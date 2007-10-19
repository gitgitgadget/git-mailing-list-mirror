From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Avoid invoking diff drivers during git-stash
Date: Fri, 19 Oct 2007 08:08:23 +0200
Message-ID: <471849D7.1020303@viscovery.net>
References: <20071019013350.GA14020@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 08:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iil2H-0004Il-Cd
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbXJSGIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbXJSGI3
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:08:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61767 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbXJSGI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:08:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iil1m-0005YY-6Y; Fri, 19 Oct 2007 08:08:12 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 72711546; Fri, 19 Oct 2007 08:08:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071019013350.GA14020@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61655>

Shawn,

thanks for the fast response with a patch.

Shawn O. Pearce schrieb:
>  Johannes Sixt <j.sixt@viscovery.net> wrote:
>  > (1) Looking at git-stash.sh I see a few uses of 'git diff' in
>  > apply_stash(). Shouldn't these use one of git-diff-{tree,index,files)? The
>  > reason is that porcelain 'git diff' invokes custom diff drivers (that in my   
>  > case run a UI program), whereas the plumbing does not.
>  >
>  > Is there a particular reason to use porcelain 'git diff'?
> 
>  Does this fix the problem?

It does!

> @@ -110,7 +110,7 @@ show_stash () {
>  
>  	w_commit=$(git rev-parse --verify "$s") &&
>  	b_commit=$(git rev-parse --verify "$s^") &&
> -	git diff $flags $b_commit $w_commit
> +	git diff-tree $flags $b_commit $w_commit

However, this porcelain 'git diff' should actually remain because it's part 
of show_stash().

-- Hannes
