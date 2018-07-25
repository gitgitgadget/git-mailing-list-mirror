Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED301F597
	for <e@80x24.org>; Wed, 25 Jul 2018 18:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbeGYT6f (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 15:58:35 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33488 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbeGYT6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 15:58:35 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so3388397ybb.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObWHzLvqhtYI31u5NntvjY1vtpLPHB9bKa0l4qpj1Gg=;
        b=T09LMN8ztkj4tcRPsPBDof59kjMV6ozl9sz0T3Tubxvr7YWh9KGr/t/jcR+dNXsFXv
         1EtmitHhkzQrvCAe903cLPLsVDs/btCoy+CFUe6QADK+FMZt0sbVkeAYm+S8+B2LQDqv
         BK7R1IZm5fbdtb1Krl5rQaqMLUbIQtNsCWvgAUI6E1HJXduk+nuy3xQQZruHaCAU06HP
         Djg2iyU2tkPAVmJqJdDNg2XuLRioiwGyWYeLG4vPMMDwNzMpJC/2v0nFfSU3R0QQLDyJ
         PVfsTbaKgpDaeMkWpZYlu1ankqXc8KLv3RwDs3XArq80tLuBNi1pxPr4Aa1JZM1BW/Su
         RHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObWHzLvqhtYI31u5NntvjY1vtpLPHB9bKa0l4qpj1Gg=;
        b=J7smxvBpysi2ohVguLNvRg0MgY5VPAkZgWxuFxozhnd/YKtX6ip4IYgtQtTJ+UUB13
         zK2fh8q8sCV8FipPEtoD6wu3l8W0NbmoSus1YI3zMKKANWTE2eujAdZxi7NMh/22fV6/
         azzzIbatJv9ikMX06qHTzW+nl8KJz7kEGqPKpTlD5T2nHI+89FbICq8gXllqo8jGCRb8
         VG2YLF1ZKVo22j39qC+spHOcvR5CjJqj0J/v2a306QG76BAJ7l8aNygFoTfS3D8pperN
         lnTDiEPCay31wjGmqF7Zm/q0G0kyUVlV2ytXtECn8VSRWevl72q2E0zkmOPZwn2nYGIa
         NsAg==
X-Gm-Message-State: AOUpUlGzXBuX7KQtY8clTfcPOxC6qIkj9iw8l96qE9Yu8KaOLgPMVONT
        wmkcHR0yB4HKlw198E7ShoiVxA2sWN9tE5Kfjr0j1Q==
X-Google-Smtp-Source: AAOMgpdgawUH4+qluH9ih+CRLoTaqU5djlHzlXiv8XW3kjHpdW0T2u5wER+EA4MuFthDdAVcC61elkWxI+lzFuI3pqM=
X-Received: by 2002:a25:7144:: with SMTP id m65-v6mr1814258ybc.352.1532544339208;
 Wed, 25 Jul 2018 11:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180710121557.6698-1-alban.gruin@gmail.com> <20180724163221.15201-1-alban.gruin@gmail.com>
In-Reply-To: <20180724163221.15201-1-alban.gruin@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jul 2018 11:45:28 -0700
Message-ID: <CAGZ79kbjy5aXbtThLU7odd15Gf5WZ3c3RGDgxfpcBEh7UnJqoA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 00/20] rebase -i: rewrite in C
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 9:34 AM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This patch series rewrite the interactive rebase from shell to C.
>
> It is based on master (as of 2018-07-24).
>
> Changes since v3:
>
>  - The `--verbose` option is stored directly into opts.verbose
>
>  - Drop includes in rebase-interactive.h
>
>  - skip_unnecessary_picks() now returns an object_id instead of a string
>
>  - Add a test case to ensure interactive rebase aborts when the todo
>    list only has commented-out commands
>
>  - complete_action() aborts when the todo list only has commented-out
>    commands
>
>  - Drop the `keep_empty` parameter of complete_action()
>
>  - Don=E2=80=99t remove the modes `--shorten-oids` and `--expand-oids` fr=
om
>    git-rebase--helper
>
>  - Replace `ret =3D !!x(); return ret` by `ret =3D x(); return !!ret`
>
>  - Fail if `--make-script` is provided with two arguments instead of
>    one
>
>  - Rewrite write_basic_state() and init_basic_state() in C
>
>  - Rewrite git-rebase--interactive.sh as a builtin
>

I gave that series a read and I think it looks good.

Thanks,
Stefan
