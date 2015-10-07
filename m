From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branch information (git branch/status) inconsistent when in
 detached HEAD state
Date: Wed, 7 Oct 2015 16:41:43 +0200
Message-ID: <56152F27.5070907@drmicha.warpmail.net>
References: <247ABEF3B84FB7499C074A0FE8058694153CB176@ONWATER51M.ad.onsemi.com>
 <5614E0C0.7060805@drmicha.warpmail.net>
 <247ABEF3B84FB7499C074A0FE8058694153CB1BE@ONWATER51M.ad.onsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Stijn De Ruyck <Stijn.DeRuyck@onsemi.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 16:41:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjpug-0008Ub-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 16:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbbJGOlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 10:41:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46874 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281AbbJGOlp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 10:41:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F2E82188F
	for <git@vger.kernel.org>; Wed,  7 Oct 2015 10:41:45 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 07 Oct 2015 10:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=A94pCmwU3/dy6+lcW7kwOJ+ehaM=; b=QUBN+v
	AVVcZt5TaKLz3tRRdlwil5T+2EoFUAut+8DiE7xcfAkVOkjbnuTcKk21rLR4v6Mp
	tBHlIU/KJ7dbDMoZ45GBgIJqX+gv9JRtadh3fTL7Lv1jbT0zPp/RE/Uknk6tPUYe
	EYIFX2pP2kphxJravql8BBqYftDL9BpErhAoc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=A94pCmwU3/dy6+l
	cW7kwOJ+ehaM=; b=csNY81xtt2St+ovcW39fCE7aCqsbvyWIsUDYJCjbjNHTdnZ
	9rWCkJmMxFnFtWz3tEE7b4j9xXQRZdf0M7oVMiS2igNtalVTWlWsjUIeRC6D3vYo
	Bz/AAJkoG4wK9+8Ccjs0ui+2NIHT3/TZ7xuAdu52nUzKGsUqXv3QAGpiU+1I=
X-Sasl-enc: OT+dLCbQxjxhwWYGFyYdjYc+VznVhI17e/1kcYeMKzk6 1444228904
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9CB00680234;
	Wed,  7 Oct 2015 10:41:44 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <247ABEF3B84FB7499C074A0FE8058694153CB1BE@ONWATER51M.ad.onsemi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279178>

[Please make sure to bottom-post or reply-inline on the git-ml.]
Stijn De Ruyck venit, vidit, dixit 07.10.2015 11:57:
> Yes it is the tip. 
> So all I'm doing is checking out the exact same commit (the tip of a branch), but in different ways and in different sequences. The result on disk is the same, but the issue is git branch/status doesn't always reflect what I just did...
> 
> If I do git checkout origin/develop, git branch might still say "detached at 545a36f", which, while true, feels wrong. How can I know afterwards what branch I actually tried to check out? "Detached at origin/develop" would make that clear.
> (I use this information in a build script to embed version information (including the branch being built) into the binary.)

Well, you think you do, but you don't. That is: You're not 'moving'; the
value of HEAD stays the same, and if you check the reflog, you see that
the second "checkout" (which in fact is a no-op) is not recorded in the
reflog at all - because the HEAD ref doesn't change at all, and the HEAD
reflog is all about changes to the HEAD ref.

In that sense everything is perfectly correct, in the same way as a fast
forward merge is not "recorded" as a merge.

The way you think about the checkout may change, of course. I'm not sure
whether "no-op" entries in the reflog would do any harm or whether we
should create them. (And I'm not sure whether the HEAD reflog is the
right tool for your purpose.)

Michael

> 
> -----Original Message-----
> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
> Sent: Wednesday, October 07, 2015 11:07 AM
> To: Stijn De Ruyck; git@vger.kernel.org
> Subject: Re: Branch information (git branch/status) inconsistent when in detached HEAD state
> 
> Stijn De Ruyck venit, vidit, dixit 06.10.2015 15:03:
>> Hello,
>>
>> Consider a repository with a develop branch tracking origin/develop and where HEAD = 545a36f = develop = origin/develop.
>> Tested with Git 2.4.3 and 1.8.3.4 on Linux.
>>
>> 1) git checkout develop
>> 2) git branch | head -1 (or git status)
>> * develop
>> 3) git checkout origin/develop
>> Note: checking out 'origin/develop'.
>> You are in 'detached HEAD' state.
>> 4) git branch | head -1
>> * (HEAD detached at origin/develop)
>> 5) git checkout 545a36f
>> 6) git branch | head -1
>> * (HEAD detached at origin/develop)
>> 7) git checkout develop
>> 8) git branch | head -1 (or git status)
>> * develop
>> 9) git checkout 545a36f
>> Note: checking out '545a36f'.
>> You are in 'detached HEAD' state.
>> 10) git branch | head -1 (or git status)
>> * (HEAD detached at 545a36f)
>> 11) git checkout origin/develop
>> 12) git branch | head -1 (or git status)
>> * (HEAD detached at 545a36f)
>>
>> As you can see, checking out a revision by SHA1 after checking out a local branch tells you you are detached at that SHA1. Ok.
>> But, checking out a revision by SHA1 after checking out a remote tracking branch tells you you are detached at that remote tracking branch.
>> And checking out a remote tracking branch after checking out a revision by SHA1 tells you you are detached at that SHA1.
>>
>> This is confusing. Is this by design?
>> For a script I am writing, it would be great if the output would be consistent. Checkout origin/develop should always say "detached at origin/develop". Checkout 545a36f should always say "detached at 545a36f".
>>
>> It looks like the detached head information is only updated when a detached head state is entered and not anymore when a checkout occurs "within" a detached head state.
>>
>> Best regards,
> 
> Does 545a36f happen to be the tip (value) of origin/develop?
> 
> For a sha1 different from the tip, I can't reproduce the effect that you describe. There have been some changes in related code recently, but I don't think they should affect this scenario.
> 
> Michael
> 
> 
