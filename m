Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4C1F3BAC
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745871890; cv=none; b=e8H+3S4cFQ+ouR57TNqMzHv5pQ+BNLeWE/XF0vVPdLl4PIXMF7IRTiHdG0Rsx1bOqncqSYjHCAtKuZgli+XaIhhpnzhoHkPconsID9tbwKcPqvRgFyH/7ChMNhERoNbpfISWyNOBpzIaOBVbn3z7FuR83GBbxngm4IeSs37gEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745871890; c=relaxed/simple;
	bh=NUK/xhcm9wjTljyS/PYfGn4MbC29XszaSKJ5jVC/7D8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Pk+7mJ7x79Q44hJQqHbDViSb2PEHOy4DQWuG96Es95ylkd7r9ZwlHzgyvfZwLw8P589+HBO04DEyvAuhbXSYA/ZNQeOnAndAcugS3nHg1xxyVBsx1wbgMzRaN9cs2kRv27jLI1SuIVHr3Pptdm9MtQz+VisOoluIH18z/TP5OFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmLDdoA4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmLDdoA4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5607396f8f.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745871887; x=1746476687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tePCQV3hxkzYN9D5WiMq9e4t9p01f8JiMygqK8n0a50=;
        b=GmLDdoA43sKQq2ROina3DUgCfpVbRw8GkCw1lrallvknWjT7bijngyTHHQxZ6n1t69
         HG0SOKDkqowKsZk7rwdkE8QKws6nWvboOLS5fKTYGuiM1XYtXFvwGTOr9aS5PN5QUGKa
         Nb5H2LoWnU9VopbNnhZ619n1+MwEXEr00WVf2A2e3NCr1mQrHNdJeVBfr+CXKvEfHyrl
         kznengZJbwZo0lLyPzQVQhiSKxwFYEsNSlsF1KDrsTAqXbIldkjZKt9PSlr/s19dfvYE
         TMfx32Obxu48Q75LbiTtoU5l3UzQpOWLjLrsjKntBA+xRPApm/TPEWyLalFVGylpnROA
         sqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745871887; x=1746476687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tePCQV3hxkzYN9D5WiMq9e4t9p01f8JiMygqK8n0a50=;
        b=aJQyV5hkPcLAaAIVUnNJp1u3Q72J1tU7R6xQv778L8/QInMEm9piKp+F+w+Q75e7mK
         dfDKHEL44TaMxkNAy/psotiaBHT46HaIs8Gz41bMawQF4Y47GYu2NMZ61Ts7l95yqDbu
         zuEjKLvWln5KRY/YBzgfKa0PnEQ34A/KpbulNE36INWaTmhfAY0xYTR3ke/vRr0wKklQ
         4TZpbU79CzDyXrlVR5O8PVmdNAPEe934oUZg79Rqh06hIKcMajM/m/xxxC52Ze1Tbryo
         5+IzvSeUsQ9g+zZuUeF0LUYDvlvXfgmnqPvjd6tFulaDTgddUpMAJ+rsvgKrBAk27NRt
         hfGg==
X-Gm-Message-State: AOJu0YxfMJYaNyr0Gm25JPdkGQHDvPPmyOewESKd+2Rqf5H2ZoXOmYNN
	QdOYb9wkkAqLBM/Dwkm6ZhsHzx6HG/kt65zOrjXGZXCypNgy3wz/C5aJZg==
X-Gm-Gg: ASbGnctAGyWDWsjxmAdahHxfMM1TCm4zPqnR6U2enY0PBDuLvUrCEyoEK2lxUGvlHO9
	8OugaVHMJYU7tcHw+Wq+ZD+xz1bgxGHz/z7kv42hS8NJvGAE/dx6utUbG9I2/YZEgPqH6N4Xrfp
	8XD8VrPGdTa+IQ4+xpP84a8LDH5gYSgzb9lj8IMyvO8es5n774wNVoqBWVuJDt6dNA+EHredjRA
	Ta+H7SM/+lYgmEm8vqI/e+Favmk1vNBdgB8f8JSvvQxJ+QyugkCjRtv+IkR+gE5HTNYEESlEMkZ
	6pE/jual0RGXZdBZVbEfmUvV8pHvzrNnLNpCliJw4LOnhUwN4lCX
X-Google-Smtp-Source: AGHT+IHQE8xW/wyZJ7JSReUB7lWZ5UdFUR8XsUTd4xWqNaUoFSsUE6FnuFwVKgC0GYvV8I8IoB8s0g==
X-Received: by 2002:a05:6000:420b:b0:3a0:83a2:1e79 with SMTP id ffacd0b85a97d-3a0891abe5dmr842818f8f.11.1745871886518;
        Mon, 28 Apr 2025 13:24:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4cbcsm11851042f8f.25.2025.04.28.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:24:46 -0700 (PDT)
Message-Id: <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Apr 2025 20:24:42 +0000
Subject: [PATCH v2 0/3] Fix REF_DELTA chain bug in 'git index-pack'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    peff@peff.net,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Derrick Stolee <stolee@gmail.com>

