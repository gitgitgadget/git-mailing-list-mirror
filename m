Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5EC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E120936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 02:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMzvCiUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIPCJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgIPCJW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 22:09:22 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F6C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:21 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h6so4974285qtd.6
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 19:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCX8i/EMiMuJdCHdZEBkSX3WgPzjDZBzpvo+UKtcuwU=;
        b=hMzvCiUL5NAu0uGZ11sR/uo8e4aLQu5MAFYNzQkSqb7cADN/4i+gJpnV1G/5PDBMdt
         fbifhWmcKe6MVrTYOObUwn6uSykg3qjblE28BtlRXIrXM3KjZ5gBpXZYagnAULX+GCJo
         NBv39IVUTn9x53iXujzip4HgUNiPv0HoguQ8RnyHQiR3RjclJktHWIV39D4zy5mo8gfn
         n0/m5KeADmuSPrRsJvBZR5ysOwQHa89YnVXZd6SXO8hI4VGNCPPaUlqGA5OCSLA2qpaL
         Xl48/8eL/6X/oH2HmS7H7TBzQAtYEaRFCIq7OLjfBwhyr+811hhYebTVEmGKrarsmxT6
         NlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCX8i/EMiMuJdCHdZEBkSX3WgPzjDZBzpvo+UKtcuwU=;
        b=EpnslHu8UL3nHFpC1LNhCoTac+n5bqHyvrzIaoHhJxWFeH3K6p/ocP80ZJs2LfIkLh
         Vfi/T7VvPihd/U2uvrMU+Va9kso9DthRqBnPuSBcHhAQ6iIlApeY6Be/lnchxvj5ZTYw
         rsOrx8p0eCeiJwID1DgrZrLP33nvJI9sykcqlGN0L86SblS2wpoEfrjyXqwgJKeNt7kl
         sgMe9GBbE073y0064v0jwWSG+xB6/OZzc2y/tDL7bifMiFo/A2pUJ64PuaRRmKxmoTH8
         U2hnzixcMRJK5ibFfspmJ+iBvAgd6dgF8+KApn4V9gHLasYVlp7CW2VJBMM0J5zln46f
         X3Jg==
X-Gm-Message-State: AOAM530guIxMOFJg3hVp3zHzS4KBXOZqhJZXp3UxzbkhnydPVjhXXlCo
        fuQXczc9u75OsKPjsgZRhrJRElCDq0yNHcIe
X-Google-Smtp-Source: ABdhPJzGe9kY9RJ2sbeqCyteeMdy3xkXnXbO0jDQs8Gg+7JsaxiMX4crryJpqfj+dDeArpfDfqbXLA==
X-Received: by 2002:aed:2767:: with SMTP id n94mr21683854qtd.237.1600222160920;
        Tue, 15 Sep 2020 19:09:20 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id k52sm19380373qtc.56.2020.09.15.19.09.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 19:09:20 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v4 2/3] Doc: cover multiple contains/no-contains filters
Date:   Tue, 15 Sep 2020 22:08:39 -0400
Message-Id: <20200916020840.84892-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200916020840.84892-1-alipman88@gmail.com>
References: <20200913193140.66906-1-alipman88@gmail.com>
 <20200916020840.84892-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update documentation for "git branch", "git for-each-ref" and "git tag"
with notes explaining what happens when passed multiple --contains or
--no-contains filters.

This behavior is useful to document prior to enabling multiple
merged/no-merged filters, in order to demonstrate consistent behavior
between merged/no-merged and contains/no-contains filters.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/filters.txt          | 3 +++
 Documentation/git-branch.txt       | 2 ++
 Documentation/git-for-each-ref.txt | 5 +++++
 Documentation/git-tag.txt          | 5 +++++
 4 files changed, 15 insertions(+)
 create mode 100644 Documentation/filters.txt

diff --git a/Documentation/filters.txt b/Documentation/filters.txt
new file mode 100644
index 0000000000..4ee17afc01
--- /dev/null
+++ b/Documentation/filters.txt
@@ -0,0 +1,3 @@
+When combining multiple `--contains` and `--no-contains` filters, only
+references that contain at least one of the `--contains` commits and
+contain none of the `--no-contains` commits are shown.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 03c0824d52..aa5e4da142 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -370,6 +370,8 @@ serve four related but different purposes:
 - `--no-merged` is used to find branches which are candidates for merging
   into HEAD, since those branches are not fully contained by HEAD.
 
+include::filters.txt[]
+
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1],
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 616ce46087..c207ed9551 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -408,6 +408,11 @@ Note also that multiple copies of an object may be present in the object
 database; in this case, it is undefined which copy's size or delta base
 will be reported.
 
+NOTES
+-----
+
+include::filters.txt[]
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f6d9791780..dadbd71d62 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -377,6 +377,11 @@ $ GIT_COMMITTER_DATE="2006-10-02 10:31" git tag -s v1.0.1
 
 include::date-formats.txt[]
 
+NOTES
+-----
+
+include::filters.txt[]
+
 SEE ALSO
 --------
 linkgit:git-check-ref-format[1].
-- 
2.24.3 (Apple Git-128)

