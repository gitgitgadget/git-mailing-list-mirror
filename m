Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CCC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 01:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiAXBms (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 20:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiAXBmr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 20:42:47 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF99C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 17:42:47 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id p1so27967601uap.9
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 17:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxGzv+ht+an8rYvTNSVsT+ZtjX7AyrwvrU0avTSh0tw=;
        b=F6s0ZHjJN5PWOz4ceCtZVTibcmJPU9pfyyu/cWIWQ2mEOm6IOGuIIt/4e9t6fmg/By
         nZ1uFAZmPeJU5eyJqvsoqheC+DZKW6W2niZZqgy1n3TLz5qtZQcEAgGoCNNAMnZbKjPg
         DiQ9gwm2LTlWmY75RR8+8ms/0cCN/ORUQcJPCPoUDtTx/i0Bx5CcXNDHes1FrAoj1eHt
         whKMjJUHHwashBq/2f150YFJEzuFp8BauQrLS2Ktm/nCPsiDYcNEKezNPCmPFdBUxtZi
         Xak1Rh1bIzVI3OF/ezVr2okHQGePXCzP6nThby2agCc7n1SKczj2CuRKqeOU1pp7LsAN
         +czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxGzv+ht+an8rYvTNSVsT+ZtjX7AyrwvrU0avTSh0tw=;
        b=JOYJiO22wTaAlwqbYHmJjBC37ifM08zza0kMQhzki3xwCDQkJNCbVlfKywdyh1J6nY
         sE5oB+DJPQoPjC6C3QRn5h7NDxrfqvhVoaIQKSsgJzigv19yeuuKi/WhV9s78zyoRh0F
         ALutw2JieN1FpoBnsNPPE9/pXRWzWg4DSP+rMDvlnD7gOQ1FlAroaLrSPJoRfaPubK5d
         d0H3f2T9OY8Pc6scwjDI+ZQOa4ot9vo6m8Sp7yPUuqna5WmwBxyRy7XfkVssayppRGXY
         ymQOkWdsvY2eCvxYgmZ2eq5kCbiJqWd/RFxEuuAlQ3K+54EFNoSJ7MIP9HglcHAsHDMR
         0geg==
X-Gm-Message-State: AOAM533P4aE7E3T2dpmVgEy5GQPRnj9UmGKVgBnH9bPHTgqmGdB7lyWU
        Wej0aDT2woDlJ7SmbXV19YtZ0py91Td+CX1cQaI=
X-Google-Smtp-Source: ABdhPJzcuxjQrMxsNkBbnXghwuQWZljZ664ce0eJFUuon+dRUb3EDoRUtqJw4BD6BU6UhaJN0fZmN//DhLny+XoYaGs=
X-Received: by 2002:a05:6102:3113:: with SMTP id e19mr884539vsh.26.1642988566531;
 Sun, 23 Jan 2022 17:42:46 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POJ9gwp+t-eP3TPkivBLLbNb2+qj=61Mehcj=1BgrVOSLA@mail.gmail.com>
 <5373af01-eeae-fb66-e9f7-41f2a022b275@kdbg.org> <CAGP6PO+GMi6jqRZ5HWxES5GDYkEDHoXOOZ+VvDkm0sC4nxkT4Q@mail.gmail.com>
 <5a30ac1f-d414-0976-cd08-7b059117af41@gmail.com> <xmqqpmoi9qna.fsf@gitster.g>
In-Reply-To: <xmqqpmoi9qna.fsf@gitster.g>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Mon, 24 Jan 2022 09:42:35 +0800
Message-ID: <CAGP6POK22pCY+_bMCnwRx3h0kE9GpZoq1Pk2hJZoyE_O06WnDw@mail.gmail.com>
Subject: Re: Some sub-commands can't be completed by TAB key.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 24, 2022 at 3:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>
> >> I see the following:
> >>
> >> $ git l<TAB>
> >> latexdiff   log
> >
> > This would mean you have a 'git-latexdiff' command somewhere in your PATH.
>
> True.  On Debian-based systems, the texlive-extra-utils package has
> /usr/bin/git-latexdiff and that is likely where it came from.

Mine comes from TexLive:

$ which git-latexdiff
/opt/texlive/2021/bin/x86_64-linux/git-latexdiff


> It is also worth noting that completion will also include whatever
> alias.  I get "lg" in the mix because I have
>
>         [alias]
>                 lg = "log --oneline"
>
> in my $HOME/.gitconfig, for example.

Good example. Got it.

HZ
