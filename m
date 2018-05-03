Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57B3C200B9
	for <e@80x24.org>; Thu,  3 May 2018 23:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751108AbeECXrL (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 19:47:11 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34616 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECXrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 19:47:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id a14so15993325pfi.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 16:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VPl/exxKbujtVWDrrNZvy7iTEwe1Bixp8Pt8kmRD+rM=;
        b=WZ6j4hERuSnj6Qj/sLYejhW8a7bVM/PVoyGv7rxeJkIfoNe1HU+OMePvpl+IpXaTco
         Jc4aIeVa66Fv1sI1wSEtvi5XJqBNNTAkLA+PfPxdET5kebsr37cQkkyhSMU2et4nS7X+
         J979E3sumDtDTmMzGquWuXpU5bmLc4m9v6HOYhRlCNA0K9tbTJaICHiuO1w/rgmbciGX
         73pTR92SWS1OqRxB+q1yVzghJp1DeSFcrXanhqDxvom0nTwQf0M2nKZvD966GGsXP8XE
         LSp8prwW7UYSq9O1tEFl+aI4q0ccevO2THyqaV8+Y1Se0fe3D1TB7Ay+swCpH2g1ioYe
         1XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VPl/exxKbujtVWDrrNZvy7iTEwe1Bixp8Pt8kmRD+rM=;
        b=UCiacOoPrQ5mOadGrUrsH+UPqBguZwaAsPpzcSgH0tmoUUCKxxZneXquA37oSrYhrD
         s6PpS3StcVdD8xhRHLbuTJSvK3UZNPEHW21CGvcpyPHmKfr4HhcltofCU89fbKkJc6Bb
         eMY7+sgeuwuFLBXdfUTIEQTR06AnkGY9UwbEMtZsMo84AQ9BxJhh3UTj6WO/vjyXSbID
         2YrJCpQ9oBMza2bbjmGEV71tL6pXkWDMvKsgLokUwLXZZaNvd/WO5xxao2vvbxnp8AJY
         2ehqDwFw0ILhKVkZxaj35qBXz/ekqJbN6CZLPUt4URuQUMP7BVyNJs8P+brYMdhvgGCf
         CvZA==
X-Gm-Message-State: ALQs6tDNcRLbEjEjV2R1bCyQopezQ7zTd4uDZpaPg1YvSX5YjEYhkiHy
        6TplKpmCLYm2P0okvLyY4w19oEJC2HA=
X-Google-Smtp-Source: AB8JxZowaUxEbS1w8EzMsWp3RKzsgkfMGE6KM9XpnUpYJ+BAVdGYhK4wIKHxZNghgn6v/nxanEPmRA==
X-Received: by 2002:a17:902:ba87:: with SMTP id k7-v6mr17599322pls.193.1525391229277;
        Thu, 03 May 2018 16:47:09 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a67-v6sm7924669pgc.23.2018.05.03.16.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 16:47:08 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH v3 0/3] Supporting partial clones in protocol v2
Date:   Thu,  3 May 2018 16:46:53 -0700
Message-Id: <cover.1525391172.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525213052.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v2: followed all Stefan's comments.

Jonathan Tan (3):
  upload-pack: fix error message typo
  upload-pack: read config when serving protocol v2
  {fetch,upload}-pack: support filter in protocol v2

 Documentation/technical/protocol-v2.txt |   9 ++
 fetch-pack.c                            |  23 ++++-
 t/t5701-git-serve.sh                    |  14 +++
 t/t5702-protocol-v2.sh                  | 112 ++++++++++++++++++++++++
 upload-pack.c                           |  19 +++-
 5 files changed, 171 insertions(+), 6 deletions(-)

-- 
2.17.0.441.gb46fe60e1d-goog

