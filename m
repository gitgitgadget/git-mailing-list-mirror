Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1B0C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1518361390
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 12:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbhI2Mvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbhI2Mv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 08:51:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4608BC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:47 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m26so1888141pff.3
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfDCTnFESK9irnLtGoXqroEi33V6ZNJmp/sq43xVytk=;
        b=f8KMrXi8asWGC2I50I+jK6BA7ZB5Xnpa6vYGejDM5uV/BZImzGDjT3U/BK417lnr3K
         4+1GpxbsT5oBvgCM5mfkNf1ymOZFf6HFKQjYeD85tHHhb7Y2fTrzU/pX4gQRajzUwh2H
         GMMRStOphPnHOhfWVdYwGXO0bcE0nIfrEnthRy2nsZWXvhQH1IkCCPemnAj3c2wECpGn
         5mwnLArf6k21duda16Hd1+ylQe/fogTTLiJQ6O2Q0vTUpnv5F7lsf5Sgauw94sQgSrcE
         k3SlrhsQplAuOP8hfBN43YpqIkR+glP3Hwy9jq9hRNbOW0F8+yGLm87yZhMsL3/5flIY
         zBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfDCTnFESK9irnLtGoXqroEi33V6ZNJmp/sq43xVytk=;
        b=YofcEb7iwUV0MHUO9+fMCxOoBF5KC3cZ0rB5mCSp7+Fo0fS+vudplb6fe0NCJxEaao
         bT2tjWmZwM+IU5zixUpEEYHYJytuhVbswoEvTjlGTY2B/Jjfwzff6ZBrSzMTd2lbPBRM
         emE89xuMIiN4h/vllGmGv7VMo632sPD4iiQouusM7F57XgjWmQunkuMqWySvw+nvF3u6
         B9IW9yA5JlvGa4c/w/ERP0G5gfRaZ8a6GLCm4AO6zibDoP3wdMypcWSVkUXJIH0MI3ts
         MbwqZ+XxcxrV29a9l1u8SFksIXFuy5CX4TmBVgvuwEPhSDNbJhALooiyTUa1P8q8akTA
         33tg==
X-Gm-Message-State: AOAM531s2KVhYS5KdzdnryHLG2YXh4NfadoXUSBMYPKE9T8lWnihYmr6
        3qMk17TDuJj5qG9ZtP3uSlqAjDhCzpfurA==
X-Google-Smtp-Source: ABdhPJyG5VMrxmxBDdyriZLrDmpm6PGqWgSRv66jAdAKBD5zBkE7sk6N/pZVDJn91AqFeFfxLQgOVg==
X-Received: by 2002:a05:6a00:14c5:b0:447:aa13:b71f with SMTP id w5-20020a056a0014c500b00447aa13b71fmr3170054pfu.40.1632919786520;
        Wed, 29 Sep 2021 05:49:46 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-72.three.co.id. [180.214.232.72])
        by smtp.gmail.com with ESMTPSA id z9sm1974844pji.42.2021.09.29.05.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 05:49:46 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     "Dr . Matthias St . Pierre" <Matthias.St.Pierre@ncp-e.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 0/2] blame: documentation update
Date:   Wed, 29 Sep 2021 19:49:33 +0700
Message-Id: <20210929124935.41917-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the default output format for git-blame(1), as well as the
--color-* options which are currently undocumented but mentioned in
usage help.

Bagas Sanjaya (2):
  blame: Describe default output format
  blame: document --color-* options

 Documentation/blame-options.txt | 12 ++++++++++++
 Documentation/config/color.txt  | 12 ++++++------
 Documentation/git-blame.txt     | 16 ++++++++++++++--
 3 files changed, 32 insertions(+), 8 deletions(-)


base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
An old man doll... just what I always wanted! - Clara

