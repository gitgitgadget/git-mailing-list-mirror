Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A1F01F406
	for <e@80x24.org>; Thu, 10 May 2018 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757423AbeEJS1D (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:27:03 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36997 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757247AbeEJS1C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:27:02 -0400
Received: by mail-wr0-f175.google.com with SMTP id h5-v6so2934137wrm.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L4IdSIRPaDZBR7e0yGScKDjKTdUwsGUssXAICYC2j8M=;
        b=BlRD/41KdcKnVcHiqhIyOFyDPx/6KmlT00Hc5bhUtz3/5z42sgAOEa+fRRMtcecmfo
         GISv8k5t0PIHYUblKKLcqsF8t3ovcPDeWlTa0DMHVh0uQyzXhH95V5WFiGspRWi4av2i
         ivnFFwtAf6oDMqcV/M/sMzPQ8xLaBS59AvfmU5HrHO51ze6XJmZhNcrHF44vqnA914G7
         EDy6wQjNyiSx4qua/PdAZC8FvrERV2rZZsQ+sf4VfVITIGrIOeziONpu7jjQdxO3W93u
         93uTY9fu1EnB9nvjcr1yqlljqjaxjkB0IKtK2bgZx/TmghpRoWfkU/+pkuFkKJcEJk1o
         xH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L4IdSIRPaDZBR7e0yGScKDjKTdUwsGUssXAICYC2j8M=;
        b=lo6F1FjV/1V6AmZjq+Jm/0pn7N7tU5fbcgoP3XejjH0ZEl0s6RUGR72aE6q6Qtipy1
         l6fVXbt7FLVs0l8I7RNMp8GLB/+Z65Z+ns2mJ5s5RYSCFokH5X4k8XPoGSKMUp2YjVcO
         Wo6h2mWHpoFyY71lk0MLGNIJikBvCzUU4SeJRQPstpMumrVVSku+9FwuJ+eRPF5Q+xPo
         c1SpnMyotggqXimPDbWxX9TCpI8y8L0o4qD6aOLxUxVaMj+vT/txIH/MlupKzdW35u3J
         /KsIzoPNKVyBeBJvqa7bTbu/EUTSFUnT8zAUna4MQoNLZ8+/PsEKxQLnWf14mZV8B3aq
         tUJg==
X-Gm-Message-State: ALKqPwcgWSEU51szSfDE1GD3D2PveSy6E/T6k9744JOB6a6jNEjKaqaq
        CGny2nsSSYhArBpnDaQmhUj3k18O
X-Google-Smtp-Source: AB8JxZodwDGL82RGsQ/YcTQU34tnGj+5O2b7qcPm9dzn4Yv4aUpxTtcDOlK9hjDZIXW89/RXoZrF0w==
X-Received: by 2002:adf:b509:: with SMTP id a9-v6mr2146115wrd.191.1525976820851;
        Thu, 10 May 2018 11:27:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:bd4c:eff9:63bd:dfc9])
        by smtp.gmail.com with ESMTPSA id v12-v6sm1383306wrm.68.2018.05.10.11.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 11:27:00 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.ath.cx,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH 0/1] warn about auto fast-forwarded submodules during merges
Date:   Thu, 10 May 2018 20:26:56 +0200
Message-Id: <20180510182657.65095-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Warn the user during merges about automatically fast-forwarded submodules.
This is just informational and does *not* change behavior otherwise.

It is a follow up to Elijah Newren's suggestion[0] to provide the attached patch.

[0] https://marc.info/?l=git&m=152544498723355&w=2

Leif Middelschulte (1):
  Warn about fast-forwarding of submodules during merge

 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.15.1 (Apple Git-101)

