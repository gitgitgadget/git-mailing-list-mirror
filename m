Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E538E5CD
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012450; cv=none; b=loIP1hrYEvUvd7RvoCpXvfGl7JysIsamtnj4ii3vUkiu5OlgJchzysi9NYIiF5jPIhfuOKiWEl4CdO7kq+OUbg0fy97q8yCRSkUFIHgf787fpn+5XLVZPDYocp+z+7lkbj6q9T34GBo1pqe6AQAfAQXGIUWlBSmi95BCiyIuA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012450; c=relaxed/simple;
	bh=gx21Ixk4a5RTXqpiqKWmeYtNd6KBD7CPHdOZuhnyB8I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rZU/hXYDYKGahz3cbGHE6ATJH28zyXbXyOugfuAYELWPe15xW9V7X9ZrBEkGyBR1kiv2K7cSJY4rsfJBGCvwjrVQi8Ch4CiTa5d2mSyfEeYNaFh0jsfN5KAL5sY8sdLP7Nc5pqvnsZvZlTliRRHzTnJFRl68RLJ7CXNBJnzEu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEEk6rzc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEEk6rzc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436356740e6so6716083f8f.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012447; x=1772617247; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoSJJy5s1NjUc641eN6sggXnSV3PPzdMge48ro2mYPE=;
        b=HEEk6rzcBFQ3lHo3X6pptMBD+vXFpOOSkWTifzCY5uyMqcNW3pkXjyjF3deLewhDCk
         gmiAlpJzsVttqDGkZanxD6HZVYhxROUqnf6HdGEB+rzvsB+b0zuFaq4x26K1paZlzTgE
         9pEOodsIrUYMIAsbxtpfdxaIXTSy4Ytpj14rO0nEqFUJocuy0djGVpkdhrXuohksypAw
         Al2nAg3vG9lPzgEFttIn2FEdjE1eHRQajrmge3pBa9vdHcirYMSybfckvYvDSCjtMpKS
         TwpNsVtcSycMMpgT5LU9rMXzXY5Y5vPZ+F9uEPPKAGgotLjYD0ZeQqJr556kbJP2VD4O
         oTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012447; x=1772617247;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoSJJy5s1NjUc641eN6sggXnSV3PPzdMge48ro2mYPE=;
        b=L8twumlTTI8qKev+ITTykeTr13ialDngiKdOAS4giapExETKrTb/oECXRkNc39GnMr
         7PRwoqgXInjE3FGhHi84gfCt6J+vwN3VRUWc904hBNKyDMj7NvTJ8R0gZlq7RtaSRnZ1
         tG/vg89RYcv//lhX5GZovIESorF33W80Fy4gTFOWr1JPJ6GwqNp6uE+MrtPfT+jDpX9a
         45rg0574Xnl1XeWImGOBkWggkxGGrBQXW+Q+NtKJ4GbH6FkOUQOer3ECsKVTDEdt8kCJ
         /CZelxEyEOgz83hedl3P2QcqeMu2P0tRsY/chp5zWxAIQt7aUZAY3QFicrCAS9l/bH9u
         YYsg==
X-Gm-Message-State: AOJu0YweR69uoW7oGRYx//8zY1ee9hi+5nGtqNE2KheXeLtt4KBPtf8s
	lByDNm2iMLew9+BvRJoWmPbcMxADEW50wGn7fmZSI/qBABKA7ffxjawy
X-Gm-Gg: ATEYQzwePLk6ItDxhtqTkgiugQSsvKwE926iTCqa+15iZ5p6FFqBpuGLPcGxV1m5tOV
	1nYKwNcmfHTkjBuKtSnnsaNo5SVndwZzbdu8s3aLObseCZwz2BqapwKtcZxPaAsshMJP6nqEUZk
	xwZyk1aDMy5f9aW+IrcGO4f1DwjtBFUhrq/UpN+WsSPDFvpyCjAG7UKD0k0sBUBcBG/hRfOz4M7
	uacrC/NR9qEa0aLIKbqZoin4TpW4cQwTYT2C/jFc382iNSRV3JLw/fVVE+K68ywK8ItDeDZyOAy
	UKT0phz42r9m0h+wOF8rw6FWjNuhlqV1zBROqt7vCRKPZQ+dkNlE/dNjrwdR4kpLYQx71/6OaTu
	AZjKXX2gr8wOpeHo7eT2BkVogcXbFXjWsgSuB6F9vTnB01OWEushe/jlS8/VrWPE/RTNt5Vy3NO
	utTDVcpYks3obCnQZ3AhWHf5j9Hi4W14Q=
