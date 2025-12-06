Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFBCA5A
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053072; cv=none; b=kkkuCANtSmcHX/LftjvFv0ZvMRbu1vyBDW8nSST34uIgJBj5z17EN+877X0PI/3AzTN0hbAHSvTnNwYNyJNjmoiNJWlUNbzxokpTswL+6shUngh06X5xchmQkFNq5OgfRNNblpdGSOtMulDJrgiptjTezZLHfDV9TdokHZ5ez+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053072; c=relaxed/simple;
	bh=sT7//Fy5Ju7tFT9ZC+pNouk91CThhxUUz/O+9bP59Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMNLku3KR04iCHA06VH48F95JEAWjYzjvlVUGYy+q72sqFp567WZlSnC4F/8EcCr90f41qrqJM0tkifF6CwKTGOXKzrejihCfaOiUObakrHatUSS0kkCymdX6E1TVjWE+k80zNkJkEcA8wNwTo+XAzzPAFZQX5Jrai12x3DOnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nwuFfhiu; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nwuFfhiu"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-641e4744e59so3205068d50.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053069; x=1765657869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGzExxNzoMbyH6iiUsg3/XKnNi+t7r6wPfXpLSLakb0=;
        b=nwuFfhiutFC6uqC4E1QyYCONic+qJhg1poR1NpZVpEaTgzIlVB6mmvBht8lTnjzzmr
         clXZLUmEW6IdhXJBMBwnT6b94/4qCTbGv4DjoDyDpcMMUbtdYJKsrcDh7m5Ju3xMenVY
         hwY4skbrV9vzMw0BjiS4M4WkUqRze+JtPnhnkIQSaWHbuCmiHfXZIwsOoH4f8nxFzkyJ
         Rr8X+VENF7wplsOp2mxPhNU3g1BsjtWvc0atYgQl8hgs09WEcZUrdWBARNaQbvWkgfL/
         JwfzSkBkOkdpkTOLhAdWW0H9u+XFEVVXsi5eOyrNrhRN+hBO0RVUBYyuXAIEmzq9sLc0
         ypPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053069; x=1765657869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGzExxNzoMbyH6iiUsg3/XKnNi+t7r6wPfXpLSLakb0=;
        b=kVukMPX0FRTpGLrp1ULFLJc45M7IfB7Nl9xIbqN2FHvsG3qkHybmXspwUiareSIKR6
         NpyyeKWqk59Yc0DQYcaMMlXfCw0gUMb80g7SrB/MPHwlBcMk+ryHF+SB+QLig/aFYs1r
         1gu0R85RWMlJ1/Ut+ZAFSs9a8JBptWG/A9PORSXJ1BU7igwPZ8fw3vsiiIMnnMSXntM/
         ijwpeAlTgc9FwkvYrH3a29wH/FywwbF5qqO1YsWi0UaouqxkN9AUKHr98tG9JnlR9rIs
         NZc477vfkHvrBIMNZB4bBDBFlQUnkr5dsDKArXklRmq1yVIiEhHYycWwuNG+KjXS6fS9
         hMqA==
X-Gm-Message-State: AOJu0Yw+WnljTbUFHhJXRhuKO2vYHGaSNVRUtArOxBFrolxcr7HV99sC
	/cdz5RZyk3ssl+RC8qSc2yBkFN85mqHhDkUjr7+G6SpMp2cl9JUPKjaxEjdMS9jq/+QMf6LD2Ol
	Z0sjBDHI=
X-Gm-Gg: ASbGnctwnev3EN2c7B87fZygEi2LJuMXxaOoTX22IEtUcOgh7tFWJzJnkEIOVXVRH94
	a/Rsb14QU68tJXQQC7wjIdUJSJs5PWIBV0EnoNplm51jNzzNk59slFshTGyuZ5l70k31AHEf9Ex
	KvMPobS1gN5VYzLdbbZfLh3BeiZf4SgJ4LepSqDnSL/g5qeSZgAqAIOK5YNPNiUSCj1pSd+HGRG
	TAr8FLDjkbJfQmEwUCxLnKC/VFz7vCgtUnMI8LY4FzGKBogTP0bXZ1TwgxX9R8uR2ePF2SozTNR
	OXT5F/SQtHEgQ6U9anRFd4+WkwBb9YGXib5U/hfzw7Q6/dVtuAgn/l2ZDjkaxbzPeOtHGM6oDub
	qINs29qLnEFpqsTn6vYGQcBqHIOI5zR+ySF7NIl7wdvEZRsS6Ax1H6IQcKNVIQ+3QdznVXzZzFO
	bnVzUCrd4GcaIUCRZ3+k6HGnsoBQNdxUg/S35moSxcnEXAGxUZVr1NjJi51kxU991O4AYSu32XL
	mdicvhtIV5kXja8bg==
X-Google-Smtp-Source: AGHT+IGYSxrsKlOWDw/vtA0+OgD8EjTfHPSWPEurGntat6Soe7dwZ68hXpBPpVPHSvVEGRZDWZ7Wtg==
X-Received: by 2002:a05:690e:190b:b0:640:d0d4:526d with SMTP id 956f58d0204a3-6444e746280mr2388724d50.9.1765053068954;
        Sat, 06 Dec 2025 12:31:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f2b7d81sm3377093d50.7.2025.12.06.12.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:08 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:07 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/17] builtin/multi-pack-index.c: make '--progress' a common
 option
Message-ID: <35377d47c36b4ea28428cfa562dd7b1e2cb00656.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

All multi-pack-index sub-commands (write, verify, repack, and expire)
support a '--progress' command-line option, despite not listing it as
one of the common options in `common_opts`.

As a result each sub-command declares its own `OPT_BIT()` for a
"--progress" command-line option. Centralize this within the
`common_opts` to avoid re-declaring it in each sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  2 ++
 builtin/multi-pack-index.c              | 10 ++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 2f642697e9e..a4550e28bed 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -18,6 +18,8 @@ Write or verify a multi-pack-index (MIDX) file.
 OPTIONS
 -------
 
+The following command-line options are applicable to all sub-commands:
+
 --object-dir=<dir>::
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5f364aa816b..ca98d4c3ba3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -84,6 +84,8 @@ static struct option common_opts[] = {
 	  N_("directory"),
 	  N_("object directory containing set of packfile and pack-index pairs"),
 	  parse_object_dir),
+	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"),
+		MIDX_PROGRESS),
 	OPT_END(),
 };
 
@@ -138,8 +140,6 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -200,8 +200,6 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -231,8 +229,6 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -264,8 +260,6 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_repack_options[] = {
 		OPT_UNSIGNED(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
-		OPT_BIT(0, "progress", &opts.flags,
-		  N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
-- 
2.52.0.171.gd6a4e6b6955

