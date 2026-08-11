Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1B41A4E8
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437216; cv=none; b=PTDr9SJFVW7XsaSqXaQ3vYtl3BbeTfx8EfaARLMPanoveb68K7Ahvj199Aahtrj7FreP1bO2HeH8zX9YyVk/eOdlUgVTj4XUFQg4SAcakOu/I8Ztq9MY8jNDMUkqYtm8MJb4K3Kbf+hxfrTH9AiHoMELntAb65swnBMhfTIPbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437216; c=relaxed/simple;
	bh=GQ3gm/mB737MPq2zbbgn8YveCAxUuMajGTVjwuXCFLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFKaenZWXkFbmSGFThjkDPunl6V0v2IHfu8JHTARLDB0L7ErKGasKwQSrWtUzppCXWzPm/ea+hlj2cPWkK5JKIpt8F7hgRbjdVNZFf6jJYfc9JollQU40so90OyvWVGXSjSkYPY0UZBpXFc3UvP6fqP5Q8/X2FMd1ikac3HNtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ+XUODy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ+XUODy"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956242332dso27102625e9.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437213; x=1787042013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQMwAeEbg8eUq4yTFbdwDklppRzNJTDATvvEcDzo5DA=;
        b=EZ+XUODyeyu2tol9v6+584tBD5k9ViCl6ei4L14Kcwnv0hpp2FNFAEAio2msUdD3GZ
         ueCVEKMHM3b5Oar9CEIcKsrs0Z4Oany9Fru12M68TNGCH6pU/cTmAoKZeoYpDqqmb766
         Lw1UFq92vVC1vzwtRT1+bTmdM7ndZR6bF6/loIh3GPBY4MfOreJ1HROvJzvNWxv2TfB0
         EiLcI6OTRY/GNya5sHT2iKhEfN99zTkdWthZPcZlbfzwbXpOMLaVQ1hFf9YWgZ15ilqH
         jLQI2Mk5XPs7tGWyU63WcrM1leHPhJ0XiIRtAklUSFXFUqfDkKjV+BuB69gHinLA/qIf
         eQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437213; x=1787042013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQMwAeEbg8eUq4yTFbdwDklppRzNJTDATvvEcDzo5DA=;
        b=maDh6AkdMoUrWipQernAR5dLPfK7nkI82XwuwtIZVWryebTiVJZTCyWn5MCxkERdvm
         E0keUAwxHTaJ/n2HDZD1hCtN+CFicUp8zOpuCo/YTAzCY2+/XWzFTKuBZX5wpXAdXrMx
         LbSwBqMjLuLmyoBv4ENJpMf8w+/ySEdA0aSSRs7rVyDSeVgL9XvyCDNDFCz1uZXWF434
         lKt3ksZiYY7KfdXa004X7UlxJahSLnKhOvMHv+hGNApIraAEzZgOOrCrBMCBDQkLkhFo
         KcOyJzGr68ncvDnBW+RGQALqUE7LDthf0ctrykVfbJmovGMEiy4EmIezvW1aM8t1awRQ
         SM7w==
X-Gm-Message-State: AOJu0YxLlJ9pyaC0vFdRStkZcMVnFBNilSxi/vyXs/pN/fRmPW8cl9bd
	hJMawTFbXwlRELImrBVl+u72bqXbH42tPJgQALIAkyjaKxWK3bNo08jLmkViNg==
X-Gm-Gg: AR+sD125ab+acJ3OktR26LkPGRBei5nGEM5jO1Xdis7kXi2AwpDF+sWAKlTpjgcnc69
	pqIk5iNaB/k2qq3a6+lgNeK6stHuWPjd/+Ykd04ygLrerDIsInX8wLdDgyZrgmeRuOY2DKqdCfc
	aonaFrJ0oNyqXvaNBxeC+O745EDCrhkpg527zLQJJrnoVoxAOKRIjy/y4bCrMEoVRPxXlxaDr2d
	31u2ACU8NfLltpTTE+EQT/2+Ka3eqObpUxZJraD5C86k8PVAPS+5mZlQTLGgwJEh4onqkkB7fu9
	rWsJijXx/nZy2/MWeBqieCg+ABkJ3AYFT4bEuC2aMrAibkOLuUUmkfIOIAglKt+uZWR4yDbBU19
	9CyCJiZjKlzdjqcKiXzRYnaqugVbN21WJNlh5kbYw4Q2if38LQyMhHmsCZmne+nZSouH6z2Fduw
	S+P9LtgG0rk48neS3No8fGrWHtZOCQLDXq/FuWoEsNGwxpChpiTOEDoi60wXRhYgT9Gz4QLKGtm
	SD8z1jcRLvL+0QusicNjJd8W0gWVt5YVAUG0cu/C8nbOerS+4b4/vMC1MTeK0fkvZcCod+TiViN
	LzM=
X-Received: by 2002:a05:600c:3b26:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-49978463aa0mr23808405e9.14.1786437213320;
        Tue, 11 Aug 2026 01:33:33 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([2001:863:5c3:4d0d:8be2:b2d7:3667:a5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c302sm18728075e9.1.2026.08.11.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:33:32 -0700 (PDT)
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
Subject: [PATCH v3 02/12] api-parse-options.adoc: document per-option flags
Date: Tue, 11 Aug 2026 10:33:04 +0200
Message-ID: <20260811083314.2023489-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260811083314.2023489-1-christian.couder@gmail.com>
References: <20260804100355.1299498-1-christian.couder@gmail.com>
 <20260811083314.2023489-1-christian.couder@gmail.com>
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
 .../technical/api-parse-options.adoc          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/technical/api-parse-options.adoc b/Documentation/technical/api-parse-options.adoc
index 880eb94642..5602cd44b2 100644
--- a/Documentation/technical/api-parse-options.adoc
+++ b/Documentation/technical/api-parse-options.adoc
@@ -150,6 +150,68 @@ Data Structure
 
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
+	The no-argument form is only accepted when the option is the
+	last token on the command line; used earlier, it still
+	requires an argument. Should not be combined with
+	`PARSE_OPT_OPTARG`.
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
2.55.0.530.gdb3615d990.dirty

