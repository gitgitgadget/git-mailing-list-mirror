Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6751F731
	for <e@80x24.org>; Mon,  5 Aug 2019 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfHEQno (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 12:43:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38152 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHEQnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 12:43:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so85083349wrr.5
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=x8qSeznnvdqGW/fEqMW1m/vpEOARsS3NWf9vSoRptnI=;
        b=DH4n94eLT4+UP6M6qW3fWai87uMYFCmvLTvkrT/1C67F57/iI2r8jce+JONq763k71
         I27KDaJX5ViQeM086zAT91Uxm/W7Dp9a/FMrdsa5z2/655IYfSr4Il8FHguT75+SZDm9
         JumbeRvGRHt3OfYZ3twspHMKa3oKFJuaYgYCImPlZJEPiy/8L8x+zWnFQcZugBaaox0I
         vOiZnkVSoME1JeLizvBwvwNThjEqLqV7VFn7fgoyqtV0SFfWr9YxHIegXy5RO5skHF1J
         4myRwz+XTjRS5qZEycvxuPoQya+SNOK72EWA/RKVv4PY4MYdUK+A3A4aaPFBq3292R81
         JG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x8qSeznnvdqGW/fEqMW1m/vpEOARsS3NWf9vSoRptnI=;
        b=nSrYC8VTuVYG8aFBQVyWOSIpKLD89wSTWhfsUVzq4kqm9uQB7Ot2mo4EUj4vA2yf93
         7MQ2D4hsov6W6OqOSTKBmBmfpJcgOfIxe4rIv246AOka/RTenreORkM/vH0oIAf5cnnT
         Gg0Xl+gHeDWlb41H9SxvD0VHQ35Hd7uziqKtzEi42bLq1cob7FHAEZpvduP+XmvsxNFf
         EoZyz9NDjlIF4E8lbfl2btu3H/m6HVUf4dzth68Uhcf9cqovs69nfI7rQcEjIG7nuqV4
         ElYv7ky5PURcu9IhxxHPqYAdLsv5t8OAM8f+ZXUyudavW25Dbo6O1wPvqTmzsNNh5Jfv
         RW7A==
X-Gm-Message-State: APjAAAWzmu8IRLkSkjTbOvtF3VJzWrLFdiitleiddRcnLolIRYJmE1ja
        HO3Zm8cu41ZLh/aKHPZIl+HS77Z7
X-Google-Smtp-Source: APXvYqyMLbyEDzrv+zuVKTL7ULHXhWdaM55smpN/69GHuM+tkhRMdSn3G/vxGc/4PNwLodbQJxTbmw==
X-Received: by 2002:adf:aac8:: with SMTP id i8mr3707199wrc.56.1565023421582;
        Mon, 05 Aug 2019 09:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm131774268wrp.54.2019.08.05.09.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:43:40 -0700 (PDT)
Date:   Mon, 05 Aug 2019 09:43:40 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Aug 2019 16:43:38 GMT
Message-Id: <pull.308.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] [v2.23.0 BUG] commit-graph: fix bug around octopus merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@google.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I come, hat in hand, with a bug-fix for a bug that I wrote. I just happened
to discover this issue while playing around with turning the commit-graph on
by default and stumbled into this warning.

Please see the commit message for full details, but putting octopus merges
in a tip commit-graph file in the incremental format [1] would cause the
file to not load because Git thinks the base commit-graphs do not have the
right hashes.

It is very likely that a more careful patch would allow this warning to
become an error during git commit-graph verify, but I wanted to minimize the
change for this quick bug fix.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.184.v6.git.gitgitgadget@gmail.com/

Derrick Stolee (1):
  commit-graph: fix bug around octopus merges

 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)


base-commit: 5b15eb397d176c557a82e872d6b4043aa7589874
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-308%2Fderrickstolee%2Fcommit-graph-octopus-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-308/derrickstolee/commit-graph-octopus-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/308
-- 
gitgitgadget
