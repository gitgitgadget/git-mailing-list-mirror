Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B319A
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480356; cv=none; b=pKA5Eld6c9E7v/M757FdRpkHDCZnULX7l+BxT/akQeREgVLp6rAQt1r54Ot57UG35nCJbGSDD53xEQTWv4yxpDTcXzNxo23gXYEF0Hbm5FgJ7y7Lh7nLG5TIHlNS/fKr0bu5MtFLM2tzIKtD77GS2ojYQJSstmSD9ofRxyuL8Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480356; c=relaxed/simple;
	bh=V7w46kCLDr35/lDECy5COY3gvsdMEVt7nxF3KfmoRHo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnK9nbZtSjNk5EtBDgm0CrYDyeNegV4k4NMoxEo7eExzyoXhoW4lhpr3WLA2do2FNwcR0bFRMQk1D6jJKCw86uJTxMp1e5wDgI8+irmzTBpcAPQw1GKpXXfND+Lt9XSGNY44lUmanaZUOU+mzCMR2fCSg/5bjLWVJYsDiKxpfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNoSjnBJ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNoSjnBJ"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a77ea7ed49so3071711cf.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751480353; x=1752085153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2jpj3Z6cB7rSCyKS8oJoRRyi//EF/zTV3OrjAGAgpjI=;
        b=cNoSjnBJQ9nIOZv8Ua3047N0OxHQ8FuqQBKYlBzVekDEgommh8HT9urEoALetM54ZA
         c6tK8aDHthGPvydO9h9ZH1AFdimTNU+pp1ga8TSE57rA2WDwygazHNceZwV0F4AaoWAz
         lwREb7AY8ksygH3VqoxwZM2x/MuG38GZPCf0I7k17IIIQN6/wD80s34y2hQYCoJH4+PY
         LAOPceSnP2wjmMJY1kYEVZwJdSedpjMBpUpLc8rmFEN8a9sTYzHpjWKnfkEWj6S5T/Lb
         bpTy4GNYoJFJc0vlz6SDL8fj/kDdLtIIV3UH2PAtqIxciSoxtjAiIR7CtpuSps0w4ZG2
         H/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751480353; x=1752085153;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jpj3Z6cB7rSCyKS8oJoRRyi//EF/zTV3OrjAGAgpjI=;
        b=cqxdoalI9W5fJtt/MV0QrMldFv4ESAGmZ6nb7Jfdr4fzM3xDvhEhWAHrjPVDSHZEyD
         dKWZ/yybFyiJXA4n8DEa636PVkfJs/K5Y0VvBti+eb57ujCI0nWQU4Xt8Y5N5Uw7UBnT
         MYElvqPkTI1KQyrXgUnZV/ly0g/k4T2VBMXm8OSNf2QRoGlsikj7D3YplWDeUJpKxgM3
         0SAOw7uz1kzRTLBb8c+MDYLlVLgk29Q2qZl81/8GunYw4qf73TsydiSK/nIYjwA3NZ7f
         tJgY2Pvh8ZALizYtOVqp4B9H9tcZE3P0ven1QR1yM+fd8WtCwGr4ZDrZMHYjdvASW70m
         PTDw==
X-Gm-Message-State: AOJu0Yw3By5qX7uEtYtHiQqsatMrNTDnhgFzXQpb2hvMW1jXT7+LWPww
	N1bMaU0oWjCxwFXzQKWw7ZbNPGXmTP0FpjZW8vVpOQyceV5dzcOuUs+ndoXpIXIZW0uw4Odig6V
	CWKKOL9wZyNqFVkajwqsev9g00AQVmRHtkD18
X-Gm-Gg: ASbGnct8r1AZmzbxQdFijHaM0o5OnDzAua9W0Fqir2YbOKSvYifboJTj8zPAv2/VCLF
	9ARU+sTKapVjocwcKKOo7QL0b/ZwZNcxr9ARHOXhZlA5+D2bE8JosU0Wza3uXIeA8NWPkeE8UXL
	YwadQjuBUQWOiT1DYBUF3DQmHfxzOid+0fGYrjCK3HVxi+nCWrJtdIiQxCCDAosSbOBwpwI7JYp
	AyD1w==
