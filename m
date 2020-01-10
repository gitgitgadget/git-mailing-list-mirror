Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9530C33CA2
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA4E2072A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 12:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBButC8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgAJMMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:12:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45256 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgAJMMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 07:12:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so1308516edw.12
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 04:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uvj6nsQbSkX/efbdMaNiFTZSWprUFKZVxiDO5QF29U=;
        b=jBButC8MoEK93lH+VkKT8DZyPy3syBMcL+sG++WBw09OOt/f9UVpVdQZZLRmvj1AMa
         hNAlzYRQe4qhDEwl5ufB4ckBTEqWbi5CTE25rC+nkFgGUti0ZL5JYHNNrjj8AIDs7ZPc
         zSKNimogcLcnJJpV1a/DjGT2HlukOr22DzxJa3yRzqNVBZMmLM//Yu7WPid2D/vnic5Z
         oT7Eg7Gc3hpsq7MN+Kq0eX45cvtqOzcpD0Aq+JV1uKltFAfjC/s49VGCiC6ce2OSqeXO
         k2HWm/xsZtd3GvOeO8rp5lKWCg2plueLPD8l9ehumEbZdeHbQ04ltpMBXfkGUnNfMRNn
         sCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uvj6nsQbSkX/efbdMaNiFTZSWprUFKZVxiDO5QF29U=;
        b=IByhBpPXDfGvPI3MAfWJUp1pFBI1GkhDNddSXPYiF7x/SObg+yXOGT2pMYifVmzMen
         yI5AjEcYo/FXeitsowMEKKOmSzWsWOCh6VD8oeGxP68NPdtxvqR+7fmusNeh8BX/Tcqc
         fw9ssBz8g5YAZlLKwEJ06MuSyDLnes9kIS0sxL4MalcQIKs10apOTQJ3ljKmf0CD0h3i
         Jj8i5Enr26taxTO+bLsi5dwHadBMuxSrwpYgRfW4KuDamcwkQx9T9bOtqSJmUzBpDvIm
         NxNOj3RzKFwfOh1h73FMfIaiyljh0NUhtbY3OU3gus5acb1o7odcP38iGf0bnc0YBe0j
         qi0Q==
X-Gm-Message-State: APjAAAVejEMJF7eVCkfx43ltpC5r+LOmkmS+ho0b3ovBsuI1AkFKuzmi
        zAnBduS1jmgbX41mWs8wHCl+8297m3kDppsffo4=
X-Google-Smtp-Source: APXvYqzZ5cObwVcvdzW+GG4gECMofowdQpn4DBBtCY6kupTQiDR/GRqDw7LzXOf41cOsfDrnf4ekY2RtHJ9/2MgBufY=
X-Received: by 2002:a17:906:b2d1:: with SMTP id cf17mr2910267ejb.192.1578658328135;
 Fri, 10 Jan 2020 04:12:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
 <pull.507.v2.git.1578370226.gitgitgadget@gmail.com> <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
 <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
 <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com>
 <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
 <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001081945490.46@tvgsbejvaqbjf.bet> <xmqqsgkp220d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgkp220d.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 11 Jan 2020 01:11:57 +1300
Message-ID: <CACg5j271GjTqt-VBrtxsdssj7X5hJOV8f2xgufgV05Zn8eXsGw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different
 branch before deleting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 9, 2020 at 8:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > This is the first time I hear about anybody wanting to disable any advice
> > ...
> > I don't really think that this is desired, though.
>
> Me neither.  We seem to have come up with more-or-less the same
> illustration, but such a global "turn all off" needs to be explained
> very well before we let users blindly use it, I think.

Thank you Dscho and Junio.
