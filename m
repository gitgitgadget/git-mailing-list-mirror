Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D522FDC53
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445343; cv=none; b=asbpmUPlRRcPOCESvhIJJ8D77QV0bJRy3G3oYXcZKO+P1Fp01E3jIrMJN5dpGK34a0zwuf+FBZTpCyTj11AZZo5Qefa09Qt5uObLa6C+5yWV3eFmFdmLWjoCL4qPPSNZJX9STkZJPMZvsx+NbvxlNXEDFiLoe04MaWjv3vCiB9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445343; c=relaxed/simple;
	bh=emb5NtCrfsMUhqJqfr3eqypfIVh9X0QCmed4z1uIG/g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFetHQLH/e58OBlt7K87n8QKX/PvqH9qq8tfM/oImMLnltuOYd7snz0a7rc+6HzY7ycx5QomYuNeo7GHCNUVnrxDsNs6Za7vdr6dXF/jl/p/cTsfxpxVZpKRBEoKYs3fELNBRnAgBZiHTuAWtINkVXIh/KB9tHBMrncEDF+X0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJfz3+eU; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJfz3+eU"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a7b2a6b13bso4223376137.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445341; x=1761050141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FhD98s0xRcjdLk0SzOTIwFubiTKsdQFpQlb+mNWKJ5E=;
        b=TJfz3+eUydkflBMlLsHVTzYtDQA862xWGF7g5TTkikSrF/E3IUrW/ZUUHXL/xav6GC
         59UXa+TX0AQC+ZIOzwcoE5TX/yG0r8f24HH1xH2VDXSuPPRGoVLfrBvk/sbnGyleeetQ
         GeSLVhYvdJnm+m2OFVZm8f3ujKmXmt2JA3UU9rHThVDrC2sFsTuwhtFRgo01MXFUxiS+
         v+JcFwo1YCgmPGyvXf0iTwZh1mnk32slv6M0Xe6IYmTUegMR6hhM3Knf9iTcd2vY9ry/
         Hv7w4R2OGEo2F3Yz4WQgG1vJLhy7b92GfxhDzrIpnvmATblzyT/Cf3zfIfSl9EGi/n5C
         bXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445341; x=1761050141;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhD98s0xRcjdLk0SzOTIwFubiTKsdQFpQlb+mNWKJ5E=;
        b=gvk0mgPqvuTXAGcodMWUESx1vW+Q+39DT6Q/cF8jDsBZzkVZfrX7dpUjPJrHOy0r5+
         0rloT1QJJnp3cVHky3kmR091Bc0vzWJ7KN3EihmmYL9yfdiZM6JTNxiD0zOzQtcC8uif
         LjfGFfFislXhtH9jb1J7Qu2q8C/AgitfZbuQhMEzhqgta+t/HZ/42LHXNov/imxWPo8j
         hQ596eyckx79mNoP7L2UwTnkr/UtP0wbv4rI5sMY87UasgnHMB4XLsaibP8f3exy9Ejl
         e0fZzgUSKKQYiiwPtQVgdB+eIVyQ96vOqsdLstDPniRAvn7XUjNT7xbsPXQF/WnAStgq
         Kzxg==
X-Forwarded-Encrypted: i=1; AJvYcCXFUwcSccQ/Xud2ERo1k0sfDCUUZimZrWF8fFs09WPR38AhFBdd4udAsyW0QWxdcvEMoJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4w89l3N8mAqb4L5WIN/rapm2DWhF+t78ah4laOEI+e9weh6+0
	evYJzSBcZltAeYgaL2kJcxjN4VnACkL+91JVBgOGDYIrRyr6x8uJIisWoSuI+JYQgMHdE6pZACp
	yrlhqpdHY8NsFVnFt87+mdVd7wqK7PrQ=
X-Gm-Gg: ASbGnctnv66uteR9bZKewJGUueUJUZ2I7572FLwjXSvSHpC2GQ9KZmLltghWLQAV3Gi
	OYgnKryHjWoJLzvcIO9T7hT07o3EHKcc6j43zv4d+6vTeEehLk45aLfzWSwNpXWyGkf+W1qLAFa
	kFfpZIwMcFimDhpB7C9V7zdL96+Jk5YutXGOlmls0Ii2kVpTiIxt4hzrxckYQg1wcGwhKIuAGY2
	UUfCu/lezkZp93o1JGtSbk4XhCzQuow5divkcRN/in9GlMWbaX6YC+kIzCYqef8CFHMAFg=
X-Google-Smtp-Source: AGHT+IFl4msMX70gBLomMai0dG5MZsl/SKJS5AjytemgjLobgUWCzH22OAC51JGOdz97kzlw+mFIZLk+0QZMbtGGewo=
X-Received: by 2002:a05:6102:14a2:b0:5d5:dcc4:bf47 with SMTP id
 ada2fe7eead31-5d5e2202de7mr10032172137.9.1760445340781; Tue, 14 Oct 2025
 05:35:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 08:35:39 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 08:35:39 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-8-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-8-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 08:35:39 -0400
X-Gm-Features: AS18NWC2CYh-Ns6XJ8-Rd-jR40dWjr_cdKDslrpheXGnH39LKMuL5KMx2s0JGv8
Message-ID: <CAOLa=ZRh8LDu=-PAxiAV9QxFtjuQtC8sOojZm-4=CgN6t4vJFg@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] add-patch: split out `struct interactive_options`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000002f2eaf06411d9f92"