X-Received: by 2002:a05:600c:3e8e:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-483bef5aac0mr30077175e9.27.1772012447074;
        Wed, 25 Feb 2026 01:40:47 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d32e:ae2b:c73c:65c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm12956025e9.2.2026.02.25.01.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:40:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 0/6] refs: allow setting the reference directory
Date: Wed, 25 Feb 2026 10:40:40 +0100
Message-Id: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJjDnmkC/3XQ3WrEIBAF4FdZvK7FGf971fcovVCju9LdpCQht
 Cx5984uLU1DBRGO4jdyrmzKY80Tezpc2ZiXOtWhp+AfDiydQn/MvHaUGQrUAELzt56H85zHPsy
 Zj7nwro5cZm0xu9SJXBg9faeL+nFnX14pn+o0D+PnfcoCt9NvEPz/4AJccJWKCl4lF3P3fLyEe
 n5Mw4XdwAU3CJoGgoS46Isp4IqReo/IXwQFNBBJSAKIXpmYsIQ9on4QI2hrIIoQGaVQtACy3CN
 6i7Q60YRYJZz3TqqU4x4xGwRUAzG3TkxwmKxNRfs9YrdI6yeWEDAFrTOii13ZI26DoGwgjhChh
 U8gMaD408m6rl8P47fZmwIAAA==
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10201;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=gx21Ixk4a5RTXqpiqKWmeYtNd6KBD7CPHdOZuhnyB8I=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmew5xsqWgpg1z2XNS8Dcuo3f0OR7sM9YzRu
 FVzG4ydtwVdB4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnsOcAAoJED7VnySO
 Rox/VksL/2tKvfXd/8VTM62RqiVfOHBhHsj41jJPQU0Xpku3nfSdzUQTTOdpdVf2gXrL3qUiVC8
 e6MtbExD9/aNIHFWc944MzHnkRx48hlY1PBR8IK9agp/277eLX+vHXoRbjYVK8X4t5oEsdM196o
 jEDsmJ1TmdcSc+QoNYwjkYOW3CpcuCUDZuZ3lT8PC1/zVnYnhG9h/jUIi7+Oau701qzvX23RMjt
 XqI8S5HHc0tkE9mqWmHMD37wc5O91m6kw7sY3Gd0Is4kvLsFiOIj0B85PjlLC8RdZh413MPXhxT
 IZvJEqvRFaSdSG315cYxt7IjtjRFXzvzRTKBWIItsCXl6pWWEecysQgz6Q17PNvML+se//CQP0P
 EyLpoo24L+D3QNIbzBJ1+FNXE57CwVxdqMS6WWHk7McYmsTis3MnGmgzux8eYiF3Y/dasvubfWO
 lV7fohwTi6K5uGDUJ5kd47YEtmGqqz0ZK47Hpqrge+2+fWlbmM7qNOjpqeAcdasJ/QuBIqoHuJ8
 s0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch extends the config 'extensions.refStorage' to take in
multiple forms of inputs:

  - A format name alone (e.g., `reftable` or `files`).

  - A URI format `<format>://<payload>` explicitly specifies both the
    format and payload (e.g., `reftable:///foo/bar`).

We also add in a new ENV variable GIT_REFERENCE_BACKEND which can be
used to override the config.

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

Since there was a long gap between v3 <> v4, the version 4 onward is
based on top of 2258446484 (RelNotes: correct "fast-import" option name,
2026-01-30).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v9:
- There was a issue with how the docs were parsed, causing the list to
  not be rendered correctly.
- Some small other nits.
- Link to v8: https://patch.msgid.link/20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com

Changes in v8:
- Fix a typo/grammar in commit 4.
- In the final commits tests, avoid creating a file for text
  comparison.
- Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com

Changes in v7:
- Add more details in the commit messages.
- Cleanup some whitespace.
- Reorder the commits to be group related changes together.
- Add checks for stubs in the tests when creating new repos.
- Link to v6: https://patch.msgid.link/20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com

Changes in v6:
- The biggest change in this version is that we now support using the
  environment variable with 'git-clone(1)' and 'git-init(1)'. In such
  situations, the alternate reference directory is created and the
  config is added to the repository.
- Add a new commit which moves stub creation/removal to the generic
  layer.
- Cleanup logic flow in `refs_compute_filesystem_location()`.
- Add more tests for usage with 'git-clone(1)', 'git-init(1)' and
  migration of repositories using alternate refs backend.
