Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFE620323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935587AbdCVTvi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:51:38 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35807 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934181AbdCVTvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:51:12 -0400
Received: by mail-pf0-f172.google.com with SMTP id 20so48115744pfk.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=evVWaZFTNMa1a2R3CS/2zFbh8zIcfa5MUhk/z9k4sKY=;
        b=VdX4Mlpmh/2/Og7BV65+ed8LXmYvD2xtuXYxMOGwfgBisyH2mC37xe6RqXWS1CzRdn
         gXyDKLGZhQrSQCiadxhwgUaUDKe+0ZqzS61WYQaG4NUtfJZZ0n1+i/eQ5/mxhzMzYrln
         3TihJKHun5eBu5c0Nty1JNENVT47GDdQKmbxTQIvDS2fhJvaNkadz4KlC8yKrgnV/+vZ
         PghQTyUAplhNeo1qOFxEutWJkKaknzzE+19SyPGLCdHwErLm3CZ2pCTBtk9uRXI4A3MH
         LJ92txL+KNIXJL23dOFem+7djetrP4dmrWqs4k2QNJPT9PUW7QjFvPQIKYX+rHfs99Do
         8B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=evVWaZFTNMa1a2R3CS/2zFbh8zIcfa5MUhk/z9k4sKY=;
        b=eeHFtpVR/sku+paX6SCaCD5oM8uUJoBXULcYH8R5qF/l2YCjH5ZwRKjir7FV8ggFba
         c9o+3vdjnsW5GESntKlsGY4G95QhLXXwVLOAV2N3X7bz/Cp8ka1Rp2wiD5T7wloa5pWd
         8YkmarcT+wKW6w4F1wSyfq2AKCfMZrEBJ8Drhypp/FVrTnTCmpcROIc2vpo9dNJfOjP7
         Iwsz/iD+iSzKBKo0Xyx8ZQLNkOWEm85pIZXtOveqqkdJgiZyVl8WKDt6I3e0va4tLPEk
         +bWj9VFeBc1zE70c58YhoZ84+sosDvnRwSvy1MYx6Jb1j4Pg5+GqFxWUwkaCoBYZrlLf
         beyA==
X-Gm-Message-State: AFeK/H2ZaJo5YXHEW0h7om5NsIqHlIZb6omUizzzNoi8S+1+7ewPbbTfhVVJGxCqtPixjZCl
X-Received: by 10.98.31.20 with SMTP id f20mr48277899pff.193.1490212270626;
        Wed, 22 Mar 2017 12:51:10 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id h14sm5577315pgn.41.2017.03.22.12.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 12:51:09 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/2] push options across http
Date:   Wed, 22 Mar 2017 12:51:00 -0700
Message-Id: <20170322195102.165314-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.1.500.gab5fba24ee-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables push options to be sent across http using remote-curl

Thanks to Jonathan Nieder for helping troubleshoot.

Brandon Williams (2):
  send-pack: send push options correctly in stateless-rpc case
  remote-curl: allow push options

 builtin/send-pack.c     |  5 +++++
 remote-curl.c           |  8 ++++++++
 send-pack.c             | 20 ++++++++------------
 t/t5545-push-options.sh | 30 +++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 13 deletions(-)

-- 
2.12.1.500.gab5fba24ee-goog

