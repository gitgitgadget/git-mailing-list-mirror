Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA8CC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 05:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjBOFKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjBOFKH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 00:10:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF5A1D905
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:10:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jk14so577991plb.8
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jr+LUOCXBRv/QWByuLy3K5QWdTp4njBjzU//TfPo18g=;
        b=IN9bbr9CrdYOLraw+8em3DY2R9JMXPWAVNBgitXT/UkTglYw7ikcJPj8A4HZI1F8i5
         2X2Hza5JlxjnMKv+M6ZfdyfSfPHPmNAx6xGxBLyJkHYE9/IVf0awpDrYQr09ZkDFaqMn
         aWRahErU5ExjcMKlFCsjdzfWKiRztutASZ3/wP37A2yJPkCSFJUlk+oAMYlBEkgddcvE
         7tSzRqacs/PVyvgjMuEJd10ICHBPsXTpJwR8Rcp0i6t0+QIxi6srzWrZmmf/4loQUwB5
         B3PNETTLghTAjkypNuNkRXtg3GdlqBkv32f1H5BqwUkYPQjm569NOLVNJONr2eswgl+D
         F3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jr+LUOCXBRv/QWByuLy3K5QWdTp4njBjzU//TfPo18g=;
        b=tqf+HuDLVFaacyP+8Fj+mk5O1oVSztDPUxZJS4Jq01QoXbpj6cAwnVLTW4CqGDreZ/
         Mu4Um/Z3noPmjEGZUxeBgW9opD5SJ7c9+F25ZfhCbKOFs07hG9/ZN4VcCJGZiNB+x8/M
         dbjXVHXrqB+XFGJHoO7vZuX6LQDahLlfM8fYe3KS5xbidgCKDu/UyQXuK0fMkKHChabv
         0+qjW8QNBhgbXuNS98TowrEeM7o2YEBNV41btIOmuYEbgcOlwoLYglL7LnWBRyf5594b
         L1Jwcm7M4q8DBazA+TbjP3BsgMsAUXPHWQmLfkaTRKeJfPnIjDsrQXj+tla28NBGx7HO
         MpHg==
X-Gm-Message-State: AO0yUKXw7NqwrY8gLQ+z9fWHypRSGRfPAmFIx5uB3A8VQof4YOJjBw/z
        4LAHaxvp7JHKaja0eDyiEnBmLxWWaHA=
X-Google-Smtp-Source: AK7set9gcn3IUMuI6U8DRB13zuv9pS3x+kgtSDcImhTbAijckFnEkR6r8pFnm6wcJsrZhTyvbp6fSg==
X-Received: by 2002:a17:90b:4a4a:b0:234:e3f:f53b with SMTP id lb10-20020a17090b4a4a00b002340e3ff53bmr1446614pjb.21.1676437805674;
        Tue, 14 Feb 2023 21:10:05 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090aec0200b00233b5d6b4b5sm459282pjy.16.2023.02.14.21.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:10:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
        <xmqqmt5f535i.fsf@gitster.g>
        <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
        <xmqqwn4j3mhy.fsf@gitster.g>
        <Y+wN0agVK9ZQU/sT@coredump.intra.peff.net>
Date:   Tue, 14 Feb 2023 21:10:04 -0800
In-Reply-To: <Y+wN0agVK9ZQU/sT@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Feb 2023 17:40:17 -0500")
Message-ID: <xmqqsff71plf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It does indeed. I pulled the logic from skip_prefix(), thinking that by
> relying on it I would avoid making a stupid mistake. Oh well. :)
>
> Doing it like this is much more readable:
> ...
> I'll hold on to that (plus an adjustment to the comment below to match,
> and perhaps a test for this negative-match case) for a day or so to give
> anybody else a chance to comment, and then send out a v2 tomorrow.

Thanks, and surely that is very readable.

Alternatively, I think you can just compare refname and rule until
they diverge, without doing any special casing for per-cent on the
rule side inside the loop.

If you do not find any difference, or the byte that differ is not
the per-cent at the beginning of "%.*s" on the rule side, they they
do not match.
