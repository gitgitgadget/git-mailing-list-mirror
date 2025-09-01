Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FF2747B
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747674; cv=none; b=KTq7dMlTtBr9hIMZzsLlFiWE6nEnvKOUORK9yAxdeNHpVqVhqjQQUPcPxRdN89to/nzqtH9C2wVmchO3fbcUcCL495IG/HN068XMASu9CUrFq8zzxs+MffSKVXULzXLKKFfTS0kQ6+h9+JqwzMxgu20RDpJ0uTJbI0LVkSSyaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747674; c=relaxed/simple;
	bh=2ou0/wnqVUtPKGV6jYe5CLLo3OJaxf1CfDjmS2kBcwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtmJN1UkfSeXi8L51t2YSW6y8Y5n55hHglyycBbTyvPI8qTyV3VBfHBzdMfsqqI7GtTdGqCHS8inlG0BGr4PtDENzlDgAUlulT9hVe6FMONKxx+PHuZJyQxhCFsMNDjEcRRTptqTXmSbW8ceh2axpwJ1Ypsd38PedJn1D99Hwb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf6qNF1w; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf6qNF1w"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8900fcc0330so3873107241.0
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 10:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756747672; x=1757352472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJipzrkJjGpjQBkO9e4lDVlN4DMXt9+ADyr8gBiPdlQ=;
        b=Wf6qNF1wdMW9yuALPOeGuqgSeeQTfIFsvdspn//kmNNKqNbHLSrwwsgYsJlH7vMo1O
         K+PYEgdhG8JxFx+D3EK2lEi5Nnw+1sXf3wMU6Wzmy+Ubz2HbvOUCv/cxbUDJaZvDzR7j
         Mt9jC7seJcQnLYSKAtYw8TFCMYhdcpZvhhYvpTPXUFK+Ni3E3f4gYz48jD72Jfbx8PGs
         kYMRTQnRmf/V5WG5Rg4T53sUBQ+K5R64hwS7PprFrKmH7NeiPu+ZIoi53i+PM4dMF50s
         zO+bTbFqYUlz0YveCkdYr5017u9+7VeJuSu1gqPP7N8knXOBUs6n1bPqkrT5VdtaVjDL
         Z9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756747672; x=1757352472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJipzrkJjGpjQBkO9e4lDVlN4DMXt9+ADyr8gBiPdlQ=;
        b=JjDue4Dbv899hGLNqnkqY3xczEBTcJcDyOxilYrMtjYwFKn3RN7nZx/84gv79K5TMB
         arE74/yNg9x+WLczgm5KKoS5SIJqJpxAc+81kSD//lkh+hlizOcC3B8KI8JqFz9HCbx1
         A9LXgNXFJ5m0foJt4p52SmG8Ia944Pel/9H2u63l34oc3vRuXp4Fv03LJM3V7jHFvtCM
         F6rf3SHDlJ6fcPi6Wut/IB+JVl4v5LrmjQlGAAhd8EQ0gpR0fvJb8miZ2Oc6oCwXoN5h
         eahFT1365uJsOhA1fldV3BLg4SBkrEVa+OUwMigG5N3lyU4y1SRy01GbbEPvfE1F2OSH
         pnmA==
X-Gm-Message-State: AOJu0YynI478TeUVZpTSnWb+ODv7OhCOLTnFQDajx4JxB5dYQkut7++I
	lLYnQsesjml1jYnTLvS6r/35pDuMhSK0KqtLMoXy6rzgC6HrI2s1+7w+Ffqaxg==
X-Gm-Gg: ASbGnctPQ3p3GpvSA1UweogMARA1ksKBMcjZ2KHO6HwKN74qZ2Oj+CjHx2KCUCcbSzT
	XpecQ46u9d2plFZaPpEe89QxvChQQQlrxIQXH2NV8qX3ukkkeKEuk1+oNzsHGKzwmpkb0OHpvjm
	IWH5CA6pBk/JnAqolDFKWOjZhN5Cg5+rBUdDqE06VToSsQIxKm8gT0irX5zeWYL8kn/98AwjUgt
	/FmVS6KaWjvQNqq7tJRnNG0/ePuZ13QLObBv1gl+w45Ho6LP4b3m+w5XEIDfq8B0zMm1frt3TUe
	MvtKMzhKfm7SZykz+Zzm7PfFPE4YTi9rCgdBxSDtRmlCo9NiLFt3yqENsCl/19Wny5ipQ+jtCBK
	AEyHoInj3uEFtvTAjNVlvFEZfxxXixSK5x7B826AWaln4t6sZ5Ifr+W4ILYagG5g7QgCUf3EgUw
	==
X-Google-Smtp-Source: AGHT+IHtD0bIaHZyqYMZQ4OVuAzhr1FmUb2R0l/FqhZxN7BnMpiKb8rxLWejMH8rUIgHTik3DAVBug==
X-Received: by 2002:a67:e009:0:10b0:4fa:3547:2d38 with SMTP id ada2fe7eead31-52aed4ea307mr2611128137.10.1756747671632;
        Mon, 01 Sep 2025 10:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:edea:fa75:64b3:34fd])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7c2c42sm3973283241.4.2025.09.01.10.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 10:27:51 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v3 0/2] repo: add -z and objects.format
Date: Mon,  1 Sep 2025 14:27:30 -0300
Message-Id: <20250901172732.98845-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

