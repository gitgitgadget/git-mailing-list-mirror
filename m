From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Sat, 26 Apr 2014 08:43:07 -0400
Message-ID: <20140426124307.GB4767@padd.com>
References: <20140425044618.GA7058@olive>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cdleonard@gmail.com
To: Tolga Ceylan <tolga.ceylan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 14:43:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We1wr-0008TW-V6
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 14:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaDZMnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 08:43:14 -0400
Received: from honk.padd.com ([74.3.171.149]:34504 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbaDZMnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 08:43:13 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id B3EFA5B16;
	Sat, 26 Apr 2014 05:43:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 57D7E201D1; Sat, 26 Apr 2014 08:43:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20140425044618.GA7058@olive>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247157>

tolga.ceylan@gmail.com wrote on Thu, 24 Apr 2014 21:46 -0700:
> When applying binary patches a full index is required. format-patch
> already handles this, but diff-tree needs '--full-index' argument
> to always output full index.
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
> ---
>  git-p4.py |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index cdfa2df..4ee6739 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1311,7 +1311,7 @@ class P4Submit(Command, P4UserMap):
>              else:
>                  die("unknown modifier %s for %s" % (modifier, path))
>  
> -        diffcmd = "git diff-tree -p \"%s\"" % (id)
> +        diffcmd = "git diff-tree --full-index -p \"%s\"" % (id)
>          patchcmd = diffcmd + " | git apply "
>          tryPatchCmd = patchcmd + "--check -"
>          applyPatchCmd = patchcmd + "--check --apply -"
> -- 

This looks like a straightforward change, but can you give a
bit more background on why a full index is required?  Do you
mean that "git apply" will reject a patch with abbreviated
blob object names?

		-- Pete
