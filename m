Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA5F1F42D
	for <e@80x24.org>; Thu, 10 May 2018 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934798AbeEJKQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 06:16:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37467 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbeEJKQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 06:16:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id l1-v6so3401970wmb.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y+4fYGQxvTkKlfiwQ6cPT7uyLm5rnYndPbZXH9cwtvQ=;
        b=jVNbTjTS46EQUEKD8StmPezuGY7nhFLiOGM2TTG9ktBnQPA6zj1T9TY6fI5NyAg37e
         Yogmz2naE9eIMRX5pTe5GciE6x3GD+tijQHED/PB/kWLQjt/oerhQ4Q5spxy8bniRyJ3
         0WOh81rZp2nB0gOuaqgglOTrTTJQ0fX44XcH3vfsqbIWKyFoJhvOqoVP4EhdYwkLAj8B
         xgu/bEMdChjeyeVuN7LstvkINkTJ9TDwfraTnvAv0mGKAKim3Qo/nqB+pE69ZMqPA9+v
         w8Q60+YdAr+SQ5wVberNWeg16n23wNni3+tpdszv27HOLQqYI2oA7lj0XL6OiGLpPXa7
         pUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y+4fYGQxvTkKlfiwQ6cPT7uyLm5rnYndPbZXH9cwtvQ=;
        b=bIvvTUAiwYktigGJVCQUqcJRUBwxPElLDae1Y4U13oCC5nipKhYQIquLU5lJ90hWYS
         9CnaZOE+a2CobisBF9CB9BBhAjd1aHzq3A23lgo29aEu6RUtLDw8FE0t+VDWR2c++hrY
         jfSOGp31kThNdMnYqXIaaD50BLi4dpWlTaoR6cKOlezbhqvSEepWwOy31t9OgsWfIpX7
         1sTI0j93l8jqr0wvmTePS1+TASCZgcRtRRNlZuOkTe4rYM76AL30UGEzpdiVcilJhsnB
         5val2h9/TPVekBv1RbuDasZRo/flH5GaezFYg/wB7Qk2bstn8YYAE7xSewl2iFdcQPsQ
         4R2Q==
X-Gm-Message-State: ALKqPwekpSo0Kj2lIcoBhuI+J+jhs5HC7iCSS7QbDdYPRGw19B2eyq3t
        B79OfiWo6+t6p59jQ5xgsf0=
X-Google-Smtp-Source: AB8JxZrxOa2vUAUqn4dKOEOAroTJTYEalNGOX8PPTbGATC4iwMYO8+kX+3EoRlm2Y1TI72L388Q6vg==
X-Received: by 2002:a1c:3b87:: with SMTP id i129-v6mr884942wma.51.1525947369678;
        Thu, 10 May 2018 03:16:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a10-v6sm959381wri.10.2018.05.10.03.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 03:16:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] object.c: free replace map in raw_object_store_clear
References: <20180509234059.52156-1-sbeller@google.com>
Date:   Thu, 10 May 2018 19:16:08 +0900
In-Reply-To: <20180509234059.52156-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 9 May 2018 16:40:58 -0700")
Message-ID: <xmqqy3grizo7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The replace map for objects was missed to free in the object store in
> the conversion of 174774cd519 (Merge branch 'sb/object-store-replace',
> 2018-05-08)

I need a bit of clarification wrt the above.  The above makes it
sound like the merge needed a semantic conflict resolution (e.g. one
side turned replace_map into a pointer while the other side added a
place where the containing structure is freed and now the merge
result needs to free the pointer in the new place that frees the
containing structure, but the merge forgot to do so).  Is that what
is going on?

Or is this just a simple "the topic that ends at 174774cd519^2 had
this leak that needs to be fixed by this patch; instead of rerolling
this is an incremental, because the topic has already been merged to
'master' and it is too late now"?

Looking at this patch in the context of the side branch (instead of
in the merged result) already makes sense to me, so I am guessing it
is the latter (i.e. not a botched merge that missed semantic
conflicts), in which case the proposed log message is a bit too
alarming and points readers in a wrong direction.  Shouldn't it
point at, say, c1274495 ("replace-object: eliminate replace objects
prepared flag", 2018-04-11) that turned the oidmap instance into a
pointer in raw_object_store?

Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  object.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/object.c b/object.c
> index 9d5b10d5a20..ff28f90c5ef 100644
> --- a/object.c
> +++ b/object.c
> @@ -497,6 +497,7 @@ void raw_object_store_clear(struct raw_object_store *o)
>  {
>  	FREE_AND_NULL(o->objectdir);
>  	FREE_AND_NULL(o->alternate_db);
> +	FREE_AND_NULL(o->replace_map);
>  
>  	free_alt_odbs(o);
>  	o->alt_odb_tail = NULL;
