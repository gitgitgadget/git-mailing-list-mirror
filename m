Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F66333736
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392952; cv=none; b=mufRlSptMUbvw2YVTTtTDAlZc/bosPSPYdUtJnn/D2SjwpQxfS5NrqXgSapMb7Snfo91HwSxenMJCI0uji02/XRNK7wKMezmLcL2bX3ltq8z+5vbqDx4QlJXJHTrzofAhMkO3B98x/Xx/2TxlTuF0iYLU8yZn4NUFLyP+164SJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392952; c=relaxed/simple;
	bh=fh0U2/Y/PO8hLs7Lnj7MRr2TO7XoxwZxMow9wWd+g3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JW6dCLx7kKWvZZv19YRY5bc5VgNAuFBXyjsN8LaQfYF3bPbi6ESbXHDxOT1UXfjSJRQD+kSY/sOAgTuIvOcuLqJShnlZKzGjSc9FTypwLCZumTppiS4RuFV0/PGkIjV/afin5ZTb570R2HCr4MpRDPvwArvLEi91fwcFTEHciHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPmXwopl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPmXwopl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98a619f020so3384861a12.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392950; x=1763997750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zUCgoLnR/e6HjRGCjISxGruEFCWE4gVKlWg0yPZpJE=;
        b=bPmXwoplth53CU7BTQX0Wl6IJe4kGJE1YJBcQQRsYKMtoCV9enmOtXJm3WZx9qGfjn
         uCcDHwvaB/GSpB0jaQZ2xMvIVb5RwZwbdL3N7irSa08xlFlZakHtNLopbRFqwX/INxEC
         70lUs2jnmxSd+aqW2maGya/r+L+EvA2xcx1HV2JnXuO+3UsbOkYe15EM+ufc00hOjbi8
         RZpS3ybPMZecK+1r4bfewa9XRZbCLzbwyNAhZ61Tt9AkEwGU63u9r3MIBKhu68Bcb2l6
         L4mnL4KDJM5dLliWNPg6zQ3ypfwNVG2iB8f/+UjG4xOfYj9PApH664W8+mWCzQ2JNS6u
         WFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392950; x=1763997750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7zUCgoLnR/e6HjRGCjISxGruEFCWE4gVKlWg0yPZpJE=;
        b=WRvOvl+0cUgWlou4G6HhV5F5agKw3YArWbjqnOM7o/5JaAi1u1rGnf4jfxTIwMbIBu
         4ZVJd3CDl2ZIkdiWvUEp1wrl7xBXUSqHzeRTxqO9gM5EBIOhDsxPbeDsABiXuH8iCGW0
         iPcJBwmZCDSGPCZlVmSG9oBZReUqyNXtlh8ePlWLByjAYIDMPqsTUezkbRbZg8oL8cKu
         BjpGJmKdsF0PMkzkCgENXys0775trmvq7Oat9JJXyippTiwMwwvEBLA6dglXbPViLNBt
         v4ufwIV/lr+H/W7iFcH3n5NWeksCsZDm8glESTfsokPYhJbPHR0tYi4g4NxMgrUHIixC
         +fVw==
X-Gm-Message-State: AOJu0Yypu7cwGK1Xo4MCUx1pbX6WQSz+plOr8jd8acgaWBbGFz9ZMLTQ
	i3r7NiDON7l3npWN1sfZ3cM9qPaEUKlL5FU7weZ2Io0oHrqYrp9ajb51aOU5USb7
X-Gm-Gg: ASbGncu09kHNHzxXEbZVCVD4u2Yc5EoeevMLhBpUYIqE3XGjcD+RnB+33ThwZf66f4z
	ka79Zgo3aVGAYLxlBMt2tOI6fzVsukhCfIM5FXHhCLSfP4LxQEicTWafUJWoTKAHymSh+0a25CT
	tjNUUGFfDXzWY12EDA8G3h17fn1Z3yvuizG8ppiTdIk07NU0aoqvv4cavB2f/ZIJYljP06DoIym
	UN/M1KNnXLun1a20hoInKRES2d9D3xDooDbMWaeRl6nVJP2/XVJxgCzsZPjZ0Pq4uogluPVQBwZ
	Lvuu22cmEoFVDonaN4SyUBkDIkUpSk4O6cZC32HZcQuo24uj54z9lhWCMFNCXi+8ULxz8fjGMOc
	hurmEIHIBpFmB4YDXURa7ZVfxR0oWaL7sYBCU/kd30gxiDYwFJ2gtTZ2PfDzcek9PZUPDCqC62m
	20hEJo8dAbOz4ViBJICaB5ANvBJuyPTDomir747vzeNqynOLRowIaVWvLJbN6szIPmn7hj
X-Google-Smtp-Source: AGHT+IFD8Yu7wE1lrOO/k4V4p77RPCJ1/rFLc95hcVLJjmMDJKrySAqBh0ww2NmFbF71rGQxJbmwaA==
X-Received: by 2002:a05:7022:6285:b0:119:e56c:18a1 with SMTP id a92af1059eb24-11b40fb08c4mr6254949c88.9.1763392949486;
        Mon, 17 Nov 2025 07:22:29 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm50245998c88.8.2025.11.17.07.22.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 07:22:29 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 0/2] repo: add --all to git-repo-info
