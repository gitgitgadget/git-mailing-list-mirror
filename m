Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB973C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B6B21D56
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bibMzlAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRESU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:18:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37811 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRESU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 23:18:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so22201743wru.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 20:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Rraq5u/38YkLDGtiWS5Y/qILocIaluOxERzjQTQjfD4=;
        b=bibMzlAeNKRvcXNQLE/C0w0KeG8lJpq03m5wm8SjRUn+JNRtsPDFCqudexcd+CzlML
         FoWnweWUA9/WqX2p/1Y8Bj3aL+KL4iIIaPZ8WChmn8uGCqpaR/vbLJ8DvmoDx4fUHeMU
         t17+/4TF0rOnYDlZ45hT4ta1ICLT5lpWZS/QeqnjTeSKRUT8A4oRwMURJfQJN6ETJwbB
         0S4igGoS01WYo74AcwnDdbN9Pqsll6hvMKKutAHdK1I+WLY+P/p5c/yhmWQba4yZmkG3
         9Av7KdTHorhXrh8PGLmDYt+MO2hcYm14Y3Yn+/oxmRQiRrlO90fA/dAuew/P6XTHgvAp
         A9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Rraq5u/38YkLDGtiWS5Y/qILocIaluOxERzjQTQjfD4=;
        b=ZEjZSqhptL/LbBn35Hhm/z0GmZVYBtXa3wQC1JlwWj+WTMIu3+4osfUK5+g8b33VDQ
         vvvVpMAYJ92Wxdi/Mi18Z+IKAr7ZxMqDkCiBZQtad2hWLl2Lm8wsuIOwNhT3PrKPCXdW
         8ND7cL6VcMv0AVUzrdLaq9TOQ5nIr+HzCgvN+6P54XftjRwYGpxdTWwlL1Zu+mxWKPb5
         H98I57XH8oyjSCnPNgSqVxD9HVvRVm1/0///0A3DAt2S3izgGyoHibSmNl5CkuNODjDP
         1qdQDzQFRTeSx10LkHNjKinAHgnf41oGOdV3NYaLp8zrCbfeuDNd+WG3+ZcvvIxyXAgw
         El6g==
X-Gm-Message-State: APjAAAWDIApqyPXvisl8vxJFzN791Llrs/CuB3xNYESeK/sR20Z/OX+2
        HVEy+atkYUOM0syiQS53NkObYZRRY+oY1Q==
X-Google-Smtp-Source: APXvYqzWgs+zfrWZPVgkfBSWCx2byV6aFOhMxc3CqgdBT61+k2wshAmFFNb38rDJ7lWAr4yG8mlEqw==
X-Received: by 2002:adf:f310:: with SMTP id i16mr26770750wro.326.1581999494723;
        Mon, 17 Feb 2020 20:18:14 -0800 (PST)
Received: from localhost.localdomain ([41.234.233.158])
        by smtp.gmail.com with ESMTPSA id k16sm4228083wru.0.2020.02.17.20.18.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 20:18:14 -0800 (PST)
From:   Robear Selwans <rwagih.rw@gmail.com>
X-Google-Original-From: Robear Selwans <robear.selwans@outlook.com>
To:     git@vger.kernel.org
Subject: [GSoC][RFC][PATCH 0/2] STRBUF_INIT_CONST Cover
Date:   Tue, 18 Feb 2020 04:18:03 +0000
Message-Id: <20200218041805.10939-1-robear.selwans@outlook.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added according to the issue opened at [https://github.com/gitgitgadget/git/issues/398]

[Copied directly from the issue description]
> This new way to initialize an strbuf would set buf to the specified
> constant string, the appropriate len = strlen(string), and alloc to 0.
 
> That way, we can initialize strbufs with constant values, only
> allocating memory when/if needed.

Things Done:
	- Added a new way to initialize constant `strbuf`
	- Edited functions that try to edit the `strbuf` to check if it was
	initialized as a constant

Robear Selwans (2):
  STRBUF_INIT_CONST: a new way to initialize strbuf
  STRBUF_INIT_CONST: Adapting strbuf_* functions

 strbuf.c | 25 +++++++++++++++++++++++++
 strbuf.h | 15 +++++++++++++++
 2 files changed, 40 insertions(+)

-- 
2.17.1

