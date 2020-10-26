Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C22C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD0E241A4
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 16:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5vRxAgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785026AbgJZQJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:09:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442617AbgJZQJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 12:09:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id c16so13062382wmd.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BzHqeIaje/9NgWoQzfnCB0Cf8V+EDxxjE2CX02YpXFA=;
        b=k5vRxAgq9a/itl3s5BMdCvOfkvNwdR9dgJZV0WmOPrBBWUcWtgpsy77XeuU9PX3wcO
         9Vo+pCrD3byCBFD/5q4XpRsQweTDACqeMubn7UTfrldMcUrWxkV2qJFhW/cR5XcIHjze
         Z/zL7AH/vFh8S6AihBtGEJcfnLYze/rSA1sz3097pm3oqYLAncNT8CCy3MJDJLhxHJe8
         ffk60ojljktUSQW2C//HWExO2WqjFVa5COt4lqE4ggNN8XOHqRQhfkAkSx0vuFqozbM7
         mmsltm1GOlc1rQjnpSi42CS5Of3e4gQUWmNtIICw/9obPyLvwtmu7XfRpfKb/BtZ40jj
         WHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BzHqeIaje/9NgWoQzfnCB0Cf8V+EDxxjE2CX02YpXFA=;
        b=aVcG0amrSK3+d3yFBAWFthB/6BIdl2kGV1mp3aKq2XwO//DbsXaL+BZZI5qk6vkcRB
         CNPkuJLn+fZclEq48Uz2IYeK2fVMYSUhmzmLiO+wehGbkf4EYAhox+CSU3/iIVp2wXII
         gwTiujdMWHxwAfV42QGksQ6o5n/6MtGJUcMmWtz/StssFaUFjoTzoz+wAyCQW/GgosVb
         sp/uo9MMbntQjOusJ+WiB5YV6K/6O5wQHPCxIphCYVQmPHCSl8BcpEDJ8FbjaG2C2MnZ
         BVl+pCXaf8H3U6IP/OEi8YP7xJr75EpG6/QTeV63JZfvG1mo8IfN8r/50UNBI8WsIdnG
         rzpQ==
X-Gm-Message-State: AOAM532K8osdNwoQoqBqqMuYJ0gWl6ThCJr+n6rOKX5lyf4E2i76Wy9N
        hZgC/qIJbgp5uirB4Nib4mCo4SrD7dg=
X-Google-Smtp-Source: ABdhPJwdzR6WTLjj5l15Jx+fRTYR5q21iFTRfxDNCAv9surXXFkkdHsNUSEXERHgwd/QEid+EsS6kw==
X-Received: by 2002:a1c:6143:: with SMTP id v64mr7684707wmb.108.1603728556869;
        Mon, 26 Oct 2020 09:09:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm19982201wmi.21.2020.10.26.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:09:16 -0700 (PDT)
Message-Id: <pull.753.v3.git.1603728555.gitgitgadget@gmail.com>
In-Reply-To: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
References: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 16:09:13 +0000
Subject: [PATCH v3 0/2] Work around flakiness in t5500.43
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems that this test became flaky only recently, although I have to admit
that I have no idea why: the involved code does not seem to have changed
recently at all. It should have been fixed by 
https://lore.kernel.org/git/20200506220741.71021-1-jonathantanmy@google.com/
, but apparently wasn't completely fixed, despite what I said in that
thread.

Changes since v2:

 * Dropped patch 3/3 because it was only intended to be defensive
   programming, but turned out to be too hard without layering violations.

Changes since v1:

 * Instead of papering over the underlying cause, the patch was completely
   changed to actually fix the bug and add a proper regression test for it
   (originally, I wanted to act according to the common notion that good
   programmers are lazy, oh my, see how well that worked out for me).
 * We now specifically watch out for future bugs where incomplete sideband
   messages would be dropped inadvertently rather than being reported at EOF
   or at encountering a flush/error packet.
 * Before sending 0-length data to demultiplex_sideband(), we now make sure
   that it is not marked as a data packet; Otherwise we now complain loudly
   about a bug.

Johannes Schindelin (2):
  sideband: avoid reporting incomplete sideband messages
  sideband: report unhandled incomplete sideband messages as bugs

 pkt-line.c               |  3 +++
 sideband.c               |  2 +-
 t/helper/test-pkt-line.c | 23 +++++++++++++++++++++++
 t/t0070-fundamental.sh   |  6 ++++++
 4 files changed, 33 insertions(+), 1 deletion(-)


base-commit: d4a392452e292ff924e79ec8458611c0f679d6d4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-753%2Fdscho%2Funflake-t5500.43-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-753/dscho/unflake-t5500.43-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/753

Range-diff vs v2:

 1:  e4ba96358b = 1:  e4ba96358b sideband: avoid reporting incomplete sideband messages
 2:  9ffcc5b78e = 2:  9ffcc5b78e sideband: report unhandled incomplete sideband messages as bugs
 3:  c61e560451 < -:  ---------- sideband: add defense against packets missing a band designator

-- 
gitgitgadget
