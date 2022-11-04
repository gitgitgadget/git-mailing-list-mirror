Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EDC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 14:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKDODc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDODb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 10:03:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1393564DA
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 07:03:29 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r18so4431672pgr.12
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rTnPzwHZD4Hp4RqW0/1JJNAkB+PAcda8XNV6lCbKixU=;
        b=gO+yty0FUQsMD6OmkJIsq0+iwzdzdo1CQ8Q60BQCwHoNwA77P8qXtCyqeQrnNWBS1w
         VEthxUXCQpQ34JFSMJ8KJEHt3mJPtKQS43ikMqEP2oD1ieSj+JPKZ9bUVEhVFkd6a+6X
         /XroLwq5cYa868sIG2UPc5jTociSXDZMFA/xzfAlUvLntAeEsBPuzH3NdhdhMxqimRql
         mHgQKDbUK6+uuQVQBqXyev67ZElX8Cp97VqnsoRf5d/pj+PmxoWsd6f68YVUGG/ivs1c
         LAGmTj28RdAO3sn5lbA61xNSCxEMivyyoVR7KfzswQikj9rIcB0T0kyIlpNXEehFcYXJ
         XaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTnPzwHZD4Hp4RqW0/1JJNAkB+PAcda8XNV6lCbKixU=;
        b=WwTrjesgMZkpqf7Z7ihjlvz8FtICEr2aPkaHJIZkVRK8YlU5G3/laJFJJN86/vycWt
         ptavqB6j5JXgBXmy7bJmBS9IvcXhTyPQtd+ocr0Z7Z6J1RDmsHL2NAgq2ws8y34CgNbz
         p+U/43zkJS59d2Ls0h0pm9eQMZoaG7KI1r4MgUNxMn+3EHy0RRxI5FZ+lgUrygAxQWvE
         oDV+9J16oFC3ecXJBzfefqY+Ispm3gdNPdPcHc66PIKsqLC3hZy4bLbEwoXp4pLRFBYo
         YGjZ9LH0sD+Fd+7eTDz5lu8RXYn4qlA/Co6eH7KgcXBUZqrH9ys8TqP2ROT8frQ45V70
         Ejmw==
X-Gm-Message-State: ACrzQf3Sypi6UR8Synmx1jketGYwizXsnvwQnzCjXqbAbRw9UpoY8Fto
        Um9rV7OLT2H1ulmt++ELnB0=
X-Google-Smtp-Source: AMsMyM4pjOUIpQxoP3867f98YKfRqAsFI8mQERTRHXJGMnwL7EyBM6NTM8LMHewmyTd1Sqyq8lIx8A==
X-Received: by 2002:a63:6b09:0:b0:453:b1f8:bb3b with SMTP id g9-20020a636b09000000b00453b1f8bb3bmr31688206pgc.36.1667570608342;
        Fri, 04 Nov 2022 07:03:28 -0700 (PDT)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902654800b00172f6726d8esm2593553pln.277.2022.11.04.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:03:27 -0700 (PDT)
Date:   Fri, 4 Nov 2022 21:03:24 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] bisect--helper: move all subcommands into their own
 functions
Message-ID: <Y2UbrCzTIvIbPbgX@danh.dev>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover.1667561761.git.congdanhqx@gmail.com>
 <081f3f7f9501012404fb9e59ab6d94f632180b53.1667561761.git.congdanhqx@gmail.com>
 <221104.86r0yiygtd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221104.86r0yiygtd.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-04 14:32:34+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Fri, Nov 04 2022, Đoàn Trần Công Danh wrote:
> 
> > In a later change, we will use OPT_SUBCOMMAND to parse sub-commands to
> > avoid consuming non-option opts.
> >
> > Since OPT_SUBCOMMAND needs a function pointer to operate,
> > let's move it now.
> 
> As shown in
> https://lore.kernel.org/git/patch-11.13-d261c32ddd7-20221104T132117Z-avarab@gmail.com/
> this can be much nicer in terms of avoiding these wrappers if we jsut
> teach parse-options.c to take our custom signature'd callback, but...
> 
> > +static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED)
> > +static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
> > +static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
> ....
> 
> >  	switch (cmdmode) {
> >  	case BISECT_RESET:
> > -		if (argc > 1)
> > -			return error(_("--bisect-reset requires either no argument or a commit"));
> > -		res = bisect_reset(argc ? argv[0] : NULL);
> > +		res = cmd_bisect__reset(argc, argv, prefix);
> >  		break;
> >  	case BISECT_TERMS:
> > -		if (argc > 1)
> > -			return error(_("--bisect-terms requires 0 or 1 argument"));
> > -		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
> > +		res = cmd_bisect__terms(argc, argv, prefix);
> >  		break;
> >  	case BISECT_START:
> > -		set_terms(&terms, "bad", "good");
> > -		res = bisect_start(&terms, argv, argc);
> > +		res = cmd_bisect__start(argc, argv, prefix);
> 
> If we're not going to do that this isn't too bad actually. s noted in my
> CL
> (https://lore.kernel.org/git/cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com/)
> I started seeing if I could cut Johannes's built-in-bisect series down
> to size so we could have it merged sooner than later.
> 
> It ended up refactoring every single user of "terms" to take the
> file-global instead of the variable on the stack, but this shows that
> that's not something we need, even without a new parse-options.c API.

Yes, I saw your patches, but I think adding a whole new
parse-options.c API is a lot (taking a side the type-safety the new
API introduced). If I were doing the new parse-options API without the
type safety, I probably make an API like:

	int (*subcommand_fn)(int argc, const char **argv, const char *prefix, void *ctx)

We would still have a non-safe 4th argument, but we won't need a new
typedef and picking_fn in every source file.

> B.t.w. you can cut down more on the verbosity by doing:
> 
> 	struct bisect_terms terms = { 0 };
> Which is the same as "{ .term_good = NULL, .term_bad = NULL }". I left
> it in place in my version because I'm explicitly trying to avoid
> touching anything we don't need to for a bisect built-in, but if we're
> refactoring this anyway...

Sure. I'll see which direction is favourable by other people.
Yes, the free_terms is the one that increase the size of this patch,


> I also think this could be further reduced in size a lot if we go for
> your approach, i.e. make a helper function that these call, like:
> 
> 	if (have_err)
> 		return error(_(error_msg));
>         if (set_terms)
> 		set_terms(&terms, "bad", "good");
> 	if (get_terms)
> 		get_terms(&terms);
> 	res = !strcmp(iam, "terms") ? bisect_terms(&terms, argc == 1 ? argv[0] : NULL) :
>         	!strcmp(iam, "start") ? bisect_start(&terms, argv, argc) :

However, if we're doing this, aren't we getting back to step 1:
strcmp to a list of subcommand instead of using OPT_SUBCOMMAND?

>                 [...];
> 	free_terms(&terms);
> 	return res;
> 
> Then e.g. the body of "terms" is just:
> 
> 	return that_helper(argc, argv, prefix, "terms", /* iam */
>         		  argc > 1, /* have err */ N_("--bisect-terms requires 0 or 1 argument"), /* err msg */
>                           0, 0, /* get terms and set terms */);
> 
> Etc., I think that might be worth it, as almost all of the contents of
> these functions is just copy/pasted...

-- 
Danh
