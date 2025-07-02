Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362842459C5
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448210; cv=none; b=cBjwZuSmheu4ClNSrKLfouBUbmHrIH9Xs0AN1e0WLFlQhG73gsh55VgBxLyZsb13DcbKMlSMMPjqe4d+pPtpI9D9c5m+Fj9X72x/x1N062bDMxZpricoP0z8LUOQFR2frvv1NI0NsnXHugQIpkgh/PBv924fI6s9DYb6lsiL7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448210; c=relaxed/simple;
	bh=7pdUcBPPc2V82OiV7BHoVzO5jssFlrZjm5Ofqx2Sn7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=JKIcEaKEDaEgF9mxKLPgBt4J/Op7hQxVF1i/9tf/8CvX7UrTFwc+kOdmpnrtHrStK0sBantw5W2plTgm0/nleP4u4YaCwITrJKn5tI4fN+Djp7mREHFBfeLqjygJzbXJDmJG5x9HLAs1sidAGWFRbc6EyuT/qHT9HG7ZMnWYqR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvzFASKe; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvzFASKe"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0de1c378fso601441566b.3
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448206; x=1752053006; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w4CrdnTBGPiUcFkfNvrjTyalMPX/nwBaJl4bfWAF5Y=;
        b=MvzFASKeAdMVxaEFzVwD4XF0zl9HNYJ5Kmk2bEoQCnm7a3JTuQ0qNwIbvZD+1N1oun
         syEKaf0PWIDFJQuiXoIzNm6yOe/1WrGebm59EbGfEU2NsOTVZpJ2isieVM8he65QAkkX
         lc8ERh2sctyUGxVZCfcSrjP5M33FwcPcH1H96qne+gVnkffmt0PFXFOHx8rIiglTUT9a
         6A3Zhd59RfUMGC/Zp1k42LneNOT5Ehntp21pD5cw/sTxWy90/eBpkXHpZBnQ0evaS89Y
         ALpCL25u3nkSe7P1WDpC7IuvSm7uow9cnZjGIR3axyT8iTmAVUOkBBuHqi86ueYDxlER
         KgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448206; x=1752053006;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3w4CrdnTBGPiUcFkfNvrjTyalMPX/nwBaJl4bfWAF5Y=;
        b=TUMqDaxwP1l4CuH2XCrv851+rZ0cqJRFCOGwHPswb/4PZjE1/uuvappZbdQXchmZvp
         ZuQUFCcgqQneoNFnyMChP05GpR2M4Rb2OZhECy4aatDvy9IgchMEREQNvmz3GuAYn4Fn
         kDqwnq9COCtCPS2Q82xbFLijFBhNrKtvTb/SGb9fu6L6RsFDfJeHcqD60gKEXaUbL1Ck
         T6DVeYZhb86PyqJjHBbXgH8R3B3FeZhq46falQhj9nogz7a0tM0w6tcPxN7/9UkahrZi
         lS8sP+TNb+11Zd808D0jJpempd/PwErok2ZJhODtaixntfKLJQbqaJd0Rg7M3kW1zvbA
         lQ0Q==
X-Gm-Message-State: AOJu0Yz7+WevD/m/m0/zNRdIe7XgXA11aNdojJe3otM4xZ1phFf1Lwqa
	o/djmvKVYRjZxrDfOVMK5cR6d/cR7wVvCUIlf2KvsflVJ+qNaPJCNkzE
X-Gm-Gg: ASbGnctJcWXhol8vaEUq6MOKiBOVbKkuALWhRN4BWWXXbTRjLsUffS2XHADvz3Wbary
	M4bIHE+svoBpkxVsXHVIesbsotU9wcod53PS9jRD6t3KpvpFiJ64vh6smYVUYWe18hifoLaadRg
	cLqA0EYI78UeFDIf9tBiU4lH/JcPoVoI+j/Yk9/+lYzxqJLl7QH7NZK338Nc9eT688CQj2/yQJT
	EwqmMxj17PGQOIQoptoIT+rM+bCEuhqk08Z3kVOlBoMZC3HMaCxsUPVOWsb8ewGU284ex6QFcgD
	pENjfK2O37zHvRokhJV5+XQqmrSgBAaPN38OO6JxPNID4A==
