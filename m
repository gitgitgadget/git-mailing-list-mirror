Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30CE20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbcKAUIc (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:08:32 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33376 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbcKAUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:08:31 -0400
Received: by mail-pf0-f173.google.com with SMTP id d2so25427337pfd.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Me7/6HizXJ01yYKmZ9hQnfCf0zez6I7QiUPOt+QN8Vs=;
        b=owbJZ7YFL1u7FimjPnft/klJDQTFBt2CzgGRXcUfXT5IqYdHExo7jzbs98R6L3u6lN
         1fXHsK++cxVlaDFdPrScM3d1BQ+Sys2kV9mMPXk+8/jCH+A8ExbW+qtQYZCvinC05Q0e
         oeESd0vbSC93nlm53rNkR5CAt57ePM7916LvGC/+TGe9Qyla4IBIxsevN5g5I3m28aPp
         oCKbzydXDJZWLBlWvMTmteddVtygj4BzVCe6HsksXUiFhIk3arNk1rQ1b4FdxiDKXP87
         g1l7JJVQ5hrWUPKS7sAm9qriHUTl6qPErykdgcelNxvmTXl8BjD3q9f5t4PqlYeYGKe9
         /BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Me7/6HizXJ01yYKmZ9hQnfCf0zez6I7QiUPOt+QN8Vs=;
        b=I3CK+FdZW+UUSMke14aiSKAakUUoI/OOZgKgcPTKDTYLLsVrWt9YXpYznSxcAgbgBn
         P4Oww9L09P2udL6xiRMms4QLsCGI4BPhBIEBLkumPnB4WAOQq3B1L+xTP2IfkJHfxxEw
         57AKFHtvpj6+aXLpr6izL5sMWTocVcDzEorhG/GbuZbiKtDoHLpBnDhEi9r5sB5tGAjt
         SRFIx185fMuJrfCkZhZAEzXFLyirEepARp4FJPnUBtgcppwAnbsxXyN+AF59uNxjUoGq
         RUUqdu/MrJN5GKRk6tkif1WCdT4o3rMIJxtYOWTDOPCMD9r4QczgHd0dbSHbHa81/28z
         nM5A==
X-Gm-Message-State: ABUngvdCCoRg+1VPcNvHEYH7KewI71GRHgv7kS0AGo8ia0rbGk5Cg3aAqEMF+kMtxyKduibz
X-Received: by 10.98.74.142 with SMTP id c14mr25776738pfj.139.1478030910920;
        Tue, 01 Nov 2016 13:08:30 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v4sm44093272pfb.52.2016.11.01.13.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 13:08:29 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [PATCH v2 0/5] Make other git commands use trailer layout
Date:   Tue,  1 Nov 2016 13:08:20 -0700
Message-Id: <cover.1478028700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all your comments.

This patch set is now built off master (since jt/trailer-with-cruft is
merged).

I couldn't think of an easy way to clearly decide if a token with spaces
should be considered a token, so I've tightened the restrictions. One
benefit is that we no longer need to create temporary strings that
include '\n' to be passed into the find_separator method.

In 2/4 (now 3/5), I've also changed some variable names as requested
(e.g. sb -> input, and un-did some others).

Jonathan Tan (5):
  trailer: be stricter in parsing separators
  commit: make ignore_non_trailer take buf/len
  trailer: avoid unnecessary splitting on lines
  trailer: have function to describe trailer layout
  sequencer: use trailer's trailer layout

 builtin/commit.c         |   2 +-
 commit.c                 |  22 ++--
 commit.h                 |   2 +-
 sequencer.c              |  75 +++---------
 t/t3511-cherry-pick-x.sh |  16 ++-
 t/t4014-format-patch.sh  |  37 +++++-
 t/t7501-commit.sh        |  36 ++++++
 trailer.c                | 296 ++++++++++++++++++++++++++++-------------------
 trailer.h                |  25 ++++
 9 files changed, 313 insertions(+), 198 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

