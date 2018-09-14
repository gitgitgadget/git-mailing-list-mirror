Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6B01F404
	for <e@80x24.org>; Fri, 14 Sep 2018 00:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeINGHl (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 02:07:41 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:50028 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeINGHl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 02:07:41 -0400
Received: by mail-qt0-f201.google.com with SMTP id f34-v6so6188602qtk.16
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 17:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5qQNkI1GmnuNcSZ6nHLORLhepR/PhfyidilJStdsQNs=;
        b=nSkPUO6tkGAHUAHko5YO1VS0Kxm9t/9qTVIDVyuZ8HXKcxrT12Vm12SMw70t2VAFNt
         o/HUp5DjmUm/tZy/lGRJiYID+izxii/z3JmUGnP0H8hoHVhbgaxLF3zok3q63fKSmTel
         VJhBcCBHAiJ0r8wDWlOHDkkyW7Tkb7hnQr2w1KeQcndCvLmvZkHUTokCCys7mAGnEKqB
         7yBKrpgeeNSspLfi3bvfE1rPmA0cok0D+IA4fONHE5nvZTUo0COyMJlaI69KtWdgp/yq
         KMmk0KyhXYmjeUmwtlfMX0f2fcifJxcyorCj/XrF3tKXo/qmZUx5vkjmv4T0NkNMLPoC
         Y2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5qQNkI1GmnuNcSZ6nHLORLhepR/PhfyidilJStdsQNs=;
        b=qJrpm0EB+iDCV8XS8h30mLs+4+A4tWYodXt/ph448o8PReZaU9avrTJeSzbLknA8cd
         ewkXUEX6n2vp3RLRGgoVJtM0b/F5+KxViYjSa/wrmGG3R3X4NGiT7zRqlmZXP1eCuIIi
         W1yFGaawJHWN1OmvOWQvK8hWeigLERKM/MXv/+GlrZj7zENOET3/V0PQqVQua19TYztW
         oO14ui+4tSrax3JxYFpdytuGGTMoS1kOchhVIcn89sab6VBg1iRm8T+vq0CEvHQzoAQx
         ZoSNij3CoQ2H4sWBKEmDlLpp3pf0+ZqOLDv3D2stTVuxpkMA1z9Ns9+DPsYnHAEMJ9ok
         9jkg==
X-Gm-Message-State: APzg51AnTRx5dtwEuPM2FU0QBbB4p12t0uH/agHoLEKaq1NtL+YVhVTA
        nKUwRN6ICcv9wihLswVA45fStM9QFH0=
X-Google-Smtp-Source: ANB0Vdb8JaLlcU0H7L7NXvzD9fGlchO8bNhh5gL1WJK4TzX0BmxQQ52J6HuPDxFu4dVZdeAFrUN9Q8DExtZ0
X-Received: by 2002:a37:a086:: with SMTP id j128-v6mr2918404qke.22.1536886545642;
 Thu, 13 Sep 2018 17:55:45 -0700 (PDT)
Date:   Thu, 13 Sep 2018 17:55:20 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1536885967.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH v8 0/7] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Things seem to have settled down in terms of responses, so here is a re-roll,
some of the changes being Junio's suggestions:
 - show a more helpful error if a positive integer is given after "tree:"
 - added a test for an issue that this patchset inadvertently fixes:
   git rev-list would filter objects given explicitly on the command-line,
   but it should not.
 - improved documentation on the NOT_USER_GIVEN flag in revision.h

Matthew DeVore (7):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: use BUG rather than die
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |  14 ++
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  60 ++++++-
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  26 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  38 ++++
 t/t6112-rev-list-filters-objects.sh    |  39 +++++
 12 files changed, 389 insertions(+), 124 deletions(-)

-- 
2.19.0.397.gdd90340f6a-goog

