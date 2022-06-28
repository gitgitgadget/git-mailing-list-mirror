Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90234C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242439AbiF1IBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiF1IBo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:01:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144A2CDF1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:01:44 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so11596288pju.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HzKrveu+xS3+mhMuiYGxIS6Oj61LeV6H5qMTFQzD18=;
        b=VhwVO0KYyp2tT9N3lNSeGoikhZuAQf4L21UyS2s0X+tAAwhdT93/MzhvisNqB8qAC+
         vY57hawTKL1TJzeYP314urrqO7HR24jTvfB2mvColeJQHmtsd9yPGpWrAteg+Yt9muSG
         riilA6mbFs6C9UVsjcVfm2GTk2yITBEJjhSWkmLFev93Z3mRk35J9qav7touH+pP2hOH
         8HPWKtJCH2SKTNc1gLkhgSzfANCdaCHySukwsFRgJu5YQXf4ZkwqLV18WoATSPwbVlnx
         WSj0jTH/G3k9TNLicfChjVQEe33pLQsffFR3/NJC9Soxj446dMGI3QU9kP2/LLAFdCmE
         SxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HzKrveu+xS3+mhMuiYGxIS6Oj61LeV6H5qMTFQzD18=;
        b=kGxwA+M9jDgRQWIFWW/bVaqgboLpcd2WeWcS//G4lKTi6nEaoU9ILGyvObtBv/dYYY
         z+9XR2F5rjTyoAzu9Nzuc2nt5yClQwXvY8XZHCXHlQjh3+feeswY0f8S+AdZfzG3UJkx
         pOccI1pl8BzjIiLfxiA05roB9p2D2JVjHCNlghjeVaBM3Fyw7Qyxdf4KQILNzeM5ATms
         jv9lnusoMmGTLzZnPOSMEEGj+p7YNIze4KWZhDeKBtKTWRVrsg7JHHvYkvkLFO03BUfv
         TJK/E/NDt5O/MQMPFTclG+rkFwroj/ggAzbrtSAFD2InEx0BEFz3qis9eCGEVc8Vh5At
         3zdA==
X-Gm-Message-State: AJIora/3weO534UTz6AUbAsb9UA+X3MWxFo7hDlIqkTG+3aLu2LpQXkh
        1wfQhXEr9tFX4qmAQ17XtyU=
X-Google-Smtp-Source: AGRyM1t6GOQz1RzPWIPsAJoUcoZddrzCG+27wRyG0dEW9by7pkQBhAxjYmefnFiyudU9DccwmC2v+g==
X-Received: by 2002:a17:902:ea4f:b0:16a:cfc:7f49 with SMTP id r15-20020a170902ea4f00b0016a0cfc7f49mr2352491plg.135.1656403303296;
        Tue, 28 Jun 2022 01:01:43 -0700 (PDT)
Received: from localhost.localdomain ([202.142.80.21])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b00524f29903e0sm8685380pfu.56.2022.06.28.01.01.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jun 2022 01:01:42 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 6/6] p5310-pack-bitmaps.sh: enable pack.writeReverseIndex for testing
Date:   Tue, 28 Jun 2022 13:31:30 +0530
Message-Id: <20220628080130.19199-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <YromNwFsUNGtW9pJ@nand.local>
References: <YromNwFsUNGtW9pJ@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> wrote:

> I think we should swap the order of these final two patches, since we're
> primarily interested in the difference between using a reverse index
> with and without the lookup table.

Ok. Thanks :)
