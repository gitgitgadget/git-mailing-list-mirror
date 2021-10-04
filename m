Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9500C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0821611C1
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 19:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhJDTDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbhJDTDS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 15:03:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39EEC061753
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 12:01:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so68660759edv.12
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s48i5v8GwHMa/ouii3922x6xwOakkUk1PXb6afKIa10=;
        b=Sg4Xc8kZ+tjfle6YAKiwUx0bVFF8b6lAZGiqYABoIl4638v3af9L8buVdhO7qVVfz3
         x/XMKXm1sVUzwtoTHunGSZP/FP/A9nlU4WPSIlu3ptvjdBOFiS3n9SAHYZS8vw/24dr0
         /8ieYGwlOTiiYoxmploiPD42mCRG+5GtGGMHv7XxLsXzz8nCgla/WFkd9PVg3izroq7i
         rpJqn7AQAn5wCcJPpPRZ8onWplz+gw2mVs0h5It6wQhSKmJdfjYCpL1Oggp9OPmWiwnY
         Kd2BRALw2Lwa4sEMOVq/cDnkmCakHLvFYSgQ8Tw4kzmPTFxECTf23Z0wQmN8y0eVE4X7
         668g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s48i5v8GwHMa/ouii3922x6xwOakkUk1PXb6afKIa10=;
        b=Bx8QGZZDkM1BJiBmwiG3HIGnirObPNwsZFigNkkcy+sqdcHj7+7MlZAExNfvGP2gDs
         75xCaoqD/sNyFzhbtXKq55xFcbOp8q0jLvkj8SV4W37G58MfBa6a5MUXvM3CHVlAw+Vk
         hv19Rx7ccWbXstaLQyQzyRyXmQNMBGMLS/gchTBTU5YjF4PiCaEwAecNFDYjuVq/7Ynr
         Z49YeumRWtOQFqRClikkLJCSA4fqbHds8iQ8F+SNsXbRbK5OfNyd/X5YWLtC3RnppEfC
         TYKJNIGKxkH7TXC8Hswng4LdwEAz6+82OwCx34XDZhTxfyuT9JA2ZxjP9r4d2TPTOuoA
         q0Mw==
X-Gm-Message-State: AOAM53018UQNUpwKkPJ4d7NJfSs63NPu1SmFqroABPV3Q09DTWTyQ/0L
        qpcYx+lmNo/8Ne38Sd8UlRmpYcXGcSU=
X-Google-Smtp-Source: ABdhPJzotBTYMprzi2v4D1XFewEWTeeKp4DQL+rdru3a+Wf3p66YHouj/WNhhbfSw9lsvcT0AC/DBw==
X-Received: by 2002:a17:906:3281:: with SMTP id 1mr18877781ejw.167.1633374087179;
        Mon, 04 Oct 2021 12:01:27 -0700 (PDT)
Received: from localhost.localdomain (178.115.74.220.wireless.dyn.drei.com. [178.115.74.220])
        by smtp.gmail.com with ESMTPSA id v13sm6759357ejo.36.2021.10.04.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:01:26 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     newren@gmail.com
Cc:     aclopte@gmail.com, git@vger.kernel.org
Subject: [PATCH v2 2/4] Documentation/diff-format: state in which cases porcelain status is T
Date:   Mon,  4 Oct 2021 21:00:48 +0200
Message-Id: <20211004190050.921109-2-aclopte@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.dirty
In-Reply-To: <20211004190050.921109-1-aclopte@gmail.com>
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
 <20211004190050.921109-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Porcelain status letter T is documented as "type of the file", which
is technically correct but not enough information for users that are
not so familiar with this term from systems programming. In particular,
given that the only supported file types are "regular file", "symbolic
link" and "submodule", the term "file type" is surely opaque to the
many(?) users who are not aware that symbolic links can be tracked -
I thought that a "chmod +x" could cause the T status (wrong, it's M).

Explicitly document the three file types so users know if/how they
want to handle this.

Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
---
 Documentation/diff-format.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index fbbd410a84..7a9c3b6ff4 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -59,7 +59,7 @@ Possible status letters are:
 - D: deletion of a file
 - M: modification of the contents or mode of a file
 - R: renaming of a file
-- T: change in the type of the file
+- T: change in the type of the file (regular file, symbolic link or submodule)
 - U: file is unmerged (you must complete the merge before it can
   be committed)
 - X: "unknown" change type (most probably a bug, please report it)
-- 
2.33.0.rc2.dirty

