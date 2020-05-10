Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3461C38A2A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1120725
	for <git@archiver.kernel.org>; Sun, 10 May 2020 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZAEfU0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEJO1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726104AbgEJO1Q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 10:27:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD25C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 07:27:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so2889911wmf.1
        for <git@vger.kernel.org>; Sun, 10 May 2020 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GQXLJJW2NKaYVL8XU1RqlOGUGRZu3NRZpyh2xSq1hqc=;
        b=UZAEfU0JeZhxD1JcS83/QR1r32gZO4OF0yXYlD33g6praNTJ6Oh6UAhyytVXp+7aQz
         eSUMI5/DuT3QuHYdv116RCtsqFPEpEHQfZs9/ecLlMZa/fOYy7i9S+9wUX6x5lV60V9j
         YindZPWTrJi0yHwI910ul48+dkgiesPfBbTxWQBRfGeXzeN9MFrHT4nPdsmJY/QaFhnt
         XFVDk+R5nxmVKI1jdJKxFaO9ACo3j0IJd6OujdB/tOGY1EaKND1lTifbGkgcK9yxwhsi
         gd7c5eLUaYEI6QFAqtFtC5k7DeWO371Q9ABWFNQ3iy8dd/8xG3s7uMIBcdgHflGGFgdv
         aMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQXLJJW2NKaYVL8XU1RqlOGUGRZu3NRZpyh2xSq1hqc=;
        b=kqZy03G6ScNG/+XZFWi7HKSRN82viKlce/QJduU3g49ehyuvW4MpIR3SFchR7VfXVA
         DPUKVfM3MLuCqAX5nWxxlNqPVczPfnBguSEdRC4XqDZv5g/ufbRgz4zCc7Knd7cPrqjK
         8oLn3CpIttMwbIppV8O5jU9nI3K5G6OvZpILQzuGQgYLkmVHtUEg3g7FLggx8KiIRxlQ
         brmKgcgmYPB2RBYFgDPsUaQ0tOTVfJWC73oynT0BfIOpOuLHG5HxKUWoPU10k2sUa3m1
         Ul7a38ht9zVkDKGYyM0VIDJxC6uu0dp2cShSwVwqnt7BWX0epWueuuJhZazwP9URWadF
         oFxw==
X-Gm-Message-State: AGi0PuYkWlYVJBNTgt0YHTBh9b4yyPmxAglvGYuAcU9tPP+vq3rtZ4fq
        rKBwcmEciYr5pbvIbHSX9Ao=
X-Google-Smtp-Source: APiQypLxhiyD//RQod4RIVMntFdPHC/GDFognnAWB4DmQ5hLIQ71V43w4RKJ0Ra0XOfS1C+3zJAHCA==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr28249278wmg.65.1589120835057;
        Sun, 10 May 2020 07:27:15 -0700 (PDT)
Received: from C02YX140LVDN ([2a02:a210:ca2:9c00:24fa:5ec6:f137:aace])
        by smtp.gmail.com with ESMTPSA id b22sm30189693wmj.1.2020.05.10.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:27:14 -0700 (PDT)
Date:   Sun, 10 May 2020 16:27:12 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] midx: teach "git multi-pack-index repack" honor
 "git repack" configurations
Message-ID: <20200510142712.GA27407@C02YX140LVDN>
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
 <a925307d4c57506f5236e60dc1390998e186cf26.1589034270.git.gitgitgadget@gmail.com>
 <xmqq7dxlvypv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7dxlvypv.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 09, 2020 at 09:51:08AM -0700, Junio C Hamano wrote:
> "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Son Luong Ngoc <sluongng@gmail.com>
> >
> > Previously, when the "repack" subcommand of "git multi-pack-index" command
> > creates new packfile(s), it does not call the "git repack" command but
> > instead directly calls the "git pack-objects" command, and the
> > configuration variables meant for the "git repack" command, like
> > "repack.usedaeltabaseoffset", are ignored.
> 
> When we talk about the current state of the code (i.e. before
> applying this patch), we do not say "previously".  It's not like you
> are complaining about a recent breakage, e.g. "previously X worked
> like this but since change Y, it instead works like that, which
> breaks Z".
> 
> > This patch ensured "git multi-pack-index" checks the configuration
> > variables used by "git repack" and passes the corresponding options to
> > the underlying "git pack-objects" command.
> 
> We write this part in imperative mood, as if we are giving an order
> to the codebase to "become like so".  We do not give an observation
> about the patch or the author ("This patch does X, this patch also
> does Y", "I do X, I do Y").
> 
> Taking these two together, perhaps like:
> 
>     When the "repack" subcommand of "git multi-pack-index" command
>     creates new packfile(s), it does not call the "git repack"
>     command but instead directly calls the "git pack-objects"
>     command, and the configuration variables meant for the "git
>     repack" command, like "repack.usedaeltabaseoffset", are ignored.
> 
>     Check the configuration variables used by "git repack" ourselves
>     in "git multi-index-pack" and pass the corresponding options to
>     underlying "git pack-objects".

Thanks for this, it will take me a bit to adjust to this style of
writing but I do find it to be a lot clearer and practical.
Will update in next version.

> 
> > Note that `repack.writeBitmaps` configuration is ignored, as the
> > pack bitmap facility is useful only with a single packfile.
> 
> Good.
> 
> > +	int delta_base_offset = 1;
> > +	int use_delta_islands = 0;
> 
> These give the default values for two configurations and over there
> builtin/repack.c has these lines:
> 
>     17	static int delta_base_offset = 1;
>     18	static int pack_kept_objects = -1;
>     19	static int write_bitmaps = -1;
>     20	static int use_delta_islands;
>     21	static char *packdir, *packtmp;
> 
> When somebody is tempted to update these to change the default used
> by "git repack", it should be easy to notice that such a change must
> be accompanied by a matching change to the lines you are introducing
> in this patch, or we'll be out of sync.
> 
> The easiest way to avoid such a problem may be to stop bypassing
> "git repack" and calling "pack-objects" ourselves.  That is the
> reason why the configuration variables honored by "git repack" are
> ignored in this codepath in the first place.  But that is not the
> approach we are taking, so we need a reasonable way to tell those
> who update this file and builtin/repack.c to make matching changes.
> At the very least, perhaps we should give a comment above these two
> lines in this file, e.g.
> 
> 	/*
> 	 * when updating the default for these configuration
> 	 * variables in builtin/repack.c, these must be adjusted
> 	 * to match.
> 	 */
> 	int delta_base_offset = 1;
> 	int use_delta_islands = 0;
> 
> or something like that.

Will add the comments in next version.

> 
> With that, the rest of the patch makes sense.
> 
> Thanks.

Cheers,
Son Luong
