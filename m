Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA04A2F
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091183; cv=none; b=EfIszyPpshd/18YGHWKBnk6vML6OND1fMsLu13EWqTEoAnsCq4FDVRW9dwC6AcHnlIVArBovdk4f2JmXHh6km19esyE8FghlTM7UL2pkPkdMSwn8U812nPJKQaD4rV4G7bKQObhPgZmNecpvvNa72hGQaZguOK8hlrw3T4FYSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091183; c=relaxed/simple;
	bh=cKifk+a+kcLT5ki9XCXaz3NFjqM+4wskDzsWFcb8FwQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=De6zH0xkpClDD689t5yOmhN4MPO4USRwePmEqtwBTLU2xKb0hUkx3ySKqw3QZH7JR/LNRRV6nYzqeRvytzXzLG7Q8gPYjywxXe/oZhnmldZHeAemtWso6DbOpqaBj9E2J22DmmKOb0IwQp5KQfG02rnKh3uXHvZ1CCok9QRCdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEqwxUZO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEqwxUZO"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34a32ba1962so1361059f8f.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091179; x=1714695979; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABhG4+2mPlET/KZ1W+ROLPBP4uDqCNh673WDJascm8M=;
        b=VEqwxUZOJToTAVQtWNx4GmbL0Nz8XlrCsWptWqs6vpaiw3DA9HvYxFPLIyPmniW1dM
         0444pyWoTyo7PDeW9gb9c62Ued+IvWpHb0JOWo5kmEYzfiHryBKXvUiUsA3SNnqqt1xK
         LKg6A50GvR+o6DV3vovVgpoDcJYCySBwOtiAABj2cwuHyRlb7OyqHXJNmaTvMP81KW+h
         U4vtuswmZlz/53g64KqRVAd3bdwOZ0+ZrWUfD77e/Bj+QeZa5dsRL5RxLvYsDh6UZlgZ
         L8uqje0xPX+9nGGRzllBrhf7HmJdJvrl4QChNInjW2Bjf12jYkhbKOhlNZZDYT4kuQ4U
         g5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091179; x=1714695979;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABhG4+2mPlET/KZ1W+ROLPBP4uDqCNh673WDJascm8M=;
        b=L1z8LjEd9vKXDsYT2wVlMztGc4UY5Vz+s2WgINJvzFQPwj3m/jDp1qiqCQ4dODS/Tq
         lwZqlnkzNxnDL4OH/0aPo15aOi1ThpCuV9Ocr8DxGFiORNVfRXltE1uRajA7OZAF87xu
         tNXhQ9cdniEEinBv4t6QEy5THibafkHiIkEe0k2M1FhmDgB5vYyzOxox0JFry0KkfvPy
         zXo/jgJobPlckoGbY1EilPNXPizWWJrMaUepUxgrKjlVKq5+IztcQQR/RxxN6S2889B2
         Y5GdYrHl/scVoUgDxUWp3Mvbrh+aHFSdCiuTG31gt3qsOO7neb15goNYHij+9A59GWFK
         wGMg==
X-Gm-Message-State: AOJu0YwOqgOA2+2JqE5ow7TunTqt4dmyWZyy5lRGr2emsLd4mOvQuVYg
	a1DgW7zzNsdAbM70Hpdc92TqsM7I7dBjlpvBzO8wVEn4wqxYELOtk0xPvw==
X-Google-Smtp-Source: AGHT+IG27CZXhTqwD/5mWvJZChttRktgMn5Ea9+bjsP46yjIK88InenO3jyJX9dptP2jvBrHk11p3g==
X-Received: by 2002:a5d:5987:0:b0:33e:726d:e963 with SMTP id n7-20020a5d5987000000b0033e726de963mr798257wri.17.1714091179480;
        Thu, 25 Apr 2024 17:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm20892447wrs.53.2024.04.25.17.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:18 -0700 (PDT)
Message-Id: <49c66c48cc1793744e7565f7ac1ef887c76da4a0.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
	<pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:07 +0000
Subject: [PATCH v3 07/10] trailer: make trailer_info struct private
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
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

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
Signed-off-by: Linus Arver <linusa@google.com>
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
index b32213a9e23..a63e97a2663 100644
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

