Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 486221F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 22:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdFIW1o (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 18:27:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33810 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFIW1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 18:27:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id u1so9850207pfg.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=20pzyFj3TnJYjL9O8j8VWl0oz6t7w72Vb6z/cvdocO0=;
        b=N4FC6eTv1UK5ha5LzCV32PC7HC3B+6JS64i8ff91OcXXPWp5I1+xLI4UhwDzRGbb3N
         PSQUo3o+UBs+QZ2FF50HkArKGKrbKISBdfraBgr/UwS26raQbgKXELfNbNXSVl6zPZ+4
         TEj0/Q5qjNJtNbJ9hKE48Amq1K4hsgXHxXO6gDJfSfKtI9k/2uVV4NCyjNVNkuwfsgpT
         Buc3cEXdLMbzMRY7SHyB12JkLkxWcJQPHGdlRbX5Q/Q+b5gm4pwm3vYtr0ibbVW/2pke
         08veXsn72Z8+vH/FytfqhZCDkEXXrr6TL6yZIW+sypQAcZhKCBXPXkeS649Cnp0QqKjx
         4MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=20pzyFj3TnJYjL9O8j8VWl0oz6t7w72Vb6z/cvdocO0=;
        b=ISE6x9+xEi/qyDQJbfXiwRDeRivbgqyPRl2IcP6UGq8jst2dZVbPnEPSX9wM2EnvZo
         N+N7dYBiwZhqRvnhooYBSXOGmArbTVKmRmXq98fc2mdpXyqmVDOABFQSsGcURjP6/fQT
         CzkcuJRuNFY5kRHpzzdto4knlAQIQgg3kCStYK+fXDjhGRVNwcRCkwGmV8t/dG8gifdL
         iR7nIsn1n8WZFnWHuJBhx6DNowRiAvy5lGKKM83jLgMahzv87kcsRjg0GaBlS4pb8OW2
         i05SnalFJMBp4Auj8oFCPEWMaYnckk8JRV3GgWM1ynCstBjrvzrR9J7SA1TjgJWf6KoD
         TcEw==
X-Gm-Message-State: AODbwcBNCWmhtTSTwbbOkVQirFvZ+WdvK67/slLe4/q/iI8ase/p6IAO
        aj/Tck7hwtJ9GQ==
X-Received: by 10.84.217.201 with SMTP id d9mr40363398plj.145.1497047262230;
        Fri, 09 Jun 2017 15:27:42 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5c07:8439:f74a:24a6])
        by smtp.gmail.com with ESMTPSA id o6sm4315738pfb.110.2017.06.09.15.27.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 15:27:40 -0700 (PDT)
Date:   Fri, 9 Jun 2017 15:27:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around
 free(ptr); ptr = NULL
Message-ID: <20170609222738.GF21733@aiede.mtv.corp.google.com>
References: <20170609085346.19974-1-avarab@gmail.com>
 <20170609220420.4910-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170609220420.4910-2-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Add a FREEZ() wrapper marco for the common pattern of freeing a
> pointer and assigning NULL to it right afterwards.

I'm conflicted.  On one hand it makes code more concise and makes it
easier for people to remember to assign NULL after freeing a variable.
On the other hand it makes git more of a custom dialect of C, which
may make the code harder to read and hack on for new contributors.

My feeling is that the costs outweigh the benefits, but I haven't
thought it through thoroughly.

> The implementation is similar to the (currently unused) XDL_PTRFREE
> macro in xdiff/xmacros.h added in commit 3443546f6e ("Use a *real*
> built-in diff generator", 2006-03-24). The only difference is that
> free() is called unconditionally, see [1].
>
> 1. <alpine.DEB.2.20.1608301948310.129229@virtualbox>
>    (http://public-inbox.org/git/alpine.DEB.2.20.1608301948310.129229@virtualbox/)

Nit: it's redundant to state the message-id twice.

Can this commit message include a summary of that conversation so
someone trying to understand this patch with "git log" does not have
to open a browser and re-read the thread?  Is that thread being cited
for the point that git uses 'free(NULL)' without worrying?  I think
that's okay to say without citation --- there are lots of examples
throughout the git codebase.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  git-compat-util.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 4b7dcf21ad..ba2d0c8c80 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -805,6 +805,12 @@ extern int xmkstemp_mode(char *template, int mode);
>  extern char *xgetcwd(void);
>  extern FILE *fopen_for_writing(const char *path);
> 
> +/*
> + * FREEZ(ptr) is like free(ptr) followed by ptr = NULL. Note that ptr
> + * is used twice, so don't pass e.g. ptr++.
> + */
> +#define FREEZ(p) do { free(p); (p) = NULL; } while (0)
> +
>  #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
>  #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))

Golfing: it's possible to do this without ptr being used twice by
introducing a helper function:

	static inline void freez_impl(void **p) {
		free(*p);
		*p = NULL;
	}
	#define FREEZ(p) freez_impl(&(p))

That way side-effectful callers like FREEZ(func() ? a : b) would
work.

Another request: if rolling out another version of this series, could
it go in a new thread?  The cover letter can link to the old version
for context.  Each time I see a new reply to the repository object
series my heart leaps for a moment, in the hope that we're getting
closer to have a repository object in git.

I kind of wish that 'free' returned NULL so that callers could do

	p = free(p);

without requiring a custom helper.  We could introduce a free_wrapper
that works that way but that is probably not worth it, either.

Thanks for an interesting and pleasant read.

Sincerely,
Jonathan
