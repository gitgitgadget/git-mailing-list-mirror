Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21FE1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbfJWMDv (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:03:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39203 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbfJWMDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:03:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so12033637pgn.6
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gSGRaXHZ8FEiOYGtaDvzOnduKOGDoTO1z1YH2n+jAdY=;
        b=mgH8rIPIUBQ5bqf/1Ng9oWHzA2hRpGgUVtD+/sDqCTa9fi5rSPiFKB5nLG5eAaPDc8
         AfBv0xRiARLVoGKNVy3VWXSAMJ8P3CpXEQkDUubh+H1JYkkV7YAoD6ZfpOeDS9+xZRCq
         tT6JHRNsc98bMcPrGeZRIzyg9Rkca5qQBXeRdJTzW/2L7ilj14fIx1FxOW3pGkU1ZNYJ
         OFap29cIPwKt/dDmGroqjtBzSg9paxKEBmi5V/j2KxM1/MwMYeZ0Aa7eiRrfy8zKbtTc
         SB0BolAvSNGbIGz+5sGNWQzabXYorEVUmeKGNFr+mzkEXI70HqmY8hn+kaNxrNvxVJgR
         uq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gSGRaXHZ8FEiOYGtaDvzOnduKOGDoTO1z1YH2n+jAdY=;
        b=X+t5dl269kNuH7WRDFdchAB3BrXRoKhHltyW9AII7RfcEmgT34L6/MZKzd9NsNitvO
         drQ2NTMd3XaeFoO/3Rd0zoJoY6kl4pFyZNvv5ADzhtczglAsV8ygU19uTKcsJkEmaqZk
         BAIFOXnKH2Wzd+1CL00+uXIvqN1pRXodVNtsAoPRqoDOtSy7uG+OhFxGbiBCVjLZm3Rq
         dCTtN7xAfpCN98dvMR24Drn31rhJfEqxFbDkyYEnmTOIRfz0/Xu/54LVFVzTXGRnoApb
         g73xmGCnziqHlW648wc6/cLeUjoDvUVF20fySmKVHDQ68SKt4FBHcMJOXdo4vPaqM5s2
         t25A==
X-Gm-Message-State: APjAAAVtvaHB0eGPygCqpZ8LRD29KspYlZpGSPGcFwOxdahUsms90rzv
        CvOoNtQRAuX1iHi99ONMzWqoVTDp
X-Google-Smtp-Source: APXvYqyt0rKiv6sRAPiPtr5gqmKA/SaRCpvWEJlaVsUZGzVv3GnhpxgRG8iUwjP4bEWWt2tglE5xrg==
X-Received: by 2002:a63:6cf:: with SMTP id 198mr5544749pgg.259.1571832228253;
        Wed, 23 Oct 2019 05:03:48 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id o67sm21623021pje.17.2019.10.23.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 05:03:46 -0700 (PDT)
Date:   Wed, 23 Oct 2019 05:03:44 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] apply: fix merge.conflictStyle bug in --3way
Message-ID: <cover.1571832176.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a bug where even if `merge.conflictStyle = diff3`, running
`git apply --3way` would not output the base.

Patches 1-3 are general cleanup for t4108, 4 demonstrates the bug and 5
actually fixes it.

Denton Liu (5):
  t4108: replace create_file with test_write_lines
  t4108: remove git command upstream of pipe
  t4108: use `test_config` instead of `git config`
  t4108: demonstrate bug in apply
  apply: respect merge.conflictStyle in --3way

 apply.c                   |  2 +-
 t/t4108-apply-threeway.sh | 96 +++++++++++++++++++++------------------
 2 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.24.0.rc0.197.g0926ab8072

