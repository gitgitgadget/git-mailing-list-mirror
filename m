Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830E3C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6A206F5
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 19:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lohQAOk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDITLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:11:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42785 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDITLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 15:11:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so1264499edb.9
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=fPBqiMlP0LYIgiwZhCyQ2S4KJoWUnmUXuicScoSWa3E=;
        b=lohQAOk6ZASyJIRpj2f3p+V87XXq3Hjg5MFZNiPlheqSc/+UNbOL5CJCp5SGC47kll
         V0137UUNGbeGQacVMdEus6pqEydo/NAITeuXijAY6pd/ZSvd8E66ypMz3UXUaJe6v5bi
         D7b0KjnUR4JV/A2ygPYpqSpKeTK+suzIz9aVCIbz46RNj0djAlQh3V4ocmOfWr4jsF5L
         JAQFIrZKuz/3sV85zT7O2w+oWR9yiYjTaw7XGHUngr+TSyTcQDf8e0gBBhr73beKyRds
         BgV8NZ2ZV8lhvYhnMQdnYSjlD/Kc/8BIZOSAJjhFMSn58neLcHI4wVy6V3iUaQ1aCA/6
         TTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fPBqiMlP0LYIgiwZhCyQ2S4KJoWUnmUXuicScoSWa3E=;
        b=IQWmDjU124iS6G4iPzfIRU5/8VOBOJY8bKbC/C8geXqiSZ6+/kSK6b4IR+oq8gnz7Q
         uchtNlAGu5I2XlRNU6GVjT+eD0w5XLCityq1ThLjykY3JzVGOdJZaVlhOCnjwI2+Spgz
         yQWZ5lzZLWbE9HEOtrPs5fX0LjYRaSnGtdgSmqwk1AVvzNDxwG7FBWCqe6ZkJ52A81A+
         ARl0FtrGGIUORtfYcNNoyhagReap9S8S5ERsYFmsft7vdtXqNRvYaS583OUe7J0FUN5T
         imUQ9TIohHE3DVKlvNp5QmDN2vigWKCexf9+/Mk0+UkETfjmqM0xfhPYObrSg4AmXD58
         fuaQ==
X-Gm-Message-State: AGi0PuaFnx/cNrRshf4sHgnqb6APU8z6LhzggDebfGbuef0rVcnlVwPH
        U6c16606I6vHC62tvFQnqXUEuYjD
X-Google-Smtp-Source: APiQypKs/KRoWzl9dADhY2fOCtKDJ3jgL7aiJVkGq2vQhCwKpPV8+15adJj9J0iN5CkQ1OSJtrNiXg==
X-Received: by 2002:a17:906:9386:: with SMTP id l6mr462916ejx.305.1586459495442;
        Thu, 09 Apr 2020 12:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y28sm69024edi.9.2020.04.09.12.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:11:34 -0700 (PDT)
Message-Id: <pull.605.git.1586459494321.gitgitgadget@gmail.com>
From:   "Alba Mendez via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 19:11:34 +0000
Subject: [PATCH] pack-format: document missing fields
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alba Mendez <me@alba.sh>, Alba Mendez <me@alba.sh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alba Mendez <me@alba.sh>

Document missing fields in the description of the delta data, added at
011b648 (pack-format.txt: more details on pack file format, 2018-05-11).

Also, the description of object entries at the main section is a bit
vague. There's an equivalent but more detailed description in the index
section; since they are redundant, put that one in place of the first.

I have also expanded tabs to prevent alignment issues and rephrased a
bit to make things clearer.

Signed-off-by: Alba Mendez <me@alba.sh>
---
    pack-format: document missing fields
    
    Hello! These are some fixes & improvements for the pack-format
    documentation.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-605%2Fmildsunrise%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-605/mildsunrise/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/605

 Documentation/technical/pack-format.txt | 75 ++++++++++---------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index d3a142c6520..b78e03137f4 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -9,7 +9,7 @@ Git pack format
          The signature is: {'P', 'A', 'C', 'K'}
 
      4-byte version number (network byte order):
