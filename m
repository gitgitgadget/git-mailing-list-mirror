Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC7ECAAD3
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiIESuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIESuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 14:50:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395AE614C
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 11:50:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q21so4709729edc.9
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=39NBr4GsO7NL6A3snae8PTXW6fXl3DeIMlxSNoJxFKk=;
        b=kNdnYSJZ2n4Uc19JZ0CQqf06FR/pN9s53FyN0LBbaHp7qU1o159B2/XRimY0T1iHNl
         3fR1LU1tYwK6a0z0/Ot4sysp7HXSc4xLcMI/3IufjQj12YN5pn5f6T7aBjnp5QfccXd/
         gbh8zbhqll8oEY/TYNFxl2dGoZnRdh2Efiv1FCiR3PGCysQKZEcRR/KxQAMSDawSEwvJ
         ACKpLnSbwlV90XdMGTsxnQKpEA6FdQvNdXIWbkfpfiJnwxeaO41AkGO6yAcNqW5AzgOb
         OIGi65QPNxv6gEtMsxmkHxkiBWY4Hi4DqfmY81iOH50oroysDsVDKjDRXI+gNdxsdpzk
         d2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=39NBr4GsO7NL6A3snae8PTXW6fXl3DeIMlxSNoJxFKk=;
        b=hWemrxxrw07FIc1GlqBLfUwHvNy2Fp7qNQvWhCH3UAIEmwDvonTTnV+ranLRB51J+d
         gnstZ0Vz/zo7k+Zi6/kZ4Ut4DPwtsfJnykYfv04c4MylrB0gKq4gW9MwGGWygoIp1piQ
         YfIMkH0olDQCAT5thQYdt74fCX6xFieChdS8g+3v1AXhsImKyNk2V0OwIPwEwcGO3O00
         b+JJI+YizFm3HNAB4pC7xb4xeREm1L6jxgBH3u3h8XZa98GPDF1czmv3dGmM82z4486O
         44tkPp9AQqI9BUgIlRjXF/7dPuxJSgWuICmSW2hatwt0ggZfVbi8G7fqpdyQLgoTulgI
         XX1Q==
X-Gm-Message-State: ACgBeo2cgYCIRMBIhcV2WT7h6xjLr7/vOvuf3KULryXW2CuNQjvitMg9
        XnhJgfMjVAjOyhE62qzvpbMxDw5SpfI=
X-Google-Smtp-Source: AA6agR5BgOK9aRK13MBzlcOIQIF5aBvlGlRZWtUJOW7utpy5xwfZe9UqUDWfN/oUYZ490UU8e+YRYg==
X-Received: by 2002:a05:6402:198:b0:442:da5a:6716 with SMTP id r24-20020a056402019800b00442da5a6716mr44009583edv.5.1662403810665;
        Mon, 05 Sep 2022 11:50:10 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0073d83f80b05sm5391843ejh.94.2022.09.05.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 11:50:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] parse-options: minor cleanups for handling subcommands
Date:   Mon,  5 Sep 2022 20:50:02 +0200
Message-Id: <20220905185007.9042-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.3.989.g4c3dfb3304
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I still wanted to make a few minor cleanups after v2 of
'sg/parse-options-subcommand', but while I got distracted with some
Coccinelle stuff that topic got merged to 'next', and it's now in
'master'.  Oh, well.

So here are those cleanups on top of that topic (or on top of 'master').

The changes really are minor: the first four patches shouldn't alter
behavior in any way, and even the last one touches only two error
messages.

SZEDER Gábor (5):
  t0040-parse-options: remove leftover debugging
  test-parse-options.c: don't use for loop initial declaration
  test-parse-options.c: fix style of comparison with zero
  notes: simplify default operation mode arguments check
  notes, remote: show unknown subcommands between `'

 builtin/notes.c               | 11 +++++++----
 builtin/remote.c              |  2 +-
 t/helper/test-parse-options.c |  7 ++++---
 t/t0040-parse-options.sh      |  2 --
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.37.3.989.g4c3dfb3304

