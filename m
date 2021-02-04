Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096ADC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA15064F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhBDTIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbhBDTHT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:07:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA164C061794
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so2246527plh.12
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nHifqpaoWCPM5TGMO6nlc30LubOcJk/lRr8mR4S7jI0=;
        b=Z4ss7qubYkjSN2N8wsOufOb3XgzCkU7XdAksyYX9MBn5oN/8IbS0jrZkMtL1dnrEHS
         rRTCUm/3iUKtqhJJdMFkodwxX5wZONUhWRZYcZOJwtmaQ6bbgSmm+KZoEil1h5q8y8MA
         X9mUFDCdhKiUrqRl/4QwulCraT8mVdOYKqOo5QiL11CGHjgxF1Xm4ObciTyHBKVXFADi
         7E0lHBAbuhTfS+4WVQ+I+RqNdt0qzWECxk0h3wBbDipGlcKiY602yOKH7iht5ks9u21X
         cQjXC5+DekIbcx2tEIWqEGE62GU2k0Pp247auSq32OH07MS6NgWDLonyF+nnrT1i579H
         iNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nHifqpaoWCPM5TGMO6nlc30LubOcJk/lRr8mR4S7jI0=;
        b=eE89kbTJudjLgp/vA6Pq8uZxQUo30E7syL4Be0wJJ59JyL2WMxEivzaYPsyAFYheGw
         A6WuHim3FJnhpKtnXSdOXbVx78F0Z/p94ZBe4X7gH4PCNNFuD2WahaPAuxCxt0WC3w9r
         +BGtgt+ZK9Y3TQteWXjOb5GdDWy/d9KIpF3/h0a17947W5bRpfnZgAYxFxExg83z7K2R
         T7Y+dK9XD7qQ6snzKhyh++QhT6oOOfnNYZIVdYD0zFNacPyzZk0WwIk3v5XDDJOn5rOp
         0fuxhrRcNCoSZE0rOhIK9xH5h+9/KLNsQCPm8KPfQrJaEmdv6SEPjjIVwL3kiN4U1MtG
         VMBw==
X-Gm-Message-State: AOAM533B5HEoqDxAn7daexYcs9G1ikHbho2AXQyMPzZoDPWisbobz6GG
        s8/UaawljwIIACB+z1WVuL3Rmauiu9KZlA==
X-Google-Smtp-Source: ABdhPJy64DsnaLits2t3OkCrbmBHr9/2sRT9hEd7zoAJ0UL55S3EO4Vvmhu4Em0uVQ0VsNpVpdhGuQ==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr718905plv.77.1612465597672;
        Thu, 04 Feb 2021 11:06:37 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:06:37 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v5 8/8] doc/git-rebase: add documentation for fixup [-C|-c] options
Date:   Fri,  5 Feb 2021 00:35:07 +0530
Message-Id: <20210204190507.26487-9-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc5..97a8d2e1aa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -887,9 +887,16 @@ If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
+message for the folded commit is the concatenation of the first
+commit's message with those identified by "squash" commands, omitting the
+messages of commits identified by "fixup" commands, unless "fixup -c"
+is used.  In that case the suggested commit message is only the message
+of the "fixup -c" commit, and an editor is opened allowing you to edit
+the message.  The contents (patch) of the "fixup -c" commit are still
+incorporated into the folded commit. If there is more than one "fixup -c"
+commit, the message from the final one is used.  You can also use
+"fixup -C" to get the same behavior as "fixup -c" except without opening
+an editor.
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.29.0.rc1

