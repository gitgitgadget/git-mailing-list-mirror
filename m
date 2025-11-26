Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204E31DDB8
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155530; cv=none; b=WUP9Mv/vazwCZmqYBb+jjxSptzCnXLe12SnXPv4nIEgV7K+sqWKZEuH8825TAi4A8bSkugkeEU1ajUg6+wqRJClRqEERqyMH7tiLujm1PLKZ8FM5XgpCueKaCxCP3wE041eTi5wr0R3ATxIPlNeJvDFVf+X6aux7aNRpFNIoZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155530; c=relaxed/simple;
	bh=PjdHO/KXIbHq0kcJF7aFtXQBecBtYhls/uKheyqQfds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=X6XTzVPdIGWeKdPOZtCAWRuTqiFPeLXHI/tfaPatTgGc5kUpA3bjQRuJ/ga1xRQFL2wWtkIar10MNLR6Qiniw7W3KuayMtaUPS+3D4ebPB5iNDQ8P/tgEaBbloodp4VAJipZPPm4nMl9iMk+ZWHdbGpMvv3IToAzLyLw2T5q1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNQGiG4q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNQGiG4q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b736cd741c1so1151744366b.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764155524; x=1764760324; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvHWn8+u/1v7xhmuYIsmkBZ1EfegJlBD4omChiz4i0E=;
        b=FNQGiG4qx4t6wb8de6aKXndcsFLrmCGUh/mgTA1k57ozRGQh+REjTkz3V+CmhkkCqO
         uvxSVRPVnHrZeHd/Q37Wtyc4IsD4EjU0rBvqMC381U+jjr9TRXsGhqMZIPaN6DVBSTtA
         oLeoK5dWMvUUBoaaF1z4epAemlanD1Km1i7oLbAIUaJLdp9AhkDKfXBo6oQvwkXxyC1w
         x5sFXewMpfP+LoN74ojleyxt84OCNid49GC6khibxkXOvQdI9TtHRRgsEYegBJM2gjJy
         +DfPnj3BGoZZ4Dr+Tct5U1ANGsbp4X2sK1mCg3jlOu1TizZq63f6bjEzdKLeHV/QpuwL
         Zc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155524; x=1764760324;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvHWn8+u/1v7xhmuYIsmkBZ1EfegJlBD4omChiz4i0E=;
        b=fgE7IG89EI7pvFIVqBt0jqVx+Y+VYNyQBmMKP9gSCuDD+C/x5o2trK/ktdm8OdUEz4
         qBHTh0rq2PWuVfoinRHcr1cWFkpsQRywVj+6ZkH1vpviz9hLZR6GmAnVFr1xBi2BPdAl
         bqI05kzwrKdOMJrB20pBzwO84rUPfa5uKuV93u0e3mRCToDak5v6g/HQv275ouvNNUhO
         EOo0KRZCDl/yrRmJqZ7ZJ4MFdmTMA5wiq7B6sgJYO4rCiEpH/vGluRbqEVm5rbGKhGsC
         Mzn9dzBxuDsCZo6V3SqYUc58l2jePp5PyWuv5kMfNheuGl50Pd6Co29hZVD3kSqyZyBk
         RpvQ==
X-Gm-Message-State: AOJu0YyKvCadUEpVCrYyqX9pVYDCovg0u7TFWHsZcV4NG8krVlwpqWze
	RilDbpYBcD6JnUyffR/WDzWJtQPRRriyOmZsVbFkiy2KZb27WJHmZc3E
X-Gm-Gg: ASbGncvCyVD66SWsUK7Gk0XviNeXzfYPeNpqDGu+FPcDm7uuOafZtWRYUh4DnLKRpws
	dcR3S/QZLtn2wsNehDSbRWzej0Sg2xLQZb6g9FwC17kQoDbt9C4iiAZpduk4SpjlKD8yxp0IntJ
	JHt/h2MR9qbQgVwPayeNMQzYudQaofEdpKetkBN3J6HfD4BAj03guOGZ4XDRgo7uGggy5+BbZQ/
	mHS/sH/MH9hwrVLwH2jV7P+iVQ56c90ZD7ovy8LWDsZ3U41kqxevUidUbvNwl+x9TmycOt9c+nk
	fEJuvOiKsV5rIxA7q9A3FXG0ZygW5QiUE4Ih8bOCwlbACdkk22UcQYbuZ3S487GwiFbf1Sdpw02
	O64vLiCImWdpug9bVoF8ZxJilIgpVc6HGJCdveNPKSTJ3VLeNKC/kIt8R91+P7LmST+WW6kJt7p
	VRKx0pvjYRj7MiBtM9SBxawYJyvm/t
