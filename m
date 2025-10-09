Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4852D879B
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012716; cv=none; b=qAH22rQmddyuugmFkM5V3dlTnz+TfVfHln43R2MFrzWHfApZ16yVdGzxqicQA7pCJiBQvG6p9l/2FrgChar7Zn2kt1uUmo4zYWkLXfsBOPdHbTn4wGSVdb8A8J/hByRGzubHcH9TjiWV8Aj6h6AvrIYgRAikMMJnz8zxA6Jnlj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012716; c=relaxed/simple;
	bh=QVZDT9KcZFWHEiDThBhphWdVXshFCam2FbWgU8dw2H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5yeck4SzK/sLHmjSB27yXSSaZaDWGd0V0S4EFFXdJkjrK1fE60TUz2pcAnNWWfl0P9y6/BoKYryL5EoKe3a32HSgCAZXgEYPYxZRRDQU3c77+f7XfYYYnOuQ+H+WCWlAGcgiz9GBd7XjZmH50qbkjLG7y4pSq78fHZSKOtXh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbU77XH1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbU77XH1"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee130237a8so880159f8f.0
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760012712; x=1760617512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zncqTTQmQ1PxpBetRt87mNQh9snrjh7EvKO/Kj0BaFI=;
        b=NbU77XH12C3XsF6PtnSE67qcQELZGM1WXdATxyZ9pyIQsJB+3gADAf0J+45nMwEA6P
         Y5EVOzb5aiQ/eovC8sJnkOG7GaF4FjGpr9K2sa/K9JZgeBkYSz8latda0yJrRx4uwpH0
         4tOIxsDM45HgEDiCXgLxVX//pxOM28N7kspzhwWCH+B+elrnxz4eokHJuOuIPpwMUSKE
         fn0hW16d+q83isM6TLHcvtudHcjhlrHa8YRNfINzbKuew3/5eAPvlpDkF8IdFgnwYwY4
         CzJkFVHbd0j4/XvKvkzRFiVwFwM9SgrPPO/Dl6OS85CcbxGfzHCduJ1Hg86pXcfVbrAc
         l3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760012712; x=1760617512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zncqTTQmQ1PxpBetRt87mNQh9snrjh7EvKO/Kj0BaFI=;
        b=szGWisxY4NJOHaEM8l10mEeIIZQwKc1kcUJYyijQ/UD5+jLV3huYf1H5aptWAu9GJ3
         rfZWGzOiBvBPaNf1T2D2X8ojlfE33qfIQAj6oWUfcuNSUCBgsGlVj33ml1y6TioGUbcZ
         Uv+mVjIELGswRi655hxaFEsZATfgq+Ia7jT25oJ1XvcIZmvIPxIKHzQVq3RWlXgKm4Gv
         cfQ19AEF6dxV6txwj/lCjTP6U5Bu3qc/EBoe0MXCkWSEK/60puc2bn7Ad5owmeVl2RLo
         nicuxrzCgMPwVHghkpG67d9S4KtlgKxDBxWXkWeOSiWMC5Mu7Pix+qb0B0Ez9butl8PC
         KYBg==
X-Gm-Message-State: AOJu0Ywio0RbtoyI3k3bPQG1IdUcAJaDXRJwvtXuE6YMtbNdUvH1nZwf
	BxH+5N03Vvd3GKuq/ljsmWue70etuaxFvMSxMrRPGmRc8sd9BBeRwuMZHxBIYclS
X-Gm-Gg: ASbGncvLl4ST/f0GdZs3fLe8zILjCCBDWnv9pf4eBJG7ZUryPjlqzha9KDMPDPCZrmX
	nWmG45W4lZmhRfGqcrf7zRgi0lvf9kReS2KmyXHFh+3izV0cIv1sjh+gxZssCCvzHZQBIp272Kx
	cxFTY7Dmz5HrXFWqB7+KmmRlgTfnD8spMni6M8EkliAdhmd2iFEbyWjJDiyPBJCblT8jUerao+2
	5hNYik1Ez7j371EEwts7nF6PhqGuI+ra8N2PcZ33/+AwDYorXFD+e1e9ASKtJJI7pVQi63MMlmr
	5YurEVMrwlJQ2quPpbx8Vu4DSKYjFWuiOmVW5/nStoum4KE9wxugrAtsUHw4c1bp3HaANwa8D3+
	yZS6FohZkCzrn3JgNZEpo4neQdJ9Y4f0uZhMtC+9hkfFjyz6J2VzpqmP76MONrpjsmJYYjeJMMg
	==