X-Google-Smtp-Source: AGHT+IEB9BPx7HS2lfJhCsiO2HPbU0Whk6/Orp9mOJVTIMqF+xxCjooHKiZtz1xjBATt7xDpABVC6V8174ohtS84v8c=
X-Received: by 2002:a05:622a:58c5:b0:4a4:2fd6:90b7 with SMTP id
 d75a77b69052e-4a987337daamr8393841cf.17.1751480352687; Wed, 02 Jul 2025
 11:19:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Jul 2025 14:19:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqms9niod7.fsf@gitster.g>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <xmqqms9niod7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Jul 2025 14:19:10 -0400
X-Gm-Features: Ac12FXwpD4lIy1GklP0dWQTjnnxiAdbDcaUFnfGBkOW3mNlsy21CEzp-9N9_5xE
Message-ID: <CAOLa=ZQZcX7Bh=63Bv5Sti89jsjq=FzVbkqqsP5Tgd7NzNr96g@mail.gmail.com>
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via '--skip-until'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="0000000000004214d30638f64c31"

--0000000000004214d30638f64c31
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Offtopic.  After applying this topic, I asked clang-format if it
> wants to change anything.
>
>     $ git clang-format --diff $(git merge-base HEAD master)
>
> The result was disasterous.  Can "clang-format --diff" mode be
> taught a bit more focused to avoid touching existing entries in the
> same array (in this case opts[] that has tons of options for the
> "git for-each-ref" command), when only one new entry was added, I
> wonder?
>

I couldn't find any way to do something like this.

> Also I am not impressed by the change it made to the code that is
> commented out (in refs.h).
>
> Line wrapping it did to refs_ref_iterator_begin() is an improvement,
> but those to ref_iterator_seek() and do_for_each_ref_iterator() are
> unnecessary (both of these were more readble in the original).
>
> Even though I found its output better for Toon's "last-modified"
> changes, I am not impressed by what clang-format suggested for this
> series.
>

It indeed looks really bad, I had a go with the new changes from
'gitster/kn/clang-format-updates'. Which seems a lot better.

However, this does show a problem with using 'RemoveBracesLLVM', where
it formats the following:

  if (...) {
     ...
     ...
  } else {
     ...
  }

to:

  if (...) {
     ...
     ...
  } else
     ...

Which isn't our style, I think we should completely drop this too, from
my patch series. Let me go ahead and do that. I really want to strip out
as many rules as possible to make the number of false positives 0 so we
can actually start enforcing clang-format. Once we enforce it, we can
slowly see what additional rules work well for us.

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 543013cd11..2ec96eff74 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 #include "strvec.h"