When fetching content from a remote, 'git index-pack' processes the packfile
content, storing a packfile appropriate for on-disk storage and a pack-index
helping to perform random-access into that packfile. To help with
compression, the packfile sent over the wire can use REF_DELTAs in addition
to OFS_DELTAs to refer to objects that are already known to exist in the
client's repository. REF_DELTAs can also refer to objects within the
packfile, though this is not typically done.

Because this inter-pack REF_DELTA is not a typical data shape, a latent bug
has been waiting that causes 'git index-pack' to die() even on legitimate
packfile content that it could resolve.

This series resolves this problem while also creating a test helper for
constructing packfiles with specific objects represented in specific types
of deltas and in a given order. This should make it easier to create test
cases like this in the future instead of updating t/lib-pack.sh through
other means.


Updates in V2
=============

 * Fixed a memory leak in the test helper.
 * The test helper has a better CLI that makes use of the parse-options
   library.
 * The test script skips the in file and instead feeds the input directly to
   the test helper.

Thanks, -Stolee

Derrick Stolee (3):
  test-tool: add pack-deltas helper
  t5309: create failing test for 'git index-pack'
  index-pack: allow revisiting REF_DELTA chains

 Makefile                     |   1 +
 builtin/index-pack.c         |  58 ++++++++------
 t/helper/meson.build         |   1 +
 t/helper/test-pack-deltas.c  | 148 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c         |   1 +
 t/helper/test-tool.h         |   1 +
 t/t5309-pack-delta-cycles.sh |  34 +++++++-
 7 files changed, 216 insertions(+), 28 deletions(-)
 create mode 100644 t/helper/test-pack-deltas.c


base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1906%2Fderrickstolee%2Findex-pack-ref-deltas-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1906/derrickstolee/index-pack-ref-deltas-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1906

Range-diff vs v1:

 1:  5d4beb202d6 ! 1:  41aac8e782f test-tool: add pack-deltas helper
     @@ t/helper/test-pack-deltas.c (new)
      +#include "hex.h"
      +#include "pack.h"
      +#include "pack-objects.h"
     ++#include "parse-options.h"
      +#include "setup.h"
      +#include "strbuf.h"
      +#include "string-list.h"
      +
     -+static const char usage_str[] = "test-tool pack-deltas <n>";
     ++static const char *usage_str[] = {
     ++	"test-tool pack-deltas --num-objects <num-objects>",
     ++	NULL
     ++};
      +
      +static unsigned long do_compress(void **pptr, unsigned long size)
      +{
     @@ t/helper/test-pack-deltas.c (new)
      +
      +int cmd__pack_deltas(int argc, const char **argv)
      +{
     -+	int N;
     ++	int num_objects = -1;
      +	struct hashfile *f;
      +	struct strbuf line = STRBUF_INIT;
     ++	struct option options[] = {
     ++		OPT_INTEGER('n', "num-objects", &num_objects, N_("the number of objects to write")),
     ++		OPT_END()
     ++	};
      +
     -+	if (argc != 2) {
     -+		usage(usage_str);
     -+		return -1;
     -+	}
     ++	argc = parse_options(argc, argv, NULL,
     ++			     options, usage_str, 0);
      +
     -+	N = atoi(argv[1]);
     ++	if (argc || num_objects < 0)
     ++		usage_with_options(usage_str, options);
      +
      +	setup_git_directory();
      +
      +	f = hashfd(the_repository->hash_algo, 1, "<stdout>");
     -+	write_pack_header(f, N);
     ++	write_pack_header(f, num_objects);
      +
      +	/* Read each line from stdin into 'line' */
      +	while (strbuf_getline_lf(&line, stdin) != EOF) {
     @@ t/helper/test-pack-deltas.c (new)
      +			if (get_oid_hex(base_oid_str, &base_oid))
      +				die("invalid object: %s", base_oid_str);
      +		}
     ++		string_list_clear(&items, 0);
      +
      +		if (!strcmp(type_str, "REF_DELTA"))
      +			write_ref_delta(f, &content_oid, &base_oid);
 2:  a9430447641 ! 2:  53a990e69ea t5309: create failing test for 'git index-pack'
     @@ t/t5309-pack-delta-cycles.sh: test_expect_success 'failover to a duplicate objec
      +	C=$(git -C server rev-parse HEAD~2^{tree}) &&
      +	git -C server reset --hard HEAD~1 &&
      +
     -+	cat >in <<-EOF &&
     ++	test-tool -C server pack-deltas --num-objects=2 >thin.pack <<-EOF &&
      +	REF_DELTA $A $B
      +	REF_DELTA $B $C
      +	EOF
      +
     -+	test-tool -C server pack-deltas 2 <in >thin.pack &&
     -+
      +	git clone "file://$(pwd)/server" client &&
      +	(
      +		cd client &&
 3:  27d36402fe9 = 3:  1358039b2f3 index-pack: allow revisiting REF_DELTA chains

-- 
gitgitgadget