X-Google-Smtp-Source: AGHT+IHAfFdHglGKiXaRb2tJsLxr+bW04XAOu5kEq/7udLEmBmZ8FAffqx9rckQl/WoSa488gl8M7g==
X-Received: by 2002:a5d:5d06:0:b0:3e5:394d:10bb with SMTP id ffacd0b85a97d-4266e7d4440mr4201502f8f.41.1760012711624;
        Thu, 09 Oct 2025 05:25:11 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07cbasm84831475e9.7.2025.10.09.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:25:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/5] fast-import: start controlling how tag signatures are handled
Date: Thu,  9 Oct 2025 14:24:52 +0200
Message-ID: <20251009122457.1273701-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251007122958.1089680-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduction
------------

Tools like `git-filter-repo` should be able to control how tag
signatures are handled when regenerating repository content after it
has been filtered. For this purpose, they need a way for `git
fast-import` to control how tag signatures are handled.

A previous series [1] added a '--signed-commits=<mode>' option to `git
fast-import` to control how commit signatures are handled, so this is
adding a similar '--signed-tags=<mode>' for tag signatures.

For now this new option behaves in a very similar way as the option
with the same name that already exists in `git fast-export`.
Especially it supports exactly the same <mode>s and the same aliases
for these modes. For example "ignore" is a synonym for "verbatim".

This way, both `git fast-export` and `git fast-import` have both a
'--signed-tags=<mode>' and a '--signed-commits=<mode>' supporting the
same <mode>s.

In the future I want to implement new <mode>s like "strip-if-invalid",
"re-sign", "re-sign-if-invalid" in `git fast-import` for both tag and
commit signatures. These might be a bit more complex, so for now I
prefer to start with the simple modes.

[1] https://lore.kernel.org/git/20250917181427.3193500-1-christian.couder@gmail.com/

Note about the different patches
--------------------------------

Patch 1/5 (doc: git-tag: stop focussing on GPG signed tags) is a
documentation update for `git tag`. It could go in a separate series
or be dropped altogether, but while working on this I thought that it
would be a good thing to do, as the doc is quite outdated.

Patches 2/5, 3/5 and 4/5 are preparatory patches for the main one
which is patch 5/5 (fast-import: add '--signed-tags=<mode>' option).

I wanted '--signed-tags=<mode>' to work for all kinds of signature in
tags (OpenPGP, X.509 and SSH) but soon realized that the
'--signed-tags=<mode>' option of `git fast-export` worked only for
OpenPGP signatures, so I fixed that issue in patch 4/5 (fast-export:
handle all kinds of tag signatures).

While working on the tests in patch 4/5, I found a few things to
improve that could belong to other patches so that's how I came up
with patches 2/5 and 3/5.

Changes since v1
----------------

Thanks to Patrick Steinhardt, Todd Zullinger and Collin Funk who
reviewed or commented on the v1.

- In patch 1/5, in the commit message:

  - "focussing" and "focussed" have been replaced with "focusing" and
    "focused" respectively as the former is UK Eglish while the latter
    is US English,

  - the missing "section" word has been added.

- In patch 1/5, in the git-tag doc:

  - "cryptographic" or "cryptographically" has been added to number of
    places,

  - the changes to the CONFIGURATION section have been shortened by
    not mentioning the supported signing backend (X.509 and SSH) other
    than OpenPGP, and by referring to git-config(1) more.

- In patch 2/5, the approach taken is now the one previously used by
  Todd Zullinger in:

  https://lore.kernel.org/git/20240703153738.916469-2-tmz@pobox.com/

  so this patch looks like a completely different patch in the range
  diff.

- In patch 3/5, in the commit message:

  - t9350-fast-export.sh has been quoted,

  - some explanations about alternative solutions that have been
    considered have been added.

- In patch 4/5, the added tests are now written in a modern style,
  instead of the old style used elsewhere in the script.

- In patch 5/5, a die() message has been marked for translation and
  some "/* fallthru */" comments have been properly indented.

CI tests
--------

They have all passed except again one on Windows where
"t8020-last-modified.sh" failed. See:

https://github.com/chriscool/git/actions/runs/18373100224

Range diff since v1
-------------------

