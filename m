Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC22F0C51
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869831; cv=none; b=TxSjRwHqbKbG5uKKlMzfirPtNmuT/Ea157ZlCK23m4Uq1xmCLAl5NdeX9liO4cTx1hmqeUQ38wSvESMFvCydzBBm/qN3xMvZa1kc6xxqIqY6j/KYC/osxuC1qMFi76HVsLT32eYqY3a6w9XC0xUN35yT2Hj+pC1sRlgGP3kfopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869831; c=relaxed/simple;
	bh=6xk4kUl4ZxJXDA19eCliIe5gd6hVNQ2MWsFiAnw4YFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eh6vxP10JsPumkXxm99oBruvg2HJ8sAFvpZoKCnOII6qapWVOZTxpXUPP0st4Ezc19oIY1vAYpw5O1FOqzLUV+kk9o+exA8EdU+lEHNkg5ik6N8Pn4zYe/iCShytmVnVXVcmJ1ANfTXsWSYj3VCQiZ+tD5ZRnZ6jF6B9R9cUThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hh2O4z7/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hh2O4z7/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so12345a12.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869827; x=1751474627; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MurrTWwXFlkmzkjqPLZAxLMtDvSihW+Dw8LGdmjHcIo=;
        b=Hh2O4z7/yCtiW2xztSm/GGVsopoFFddmYqaV9A13eHuhTFnuSf31JSO9o3vaGHM7Gg
         1N/N+y/jkQT954O8TZydoI1umoY8xF9dBQxDEAgi+sWrghonUP4Hg9o75vB1r/0yDhiG
         Dp3+wG3NPfHl4v6fbQAA/sbIXK7prNENTikqSYUYgRgxW2mXYOwi+wSrITq9IrFAxhMI
         dJq09XWHvm6l4j+yB86I2dghIW1yxQZFpW4CdpCNCgUNV0J4qaE9lZDw+mfFGF1GHhiJ
         DuqzmTDsjeJ9evw9zpJzIRrlRfpIYXo4pG/epVLrTMvi+zzZ6hqyInHH7/KIZmw6ZXKY
         ducg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869827; x=1751474627;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MurrTWwXFlkmzkjqPLZAxLMtDvSihW+Dw8LGdmjHcIo=;
        b=kurFTnNRaKVjAMsAfsWyk6RaWsRF0SoefSDi9e/5nFGYOpHOLZOmpPNa3C9fz05a4W
         b+bDQx7aKJv5LiIOwCaDlWeFC3U7EOgHQFZUqVhzctC7vVORGSire5JFMCNbRY0irKWx
         zPM6PKB+HF/Un1VBBW08TUFA3H3QEUk9Umvjworr+VXznVxJ/3iT+KCF8Ba2IwzWCyA/
         JhULoWHr6/Bx6UeTJ8fG0Z1XO7W78A5vTxXJeIE/FWba18mAkp0wuufkeVET51+tVL9h
         bOvy5OBeFfVZTCSySjljKYdu5QgGYtXyIQvC7nAY0XIN6x7IknOGG3DzQ3qnEKNs52uZ
         FtUQ==
X-Gm-Message-State: AOJu0Yy23/bVlbHgXHSbeDmb1sRNjxlLTpYAhA5SpBSsdiC2JZVnQAxD
	5xcIt+P+VEFXQdqr7D+pG/AvwnZgXrRIT1CpksJgn9HfS88qANGcrSIZhge0xUlo0Vo=
X-Gm-Gg: ASbGncs+1iJHu3JniNL/xZa/K52cIJerFk0L13xdO1BjuaanF6kWOWev0qCR8bxuszu
	jgLRM3HOARuUmkaQrn1WWNaGSMUA1npB44euOPF5sbf2a+8z1vy6HjJTQ8l8ErZIF1xOR53omr1
	+9b8P+UHga9Bbjq9+qQ5MSLkG7SW3EkJuUljdhUuZyQXEuDQTPNukkS/V1bRA6SOtkL1EMH18oT
	rHdz+LVb5nknOrRUB6+WxCVXmvNbnHzDaOx3Bo5p22e6l/lSFHYHsUMUw80LETD/s3YMlRDN3LF
	S0dSCEEmSC+89SfGsHMUQwSR3lb69t7zsCjIRpLiNjeiIA==
