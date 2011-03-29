From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 0/9] add long forms for format placeholders
Date: Tue, 29 Mar 2011 08:46:10 +0200
Message-ID: <4D918032.3010608@drmicha.warpmail.net>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com> <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:49:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SkU-0001RE-HI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab1C2Gtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 02:49:49 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36073 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135Ab1C2Gtt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:49:49 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7B4F020446;
	Tue, 29 Mar 2011 02:49:48 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 29 Mar 2011 02:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=QjYl25ydUnWiyGeEhdLw6XEHQA0=; b=sVvKDQL6IR5BT27YAExxmdotDCfCTA9pK70UOUB40xToKOWO1odnE2ts87E8rKWsbm7twpKIBK7inGnkHDvzsk2HzNO+L4uqRjEka6tYTX51aI1W9Kd/IM2OUejM0lniH8d86gxNmnDnAftSXjvg2khFEI9CFiu0wbNz8nWXz3g=
X-Sasl-enc: wCePrQbrfjYhpEFkU2teU4XHXhXrXig56JViEd0F0KRj 1301381388
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AE72D442C45;
	Tue, 29 Mar 2011 02:49:47 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vei5qvkgw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170232>

Junio C Hamano venit, vidit, dixit 29.03.2011 02:28:
> Will Palmer <wmpalmer@gmail.com> writes:
> 
>> I've been kicking around this series for a while now as part of a larger
>> effort of refactoring the pretty formats. A recent discussion on the
>> list has lead me to believe that this smaller subset may be of use
>> sooner, rather than later.
>>
>> This series attempts to add "long forms" for common format placeholders
>> in the "git log" family of commands, making the way for yet more
>> placeholders to be added without needing to worry too much about the
>> increasingly limited set of available one-letter mnemonics. It also
>> moves towards the possibility of eventual unification with the format
>> options in for-each-ref.
> 
> I don't claim that I read 1300+ long [PATCH 5/9] carefully, but I like the
> direction in which this topic is going very much.
> 
> Except that [PATCH 2/9] looked quite out of place---more like "I wanted to
> sneak this feature in" than "this was needed to keep the resulting code
> backward compatible" or anything like that.
> 
> Off the top of my head, I don't think of a reason to say that [PATCH 3/9]
> is going in a wrong direction---is there a reason to make you worried in
> the particular change?

I'm wondering how much of this could and should be shared with
for-each-ref. Notable differences that I'm aware of:

- for-each-ref is about (named) refs which can point to any type of
object; rev-list/log is about commit objects

- for-each-ref deals with "few" objects typically, rev-list/log with many

So, other than %(refname), %(upstream) and %(tagger...), all
for-each-ref placeholders make sense for rev-list/log.

Sharing the parser would serve several purposes:

- reduced code
- increased test coverage (for-each-ref tests would test the parser)
- speed up for for-each-ref (due to your nice separation)
- short placeholders for for-each-ref
- automatic consistency between the two

Michael
