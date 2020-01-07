Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1850DC33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB94E207E0
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmQ/B0iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgAGG6C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:58:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGG6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so52627090wrr.1
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MmvlsFD563WDnD1bJXLAPFvDnk2+ZIXc0o/3exv3T2Y=;
        b=ZmQ/B0iY5FezPgLnoiVPRAgGJWkBU3D46uzZXTRIPlnysDPB1NlL/lZlrFodWaYlTH
         f06M0utAuSeQjZZo9EJ/a0gNqXR0vqa4fS+J5wemXitJLIYF+48rja86AEwFoU1mi3EH
         KQSe0kKolevFF4jF2wlnnRKDmARfKMvJAFL3WnfyiD4PFCifFG/t43SAOEKF7mSOoNqg
         6hzH8qc+eIhCF2SBcngmKx0JTeDsTzIGUAebAd5JEwRbuJOliLO8q3I5QC2t792ZTAn7
         O32/f9zpP66GB46b+kAbNmXpQbNx39dH/gSFxupGyJR9ym/c6FDJ4c/kTZt9pxdWyOTl
         I6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MmvlsFD563WDnD1bJXLAPFvDnk2+ZIXc0o/3exv3T2Y=;
        b=fzQc1zAtlRp4swz6uP47lUhOuabcdUneSeJEh8ocaSbFoS/XmMvLX9XCm5oIahqxec
         bM164QHSBn/+yfxJeh0WX+1aEBYz66TPnr5Ku77iVYYZP2KIa1+x3AJk/pJiZBIW19SW
         Poq0gbGADhl/Yl5XKVscpK1FuJ1Q5oP43rP98FOZJruwMfcSr61tqAdk0rDYjxeV3u7j
         2gTbjt6WlgcNpS81po9POBau1842WOgyWVBzSZujaFgkD8YpbMu6CFTI+x8ZOlukxdWH
         aEsAUBSbtaIYsmCtsBWxAP+IeXBpmCa1SwmP0HenDs4cJQjph+6rHiyRxhkNL25DovUZ
         qMgg==
X-Gm-Message-State: APjAAAX9o1c8YVwa21RlCOs0XXX3PzMSPuvDWgn0nw8sdB5XGHdsrGSQ
        Y5tWQRXTWUNOX5e7orVCuk6O+G8m
X-Google-Smtp-Source: APXvYqxxbpGJcZEufFSYT5rtfNlaU8WiZ0BNY817K8h6bzwJHtZIlCu65zxKPuXcaFsexpp8iN8Q1A==
X-Received: by 2002:adf:de84:: with SMTP id w4mr102453990wrl.97.1578380279458;
        Mon, 06 Jan 2020 22:57:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm73850513wrl.17.2020.01.06.22.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 22:57:58 -0800 (PST)
Message-Id: <pull.686.v2.git.git.1578380277.gitgitgadget@gmail.com>
In-Reply-To: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 06:57:56 +0000
Subject: [PATCH v2 0/1] unpack-trees: exit check_updates() early if updates are not wanted
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In trying to understand check_updates(), I found I was able to simplify the
function by making it exit early when updates are not wanted.

Changes since v1:

 * Added two bullet points to the end of the commit message to explain the
   questions Junio brought up about function calls that are skipped by the
   early return.

Elijah Newren (1):
  unpack-trees: exit check_updates() early if updates are not wanted

 unpack-trees.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-686%2Fnewren%2Fsimplify-check-updates-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-686/newren/simplify-check-updates-v2
Pull-Request: https://github.com/git/git/pull/686

Range-diff vs v1:

 1:  de0f381284 ! 1:  dd27727332 unpack-trees: exit check_updates() early if updates are not wanted
     @@ -33,6 +33,21 @@
              These two calls to git_attr_set_direction() cancel each other out
              and thus can be omitted when o->dry_run is true just as they
              already are when !o->update.
     +      * The code would previously call setup_collided_checkout_detection()
     +        and report_collided_checkout() even when o->dry_run.  However, this
     +        was just an expensive no-op because
     +        setup_collided_checkout_detection() merely cleared the CE_MATCHED
     +        flag for each cache entry, and report_collided_checkout() reported
     +        which ones had it set.  Since a dry-run would skip all the
     +        checkout_entry() calls, CE_MATCHED would never get set and thus
     +        no collisions would be reported.  Since we can't detect the
     +        collisions anyway without doing updates, skipping the collisions
     +        detection setup and reporting is an optimization.
     +      * The code previously would call get_progress() and
     +        display_progress() even when (!o->update || o->dry_run).  This
     +        served to show how long it took to skip all the updates, which is
     +        somewhat useless.  Since we are skipping the updates, we can skip
     +        showing how long it takes to skip them.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      

-- 
gitgitgadget
