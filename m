Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB05C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 20:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiFOUrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiFOUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 16:47:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819983A1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:47:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d128so9661972qkg.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y4+7xy2h4p7c3Nc0V6LmXM/uXsG/dY5OLXy6jN5qxeo=;
        b=f0Xgj/7EulYWbUPOkHsGkrkFZJeTK3OgGmm3GzhcAmhWzCTcWS8noNycdIqC+q3WCq
         +OKOgtoos2MEFgsIV2mFJU2sx4kMWN9nf9yWhQBjjYozV/VGVCasbc6mKy3ny5I0K2rM
         fJFx40Ibtjt/XPFulcgj9m1Hv4t+hbScVl7YJWCMh5sPqD07aXm+8ChYxh9d4rgZT0jw
         JiMvply2mHhDmwQt3Sxnvt49WnYqzxgfJHM0FdZchQxRHDf9UEI7gP5L92X1klU7R3tn
         PfgffbF12GFjlop08RnuI8ayWOH/3q6JQ8Kfyb4S9U7M5U35NKjX7c4NZro6K5geFCy9
         Qydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y4+7xy2h4p7c3Nc0V6LmXM/uXsG/dY5OLXy6jN5qxeo=;
        b=4g6FaPbN99FxiCvpLWKhmhBRWqxgS0xMz9uWD3UPC9Q887qEUKXovP3IAI8HaoJQHF
         qze7IHN0AE2lXxypK3fr+AaWTISkPgYecMpXmu58iHCT58aWg7oKH7knkEw790j7srZd
         FHiCCsxcqVnjiq03ChmyQJ+bmZ9Xut7nnc88pSFuGbmyc10ytsDDW+ehwrPOm2ktbP/V
         WeSLe11ge2gW5+BHfP8KwD4JE73Dmoa4LGLrJlf5Hs71aQlBrG2i3H3/hOfFK/iq/38A
         Zowkd4XKeUpDXozhM9GfdHjNqxrPDuO6u89HKviZsSNgPtid2+oIFlq7TBe29n2R3xdd
         6/Kg==
X-Gm-Message-State: AJIora/BdWNqdyc2C0sGsQuNhj7t9EnEqFcXIieGCr3dss0GsGHcgcdU
        QFyWuOLL+NwK2rszqXZaQFLnrg==
X-Google-Smtp-Source: AGRyM1scD0ARcF5hGbrrbsG4J9NeHXhbeMaWwphe6uS/P08UqoI6Af8ffuh2PzuvhCBwIoY3KJbwKQ==
X-Received: by 2002:a05:620a:44c6:b0:6a6:d033:7804 with SMTP id y6-20020a05620a44c600b006a6d0337804mr1246375qkp.153.1655326047634;
        Wed, 15 Jun 2022 13:47:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h8-20020ac87148000000b003050af740e6sm154031qtp.22.2022.06.15.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:47:27 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:47:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Message-ID: <YqpFXoKPu2E1j+mr@nand.local>
References: <xmqqfskdieqz.fsf@gitster.g>
 <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
 <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
 <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
 <Yqk9uMS5kxHD6o7l@nand.local>
 <YqlWhKDFX3KESY0h@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqlWhKDFX3KESY0h@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 11:48:20PM -0400, Jeff King wrote:
> On Tue, Jun 14, 2022 at 10:02:32PM -0400, Taylor Blau wrote:
>
> > --- >8 ---
> >
> > diff --git a/string-list.h b/string-list.h
> > index d5a744e143..425abc55f4 100644
> > --- a/string-list.h
> > +++ b/string-list.h
> > @@ -143,7 +143,7 @@ int for_each_string_list(struct string_list *list,
> >
> >  /** Iterate over each item, as a macro. */
> >  #define for_each_string_list_item(item,list)            \
> > -	for (item = (list)->items;                      \
> > +	for (item = (list) ? (list)->items : NULL;      \
> >  	     item && item < (list)->items + (list)->nr; \
> >  	     ++item)
> >
> > --- 8< ---
> >
> > > but even with your suggestion, I get this compiler error:
> >
> > ...so did I. Though I'm not sure I understand the compiler's warning
> > here. Surely the thing being passed as list in the macro expansion
> > _won't_ always evaluate to non-NULL, will it?
>
> In the general case, no, but in this specific expansion of the macro, it
> is passing the address of a local variable (&cpath), which will never be
> NULL. The compiler is overeager here; the check is indeed pointless in
> this expansion, but warning on useless macro-expanded code isn't
> helpful, since other macro users need it.

Ah, that makes sense. The compiler is warning us that the macro-expanded
version of for_each_string_list_item() has a ternary expression that
will never evaluate its right-hand side in cases where it can prove the
second argument to the macro is non-NULL.

> Hiding it in a function seems to work, even with -O2 inlining, like:
>
> diff --git a/string-list.h b/string-list.h
> index d5a744e143..b28b135e11 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -141,9 +141,14 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
>  int for_each_string_list(struct string_list *list,
>  			 string_list_each_func_t func, void *cb_data);
>
> +static inline struct string_list_item *string_list_first_item(const struct string_list *list)
> +{
> +	return list ? list->items : NULL;
> +}
> +
>  /** Iterate over each item, as a macro. */
>  #define for_each_string_list_item(item,list)            \
> -	for (item = (list)->items;                      \
> +	for (item = string_list_first_item(list);       \
>  	     item && item < (list)->items + (list)->nr; \
>  	     ++item)

That works, nice. I don't really want to mess up the tree too much this
close to a release, but this sort of clean-up seems good to do. I know
Stolee identified a handful of spots that would benefit from it. Some
good #leftoverbits, I guess :-).

Thanks,
Taylor
