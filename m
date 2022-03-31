Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6035C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiCaTVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCaTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:20:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904B49F25
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:19:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p15so888423lfk.8
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUDVzWAAnV8fPuW5mDVT374EExn237xZOpDtfBDrr3A=;
        b=SKjYrcZCJR8eKBdHRSuEdVvGRsuYYEv2Nqk6yC8n8lUlH02pKh11PgqM+Hvl+Qy9zJ
         +3CTwZfMHng6D5qIXGPnMOOq4DKpvtR2KgU18oYI053UetZbxoRT/9Pu0ZEFBxi95DtQ
         QZsP0hSFH6tY2tNb/KZFkxFDnQGcOfPJr8HDcBGtmBSg2x7PrZ8X2j4wuFr3zo78F+Ni
         V8XbGWbowzlQTfv3z4oIg8cabTIeSGAd4STqP13VFaniGP3ZkSQ7Fjy9U87QJ4FGgGdx
         pMxsTnoiC6pK7JHIApWRTei6Yxlb0h+FggPDRoHMEv3xR9dG6MRYo6YrTc5JgdDknmf/
         +G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUDVzWAAnV8fPuW5mDVT374EExn237xZOpDtfBDrr3A=;
        b=TgUGMU9TTUle/Z1pvWoOvfMIJ5TEIeI8jzCDelR6e0VzxDP/KE0kLnP7wdw+IwRQmq
         ofIzqMxBo9YDHlU02/RIizfCufsmmEUWjDvUIUXwcw/b/7A4VQDAyuVyhY/Q4pfvniAv
         6/g8GdlqL7oINWObmjufmkxcqaq42AyPlRXwyWWZduQ0baUGXjg/g2JIB5CTJ8b7ReXz
         rGSbnN3gXwR2Ftrs6FkId1RkIBkSIZQECxX+JRo0j7NGqHd7EbLDpAWQ73dVUwhj64y0
         cPjTU2x6xlyT3WDAEEdgc+VhqfNl6g9FTT6aZFWNBw4mB2BJtYYkkccPieiIF1pskeJb
         DU7g==
X-Gm-Message-State: AOAM532zWWq1JAIkYB173zNJfE0RJlkSjQIC4PaDQ+UEY+gsGZKSxWlr
        W3eJFxR0DyAxQXK5X6JqIMslJM8JgxE9Uu460AM=
X-Google-Smtp-Source: ABdhPJyzivvRG1alN0xiakHA1rPF8hi56XxWGYlIFGiYZ9uMKRncOeFTaSwa0LsyIDVyztgHwfwzpc4EVdYe0Tdglwc=
X-Received: by 2002:a05:6512:322f:b0:44a:57a0:6950 with SMTP id
 f15-20020a056512322f00b0044a57a06950mr11964906lfe.74.1648754349354; Thu, 31
 Mar 2022 12:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
 <xmqq4k3f9w9s.fsf@gitster.g> <CANQDOdd-G0VHOKWjWQL75jAJ7Az4izB33HKzayqnk-F-nkHj_A@mail.gmail.com>
 <xmqqtube2e1d.fsf@gitster.g>
In-Reply-To: <xmqqtube2e1d.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 31 Mar 2022 12:18:57 -0700
Message-ID: <CANQDOdcVnyEo1Om=Odutix1ZT4vbNiZX29_Zo+=PfxnssmUM9g@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] core.fsyncmethod: batched disk flushes for loose-objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 11:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > To describe the above if it doesn't render correctly, we have a
> > bulleted list where the batch after the * is bolded.  Other instances
> > of single backtick quoted text just appears as plaintext. The
> > descriptive "Currently `batch` mode..." paragraph is under the bullet
> > point and well-indented.
> >
> > In HTML the output looks good as well, except that the descriptive
> > paragraph is in monospace for some reason.
>
> The "except" part admits that it does not render well, no?
>
> What happens if you modify the second and subsequent paragraph after
> the "+" continuation in the way suggested?  Does it make it worse,
> or does it make it worse?
>

Apologies, I misinterpreted your statement that the input "has to be
flushed left without indentation".  Now that I flushed it left I'm
getting better output where the follow-on paragraph has a "normal"
text style and interior backtick quoted things are bolded as expected.

This will be fixed in the next iteration.
