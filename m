Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE458CCA479
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 08:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGRI7n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiGRI7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 04:59:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A83F5B6
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:59:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so17615091pjn.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjPRDcEHfnRGVg0Ytak2fpW3RwAKzgu153aPPr8vmA0=;
        b=pmGWVoI8pax7Y0NxtQQbkmAIfN5ldUvgBTUJRA2NBFrJvThPwC+rOEMOf6cvS/PJm3
         8XluRNUVpvaSaOYxQCIuk/3ubpfD27mPNbG2Exf12w6cPY2R/7QhD7mmArihTEKzMNrp
         mYPBr5ZOoDJNS5VSwbHcsRHOSfiN3LEc4ZDEOU4ejhH9yif7PN9Cie2jCuuJcnbW6M/h
         WNO2a79Yi11U95s4T6L422nlNjQiHEdr7D828lt/ahYHwSDYVqBiuZbHA9NNm6LKp2ET
         tn/t7IcOksV26GJlfXesH7/ROdbQcORERKSo49ubu9qaDxXGoRNgTThGsUBtA6D1fFk2
         6qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjPRDcEHfnRGVg0Ytak2fpW3RwAKzgu153aPPr8vmA0=;
        b=kjum9l4ySN5zTC7TbE+yYzEJZGZ0egYW+LDOFgA7BY9Aw0LNMivPaDv3niQ1tZCgxH
         17b48AfAzBHRYLZ+DEeZWTm3YvPr/tHo6Q89djcQ1ttFLixjbm5sgbLyXVEydkGWJ3/l
         vDevfC/a0tBRugMFshjboPPUBNBehcdxotmNiNAWEnJlvuWjnQZraFlPMudJJ4XK0hNw
         2RRpqHN7NN83ruiC3KhQ55EO2Lh6DozOJtd7xLrOvfYDxgnVeaTpt4CKWbMlIDMoQWo1
         bul72BPyI0yZp7E26hT6D42+NN3bAOT5qa1fcyOFw6MeiY2BdgM+MSloEaTbXW4nEe66
         wB/Q==
X-Gm-Message-State: AJIora9jdUp578vOmSDHX54CCMu8KJ13Tj5t+C8ESCOYvx4eSwYgvDQK
        nh3jbAJrPx7jscDedYhJIOs1PhJ/wQ2MF6vX1h8EF7fR
X-Google-Smtp-Source: AGRyM1spwTTHI+kKsT9hyVpSbyDeu+hKUfmuICIFwKyORSegs+4XrMRtpwG4BU6El3uqBD7VpKGbSNU+pSewOmfPUsM=
X-Received: by 2002:a17:90a:a404:b0:1ee:e545:288b with SMTP id
 y4-20020a17090aa40400b001eee545288bmr30315972pjp.142.1658134779875; Mon, 18
 Jul 2022 01:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 18 Jul 2022 10:59:27 +0200
Message-ID: <CAN0heSoBca4BcBgR01cwE567NHQyjO+gRkY1V_6Z0nEd-_tW4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 4 Jul 2022 at 10:48, Abhradeep Chakraborty via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> +static int table_cmp(const void *_va, const void *_vb, void *_data)
> +{
> +       uint32_t *commit_positions = _data;
> +       uint32_t a = commit_positions[*(uint32_t *)_va];
> +       uint32_t b = commit_positions[*(uint32_t *)_vb];

This casting and dereferencing are ok because ...

> +static void write_lookup_table(struct hashfile *f,
> +                              struct pack_idx_entry **index,
> +                              uint32_t index_nr,
> +                              off_t *offsets)
> +{
> +       uint32_t i;
> +       uint32_t *table, *table_inv, *commit_positions;
> +
> +       ALLOC_ARRAY(table, writer.selected_nr);
> +       ALLOC_ARRAY(table_inv, writer.selected_nr);
> +       ALLOC_ARRAY(commit_positions, writer.selected_nr);

... `table` is where `_va` and `_vb` will be pointing into.

> +       QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);

I started looking at this casting because of something similar in
"pack-bitmap: prepare to read lookup table extension". I'm pointing out
this instance just to say that it looks ok to me.


Martin
