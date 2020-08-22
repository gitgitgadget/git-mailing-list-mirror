Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217EBC433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 20:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E5C207C3
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 20:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDG42DY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgHVUcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgHVUcc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 16:32:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437FBC061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 13:32:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so4296373qki.12
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3OUWjQ/5dSuDDkuztomnVE+rxlpU9gKm5H/C7lFt5Y=;
        b=dDG42DY7Eers/Po0myxogX4/DZBOrCHrULNezkfUppa64h5WXS0SeZzP1bua6UdOqD
         X+nbZbLSv1tNRROGwuRIdTw9b3zDMZI5GC0fv1yGEQo3GpBamcRrahglDF3mMGgdMbpq
         39VP42wSykuXIOWEczZW2VGQE0b1qvEy0UWj2wGHp8vlK6foz5p51NOlTUX3bbAHq6Du
         f2xoVFddo2Hp4pl/N8zGu14CG+gihtLX9OYdvI2gqKjDj2G+S5B3Nev4oju/sOkRbH5K
         yIH8P+l1mi0HDS6rvnKCrgmulo95g1ZOq9XNws3dNhwyF0PMNkASm+wpPesvHVGHQaz6
         ylvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3OUWjQ/5dSuDDkuztomnVE+rxlpU9gKm5H/C7lFt5Y=;
        b=VLs4W6/8Nt5R0CoJHGHAEiqZUhxSFb6cHIPEDv4bWkWHN+R2yVuUaS+uXu7Fhd2qSP
         DxvEdxBZr+W/OuWwO6dU5OGZX4zCAhM4BKZ04hXcCwuMrxbWxVR18yfdCvBUCdWnEJ3r
         UZerZDvGx/YYkV3pLBA4BpYyyKvCeVjT4qRPps/TNqV5l5elxkP6xjns/T0OT2N4gYpu
         KiPcQLlDgAq+l2qWEbm8iQvSV/R+4anSo+BpRid2I46gOWQuRKtG0GXYpjZxb+hw0VZz
         uVBCWielYGYFoBX0rSX/epT3GY3WwPl8aoph+to14JbMQ2rTztGgUBhGwZApCDvnBkm9
         5T6g==
X-Gm-Message-State: AOAM53279enEGDIczJk9xE6aQDx6N3ZAazkGoTRyBmkQMD0je/UKpn1s
        ZpWkJzzB1IImxp0tx+zthl/8mAXgaF2pLyPt
X-Google-Smtp-Source: ABdhPJylusfDeS9bSMzwtAQPwkr0EpMZogX8b5UuF0JBR68s7VOPZts5+KHnr2PW9DsIfiOWsiyO2g==
X-Received: by 2002:a37:68c6:: with SMTP id d189mr6374923qkc.80.1598128351326;
        Sat, 22 Aug 2020 13:32:31 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id r6sm6523102qtu.93.2020.08.22.13.32.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2020 13:32:30 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH] bisect: add first-parent option to documentation
Date:   Sat, 22 Aug 2020 16:32:03 -0400
Message-Id: <20200822203203.66116-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that the [--first-parent] option is listed in the output of
git bisect -h

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
This patch updates a piece of documentation I missed when submitting the
first-parent option a few weeks ago.

 git-bisect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c7580e51a0..c28e35b0fa 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -4,7 +4,7 @@ USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|view|replay|
 LONG_USAGE='git bisect help
 	print this long help message.
 git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
-		 [--no-checkout] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
 	reset bisect state and start bisection.
 git bisect (bad|new) [<rev>]
 	mark <rev> a known-bad revision/
-- 
2.24.3 (Apple Git-128)

