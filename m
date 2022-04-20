Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A37FC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 05:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352624AbiDTFT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 01:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357504AbiDTFT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 01:19:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D3340E3
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 22:16:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 203so593879pgb.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 22:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RrUrAgW45ZxmwAjfojakav0AcHFcLpQL6/+KdAhehSM=;
        b=lEK0pVKmYD9yvjbkcl3UC/jYIcGdRALMVWhR6gsX1gQPrtrdpwDwNl4eHmpG7Jsjcq
         rT5PdLfjLXadG2zlauWd9pojlJp/+zmwDSJZCWQdDzr0sdfGIEZWJkPwlqw3zx2j+xJv
         du+aRE5nQhY0lK8WXgk+OM0iWnW9xqAX1q1sdDFA2tTpaj9K0zxiHGBGt8sifgn6KXjw
         qsH/UakIAtQbHn13adyv8AGwRO+pwsUqhc6Lsw1XR005iYHXKq9/2TeQQjwyHZvDBQHe
         0aydRCdUvkXE4vVr7E5ICJMn058qVQzxwarehK8ONl+wvsF0XFs2qsvHefxu4UPMmVVt
         qc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RrUrAgW45ZxmwAjfojakav0AcHFcLpQL6/+KdAhehSM=;
        b=wIAYaMmh38WUMF5rj+s6nwnftjvrD++pb1adw+gRJBUuG2f1667l8EvszyfumT3+yF
         dr+HQvgI2WKc4Fc4N7TzPIdL8RThexJQzMT77hn7n9ylTgQBVfFO5mLcDcudmTnwKF2X
         zMns9d8rHK6DMyCoJRHoh0+PPWpCZKFJqlO0shkL0nrAXFfdIt0lXjlQAUzs8aGfLC0L
         DWi8GIEnQEQigJc5ZPIbGtGowRMpigzmA+5/zSk6uWGzfEGboxRygbsLgAB+SlifNugE
         DHHIJ4IR8UAErDtjQ6JEuaGVvQ4+skXEBiG6knAGM90ay7LXEeG7HyPZWo6FVb9kQ21P
         EsFQ==
X-Gm-Message-State: AOAM531dlNy82rnS/PnKd7JwJVH0snq5fGfF6Lv7E+us2lXhuRbhOoLs
        LPqiS92lMvOo4ZunFp2DFl4OBPRTKLCEtA==
X-Google-Smtp-Source: ABdhPJxirx/2w/cmpTGkJE0Q4+buLmX91DM9yfIx2Hx2mEJcWZLXAOMBg9eRtbc5UlhZihXNX0ffDw==
X-Received: by 2002:a63:42:0:b0:3a8:47f7:bf0d with SMTP id 63-20020a630042000000b003a847f7bf0dmr15468899pga.276.1650431801376;
        Tue, 19 Apr 2022 22:16:41 -0700 (PDT)
Received: from localhost.localdomain ([202.142.96.31])
        by smtp.gmail.com with ESMTPSA id q16-20020a17090a431000b001d4a27e6a77sm232985pjg.21.2022.04.19.22.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Apr 2022 22:16:40 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add coccinelle script to check the option usage strings
Date:   Wed, 20 Apr 2022 10:46:26 +0530
Message-Id: <20220420051626.1216-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <pull.1216.git.1650024209568.gitgitgadget@gmail.com>
References: <pull.1216.git.1650024209568.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello community,

Looks like it is not reviewed yet. Could you please review it?

Thanks :)