--0000000000002f2eaf06411d9f92
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `struct add_p_opt` is reused both by our the infra for "git add -p"
> and "git add -i". Users of `run_add_i()` for example are expected to
> pass `struct add_p_opt`. This is somewhat confusing and raises the
> question which options apply to what part of the stack.
>

Okay. So seems like `struct add_p_opt` is defined in 'add-patch.h' and
`struct add_i_state` in 'add-interactive.h'.

> But things are even more confusing than that: while callers are expected
> to pass in `struct add_p_opt`, these options ultimately get used to
> initialize a `struct add_i_state` that is used by both subsystems. So we
> are basically going full circle here.
>
> Refactor the code and split out a new `struct interactive_options` that
> hosts common options used by both. These options are then applied to a
> `struct interactive_config` that hosts common configuration.
>
> This refactoring doesn't yet fully detangle the two subsystems from one
> another, as we still end up calling `init_add_i_state()` in the "git add
> -p" subsystem. This will be fixed in a subsequent commit.
>

[snip]

> diff --git a/add-patch.h b/add-patch.h
> index 4394c74107..a4a05d9d14 100644
> --- a/add-patch.h
> +++ b/add-patch.h
> @@ -1,15 +1,45 @@
>  #ifndef ADD_PATCH_H
>  #define ADD_PATCH_H
>
> +#include "color.h"
> +
>  struct pathspec;
>  struct repository;
>
> -struct add_p_opt {
> +struct interactive_options {
>  	int context;
>  	int interhunkcontext;
>  };
>
> -#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
> +#define INTERACTIVE_OPTIONS_INIT { \
> +	.context = -1, \
> +	.interhunkcontext = -1, \
> +}
> +
> +struct interactive_config {
> +	enum git_colorbool use_color_interactive;
> +	enum git_colorbool use_color_diff;
> +	char header_color[COLOR_MAXLEN];
> +	char help_color[COLOR_MAXLEN];
> +	char prompt_color[COLOR_MAXLEN];
> +	char error_color[COLOR_MAXLEN];
> +	char reset_color_interactive[COLOR_MAXLEN];
> +
> +	char fraginfo_color[COLOR_MAXLEN];
> +	char context_color[COLOR_MAXLEN];
> +	char file_old_color[COLOR_MAXLEN];
> +	char file_new_color[COLOR_MAXLEN];
> +	char reset_color_diff[COLOR_MAXLEN];
> +
> +	int use_single_key;
> +	char *interactive_diff_filter, *interactive_diff_algorithm;
> +	int context, interhunkcontext;
> +};
> +
> +void interactive_config_init(struct interactive_config *cfg,
> +			     struct repository *r,
> +			     struct interactive_options *opts);
> +void interactive_config_clear(struct interactive_config *cfg);
>

It feels a little odd that the `interactive_*` code lies in the
'add-patch.h' and not in the 'add-interactive.h'.

Should we also consider moving this or renaming the structs?

Nit: might be nice to make add the 'add_' prefix to them while we're
here.

>  enum add_p_mode {
>  	ADD_P_ADD,
> @@ -20,7 +50,7 @@ enum add_p_mode {
>  };
>
>  int run_add_p(struct repository *r, enum add_p_mode mode,
> -	      struct add_p_opt *o, const char *revision,
> +	      struct interactive_options *opts, const char *revision,
>  	      const struct pathspec *ps);
>
>  #endif

[snip]

--0000000000002f2eaf06411d9f92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a5da72048961957_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdVE1b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWdDQy9qbTY2MjRXR1o3cUR6bDFRZ1RHTzhDcjlSZwp0ellVZS9KN1hB
ekFEQkhFV2p2RHJrWTRudXJReTkvVkxYenlXN1V1Vlp3ZVpGT3NjdmdSTVZQaVdNZksvZ05sCk9w
eGVQMXEvSDdxZUxCd2dEZjF6bGxsUFAzUnYvYXpTaHpkblJCVnlraFBxcGRSUXBqc0lsWUR4Q2ZB
U1RXRVAKTUViRTg1a0NEcGtUcGtYMkUyRUxlejBCaDhqNDZIaEpwU1RHam5oKzNqTFNsR3NLK1dF
b0ovZUR3NWtMUDNCRwpEWCtsNXJEWjNxMkNTNWpnbnJMT1o4UUpKV3ZpeWpLRjA3cTRPSngwaXNs
RW56dlFRZHo1Zmo5RFl3SGhHdFErCjlvNm9qMWFxTFQ0Vkp1NUtQU3NuSFlXc3NtMndvcThmTGYv
Zm5QQnVtL1JsRkVXNWoyNW5uNXM2Wkc0emw0N1MKaEFPR2Q1bGh1Zi9EcXZrQnhtclgxSUhyUTZp
cVJ5U1ZZaVhKSFNnbnpwZS9UL1BJTkVIN3YrS1E1QzVqczlLaQo1Wk5TS2FnT05kNU9NS3dLcGZ0
Vkd6c0Nrc0lhcHJOUVNISFFvSE5UU1FuNThEWEY4ZDNZVTNmUVNsNVAxR2lqCktncTlvNHZidkJV
cXhGYnVkMkdiRTI5QVQyaXpQYm1xbStYRDJ3PT0KPTJZTTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002f2eaf06411d9f92--
