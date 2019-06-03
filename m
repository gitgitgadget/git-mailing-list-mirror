Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13071F462
	for <e@80x24.org>; Mon,  3 Jun 2019 21:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFCVsm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 17:48:42 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:51730 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCVsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 17:48:41 -0400
Received: by mail-yw1-f74.google.com with SMTP id k10so17864414ywb.18
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GohRiP2RuVvonEvu5PrW5SpTF1nA1XS7O0zMwoRM00w=;
        b=hL3hlFe3W/rlsTvjy0ljkMS3WdbbTbWedKJ8iCIsJgCi7VffWkZyZ4PR+LIQSqgQ2K
         C1zWGnkNHril26hCkIViYiyOS0s4JQPntWESVxt22PtnKftCd0C63vCzBkQk1Uto2VVS
         RX5eLa9nv48e33S6/iZoDhFC1/F0wXAeeIoWllOtDcD/mQEkj8C2TSnYjIYUW5YJgUv1
         ci8fDY1dWballMcsLGPT9JX6X4FyYjpYn1G8LDutwKZBSPkcDtpROhwWac+LlNGXAyrQ
         EzAgsG2E2fpmpwZT7BK2BBY0OZ82anNuA2+IiDt62yo8loOc72/sm6LCZKDy9cIz7bq2
         6mTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GohRiP2RuVvonEvu5PrW5SpTF1nA1XS7O0zMwoRM00w=;
        b=mJuxvATyQtZtM9sWijaX3J0wdVo5wDnjOs5afUI3LHrlRtBMAmKbTNgU2SZlmVs8yR
         Yo8FlqpbuG4v+O5z9tuBHBFBIMqGpuAD0XJhCkZ8XlY5658vMM0HV0vxlrr7unic03A3
         PGnPXEnq/hdfjgNchcLZk3sZR5GNgyDQx0ZY0b5Sgn6Gg5DUeckqkikG/4V0fOIVAv2o
         4MPupWt2J9eNUBzua/CovsubZWiJ4N5OdruBsL9yslhAzTR30PWw6vl8j2bH2SJZNzHD
         4JoEzl+Ai4C8HV3TsEqe9EouomXgjiIBsf/C2PrvB1Jiwa0mHo5lM74PG9r09b66RR9t
         pAqQ==
X-Gm-Message-State: APjAAAXhPDF1iqlwJ+HPWraOaoRRME4qWBtt9t1oFmxj6ZChjlF3OJvO
        yw+tUbL7BGRdY4xWtCKBeUEAtnInCCKztDNaYqd1hoqswujPzSW9W+HyX02oGg/4Oj5ZOotTu5f
        8yiwdOJvZlIJd3e7uvC7ODx4c07BZq12lSvmy/f5yQdSKTebFNPgN0cZ33Wg=
X-Google-Smtp-Source: APXvYqxvnHUMwdCAmr4HrHgg43WFYkz37BZf1YLm5T7mw+YCoTZW6vQyfmBZRGU7fHbZD2DvHpJ/HLgnoaQN
X-Received: by 2002:a25:81cc:: with SMTP id n12mr12654681ybm.382.1559594742404;
 Mon, 03 Jun 2019 13:45:42 -0700 (PDT)
Date:   Mon,  3 Jun 2019 13:45:24 -0700
Message-Id: <20190603204526.7723-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH 0/2] Harden url.c URL-decoding logic
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        l.s.r@web.de, gitster@pobox.com, spearce@spearce.org,
        jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixing two minor issues related to string-handling corner cases in url.c

Thanks,

Matthew DeVore (2):
  url: do not read past end of buffer
  url: do not allow %00 to represent NULL in URLs

 url.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

