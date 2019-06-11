Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD611F462
	for <e@80x24.org>; Tue, 11 Jun 2019 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389894AbfFKNDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 09:03:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53336 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbfFKNDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 09:03:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so2868718wmj.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJuNfjApwUYB3shI6THaG0Hd3mxd+FpkhlO0I4VxjkQ=;
        b=RGkZDjDyPIyVxrSLQtgNxbSSt7ZtUfVQLvqeaIq2wf447V41hB98XRDjSy/5OIOAny
         /NxgXN5ZOnsrO+75/MbL8D/Kdh5krSvgwmdnaEEAfOmKSUkYbhAGRPOGNuQXFidNhkAe
         slIcJoNimmw6jjs3yU/dCWr3sFwuMJvwqKcGltNJpacteVrJsRX0wFN7FIsIITSSdVTR
         HjddasvBxUp/vLX2IfUkckC4AgDWWXeqwTFrK3WkzzMtRoRuE5+MwbcxHbmff5sMDV/T
         N3J75jqRPej3mrfk06FGIkbwSHfEVoTQ+pMGKf00K5VmGHREuJalxU34qUKDG7RJTExX
         nPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJuNfjApwUYB3shI6THaG0Hd3mxd+FpkhlO0I4VxjkQ=;
        b=Wws7N4I/CFuINp0caz9IryYQvqrD39sYKXScKbCEcouwRtxJiDpnBj3yJh/47exUD6
         ntxujn7B0pisuXy4M/6nXzwgpD68ma8V1OLOPi7MpjVOnSmDxt7cgfiFUGZMr+TzRVYj
         1qIy5HU2WNIjuD6any+57zoyyJPUGLd9u3lcmGRWTeHqT6mv9uo8RT8wvMbSLBey+Z78
         8oEc+e15c5D8dgbphIftVk1Zp3TBOCVkp2hxpNDYyyO+u5la+IFinPmHEylw9UQM4Fdq
         0MmocOtyvl4asxzA2QpxthMNKLRg87oX0xXMs+eZSrmECKajyqiepi+kF83/g6BdlP3e
         XlMQ==
X-Gm-Message-State: APjAAAXrzXaedhBPFMQNrC9bx+DPgsMi47jS3w74XZjc9D3KZCa98vyS
        ssGtCUC3//OKU/KJMY8eksAKmDpA
X-Google-Smtp-Source: APXvYqwmyryYJ1QZxLDQUhDmuo2mYSbSRCH8NY/qrSvIYa6snxaBMvYvd5NttyHBJDAnOPxYPoUHYw==
X-Received: by 2002:a1c:305:: with SMTP id 5mr18481806wmd.101.1560258216587;
        Tue, 11 Jun 2019 06:03:36 -0700 (PDT)
Received: from localhost.localdomain (x4d0cbedf.dyn.telefonica.de. [77.12.190.223])
        by smtp.gmail.com with ESMTPSA id l190sm2561524wml.16.2019.06.11.06.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jun 2019 06:03:35 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/4] rebase/progress: add and use term_clear_line()
Date:   Tue, 11 Jun 2019 15:03:16 +0200
Message-Id: <20190611130320.18499-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.566.g58873a45ff
In-Reply-To: <20190430142556.20921-1-szeder.dev@gmail.com>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reworked/extended version of the single patch "rebase: fix
garbled progress display with '-x'" at:

  https://public-inbox.org/git/20190430142556.20921-1-szeder.dev@gmail.com/T/#u

Changes:

  - Add a helper function to clear the whole line on the terminal,
    using an ANSI escape sequence on capable terminals and a
    terminal-width worth of spaces on dumb terminals.

  - Use this helper when fixing rebase's garbled progress display with
    '-x'.

  - Use this helper in progress.c:display() as well to get rid of
    quite some arithmetic that made a -rc-phase bugfix necessary.

I don't really like the necessary adjustments to the tests in patches
3 and 4, though.


SZEDER Gábor (4):
  t3404-rebase-interactive: use the 'q_to_cr' helper
  pager: add a helper function to clear the last line in the terminal
  rebase: fix garbled progress display with '-x'
  progress: use term_clear_line()

 cache.h                       |  1 +
 editor.c                      |  6 +++---
 pager.c                       | 20 ++++++++++++++++++++
 progress.c                    | 28 +++++++++++-----------------
 sequencer.c                   | 17 ++++++++++++++---
 t/t3404-rebase-interactive.sh | 15 +++------------
 t/t3420-rebase-autostash.sh   |  4 ++--
 t/t5541-http-push-smart.sh    |  6 +++---
 8 files changed, 57 insertions(+), 40 deletions(-)

-- 
2.22.0.566.g58873a45ff

