From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] log: Do not decorate replacements with --no-replace-objects
Date: Thu, 25 Aug 2011 17:08:54 +0200
Message-ID: <4E566586.5010901@drmicha.warpmail.net>
References: <ad41e81daa6f9fc4654ae4c312f293202519a5d0.1314279822.git.git@drmicha.warpmail.net> <CACsJy8BOhU7-aTN2TPRRoQ=_mSfbOstXFRfpyoPmrr_Gbqg0pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 17:09:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwbYD-0004Qg-RA
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 17:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1HYPI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 11:08:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56435 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab1HYPI4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 11:08:56 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B82FF206C4;
	Thu, 25 Aug 2011 11:08:55 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Aug 2011 11:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=PxJFkI9kZOLh6ybb+SdMqJ
	WhgOI=; b=iLiqzYehHuSPaltCuzKMe+y83eZM+rCD3NtlYY/KN3xiCpcaTCJwcZ
	xc97PrTp1EUy78rdsnDMVVh/r3RbPVsWrLVpOqSFV6G8dtilM6pPw5ggIV07tunI
	cJfaKG/3afd49FDIwZKEl9t3eDvZsAOsD/hUIMCDCLHjnYZK+gXQo=
X-Sasl-enc: VGDsnlUBD8nPb3qNifrUX+1I3XN3zIR/haW9jxnUl2g5 1314284935
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2488C41D6DA;
	Thu, 25 Aug 2011 11:08:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CACsJy8BOhU7-aTN2TPRRoQ=_mSfbOstXFRfpyoPmrr_Gbqg0pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180081>

Nguyen Thai Ngoc Duy venit, vidit, dixit 25.08.2011 15:55:
> 2011/8/25 Michael J Gruber <git@drmicha.warpmail.net>:
>> Make it so that additionally the use of --no-replace-objects is
>> detected: I.e. replaced commits are only decorated as replaced when they
>> are actually replaced.
> 
> Yeah.. I forgot about this.
> 
>> @@ -95,7 +95,7 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
>>        struct object *obj;
>>        enum decoration_type type = DECORATION_NONE;
>>
>> -       if (!prefixcmp(refname, "refs/replace/")) {
>> +       if (read_replace_refs && !prefixcmp(refname, "refs/replace/")) {
>>                unsigned char original_sha1[20];
>>                if (get_sha1_hex(refname + 13, original_sha1)) {
>>                        warning("invalid replace ref %s", refname);
> 
> You should put "if (!read_replace_refs) return 0;" inside "if
> (!prefixcmp..", otherwise it'll come to the ref decoration code below
> and my second paragraph in 5267d29's commit message will be reverted.

Right, thanks for checking.

> I thought my patch was
>  - simple
>  - replace is rarely used
> therefore neglected the tests. Perhaps you can also add a few tests
> here. It's not that simple after all.

It would take a bit to do so, but this is a fix to a recently introduced
feature, so it should go along quickly. v2 upcoming.

Michael