X-Google-Smtp-Source: AGHT+IGhA+g46qd55EOWEejhPdCtVd+mP4PXHk4uyrgXcMPnx+K8kZP4nEcy69zju3DcJS80pLIUWw==
X-Received: by 2002:a17:907:3f93:b0:b73:79e9:7d3b with SMTP id a640c23a62f3a-b76715938b2mr2186491066b.25.1764155524125;
        Wed, 26 Nov 2025 03:12:04 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:e97b:ea4a:70d1:4f56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm1835186866b.18.2025.11.26.03.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 03:12:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] refs: allow setting the reference directory
Date: Wed, 26 Nov 2025 12:11:59 +0100
Message-Id: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/gJmkC/22NwQ6CMBBEf4Xs2TVtpRE8+R+GQ20X2AjFtA3Rk
 P67lXj0+GYybzaIFJgiXKoNAq0cefEF1KECOxo/ELIrDEooLaXQ+PBopkTBm0QYqEfHAU+kz4o
 a6wT1UKbPUvBr1966wiPHtIT3/rLKb/oTyva/cJUosLZ9bdraNndy12E2PB3tMkOXc/4A0Bc2i
 rgAAAA=
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 gitster@pobox.com, toon@iotcl.com, sunshine@sunshineco.com, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10996;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=PjdHO/KXIbHq0kcJF7aFtXQBecBtYhls/uKheyqQfds=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGkm4IKgIw+lel8Ne838plu/n7QtzaPo5ZaLV5vB57QtJ0jc1
 okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpJuCCAAoJED7VnySORox/hO8L/ipd
 tpjGNgYRiTRg0YIqMo3eh0eupSLLuGQuepgp9FOvpC4S1tVrBHij4JAatgtpfrqRMC3rdiIVfML
 GJQU1rb9Kcu0P2/s8r/gIcSjCAOOWPQd1RY+GZ1DbtF5NZXVAXewE13Y5dUAXkmhynm/OeNrQ6X
 XK7Ve+mrhWNJ9bW10OPUMApbj7jJPnjqQY4NnYz38N+hu18U2JXVuDUXrJ+lOae1D4qgzUJIhps
 GfX8TncdRfGAeBR/VEYJ0Hy+RSucz9JSdiOshu5A+v18bJuPL3awu/aRK8Hsn2at4MsZNPkW4z9
 TXRV9HW5ow/sZTpndKaAOinpXzaeWPprp/XQCBQBZQcqYgUvkD0lPBPMBzczVorTt9s3kiUG+lU
 1j/WmcBbOPMkHO+8d7ZArF+8DiYofaTHX+XAERAQ9EkunXvkZZ1/WGUZSlsNcp1hLg0NACRn+eG
 8SjSO9mv4nCzif9lDpf3vh4KFUiUKWIC5MjzmpLFd8NVoSUpCw0nOyoTBAAA==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch series adds a new ENV variable 'GIT_REF_URI' which takes the
reference backend and path in a URI form:

    <reference_backend>://<URI-for-resource>

For e.g. 'reftable:///foo' or 'files://$GIT_DIR/ref_migration.0xBsa0'.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

For some background, at GitLab, the criteria for our migration was to
reduce the downtime of the migrate ideally to zero. So running 'git refs
migrate --ref-format=reftable' by itself wouldn't work, since it scales
with the number of references and we have repos with millions of
references, so we need to migrate without loosing any information. We
came up with the following plan:

  1. Run git-pack-refs(1) and note timestamp of the generated packed-refs
     file.
  2. Run git refs migrate –dry-run.
  3. If there are no ongoing reference requests (read/write)
     a. Lock the repository by blocking incoming requests (done on a
        layer above git, in Gitaly [1]).
     b. If the timestamp of the packed-refs file has changed, unlock
        the repo and repeat from step 1.
     c. Apply all the loose refs to the dry-run reftable folder (this
        requires support in Git to write refs to arbitrary folder).
     d. Move the reftable dry-run folder into the GIT_DIR.
     e. Swap the repo config
     f. Unlock repo access

