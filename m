Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D15C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 20:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiBRUxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:53:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 15:53:22 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610D8ADFEE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so16444023wrg.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxTICuMLUozHfGi0FXb4mvO0iYEnoKg20zYWrlnU7vY=;
        b=aTsSo2qJsvYHzzJwGUr2blosQDfsJgbg6+/jDM4pobI+fTNPF4z3HP/yEIbukkeNxe
         CwmcPhsN9KU5v9TwSH1IyP+SSUeS9a2XdqwjD3OiVF2UfRkBlL7VED01yIXwqZKG8Qet
         Qi2MNam6Nd+rFScsz3SYcBVXrRgVVhI4yutvboRCay1twbBE8ZisSwDY769EGybGA3vh
         hGdJNLM6HlQ2cTl/KcqC24eeFvSlr7SvpytTJroy/i9MsCyy7JsqpSFLnn4PeY9E39bR
         z7LkQfMCWT/qru176gfOR1bbhdmU2kmGgD1MEFsZUZIA70FApa+k/GQHk47nWp4n+BWx
         sjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxTICuMLUozHfGi0FXb4mvO0iYEnoKg20zYWrlnU7vY=;
        b=vjfdYs/muEL534+5aSKeaug1W5YViGNZQaeULFaqs6Qv1zY3lyA19e2oJemE1n/fyK
         H0S7vZPEANubtdIGLja+G77kWAkvOuPSWeutPBbMGxCN9CIqUgOY5t6O1GJY4XJeLML9
         GMDfcKEo8p96DM8JmZfyeKQ9asJvLSzl6go6mRsMy/ME0QAiJF9ERqiAB7M623iD2qya
         QOrqKofKJFVTMcNLxKEeGmL4q9rHzOOfKpyzK2m3Sw59bZPi08M3VWVtch8JKIXuhQz9
         jYAmGbMrd3TKkx1AW4BNFC/VY/WoyOmxBVAUlqjj5HU1hYz5nQ3tYk3sBWMO93ovJNWL
         DbjA==
X-Gm-Message-State: AOAM533EyPs0Ldqee55dr7WQVMWnomHxqAW0sD5kpnNpnMezuLxersbW
        lfWnXzTGJFezn3wzkBypVk+DjLzeeH1pIA==
X-Google-Smtp-Source: ABdhPJzSzNoh0sT1aiDgBWAgrJnqvUp9aYSvT3uScqA1skQ4bbYUwAc+bUf3INdFIIfRY1gBhElxYw==
X-Received: by 2002:adf:d082:0:b0:1e3:16e2:d611 with SMTP id y2-20020adfd082000000b001e316e2d611mr7593646wrh.716.1645217583764;
        Fri, 18 Feb 2022 12:53:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm36076143wrr.94.2022.02.18.12.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 12:53:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] hook tests: pre-push test style & test accurace
Date:   Fri, 18 Feb 2022 21:52:57 +0100
Message-Id: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trivial topic to fix a blind spot in the test coverage for pre-push
hooks, and to fix miscellaneous issues in that test while we're at it.

These patches have been on-list before as part of a much bigger topic
submission. I opted to split these out to make the continuation of
these larger hook topics easier to digest.

The last iteration was at [1] and [2]. As the range-diff to those
patches below shows there's been no change since then.

1. https://lore.kernel.org/git/patch-v5-28.36-957691f0b6d-20210902T125111Z-avarab@gmail.com
2. https://lore.kernel.org/git/patch-v5-29.36-88fe2621549-20210902T125111Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (2):
  hook tests: test for exact "pre-push" hook input
  hook tests: use a modern style for "pre-push" tests

 t/t5571-pre-push-hook.sh | 94 ++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

Range-diff:
1:  957691f0b6d = 1:  7cf279205eb hook tests: test for exact "pre-push" hook input
2:  88fe2621549 = 2:  8035594be8b hook tests: use a modern style for "pre-push" tests
-- 
2.35.1.1031.g277d4562d2e

