Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE31C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 16:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBYQ3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 11:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBYQ3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 11:29:04 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A405FD0
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 08:29:03 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id j17so2120196ljq.11
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o1iyWgZczHTmJogixeMIqyK/fObadawIOWJa+36eqsM=;
        b=WC/KV81rChyuWGImdI1RfJMsGetWKPJipa2N0SyIlv2tFBGun0xzQm6dWk1O4Xf8xf
         o0bByLb8tyZEvE6P9qXLCmbRHyLm5QPfiRwsVWSaWLntSy+AvTmbNWTjQOvmvAL2uxBI
         B2vlSNTsq6BO42HAVlQFcTFa6Ex8yrt3B2+DtMo03p5L9eTRYjGJiayrzOLwai+B1aUR
         w8Htu7FVF1qMVklwpxVuXRQr1ky/Kr40vbNa6kzQbJiB6C2D5l34oAxxyAo+ZHo9GIXS
         SgkaPvwDrs3js3nGBAq+B1IIqXeGtorYXinrwi41WwBGNoVXKvtFRaNB4bep0R7PCUMf
         2esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1iyWgZczHTmJogixeMIqyK/fObadawIOWJa+36eqsM=;
        b=Uzj9bsVbSS14tkctjrcxuJRzEjv4GuY2G6OHAVxa7YLdsbBAPj9DiImnu/AKBGLXXi
         hGiZV7edhlhMdBmeCYQR872m/QWYuntmDMVmjdArvZGgfJ2ceSWjojjI6wmAgbcpUFGF
         XNOPCAiKrj3BxCbSI1MheA1Xn3AqOs6MegZe+8gPgInuuKHD02pjzxX1AG9E9VAccwk1
         cIsrWbc2mt+yxPzGsgwxZyENMTn1g2hORWSi/ltvI7BX5tEextWP5xsFVefkAXMUSw1g
         gXvJWW0sjzOHiObOLvl3xkxbEtEbpY2Jg5Q17/5yqcZgG4V6/ws/vCGl74DjHEISFTr2
         GVTA==
X-Gm-Message-State: AO0yUKUfXB0U2jIvB7nY6u7kPPyfc617IgFMb7ftumoO7MCeousDtW6+
        jStoUkw292kgz+t30pKCqJJLXZ+OgpxFqifYutM=
X-Google-Smtp-Source: AK7set+jg5x7TPb1yRJ4G89x/zNtNYZbRODiK/74gAc8/2KbdWwtVPNWke7gdZromdDhqpVgSTYqXIJCFkJAQ64+G/c=
X-Received: by 2002:a2e:a268:0:b0:295:b0cd:523 with SMTP id
 k8-20020a2ea268000000b00295b0cd0523mr188306ljm.6.1677342541107; Sat, 25 Feb
 2023 08:29:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk> <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
 <87a615vkqk.fsf@osv.gnss.ru> <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
 <87bklilnvp.fsf@osv.gnss.ru> <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
 <87fsatixnn.fsf@osv.gnss.ru>
In-Reply-To: <87fsatixnn.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Feb 2023 08:28:49 -0800
Message-ID: <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2023 at 7:15 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Elijah Newren <newren@gmail.com> writes:
>
> [...]
>
> > Please, go read at least [1] to see Johannes comments about how the
> > prior proposals don't work beyond simple cases.
>
> It's exactly handling of simple cases that we need most. We can get
> fancy afterwards, if feasible.

If we can handle just the simple cases without making common cases
significantly worse, that'd be a potential path forward.  Any proposal
involving the diff between a merge commit and either of its parents
(or an equivalent such as a three-way merge involving the merge commit
and one of its parents) doesn't achieve that, IMO.
