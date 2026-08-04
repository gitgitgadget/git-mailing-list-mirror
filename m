Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9D45040E
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837865; cv=none; b=WMNhRtOA9lZPtTh+5scbslMxJKnbkHTLLFCe+/7X1o9tHm6R0xBFJ1FK9OSq9MWic5a9lkWjsSDcKhBbejlWJorY+Wbn/V3Mxf8/5SYGMnsmvZ+y4s/GuHAGZXv+CaXOFa2bFWn8iIJaALmugpOMLpTm9YiDGAkcGbeeRCrMZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837865; c=relaxed/simple;
	bh=Mh2T/TI9bYEeG0fR23j3HBUFR1iCU+APRoYdN+Dfvbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyrGMAiPa0GkimSgwf/JVMxOx63CoyrO0MFrqnkCKiOFS+Ac2sdq61m4BL7fYQbnkCtHjUQEyP6I4Fo6kO3GIrnxJqKlfh5oT2mgeU7VuBSsjvieMEwdEzx/8+1bwiLOux6ygC40Hir1rdSmgwtjHlezAM9fN6YP1efUkNyf8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCFok4tm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCFok4tm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954afac04bso35588075e9.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837862; x=1786442662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UrkIcRMroFRadRqZV8MTZjuNgcEWoTjXziCETOzx/c8=;
        b=RCFok4tmKE1i7mURYNH6uqQHadxuQF9V1lsVt/v7hF7j5WAmRC8sop60xM5zkERueE
         ZQ44VViS3VdxylfTrYsfjv7tlAA14ORm6Dm/RJvmu+8rOODkTBBDx1CyCvENK74vjzcn
         fcf02FJVQAe4Sqo7aR/g/W8zPoaTr3JsDbjcxraKpALaeQILTZiWFidRvF4D1ytzfXw/
         9DQEgZp+AWNy1t3s8JlscE4N03/t3qnjQV+vNBV3Bso46cPDxDtAJBqya8TRL18WlMVx
         Kq09IPgv01YvOhX+/KgYysQfqy4GKkR7V8Yoex2Al2q0yNTy9ePUShLHh3xPAY0c9iEA
         Hysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837862; x=1786442662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UrkIcRMroFRadRqZV8MTZjuNgcEWoTjXziCETOzx/c8=;
        b=McTttkAg5GuX/1X/SbfhsFs5JbvojZhK6jqMac2p/ty3N65BZqdzQvbxXvCfGAkt+h
         APG6YRUDMyW13b+Ck+eVyoDh2WJy8BNVwHxEHysbboSdHHn4rAYw6j0UhtXkszPysgV7
         h+WvnAvueldbqvUU6lh4wFLUGy6FhjVGgIMymSXuf58OdMybgq9ACHj4hnQdKwzFoDpb
         PbwJnwcZDPBCZwQnfKXr6VpzJCnBnablDFldjq18pw5NsFLKLVi6P6lKCHLr7OcNYXRP
         CvKasETjBGaP7mfncijJag9VfPsvDmw6ugHtLhSnnp2D7Sk6jl699cnIyipmobcZRidP
         9BmA==
X-Gm-Message-State: AOJu0YxgICGjhfkxuVuwHmg7oO4yH14oZLcBFJ7osXDFARI5QhKJXxc7
	3EqSYzF3yi2MtM906pbXXbi/JBpmaIVVYyUTcMRGBvbfyV8anE8bS1dxPmLYYQ==
X-Gm-Gg: AR+sD12tePAx4HvtarMh6/Mr3kUTcoCpybYxoqqCrWEX+f6sulOQ14o0SlGET7iBnD7
	Ppo8cCMfuQAu49HQIrZkDHuqCW6kxmM1U67WrtERD3nTf1M16jCVc3swT7gTo+729I3UiTF6NkU
	5ierTFwVaS0hUfLfj+Q1o+L9X+vulztiLk1X2bnJywZdnr5p5vBg7E81DWK2LZq2ADhj+Yuk58G
	F59CZsWWoXFI1EpN5wE1vA4PoLNt7eeDhfsqdegC9neOOEqrZHwcs9ffy/JxrqYDXdRyHlNR2lc
	FoGe2YOBjPvJKjttPWFVs/C5X+ll+0zqiwIMxLoNf4Hsq88rxXl78OVGrxadLMc+b11u5W9TVm3
	3M5UqX/Nt6ZMw+9t8rwH+xa7pMBgAamhcUnVT+RTFNWlI4ePVbdJuwaY5vtkM5Eh7HIplwYgRNZ
	+BTESIWHiDe04zCg852lAh/Qg3uXB/0LyBINfTyi+0j2tCYHkSkg3I0iKp/C49W07xCQus7mFEH
	s23XhwXF01lwO+AENZnyXvmdeSRVEM11Uox4yQZ2fY4SCf/YQeTMjbeg5pKxAzdQJnhH9+ekqLF
