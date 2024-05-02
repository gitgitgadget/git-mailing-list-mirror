Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952D208A5
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625681; cv=none; b=MJ0tgvbws58J6JmdYu3/jxgMSjJq9gW1PcuEFEGIhZA5y+opjB89SBOhvrqgBSofCAltQXLchNhBBGIt83oTCOhCTYcjvTbxFiqSQIbVACUt6P/Un/QvB99uNrzBXguwDdNTwxKbPce3Y7BvkQznF4+RTb4MROr/Vd6WuKMRzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625681; c=relaxed/simple;
	bh=uEHr4ZS7X/bZIOYID1msplF47dMxYIqUkI03R2KsVBo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BOtRq5LpjR9MJ9FUPce1CRY6prklA93qtqcoOAZGlll/DLKPz06wlrU7Pg38O3/rAENcWOepZhD3iA6lvwwIjndhMoU3wU02VRGolNjjChfvwa7dadngeTEiBUyfudfJz/9fTz/VcbsOb+aq5RRG2YL7rrvxvHxN10xeJyjQVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQJr+pyU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQJr+pyU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b794510cdso49143755e9.2
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625678; x=1715230478; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAnslTvdkZPeM+iwo8vx31r70Wcrsa/u5WxTuhuHa0g=;
        b=gQJr+pyUzOHR+G4hac+tYOOW212omNqxFBLDSMjJ7za2f5Dr9XUIcswoaGE1lf1eKb
         N/RAprEeEM4YK1tKEu3lg7QwHs1T6bD12/3TOAYaLw++KuL1fbz0RwH7JEmbpmeKqql6
         LVYpaUi85bnIQGqA6TPZZbJlLQVOEHpvyEyXqs4plG6HFTECT1bq1mUr6Sz8tjiuUJml
         PmBUDbCRrwKVo/65YXNFx5ZTPJtHGflQ3RDs2VVo6uPwdt7oULO+ZmQpyvkr/2tpoJ2r
         B2dECknKhRcrn8Cl76lTGy9Jgx1tRWld6jPK0CiBBpzDMMQNyg2ppWq42BZ9lPHcXULs
         TZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625678; x=1715230478;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAnslTvdkZPeM+iwo8vx31r70Wcrsa/u5WxTuhuHa0g=;
        b=XTtry6hvdyvifH0LQw7vwwB2LhzxST4mUGlrykp8DNRVCU0B0AvJpmfFnWdERqEXHi
         tnp/dyGmCR6z1j2bmTT7OEjXsLlCiESRmHvkYTj/JSqDhZ2x45+n2V44aXEscyHNnESc
         2nAG8GQsfzqj+Pdu+qFMAw0gRUgebf/yJzVhm8PIG4fw1hOXdM817tbmPBgMax9+hEOO
         hQMzwXEMALqN9kYMlg7hsLJQNyewrHiaRB5rDL4Kh6qXUZZ13Txuas6Qz/9ceXPG9fJ6
         UpnDpyMDScCB0kNw5M8xOzNhB3j4psVZazvzGpK4ii8i1R8MKGk9UkpAyQr1VwkdkIck
         WCrg==
X-Gm-Message-State: AOJu0YxDBPS1wiOQ+HSCG4rlqtS2B7/BDJlewf9jfw0q2Wnc0xRrf+73
	XyGzdl88KHmVH0cZuHngPJMuCDpml3Q3KysvuuxJH8Xxkgs+SkP01DXIAQ==
X-Google-Smtp-Source: AGHT+IGO2XZJ0m6Ti9fxLKvX9VODqKA3Nb51+CbCzhKNsDc0iPNm0lNKtFBlnPE+NgJ6M1hyHSgVzQ==
X-Received: by 2002:a05:600c:4511:b0:418:3eb7:e8c6 with SMTP id t17-20020a05600c451100b004183eb7e8c6mr2874092wmo.5.1714625677654;
        Wed, 01 May 2024 21:54:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b004186eb69a55sm507512wmq.25.2024.05.01.21.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:36 -0700 (PDT)
Message-Id: <246ac9a5d075870e07fe1485b0687f035facd3b8.1714625668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
	<pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:24 +0000
Subject: [PATCH v4 07/10] trailer: make trailer_info struct private
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linus@ucla.edu>

From: Linus Arver <linus@ucla.edu>

In 13211ae23f (trailer: separate public from internal portion of
trailer_iterator, 2023-09-09) we moved trailer_info behind an anonymous
struct to discourage use by trailer.h API users. However it still left
open the possibility of external use of trailer_info itself. Now that
there are no external users of trailer_info, we can make this struct
private.

