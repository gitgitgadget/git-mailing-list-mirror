Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB77C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3266124F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJDH2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhJDH2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:28:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A7DC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 00:26:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d8so4885440qtd.5
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+D8fiGrX9i1l2k49J8lyAR/HVDzGHORS5HyTUcXTa1w=;
        b=FQbQbqeGa7bii7MXqyYt1llv/J5WbccU1HtDhEDu8289hK1nie/2qXh4YCypP0Nwd4
         GK6Vds+fO5KT2uukGxngZHYVpVOQXsV4bJVJ0nb/y7A7GiRTMdxZah3Frt8+h7r0yPwz
         zZB0RXEwJSLCI53K8G2yDNFQlWgNyiM3rCzpftoBG6d8kwJoQHE4dHWmgpWoJaHIuifz
         nIdrUTT8+Bsy8leG7x0/o2J6TTvZo7sJNOBbbtcqzX8dMfLc7Po6NXlm3f7/wSgBose0
         wq/qBJDHppSm+GC21T3j1dFT8cWzGb1VgbwKjG/cw3qPKmbEWBxcA2HVRqY7kS2+ztKe
         zqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+D8fiGrX9i1l2k49J8lyAR/HVDzGHORS5HyTUcXTa1w=;
        b=AAcDRSJRdjx1LFFsg9knEoXgBRzPqlaVtaGE+G4zii3iBqVspZ99PXcFXznRsZ8Wdf
         /wR69TV2gWy1hvSEGg+qVFjshDuWxrx2d9Ap1q2Qk7bnvT9+Ek9m21fzxrT0r3aZcwDj
         wPRkghybBoieGmScmvsvvxqW+FEtkDe+UIRfxIBwfVFYMt8P5J6B6OL9HX7aLnA+psPY
         yKw6N65T0eyavKef2xvTSGIGrjlV6b9kxEExZV1Re4Nq1gBqpZETcnpADyzShkoDvaHC
         AioguOUkTau4rlfVCQ+G+e7GZFcUgj+1bK5UNN00kqWp4MfERDdeF0a3w8akcGCWYI5j
         8c3Q==
X-Gm-Message-State: AOAM533kesLc6n0Aw3sFMKMgYCTW9ixPSQeJkfm9RaC49rMXGddQr1Hj
        JeA63JOWg1meE7dsKJ6zV5U5cx7g58G7xg==
X-Google-Smtp-Source: ABdhPJwCaXkEZqgoJ8jgFGSnULGX94S/W9dY1SG40YRkg1lMzyLEHijsMIQsKdVb4xS7GDAwrr4JRQ==
X-Received: by 2002:ac8:705b:: with SMTP id y27mr11886009qtm.73.1633332374862;
        Mon, 04 Oct 2021 00:26:14 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a3sm9015330qta.48.2021.10.04.00.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Oct 2021 00:26:14 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/2] protect git from a rogue editor
Date:   Mon,  4 Oct 2021 00:25:58 -0700
Message-Id: <20211004072600.74241-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20211002153654.52443-1-carenas@gmail.com>
References: <20211002153654.52443-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following series, expands git's terminal support to allow for
saving/restoring its settings around an EDITOR call.

The reason why that might be useful has been documented[1] by Windows
users that had found themselves not able to read clearly the messages
printed by git after a commit (or a rebase) when the default EDITOR
failed to reset the terminal settings completely.

It can be useful also in POSIX systems and indeed could be tested there
by forcefully killing vi while doing a commit, and that before this series
will require the user to reset their terminal.

The code has been improved since the RFC and simplified, and has been
tested in Windows 7 x86, and Windows 10 and 11 (x86_64).

[1] https://github.com/microsoft/terminal/issues/10152#issuecomment-932808573

Carlo Marcelo Arenas Belón (2):
  terminal: teach git how to save/restore its terminal settings
  editor: save and reset terminal after calling EDITOR

 compat/terminal.c | 75 ++++++++++++++++++++++++++++++++++++++---------
 compat/terminal.h |  3 ++
 editor.c          |  8 +++++
 3 files changed, 72 insertions(+), 14 deletions(-)

-- 
2.33.0.955.gee03ddbf0e