-static char const * const for_each_ref_usage[] = {
+static char const *const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
@@ -33,19 +33,19 @@ int cmd_for_each_ref(int argc,
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
 			N_("quote placeholders suitably for shells"), QUOTE_SHELL),
-		OPT_BIT('p', "perl",  &format.quote_style,
+		OPT_BIT('p', "perl", &format.quote_style,
 			N_("quote placeholders suitably for perl"), QUOTE_PERL),
-		OPT_BIT(0 , "python", &format.quote_style,
+		OPT_BIT(0, "python", &format.quote_style,
 			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
-		OPT_BIT(0 , "tcl",  &format.quote_style,
+		OPT_BIT(0, "tcl", &format.quote_style,
 			N_("quote placeholders suitably for Tcl"), QUOTE_TCL),
-		OPT_BOOL(0, "omit-empty",  &format.array_opts.omit_empty,
-			N_("do not output a newline after empty formatted refs")),
+		OPT_BOOL(0, "omit-empty", &format.array_opts.omit_empty,
+			 N_("do not output a newline after empty formatted refs")),

 		OPT_GROUP(""),
-		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show
only <n> matched refs")),
-		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format
to use for the output")),
-		OPT_STRING(  0 , "skip-until", &filter.seek, N_("skip-until"),
N_("skip references until")),
+		OPT_INTEGER(0, "count", &format.array_opts.max_count, N_("show only
<n> matched refs")),
+		OPT_STRING(0, "format", &format.format, N_("format"), N_("format to
use for the output")),
+		OPT_STRING(0, "skip-until", &filter.seek, N_("skip-until"),
N_("skip references until")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
diff --git a/refs.c b/refs.c
index a4220d3537..d492e1b423 100644
--- a/refs.c
+++ b/refs.c
@@ -2669,23 +2669,21 @@ enum ref_transaction_error
refs_verify_refnames_available(struct ref_store *refs
 			if (!iter) {
 				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
 							       DO_FOR_EACH_INCLUDE_BROKEN);
-			} else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) {
-				goto cleanup;
-			}
+				else if (ref_iterator_seek(iter, dirname.buf, 1) < 0) goto cleanup;

-			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-				if (skip &&
-				    string_list_has_string(skip, iter->refname))
-					continue;
+				while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+					if (skip &&
+					    string_list_has_string(skip, iter->refname))
+						continue;

-				if (transaction && ref_transaction_maybe_set_rejected(
-					    transaction, *update_idx,
-					    REF_TRANSACTION_ERROR_NAME_CONFLICT))
-					continue;
+					if (transaction && ref_transaction_maybe_set_rejected(
+								   transaction, *update_idx,
+								   REF_TRANSACTION_ERROR_NAME_CONFLICT))
+						continue;

-				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    iter->refname, refname);
-				goto cleanup;
+					strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+						    iter->refname, refname);
+					goto cleanup;
 			}

 			if (ok != ITER_DONE)
diff --git a/refs.h b/refs.h
index c5e08db0ff..41fe96d688 100644
--- a/refs.h
+++ b/refs.h
@@ -1285,9 +1285,9 @@ enum do_for_each_ref_flags {
  * The output is ordered by refname.
  */
 struct ref_iterator *refs_ref_iterator_begin(
-		struct ref_store *refs,
-		const char *prefix, const char **exclude_patterns,
-		int trim, enum do_for_each_ref_flags flags);
+	struct ref_store *refs,
+	const char *prefix, const char **exclude_patterns,
+	int trim, enum do_for_each_ref_flags flags);

 /*
  * Advance the iterator to the first or next item and return ITER_OK.
@@ -1342,5 +1342,4 @@ void ref_iterator_free(struct ref_iterator *ref_iterator);
 int do_for_each_ref_iterator(struct ref_iterator *iter,
 			     each_ref_fn fn, void *cb_data);

-
 #endif /* REFS_H */

--0000000000004214d30638f64c31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5aff5a7ba62afb03_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1obGVCd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM2ZiQy85UFJhN0czaklnMG5Id2RvMmhZRFg3QzNWVgpmUHJOZ3o4ZnY5
QTBFSXlEWjVqV0M0akIrdC9mRDd6SWJ1eUcwbzJYbkl0MGhteU1QRUthNUtDWWlsdC9CZjFsCjdM
VjVoR1Q5UEdNbjNsZXMyS2k3VVFsK0R0WExoVUJ3Uzk4UjhoOGJPcGdWanlNR1dSYUNBb09FMlVL
R0NKN2wKazlkMFdtMlQyRVhxL01BVlNoV24rODlZaHI4WVNaZ0E2WXdBYmFWRThqY0lvTWFYMTJK
WGhMUTh2bzVOWTQ4dwp2OFFIZi9QeG91RC9Xb05FNnMyVkhYRmNCa21GYVZRWGdIYnNhZjN4OXJy
c24yR1I4bFlKMDlPcUY0V2lEbStGCkFLRW9xc3FpZWNXbDl1U0NDN2czM1hQOFlLVHQwdHdXZXhB
UU1sQVpNZ3NQa0hpMU5OQzU4NGppL0pBcktmaEYKRUhhbXR4NlpLQUc3SUVyNWtleVQzYk1VVXRT
SitpVVVtalcxRHM4QlRSbEVMckdubHRuaG0ya00zdWMyRy9lcAo3L254amVKUFlUeHdmNFF0TEdV
UWQrUDdESGw2bnBSWVdzYUVGdTRLRHh6dzM2eTJQb05nbm92WWloTVlRVU1qCjlSdkFkcWVXaTJr
QWpJazYvL284NnE5K0lETndjaTJIK1JDamNmaz0KPTR1dk8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004214d30638f64c31--
