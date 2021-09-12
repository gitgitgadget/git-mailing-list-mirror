Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF66C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F1611CC
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhILCWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 22:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILCWT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 22:22:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D466C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:21:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id q14so6313064ils.5
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T5j892xarA3eBNiFjC0ee30tUw+33W9SquzMwF4R1iY=;
        b=Po9SIfdSTltk6f7FW4zpBml1zAyJ90gtwMk8Q6F1979Fmw55xHBcwLw0KD8BWW5V/H
         OwgURyFp0KTHs7T9L67rHK4M63gw83cPwLFYWGbRfKAuhtdzDWdNgd8WKXQ4jGovkYif
         Eht3Q/zwX7yGTkCp4QYRvMhKeaFISF//fJeqz952iZWY//SvZZTK2X4npIGejZxNXJWb
         1P8AbmE8RwsafmgeJL5Cf4CTBeDmeLfiapESS3AFReMy6IeoBKZVFJ1uZDmA714cE5W7
         IbDQy+HNzFC0SjhcwgCmko3cHQ5YDN6wAlEb/16X9BqIvnwh9o+y0/WrmCCyKvpC0gqj
         +YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T5j892xarA3eBNiFjC0ee30tUw+33W9SquzMwF4R1iY=;
        b=hpDkotztL2lOvB8uXtXo4/woLYEqvl+ZcRsJJa6lIyjgOZd8SgL5IvMtEuP82fIPRu
         wluJtEVWqGDUjpVOoE4jwOYJJZCntqM1vf7OftMsmYymlH/nbVlOPTujpSSU0XBmkQum
         INeOEN+Y/DblH1b2iWIlEYF95duEu2PU106DNsKRHib5i/f1dA/QY/tfqwB3CQYXu6mm
         DFNnZoA90nj7CYcDMt1uy5sPsp3en3s35kv4KnhNOChNE+xboj5xaOU9iRz7oeUFIKc4
         a3gjx/mbf0PgVkoykRpSYZe4cXeTze14HBiqGAOoXWAFEHUBDbuNLdjMkqn2fqRxxTst
         SVzQ==
X-Gm-Message-State: AOAM530uKnkLYUU/L/U9v6zybs0Lp5+496TOrYipZp/kcULjZrP9eL86
        yN6rUO0dLvLtPB8SEZGDI0j5H812/+42j9yi
X-Google-Smtp-Source: ABdhPJyB6JSco7pnhqtPGuxgcF1pYHF9Ja7gsdv9k3KrzOhlArowaYek15SKH7AHQqRPB4IWwMxUCw==
X-Received: by 2002:a92:ae0e:: with SMTP id s14mr3438809ilh.197.1631413263219;
        Sat, 11 Sep 2021 19:21:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o15sm1993752ilj.69.2021.09.11.19.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 19:21:02 -0700 (PDT)
Date:   Sat, 11 Sep 2021 22:21:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs
 mode
Message-ID: <YT1kDVBHtPhxc6Wk@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com>
 <YTzYYfBGqG87O5mN@nand.local>
 <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 10:08:44PM -0400, Eric Sunshine wrote:
> On Sat, Sep 11, 2021 at 12:25 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Sat, Sep 11, 2021 at 12:05:05PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > > Before calling string_list_clear(). I.e. we didn't strdup(), but during
> > > free() we pretend that we did, because we did, just not in
> > > string_list_append().
> >
> > Good catch. It's kind of gross, but the result is:
> >
> >  static void read_packs_from_stdin(struct string_list *to)
> >  {
> > -       struct strbuf buf = STRBUF_INIT;
> > +       struct strbuf buf = STRBUF_INIT_NODUP;
> >         while (strbuf_getline(&buf, stdin) != EOF) {
> >                 string_list_append(to, strbuf_detach(&buf, NULL));
> >         }
> > @@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
> >                 ret = write_midx_file_only(opts.object_dir, &packs,
> >                                            opts.preferred_pack, opts.flags);
> >
> > +               /*
> > +                * pretend strings are duplicated to free the memory allocated
> > +                * by read_packs_from_stdin()
> > +                */
> > +               packs.strdup_strings = 1;
> >                 string_list_clear(&packs, 0);
>
> An alternative is to do this:
>
>     struct strbuf buf = STRBUF_INIT;
>     ...
>     while (...) {
>         string_list_append_nodup(to, strbuf_detach(&buf, NULL));
>         ...
>     }
>     ...
>     string_list_clear(&packs, 0);
>
> That is, use string_list_append_nodup(), which is documented as
> existing precisely for this sort of use-case:
>
>     Like string_list_append(), except string is never copied.  When
>     list->strdup_strings is set, this function can be used to hand
>     ownership of a malloc()ed string to list without making an extra
>     copy.
>
> (I mention this only for completeness but don't care strongly which
> approach is used.)

Thanks for a great suggestion; I do prefer using the existing APIs where
possible, and it seems like string_list_append_nodup() was designed
exactly for this case.

Thanks,
Taylor
