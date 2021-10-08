Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10824C433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E026961037
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhJHQFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHQFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 12:05:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0E8C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 09:03:11 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so31455825wri.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x9Ve1tZewj6K6PlM1PVUHZyHW/GWlN0ZnaPrifWlv5s=;
        b=BGPPA2Lp6l6AG66DFXLtkSZpkPz8gtSh+NCgnymujkagoPpXJy0tQ4EO1M7VNvciX5
         x4cZegV2skwVsB9CIiDJaYx+GTvAUSl9TXecuMmWnXrXqLKcIsQvxXy6DlvX+G7/tYOl
         sjiNNWoOr4+kt+ravEEp1LsCWFlGR5Z2jfYCU1Vo5eonxb4qf9B3Djwv7asXn5f9WAJD
         JbYiFCWFJLHuLaXgc5IkbadKIaePYnHHDzXgRfSn1xoFgp2WEenG9gz3DSQ8AgQG6C4e
         CPzbcGfIkU0DCZPgt+/VMtTQmKD9Ni+i2hH6/7jgbiOnDbhXY3ZAKUb8b6cr0tPUf4AT
         pi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x9Ve1tZewj6K6PlM1PVUHZyHW/GWlN0ZnaPrifWlv5s=;
        b=atIN91Gjq1hlw61EzUcfC8vToltSj25yzaQeGcjW/vmNKpKC6IhYRJtIRRxVXJ1Ann
         7UUkl5sAQGPh7ZREcAC3cju4qAQ3C6fXOiIHWK/buecGkKLsL1bIdF6OIfXverhLhuRp
         r2GrH7pU8cgcyn2RzWz/OK+lyAdy0XFAGOEUflBjNLRpio2XjBFeZgetNyUPAh6Yzohe
         D1tXK+ba0W9ENhcgq6Czh01gsL923oS+/ITLEC5ez7edwEpMxEb1Ru0vgZcYk0NWAEe3
         5vllDs2gDXGbaxP3rdXl+d8SrESknNv6O5BkoJYmodlwhI9K9P4tzhgcKClOet7OtIrK
         evcw==
X-Gm-Message-State: AOAM530LY55/rsdnQjZSn9xBP8b+pB5XNnR+UEej2bmPWQ++UQWkRG0L
        u2YXgCkeeJe6jJx2x21hb8RocwpUml8=
X-Google-Smtp-Source: ABdhPJyPVmfPQAbZ6OyZ4Bcv6FLzp5F7lRB+GynllQdXywMdpCl3pvNYM8O7FSYWT6vPPwnhck1yIQ==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr4444808wmf.61.1633708989829;
        Fri, 08 Oct 2021 09:03:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z79sm3018927wmc.17.2021.10.08.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:03:09 -0700 (PDT)
Message-Id: <497c5fd18d7206c137d8a62d229d2f295c9fe4fa.1633708986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 16:03:06 +0000
Subject: [PATCH 2/2] Documentation: packfile-uri hash can be longer than 40
 hex chars
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

Packfile-uri line specifies a hash of 40 hex character, but with SHA256
this hash size is 64. There are already tests using SHA256 (e.g. in
ubuntu-latest/linux-clang).

Update protocol-v2 documentation to indicate that the hash size depends
on the hash algorithm in use.

Signed-off-by: Ivan Frade <ifrade@google.com>
---
 Documentation/technical/protocol-v2.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 21e8258ccf3..a23f12d6c2b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -393,7 +393,7 @@ header. Most sections are sent only when the packfile is sent.
     wanted-ref = obj-id SP refname
 
     packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
-    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
+    packfile-uri = PKT-LINE((40|64)*(HEXDIGIT) SP *%x20-ff LF)
 
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
@@ -476,9 +476,9 @@ header. Most sections are sent only when the packfile is sent.
 	* For each URI the server sends, it sends a hash of the pack's
 	  contents (as output by git index-pack) followed by the URI.
 
-	* The hashes are 40 hex characters long. When Git upgrades to a new
-	  hash algorithm, this might need to be updated. (It should match
-	  whatever index-pack outputs after "pack\t" or "keep\t".
+	* The hashes length is defined by the hash algorithm (40 hex
+	  characters in SHA-1, 64 in SHA-256). It should match whatever
+	  index-pack outputs after "pack\t" or "keep\t".
 
     packfile section
 	* This section is only included if the client has sent 'want'
-- 
gitgitgadget
