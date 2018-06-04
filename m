Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 122411F403
	for <e@80x24.org>; Mon,  4 Jun 2018 18:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeFDSs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 14:48:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53970 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeFDSs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 14:48:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so234166wmc.3
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+435tSI8n5/5IUdyslKJKEPNFmc7AN5YzbfV8WBbmtM=;
        b=grTeiJZen6ym/fmZyx33YhCL6CNbezA3daeNML3XzvEnpVECl402sCyERUj4OIZR2F
         HgLKWtiPqJbIPI2zc7FnGuEwItdC+ogWQaQEX/EoIFip03mmpOAoyw/bhGMCfa3prIQD
         5yg2EYD1mBQ2n8/fPANHYbORLnCx1AQjbu6w2LFRa/24IdBTO+/n0PlqWfbogbeYESep
         WTL/k7VxI9yh7DU+aMRCaSEu5RgTKPE6Q3pzv5FwNzYVx04ZiMPlj1PFLB9T2GJqqcel
         rFTJJQuuSwpsNbgtXp8UDdcWrbYX7E1CmMimDn6qnHGU1aYZA3uKoyPKRQtFsI+keZoZ
         5YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+435tSI8n5/5IUdyslKJKEPNFmc7AN5YzbfV8WBbmtM=;
        b=ogD3/DEehFx4EUs/NYpqj87V4deaYUKXhI5e+Qb6DxfjcAw2GUDlOC+X3dO4eLEvRb
         g2W8YyocfoIC910p5XZbjl7o8ahUR+PmuKVh8Z0Hh0wVGL9t1BX6oQ/cd03qBagElPKs
         OSXLooQADZtsFumKdKvigLfz8MkFRs2jdz1tPsvuakc61ZKhU48vX7f+fN7U+2HcJqQ2
         PsnOUTDJtTEksSg5ODG14i9KX6vMBF1z3FX/gUFoTKDRkhOha+DxZHc/esS9gcM7+At1
         iclCH/HOwlRrv5YRAw/GiL79a6WHdEEIq6RWr8p6Ty9wO62tkvnrQ3e4inkHILoZ4UEn
         QucA==
X-Gm-Message-State: APt69E1zbTZMFBucEJAkUSEjx5RP41HHmQtOL1G8N8wFdjZT1a4z1XP5
        f6SJrUjb1qarmIyGE7XzNkY=
X-Google-Smtp-Source: ADUXVKKZcm+uUO7jAGQmHRqdfIEOodCgiRVbrJ0efvs3oktxnaT5TbTGEpYamUyGmrYNOJ8CP8g9Vw==
X-Received: by 2002:a1c:b7d4:: with SMTP id h203-v6mr9583221wmf.161.1528138107008;
        Mon, 04 Jun 2018 11:48:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:e56c:af82:eed6:eafd])
        by smtp.gmail.com with ESMTPSA id c11-v6sm27247266wri.49.2018.06.04.11.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 11:48:26 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, leif.middelschulte@gmail.com,
        newren@gmail.com, sbeller@google.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH v4 0/1] merge-recursive: give notice when submodule commit gets fast-forwarded
Date:   Mon,  4 Jun 2018 20:48:04 +0200
Message-Id: <20180604184805.36332-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <xmqqk1s474vx.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1s474vx.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

The provided patch is in response to Elijah Newren's [0] and Junio Hamano's [1]
comments on my prior patch regarding the reasoning and implementation of a user
notification during (clean) merges of submodules.

[0] https://public-inbox.org/git/xmqqo9hg7554.fsf@gitster-ct.c.googlers.com/#t
[1] https://public-inbox.org/git/xmqqzi0t1waf.fsf@gitster-ct.c.googlers.com/

Leif Middelschulte (1):
  Inform about Auto-merging of submodules during merge

 merge-recursive.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.15.1 (Apple Git-101)

