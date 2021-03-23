Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA8C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F131B6192E
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhCWOUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhCWOUB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F7C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so15005648qtc.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSDuScO1lANtIurUGrIjjO8oLFXohueAM0HPRCi0A1w=;
        b=ZEBsvKK8bV7SBPiZPf1YyKQGFt5431RhLXdwkufqy/wJ5YUUcMA3Q+2XR3OtiaiwN/
         yBETwAtIHTfT2sO5MKqEm/beQKnfB78d4oQ35OrUe+RE6d7haN24mlGSerZefymUe62t
         k5FL6u4AHJahITAuitsXpCLdtliVwe/Ao5W/4eMu4Rb9mxDTrh9v3ZH9swWRhMqoOGyJ
         wO054VIOEZEMuVYSQsdV617uQHjQadRSbeeemsrOnPRtQmPTrc2eDWdKODAlMscaxieZ
         3E4FaKuzYuj6Yei4glJHbnZ7MV347ykGUgLUVtoDllfmzufa6uTeP7PPIQup0GiVuCCH
         bWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSDuScO1lANtIurUGrIjjO8oLFXohueAM0HPRCi0A1w=;
        b=VjW83CZsmYnYCZRxCqbtV98WaXDyj4LUw27ed8yY+C/PqVKJDvaQ9KwDOmtdJdSzF1
         DPCo9Lbf9dRCvoI53l7L1eH4IxsEqsdKylz4xGXnd7NhYoj6wh2cCKxa+Uj95+6qniAl
         DM4WSQzJW+XH2uk6WBrtH+0lNmpxTTecSw22hFlx5Z4LKeJygp7cay5ZGuUuc5u+WfS8
         P5elACRPDh5BVCQEm2e1Avs6EJWzevR7i0EsjP3q2kAlx2uR7p60LlYAz3iLTcVLkUsu
         WFI3KUSgE4UWibOZbDaHySAL/wAQe8ejJWHGEgmy81bGBZcjvCqTxEW+4KF3lRjtavHo
         l0oQ==
X-Gm-Message-State: AOAM533bdgJ9CjPIh9yrmOKjrjMA6yp90FcMKbvvI6hw7sH5DEsMyfzm
        qlDPkGW5pNuFptEyqI4EM6Ohuw==
X-Google-Smtp-Source: ABdhPJysRA0PnpncOyjNFbcdTZWKsDYueTry8bLz8XCb3zQ7JzlqtL07zwcHrrcLOrzuD1WsczmaXA==
X-Received: by 2002:ac8:57c4:: with SMTP id w4mr4355524qta.281.1616509199554;
        Tue, 23 Mar 2021 07:19:59 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:19:59 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 0/9] Parallel Checkout (part 1)
Date:   Tue, 23 Mar 2021 11:19:27 -0300
Message-Id: <cover.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1608128666.git.matheus.bernardino@usp.br>
References: <cover.1608128666.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Preparatory API changes for parallel checkout. This version was rebased
on top of 'master'. The only change required in this change of base was
the `entry.h` inclusion on `builtin/stash.c`, at the commit that creates
this header file.

Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add classification for conv_attrs struct

Matheus Tavares (5):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract update_ce_after_write() from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() taking preloaded conv_attrs

 apply.c                  |   1 +
 builtin/checkout-index.c |   1 +
 builtin/checkout.c       |   1 +
 builtin/difftool.c       |   1 +
 builtin/stash.c          |   1 +
 cache.h                  |  24 -------
 convert.c                | 143 ++++++++++++++++++++-------------------
 convert.h                |  96 +++++++++++++++++++++++---
 entry.c                  |  85 +++++++++++++----------
 entry.h                  |  59 ++++++++++++++++
 unpack-trees.c           |   1 +
 11 files changed, 276 insertions(+), 137 deletions(-)
 create mode 100644 entry.h

Range-diff against v5:
 1:  9909ccee14 =  1:  5e8a1b6a1c convert: make convert_attrs() and convert structs public
 2:  ec4e645aea =  2:  91d1a3063b convert: add [async_]convert_to_working_tree_ca() variants
 3:  1834a54dfd =  3:  ab1bf85b75 convert: add get_stream_filter_ca() variant
 4:  b26022af45 =  4:  01ac6176cc convert: add classification for conv_attrs struct
 5:  837fccde5b !  5:  4d85af1579 entry: extract a header file for entry.c functions
    @@ builtin/difftool.c
      static int trust_exit_code;
      
     
    + ## builtin/stash.c ##
    +@@
    + #include "log-tree.h"
    + #include "diffcore.h"
    + #include "exec-cmd.h"
    ++#include "entry.h"
    + 
    + #define INCLUDE_ALL_FILES 2
    + 
    +
      ## cache.h ##
     @@ cache.h: const char *show_ident_date(const struct ident_split *id,
       */
 6:  231e81fb82 =  6:  af8b1691cc entry: make fstat_output() and read_blob_entry() public
 7:  2fd8d35242 =  7:  b28e518c0d entry: extract update_ce_after_write() from write_entry()
 8:  7531ad195b =  8:  87b9d4590a entry: move conv_attrs lookup up to checkout_entry()
 9:  bf6b7259cb =  9:  aa36bfee87 entry: add checkout_entry_ca() taking preloaded conv_attrs
-- 
2.30.1

