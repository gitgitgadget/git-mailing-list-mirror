Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DF641F803
	for <e@80x24.org>; Tue,  8 Jan 2019 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfAHVwf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 16:52:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfAHVwf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 16:52:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so5593815wrx.9
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyZW5o5AK0ks1uRFY3S3yRWRaR2pNUyPPCLloZaGTWo=;
        b=LKz5i6BJA4wNeYa8XIxxeji6ZEk7ygSTALfoB86aKJi3r3i/hsPEDqX9iEmYzZ0nFG
         MCrCROfymbjN0utHWlWZBRyMe4IhU/aPV7ozklZUa8pmVaRgE2rKXD7CjgjatbY5eDO/
         HwIAktP4/b+xe6dBifs1luo0Vc2N01VGLAiFFfc0vyL+z5ifIMRBsoVA4fLwpD3qeBK5
         tGeIdUmZE+ExJhDvZBY2TzT46RjLMAAnH1C5496Z3JJ4+8uWCq7eFJpevKNkZ5pxW+5T
         7zQg17sw1Gwmb7O597902UKHl6mmeCxtN7d0SmZpWpjTY/ehzuXpFdAV/ndjlS8w5RSa
         qbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyZW5o5AK0ks1uRFY3S3yRWRaR2pNUyPPCLloZaGTWo=;
        b=nMxByMc7neP9WLoSEcNJRS88FS0fD/+WCqiloHfa+WbUeOQc886J61XAjjAydLdak3
         ziSe145rA9OTFBIIp2lPceNKGJyUcC9iccJMenSHtmeMi+bhru/myPXiFzm2fn+bt3QX
         FG5dc1INijvorFG3faOWP78XaAGxlsyrK0Is0J1SDYat7/6dQg5BsvBLeEgrNmCPNtv4
         zhrmHnxVxGFJTslT212uxUfNg3vEYOWp1HEl50VrjSudKrdO3Dgulx0HsuvppYk4briq
         JatUx45xDv2iqrkl/HIx0z3nwNXpTryqi2T3OvesJHhKmYU9o7lYMKhZjnvcniYOmqK8
         8nIw==
X-Gm-Message-State: AJcUukdHqJigmgI/d6Awv5ToLV2C70sy5xnkXlmn2nRUDCO4A+qcr2Bw
        57dAcuY7zlXfdv9JoKXUIMCWnL88
X-Google-Smtp-Source: ALg8bN4ywPGgCbPpyN4Y/DRpkHlxFUUNOiQ6oukhZFQkbkmKz3yw8rHyFV9E3kNKzvldipGPsF66oQ==
X-Received: by 2002:adf:a4d9:: with SMTP id h25mr2539484wrb.167.1546984352516;
        Tue, 08 Jan 2019 13:52:32 -0800 (PST)
Received: from localhost ([2.24.105.63])
        by smtp.gmail.com with ESMTPSA id t5sm12554582wmd.15.2019.01.08.13.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 13:52:31 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/8] introduce no-overlay mode in git checkout
Date:   Tue,  8 Jan 2019 21:52:17 +0000
Message-Id: <20190108215225.3077-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previous rounds are at <20181209200449.16342-1-t.gummerer@gmail.com>
and <20181220134820.21810-1-t.gummerer@gmail.com>.

Thanks Duy, Eric and Junio for comments on the previous round.

This round fixes some inconsistencies and improves the grammar in the
docs.  Range-diff below:

1:  fa450cda7c = 1:  fa450cda7c move worktree tests to t24*
2:  9ada8d3484 = 2:  9ada8d3484 entry: factor out unlink_entry function
3:  41c0ea4047 = 3:  41c0ea4047 entry: support CE_WT_REMOVE flag in checkout_entry
4:  afccb0848d = 4:  afccb0848d read-cache: add invalidate parameter to remove_marked_cache_entries
5:  8a2b5efdad = 5:  8a2b5efdad checkout: clarify comment
6:  c405f20471 = 6:  c405f20471 checkout: factor out mark_cache_entry_for_checkout function
7:  e5b18bcd02 ! 7:  a291dc78fa checkout: introduce --{,no-}overlay option
    @@ -35,7 +35,7 @@
      section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
     ++
     +Note that this option uses the no overlay mode by default (see also
    -+-`--[no-]overlay`), and currently doesn't support overlay mode.
    ++`--[no-]overlay`), and currently doesn't support overlay mode.
      
      --ignore-other-worktrees::
      	`git checkout` refuses when the wanted ref is already checked
    @@ -44,9 +44,9 @@
      	submodules HEAD.
      
     +--[no-]overlay::
    -+	In the default overlay mode files `git checkout` never
    ++	In the default overlay mode, `git checkout` never
     +	removes files from the index or the working tree.  When
    -+	specifying --no-overlay, files that appear in the index and
    ++	specifying `--no-overlay`, files that appear in the index and
     +	working tree, but not in <tree-ish> are removed, to make them
     +	match <tree-ish> exactly.
     +
8:  de24990d57 ! 8:  8d4070f142 checkout: introduce checkout.overlayMode config
    @@ -19,9 +19,9 @@
      	settings nor will it show the local changes.
     +
     +checkout.overlayMode::
    -+	In the default overlay mode files `git checkout` never
    ++	In the default overlay mode, `git checkout` never
     +	removes files from the index or the working tree.  When
    -+	setting checkout.overlayMode to false, files that appear in
    ++	setting `checkout.overlayMode` to false, files that appear in
     +	the index and working tree, but not in <tree-ish> are removed,
     +	to make them match <tree-ish> exactly.

Thomas Gummerer (8):
  move worktree tests to t24*
  entry: factor out unlink_entry function
  entry: support CE_WT_REMOVE flag in checkout_entry
  read-cache: add invalidate parameter to remove_marked_cache_entries
  checkout: clarify comment
  checkout: factor out mark_cache_entry_for_checkout function
  checkout: introduce --{,no-}overlay option
  checkout: introduce checkout.overlayMode config

 Documentation/config/checkout.txt             |   7 +
 Documentation/git-checkout.txt                |  10 ++
 builtin/checkout.c                            | 133 +++++++++++++-----
 cache.h                                       |   7 +-
 entry.c                                       |  26 ++++
 read-cache.c                                  |   8 +-
 split-index.c                                 |   2 +-
 t/t2025-checkout-no-overlay.sh                |  57 ++++++++
 ...-worktree-add.sh => t2400-worktree-add.sh} |   0
 ...ktree-prune.sh => t2401-worktree-prune.sh} |   0
 ...orktree-list.sh => t2402-worktree-list.sh} |   0
 ...orktree-move.sh => t2403-worktree-move.sh} |   0
 ...ree-config.sh => t2404-worktree-config.sh} |   0
 t/t9902-completion.sh                         |   1 +
 unpack-trees.c                                |  21 +--
 15 files changed, 213 insertions(+), 59 deletions(-)
 create mode 100755 t/t2025-checkout-no-overlay.sh
 rename t/{t2025-worktree-add.sh => t2400-worktree-add.sh} (100%)
 rename t/{t2026-worktree-prune.sh => t2401-worktree-prune.sh} (100%)
 rename t/{t2027-worktree-list.sh => t2402-worktree-list.sh} (100%)
 rename t/{t2028-worktree-move.sh => t2403-worktree-move.sh} (100%)
 rename t/{t2029-worktree-config.sh => t2404-worktree-config.sh} (100%)

-- 
2.20.1.153.gd81d796ee0

     
