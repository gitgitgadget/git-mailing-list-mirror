Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C2C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjC1NRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjC1NQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:16:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2508A62
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:16:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h14so7159347pgj.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009392;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=laAkbxgs5r71S9nDyVTNjekSglSzKmuVZhIfyjuCN8k=;
        b=pECPYgnt8SgeDMqjJA41DwTVo9YPpLeB5s0CaJmfno3iOUkP1zKVxLyviYnpfv4+bl
         7NMP1k1xjw1ausKAuwyb7ROmpPDihcD79sfaqxkjC3jycOyNCiuxqpQ+hPv6GEKPZeL3
         bMhoKd+vxgiVVhB4y1+Ciys0rxufDVX3V7//Fe8YIdsUoV4LspHhvJXLiPutCNFofZuz
         LYj8EqcuIq7s/IrfVSzqyDAKJKAkKCoQtAfJrb0DvIQomxrT65yXcsewP5BC+xP5wjAq
         QUikEgm+LcuU1oNs8LljvA0rAZlxkjZcNhTgDljxeJQGqEZG52TXOcqwORBp35AlaUsE
         oZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009392;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laAkbxgs5r71S9nDyVTNjekSglSzKmuVZhIfyjuCN8k=;
        b=unJ+2EjJjzUw54EP4GBI+T8oss/5duI6XI3S62q+qdcX3yIixnq8Yet6qkzMVZBv3r
         b4kTgVVzkxMMnwPpJ4KTnu1DNotwitijwDBI0SxbR1c+YOClPu6i88Okms1gcw3DbX1v
         Op9Rjv3uM0Yq70/JhNUVd2oAP9G5vkYhSWY0fJonnS2sMRtud4meRrtw14ZOe6xBh0mD
         HK5h6V0zVrsG2vhYQTowUTZHug3ksbYGkFwpgoeTx8hNa02fIGngU3jfjPbOTM91Av8n
         6N+bBywrKtUUyUPgiYcU3ilnRVMhn/4max14+lljCLhfpDTO/7AWw2EIn5M2nhtwJaWP
         fulg==
X-Gm-Message-State: AAQBX9f9mDo6CDDEKvN6uC5INVZKou0StlIYRQORS0Hs2iEVfLsTkbR+
        m8L+/t2+KEhBN+EgdoLDv/vURU1A74/11CGT
X-Google-Smtp-Source: AKy350ZkMWaXKEEdOM/zwGmkBXcjnuccvE4+vhLT4iS4ZSmi9VAnDa9d2h8tJgoQQHTF7RWC+eAcyg==
X-Received: by 2002:a62:1b07:0:b0:625:4b46:e019 with SMTP id b7-20020a621b07000000b006254b46e019mr14238987pfb.9.1680009391996;
        Tue, 28 Mar 2023 06:16:31 -0700 (PDT)
Received: from Developer ([123.19.165.203])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b00593e4e6516csm19501236pfh.124.2023.03.28.06.16.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:16:31 -0700 (PDT)
From:   <sang.tts.designer@gmail.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     <martin.agren@gmail.com>, <git@vger.kernel.org>
References: <000801d95a56$e9253f80$bb6fbe80$@gmail.com> <CAN0heSqEH+AtzXcybPY-Jd-bRtgtKmGrfxbXL-adsvjr_srEZw@mail.gmail.com> <001d01d95a63$f1fa38b0$d5eeaa10$@gmail.com> <002601d95a64$57312bd0$05938370$@gmail.com> <36529771-b147-48ac-13df-51ed8462eaa1@gmx.de>
In-Reply-To: <36529771-b147-48ac-13df-51ed8462eaa1@gmx.de>
Subject: RE: Bug Report with Git Bash
Date:   Tue, 28 Mar 2023 20:16:24 +0700
Message-ID: <003601d96177$822f7110$868e5330$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHl4PFjS+RqS8CpTVhw3ZGG/+gRxgJP7KFgA4RLNfsCCen9GwHSXpbQrqmo8SA=
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Johannes,
Thanks a lot for your information.

--
Thanks and Best Regards!
---------------------------------------------------
Sang Truong Tan=20

Department of Electronics
HCMC University of Technology
Phone: (+84) 977 600 563 or (+84) 908 983 574
Email: sang.tts.designer@gmail.com

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Monday, March 27, 2023 2:17 PM
To: sang.tts.designer@gmail.com
Cc: martin.agren@gmail.com; git@vger.kernel.org
Subject: RE: Bug Report with Git Bash

Hi,

FWIW the reason why you see it in your Ubuntu setup is most likely =
rooted in the `/etc/skel/.bashrc` file that contains this:

	# don't put duplicate lines or lines starting with space in the =
history.
	# See bash(1) for more options
	HISTCONTROL=3Dignoreboth

Ciao,
Johannes

On Sun, 19 Mar 2023, sang.tts.designer@gmail.com wrote:

> Dear Martin,
> What a very quick response!
> I just tried your recommendation, and it works.
> There is no word that can explain my appreciation, to be honest!
> Thanks a million.
>
> --
> Thanks and Best Regards!
> ---------------------------------------------------
> Sang Truong Tan
>
> Department of Electronics
> HCMC University of Technology
> Phone: (+84) 977 600 563 or (+84) 908 983 574
> Email: mailto:sang.tts.designer@gmail.com
>
> From: Martin =C3=85gren <mailto:martin.agren@gmail.com>
> Sent: Sunday, March 19, 2023 7:28 PM
> To: mailto:sang.tts.designer@gmail.com
> Cc: mailto:git@vger.kernel.org
> Subject: Re: Bug Report with Git Bash
>
> Hi,
>
> On Sunday, 19 March 2023, <mailto:sang.tts.designer@gmail.com> wrote:
> This is a relatively simple bug. when we double-type a command, like =
'ls'.
> However, in the Ubuntu environment, the command only occurs once when=20
> we press the top arrow to use the prior command.
> It is identical when using git bash.
> Repeat these steps:
> Type "ls: in git bash.
> 2. Type "ls" once more.
> 3. To return to the previous command, use the top arrow.
> As you can see, the number of times we type the can command 'ls' does=20
> not matter; it only needs to occur once.
>
> This depends on how your shell is configured.
>
> Look into HISTCONTROL and ignoredups.
>
> You might want something like
>
>   export HISTCONTROL=3Dignoredups
>
> in ~/.bashrc.
>
> Martin
>
>

