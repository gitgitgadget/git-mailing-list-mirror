Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C038125A8
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900413; cv=none; b=CRHsSisNDyz3TFy3poUt5zRxGA+2lOPa+HkSSTDaeXXQWrh17kqxbOBdK2GTSN97oI76DqmI0xrf+wKr7I923Qycxoiw5xJPwGNK+JJuL5vAcNr9837h6S3W1QuQFdZG9MIUTz+VXB8RN6sxy1rqAZWXmSlZji7kWCU1niC1uTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900413; c=relaxed/simple;
	bh=rMVAPeUrU+qj85cO0P4tyrUvxgRITUX1LIDfSGRGTrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z12TE0nTUMjAcTnwhJri6zlGqsCcniuA5DXaaGsUjyEHNMmPpSYoZNBpXBZVWpJpVZnrQkiCf3GyHdLAENm4Fwu7fh/rxd1YnxoU5CkuuCAt50J94WlcLIDh7PvwFU1E8a4B9Inh704VnaZCCNaiBzbdiR2ZGY5m9NKmVGuAvok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caS6LbkS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caS6LbkS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d932f6ccfaso38184235ad.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 00:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707900411; x=1708505211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncNwfe7k3cqoxsQ6oCXQYXVBjSgxgCO6482AGAtSrFA=;
        b=caS6LbkSHZlnf9DFDISE1wHqoujOzoCoCMXv6KKAcd7Bn4NDbGNJOOQrcUt/xgDThV
         ZIDuDiVtXCjXkqLPAZm/YcV5rAUrx+cDmqS6RAD8EFNsZozgFQJaW2bGaOK178WBDtrN
         Z08cqdZgKnNnONMZypKlkD9NTu/nMYo787lexglBacBDU9aQK7Hxc2DzImRwTuxPfEr6
         0SSG0I6lG767jX8+zX207+EoyYxlmE788BTSUseCFQ8Q3EWC0S4t+PplZZqZYhpqCpgW
         vpcmlceF/Hm7b2PAvSFvsTaerWZag9prFsAxMkDyVAGdVlaFKdZQRI/RxEvLkOjnsMhV
         hnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900411; x=1708505211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncNwfe7k3cqoxsQ6oCXQYXVBjSgxgCO6482AGAtSrFA=;
        b=n+3rYPUGYbUXXKuJF/SyB6nw6WznISMngjrriyIXkwJi5vfGL36tYXSwCBV534PQfO
         pwVoJWaxFaylOqTd0wyvkkGnENJVwZy/PFmEbniouya01o/9nMUf7Jc0an0kBiDXtL1T
         ukcQevV3tbZ+RnuC7wLnNrLkJen4tN+3OzgAnCsqBbEsF4wxkGvztK1/du9ET0APiWEw
         ig9+YJ5/qQPHgNfSTnH3twkjBfb/eF2lzEfCkm4r0+zdPVslUXgBCIr9i2O46oMJnsWj
         GZGKuuFYQ92A8R68phcGOGf/SZjZyTzXn4hWf/lT3I3ZGgOk/vSlSbUhMRIUj1iJAu22
         0Hfg==
X-Gm-Message-State: AOJu0YyvC7b9gF813x5DtyjzUPhnYEgwo4aG0+AHNHreF8KvFW15suhR
	ZfgwBN4tgP15zWhoeCYrq1Lc/sGyXh2iVM7BwYMBZ0eGZ4peFzznMsGfBmu0
X-Google-Smtp-Source: AGHT+IFhOowCfwQd8giyAVHA0ZUUjlUTez87UURq9RTfsCEJXTJSfRmvQvsT/2eQlhZviZComTD9ow==
X-Received: by 2002:a17:902:dac4:b0:1db:299f:5b0e with SMTP id q4-20020a170902dac400b001db299f5b0emr2166292plx.1.1707900411018;
        Wed, 14 Feb 2024 00:46:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIC/sXAOuWos0ZZfoyvyswle9Q4OgEcOd4+oFFAMY+pmQKTIBQyCbOryjcI/w6xKn2Y8t/V7zS/+AglRDqf5yAXGyIzuUICw4bNXhb58vL9/kQfw==
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id mp13-20020a170902fd0d00b001db3bffd1a8sm2267733plb.42.2024.02.14.00.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2024 00:46:50 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/1] diff: mark param1 and param2 as placeholders
Date: Wed, 14 Feb 2024 16:46:41 +0800
Message-Id: <3a82f72f33663f162aa41cb20c0fb3b6786971c9.1707900029.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1707900029.git.worldhello.net@gmail.com>
References: <6e33b2b2-f0b1-46ba-bbd8-3ae4c87d35ba@free.fr> <cover.1707900029.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some l10n translators translated the parameters "files", "param1" and
"param2" in the following message:

    "synonym for --dirstat=files,param1,param2..."

Translating "param1" and "param2" is OK, but changing the parameter
"files" is wrong. The parameters that are not meant to be used verbatim
should be marked as placeholders, but the verbatim parameter not marked
as a placeholder should be left as is.

This change is a complement for commit 51e846e673 (doc: enforce
placeholders in documentation, 2023-12-25).

With the help of Jean-Noël,some parameter combinations in one
placeholder (e.g. "<param1,param2>...") are splited into seperate
placeholders.

Helped-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index ccfa1fca0d..e50def4538 100644
--- a/diff.c
+++ b/diff.c
@@ -5590,7 +5590,7 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_BITOP(0, "shortstat", &options->output_format,
 			  N_("output only the last line of --stat"),
 			  DIFF_FORMAT_SHORTSTAT, DIFF_FORMAT_NO_OUTPUT),
-		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1,param2>..."),
+		OPT_CALLBACK_F('X', "dirstat", options, N_("<param1>,<param2>..."),
 			       N_("output the distribution of relative amount of changes for each sub-directory"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
@@ -5598,8 +5598,8 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("synonym for --dirstat=cumulative"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       diff_opt_dirstat),
-		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1,param2>..."),
-			       N_("synonym for --dirstat=files,param1,param2..."),
+		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1>,<param2>..."),
+			       N_("synonym for --dirstat=files,<param1>,<param2>..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
 		OPT_BIT_F(0, "check", &options->output_format,
-- 
2.44.0.rc0

