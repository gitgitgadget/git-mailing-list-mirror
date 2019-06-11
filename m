Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55E01F462
	for <e@80x24.org>; Tue, 11 Jun 2019 07:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbfFKHeN (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 03:34:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35819 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391234AbfFKHeN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id d126so6874338pfd.2
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 00:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iengOX/t2rcyiJtL2Vvexr8Mf5+S6HS2K8Ux3mooha8=;
        b=Squ4h5RmCoMUm3Vx11SugUcS9Huryn8Z1hKUfJpKty8iTMGTbmo1AIbxv+HJMM3wXS
         jZpCrpgtu+F23aGmMrq4lzmx/Ebno/NvlNJvDimgrmZ1ZZkb91+6Fp2vbnIumV58Y3tk
         OF+zp3CVURTs7IZCEtw2TxpzoiGo2NbvehlmRZWGjnPRhab9wljtxA10RTYAdls6GCn9
         jHLZSxPlBYJd/tqfkOS9jGrb6w8oXnaqB2BGZLk2UvkaLUWO99HqaFbGomfXJFGip+/c
         CwsNfq+qkAJRHGMDhctHZF/hQil9Vpizm6NOULdp5GnQH2omd/1hLWrEBgGT5OGOXQTY
         gDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iengOX/t2rcyiJtL2Vvexr8Mf5+S6HS2K8Ux3mooha8=;
        b=DPy9/77WVsdsl4KGaHlf1sn6TZHUEqvhfmHL2VRDh17nxnE00He6U1BMWz+DEKyTX/
         wDiecaQ2INWyI2+iTmitrIAjsK9YMjBk8AGJ28fNAxj8Ez6WDOHco08OSjN3bJCvkKnc
         olytfNxsOB5zNaghc4bSCtcWIkjoV3q64Ckgyt3SN3GxTz+mgRiudxUvsJW6c+UqeVim
         +kQ+PoP/wiHiwDz6R+PdgJSuWs+gC2S+9GiuTr8v/cq9K/e7MXcxFge66AQ96bGqXbe+
         L1ZCmvGtO/i3DafYUKGsbEame8kbnEQPYP7uzEmCx0b0sCOkTcqvmUX3uOu+Yr56cQCO
         LnHg==
X-Gm-Message-State: APjAAAXhHOr17k4KHTOCsBAOVd68MT578uxACCS3JXXyIrSTQahBAHwj
        wHbXLu4c3y6YKE6Icx3IREg=
X-Google-Smtp-Source: APXvYqyLtc3+fhhfTLdeUL8OdTJX8k9DAC8mth0Go2vp8CX8S7CWFlLGYqsqLBleLmEvcCTrXHdyNw==
X-Received: by 2002:a65:620a:: with SMTP id d10mr19197906pgv.42.1560238452493;
        Tue, 11 Jun 2019 00:34:12 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:310c:9b37:39e2:17f3:788e:3d39])
        by smtp.gmail.com with ESMTPSA id m16sm7166022pfd.127.2019.06.11.00.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:34:11 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v2 0/3] Teach cherry-pick/revert to skip commits
Date:   Tue, 11 Jun 2019 13:01:49 +0530
Message-Id: <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding a `--skip` option to make skipping commits easier for the user
and to make the commands more consistent. This will serve as a small
step to the bigger goal which improving consistency of sequencer commands.

Rohit Ashiwal (3):
  sequencer: add advice for revert
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 builtin/commit.c                  |  13 ++--
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  88 +++++++++++++++++++--
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 124 ++++++++++++++++++++++++++++++
 8 files changed, 225 insertions(+), 18 deletions(-)

-- 
2.21.0