-	 Git currently accepts version number 2 or 3 but
+         Git currently accepts version number 2 or 3 but
          generates version 2 only.
 
      4-byte number of objects contained in the pack (network byte order)
@@ -20,19 +20,34 @@ Git pack format
    - The header is followed by number of object entries, each of
      which looks like this:
 
-     (undeltified representation)
-     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
-     compressed data
-
-     (deltified representation)
-     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
-     20-byte base object name if OBJ_REF_DELTA or a negative relative
-	 offset from the delta object's position in the pack if this
-	 is an OBJ_OFS_DELTA object
-     compressed delta data
+     packed object header:
+        1-byte size extension bit (MSB)
+            type (next 3-bit)
+            size0 (lower 4-bit)
+        n-byte sizeN (as long as MSB is set, each 7-bit)
+            size0..sizeN form 4+7+7+..+7 bit integer, size0
+            is the least significant part, and sizeN is the
+            most significant part.
+     packed object data:
+        If it is not DELTA, then deflated bytes (the
+            size above is the size before compression).
+        If it is REF_DELTA, then
+            20-byte base object name SHA-1.
+            deflated delta data (the size above is the
+                size of this data before compression).
+        If it is OFS_DELTA, then
+            n-byte offset (see below) interpreted as a
+                negative offset from the type-byte of
+                the header of the ofs-delta entry.
+            deflated delta data (the size above is the
+                size of this data before compression).
 
-     Observation: length of each object is encoded in a variable
-     length format and is not constrained to 32-bit or anything.
+     offset encoding:
+        n bytes with MSB set in all but the last one.
+        The offset is then the number constructed by
+        concatenating the lower 7 bit of each byte, and
+        for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
+        to the result.
 
   - The trailer records 20-byte SHA-1 checksum of all of the above.
 
@@ -67,7 +82,9 @@ Ref-delta can also refer to an object outside the pack (i.e. the
 so-called "thin pack"). When stored on disk however, the pack should
 be self contained to avoid cyclic dependency.
 
-The delta data is a sequence of instructions to reconstruct an object
+The deflated delta data begins with two n-byte sizes: the size of
+the base object data, and the size of the reconstructed object data.
+What follows is a sequence of instructions to reconstruct the object
 from the base object. If the base object is deltified, it must be
 converted to canonical form first. Each instruction appends more and
 more data to the target object until it's complete. There are two
@@ -186,36 +203,6 @@ trailer	  | | packfile checksum              |
                   |
 Pack file entry: <+
 
-     packed object header:
-	1-byte size extension bit (MSB)
-	       type (next 3 bit)
-	       size0 (lower 4-bit)
-        n-byte sizeN (as long as MSB is set, each 7-bit)
-		size0..sizeN form 4+7+7+..+7 bit integer, size0
-		is the least significant part, and sizeN is the
-		most significant part.
-     packed object data:
-        If it is not DELTA, then deflated bytes (the size above
-		is the size before compression).
-	If it is REF_DELTA, then
-	  20-byte base object name SHA-1 (the size above is the
-		size of the delta data that follows).
-          delta data, deflated.
-	If it is OFS_DELTA, then
-	  n-byte offset (see below) interpreted as a negative
-		offset from the type-byte of the header of the
-		ofs-delta entry (the size above is the size of
-		the delta data that follows).
-	  delta data, deflated.
-
-     offset encoding:
-	  n bytes with MSB set in all but the last one.
-	  The offset is then the number constructed by
-	  concatenating the lower 7 bit of each byte, and
-	  for n >= 2 adding 2^7 + 2^14 + ... + 2^(7*(n-1))
-	  to the result.
-
-
 
 == Version 2 pack-*.idx files support packs larger than 4 GiB, and
    have some other reorganizations.  They have the format:

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
