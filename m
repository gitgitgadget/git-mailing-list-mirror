Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F61C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 05:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjDUF4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 01:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDUF4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 01:56:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF042109
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 22:56:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a67bcde3a7so20409305ad.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 22:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682056611; x=1684648611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIo2ynMcyDD6v0iCt2f1+H6ZKlLoGZET4EoM5x+Z69w=;
        b=Oe04hQufKAzG6Bmpjvn5JZSkaoFdSisoLwd6uon8jgprJCBU/a3xcYGhQ1VKGI3sZI
         SHuV+L/wyxar0xuUMBmKdXZYMif9THbKwVlRl4559o0WTIFKk/Ee7CQMSO/VX3PJ1Xwh
         /vZzIANOqhXAF/aWybj5LXVvAFtGaBsDEbQWZorRhoG1S6zAP1nW4Wb3r/Q/Cgb/2FOp
         /x4X4cRUidVBwE4Pme49HNuNDycsal2e71EdfP7ns/IAM3HhZ5edxnyxOZKWm0gJF35Y
         f3ve149GQqzce4rVVCVAOfI/1tmhxyFcdxay2lY6MeYM8c+p8enDjQF7lMnT5Xracc01
         SjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682056611; x=1684648611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIo2ynMcyDD6v0iCt2f1+H6ZKlLoGZET4EoM5x+Z69w=;
        b=ZTkntaFlbevmi2J6nYOZU6zH4CfGbQLpB3QTJs1NCgsHEBUbPe7/99B9Vlq4IT653z
         pUZY7+VdE591hhBogNRrUFd/SR+Yr0dJT4mMSXyQZpXlC7FDgTUTXur+ceqSbEcpnnAh
         vXzBQwmlhWoqU3FCVFTzNZcZnA++S/vVLfUZEpgPPqzn5i1xtTaRhlTmiBZxzZRLRWCp
         D4/ERgSL5GYVRmgNFvvySIY5pu9JJUuOYhJx1Z1F/YOmXCypc54qK7jfqrjSY9Q5k7PS
         8A2lWl6VCRJjKOtwZdjWVovxfn2brcXNA/a6YzaReeNQ+i4a6tbSfl+y2fsVzCbe/f52
         MzEw==
X-Gm-Message-State: AAQBX9dw2Mtr09JIdKKJv6nEnDTKHuuMFiM0qFpIrBX+4LeKxTUbN80n
        JbRudZggLuVDMMMLNjfWIyOLnT9xDAA=
X-Google-Smtp-Source: AKy350Z7y2GLMdjeuYvfAe23GhvsDwbRw4vyuMcM+fRAcDd8Nsnd6lzPEKfvfOBo79Psl2ADMXBebQ==
X-Received: by 2002:a17:902:f547:b0:1a0:6690:d3d1 with SMTP id h7-20020a170902f54700b001a06690d3d1mr4352669plf.6.1682056610726;
        Thu, 20 Apr 2023 22:56:50 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902bb9400b001a6392b073csm1736004pls.19.2023.04.20.22.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 22:56:50 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, eyvind.bernhardsen@gmail.com, tboegi@web.de,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] docs: clarify how the text and text=auto attributes are different
Date:   Thu, 20 Apr 2023 23:56:41 -0600
Message-Id: <20230421055641.550199-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two sentences are confusing because the description of the text
attribute sounds exactly the same as the description of the text=auto
attribute:

"Setting the text attribute on a path enables end-of-line normalization"

"When text is set to "auto", the path is marked for automatic
end-of-line conversion"

Unless the reader is already familiar with the two variants, there's a
high probability that they will think that "end-of-line normalization"
is the same thing as "automatic end-of-line conversion".

It's also confusing that the explanation of how end-of-line conversion
works is in the paragraph for text=auto even though it applies equally
to the text attribute which is described earlier.

On top of that, "When the file has been committed with CRLF, no
conversion is done" implies that normalization is only suppressed if the
file has been committed. In fact, running `git add` on a CRLF file,
adding the text attribute to the file, and running `git add` again does
not do anything to the line endings either.

Rephrase the documentation of text and text=auto to be clear about how
they are the same, how they are different, and in what cases
normalization is performed.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/gitattributes.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 39bfbca1ff..6db4ecd794 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -131,9 +131,12 @@ linkgit:git-config[1]).
 
 Set::
 
-	Setting the `text` attribute on a path enables end-of-line
-	normalization and marks the path as a text file.  End-of-line
-	conversion takes place without guessing the content type.
+	Setting the `text` attribute on a path marks the path as a text
+	file, which enables end-of-line normalization: When a matching file
+	is added to the index, even if it has CRLF line endings in the
+	working directory, the file is stored in Git with LF line endings.
+	However, if the file was already in Git with CRLF endings, no
+	conversion is done.
 
 Unset::
 
@@ -142,10 +145,9 @@ Unset::
 
 Set to string value "auto"::
 
-	When `text` is set to "auto", the path is marked for automatic
-	end-of-line conversion.  If Git decides that the content is
-	text, its line endings are converted to LF on checkin.
-	When the file has been committed with CRLF, no conversion is done.
+	When text is set to "auto", Git decides by itself whether the file
+	is text or binary.  If it is text, line endings are converted as
+	described above.  If it is binary, they are not.
 
 Unspecified::
 
-- 
2.40.0

