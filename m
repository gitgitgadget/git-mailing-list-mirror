Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D035C001B3
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGCSqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCSqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7905AE72
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3112f5ab0b1so5334643f8f.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409962; x=1691001962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LkUWRdj/6sf9x2AxsQFKLzsxSTfwf2GtlqlLHq4dWU=;
        b=hO+nfmHjdwJA/uZsU0CTFoOUmskAyEaPoKoPaPI9LX32eakuY/HmhnLPnIUF4G9JcQ
         gNWp4kLx900AFW/X+NPigLf0BCmuZuvzm7dT6IR5YQXWD6QAeNxoXHQ8zIEo2xbpISkG
         7CQu7b52OgqbKOxxtjvkGwAvhqFB4wc7Frtxb49GHO32WQ0Ip7wp65nAudyioOHRejH5
         YAYRrOtHqnsrKctyy4PWNV9u8dOLiWEgXUTocyxGqaidJ9uCjVLyk1w7HL/52chcwYXo
         2q1U+EhjPjvYiq/pmXHh+AZXplfFjBphzNbBzlC+QptF6FDVr7M22XLzmNCrebKC6tvj
         Ub6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409963; x=1691001963;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LkUWRdj/6sf9x2AxsQFKLzsxSTfwf2GtlqlLHq4dWU=;
        b=KYu4yFTU3TdkgThUxR4zek+5HYfgn5mV29II2QE+SIXhKHXx/b26SSGNxbqeCy2a+u
         PHsfKsAS+iz/rKwviu24M0dcpbC3jom0yC1+zDZ4Fa878MuNtR9GDTuXFHKNFrFgCnV0
         8PNHDVnInRWk+rNb6ia/Q4o26diig9KFVgRxZroi6990/WcDbB7dBLqJNpovUpP50vD+
         KAmwYUWb5klg439mYjMnPeZ0M7+HxXVdY0r0GRcaBhLNpEA6sq5bQFmnQK9oNXprQoCi
         jYxxAo6xeYwsbND7VMji0BqWh1kLS1u0KG+AkeRCstwgYghJRSffuTn+KQP/1nH2iP47
         YPWQ==
X-Gm-Message-State: AC+VfDyM0q2w0BXY2Q78aldXod7SmX85bvgRuyIJXsVZJjza3VHfcqpd
        DxhCphjpR65rqVZNrj+Ctm3FoLEbgmM=
X-Google-Smtp-Source: ACHHUZ47tlj4gWOmgDtD+vZOKmH//mRADSayddWxo4MzjqtHj2A17BULr/x7Bx9cZJCnnyCAi8WRhA==
X-Received: by 2002:a1c:7c1a:0:b0:3f9:b297:1804 with SMTP id x26-20020a1c7c1a000000b003f9b2971804mr8055940wmc.17.1688409962513;
        Mon, 03 Jul 2023 11:46:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c214e00b003f605566610sm15069961wml.13.2023.07.03.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:02 -0700 (PDT)
Message-Id: <063b5652c0eed158a4c8a96f2623d42d86a78286.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:49 +0000
Subject: [PATCH v2 01/10] gitk: add procedures to get commit info from
 selected row
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

These procedures are useful for implementing keyboard commands. Keyboard
commands don't have access to commits that are selected by the mouse and
hence must get info from the selected row.

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index df3ba2ea99b..6d12e04ca64 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1333,6 +1333,24 @@ proc commitonrow {row} {
     return $id
 }
 
+# Get commits ID of the row that is selected in the GUI
+proc selected_line_id {} {
+    global selectedline
+    return [commitonrow $selectedline]
+}
+
+# Gets all branche names on the commit that is selected in the GUI, or the
+# empty list if there is no branches on that commit.
+proc selected_line_heads {} {
+    global idheads
+    set id [selected_line_id]
+    if {[info exists idheads($id)]} {
+        return $idheads($id)
+    } else {
+        return {}
+    }
+}
+
 proc closevarcs {v} {
     global varctok varccommits varcid parents children
     global cmitlisted commitidx vtokmod curview numcommits
-- 
gitgitgadget

