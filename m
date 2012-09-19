From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 5/7] grep.c: mark private file-scope symbols as static
Date: Wed, 19 Sep 2012 19:02:09 +0100
Message-ID: <505A08A1.1080303@ramsay1.demon.co.uk>
References: <5054AA62.2040603@ramsay1.demon.co.uk> <1347743452-2487-1-git-send-email-gitster@pobox.com> <1347743452-2487-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:10:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEPfH-0002Rg-EA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 21:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab2ISTKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 15:10:17 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:33415 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932282Ab2ISTKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 15:10:16 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 5872640026A;
	Wed, 19 Sep 2012 20:10:14 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 80A4340024D;	Wed, 19 Sep 2012 20:10:13 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tch.inty.net (Postfix) with ESMTP;	Wed, 19 Sep 2012 20:10:12 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <1347743452-2487-5-git-send-email-gitster@pobox.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205978>

Junio C Hamano wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  grep.c | 6 +++++-
>  grep.h | 3 +--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/grep.c b/grep.c
> index 925aa92..c7f8a47 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -3,6 +3,10 @@
>  #include "userdiff.h"
>  #include "xdiff-interface.h"
>  
> +static int grep_source_load(struct grep_source *gs);
> +static int grep_source_is_binary(struct grep_source *gs);
> +
> +
>  static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
>  					const char *origin, int no,
>  					enum grep_pat_token t,
> @@ -403,7 +407,7 @@ static void dump_grep_expression_1(struct grep_expr *x, int in)
>  	}
>  }
>  
> -void dump_grep_expression(struct grep_opt *opt)
> +static void dump_grep_expression(struct grep_opt *opt)
>  {
>  	struct grep_expr *x = opt->pattern_expression;
>  
> diff --git a/grep.h b/grep.h
> index 00d71f7..8a28a67 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -159,11 +159,10 @@ struct grep_source {
>  
>  void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>  		      const char *name, const void *identifier);
> -int grep_source_load(struct grep_source *gs);
>  void grep_source_clear_data(struct grep_source *gs);
>  void grep_source_clear(struct grep_source *gs);
>  void grep_source_load_driver(struct grep_source *gs);
> -int grep_source_is_binary(struct grep_source *gs);
> +
>  
>  int grep_source(struct grep_opt *opt, struct grep_source *gs);

Heh, so I obviously didn't see this before sending the patch yesterday! :-D

Yes, this solves the problem addressed by yesterday's patch, so please
ignore that. However, this tickles sparse to complain as well ... ;-)

New patch on it's way.

[I have a funny feeling that I'm about to download an email, in response
to yesterday's patch, that says something like: "does commit 07a7d656 not
fix it for you ..." :-P ]

ATB,
Ramsay Jones
