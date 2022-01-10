Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C12C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiAJWIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240591AbiAJWIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 17:08:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3EDC061748
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l25so18564112wrb.13
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtyT5IHjYpNCVyi4eU30DuzKw0U73tUQycBlXwftPnA=;
        b=JRSDsL+QTiRsKL1P/O+d/IHAfRIeV4+UqC4UMWOUptWoJE1bVsIbRsV6gsmPYfLQVn
         K508FGTl/Sr0R4cnmb3oXFjxh8rsxzgcc96wgYfg29qDtDODv0clET/KjVNzWNETS30T
         T4v1kAXi7fLr161+Z5uucWVL350rL0AL64gLxXJxMmuj5+UgGd4m76WpnV//NU6fikuE
         9oXc6Q4SxVHZhHVG7YZW5yNM0UXXONyO3C8Tx5zEriQ0beIuLCyx149ykDPyWFOdw7Fn
         Lo13WqOAOzkklC0X4/Vnvqr7+LDWh008x31A3dMXequZ3Qv10tNUODnXXnV3ow+h/0Hx
         viuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtyT5IHjYpNCVyi4eU30DuzKw0U73tUQycBlXwftPnA=;
        b=mNVQkv6ARf1uEBWANdv2HQxiEVOWijdcC15BiQa16wsvo7AZdNuXcCdnaoHH6McZ7d
         VSScbVo6IDDtAuTaCseVjawzei+9o5SkHO4fKyzzHi3G0XWkfL6w3nXZXAqd0LoZYEZi
         xzBa0aq9GtvO8d6lnnxhoOCJXrbV/4791WpiLSaCuABSk/a2Dntp5vc6lm1l517w1ImF
         HZhJgdmzzcTHyI7R/SPK1fPGhpi3Uj+IeIE9nWiD7jZ9Nv2jPfgode1lg99IoU+IhlEq
         zUl1ZrG5ygnckNd7jCr7jafrsmDh/Dvfhn+3bsBmprxC3fDEgIurKwFq1xeSKmRubGPz
         bOfA==
X-Gm-Message-State: AOAM53298df1s/Ix/Eps1tlDLrTWCEwjmmEXsiIpVUf0D5zH9ieP6MsJ
        vSkG9b/PD/nyw7WvIMH1KJ+FawrrK3zDNw==
X-Google-Smtp-Source: ABdhPJxXb0pBXoJkGlZ7TKM6gp2Uz/UAxl76cmHmO10eIdTESoJw958D9xaj8Sa0+sr3AYRyNGfYhQ==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr1310051wrs.61.1641852530771;
        Mon, 10 Jan 2022 14:08:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm84432wmr.30.2022.01.10.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:08:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] fixups for issues in next-merged ab/cat-file
Date:   Mon, 10 Jan 2022 23:08:44 +0100
Message-Id: <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1373.g062f5534af2
In-Reply-To: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series goes on top of ab/cat-file, which was merged to next in
e145efa6059 (Merge branch 'ab/cat-file' into next, 2022-01-05).

The first commit addresses an issue Jiang Xin raised in
https://lore.kernel.org/git/CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com/

The second fixes a typo of mine when referring to an option name that
I spotted while preparing this.

Ævar Arnfjörð Bjarmason (2):
  cat-file: don't whitespace-pad "(...)" in SYNOPSIS and usage output
  cat-file: s/_/-/ in typo'd usage_msg_optf() message

 Documentation/git-cat-file.txt | 4 ++--
 builtin/cat-file.c             | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1.1373.g062f5534af2

