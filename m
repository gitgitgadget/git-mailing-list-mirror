From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: t7810.94 (git-grep -E -F -G) never passed
Date: Wed, 25 May 2011 12:21:57 +0200
Message-ID: <4DDCD845.1030800@drmicha.warpmail.net>
References: <BE19630B-8E48-4CA8-B956-A4DC767BFFDD@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed May 25 12:22:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPBE5-0007jP-7I
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 12:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536Ab1EYKV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 06:21:59 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58236 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512Ab1EYKV7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 06:21:59 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C141A2095C;
	Wed, 25 May 2011 06:21:58 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 25 May 2011 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=I2McqVRPB+j5xsJMNKpfwBusjZs=; b=NXdkOj9mNA30J+CNXkSE7qzFKw/0rhkNgnTUlSDgnOGjpdjqPHdserWyd+T5eT4slp6rhBbwItY4mtLsAE7+QWjyvipE2Yt8OpzyUPXqo36qDh1BIAtVt6o4RJ01WYh1C39ESyqSs7PrLm3HFPHYYJe2lYsP+F406uk+hjMu8hc=
X-Sasl-enc: XreqYKutzMRYCmXJKFoKT2TFO71nLAuy70LjeRVuvWqz 1306318918
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 506EC445463;
	Wed, 25 May 2011 06:21:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BE19630B-8E48-4CA8-B956-A4DC767BFFDD@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174379>

Brian Gernhardt venit, vidit, dixit 25.05.2011 05:27:
> I'm not sure why it's supposed to pass, actually.  -G makes the pattern be a basic regex and basic regexen don't recognize the + repetition operator.
> 
> expecting success: 
> 	echo ab:aab >expected &&
> 	git grep -E -F -G a\\+b >actual &&
> 	test_cmp expected actual
> 
> --- expected	2011-05-25 03:19:05.000000000 +0000
> +++ actual	2011-05-25 03:19:05.000000000 +0000
> @@ -1 +1 @@
> -ab:aab
> +ab:a+b
> not ok - 94 grep -E -F -G pattern

"Never" is a strong statement when this test always passed for everyone
else running tests, assuming they would have reported otherwise. What's
your system?

reg-ex.info says:

"The other BRE metacharacters require a backslash to give them their
special meaning."

"Some implementations support \? and \+... but \? and \+ are not part of
the POSIX standard."

So I guess we're going with "some".

Michael