The major change in this v3 is that it's now possible to use --format and -z
together. If the user uses a combination of two or more --format or -z, only
the last one will be considered.

Here's the range-diff versus v2:

1:  3ea40b1572 ! 1:  0323f1fa75 repo: add the flag -z as an alias for --format=nul
    @@ Documentation/git-repo.adoc: git-repo - Retrieve information about the repositor
      --------
      [synopsis]
     -git repo info [--format=(keyvalue|nul)] [<key>...]
    -+git repo info [--format=(keyvalue|nul) | -z] [<key>...]
    ++git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
      
      DESCRIPTION
      -----------
    @@ Documentation/git-repo.adoc: THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHAN
      COMMANDS
      --------
     -`info [--format=(keyvalue|nul)] [<key>...]`::
    -+`info [--format=(keyvalue|nul) | -z] [<key>...]`::
    ++`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
      	Retrieve metadata-related information about the current repository. Only
      	the requested data will be returned based on their keys (see "INFO KEYS"
      	section below).
    @@ builtin/repo.c
      
      static const char *const repo_usage[] = {
     -	"git repo info [--format=(keyvalue|nul)] [<key>...]",
    -+	"git repo info [--format=(keyvalue|nul) | -z] [<key>...]",
    ++	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
      	NULL
      };
      
     @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
    + 	return ret;
    + }
    + 
    ++static int parse_format_cb(const struct option *opt,
    ++			   const char *arg, int unset UNUSED) {
    ++	enum output_format *format = opt->value;
    ++
    ++	if (opt->short_name == 'z')
    ++		*format = FORMAT_NUL_TERMINATED;
    ++	else if (!strcmp(arg, "nul"))
    ++		*format = FORMAT_NUL_TERMINATED;
    ++	else if (!strcmp(arg, "keyvalue"))
    ++		*format = FORMAT_KEYVALUE;
    ++	else
    ++		die(_("invalid format '%s'"), arg);
    ++
    ++	return 0;
    ++}
    ++
      static int repo_info(int argc, const char **argv, const char *prefix,
      		     struct repository *repo)
      {
     -	const char *format_str = "keyvalue";
    -+	const char *format_str = NULL;
    - 	enum output_format format;
    -+	int format_nul = 0;
    +-	enum output_format format;
    ++	enum output_format format = FORMAT_KEYVALUE;
      	struct option options[] = {
    - 		OPT_STRING(0, "format", &format_str, N_("format"),
    - 			   N_("output format")),
    -+		OPT_BOOL('z', NULL, &format_nul, N_("alias for --format=nul")),
    +-		OPT_STRING(0, "format", &format_str, N_("format"),
    +-			   N_("output format")),
    ++		OPT_CALLBACK_F(0, "format", &format, N_("format"),
    ++			       N_("output format"),
    ++			       PARSE_OPT_NONEG, parse_format_cb),
    ++		OPT_CALLBACK_F('z', NULL, &format, NULL,
    ++			       N_("synonym for --format=nul"),
    ++			       PARSE_OPT_NONEG|PARSE_OPT_NOARG,
    ++			       parse_format_cb),
      		OPT_END()
      	};
      
    @@ builtin/repo.c: static int print_fields(int argc, const char **argv,
     -	if (!strcmp(format_str, "keyvalue"))
     -		format = FORMAT_KEYVALUE;
     -	else if (!strcmp(format_str, "nul"))
    -+	die_for_incompatible_opt2(!!format_nul, "-z",
    -+				  !!format_str, "--format");
    -+
    -+	format_str = format_str ? format_str : "keyvalue";
    -+
    -+	if (format_nul || !strcmp(format_str, "nul"))
    - 		format = FORMAT_NUL_TERMINATED;
    -+	else if (!strcmp(format_str, "keyvalue"))
    -+		format = FORMAT_KEYVALUE;
    - 	else
    - 		die(_("invalid format '%s'"), format_str);
    +-		format = FORMAT_NUL_TERMINATED;
    +-	else
    +-		die(_("invalid format '%s'"), format_str);
    +-
    + 	return print_fields(argc, argv, repo, format);
    + }
      
     
      ## t/t1900-repo.sh ##
    @@ t/t1900-repo.sh: test_expect_success 'git-repo-info aborts when requesting an in
     +	test_cmp expected actual
     +'
     +
    -+test_expect_success 'git repo info fails when using --format and -z' '
    -+	echo "fatal: options ${SQ}-z${SQ} and ${SQ}--format${SQ} cannot be used together" >expected &&
    -+	test_must_fail git repo info -z --format=keyvalue 2>actual &&
    ++test_expect_success 'git repo info uses the last requested format' '
    ++	echo "layout.bare=false" >expected &&
    ++	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
     +	test_cmp expected actual
     +'
     +
2:  1d062e690e = 2:  b2b241f401 repo: add the field objects.format


Lucas Seiki Oshiro (2):
  repo: add the flag -z as an alias for --format=nul
  repo: add the field objects.format

 Documentation/git-repo.adoc |  9 ++++++--
 builtin/repo.c              | 44 +++++++++++++++++++++++++++----------
 t/t1900-repo.sh             | 18 +++++++++++++++
 3 files changed, 57 insertions(+), 14 deletions(-)

-- 
2.39.5 (Apple Git-154)

