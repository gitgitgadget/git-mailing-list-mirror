Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F2C3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiHXVJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbiHXVJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:09:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF7C79A56
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:09:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id x19so16754954plc.5
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=Vg0cRbm5nCgVKwl/782N4zoQt4noUie83pXiXWYQrqw=;
        b=Bd5tvutRwO/ZsIzJGBkn/akGFTcnPJsgcovpECb52PRTCc3p3n6Qxdm72yamejPNeS
         C+CbkNwc3Qw2vi18sw4B9cyZ3hqzVLbsH6L3vwwzNZZ0dNB4i2hALgfm/OmwS8iFXKY3
         lEMsf/2JRS/6+RO+z2yVbTAOAhu9R4oUgZUVGbZMdha2PgvwfEVFenKO345v3wQZ6Z+b
         CF2MVUm1pVUMMCHMeOatLeC1HmQnKk91iy64WIXkCq10wV7m0Gl8ZGt9uXVFOR0dHBfY
         AOS+mWz7Ik2GP02FBx4NO0O6Z7p/ZvONprIJbI96Ezux3gXBcMSESQyhZZwuEYLc2tZ5
         LZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=Vg0cRbm5nCgVKwl/782N4zoQt4noUie83pXiXWYQrqw=;
        b=T3pFSP2C3Hm7japSnQrGQxC9kMr51t1+TpnrT3kcZxJI/U7+jfkHE1SkHT8FtIOCGE
         uM+yFhv2MhQ8/fjPX2+Y3se9QWBWTY/ioU+MsrZLmEFD0vEKGSx3y5sPRgW5TaRzVfrC
         2pnFbnmnraw06VB7yFQ4ufTQXawBVkMdDaPAQ6qGiCX3AKHbXzxY0LtgSoyepMSl/fZx
         gqLYsMZVTHkvckGdCDKnx73RW8DP7bNjnB1kNYUH/aNMs2Kvk8ly3A6ORj4i2XS+xQHU
         uU6ByDOUR1u5UnCalhLm+9tXTGigzMXfE6AsQTUhPsag9FtEgL8InOPfyAJDOkiifkiy
         1Jcg==
X-Gm-Message-State: ACgBeo15thwRwNx0gcSDpzmm1opRVUPT3bX6D7Hi4EBeGfxs1ZqCc07E
        XRtbqyZFVWRkz1MgtW3Bw80=
X-Google-Smtp-Source: AA6agR5c+2FArj1e8PoejmHYhGuyzyi4BlNYAbrLDhGqJ7j4mkxint7trQT2t2baq/ZBkK4GtSCPpg==
X-Received: by 2002:a17:902:d591:b0:172:689f:1059 with SMTP id k17-20020a170902d59100b00172689f1059mr603896plh.121.1661375347517;
        Wed, 24 Aug 2022 14:09:07 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b0016f1ef2cd44sm13185904plh.154.2022.08.24.14.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:09:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] Miscellaneous merge fixes
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
        <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>
        <CABPp-BHcRQatt9F2Hj4ygUsS9y8_BmfN3K=YFrLEnCn+2WLz9A@mail.gmail.com>
Date:   Wed, 24 Aug 2022 14:09:06 -0700
In-Reply-To: <CABPp-BHcRQatt9F2Hj4ygUsS9y8_BmfN3K=YFrLEnCn+2WLz9A@mail.gmail.com>
        (Elijah Newren's message of "Mon, 22 Aug 2022 20:03:00 -0700")
Message-ID: <xmqqfshl5oy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Aug 22, 2022 at 7:42 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> While working on other things, I noticed a few miscellaneous issues in
>> builtin/merge.c. Here's a few small fixes to address them.
>
> Sorry, forgot to include a high level summary:
>
> Changes since v1:
>   * Fix play/apply typo, spotted by Eric
>   * Almost completely rewrote patch 2; it's now merely a "code cleanup"
>   * Added a third patch, just a very minor code simplification

I was skeptical about patch 2 before I saw it, but removal of
!merge_was_ok in the loop condition alone is very well worth it.

As to patch 3, I do not think it makes huge difference either way,
but I've queued it anyway.

Thanks.

