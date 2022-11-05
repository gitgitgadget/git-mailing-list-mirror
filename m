Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85957C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 11:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKELeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKELeV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 07:34:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05E24BFE
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 04:34:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v17so7135837plo.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x64olFW55YKA//DN8fUTXcI1Qtc8u5/YPD0JvsU0Zus=;
        b=GmHLRknCupi1BAkUSwCol8NvIrs3Q920HTxbtjAce7B8TxvAfWb1bwi48iyWoAi+38
         BCkTOwAmvC+9Bvle/mirtKDrFoifF5/jroDKmVllBR0dqcgmGZSeLCvwZahZ3yEHSRAS
         YQCoBbKzZlq/oXB5j6SRrh8Db+VD5MBTJuoJk6ARB6XqUc5bl+WrH3UgTjD7cdTgIH1y
         n1YO1NOn8TkCx/MWL4XymIgmGMfi46AGMnrfj9A10C5g1Ma92VtWDwPKti/p6szeBFZn
         COeOqmH6Org+UY8g+LRz/bxhJz4BopmnFY7nuTxIGc1eNUWnrX2FP6HQiD5ySQewww1n
         SuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x64olFW55YKA//DN8fUTXcI1Qtc8u5/YPD0JvsU0Zus=;
        b=NY9khWc4dmqp5D7UhlJC8Mit+QqGTyEu8M3Ex4g4I2UY7PE8liqWFJ8WNMOOJGdPIB
         OMrZ5oRuRU9mMXQQ5Z/u4yOFdb3CjyJpO4Tv0EEFYqcWOUQYaqrFurBBriCAGBFG9Vfu
         LU9rMgwyoRt6ExdNr8am1TuBcGZzhw7jTLxW1+xI7WGAe/nVRGqXOfV4eW4G+PWutn3H
         ZacvpkgAXC9xJAI/XRZLK2DXGb+dIKdvpW5TZuMC2ZHL9nSWsIefXNVebzPkHuW2bBgc
         T91E6khrDJRwjnqm3DclFM0HuwwfX2O7sq6C+4gF/2jN3Z0exjbE8FEEqW2K3w+vtwPf
         UszA==
X-Gm-Message-State: ACrzQf3d5iHUZ6FmHROE/qY8261jCMq01EUeWRzbCoMOpW5erkDJzIak
        7c9unD8eUoz0NCziQUgurgk=
X-Google-Smtp-Source: AMsMyM5cyiniOx/rgj50JTl4wy6snTqzZ0MNKEh3miX9p/RUNDMetgb5BXsiDfLS99mkU+sy4Vg5sw==
X-Received: by 2002:a17:902:6847:b0:186:61be:ef82 with SMTP id f7-20020a170902684700b0018661beef82mr39831252pln.135.1667648060538;
        Sat, 05 Nov 2022 04:34:20 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b001869f2120a5sm1474506plr.34.2022.11.05.04.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 04:34:19 -0700 (PDT)
Date:   Sat, 5 Nov 2022 18:34:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Message-ID: <Y2ZKHPkEXViv9wcp@danh.dev>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 
On 2022-11-05 09:32:44+0100, René Scharfe <l.s.r@web.de> wrote:
> > diff --git a/parse-options.h b/parse-options.h
> > index b6ef86e0d15..61e3016c3fc 100644
> > --- a/parse-options.h
> > +++ b/parse-options.h
> > @@ -128,19 +128,24 @@ typedef int parse_opt_subcommand_fn(int argc, const char **argv,
> >   *			 the option takes optional argument.
> >   *
> >   * `callback`::
> > - *   pointer to the callback to use for OPTION_CALLBACK
> > + *   pointer to the callback to use for OPTION_CALLBACK and OPTION_SUBCOMMAND.
> >   *
> >   * `defval`::
> >   *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
> >   *   OPTION_{BIT,SET_INT} store the {mask,integer} to put in the value when met.
> > + *   OPTION_SUBCOMMAND stores the pointer the function selected for
> > + *   the subcommand.
> > + *
> >   *   CALLBACKS can use it like they want.
> >   *
> >   * `ll_callback`::
> >   *   pointer to the callback to use for OPTION_LOWLEVEL_CALLBACK
> >   *
> >   * `subcommand_fn`::
> > - *   pointer to a function to use for OPTION_SUBCOMMAND.
> > - *   It will be put in value when the subcommand is given on the command line.
> > + *   pointer to the callback used with OPT_SUBCOMMAND() and
> > + *   OPT_SUBCOMMAND_F(). Internally we store the same value in
> > + *   `defval`. This is only here to give the OPT_SUBCOMMAND{,_F}()
> > + *   common case type safety.
> >   */
> >  struct option {
> >  	enum parse_opt_type type;
> > @@ -217,12 +222,24 @@ struct option {
> >  #define OPT_ALIAS(s, l, source_long_name) \
> >  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
> >
> > +static inline int parse_options_pick_subcommand_cb(const struct option *option,
> > +						   const char *arg UNUSED,
> > +						   int unset UNUSED)
> > +{
> > +	parse_opt_subcommand_fn *fn = (parse_opt_subcommand_fn *)option->defval;
> > +	*(parse_opt_subcommand_fn **)option->value = fn;
> 
> ->defval is of type intptr_t and ->value is a void pointer.  The result
> of converting a void pointer value to an intptr_t and back is a void
> pointer equal to the original pointer if I read 6.3.2.3 (Pointers,
> paragraphs 5 and 6) and 7.18.1.4 (Integer types capable of holding
> object pointers) in C99 correctly.
> 
> 6.3.2.3 paragraph 8 says that casting between function pointers of
> different type is OK and you can get your original function pointer
> back and use it in a call if you convert it back to the right type.
> 
> Casting between a function pointer and an object pointer is undefined,
> though.  They don't have to be of the same size, so a function pointer
> doesn't have to fit into an intptr_t.  I wouldn't be surprised if CHERI
> (https://www.cl.cam.ac.uk/research/security/ctsrd/cheri/) was an actual
> example of that.
> 
> Why is this trickery needed?  Above you write that callbacks in
> builtin/bisect--helper.c can't use subcommand_fn because they need
> their own argument.  Can we extend subcommand_fn or use a global
> variable to pass that extra thing instead?  The latter may be ugly, but
> at least it's valid C..

Not the author, but I fully agree with you, I think instead of adding new API
for some arbitrary subcommand_fn, I would change the subcommand_fn to
type:

	int (*)(int argc, const char **argv, const char *prefix, void *context)

The last argument would be an object pointer, which will be casted to
the correct type inside the callback.

Let me cherry-picking this series on top of mine to see how things
would progress.

> > +	return 0;
> > +}
> > +
> >  #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
> >  	.type = OPTION_SUBCOMMAND, \
> >  	.long_name = (l), \
> >  	.value = (v), \
> >  	.flags = (f), \
> > -	.subcommand_fn = (fn) }
> > +	.defval = (intptr_t)(fn), \
> > +	.subcommand_fn = (fn), \
> > +	.callback = parse_options_pick_subcommand_cb, \
> 
> Getting the address of an inline function feels weird, but the compiler
> is free to emit to ignore that keyword and will provide an addressable
> function object here.
> 
> > +}
> >  #define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
> >
> >  /*
> 

-- 
Danh
