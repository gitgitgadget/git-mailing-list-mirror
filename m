Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFCB29B8DC
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519269; cv=none; b=lcb60ScYDah0NRvRJXr2C+pCzEF2YlMvs3blwCY2sKp/OE0CFSLYt2qWDjAw84h3eW4JwWQbqZCWhveeG9ME1L6NPoKL4iiyEkgEwNmMvsF+n81xVJWXZcPXCr+Q/xVWkCtlk8UaNZMb6odqnzOnHZvp8Y0/KtzFB1rOdo7uMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519269; c=relaxed/simple;
	bh=zRZ/PkopfV5qoMJGXuEw55D2Ftrq6dPuevAa+GNkjvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJgeAOIw0woMADrn7+x1GE+Jjy8D9G5MMdJQU2DoLM7mAj5sptxhSpPEOrWRYVgzolYGekIyp4N2I8IJ8QmyJ1w/Ru6KbgjEELce611J8weU4Dlslwwy2Cbi3QJzetPiKNwH3uh6wtPQRVA9sFzW1OWP7oNpw2jewKwP2h153aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7zPwAPN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7zPwAPN"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290a3a4c7ecso44434715ad.0
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761519266; x=1762124066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlUcWwAlMJ6OF8A4Lt2tvarOtDphVJimlWY6o3dhmLs=;
        b=e7zPwAPNoJmusNFbVejNKG1mUx0OuFrchzR6QD7bMcxqodOn6drBVMqCJ2de9hsjkY
         kzHJqt4gYotka3HOdnm4WM/x4lQW1ofCib3EJLC4p8A7QhsGWivTKaUHhM0RJp73RAhT
         C83O9CGHrxxUXf53PZjGWRtLApsGIRJFzGirsDuXsiCPQdUBJ/1E6JXecZZtSyo0F5t9
         8bYBcHaU53wuj3SHvPWsl7vRtDJjllHGZqYoNLWPbvPm+TUmhnRFBVrVNmIbycAh+wg8
         jS0p9mhnLQmFaXOkItUvf3hNz3HyRRRj12FElNHU/9VawKKDqJgCHQhrv9aJKTbGhPQS
         UDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519266; x=1762124066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlUcWwAlMJ6OF8A4Lt2tvarOtDphVJimlWY6o3dhmLs=;
        b=F2y7cQbx6+KoqUoKsIUuwhGobc+YSZxQwz0nCK1b87IOCNzwdV8S6huOP2Fw8C5xs1
         mxSB0fbX77HLkC+hWOS05t9+BKI8nxYJXnS8Yo2FKyo+22FcvKLMlf4P1aDW9JLh4f1B
         bbhB+DYT4VIj44ejOd/pj4g8Idx+0Ys3V9aupOIjXK0vCoeQBK39lcrXDJQE8MRokOeX
         gvzqKkEgHVCL6yoFbKgeqZJbN1cL3sboObD+2ze8C0/kZSlIhjzXpMn09Q7yqxN1Gj0F
         K5GDu/Zvnr544W/HqSGZ7Q/Om5UEhtvr+gfm7aU25t+xbclzmYthLeQvhoSJB7OmNO9s
         JkhQ==
X-Gm-Message-State: AOJu0YwCVY3V1C5cKa5U3nvmdShnwfnrO8B6UlVLYmTUYqxPi6Jc6PfQ
	HjBgAym2YlIhO/hA9JEIxDNhDBFfCgRYmnV5rw/VTgyVPyH1gG/fHjUn6blBEekH
X-Gm-Gg: ASbGnctWyvofn9HTwKHGDq2JyFauVCDAZ3fC/FZcBg6XlaRRRFpGyV/cTc+RVx2mD1p
	zz4WiZdXTr4VrAgmFMwfEcVS5fderp2nE5va/NOBilhvuJpC6DOS35t9Db8euidgpaHRzPgN7+9
	Mes5Rj0ldpEX7iBiu8AbtBlqOHFKNSMPzIiTxWSyu74CCk0TBww1oZrfUatgpYg1zHZzAZxqp1E
	1riyKlE45QLey7EcDZRUsUUpyTZlM0Zoo8rt1zz52zSER9XHW8017bXnii3Wt29Qpxr4rEQ+e53
	mgjuPeLVwuOVtYZ13mRLhLA64wIkOfLvW58UL2Bgl1tbhI6FmX7EDQLPd6ybden6lL69lWM//wS
	7VFRrPeGVnPDsIfx38S49p2i2+Oagx5yMv80TuSVXMu71LSsPifIlfHT8wdutzobrL3uDT4nhsr
	srFdYDf/3OA7lTufTzNaWfuSfs1lDjd6Tjv6Ru