Date: Mon, 17 Nov 2025 12:02:50 -0300
Message-ID: <20251117151844.14802-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Sorry for only sending this after some weeks. I've been busy finishing
my master's and I didn't have enough time to send another version. But
here it is.

This fourth version of this patch addresses the issues pointed by Eric
in the v3:

- I dropped the `strbuf quotebuf`, since it can be replaced by
  outputting `quote_c_style` directly to `stdout`;

- `print_field` now uses the string `value` instead of the
  `strbuf valbuf`;

- The variable `field` in `print_fields` was replaced by a pointer,
  since it didn't require to be copied;

- replace the help string by the suggested.

Lucas Seiki Oshiro (2):
  repo: factor out field printing to dedicated function
  repo: add --all to git-repo-info

 Documentation/git-repo.adoc |  6 ++--
 builtin/repo.c              | 62 +++++++++++++++++++++++++++----------
 t/t1900-repo.sh             | 21 +++++++++++++
 3 files changed, 69 insertions(+), 20 deletions(-)

Range-diff against v3:
1:  0db9aad2bc ! 1:  fce09770b8 repo: factor out field printing to dedicated function
    @@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
      }
      
     +static void print_field(enum output_format format, const char *key,
    -+			struct strbuf *valbuf, struct strbuf *quotbuf)
    ++			const char *value)
     +{
    -+	strbuf_reset(quotbuf);
    -+
     +	switch (format) {
     +	case FORMAT_KEYVALUE:
    -+		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
    -+		printf("%s=%s\n", key, quotbuf->buf);
    ++		printf("%s=", key);
    ++		quote_c_style(value, NULL, stdout, 0);
    ++		putchar('\n');
     +		break;
     +	case FORMAT_NUL_TERMINATED:
    -+		printf("%s\n%s%c", key, valbuf->buf, '\0');
    ++		printf("%s\n%s%c", key, value, '\0');
     +		break;
     +	default:
     +		BUG("not a valid output format: %d", format);
    @@ builtin/repo.c: static get_value_fn *get_value_fn_for_key(const char *key)
      static int print_fields(int argc, const char **argv,
      			struct repository *repo,
      			enum output_format format)
    + {
    + 	int ret = 0;
    + 	struct strbuf valbuf = STRBUF_INIT;
    +-	struct strbuf quotbuf = STRBUF_INIT;
    + 
    + 	for (int i = 0; i < argc; i++) {
    + 		get_value_fn *get_value;
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
      		}
      
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     -		default:
     -			BUG("not a valid output format: %d", format);
     -		}
    -+		print_field(format, key, &valbuf, &quotbuf);
    ++		print_field(format, key, valbuf.buf);
      	}
      
      	strbuf_release(&valbuf);
    +-	strbuf_release(&quotbuf);
    + 	return ret;
    + }
    + 
2:  b6ecdc2c2f ! 2:  ccdad86123 repo: add --all to git-repo-info
    @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
      [synopsis]
     -git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
     +git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
    + git repo structure [--format=(table|keyvalue|nul)]
      
      DESCRIPTION
    - -----------
     @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
      
      COMMANDS
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
     
      ## builtin/repo.c ##
     @@
    - #include "shallow.h"
    + #include "utf8.h"
      
      static const char *const repo_usage[] = {
     -	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
     +	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
    + 	"git repo structure [--format=(table|keyvalue|nul)]",
      	NULL
      };
    - 
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
      	return ret;
      }
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     +			     enum output_format format)
     +{
     +	struct strbuf valbuf = STRBUF_INIT;
    -+	struct strbuf quotbuf = STRBUF_INIT;
     +
     +	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
    -+		struct field field = repo_info_fields[i];
    ++		const struct field *field = &repo_info_fields[i];
     +
     +		strbuf_reset(&valbuf);
    -+		field.get_value(repo, &valbuf);
    -+		print_field(format, field.key, &valbuf, &quotbuf);
    ++		field->get_value(repo, &valbuf);
    ++		print_field(format, field->key, valbuf.buf);
     +	}
     +
     +	strbuf_release(&valbuf);
    -+	strbuf_release(&quotbuf);
     +}
     +
      static int parse_format_cb(const struct option *opt,
      			   const char *arg, int unset UNUSED)
      {
    -@@ builtin/repo.c: static int repo_info(int argc, const char **argv, const char *prefix,
    - 		     struct repository *repo)
    +@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
    + 			 struct repository *repo)
      {
      	enum output_format format = FORMAT_KEYVALUE;
     +	int all_keys = 0;
      	struct option options[] = {
      		OPT_CALLBACK_F(0, "format", &format, N_("format"),
      			       N_("output format"),
    -@@ builtin/repo.c: static int repo_info(int argc, const char **argv, const char *prefix,
    +@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
      			       N_("synonym for --format=nul"),
      			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
      			       parse_format_cb),
    -+		OPT_BOOL(0, "all", &all_keys, N_("return all keys")),
    ++		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
      		OPT_END()
      	};
      
    - 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
    +@@ builtin/repo.c: static int cmd_repo_info(int argc, const char **argv, const char *prefix,
    + 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
    + 		die(_("unsupported output format"));
      
     +	if (all_keys) {
     +		if (argc)
-- 
2.50.1 (Apple Git-155)