X-Google-Smtp-Source: AGHT+IH5BEeKZe4y2j6gCsDlmNZ/2FruyAc6sbd6BYUIPLuIAplRf6du79hkhnRgjsy5sWowlswojw==
X-Received: by 2002:a05:6402:3514:b0:608:6754:ec67 with SMTP id 4fb4d7f45d1cf-60c4dee1430mr3210383a12.30.1750869825092;
        Wed, 25 Jun 2025 09:43:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:b5f1:56b2:13d2:a5cf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm2661774a12.35.2025.06.25.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:43:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/4] clang-format: modify rules to reduce false-positives
Date: Wed, 25 Jun 2025 18:43:25 +0200
Message-Id: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0nXGgC/x2NQQqDMBBFryKz7oAJJDRepXQR07EOGlMmKgXx7
 g4u3uLx4P8DKglTha45QGjnymVRMY8G0hiXLyF/1MG21rXeOnRKjhNhmjXjUCTHFXMRQin9Vlc
 M/mmsTyGYPoDu/IQG/t8fr/d5XnZbmIpzAAAA
X-Change-ID: 20250625-525-make-clang-format-more-robust-968126c991b9
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4826; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6xk4kUl4ZxJXDA19eCliIe5gd6hVNQ2MWsFiAnw4YFE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhcJz/XYaN9eavnEs70nAyIftz7Mpnv68cmb
 ULXhWaBcyhQG4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoXCc/AAoJED7VnySO
 Rox/frsMAJVAv1DemVPcObR52JlPpa+EAyaGISC4I6r+8KBmnn7F7ZS5QNn3A7NLfrOWZd5/CcS
 aqjoqw4xINzQAgNUVON/TUOroQ+cFNZtEb1V33IYXlO0xJZKW6897o8sJ1jD5JhXskCHeoBIqB3
 6RaBseQ/rKoMgly0y9Dyq8sl6nE9N+LQKQikWpjQXwdinO7D++cFdUNrwbg8NuspY453wKu3lcz
 cr8r67kjE+PcbPw68cgDDvEiNWltZw/BNGMKhg5SVcluZVmTswLg1MNvaAiaLSZulwFvNGbuast
 WDB+4MW0qcnDguEcq1tPjb+qGqpWZi1Xl+N1DlgjCEVQatpe/mQxo+d6eThQDRhZNroQVM94XP/
 4TI3ITjWIVuMj1vFdLqSW4am0vMLgDHXjf6g6LYqemOK/lQqJsk1C+Bh0RaDpKn0t6F24PHbrmg
 144KBgK6jYgmmQgOfIPGTQ/TQ4apNe8pTNQwcrtjApdtaKytNQW9TVPJhe5Ej1aLKsRoH/LESJ6
 o0=
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
2. Add a 120 character limit to the '.editorconfig' to ensure that
   editors wrap lines beyond that.
3. Add a rule to 'meson' to run 'git clang-format' by running 'meson
   compile style'.
4. Make the 'RemoveBracesLLVM' permanent by moving it to
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
 .clang-format         | 27 +++++++++++++++------------
 .editorconfig         |  1 +
 ci/run-style-check.sh | 18 +-----------------
 meson.build           | 12 ++++++++++++
 4 files changed, 29 insertions(+), 29 deletions(-)

Karthik Nayak (4):
      editorconfig: set maximum line length to 120 characters
      clang-format: set 'ColumnLimit' to 0
      clang-format: add 'RemoveBracesLLVM' to the main config
      meson: add rule to run 'git clang-format'



base-commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
change-id: 20250625-525-make-clang-format-more-robust-968126c991b9

Thanks
- Karthik

