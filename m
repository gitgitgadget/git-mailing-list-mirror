Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C423AC28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 06:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EA321775
	for <git@archiver.kernel.org>; Sat,  9 May 2020 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNcKC1mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgEIGTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 02:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgEIGTt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 02:19:49 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB783C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 23:19:49 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x7so9592102oic.3
        for <git@vger.kernel.org>; Fri, 08 May 2020 23:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JfTV00k+/LoMJWPMjpEVRXkUhV0k9NULj2NWFuVYo88=;
        b=MNcKC1mUsW8avmT4PN76LMqmPWTZRXuxmtERyWGrf+0UVkMvThuS15moAGhOiL2NIu
         or32L/F0+vMPwDU4qRBo59iZ/+KwHl3AWdi3PcfjKUunUC4Qu47tc1HRfoavujm/P1Dy
         90NeoRNQ/Yc8hBbrvRiqPfO63aKUZotCaUz653XFuuj8SCLLcQKhhclr/gS2WxZEaPPc
         J5RU82H+EuCYb+PLQvynz2Ggiqw1fkvV4g6LfmSP0JVYlRR6j62ECGxL/uNAxc+rxHRR
         L0x+/glxtlBFQ2jSeIU5XiEM9VQah7PwJ73cApVEEniPzx14CEvt2Rzr5RQoTH+9EnZA
         8gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JfTV00k+/LoMJWPMjpEVRXkUhV0k9NULj2NWFuVYo88=;
        b=iJJD8FtGUhtkR05+dPG4Ao3LwT5jvmreZmGn94lxubevibZGpygfp/K1KEn/cKyobA
         9cAjwRXBLldr8iFi4eDr20z37LquEDv5T0qnA3wTBn40oGFyVCGkHP0vs1Jl8XMnM5ZF
         f5ceHnx2JBwjtjFXCGiT8zcnTbuSA6U3uWmINi4CznZznwCzK1U/ww3U82kSeYrtC5m5
         WD+6FT2d5WH2Bq5kv1IV2B6Fkh/oL5VUyFysCSVE07Wl4xWD35+0EwAM/LINJIdCoM4Z
         dg2Kf+RRG2eZV1yW4CBTFblDKKNBiK1yvfD13rYxVV5GX/oDGaO9RRyRW2jTqIgTPLXD
         kyOg==
X-Gm-Message-State: AGi0PubSlwQiD9SjkpIhkJ9i0h/mCrFCfQSxnMsOQLIqTDrvyh32Wi1q
        PE1dlhqc5cjyafLK/q2snRaIuwuN17wfd5KKVIfVt1I1
X-Google-Smtp-Source: APiQypLD4S9MiyPwXBMO+1AEFFqHdnlI5GukylZRuSM8R52nZSKkp++ohopdjDt5oKIZ/A2cM7ARixsX8/9AndIjOjc=
X-Received: by 2002:a05:6808:4d5:: with SMTP id a21mr7892739oie.105.1589005188789;
 Fri, 08 May 2020 23:19:48 -0700 (PDT)
MIME-Version: 1.0
From:   Brandon Williams <bwilliamseng@gmail.com>
Date:   Fri, 8 May 2020 23:19:38 -0700
Message-ID: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
Subject: invalid tree and commit object
To:     git <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!

Its been a minute since I've written to the list but I was recently looking
into the rules fsck uses to identify valid or invalid objects and I believe I
found a case that I believe fsck is currently missing. One of the things fsck
looks for when validating a tree object is that it doesn't contain any
duplicate entries. It even has a nice comment about how `git-write-tree` used
to write out trees with duplicate entries:

    /*
     * git-write-tree used to write out a nonsense tree that has
     * entries with the same name, one blob and one tree.  Make
     * sure we do not have duplicate entries.
     */

Here's the setup:
    tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
    tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
    blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689

    $ git ls-tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
    100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello
    100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello.c
    040000 tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6    hello

    $ git ls-tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
    100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello

    # '%' here indicates that there is no newline at the end of the object
    $ git cat-file blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
    Hello World%

fsck currently passes when being passed these objects despite c63d067eae having
a duplicate entry. This seems to be due to the duplicate entry check in
`fsck_tree` only checking if adjacent entries are duplicates but due to the
sorting rules its unable to realize that there is both a blob and a tree with
the name "hello".

I was even able to produce a commit and push it to Github[1] (which
didn't complain)

    $ git show --pretty=raw 62f1ff6e109f8b77edd7eeb65f6634faa76a93b2
    commit 62f1ff6e109f8b77edd7eeb65f6634faa76a93b2
    tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
    author Brandon Williams <bwilliams.eng@gmail.com> 1589004242 -0700
    committer Brandon Williams <bwilliams.eng@gmail.com> 1589004242 -0700

        hello

Checking out that commit leaves your working directory in a somewhat
broken and 'unclean' state (although Github's UI seems to be able to handle
displaying it properly).

Am I correct in assuming that this object is indeed invalid and should be
rejected by fsck?

-Brandon

[1]: https://github.com/bmwill/invalid-commit