Using such a route, scales much better since we only have to worry about
blocking the repository by O(ref written between #1 and #3a) and not
O(refs in repo). But for doing so, we need to be able to write to a
arbitrary reference backend + path. This is to add the missing
references to the dry-run reftable folder. This series, achieves that.

The first commit adds the required changes to create a 'ref_store' for a
given path. The second commit parses the URI if available when creating
the main ref store.

This is based on top of 9a2fb147f2 (Git 2.52, 2025-11-17).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v2:
- Added more clarification and proper intent in the cover message.
- Changed the format from '<ref_backend>://<path>' to
  `<ref_backend>://<URI-for-resource>` as it much clearer.
- Added logic to check for the '//' in the provided URI and a test for
  the same.
- In the tests:
  - Use test_must_fail() instead of ! git
  - Fix looped tests not using the variables correctly and ensure that
    the test description is correct.
- Link to v1: https://patch.msgid.link/20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com

---
 Documentation/git.adoc |   8 ++++
 environment.h          |   1 +
 refs.c                 |  71 +++++++++++++++++++++++++++--
 t/meson.build          |   1 +
 t/t1423-ref-backend.sh | 121 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 199 insertions(+), 3 deletions(-)

Karthik Nayak (2):
      refs: support obtaining ref_store for given dir
      refs: add GIT_REF_URI to specify reference backend and directory

Range-diff versus v1:

1:  f6e8aa37fe ! 1:  c925726efd refs: support obtaining ref_store for given dir
    @@ Commit message
         The refs subsystem uses the `get_main_ref_store()` to obtain the main
         ref_store for a given repository. In the upcoming patches we also want
         to create a ref_store for any given reference directory, which may exist
    -    in arbitrary paths. To support such behavior, extract out the core logic
    -    for creating out the ref_store from `get_main_ref_store()` into a new
    -    function `get_ref_store_for_dir()` which can provide the ref_store for a
    +    in arbitrary paths. For the files backend and the reftable backend, the
    +    reference directory is generally the $GIT_DIR.
    +
    +    To support such behavior, extract out the core logic for creating out
    +    the ref_store from `get_main_ref_store()` into a new function
    +    `get_ref_store_for_dir()` which can provide the ref_store for a
         given (repository, directory, reference format) combination.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
2:  5e30fa334e ! 2:  b859ebad64 refs: add GIT_REF_URI to specify reference backend and directory
    @@ Commit message
         Add a new environment variable 'GIT_REF_URI' that specifies both the
         reference backend and directory path using a URI format:
     
    -        <ref_backend>://<path>
    +        <ref_backend>://<URI-for-resource>
     
         When set, this variable is used to obtain the main reference store for
         all Git commands. The variable is checked in `get_main_ref_store()`
    @@ Commit message
         Add a new test file 't1423-ref-backend.sh' to test this environment
         variable.
     
    +    Helped-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/git.adoc ##
    @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., th
      	See `--ref-format` in linkgit:git-init[1].
      
     +`GIT_REF_URI`::
    -+    Specify which reference backend and path to be used, if not specified the
    -+    backend is inferred from the configuration and $GIT_DIR is used as the
    -+    path.
    ++    Specify which reference backend to be used along with its URI. Reference
    ++    backends like the files, reftable backend use the $GIT_DIR as their URI.
     ++
    -+Expects the format '<ref_backend>://<path>', where the 'backend' specifies the
    -+reference backend and the 'path' specifies the directory used by the backend.
    ++Expects the format `<ref_backend>://<URI-for-resource>`, where the
    ++_<ref_backend>_ specifies the reference backend and the _<URI-for-resource>_
    ++specifies the URI used by the backend.
     +
      Git Commits
      ~~~~~~~~~~~
    @@ refs.c: static struct ref_store *get_ref_store_for_dir(struct repository *r,
     +	}
     +
     +	format_string = ref_backend_info.items[0].string;
    ++	if (!starts_with(ref_backend_info.items[1].string, "//")) {
    ++		error("invalid reference backend uri format '%s'", uri);
    ++		goto cleanup;
    ++	}
    ++	dir = ref_backend_info.items[1].string + 2;
    ++
    ++	format_string = ref_backend_info.items[0].string;
     +	dir = ref_backend_info.items[1].string + 2;
     +
     +	if (!dir || !dir[0]) {
    @@ t/t1423-ref-backend.sh (new)
     +		cd repo &&
     +		GIT_REF_URI="" &&
     +		export GIT_REF_URI &&
    -+		! git refs list 2>err &&
    ++		test_must_fail git refs list 2>err &&
     +		test_grep "reference backend uri is empty" err
     +	)
     +'
    @@ t/t1423-ref-backend.sh (new)
     +		cd repo &&
     +		GIT_REF_URI="reftable@/home/reftable" &&
     +		export GIT_REF_URI &&
    -+		! git refs list 2>err &&
    ++		test_must_fail git refs list 2>err &&
     +		test_grep "invalid reference backend uri format" err
     +	)
     +'
    @@ t/t1423-ref-backend.sh (new)
     +		cd repo &&
     +		GIT_REF_URI="reftable://" &&
     +		export GIT_REF_URI &&
    -+		! git refs list 2>err &&
    ++		test_must_fail git refs list 2>err &&
     +		test_grep "invalid path in uri" err
     +	)
     +'
     +
    ++test_expect_success 'uri ends at colon' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init --ref-format=files repo &&
    ++	(
    ++		cd repo &&
    ++		GIT_REF_URI="reftable:" &&
    ++		export GIT_REF_URI &&
    ++		test_must_fail git refs list 2>err &&
    ++		test_grep "invalid reference backend uri format" err
    ++	)
    ++'
    ++
     +test_expect_success 'unknown reference backend' '
     +	test_when_finished "rm -rf repo" &&
     +	git init --ref-format=files repo &&
    @@ t/t1423-ref-backend.sh (new)
     +		cd repo &&
     +		GIT_REF_URI="db://.git" &&
     +		export GIT_REF_URI &&
    -+		! git refs list 2>err &&
    ++		test_must_fail git refs list 2>err &&
     +		test_grep "unknown reference backend" err
     +	)
     +'
    @@ t/t1423-ref-backend.sh (new)
     +			continue
     +		fi
     +
    -+		test_expect_success 'read from other reference backend' '
    ++		test_expect_success "read from $to_format backend" '
     +			test_when_finished "rm -rf repo" &&
    -+			git init --ref-format=files repo &&
    ++			git init --ref-format=$from_format repo &&
     +			(
     +				cd repo &&
     +				test_commit 1 &&
     +				test_commit 2 &&
     +				test_commit 3 &&
     +
    -+				git refs migrate --dry-run --ref-format=reftable >out &&
    -+				REFTABLE_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
    ++				git refs migrate --dry-run --ref-format=$to_format >out &&
    ++				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
     +				git refs list >expect &&
    -+				GIT_REF_URI="reftable://$REFTABLE_PATH" git refs list >actual &&
    ++				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >actual &&
     +				test_cmp expect actual
     +			)
     +		'
     +
    -+		test_expect_success 'write to other reference backend' '
    ++		test_expect_success "write to $to_format backend" '
     +			test_when_finished "rm -rf repo" &&
    -+			git init --ref-format=files repo &&
    ++			git init --ref-format=$from_format repo &&
     +			(
     +				cd repo &&
     +				test_commit 1 &&
     +				test_commit 2 &&
     +				test_commit 3 &&
     +
    -+				git refs migrate --dry-run --ref-format=reftable >out &&
    ++				git refs migrate --dry-run --ref-format=$to_format >out &&
     +				git refs list >expect &&
     +
    -+				REFTABLE_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
    -+				GIT_REF_URI="reftable://$REFTABLE_PATH" git tag -d 1 &&
    ++				BACKEND_PATH=$(cat out | sed "s/.* ${SQ}\(.*\)${SQ}/\1/") &&
    ++				GIT_REF_URI="$to_format://$BACKEND_PATH" git tag -d 1 &&
     +
     +				git refs list >actual &&
     +				test_cmp expect actual &&
     +
    -+				GIT_REF_URI="reftable://$REFTABLE_PATH" git refs list >expect &&
    ++				GIT_REF_URI="$to_format://$BACKEND_PATH" git refs list >expect &&
     +				git refs list >out &&
     +				cat out | grep -v "refs/tags/1" >actual &&
     +				test_cmp expect actual


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

