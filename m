From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branch information (git branch/status) inconsistent when in
 detached HEAD state
Date: Wed, 7 Oct 2015 11:07:12 +0200
Message-ID: <5614E0C0.7060805@drmicha.warpmail.net>
References: <247ABEF3B84FB7499C074A0FE8058694153CB176@ONWATER51M.ad.onsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Stijn De Ruyck <Stijn.DeRuyck@onsemi.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 07 11:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjkh2-0002Hk-Cj
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 11:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbbJGJHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 05:07:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60150 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538AbbJGJHO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Oct 2015 05:07:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 01888226DD
	for <git@vger.kernel.org>; Wed,  7 Oct 2015 05:07:13 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 07 Oct 2015 05:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=JAwaisskB14lC9N4p3bKZAHFyHg=; b=guIukV
	nNta45H65Zfpj043uwNkV9kufD8350WFoywbIMtFGK+RfZMuVcXjYx0pMrPULLo4
	7caNnbo9v0SSPH+VJ6pW/urIXllsHf3AfBlXtP6BFwfVxtZI/p1p+uYGRLRAAafB
	+g2QeA04T6e5M//qBcYeLXdDErGgnkHYfEXYg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=JAwaisskB14lC9N
	4p3bKZAHFyHg=; b=V77yLwczuLvloR/yGkXSWTcs+I6Otg+AQ9tnpErS61e6i+Q
	quQBoI7cP9Urm9psiafRwh/JKSe0FOKGj0HCial/eQYoqRNzWN0Q4GxzHtAl7OuA
	yBimCDoIoDjI9bROOvPWY4exavcCkFe2e/kV0gJkERoZr7YeCUJ6YVDyG/4Q=
X-Sasl-enc: mvoiUTViRgkya/JAx6yBELAnJ4eEsMLJFe6xF39RdkT1 1444208833
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 79326C0001A;
	Wed,  7 Oct 2015 05:07:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <247ABEF3B84FB7499C074A0FE8058694153CB176@ONWATER51M.ad.onsemi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279176>

Stijn De Ruyck venit, vidit, dixit 06.10.2015 15:03:
> Hello,
> 
> Consider a repository with a develop branch tracking origin/develop and where HEAD = 545a36f = develop = origin/develop.
> Tested with Git 2.4.3 and 1.8.3.4 on Linux.
> 
> 1) git checkout develop
> 2) git branch | head -1 (or git status)
> * develop
> 3) git checkout origin/develop
> Note: checking out 'origin/develop'.
> You are in 'detached HEAD' state.
> 4) git branch | head -1
> * (HEAD detached at origin/develop)
> 5) git checkout 545a36f
> 6) git branch | head -1
> * (HEAD detached at origin/develop)
> 7) git checkout develop
> 8) git branch | head -1 (or git status)
> * develop
> 9) git checkout 545a36f
> Note: checking out '545a36f'.
> You are in 'detached HEAD' state.
> 10) git branch | head -1 (or git status)
> * (HEAD detached at 545a36f)
> 11) git checkout origin/develop
> 12) git branch | head -1 (or git status)
> * (HEAD detached at 545a36f)
> 
> As you can see, checking out a revision by SHA1 after checking out a local branch tells you you are detached at that SHA1. Ok.
> But, checking out a revision by SHA1 after checking out a remote tracking branch tells you you are detached at that remote tracking branch.
> And checking out a remote tracking branch after checking out a revision by SHA1 tells you you are detached at that SHA1.
> 
> This is confusing. Is this by design?
> For a script I am writing, it would be great if the output would be consistent. Checkout origin/develop should always say "detached at origin/develop". Checkout 545a36f should always say "detached at 545a36f".
> 
> It looks like the detached head information is only updated when a detached head state is entered and not anymore when a checkout occurs "within" a detached head state.
> 
> Best regards,

Does 545a36f happen to be the tip (value) of origin/develop?

For a sha1 different from the tip, I can't reproduce the effect that you
describe. There have been some changes in related code recently, but I
don't think they should affect this scenario.

Michael
