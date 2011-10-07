From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How pretty is pretty? git cat-file -p inconsistency
Date: Fri, 07 Oct 2011 22:26:48 +0200
Message-ID: <4E8F6088.8060300@drmicha.warpmail.net>
References: <4E8EBC00.90909@drmicha.warpmail.net> <7v62k0wudg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 22:26:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCH0R-0004jh-WA
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 22:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758519Ab1JGU0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 16:26:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43228 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966Ab1JGU0v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 16:26:51 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B577F205DF;
	Fri,  7 Oct 2011 16:26:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 07 Oct 2011 16:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=48WRfaeeThiAC/D7q1acY7
	5O7P4=; b=mIAw0m4KqCDo1miXsHuZ06Vs24T8WpbxT8HYvh59k2z4d4PKvkmxaT
	HDBrafpPg5mis/QjJpFsBpgt3UUnkQwRtNgVIAGgz2+xwkZcKpQmxB5jUPwKKbyE
	78ZuLhUD4suZDAVoO3a/1GQQQrO673baCGSaS1g1xuIYg1oDKmpYY=
X-Sasl-enc: RIG9OH6siBeSMnIhamSJcEXFS8mzwlbyWdROwC3UxQCt 1318019210
Received: from localhost.localdomain (p548598D0.dip0.t-ipconnect.de [84.133.152.208])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 27E91CA07DB;
	Fri,  7 Oct 2011 16:26:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7v62k0wudg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183106>

Junio C Hamano venit, vidit, dixit 07.10.2011 20:04:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> That is, "cat file -p" pretty prints dates for tag objects but not for
>> commit objects. In fact, "-p" on commit objects does not prettify at all
>> compared to the raw content. Is that intentional?
> 
> "cat-file -p" is an ill-conceived half-ass afterthought, and I do not
> think anybody sane considers it as part of the "plumbing" ultra stable
> interface for machine consumption. See a0f15fa (Pretty-print tagger
> dates., 2006-03-01).

Uh, I see. "git cat-file -p tagname" is a bit like the the missing "git
tag show tagname" or "git show tagname" without the commit.

> 
>> I'd suggest
>> prettifying dates with "-p" for commit objects also.
> 
> Please make it so. It is your choice to do a patch to update this single
> thing first, or to discuss the output with "-p" for all the other object
> types at the same time to get the list concensus before proceeding.

I never knew how ugly the output of "git tag-file tree sha1" is. I guess
it's the type of object whose format I don't know... We don't have an
object format description in Doc/technical, do we? tree.c doesn't tell
me much.

Looking at how "cat-file -p" for tags is done makes me not want to do it
for commits ;) We do have pretty "git show" for all types of objects,
though "git cat-file -p treeobject" is more informative than "git show
treeobject". I guess I have to make up my mind about what direction to go.

Michael
