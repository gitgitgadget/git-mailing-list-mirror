Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78206C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5912960D07
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 18:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhJUSjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUSjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 14:39:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575AC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d198-20020a1c1dcf000000b00322f53b9b89so543563wmd.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 11:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRqGEkL/HtXGQ9pOreZ4+c82Vacl84jHCsASypaexJU=;
        b=IGnEPFh9Zd+esMn4ks89fgS/JOvlnXzM56A2YMJ5ZYVb59PddKwaOdEIumMrMPhA16
         m2lNH2KMg//UwRhBsp3PP2oL8L0tZuVhElCGlZ2IfIn/8HseF3YBSs7i0d3w/RIWjARz
         ElqqNWdTW5bc1aQJq4GA/HtcXV7CpVFoDoLLEDW3126dB9ivNxgPqSCHnv9nZdP6Gaf+
         RFWfpuzzzLMT/Qhfl4w3p+5QvO5ydyEiwzRoaPZQYd9BEE0xRrBzwMlWI5EAshQ9xgnx
         LjCT0t0AADwrmm116ZVl72pRATvCic4EgA0YmHVUH3LGlOaNjYObqdpR+XF9ItRd1r0+
         9Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRqGEkL/HtXGQ9pOreZ4+c82Vacl84jHCsASypaexJU=;
        b=upaK+qsPz0MyIPecHv8YFRKJwjwxgmKD9W+nni+e2tlwGmGA8/9XM73E3F+/maB02z
         BDVgHXuBAmorIRyeaN8hyPdwrkvH1fXivVZ0QePNr64wK4YbmdGkXQ8hMwLSlho2jL1q
         OGVP1YnvhLBYL8eycHf4VhWyd/+1Rb1++bO+jJntVrNbdSOc745c3kY1jEN5aWPxWme+
         XS7hFGmXgASZ8TQHx9D2VKhJZYGYPqbT6lOqO20ejxxM132ZbvCTC9v5HLiaZZ2tSHna
         UywSTrCK5A0A1jHH+oFTZJLfIBMCjS9JXlkBdaW7sVVaWuJoHqmB8fiR/IkDREBP90+3
         /mKQ==
X-Gm-Message-State: AOAM530WlqYHp09YTC8mFcG7cXMFmYW2S9esF7flJDKK0mugRMU2sC+N
        X9wyweBe5I2MHBJuktqMLCe+Zjk/WCpsmw==
X-Google-Smtp-Source: ABdhPJyRMs28FHwwVF5RoVGHncw6V47YDjyJ6Uulxz5puUKtwlrNAoMnAbWNdl9LK2PW5k10WUqt3A==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr6002170wmc.187.1634841457064;
        Thu, 21 Oct 2021 11:37:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm7048278wrs.5.2021.10.21.11.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:37:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] remove code that's dead post-rebase --preserve-merges removal
Date:   Thu, 21 Oct 2021 20:37:31 +0200
Message-Id: <cover-0.2-00000000000-20211021T183627Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small follow-up to the now-landed "git rebase --preserve-merges"
topic.

Ævar Arnfjörð Bjarmason (2):
  git-sh-i18n: remove unused eval_ngettext()
  git-sh-setup: remove messaging supporting --preserve-merges

 git-sh-i18n.sh  | 12 ------------
 git-sh-setup.sh | 12 +-----------
 2 files changed, 1 insertion(+), 23 deletions(-)

-- 
2.33.1.1494.g88b39a443e1