X-Google-Smtp-Source: AGHT+IFBIscjqj5dTXZqZeyUezw10pHbR4a0jgCQF838ulC9fPI0nMY+pGfhcwt2AHO8AsCxqo/btQ==
X-Received: by 2002:a17:902:cf12:b0:28e:80d7:663e with SMTP id d9443c01a7336-290cb079e2dmr450758105ad.40.1761519266488;
        Sun, 26 Oct 2025 15:54:26 -0700 (PDT)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm59657435ad.42.2025.10.26.15.54.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 15:54:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 0/2] repo: add --all to git-repo-info
Date: Sun, 26 Oct 2025 19:52:06 -0300
Message-ID: <20251026225409.46647-1-lucasseikioshiro@gmail.com>
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

This is the third version of the patchset that adds a new flag --all
to git-repo-info for requesting the values of all the available flags.

Now, in this version, git-repo-info will abort if it is called with --all
and some key.

Here's the range-diff against v2:

1:  5f72f07589 = 1:  0db9aad2bc repo: factor out field printing to dedicated function
2:  b8158bb7b8 ! 2:  b6ecdc2c2f repo: add --all to git-repo-info
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      The values are returned in the same order in which their respective keys were
     -requested.
     +requested. The `--all` flag requests the values for all the available keys.
    -+Keys requested after `--all` will be duplicated.
      +
      The output format can be chosen through the flag `--format`. Two formats are
      supported:
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     +
     +	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
     +		struct field field = repo_info_fields[i];
    -+		get_value_fn *get_value = field.get_value;
    -+		const char *key = field.key;
     +
     +		strbuf_reset(&valbuf);
    -+		get_value(repo, &valbuf);
    -+		print_field(format, key, &valbuf, &quotbuf);
    ++		field.get_value(repo, &valbuf);
    ++		print_field(format, field.key, &valbuf, &quotbuf);
     +	}
     +
     +	strbuf_release(&valbuf);
    @@ builtin/repo.c: static int repo_info(int argc, const char **argv, const char *pr
      
      	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
      
    -+	if (all_keys)
    ++	if (all_keys) {
    ++		if (argc)
    ++			die(_("--all and <key> cannot be used together"));
    ++
     +		print_all_fields(repo, format);
    ++		return 0;
    ++	}
     +
      	return print_fields(argc, argv, repo, format);
      }
    @@ t/t1900-repo.sh: test_expect_success 'git repo info uses the last requested form
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'git repo info --all <key> duplicates <key>' '
    -+	git repo info $REPO_INFO_KEYS object.format >expect &&
    -+	git repo info --all object.format >actual &&
    ++test_expect_success 'git repo info --all <key> aborts' '
    ++	echo "fatal: --all and <key> cannot be used together" >expect &&
    ++	test_must_fail git repo info --all object.format 2>actual &&
     +	test_cmp expect actual
     +'
    -+
    -+test_expect_success 'git repo info --all <invalid key> warns about invalid key' '
    -+	git repo info $REPO_INFO_KEYS >expect &&
    -+	echo "error: key ${SQ}no.key${SQ} not found" >expect_err &&
    -+	test_must_fail git repo info --all no.key >actual 2>actual_err &&
    -+	test_cmp expect actual &&
    -+	test_cmp expect_err actual_err
    -+'
     +
      test_done

Lucas Seiki Oshiro (2):
  repo: factor out field printing to dedicated function
  repo: add --all to git-repo-info

 Documentation/git-repo.adoc |  6 ++--
 builtin/repo.c              | 63 ++++++++++++++++++++++++++++---------
 t/t1900-repo.sh             | 21 +++++++++++++
 3 files changed, 72 insertions(+), 18 deletions(-)

-- 
2.50.1 (Apple Git-155)

