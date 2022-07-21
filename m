Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30139C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 13:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGUN2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGUN17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 09:27:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E30E753A7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:27:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pc13so1610455pjb.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaBlNt0gBf/M0my++7FF5VM9fGrehEMNlerhqeR4dNE=;
        b=j/Moubk2GEGT6HvwsxulVINknt88V4g1D+BqZln33+wJ3/4BSNP9vTRaLIqVsugPsI
         vY7eqPfXTUkWUtTNQlU4uRxUZ02IxV2ILmC47KpA55H9jr+6qlsGW8+X7MUfFSG9ZfjM
         TNXXgQ0JdAOelExPGA+/RtGato6ZfePr/4qFiy/HkQKYQi2WC8Bo60neHQc30mvSdcwi
         JVpK0xiqOLIlIZ23qKhuzGTWfc8XtddpdNkcjZsIJN54eaSpbc+mjzZlkCrGcZE4nzx0
         BpnWzFBmpZafYl7lj2w7D2PtHefUvj+JrgUa3fSz0iPWBzAmDd6YqgDqrSQpGqz22Qnv
         mGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaBlNt0gBf/M0my++7FF5VM9fGrehEMNlerhqeR4dNE=;
        b=Q+TpkS1lZHGvN/fs+9VK5isvHD5/WRlQ0aJCYk1laiFrKAavO3BDysnjy+OVP48+J9
         7eHmb2SddAk6uA+hyUu9oC6jYASbdd6mv5BrpzQIMnAcUgzpIcXcE/E5BJ2/0hNsx1cM
         5rwJm+2+dPTbJCIJ//U9lj394IFGIorGWIZq62ScZANUFoqbmwndz4rIKnS7S9IH35E1
         pDVb2zYgod63ouVCP4o/M9BA3E4y+7Bu1i/PqkeEINF81QSAMAOKO+xw9WAs1STRH4I5
         AnH6vxmAIHMa9oXacP/hnemv6Aqx8Z1H0/CwCf/7Gv7XuvsmCcDiAcdfBxVkAPi8rzSh
         UJDw==
X-Gm-Message-State: AJIora9LxLV0Mpzy7YMdgAMn1CFNTT7rNKYMjjEm5wtBu4ZpQpiN+gtz
        JcKeaF/t7s4QiwkGxfhIQ3SeNOC1734=
X-Google-Smtp-Source: AGRyM1uAVL6r/OArEdoAXpRKZGfUanmizLyBVbVrSWmTmQweGXNLHdeO7wuQPRx8iOpZiHtEOAMiTQ==
X-Received: by 2002:a17:90b:1e04:b0:1f0:61a4:d747 with SMTP id pg4-20020a17090b1e0400b001f061a4d747mr11465845pjb.58.1658410077413;
        Thu, 21 Jul 2022 06:27:57 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm1467326pgt.64.2022.07.21.06.27.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:27:56 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, --cc=avarab@gmail.com, git@jeffhostetler.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/2] tr2: shows the scope unconditionally with config 
Date:   Thu, 21 Jul 2022 21:27:46 +0800
Message-Id: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This series is separated from :

  https://public-inbox.org/git/a01ae8478d3a8545241c5b064b6d369a330ee59f.1658159746.git.dyroneteng@gmail.com/

and now move to a independent topic now.

Thanks.


Teng Long (2):
  api-trace2.txt: print config key-value pair
  tr2: shows scope unconditionally in addition to key-value pair

 Documentation/technical/api-trace2.txt | 41 ++++++++++++++++++++++++++
 trace2/tr2_tgt_event.c                 |  3 ++
 trace2/tr2_tgt_normal.c                |  5 +++-
 trace2/tr2_tgt_perf.c                  |  9 ++++--
 4 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.37.1.1.g8cbb44ffc4.dirty

