Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90318C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC0UmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC0UmN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 16:42:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFEC10E5
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 13:42:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bn14so5934459pgb.11
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679949732;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkc2+Pzf9EbVSHpWvXy5SahyveOm/pVMqR3yQL9vW8U=;
        b=TlhSEYN2qWTdXsx6Ly5pH6rTd/V4cHLy1KlOD5LP7Q9JRjAcLyzyxXQq646Goi3oTo
         jJp7tlsYQPZhPKpsmfyGuQ7btKtYoyZyONA68SbmV0nfSB/y7fxMdt0c9Y74gcQXUZ/b
         SqlZ81RrwKkfpe4hGRHIOT7U7Qsm7vfcLZmASqwMQ76lp2K8DqusdtsZdbyp0F5I84gS
         YIV9Yw1xk+gqKRTVc8W5WZes9qGMDABPkdKzC8xjiFzNgqjdy6MWxJWtPfE2M9k0f41Z
         QSqrKGw4te7JmJgsD+Mvu5w65aKzamjTst5RNISbdaZbR73/v9R9rODkXE0w04x2uZxc
         5r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679949732;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkc2+Pzf9EbVSHpWvXy5SahyveOm/pVMqR3yQL9vW8U=;
        b=N4xK/so7kel7/m8GnsX2BFdze0yeEMPuOqTF41ilphCsK3q+j7maqSsUhZt1lBnGrV
         7wgdxo621HY7yMIQWvHvZ0eCMKX4/dFsJjglDLYKnU6zH/28xK+D1ki2lHquUtLuPsW/
         ReihIPC4Gkona3Ig/MMTIU3kZii3tfyoMW19nzBhIa3c/nbe+Tp6csRt0nD/bfiGGbLx
         /yTX1DUFsMwiow05vnY5YC3vOnkj2hj2KjwVOah51O/CyoMyKdGxJK6QSQZ28izZseR9
         agHRRCTZtchDfCIBPNNVRRGXDE7r4XrQfX82/Kde1YEEa//1jnoZrQ6lxpdnkhIwc3S3
         g7yw==
X-Gm-Message-State: AAQBX9cuJfJeH6olMoGjFrIyvH58ffm+qdmvPlZQRhkaziVYC5aOSSOx
        lhAB63OfBPebTfpmzgz/ODY=
X-Google-Smtp-Source: AKy350Zgmnr15XoZrucKQxd7xHq5A3Q/Emx82uY2pdj2J7H5do/dBGv1iRLD5paxT/GZRxfDQ9RmoA==
X-Received: by 2002:a62:5543:0:b0:625:a012:a59c with SMTP id j64-20020a625543000000b00625a012a59cmr14185536pfb.9.1679949732072;
        Mon, 27 Mar 2023 13:42:12 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id t23-20020aa79397000000b00627df889420sm18057480pfe.173.2023.03.27.13.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:42:11 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: win-test: unknown terminal "xterm-256color", was Re: [RFC PATCH
 6/6] ls-tree: introduce '--pattern' option
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
        <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
        <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
        <xmqqtu20qinx.fsf@gitster.g>
        <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de>
Date:   Mon, 27 Mar 2023 13:42:11 -0700
In-Reply-To: <d566eb68-6476-a193-2acb-10106a154d3d@gmx.de> (Johannes
        Schindelin's message of "Mon, 27 Mar 2023 12:37:33 +0200 (CEST)")
Message-ID: <xmqqzg7ylye4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The TERM is hard-coded in the MSYS2 runtime:
> https://github.com/git-for-windows/msys2-runtime/commit/bd627864ab4189984cdb0892c00f91e39c4e8243
>
> Note: The MSYS2 runtime merely wants to ensure that `TERM` is set; If it
> already has a value, that value remains unchanged.
>
> And to save on bandwidth/time (in a desperate attempt to counter the
> ever-growing runtimes of Git's CI builds), I liberally exclude files from
> the "minimal subset of Git for Windows' SDK", e.g. `/usr/lib/terminfo/`
> and `/usr/share/terminfo/`. That's why `tput` cannot figure out what to do
> with this `TERM` value.

Ah, so it is not like "you ship vt100 but not xterm-color yet the
runtime insists you are by default on xterm-color", so "set it to
something your terminfo database understands" would not work.  I am
not sure what unintended fallouts there would be from setting it to
dumb, though.  Our tests are designed for unattended testing, and
they are even capable of running without control terminal, so it
should be OK to force TERM=dumb, I guess.

> If these `tput` errors become too much of a sore in your eye, I see two
> ways forward:

Not at all.  As long as it is clear that they are to be expected and
to be ignored when fishing for real breakages, it is fine by me.
Others may care more than I do, but then they are welcome to send
fixes your way ;-)

Thanks.