1:  05d0b86de6 ! 1:  eb65af631d doc: git-tag: stop focussing on GPG signed tags
    @@ Metadata
     Author: Christian Couder <chriscool@tuxfamily.org>
     
      ## Commit message ##
    -    doc: git-tag: stop focussing on GPG signed tags
    +    doc: git-tag: stop focusing on GPG signed tags
     
    -    It looks like the documentation of `git tag` is focussed a bit too
    +    It looks like the documentation of `git tag` is focused a bit too
         much on GPG signed tags.
     
         This starts with the "NAME" section where the command is described
    @@ Commit message
         This goes on in the "OPTIONS" section too, especially about the `-s`
         and `-u <key-id>` options.
     
    -    The "CONFIGURATION" also doesn't talk about how to configure the
    -    command to work with X.509 and SSH signatures.
    +    The "CONFIGURATION" section also doesn't talk about how to configure
    +    the command to work with X.509 and SSH signatures.
     
         Let's rework all that to make sure users have a more accurate and
         balanced view of what the command can do.
     
    +    Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-tag.adoc ##
    @@ Documentation/git-tag.adoc: and `-a`, `-s`, and `-u <key-id>` are absent, `-a` i
      Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
      tags; they contain a creation date, the tagger name and e-mail, a
     -tagging message, and an optional GnuPG signature. Whereas a
    --"lightweight" tag is simply a name for an object (usually a commit
    --object).
    -+tagging message, and an optional signature. Whereas a "lightweight"
    -+tag is simply a name for an object (usually a commit object).
    ++tagging message, and an optional cryptographic signature. Whereas a
    + "lightweight" tag is simply a name for an object (usually a commit
    + object).
      
    - Annotated tags are meant for release while lightweight tags are meant
    - for private or temporary object labels. For this reason, some git
     @@ Documentation/git-tag.adoc: OPTIONS
      
      -s::
    @@ Documentation/git-tag.adoc: OPTIONS
     -	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
     -	configuration variable if it exists, or disabled otherwise.
     -	See linkgit:git-config[1].
    -+	Make a signed tag, using the default signing key. The signing
    -+	backend used depends on the `gpg.format` configuration
    -+	variable. The default key is determined by the backend. For
    -+	GPG, it's based on the committer's email address, while for
    -+	SSH it may be a specific key file or agent identity. See
    -+	linkgit:git-config[1].
    ++	Make a cryptographically signed tag, using the default signing
    ++	key. The signing backend used depends on the `gpg.format`
    ++	configuration variable. The default key is determined by the
    ++	backend. For GPG, it's based on the committer's email address,
    ++	while for SSH it may be a specific key file or agent
    ++	identity. See linkgit:git-config[1].
      
      --no-sign::
      	Override `tag.gpgSign` configuration variable that is
    @@ Documentation/git-tag.adoc: OPTIONS
      -u <key-id>::
      --local-user=<key-id>::
     -	Make a GPG-signed tag, using the given key.
    -+	Make a signed tag using the given key. The format of the
    -+	<key-id> and the backend used depend on the `gpg.format`
    -+	configuration variable. See linkgit:git-config[1].
    ++	Make a cryptographically signed tag using the given key. The
    ++	format of the <key-id> and the backend used depend on the
    ++	`gpg.format` configuration variable. See
    ++	linkgit:git-config[1].
      
      -f::
      --force::
    @@ Documentation/git-tag.adoc: it in the repository configuration as follows:
     +    signingKey = <key-id>
      -------------------------------------
      
    -+The signing backend is controlled by the `gpg.format` configuration
    -+variable, which defaults to `openpgp` for GPG signing. To sign tags
    -+using other technologies like X.509 or SSH, set this variable to
    -+`x509` or `ssh` respectively.
    ++The signing backend can be chosen via the `gpg.format` configuration
    ++variable, which defaults to `openpgp`. See linkgit:git-config[1]
    ++for a list of other supported formats.
     +
    -+You can also specify the path to the signing program for each
    -+format. The `gpg.program` variable (or its synonym
    -+`gpg.openpgp.program`) is used for the OpenPGP backend. For other
    -+backends, the configuration is `gpg.<format>.program`, for example
    -+`gpg.ssh.program` for SSH signing.
    ++The path to the program used for each signing backend can be specified
    ++with the `gpg.<format>.program` configuration variable. For the
    ++`openpgp` backend, `gpg.program` can be used as a synonym for
    ++`gpg.openpgp.program`. See linkgit:git-config[1] for details.
     +
      `pager.tag` is only respected when listing tags, i.e., when `-l` is
      used or implied. The default is to use a pager.
