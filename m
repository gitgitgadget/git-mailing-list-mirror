From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] sample pre-commit hook: don't trigger when recording a merge
Date: Mon, 18 Jan 2010 06:16:36 +0900
Message-ID: <20100118061636.6117@nanako3.lavabit.com>
References: <20100109081652.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 22:17:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWcVE-0002z4-IV
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 22:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763Ab0AQVR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 16:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325Ab0AQVR1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 16:17:27 -0500
Received: from karen.lavabit.com ([72.249.41.33]:38308 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab0AQVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 16:17:26 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 4923111B930;
	Sun, 17 Jan 2010 15:17:25 -0600 (CST)
Received: from 7089.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id F4R9E902XJY5; Sun, 17 Jan 2010 15:17:25 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=T8d3Gjw70GC2WxVBmXl+L8MW7lL9GAPZsr00GeY673Uygl4LuCX47Kydj8k1ws3ChmQO9PCyB8AfaVZYoo6+ak1yfRMg56Fo4e7FlycyXp1fibKydELbIup4GbkGtWAkQipWwO6h/FSLgUFMeR3rqhyR874VgJBJI3WyhNj1tjg=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <20100109081652.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137344>

Hi,

I sent this patch but didn't receive any feedback. Is it a bad idea?
It may be better if 'git-commit' didn't call this hook when recording a merge,
but I don't write C very much.

Thanks.

> When recording a merge, even if there are problematic whitespace errors,
> let them pass, because the damage has already been done in the history. If
> this hook triggers, it will invite a novice to fix such errors in a merge
> commit but such a change is not related to the merge. Don't encourage it.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  templates/hooks--pre-commit.sample |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
> index 439eefd..66e56bb 100755
> --- a/templates/hooks--pre-commit.sample
> +++ b/templates/hooks--pre-commit.sample
> @@ -7,6 +7,11 @@
>  #
>  # To enable this hook, rename this file to "pre-commit".
>  
> +if test -f "${GIT_DIR-.git}"/MERGE_HEAD
> +then
> +	exit 0
> +fi
> +
>  if git-rev-parse --verify HEAD >/dev/null 2>&1
>  then
>  	against=HEAD
> -- 
> 1.6.6
>
> -- 
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
