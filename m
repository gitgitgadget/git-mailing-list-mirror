From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] add test for 'git rebase --keep-empty'
Date: Wed, 8 Aug 2012 12:59:31 -0400
Message-ID: <20120808165931.GA1481@hmsreliant.think-freely.org>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 18:59:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz9bk-0000kZ-9e
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 18:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758906Ab2HHQ7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 12:59:39 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42127 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531Ab2HHQ7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 12:59:38 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1Sz9bZ-0008Hl-45; Wed, 08 Aug 2012 12:59:34 -0400
Content-Disposition: inline
In-Reply-To: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203100>

On Wed, Aug 08, 2012 at 09:48:18AM -0700, Martin von Zweigbergk wrote:
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---
> 
> While trying to use patch-id instead of
> --ignore-if-in-upstream/--cherry-pick/cherry/etc, I noticed that
> patch-id ignores empty patches and I was surprised that tests still
> pass. This test case would be useful to protect --keep-empty.
> 
>  t/t3401-rebase-partial.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t3401-rebase-partial.sh b/t/t3401-rebase-partial.sh
> index 7f8693b..b89b512 100755
> --- a/t/t3401-rebase-partial.sh
> +++ b/t/t3401-rebase-partial.sh
> @@ -47,7 +47,14 @@ test_expect_success 'rebase ignores empty commit' '
>  	git commit --allow-empty -m empty &&
>  	test_commit D &&
>  	git rebase C &&
> -	test $(git log --format=%s C..) = "D"
> +	test "$(git log --format=%s C..)" = "D"
> +'
> +
> +test_expect_success 'rebase --keep-empty' '
> +	git reset --hard D &&
> +	git rebase --keep-empty C &&
> +	test "$(git log --format=%s C..)" = "D
> +empty"
>  '
>  
>  test_done
> -- 
> 1.7.11.1.104.ge7b44f1
> 
> 

Acked-by: Neil Horman <nhorman@tuxdriver.com>