2:  61a1116542 < -:  ---------- lib-gpg: allow tests with the GPGSM prereq first
-:  ---------- > 2:  640204ef26 lib-gpg: allow tests with GPGSM or GPGSSH prereq first
3:  b2b703ae9d ! 3:  8f788bafe1 t9350: properly count annotated tags
    @@ Metadata
      ## Commit message ##
         t9350: properly count annotated tags
     
    -    In t9350-fast-export.sh, these existing tests:
    +    In "t9350-fast-export.sh", these existing tests:
     
           - 'fast-export | fast-import when main is tagged'
           - 'cope with tagger-less tags'
    @@ Commit message
         added, and then by comparing the number of annotated tags to the value
         of the counter when checking the number of annotated tags.
     
    +    This is a bit ugly, but it makes it explicit that some tests are
    +    interdependent. Alternative solutions, like moving the new tests to
    +    the end of the script, were considered, but were rejected because they
    +    would instead hide the technical debt and could confuse developers in
    +    the future.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## t/t9350-fast-export.sh ##
4:  b51e904f90 ! 4:  d62a43905c fast-export: handle all kinds of tag signatures
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
      '
      
     +test_expect_success GPGSM 'setup X.509 signed tag' '
    -+
     +	test_config gpg.format x509 &&
     +	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
     +
     +	git tag -s -m "X.509 signed tag" x509-signed $(git rev-parse HEAD) &&
     +	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
    -+
     +'
     +
     +test_expect_success GPGSM 'signed-tags=verbatim with X.509' '
    -+
     +	git fast-export --signed-tags=verbatim x509-signed > output &&
     +	test_grep "SIGNED MESSAGE" output
    -+
     +'
     +
     +test_expect_success GPGSM 'signed-tags=strip with X.509' '
    -+
     +	git fast-export --signed-tags=strip x509-signed > output &&
     +	test_grep ! "SIGNED MESSAGE" output
    -+
     +'
     +
     +test_expect_success GPGSSH 'setup SSH signed tag' '
    -+
     +	test_config gpg.format ssh &&
     +	test_config user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
     +
     +	git tag -s -m "SSH signed tag" ssh-signed $(git rev-parse HEAD) &&
     +	ANNOTATED_TAG_COUNT=$((ANNOTATED_TAG_COUNT + 1))
    -+
     +'
     +
     +test_expect_success GPGSSH 'signed-tags=verbatim with SSH' '
    -+
     +	git fast-export --signed-tags=verbatim ssh-signed > output &&
     +	test_grep "SSH SIGNATURE" output
    -+
     +'
     +
     +test_expect_success GPGSSH 'signed-tags=strip with SSH' '
    -+
     +	git fast-export --signed-tags=strip ssh-signed > output &&
     +	test_grep ! "SSH SIGNATURE" output
    -+
     +'
     +
      test_expect_success GPG 'set up signed commit' '
5:  6987fc0bae ! 5:  9094f37b46 fast-import: add '--signed-tags=<mode>' option
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
     +
     +	/* First, modes that don't change anything */
     +	case SIGN_ABORT:
    -+		die("encountered signed tag; use "
    -+		    "--signed-tags=<mode> to handle it");
    ++		die(_("encountered signed tag; use "
    ++		      "--signed-tags=<mode> to handle it"));
     +	case SIGN_WARN_VERBATIM:
     +		warning(_("importing a tag signature verbatim for tag '%s'"), name);
    -+			/* fallthru */
    ++		/* fallthru */
     +	case SIGN_VERBATIM:
     +		/* Nothing to do, the signature will be put into the imported tag. */
     +		break;
    @@ builtin/fast-import.c: static void parse_new_commit(const char *arg)
     +	/* Second, modes that remove the signature */
     +	case SIGN_WARN_STRIP:
     +		warning(_("stripping a tag signature for tag '%s'"), name);
    -+			/* fallthru */
    ++		/* fallthru */
     +	case SIGN_STRIP:
     +		/* Truncate the buffer to remove the signature */
     +		strbuf_setlen(msg, sig_offset);



Christian Couder (5):
  doc: git-tag: stop focusing on GPG signed tags
  lib-gpg: allow tests with GPGSM or GPGSSH prereq first
  t9350: properly count annotated tags
  fast-export: handle all kinds of tag signatures
  fast-import: add '--signed-tags=<mode>' option

 Documentation/git-fast-import.adoc |  5 ++
 Documentation/git-tag.adoc         | 48 ++++++++++++------
 builtin/fast-export.c              |  7 ++-
 builtin/fast-import.c              | 43 ++++++++++++++++
 t/lib-gpg.sh                       | 24 +++++++--
 t/meson.build                      |  1 +
 t/t9306-fast-import-signed-tags.sh | 80 ++++++++++++++++++++++++++++++
 t/t9350-fast-export.sh             | 48 ++++++++++++++++--
 8 files changed, 229 insertions(+), 27 deletions(-)
 create mode 100755 t/t9306-fast-import-signed-tags.sh

-- 
2.51.0.438.g6987fc0bae

