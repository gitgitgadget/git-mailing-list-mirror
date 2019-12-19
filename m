Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE62C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7292465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 22:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="o/TkdXu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSW1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:27:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:47065 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSW1z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 17:27:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so5502965ljc.13
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 14:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOEYVGnk3GzrN5AI4gRT6vErS9WFYtxYMswtoRkjCrU=;
        b=o/TkdXu8BtwUntFiX6dMI0t/y0Hqw5HtFP5yc9d1OL80bC2nvmlNG0BOYn1myegKaM
         CiuL6l4WSRWUxt8/pO29rXObUI6041FkZyNlbgMqeASeXWx4sF5nNiFsXxDmpp+5F4qZ
         PinH60s5NPIuMGK63rUKOje7+pmlD5Atz+euQd7TA1xx2dPhJcyjzZDbIRrhZmdUyypN
         Y/S7gNHH3hXXZsXR2pnHoBpsx3RyOdZoFs35rjweL/hedFk+rkJHA/4XWVC8GNX5TPrL
         Vr9qBlJRmPO/rKsI1Lc+EJBSngfxNehQvcF5Y3VGpb7NgEXNtu1l5F989eMcMR2t9uv7
         f9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOEYVGnk3GzrN5AI4gRT6vErS9WFYtxYMswtoRkjCrU=;
        b=VhSv6V2SEhb79Gd/mmBkK97epZXkCX3BiS922Bgfsnm12R2TiqBC/LYRqu92VyXtlr
         sDeC6WYYh5kcjcb7D3l0b8SJ6O65nn30nANgA9I4QlzFyXWbNvL2kYqMh6WuYm4eP/AQ
         17a4xNiLjVT/Oh+tVvmsMVW9ri2klIFBT83CR3W70j04R7xxXS7atb8Zmi8U2nDF8hz6
         CRE9stcKdcqztuoaYEzDMnD0sIw2ZcKERMFFgBr5iZcclF6sPGSrrhhYIOCC8okcUoyT
         MDVJm7lsU/rpZ7fzgFr/VxrrVe4uy+AEjxfUsoqmaWhkaS6sNYCSRCbo6IYdu2jeD4Wg
         G2LA==
X-Gm-Message-State: APjAAAUzqNLBeLkT2k8PFUo2cTG7YWafaXB9aO/szqLNZ5nF1gEPgaIL
        s9MuGuAOEaD5kjRLOFmoQT1f9I5bTr3s1hWYjIZ0CA==
X-Google-Smtp-Source: APXvYqx3irqEtsAUA4EHQa/F6LhnBsrfQJnpaRpizpFN6EPoLKLx6our1VcxD6nzXumhVHI314c/0S4w4sKeeRUAVkM=
X-Received: by 2002:a05:651c:1194:: with SMTP id w20mr7821735ljo.129.1576794473300;
 Thu, 19 Dec 2019 14:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20191114060134.GB10643@sigill.intra.peff.net> <20191114181552.137071-1-jonathantanmy@google.com>
 <20191115041215.GB21654@sigill.intra.peff.net>
In-Reply-To: <20191115041215.GB21654@sigill.intra.peff.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 19 Dec 2019 19:27:42 -0300
Message-ID: <CAHd-oW5qT5LmUd6GTL=O+-yXPmq5Uy9gk3ohL_2r+_K+6UJS3Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] object-store: allow threaded access to object reading
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Peff and Jonathan

Sorry for the delay in re-rolling this series, it was a very busy end
of semester. But I finally completed my degree and had time to get
back to it :)

I tried the rwlock approach, but there were some subtle difficulties.
For example, we should hold the lock in write mode when free()-ing the
window, and thus, the lock couldn't be declared inside the struct
pack_window.

Also, it seemed that protecting the window reading at git_inflate()
wouldn't be enough: suppose a thread has just read from a window in
git_inflate() (holding the rwlock) and is now waiting for the
obj_read_mutex to continue its object reading operation. If another
thread (that already has the obj_read_mutex) acquires the rwlock in
sequence, it could free() the said window. It might not sound like a
problem since the first thread has already finished reading from it.
But since a pointer to the window would still be in the first thread's
stack as a window cursor, it could be later passed down to use_pack()
leading to a segfault. I couldn't come up with a solution for this
yet.

However, re-inspecting the code, it seemed to me that we might already
have a thread-safe mechanism. The window disposal operations (at
close_pack_windows() and unuse_one_window()) are only performed if
window.inuse_cnt == 0. So as a thread which reads from the window will
also previously increment its inuse_cnt, wouldn't the reading
operation be already protected?

Another concern would be close_pack_fd(), which can close packs even
with in-use windows. However, as the mmap docs[1] says: "closing the
file descriptor does not unmap the region".

Finally, we also considered reprepare_packed_git() as a possible
conflicting operation. But the function called by it to handle
packfile opening, prepare_pack(), won't reopen already available
packs. Therefore, IIUC, it will leave the opened windows intact.

So, aren't perhaps the window readings performed outside the
obj_read_mutex critical section already thread-safe?

Thanks,
Matheus

[1]: https://linux.die.net/man/2/mmap
