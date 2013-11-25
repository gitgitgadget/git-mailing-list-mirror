From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 12:23:58 -0800
Message-ID: <xmqqmwksxmap.fsf@gitster.dls.corp.google.com>
References: <878uwc2r7c.fsf@thomasrast.ch>
	<89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:24:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2hV-0002uq-0V
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860Ab3KYUYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:24:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab3KYUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:24:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BE2953185;
	Mon, 25 Nov 2013 15:24:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t6p/L4wjzz0D8K9A5yURSOLKNG0=; b=b4tf7M
	tPzOLRCaZOacFgNILW9L5iR5Rl/KlXy1p/5yVd3gs0jRI94hhHTvAe28lCXirDzO
	965gbLB7uiPeMFMqgIVIeIyhmCQ0tSSzvkUduV63lqjCk87Leyg6SHXPjW6XN5dH
	LWjcNUpJaMQbkI29KvRKU5CjoYl88JsSdw06c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ioDW2iWOIRyzDpawCesrSWTO2/9SzqkQ
	Ve3XgF1PJIXNWHzzIT9itvqgDi009uEUhfmSZqQte6yB6N1c8wB5u19LC8Y6JJ+L
	9RFkC1kgzCArqor4IQktSrn97DoI+XLgWfSOxYo98ZcuYExnqKFL9limYcaAmurd
	eMPkUteZoo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63D1A53184;
	Mon, 25 Nov 2013 15:24:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E250F5317E;
	Mon, 25 Nov 2013 15:23:59 -0500 (EST)
In-Reply-To: <89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Mon, 25 Nov 2013 21:04:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 848A69D8-560F-11E3-B891-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238341>

Thomas Rast <tr@thomasrast.ch> writes:

> Here's a version that has a fat comment instead of the removal.
>
> Also, since I was rerolling anyway I put a reason why we need this.
> In the original motivation I actually created more functions
> afterwards, which made it more convincing, but the problem already
> exists.

Thanks.

I considered the bottom one the real declaration (with the top one a
forward declaration we need to make the result compile), by the way,
so there may be no redundancy anywhere ;-)



>  commit-slab.h | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/commit-slab.h b/commit-slab.h
> index d77aaea..21d54f1 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -45,8 +45,8 @@ struct slabname {							\
>  };									\
>  static int stat_ ##slabname## realloc;					\
>  									\
> -static void init_ ##slabname## _with_stride(struct slabname *s,		\
> -					    unsigned stride)		\
> +static inline void init_ ##slabname## _with_stride(struct slabname *s,	\
> +						   unsigned stride)	\
>  {									\
>  	unsigned int elem_size;						\
>  	if (!stride)							\
> @@ -58,12 +58,12 @@ struct slabname {							\
>  	s->slab = NULL;							\
>  }									\
>  									\
> -static void init_ ##slabname(struct slabname *s)			\
> +static inline void init_ ##slabname(struct slabname *s)			\
>  {									\
>  	init_ ##slabname## _with_stride(s, 1);				\
>  }									\
>  									\
> -static void clear_ ##slabname(struct slabname *s)			\
> +static inline void clear_ ##slabname(struct slabname *s)		\
>  {									\
>  	int i;								\
>  	for (i = 0; i < s->slab_count; i++)				\
> @@ -73,8 +73,8 @@ struct slabname {							\
>  	s->slab = NULL;							\
>  }									\
>  									\
> -static elemtype *slabname## _at(struct slabname *s,			\
> -				const struct commit *c)			\
> +static inline elemtype *slabname## _at(struct slabname *s,		\
> +				       const struct commit *c)		\
>  {									\
>  	int nth_slab, nth_slot;						\
>  									\
> @@ -98,4 +98,16 @@ struct slabname {							\
>  									\
>  static int stat_ ##slabname## realloc
>  
> +/*
> + * Note that this seemingly redundant second declaration is required
> + * to allow a terminating semicolon, which makes instantiations look
> + * like function declarations.  I.e., the expansion of
> + *
> + *    define_commit_slab(indegree, int);
> + *
> + * ends in 'static int stat_indegreerealloc;'.  This would otherwise
> + * be a syntax error according (at least) to ISO C.  It's hard to
> + * catch because GCC silently parses it by default.
> + */
> +
>  #endif /* COMMIT_SLAB_H */
