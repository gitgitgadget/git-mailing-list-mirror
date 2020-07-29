Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A47C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E282E2070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="Q/OHFktX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgG2VcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG2VcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:32:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E1C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:32:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so19994680wrx.9
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKrYwWi3XKuFKVDnlS1QRf/Udg/4I2JLrKxLh3Bsy2I=;
        b=Q/OHFktX3ptS1xMyLqWjUjJ0Mh2SHDi6lSY/tdc47nNfTfIQiKr2k/q91B85jKF9iM
         2u2a1zj/G/kNYtFFun4OYCvLjyDe6aNJ/kBG9lUi7Q6pwZ688G+fclEI1ZtdjLRJBv5M
         G33CE7gixvNMLOJ4NX90D8v+l/YmA9tZKd3PqoPuQWlp2UmcPq553uw6iHkQyBpj6l/Z
         EMt7p4b8e2Lhw+vNxXrsRt9K1cYh2F9b0lHwPyvEwohgkYjlPLOZNuSmYJgv4QMDqhLT
         g2uUv5HzMclRzeJmPnD53eZCeGfuqQf+N567ZSur5G7S0CgDBo8pUAtwlWUyJiwOlm0U
         FLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKrYwWi3XKuFKVDnlS1QRf/Udg/4I2JLrKxLh3Bsy2I=;
        b=NFFaf7aEO4Eyhz0hDfrzegoURZ6txjPKB1jKw3Fx+AmnacqomSMDD8TQwY65Ipv8X7
         jTUzW9Xgo+kd2Gqn+Mt/B4CHmEU5Wx49GRoTQAjhKuEFGrS0uA/vS94/T/ZlxUJC8hHI
         Saij9xVUYg4cDChKUYucSXnp8mzjq+1891hoswKpp6xGSfr485HTu/WnO2gStDu5rIfJ
         cpGHXLpsNCI9wsptYMU8T/zIofAsxmvzeoTSTHum5Qf8Ss1eBrt74jZIn8z63jfLp2g7
         eFkqydl617zf+qIzeBurYsHLvPaGB+x+L/thLFfRiiYRsi0bRFc55N/ZCrm6DWwWbytp
         Fcuw==
X-Gm-Message-State: AOAM531RRntyDaYqF41Z2/LHVzmFatsvlngE9yBrGA+VnyBnJ0qY2kKq
        Yomy3NimQ7aqr5KY6w66hKet+rVZ2q4=
X-Google-Smtp-Source: ABdhPJzXUra1RS9AiCat27sqs3WOWUvX2egyOzX379gSRzJ/aBL5BzD9SLO0zmibZHlEmoIFjTrCzg==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr16794030wrm.301.1596058335185;
        Wed, 29 Jul 2020 14:32:15 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z8sm6402057wmf.42.2020.07.29.14.32.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:32:14 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        pudinha <rogi@skylittlesystem.org>
Subject: [PATCH v3 0/2] mergetools: add support for nvimdiff (neovim) family
Date:   Wed, 29 Jul 2020 22:31:11 +0100
Message-Id: <20200729213113.15927-1-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200719042335.3913-1-rogi@skylittlesystem.org>
References: <20200719042335.3913-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

thanks for your time. I think I addressed all your comments regarding
the commit messages. One of them is a bit long, but I saw some others
are too and I'd rather have it long than not descriptive enough.

Please, let me know if anything else needs changing.

Best regards

pudinha (2):
  mergetool--lib: improve support for vimdiff-style tool variants
  mergetools: add support for nvimdiff (neovim) family

 contrib/completion/git-completion.bash |  4 +--
 git-mergetool--lib.sh                  | 35 ++++++++++++++++++++------
 mergetools/bc                          |  5 ++++
 mergetools/bc3                         |  1 -
 mergetools/gvimdiff3                   |  1 -
 mergetools/{gvimdiff2 => nvimdiff}     |  0
 mergetools/vimdiff                     | 21 ++++++++++++----
 mergetools/vimdiff2                    |  1 -
 mergetools/vimdiff3                    |  1 -
 9 files changed, 51 insertions(+), 18 deletions(-)
 delete mode 100644 mergetools/bc3
 delete mode 100644 mergetools/gvimdiff3
 rename mergetools/{gvimdiff2 => nvimdiff} (100%)
 delete mode 100644 mergetools/vimdiff2
 delete mode 100644 mergetools/vimdiff3

-- 
2.28.0

