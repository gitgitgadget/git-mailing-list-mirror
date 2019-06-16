Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA3D1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfFPIXb (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:23:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37882 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfFPIXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:23:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so2824475plb.4
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbojfcr1/dNFwnMepRAEJwJtOqCaGvrZeeE5nW2ATaA=;
        b=tu+BYJvGAXP8bFGP4CTh0O//Dys8XD4JKdAi34PPAaWR+s38n/GXnaH/2ch6E4Xoha
         zIwlvzn0XpqSaK/rzA8q8+eU0IaCdUfVbeTmOwf7qq8BFBxJq/vazatLtjLZsTVrOKXe
         SdaDl1mfzxB0zvymjQFy7rtC358hDPbGk1JgudbSpUROfxWLks3qwW4ZvTnSz80wQgrB
         lBi35zaT+E8k9B1ImDxv94gXpgzKolLezyxAYaKKr/VbnBEic33df9JffeuJznOKIGg2
         fwwXUdcqVBBu6jwG48yzItwAcH76IGn/F+33VLqE4zhE4DAG3i36/TL2p2QzMMt8TyVj
         dn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbojfcr1/dNFwnMepRAEJwJtOqCaGvrZeeE5nW2ATaA=;
        b=MNtEW8rkvgEBEAjiCY7gZNoVqn6ztY1Dp9lBamoIzn9BytvDhf7GmfR19t6Ja6vwkG
         GzvhgOiDjUqESYs4zy61ouZtKsg4LKjNNQXzMmiu8I40wEzpFQE1ttCrllXztazE8C+o
         3g8Hkdrn8Q0vRL1+yIBnFc1esrCTqzJLQNGOtanUyPobOxqMeOH006PwgLFAr5Veg0l4
         kzStTVLdrc6dQY7tGkvmejDhfIvzRYYOOsMddGYZIBkY+o5gnVrxIgkhdG6KtkNZM5Ne
         +qBZ834DGpeAWT/2wHW9/Y0gF6uW5H22MvdJBfp+hAQljRdcvqJrLnnY0JC8/ghAonG9
         1Qsw==
X-Gm-Message-State: APjAAAW9uFLhhP4SHxBbpCaER7BklbQxG5qucr4no9oPykdKLHw1+D9X
        Y6DErNBUZVf1GQ88tWqQ1jY=
X-Google-Smtp-Source: APXvYqxPnUFQ48zABTr+N/m8YJiFgo/UtMfqTPA4PXR6fabJXva0kzbhVpUqxMcXK6kSDLOgns+MhA==
X-Received: by 2002:a17:902:bc47:: with SMTP id t7mr88816379plz.336.1560673410489;
        Sun, 16 Jun 2019 01:23:30 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:b496:8be7:332f:b415])
        by smtp.gmail.com with ESMTPSA id x128sm1471972pfd.17.2019.06.16.01.23.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:23:29 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v4 0/4] [GSoC][PATCH 0/3] Teach cherry-pick/revert to skip commits
Date:   Sun, 16 Jun 2019 13:50:36 +0530
Message-Id: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yet another iteration of my patch. We have changed the series a little bit. We
now have a commit that rename `reset_for_rollback` to `reset_merge`. A lot of
nit-picks were handled in this revision.

Thanks
Rohit

Rohit Ashiwal (4):
  sequencer: add advice for revert
  sequencer: rename reset_for_rollback to reset_merge
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 builtin/commit.c                  |  13 +--
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 139 ++++++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 ++++++++++++++++++++++++++
 8 files changed, 266 insertions(+), 26 deletions(-)

-- 
2.21.0

