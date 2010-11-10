From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/5] t/t7004-tag: test handling of rfc1991 signatures
Date: Wed, 10 Nov 2010 09:23:59 +0100
Message-ID: <4CDA569F.5090901@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net> <cover.1289041051.git.git@drmicha.warpmail.net> <c20fb62cefcd42533e47f6f1bf5817712e5ebf9a.1289041051.git.git@drmicha.warpmail.net> <7vwrommn6j.fsf@alter.siamese.dyndns.org> <4CD9839B.6060406@drmicha.warpmail.net> <7vhbfqjaho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 09:26:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG60H-0006sd-BJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 09:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab0KJIZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 03:25:54 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51866 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab0KJIZx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 03:25:53 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 99BD8665;
	Wed, 10 Nov 2010 03:25:50 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 10 Nov 2010 03:25:50 -0500
X-Sasl-enc: rxIwnpn456ASc5HkA7i5vmnkhQJP91wQ17eOPKCggHJC 1289377550
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 05F655E9A92;
	Wed, 10 Nov 2010 03:25:49 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <7vhbfqjaho.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161138>

Junio C Hamano venit, vidit, dixit 10.11.2010 01:19:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The --rfc1991 option matters for the creation of signatures only, not
>> for the verification (and neither for display/listing with git, of course).
> 
> Doesn't the above statement assume a bit too much about how the current
> version of gpg behaves, I have to wonder?

[Note: I'm sick and may sound even more grumpy than usual...]

* This test (and the patches) is about making signed tags work for
people with rfc1991 in their options. This is why I put rfc1991 in gpg's
option file.

Note that git always produced rfc1991 sigs for those users, and always
failed to verify/list them properly, no matter what gpg option is active
during the verify/list phase.

* If you /also/ want to test that users without --rfc1991 can very those
rfc1991 sigs one would need an additional test after the "rm...". I'm
telling you that --rfc1991 is completely irrelevant for what gpg
accepts, and thus the additional test is completely superfluous. gpg is
lenient about what it accepts (within existing rfc's) and strict about
what it produces (according to what you tell it to do), just like it
should. This is by design and intentional, not version dependent or by
chance. (Even requesting strict openpgp mode does not change this.)

So, the rm needs to stay where it is.

I could repeat the three tests again after the rm, albeit in different
order so that the first one has no chance of rewriting the rfc1991 sig
into an openpgp sig. I have no objection against that, it does no good
and no harm.

Michael