X-Google-Smtp-Source: AGHT+IHqH8mdcNyyWySV6j0jl8ZVOC3my6CyppYFQEe/YMlPeYRuTDxdm7DdXVNSewfyPmnXynyfaA==
X-Received: by 2002:a17:907:6e8b:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-ae3c2c37f5amr201455666b.26.1751448206167;
        Wed, 02 Jul 2025 02:23:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:56cd:2345:b424:ce97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1b9sm1052809066b.12.2025.07.02.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:23:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/3] clang-format: modify rules to reduce
 false-positives
Date: Wed, 02 Jul 2025 11:23:17 +0200
Message-Id: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIX6ZGgC/5XNsQ7CIBQF0F8xzD4DVGhx8j+MA1BoiaUYqETT9
 N+lnTrq8Ib7bnLujJKJziR0OcwomuySC2MJ1fGAdC/HzoBrS0YUU4Y5ZcDKefkwoIdSgw3Rywl
 8iAZiUK80geANoVwLQZRAxXlGY91727jdS+5dmkL8bJOZrN9/9EwAA6/lWRitqW3ZtfPSDScdP
 Fr1THdihX8RaREx00q3ytYNqffisixfet+iCyQBAAA=
X-Change-ID: 20250625-525-make-clang-format-more-robust-968126c991b9
In-Reply-To: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6187; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7pdUcBPPc2V82OiV7BHoVzO5jssFlrZjm5Ofqx2Sn7o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhk+oru8fjCB8H1oPJDYJVcGyrF92u82mdg2
 O1TmvFpdOsC54kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZPqKAAoJED7VnySO
 Rox/kIQL+QH644ACD1G9ae0TKPjnx24BIPe552rSjmyX5heff2DreQei5il9/Avrs+JhFCzN6Ln
 iH5VdxSkwHELmXe3f2f8ICodcJPFMFGo2D9TJ2pElBgWhVuMYQIu8/VoiUatJmoADmRcDTWsB2w
 zbyDgXvI08iOM3C2twGtw/bwhzrGZIc0UmFX24ehHWjLz24am5Hvv0wgvTkrjhrqjV+P1sg+ySC
 vQ0JKArvBLv3nF/d8HN9u3am6WcppYDhcgzADiv4gfQf4ziNSW4UymRcsMK0nJpYOdsu+KC4UnP
 coh0cKJu1kLDPJERjvmTj3oP1bBM3loksuif1q06Y6vYlWcYSqsCLEl5R00Pzu14y+ekFWEza9e
 5LyTDz6uGpRgBwXxKknIZ7pnfspaxS/ZtU8XIFz603PEzhRnQlOJYr1XEQbuqoXX6PvEPsK5jGr
 zv4OhGuA6T1yuNXDMZ1h+DqbRtQTVPyS99uJk+oIp1AL7lzAn1Hn7HQ75gaw8DWrl9nvXlEhwz8
 hs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This series is in response to an email thread [1] around the usage of
'.clang-format' and its effectiveness.

The goal of the series is to improve the usage of 'clang-format' in the
repository. To do this we:
1. Reduce the number of false positives. Majority of which is due to
   line-wrapping. We remove the 'ColumnLimit' from 'clang-format'. This
   removes the responsibility of line-wrapping from 'clang-format' and puts
   it into the hands of the user.
2. Add a rule to 'meson' to run 'git clang-format' by running 'meson
   compile style'.
3. Make the 'RemoveBracesLLVM' permanent by moving it to
   '.clang-format'.

