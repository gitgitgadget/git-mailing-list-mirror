Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAB5C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 20:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbhKVUzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 15:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhKVUzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 15:55:17 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B1C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 12:52:10 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p37so39239674uae.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 12:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOa7XjA2FXFGeFAifEsBQuRbv7L57TY9Ul4GdujNOMQ=;
        b=Vpb2eEoAsXVZ6EZZf3jpMuDs/IOHchePDfa696mhqWZ52guGnw7jq+WbT/WaAGYHiL
         FYsDdbm5wjm8AeQYKhz/KfbAvATIHTRwesNzcK/O96cWg4U3v17Dp6NVAsdnEmSG/qRz
         7/SIxEAnTbOoySB4Y/gAta2Og+co/G+fUx+zW3iMummavXH/DEztGDTFdg2tCjVyRObh
         SiqOFyfTyHuOoSKa9BA6VwzZd1DIztkwwfvwG7GTDdN5uO50E6kFFGHtPBfJX4hDR1/I
         tqk9Kpwi6unk6orlfjbJAKSkaegkrClr7rJQHZbAB7x6w2JdALNpTpJ1isDGVarmxG+S
         dWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOa7XjA2FXFGeFAifEsBQuRbv7L57TY9Ul4GdujNOMQ=;
        b=B/KDjgTCFnVtcNgtuYabwR+JhQo+HqxwepjI1bdjhXi4xhxJMH/7Qw42azQ5apLlqq
         2uNiq0im1+E5DyTL7hc8u0xSheZpbmqZnY63NEf3CR3oYvvyxSQGZPe9E2zVtAsxYqRG
         35iz3eGQ5WNYKy/LtppyHKGwe1BRxli/DxVLraA8LjjcR7wR4009f5o63khdJ/tZ0yu9
         a+gmCtyuVEx3GjUFPNDppI+bXLZVb+cmoA6CjKKl+NfH2ZfN8tkpvOCQhJL9XMFrNwT4
         tDFOXydugK1xdc7wydV3DPxRUGHxX4zSTaWI+7z62T2n7Okx5lJb4g92qk6rc8Jwf4Ya
         BANg==
X-Gm-Message-State: AOAM532i9OS8ZbBPdd81y77JHWtaDtuvB/+C1xnaqTCH8VbYvO2s8OEA
        wYnnuMGlbde21cuutuN96b2sC1UwWQSGfarhQNY=
X-Google-Smtp-Source: ABdhPJx3ROXFPHV5sYkm1PpF97Fxg2mOinhP3WZmBz5vxasrA9cu8DGSvZQTJHkwumKm8vB5+SI/s2cJUfa6fnB6U5s=
X-Received: by 2002:ab0:7c65:: with SMTP id h5mr88501241uax.138.1637614329351;
 Mon, 22 Nov 2021 12:52:09 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1b8gkhg.fsf@gitster.g>
In-Reply-To: <xmqqr1b8gkhg.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 22 Nov 2021 12:51:55 -0800
Message-ID: <CAPUEsphNH9pfQoHqVgJfkQCU-Li45dz4QtGtDjWu5bDV9A3PEg@mail.gmail.com>
Subject: Re: preparing for 2.34.1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> There are a few topics [*] to fix regressions introduced in the
> previous cycle

There was another regression report[1] that I just fished out of my
spam folder and that I introduced in 3d411afabc (editor: save and
reset terminal after calling EDITOR, 2021-10-05), but that I have not
yet produced a fix for or fully understood.

The gist is that some people seem to be using a hack[2] dscho posted a
few years ago to get info from git programmatically and I just didn't
expect someone would try to invoke the EDITOR unless they had a
terminal, so the fix might be to just add an isatty(0) call, but
reverting that commit would be also an option.

Carlo

[1] https://lore.kernel.org/git/ee302c98-da27-da43-e684-c7ec8b225360@gmx.net/
[2] https://yhbt.net/lore/all/nycvar.QRO.7.76.6.1903221436590.41@tvgsbejvaqbjf.bet/T/