X-Received: by 2002:a05:600c:314f:b0:495:4572:21af with SMTP id 5b1f17b1804b1-4980c673252mr264471645e9.9.1785837861528;
        Tue, 04 Aug 2026 03:04:21 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:20 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 02/12] api-parse-options.adoc: document per-option flags
Date: Tue,  4 Aug 2026 12:03:45 +0200
Message-ID: <20260804100355.1299498-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "Flags" section in "Documentation/technical/api-parse-options.adoc"
documents the flags that can be passed to parse_options() itself. It
does not, however, document the flags that can be set on individual
options through the `flags` member of `struct option` (and through the
`OPT_*_F()` macro variants).

These per-option flags are used throughout the codebase (for example
`PARSE_OPT_HIDDEN` is used to hide an option from `-h` while still
showing it with `--help-all`), but a reader currently has to dig into
"parse-options.h" to find them.

To remediate that, let's add an "Option flags" subsection to the
"Data Structure" section, just before the list of option macros.

Let's also make it explicit that these are distinct from the
parse_options() flags described earlier, and let's describe the `-h`
versus `--help-all` behavior for `PARSE_OPT_HIDDEN`.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 .../technical/api-parse-options.adoc          | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 880eb94642..fb4580e755 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -150,6 +150,67 @@ Data Structure
 
 The main data structure is an array of the `option` struct,
 say `static struct option builtin_add_options[]`.
+
+Option flags
+~~~~~~~~~~~~
+
+Each option can carry flags in the `flags` field of its `option`
+struct. These are per-option flags and are distinct from the
+`parse_options()` flags described above; they are usually set through
+the `OPT_*_F()` macro variants (see below) rather than by hand. They
+are the bitwise-or of:
+
+`PARSE_OPT_OPTARG`::
+	The option's argument is optional, i.e. both `--option` and
+	`--option=<value>` are accepted.
+
+`PARSE_OPT_NOARG`::
+	The option takes no argument at all. Using `--option=<value>`
+	is rejected.
+
+`PARSE_OPT_NONEG`::
+	Disable the automatically generated negated `--no-option`
+	form.
+
+`PARSE_OPT_HIDDEN`::
+	Hide the option: it is omitted from the usage shown by
+	`git <cmd> -h`, but is still shown by `git <cmd> --help-all`.
+	The option is parsed as usual either way. This is meant for
+	deprecated, advanced or otherwise uncommon options.
+
+`PARSE_OPT_LASTARG_DEFAULT`::
+	Use the default value (`defval`) when the option is used
+	without an argument, even for an option that normally requires
+	one. Only the last argument on the command line takes effect.
+
+`PARSE_OPT_NODASH`::
+	The option is a single character without a leading dash, such
+	as the `+` used by some commands.
+
+`PARSE_OPT_LITERAL_ARGHELP`::
+	Use the argument help string (`argh`) verbatim in the usage
+	output instead of surrounding it with `<>` or `[]`. Useful when
+	`argh` already contains a hand-formatted description.
+
+`PARSE_OPT_FROM_ALIAS`::
+	Internal flag, set on options that were expanded from a
+	configured alias. It should not be set by callers.
+
+`PARSE_OPT_NOCOMPLETE`::
+	Do not offer this option for completion.
+
+`PARSE_OPT_COMP_ARG`::
+	The option's argument, rather than the option itself, is what
+	should be completed.
+
+`PARSE_OPT_CMDMODE`::
+	The option is one of several mutually exclusive "command mode"
+	options that share the same variable. Using more than one of
+	them at once is rejected.
+
+Macros
+~~~~~~
+
 There are some macros to easily define options:
 
 `OPT__ABBREV(&int_var)`::
-- 
2.55.0.492.g44bba30fd7.dirty