Make this struct private by putting its definition inside trailer.c.
This has two benefits:

  (1) it makes the surface area of the public facing
      interface (trailer.h) smaller, and

  (2) external API users are unable to peer inside this struct (because
      it is only ever exposed as an opaque pointer).

There are a few disadvantages:

  (A) every time the member of the struct is accessed an extra pointer
      dereference must be done, and

  (B) for users of trailer_info outside trailer.c, this struct can no
      longer be allocated on the stack and may only be allocated on the
      heap (because its definition is hidden away in trailer.c) and
      appropriately deallocated by the user, and

  (C) without good documentation on the API, the opaque struct is
      hostile to programmers by going opposite to the "Show me your
      data structures, and I won't usually need your code; it'll
      be obvious." mantra [2].

(The disadvantages have already been observed in the two preparatory
commits that precede this one.) This commit believes that the benefits
outweigh the disadvantages for designing APIs, as explained below.

Making trailer_info private exposes existing deficiencies in the API.
This is because users of this struct had full access to its internals,
so there wasn't much need to actually design it to be "complete" in the
sense that API users only needed to use what was provided by the API.
For example, the location of the trailer block (start/end offsets
relative to the start of the input text) was accessible by looking at
these struct members directly. Now that the struct is private, we have
to expose new API functions to allow clients to access this
information (see builtin/interpret-trailers.c).

The idea in this commit to hide implementation details behind an "opaque
pointer" is also known as the "pimpl" (pointer to implementation) idiom
in C++ and is a common pattern in that language (where, for example,
abstract classes only have pointers to concrete classes).

However, the original inspiration to use this idiom does not come from
C++, but instead the book "C Interfaces and Implementations: Techniques
for Creating Reusable Software" [1]. This book recommends opaque
pointers as a good design principle for designing C libraries, using the
term "interface" as the functions defined in *.h (header) files and
"implementation" as the corresponding *.c file which define the
interfaces.

The book says this about opaque pointers:

    ... clients can manipulate such pointers freely, but they can’t
    dereference them; that is, they can’t look at the innards of the
    structure pointed to by them. Only the implementation has that
    privilege. Opaque pointers hide representation details and help
    catch errors.

In our case, "struct trailer_info" is now hidden from clients, and the
ways in which this opaque pointer can be used is limited to the richness
of <trailer.h>. In other words, <trailer.h> exclusively controls exactly
how "trailer_info" pointers are to be used.

[1] Hanson, David R. "C Interfaces and Implementations: Techniques for
    Creating Reusable Software". Addison Wesley, 1997. p. 22

[2] Raymond, Eric S. "The Cathedral and the Bazaar: Musings on Linux and
    Open Source by an Accidental Revolutionary". O'Reilly, 1999.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linus@ucla.edu>
---
 trailer.c | 21 +++++++++++++++++++++
 trailer.h | 23 ++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/trailer.c b/trailer.c
index 9179dd802c6..6167b707ae0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,6 +11,27 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
+struct trailer_info {
+	/*
+	 * True if there is a blank line before the location pointed to by
+	 * trailer_block_start.
+	 */
+	int blank_line_before_trailer;
+
+	/*
+	 * Offsets to the trailer block start and end positions in the input
+	 * string. If no trailer block is found, these are both set to the
+	 * "true" end of the input (find_end_of_log_message()).
+	 */
+	size_t trailer_block_start, trailer_block_end;
+
+	/*
+	 * Array of trailers found.
+	 */
+	char **trailers;
+	size_t trailer_nr;
+};
+
 struct conf_info {
 	char *name;
 	char *key;
diff --git a/trailer.h b/trailer.h
index c8c0018c54d..4e0a6789d7f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,6 +4,8 @@
 #include "list.h"
 #include "strbuf.h"
 
+struct trailer_info;
+
 enum trailer_where {
 	WHERE_DEFAULT,
 	WHERE_END,
@@ -29,27 +31,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-struct trailer_info {
-	/*
-	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
-	 */
-	int blank_line_before_trailer;
-
-	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
-	 */
-	size_t trailer_block_start, trailer_block_end;
-
-	/*
-	 * Array of trailers found.
-	 */
-	char **trailers;
-	size_t trailer_nr;
-};
-
 /*
  * A list that represents newly-added trailers, such as those provided
  * with the --trailer command line option of git-interpret-trailers.
-- 
gitgitgadget