With this, running `git clang-format` for the last 25 commits in master,
seems to produce much less false positives.

  diff --git a/builtin/diff.c b/builtin/diff.c
  index c6231edce4..246b81caa2 100644
  --- a/builtin/diff.c
  +++ b/builtin/diff.c
  @@ -30,14 +30,13 @@
   #define DIFF_NO_INDEX_IMPLICIT 2

   static const char builtin_diff_usage[] =
  -"git diff [<options>] [<commit>] [--] [<path>...]\n"
  -"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
  -"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
  -"   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
  -"   or: git diff [<options>] <blob> <blob>\n"
  -"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
  -"\n"
  -COMMON_DIFF_OPTIONS_HELP;
  +	"git diff [<options>] [<commit>] [--] [<path>...]\n"
  +	"   or: git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]\n"
  +	"   or: git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]\n"
  +	"   or: git diff [<options>] <commit>...<commit> [--] [<path>...]\n"
  +	"   or: git diff [<options>] <blob> <blob>\n"
  +	"   or: git diff [<options>] --no-index [--] <path> <path> [<pathspec>...]"
  +	"\n" COMMON_DIFF_OPTIONS_HELP;

   static const char *blob_path(struct object_array_entry *entry)
   {
  diff --git a/builtin/stash.c b/builtin/stash.c
  index 7cd3ad8aa4..90e441a6e5 100644
  --- a/builtin/stash.c
  +++ b/builtin/stash.c
  @@ -1802,7 +1802,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,

 		  argc = parse_options(argc, argv, prefix, options,
 				       push_assumed ? git_stash_usage :
  -				     git_stash_push_usage, flags);
  +						    git_stash_push_usage,
  +				     flags);
 		  force_assume |= patch_mode;
 	  }

  diff --git a/bundle-uri.c b/bundle-uri.c
  index c9d65aa0ce..89f59aafe8 100644
  --- a/bundle-uri.c
  +++ b/bundle-uri.c
  @@ -123,7 +123,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 		  for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 			  if (heuristics[i].heuristic == list->heuristic) {
 				  fprintf(fp, "\theuristic = %s\n",
  -				       heuristics[list->heuristic].name);
  +					heuristics[list->heuristic].name);
 				  break;
 			  }
 		  }
  diff --git a/diff-no-index.c b/diff-no-index.c
  index 4aeeb98cfa..a3892a9ccc 100644
  --- a/diff-no-index.c
  +++ b/diff-no-index.c
  @@ -325,7 +325,7 @@ static int fixup_paths(const char **path, struct strbuf *replacement)
 	  return 0;
   }

  -static const char * const diff_no_index_usage[] = {
  +static const char *const diff_no_index_usage[] = {
 	  N_("git diff --no-index [<options>] <path> <path> [<pathspec>...]"),
 	  NULL
   };
  diff --git a/pathspec.h b/pathspec.h
  index 5e3a6f1fe7..601b9ca201 100644
  --- a/pathspec.h
  +++ b/pathspec.h
  @@ -80,7 +80,7 @@ struct pathspec {
    * For git diff --no-index, indicate that we are operating without
    * a repository or index.
    */
  -#define PATHSPEC_NO_REPOSITORY (1<<7)
  +#define PATHSPEC_NO_REPOSITORY (1 << 7)

   /**
    * Given command line arguments and a prefix, convert the input to

While now I'm tempted to mark the 'check-style' CI job as required. I
think we should do that in the future.

[1]: https://lore.kernel.org/git/xmqqmsa3adpw.fsf@gitster.g/

---
Changes in v3:
- In meson.build, set 'native: true' and use the variable obtained from
  'find_program()' directly in 'run_target()'.
- Link to v2: https://lore.kernel.org/r/20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com

Changes in v2:
- Drop the patch to add 120 column length to editorconfig. This way, we
  will continue to use the default of 80 columns. Adding a higher column
  length makes editorconfig combine smaller lines during block
  formatting. This is not desirable.
- Ensure that meson specifically checks for 'git-clang-format' and not
  just 'clang-format'.
- Link to v1: https://lore.kernel.org/r/20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com

---
 .clang-format         | 27 +++++++++++++++------------
 ci/run-style-check.sh | 18 +-----------------
 meson.build           | 12 ++++++++++++
 3 files changed, 28 insertions(+), 29 deletions(-)

Karthik Nayak (3):
      clang-format: set 'ColumnLimit' to 0
      clang-format: add 'RemoveBracesLLVM' to the main config
      meson: add rule to run 'git clang-format'

Range-diff versus v2:

1:  f8271d7114 = 1:  c7a7f6d798 clang-format: set 'ColumnLimit' to 0
2:  f49237edda = 2:  c68ea68349 clang-format: add 'RemoveBracesLLVM' to the main config
3:  8d2a1647a2 ! 3:  b972289ab8 meson: add rule to run 'git clang-format'
    @@ meson.build: if headers_to_check.length() != 0 and compiler.get_argument_syntax(
        alias_target('check-headers', hdr_check)
      endif
      
    -+git_clang_format = find_program('git-clang-format', required: false)
    ++git_clang_format = find_program('git-clang-format', required: false, native: true)
     +if git_clang_format.found()
     +  run_target('style',
     +    command: [
    -+      'git', 'clang-format',
    ++      git_clang_format,
     +      '--style', 'file',
     +      '--diff',
     +      '--extensions', 'c,h'


base-commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
change-id: 20250625-525-make-clang-format-more-robust-968126c991b9

Thanks
- Karthik

