Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14121F403
	for <e@80x24.org>; Sat,  9 Jun 2018 17:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeFIRmB (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 13:42:01 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41044 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeFIRmA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 13:42:00 -0400
Received: by mail-ot0-f194.google.com with SMTP id d19-v6so13764868oti.8
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76q6oNkLaISoUw/HRUklDvQmZA1yo/HCOfsuWk+x+Qk=;
        b=Fx7WLCwJkjpT0hIDPHfH6E0y+l2cf7gfwyrfpj1xShOOuo2smClZYgfat1PhAvCfw7
         G5PzlNbYiXo7jazgu/6VeIfCYfS0syIl/3fDEOyTzJUXz17o84wE7oAWHrJodzX3X935
         kTXi7ZvKVwFlSBHj6h10rDz1yVFsJMTfdV2RBTjjxqs2UzNW4QaqQ3wPhTSZ6HRktNPD
         EyDhGLDH+jmPcgHNcw9Y/ksSJoV534TbYRQOPzJHcXJjyvWiYZyyml2Qca8N6e7jGkqM
         XtxEC20Vslh2fDeQqpASkHedNWBf4yAYCTZ6lv65cbNJzP+ECmiN8et1z3C3cAWabdKP
         j35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76q6oNkLaISoUw/HRUklDvQmZA1yo/HCOfsuWk+x+Qk=;
        b=gYbM6rg2wfsbgFUmY1LMj90ku5BBE5g5syB3h2o79IPJkPXs7xFeYVEAUDmD6hKjh7
         R6aojLXI+IR/AFeff2rM8JnFkgUXMSvP7nFyGIRubSk/DTLgVAxgH4r9OU01CyAi2NjG
         zLrIjOo2GfG+EWXSICn9VMtqcqBNodIS+fcecxu0EGVlIUiPZ84VHs3dxL/Q+454f0lD
         vHQ5wJmHYnm1+XCDTuYg9taCF3Gr8FZ6Ga1ly/7xSleMyxjJNkU0j+ckfjqZcymd//QD
         3Z+5xqFRDy4LomeCS2U5RTYZoL+BqVr7Wdq0wIPVxcxIRSzVW4+Rcb0HL1EXX6iPXbxp
         UlOg==
X-Gm-Message-State: APt69E2fByRn58lca68pBJlHZ1KONyJbrI9mijboJ7DR4TxP9ewd3VOZ
        ZQYcn8K9hD3APFj1q0ksKkEBtj8AptSQQaiTFk0=
X-Google-Smtp-Source: ADUXVKImoWZopogSd6v/6xrCzkp7CFpAIOiPbVNBqHon0IJgtYok0UollvY6Q+iNJJ18wctefWHLgCdcRZc35pPSlW4=
X-Received: by 2002:a9d:2c94:: with SMTP id p20-v6mr6703412otb.14.1528566120077;
 Sat, 09 Jun 2018 10:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-15-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-15-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 19:41:33 +0200
Message-ID: <CACsJy8CX5HVNXfiFjOSVJUkyKEfMTcrGKN3T93kyJoG8L00kPg@mail.gmail.com>
Subject: Re: [PATCH 14/23] midx: write object offsets
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 7:02 PM Derrick Stolee <stolee@gmail.com> wrote:
> +static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
> +                                      struct pack_midx_entry *objects, uint32_t nr_objects)
> +{
> +       struct pack_midx_entry *list = objects;
> +       size_t written = 0;
> +
> +       while (nr_large_offset) {
> +               struct pack_midx_entry *obj = list++;
> +               uint64_t offset = obj->offset;
> +
> +               if (!(offset >> 31))
> +                       continue;
> +
> +               hashwrite_be32(f, offset >> 32);
> +               hashwrite_be32(f, offset & 0xffffffff);

Not sure if you need UL suffix or something here on 32-bit platform.

> +               written += 2 * sizeof(uint32_t);
> +
> +               nr_large_offset--;
> +       }
> +
> +       return written;
> +}
> +
-- 
Duy
