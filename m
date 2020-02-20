Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630ABC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685B24654
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew3jT0xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBTJQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:16:29 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:42082 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 04:16:29 -0500
Received: by mail-pf1-f181.google.com with SMTP id 4so1614535pfz.9
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 01:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7cdRMw1bJwKteRE9xnUyhu4vyBNAEmcSCSJmds4XQwE=;
        b=ew3jT0xkh4bW31OtIm406UZKMvhCovLulCK4EdECEZkjNuONDbrNNB8wsIimFzLT6I
         +w844kOGarAk2ssC0k1c3VGURgzukZGW0XBiOgz9Bc3xiqNmKIIhVEqfnvPDYCW1ysRA
         +e6d+5Y8DEdOZc54d5Cwn9XSZN6wgpfaYaN2XXIdDuafWdY9W0ruC0D/WgUZE/FSRhr/
         2SCqYV0SOjuHt4ZB7M6Pjku/ICbyJymRYXmhwOu7hN33jS41GyFWoHfW1v2MJ26RzDAE
         jeUWAmwcMi13Zk3hXtEYgIXrfUXarZDXqqwImcYB6+KSHTnl8dACnaYV4e0LioNIKzFA
         DkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7cdRMw1bJwKteRE9xnUyhu4vyBNAEmcSCSJmds4XQwE=;
        b=cmaKKuT6qm8j4t1pcEjAamzb8km0HKcm8FboxpAFWl11AFBE8M/dKGbylwnQIDeF1n
         +24xJkBwpogII5kGOgYSmr8+UYidJ6E6/IcoS9qJJuLnQSfC8cKzmOC1jw6P/gs8gHYJ
         spU7hdvphvIZQCagqIuCpPYG5F1MKVWORm5JGC40cGuyoZX/z+kvFjoqPKCmW/MelmVo
         SsD5XeBNN2ZH80wO5Rx43zWhTKZHg2MGTsvIzbGaYBRbZk+CAb2JLfwKFWDBKC92ReKA
         ScNkIfK/twv0JD2czTEuk1ndJ8HsUYXrfb+nOek+gHg4tjdSVm7jAtxPUTOLfHBTYrAU
         PKiw==
X-Gm-Message-State: APjAAAXEDFeRgpuW0aJqrBj/wRVG/CnYJ/qr1N51DIX0I3nEwAJrXRz3
        8cs1FOR2WFCPYTN5N9huhViVjeIVJJg=
X-Google-Smtp-Source: APXvYqwoe1x3iTEQKUkYIJZWgXAYF9IvOcW4FkNwFOxaV6v1x38AssiNJb+WxD+/eSQNCBml0HQu4A==
X-Received: by 2002:a62:820c:: with SMTP id w12mr9193953pfd.92.1582190188554;
        Thu, 20 Feb 2020 01:16:28 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.107])
        by smtp.gmail.com with ESMTPSA id c8sm2745381pgq.30.2020.02.20.01.16.26
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 01:16:27 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC PATCH v2 0/2] Consolidate test_cmp_graph logic
Date:   Thu, 20 Feb 2020 14:45:26 +0530
Message-Id: <20200220091528.28472-1-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
- Arrange patches on functions changed, rather than files changed.
- Use specialized helper functions calling library functions.
- Fix SP and other style issues.

I would like to thank Junio for his suggestions - Really cut down on the
needless changes.

Closes gitgitgadget issue #471.

Abhishek Kumar (2):
  lib-log-graph: consolidate test_cmp_graph logic
  lib-log-graph: consolidate colored graph cmp logic

 t/lib-log-graph.sh           | 28 ++++++++++++
 t/t3430-rebase-merges.sh     |  5 +--
 t/t4202-log.sh               | 57 +++++++------------------
 t/t4214-log-graph-octopus.sh | 82 ++++++++++++------------------------
 t/t4215-log-skewed-merges.sh |  9 ++--
 5 files changed, 74 insertions(+), 107 deletions(-)
 create mode 100755 t/lib-log-graph.sh

-- 
2.25.0

