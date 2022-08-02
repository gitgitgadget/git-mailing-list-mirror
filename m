Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468EC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 22:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiHBW7q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 2 Aug 2022 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiHBW7p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 18:59:45 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8AC201A5
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 15:59:41 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g5so1479147ybg.11
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 15:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=blABbgg2NOX/9YNnGLGfjb9EcskQRU3D0BUdTZ10Mpo=;
        b=0dcT3VNG9gUC7SCIACyAhOxVEMZWbdMXAdYGSTK+hHWsUw6OTOVVNDcy+3JTINbcBR
         yNwmR/7ZZdmRMOs4xw26QAdL2+tMWLTyTax6YkXYert/TwPXzW1uE+TBRUpVw9cbOlru
         Thzn/BXhzBX486sryYOFMEmjUlqakF0MdpyCzLy7IopRq8uC+NZ3ajKrzkU60hy8yWTV
         JWk9lgjX8hg6TrRvJxnCu5FuZzGRxI/0bW7Rlv9v6fz1phFBiTG1OdsQfv30X7KtMSNc
         80fBpnX2C5WRYujz3dfePteNuUb10ml9JiXvyQMESQcLfmRDq6OLi0+eJd+4P+S9Edn9
         3oBA==
X-Gm-Message-State: ACgBeo1fmm50wGWPiNU0i4nA7bTmiCLKRcKsx6OYbfqVJBu4uXlHjlsO
        kFqF1iO8kgSqZFAoAfnveHEuigfutDHm8553cj8=
X-Google-Smtp-Source: AA6agR7hZoFS3gJs2HlHP+N+cp8LFH6zD0Qq/U7HnRqEo3DbaNoAkRwrc4cTMNuiVxoGemMCnVWd0wB792O6Y7akMiw=
X-Received: by 2002:a05:6902:706:b0:676:dea8:c1b2 with SMTP id
 k6-20020a056902070600b00676dea8c1b2mr14556019ybt.475.1659481180960; Tue, 02
 Aug 2022 15:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1228.git.git.1659422389830.gitgitgadget@gmail.com>
 <xmqqles6is9s.fsf@gitster.g> <2a7040a4-20ce-495d-4182-089c6c08fbd6@gmail.com> <xmqqy1w6e0ix.fsf@gitster.g>
In-Reply-To: <xmqqy1w6e0ix.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Aug 2022 18:59:30 -0400
Message-ID: <CAPig+cSzgaxMxfhShRHtztRH72rgA21-Vw1SrFwkiFyrP7De7Q@mail.gmail.com>
Subject: Re: [PATCH] rebase: introduce allow-inline-reword option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Th=C3=A9o_Maillart?= <tmaillart@gmail.com>,
        =?UTF-8?Q?Th=C3=A9o_MAILLART_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 2, 2022 at 6:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> Théo Maillart <tmaillart@gmail.com> writes:
> > So, if I understand your suggestion correctly, we can say that,
> > most of the logic is implemented in this patch, but I should move
> > the "inline" logic from the "reword" to a new action "retitle".
>
> Yeah, I was hoping that most of the logic has already been written,
> except that it is likely you just ignored the original log message
> and overwrote it with the single line you got, but now you need to
> read the original and replace only the title (the "paragraph" before
> the first blank line), which you may not have yet.

Michael Haggerty had made a more generalized proposal[1] some time
back which might or might not be relevant here. The notion of being
able to edit the title of commit came up in the ensuing discussion, as
well.

[1]: https://lore.kernel.org/git/530DA00E.4090402@alum.mit.edu/
