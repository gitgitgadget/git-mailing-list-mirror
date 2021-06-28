Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD699C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 12:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D87461C69
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 12:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhF1MUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1MUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 08:20:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C983C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 05:17:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g198so3355533wme.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=v55LN7IBGP5NAWg0YLaNZsAulXiJ7GYMZwJ8+I3Sc2s=;
        b=lWv6CuBLHTkhRWPjU8eLpUAvX1wcr2dYWVXbz4Kq6ZTCeBKHi7XnRxK3GEQO6Get67
         Z5I7UPKmWqr7BFNFp9k2HST6AKeRFMraHC1Cij5VirJrTZgO12xMDeUXogEXY4o9PjzX
         aGk9RB3eQPUPJhG++BUcab/ITphizU03LEhzH9sFbvZfgiBkmKsIxc3oL9R67URnCEPj
         A7wGzI8RibGHuZS5BBX7tWl0RrnGp20jfLCekRjxt/IXEuDJKZ3ILFyjEGrNJWMt/T0w
         mN4gNsVsCkk5Gs/qVd7i14TfheWdzPDMDl3EPDJ88C/MExp9GfCqOEKnd6VQTRixh5kA
         ns5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=v55LN7IBGP5NAWg0YLaNZsAulXiJ7GYMZwJ8+I3Sc2s=;
        b=n3+ff666D588x6Ms4B6tpeTpgPaAMcuyMZvlTMLfoJIxUuWw+R++1+czpguBcYcF+y
         wM0KcCLHQ1Ynv0iq6h3MMA1O8ygIMo58ZtxPsxzxabZ3qU4AU9QkePNElPPT2PuNR+U3
         Ks4Obt8H1tv7xrYFbSO1aaloiT1Y5YcE6raYpVTK/34P2LytYA0DPupwE/uh+heacVWe
         QkbcNZjALNOrKF/itg+w1WltDkGHVDCq68mYDyR+xTF3scH2CYajK0/5yeW6D0bjdvcv
         Kj33/w6d1J4T78O9NNiBKKqM6ao7rYs3By1CH78DGwFfpeAcHogMPi7Ysbq0LIaQOAkc
         NcXQ==
X-Gm-Message-State: AOAM532MlcnTN5AYq9EpQQt1mOGb27nttuiEriaZpvTz7ep/NDYnMcPC
        ZKKd9V7P1LDxfIV69nwRGabX6+mWshvE3A==
X-Google-Smtp-Source: ABdhPJxSiBXBNwoyJC1zIe5BLfRT7W+Zx0ZFmBcqsyOuKGarh2rcna12lZyDHAprDJhI5FjzoNf/WQ==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr25564879wmq.140.1624882670514;
        Mon, 28 Jun 2021 05:17:50 -0700 (PDT)
Received: from debianXPS.lan ([193.32.126.215])
        by smtp.gmail.com with ESMTPSA id h46sm16049065wrh.44.2021.06.28.05.17.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:17:49 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:17:48 +0100
From:   Matthew Hughes <matthewhughes934@gmail.com>
To:     git@vger.kernel.org
Subject: segfault on invalid 'git grep' invocation
Message-ID: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It's my first time writing to this mailing list, so apologies in advance
for any mistakes/faux pas.

Summary
=======

Segfault seen when running:

    $ ./git grep --and -e 'pattern' -- not_a_path

Expected Behaviour
==================

The above invocation doesn't appear particularly valid to me, I
accidentally ran it while editing a command. Not sure if this needs
addressing, but perhaps the expected behaviour would be an error message
about it not being valid?

Compare with, running without '--':

    $ ./git grep --and -e 'pattern' not_a_path
    fatal: ambiguous argument 'not_a_path': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

Running with a valid path:

    $ ./git grep --and -e 'pattern' -- common-main.c
    fatal: Not a valid grep expression

    $ ./git grep --and -e 'pattern' common-main.c
    fatal: Not a valid grep expression


Background
==========

git version:
git version 2.32.0.93.g670b81a890
cpu: x86_64
built from commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64
compiler info: gnuc: 8.3
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash

Also reproduced on git 2.20.1 (packaged version on Debian 10)

The segfault is raised at free_pattern_expr (x=0x0) at grep.c:825 (on
commit 670b81a890388c60b7032a4f5b879f2ece8c4558)

Regards,
Matt
