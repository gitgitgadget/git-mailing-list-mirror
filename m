Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED0C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECBB6120F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhJDBom (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 21:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhJDBol (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 21:44:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86976C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:42:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so27709951wrv.9
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6+9dyOhioGCYlCZqUV/M8+5+k9tsaa5GMNHbCzxPyY=;
        b=IoctWrJHOVcJKSL8Z0jxFQOsfjptGORNzVPsJqbhrUJFdpAEqr95EsKdA1OVgfjUBd
         e91nB/aRjno+ohVANZ2/JrV20Ld3VtU5s/kmFHV+MVIMwrDZEU7glqu/iM8F2FeV31D4
         /LRsojacSPh0A3sfpGN+cyvBcOGtB1suCLUZIyVI4vnvpk5t2Q9vVXGUqkiGhMJSNC/v
         bNaN4+XyAs4bCwbS6oObzSOOc/7Wll+H+ZqQPftK6a6Hn3SX/QBN3GLAJNoMQcmPwSAP
         c8Nu8OHog9ciGImkkezylnoR82+dM0jtA5wBW5rPVjI18VTnwF99gbVi5blOTWHYVqO+
         XbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6+9dyOhioGCYlCZqUV/M8+5+k9tsaa5GMNHbCzxPyY=;
        b=duxfqZR41zLq+AuWmM4Xsn7UIoOCOP0J/sDHn0G66LAvmDqsFBA5oOsrbHZooACj32
         w+S5vi+tY56Kaa5yY1BcMegNjeyKObYKXBii3OyduOWdr3rFUM9YQdR1ziY1X7+PPrLx
         sLq8/SRepbNDhWZLrJZljiJHrzGeeJKw4P132clndEaIm3NREUfqXVvCy2PjzOc7aN2Q
         YC6SwclLxzJ7Z/L/WgFqUqV3OTnbsaqrgZ9kHsAmEhCNfJAswLnrkgiKpbldmadiiH88
         MeE+JW/I0JN+ILewhPvQHmriLHfqrOv7rWhRCpn5kQ18h64d+i3nrfPjtmnp22jLFpTz
         CMtg==
X-Gm-Message-State: AOAM530gTVfKogx+IwpD6MJPjCzo+8Q1Q3xu0G3PDyYqdJ5TacnhdFx7
        DOtiCfIss248uOGobOtAkgheZhdFNYIHeg==
X-Google-Smtp-Source: ABdhPJy3wRsmpY0dnXVz2BJP+ce8MERtMfvnMbja8kBHBjUq0f8ZNcA2pyJjotaadgAJr35gqubjsQ==
X-Received: by 2002:adf:b34c:: with SMTP id k12mr10878056wrd.1.1633311771783;
        Sun, 03 Oct 2021 18:42:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e14sm3308193wrw.33.2021.10.03.18.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:42:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] i18n: improve translatability of ambiguous object output
Date:   Mon,  4 Oct 2021 03:42:47 +0200
Message-Id: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series improves the translatability of the output we emit when an
ambiguous OID is given by not emitting it a line-at-a-time. This
likely won't matter in practice except for RTL languages (of which we
have no current translations), but it's good to be future-proof!

Ævar Arnfjörð Bjarmason (2):
  object-name tests: tighten up advise() output test
  object-name: make ambiguous object output translatable

 object-name.c                       | 53 ++++++++++++++++++++++++-----
 t/t1512-rev-parse-disambiguation.sh | 16 ++++-----
 2 files changed, 52 insertions(+), 17 deletions(-)

-- 
2.33.0.1404.g7bcfc82b295

