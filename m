From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-bisect: call the found commit "*the* first bad commit"
Date: Fri, 28 Aug 2009 07:31:12 +0200
Message-ID: <200908280731.12827.chriscool@tuxfamily.org>
References: <20090826173850.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:30:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgu2X-0003R4-0q
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbZH1FaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 01:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZH1FaJ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 01:30:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33976 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188AbZH1FaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 01:30:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 377138180CE;
	Fri, 28 Aug 2009 07:30:02 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 086598180D0;
	Fri, 28 Aug 2009 07:29:59 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20090826173850.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127269>

On Wednesday 26 August 2009, Nanako Shiraishi wrote:
> .. as we learned in the school ;-)
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  bisect.c                    |    2 +-
>  git-bisect.sh               |    2 +-
>  t/t6030-bisect-porcelain.sh |   18 +++++++++---------
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 7f20acb..dc18db8 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -991,7 +991,7 @@ int bisect_next_all(const char *prefix)
>
>  	if (!hashcmp(bisect_rev, current_bad_sha1)) {
>  		exit_if_skipped_commits(tried, current_bad_sha1);
> -		printf("%s is first bad commit\n", bisect_rev_hex);
> +		printf("%s is the first bad commit\n", bisect_rev_hex);
>  		show_diff_tree(prefix, revs.commits->item);
>  		/* This means the bisection process succeeded. */
>  		exit(10);

Thanks, but I wonder if this could give the false impression that there can 
only be one "first bad commit". Because it's possible that a bug appears in 
one commit say A, then get fixed in another one say B, and eventually 
reappears in a third one say C. So if the bisection range contains all 
these commits, the result from bisecting could be A or C.

Best regards,
Christian.