- Fixup documentation, commit messages and typos.
- Link to v5: https://patch.msgid.link/20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com

Changes in v5:
- Moved around the commits, to ensure that the code to handle the config
  in the backend is first. Previously, we added the config first, which
  meant the commit allowed users to provide a URI but it was simply
  ignore.
- Fix typos and grammar and rename variables.
- Clean up the description and documentation to actually specify
  protocol over location.
- Avoid an extra memory allocation by detaching the strbuf value.
- Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com

Changes in v4:
- Mostly re-wrote the code to also support worktree. Now, the existing
  backends will store worktree references in 'ref_dir/worktrees/wt_id'
  and add corresponding stubs in 'git_dir/worktrees/wt_id'.
- We also support relative paths in the reference directories. These
  relative paths are resolved relative to the GIT_DIR.
- Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com

Changes in v3:
- Cleanup some stale code which wasn't removed.
- Localize strings which will be output to the user.
- Remove additional defensive checks which are not needed.
- Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

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
 Documentation/config/extensions.adoc |  16 +-
 Documentation/git.adoc               |   5 +
 builtin/clone.c                      |   9 +-
 builtin/worktree.c                   |  34 +++++
 environment.h                        |   1 +
 refs.c                               | 126 +++++++++++++++-
 refs.h                               |  13 ++
 refs/files-backend.c                 |  23 ++-
 refs/packed-backend.c                |   5 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  14 ++
 refs/reftable-backend.c              |  61 ++------
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  96 ++++++++++--
 setup.h                              |   4 +-
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 280 +++++++++++++++++++++++++++++++++++
 18 files changed, 625 insertions(+), 81 deletions(-)

Karthik Nayak (6):
      setup: don't modify repo in `create_reference_database()`
      refs: extract out `refs_create_refdir_stubs()`
      refs: move out stub modification to generic layer
      refs: receive and use the reference storage payload
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v8:

1:  9f1978e991 = 1:  71504213ca setup: don't modify repo in `create_reference_database()`
2:  75013d6874 ! 2:  f372287ec6 refs: extract out `refs_create_refdir_stubs()`
    @@ refs.h: void ref_iterator_free(struct ref_iterator *ref_iterator);
     + * While it is necessary within the files backend, newer backends may not
     + * follow the same structure. To go around this, we create stubs as necessary.
     + *
    -+ * If provided with a 'refs_heads_msg', we create the 'refs/heads/head' file
    ++ * If provided with a 'refs_heads_content', we create the 'refs/heads/head' file
     + * with the provided message.
     + */
     +void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
    -+			      const char *refs_heads_msg);
    ++			      const char *refs_heads_content);
     +
      #endif /* REFS_H */
     
3:  97bef9c5c0 = 3:  b79ac00a3d refs: move out stub modification to generic layer
4:  ed55f79701 = 4:  d0ffa07dfc refs: receive and use the reference storage payload
5:  5902a4588c ! 5:  bf17494952 refs: allow reference location in refstorage config
    @@ Documentation/config/extensions.adoc: For historical reasons, this extension is
     +  format and payload (e.g., `reftable:///foo/bar`).
     +
     +Supported format names are:
    -++
    ++
      include::../ref-storage-format.adoc[]
    -++
    ++
     +The payload is passed directly to the reference backend. For the files and
     +reftable backends, this must be a filesystem path where the references will
     +be stored. Defaulting to the commondir when no payload is provided. Relative
    -+paths are resolved relative to the $GIT_DIR. Future backends may support
    ++paths are resolved relative to the `$GIT_DIR`. Future backends may support
     +other payload schemes, e.g., postgres://127.0.0.1:5432?database=myrepo.
      --
      +
6:  7b0f103dbf ! 6:  d1f3323df6 refs: add GIT_REFERENCE_BACKEND to specify reference backend
    @@ t/t1423-ref-backend.sh: do
     +	(
     +		cd repo &&
     +
    -+		git config get extensions.refstorage >expect &&
    -+		echo $BACKEND >actual &&
    ++		git config get extensions.refstorage >actual &&
    ++		echo $BACKEND >expect &&
     +		test_cmp expect actual &&
     +
     +		test_commit 1 &&
    @@ t/t1423-ref-backend.sh: do
     +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
     +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
     +
    -+	git -C repo config get extensions.refstorage >expect &&
    -+	echo $BACKEND >actual &&
    ++	git -C repo config get extensions.refstorage >actual &&
    ++	echo $BACKEND >expect &&
     +	test_cmp expect actual &&
     +
     +	verify_files_exist repo/.git refdir &&


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik

