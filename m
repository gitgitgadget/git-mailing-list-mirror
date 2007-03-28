From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] use xmalloc in diff-delta.c and removed NULL verification in builtin-pack-objects.c from create_delta_index()
Date: Wed, 28 Mar 2007 00:03:53 -0300
Message-ID: <20070328030353.GA654@c3sl.ufpr.br>
References: <20070328010430.GA8783@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 05:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWOS8-0007rh-88
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbXC1DD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 23:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752781AbXC1DD5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:03:57 -0400
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:43209 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbXC1DD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 23:03:56 -0400
Received: from cohiba (cohiba.c3sl.ufpr.br [200.17.202.52])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id EBA353019904
	for <git@vger.kernel.org>; Wed, 28 Mar 2007 00:03:53 -0300 (BRT)
Received: by cohiba (sSMTP sendmail emulation); Wed, 28 Mar 2007 00:03:53 -0300
Content-Disposition: inline
In-Reply-To: <20070328010430.GA8783@c3sl.ufpr.br>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43346>

please ignore. Sending in right way.

sorry.

On Tue, Mar 27, 2007 at 10:04:30PM -0300, Bruno Cesar Ribas wrote:
>  builtin-pack-objects.c |    2 --
>  diff-delta.c           |    8 ++------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index b5f9648..04a4abc 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1254,8 +1254,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>         }
>         if (!src->index) {
>                 src->index = create_delta_index(src->data, src_size);
> -               if (!src->index)
> -                       die("out of memory");
>         }
>  
>         delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
> diff --git a/diff-delta.c b/diff-delta.c
> index 9f998d0..011d7d6 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -157,9 +157,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
>         memsize = sizeof(*index) +
>                   sizeof(*hash) * hsize +
>                   sizeof(*entry) * entries;
> -       mem = malloc(memsize);
> -       if (!mem)
> -               return NULL;
> +       mem = xmalloc(memsize);
>         index = mem;
>         mem = index + 1;
>         hash = mem;
> @@ -258,9 +256,7 @@ create_delta(const struct delta_index *index,
>         outsize = 8192;
>         if (max_size && outsize >= max_size)
>                 outsize = max_size + MAX_OP_SIZE + 1;
> -       out = malloc(outsize);
> -       if (!out)
> -               return NULL;
> +       out = xmalloc(outsize);
>  
>         /* store reference buffer size */
>         i = index->src_size;
> -- 
> 1.5.0.3
> 
> -- 
> Bruno Ribas - ribas@c3sl.ufpr.br
> http://web.inf.ufpr.br/ribas
> C3SL: http://www.c3sl.ufpr.br 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
