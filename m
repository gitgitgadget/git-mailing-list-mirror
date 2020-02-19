Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE06C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7DC2464E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 16:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8E7n1nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSQ7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:59:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33736 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSQ7w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 11:59:52 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so1364058ioh.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 08:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/rnXuTOBXkXu81lt73Bhg+MTdfUMgfI3k2RYvtijh0=;
        b=K8E7n1nJyyqfJnNiVYqw3md1SKXD3z2ttxi8wZepa+AMIWRTuaOn5hurwgB5AYST1m
         3MxSoxC7hx4xykAYDzvyQ2ZIsLQWmFGJm7EAklz4dlysli/uYI+zzRLL5QKutI/qNIu/
         EUDKNzOz7u1/BC9+g3+gKqOYYwTrr0WIk3QiCnBDLwykSn4rWgndM36nInr22HDyOFke
         lqYm/nAo+sJB7ROsk5jGcBAU/lGaK95F2AzcXHeqrpWb+SA0vCJPW5GoFhF/RzU4gyTf
         kfpWsdK8bRghiEktw0+cO+Ud6hG/ATHsfby7kBp4nxqNAaJpp0hdyiGNV/0BHs5/ZSVS
         eJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/rnXuTOBXkXu81lt73Bhg+MTdfUMgfI3k2RYvtijh0=;
        b=fsp27j/kw/ltIgT4vytAUBCVCGLxXmoYSuMkyKCp8RJvPvC801OROzgP3FOJBX6wnX
         +CSQ/ge1V2xFj4PZemAacH/aMWzEzovYSWLk4YIFztvESXAtQIQR0mJevzsNd1Hn9/Zx
         izA8lyXmB0uTyo712+fbLLtpVbA1kH3Kf7E27InjunZWQ1uUCQEoPWoPGGXXFbIlpnkG
         s/VSlMh5Xqjqr0A/KFXiUXxNnk3z8zC1KPTuPGs4jwFtgbtrg9GQnX/cIpNHZkwgjjg5
         1JHyH1JnesuIduZFRkGiqzcFjHaBIHTa2fJtD2QZydwj7j8NfIMFAzCZHm3iC+ilVP9D
         vYBQ==
X-Gm-Message-State: APjAAAWdyCfreEqGdWRg3Bk2iVFk1IG8G5T9vu9Jx1QWwX1mBrflIvZl
        7v6/6B9UneGFKh0i9KieFGonQ9sJaBQeQNAfvho=
X-Google-Smtp-Source: APXvYqzgR0w8wCGYA6kkLrCuUvzhnQdwUc44Gj88W6XSm5zE2kzAM8mTViYs7TLqK6aXo1WvDg0OLqen1fQRAEmIfCU=
X-Received: by 2002:a6b:db11:: with SMTP id t17mr20120692ioc.270.1582131591857;
 Wed, 19 Feb 2020 08:59:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwenn@gmail.com>
Date:   Wed, 19 Feb 2020 17:59:40 +0100
Message-ID: <CAOw_e7abpAwTkb6qKZjbxxw7XrAWdhcANbjAWvRxi1_fT5vSDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 10:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here is what I got from "git am --whitespace=fix" on these five patches.
> Does it match your test application?
>
> Applying: refs.h: clarify reflog iteration order
> Applying: create .git/refs in files-backend.c
> Applying: refs: document how ref_iterator_advance_fn should handle symrefs
> .git/rebase-apply/patch:145: trailing whitespace.
>
> .git/rebase-apply/patch:147: trailing whitespace.
>
> .git/rebase-apply/patch:6544: indent with spaces.
>         left = *destLen;
> .git/rebase-apply/patch:6545: indent with spaces.
>         *destLen = 0;
> .git/rebase-apply/patch:6548: indent with spaces.
>         left = 1;
> warning: squelched 15 whitespace errors


your checker is tripping over code imported from zlib. I added a /*
clang-format off */ comment to avoid reformatting this code. What do
you suggest?


-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
