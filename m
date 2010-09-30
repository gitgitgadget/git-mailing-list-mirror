From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3] Makefile: implement help target
Date: Thu, 30 Sep 2010 09:08:21 +0200
Message-ID: <4CA43765.5010804@drmicha.warpmail.net>
References: <7vhbh8r1zj.fsf@alter.siamese.dyndns.org> <d2da07fe51a3aba727165b0a0de299c266097145.1285791283.git.git@drmicha.warpmail.net> <7vbp7gmggy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 09:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1DFa-0001er-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 09:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab0I3HIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 03:08:12 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37567 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446Ab0I3HIM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 03:08:12 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CD7ADB09;
	Thu, 30 Sep 2010 03:08:11 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 30 Sep 2010 03:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=AW8m9AsmXX+jyzhgIhLYaNvbBJM=; b=shvBCuYtoAOYIWE2W8dJ9MW6/7s9B7cJ9x/G8J3WJl/z+/tkdpS0mekz022aODxGjekpclIBzwgO18Uc2jQkEtXVammzplxkY6OlTsN2dOXAMmkyGepm/sUPJsI9mMDyqTALAWnGIWg83kP2bgS5eQAFYs7pup2k+xX9bjHfwoQ=
X-Sasl-enc: WyraYw+4Kww4JUVdXWeJK5vZHGdiE5YXy7QCEQCJM9L6 1285830491
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C5B05406FCD;
	Thu, 30 Sep 2010 03:08:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vbp7gmggy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157632>

Junio C Hamano venit, vidit, dixit 09/29/2010 10:39 PM:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/Makefile b/Makefile
>> index db2efd6..371214d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,4 +1,10 @@
>>  # The default target of this Makefile is...
>> +help-Build::
> 
> Heh, no way.  The default target of this Makefile should remain "all".

Damnit, that wasn't intended.... But that's solved by a simple
reordering, of course.

> Even though letting phony double-colon rules to implicitly collect members
> of groups and showing them is a neat idea, I do not think "make -j help"
> would do what you are expecting ;-)

I expect a randomly ordered mess, and "make -j help" fully meets those
expectations! Can "-j" be set in the environment or config.mak somehow?
Otherwise I think that explicitly shooting yourself in the foot should
be allowed...

Anyway, this topic is (only) about help on our Makefile, and I think
that as long as we don't want to go several extra miles, we have to
decide between two app roaches :)

* comment based:
  + readable
  + -j safe
  - no var expansion (that I know of, at least without recursive make)
  +- single line comments (unless more perl/awk foo is invested)
  +- either in Makefile order or lexically sorted (or more perl lines)

* phony :: rules based:
  +- somewhat less readable
  - not -j safe
  + var expansion
  + multi line comments (could easily add a 3rd level also)
  + categories can be ordered freely (targets in Makefile order within)

Michael
