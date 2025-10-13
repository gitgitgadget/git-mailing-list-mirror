Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A02FB095
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345356; cv=none; b=m5IBvFpG3VxIss6jFfTBWmlEw01ANDzZZYJ9FJjNVQ03sr3VBPWFLa7VSCxbboUmVUQKmsJqrfOqVEdKspovg+xXp6j0wFvrFN9e3dXrnf5b8vGDPf3FVd1LCG67EszJz9wWg3RrlgQlZZI/Sl5dMVnBJsn7waVa4UION35nWSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345356; c=relaxed/simple;
	bh=5rWvcw5d3szoYtWV3WljeLVsYa92ctV3t2eShpmfs60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6TYXMQrKbbN4MjMj3ftEZkuynpcESmg4NN/gTSoWH71mx4/IjEd2biewfV43c3WEGhbyStbdbT1GXE99ObhOLxtjazf482IukmBi+VKf8a9ll6dqCXVE9yTk9M/qfBAhJ2dFtEcZZG2NLXfEtGbHQX8tH6RFiHG75aiQHcCRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI/5QYgp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI/5QYgp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so41935025e9.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345351; x=1760950151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFzuNWXOnKmRWsEUPVnVPzG/v2p75RlPr5T7VnxroZM=;
        b=mI/5QYgpsZK3zQTy5vYapR/ZzRkfkBhoHrsevW9/3RX+L73S//VjU0YLON1ba/RcJH
         jcbYarNP/vgcmno1jDsO9aAJVljofFVmPnLeAM4uIW8pfURqr+tBNQOk9I3zJ0r/Dm56
         BayPKmxcB+RL9Mt95EVak7+xPkO8i9dM6FpP/pz8f9SA2LyUMlQ6DhW9bMz3tMmL5nOU
         GO3z0EF+WgoC9Cf3daGBMgT8mwepGTnPJhzlBntNL+D3twzW9/FmkhrvjA66qFbDpYEr
         +xtUH6HS7f7+RXoYkntTlwIet6E4qgJbjh3dAvYoqs77zFtByYbiBYH8FobCjb8HSpb6
         GVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345351; x=1760950151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFzuNWXOnKmRWsEUPVnVPzG/v2p75RlPr5T7VnxroZM=;
        b=MmG6MGFXiMAXctQ3s5iL10Mvbq+m+PGopEdywHV3WIOJwSFJoHuT841bQ+0kbcdCI9
         dFBHuuM9xlv9SbIAJaOmOn+QxkBsZWc5npLzH4i0J61UmWL8Kh4QBXHJhzjoVYGUT03P
         ljSs9K7vRzmlEhdrTLDxfasFOTDm+aRGEBD37qnHScAgrU0ZNOTB2a9HojdVNp4kXYUr
         h/W+B3IEezYDxQ8d8N2Pn73v4gvIi9BngapVaD8F8I9UMoZHjJ+K8kLNR/j3PxT9jzrB
         Q+b/E362JdgmKdTYj3hFWu7/CkzH7Bf/cUaKHA4odfEuNT1wef4Bn1BihMUSFKmRwXOa
         ycrA==
X-Gm-Message-State: AOJu0YyO8Gw49PPiQj6iOML1SuVAZQM6aqNUEkSGdeKXsJa3CAHYz6QC
	tUXEt2BUg3IScypNlCsidQvgVrhOcJHrjHqANAUM6VHDNVay6R62AkrSligQBxlZ
X-Gm-Gg: ASbGncuVMmNw0Xki/ZP8FeyQ7HVkbR7+uCTIX9B+4bcwUM5sELEhDOf3ZRFvQMFllFS
	4YDgbw9rqoyU+nE45oBsBqly8+zkO5ZwMrCAsgE35IEBd5z270eQx0yWFZrgIuMZotGtnIR2RBZ
	O1N88Iyfz1TNCAME1/JE8TQcNgC2Kj+8PVH4LlwOWSgkXDbo9LIQKAkOGPG9dQxG6zbl0PZ0pII
	qODkDo2isFWNKexyE8gVz/3tB0htgVgiwdkezqMplisyphV2Qjd9idIn35mvxKcSPsNRpVnWnq6
	0WeyYLsMtrDB4mU/5x7Js0ZXcfBV6RZ1PDg1W0OXgw6YYimZHox+3T4gnxItP2R0o1DpzYVOgxU
	VGSPPHGQytXd3leEIWfvLngJfT5VRG1wd5ckMno+eM8OBOEKcDslG3LdwZDyDHePFBdKu
X-Google-Smtp-Source: AGHT+IEpOAxVfkb8FalrFP5YjQ7cMSU1KIUmANo7PWdh5SLJCZ3fxrDMq8QnHuVh4x12QN54d7N3Og==
X-Received: by 2002:a05:600c:6212:b0:46e:27f7:80ce with SMTP id 5b1f17b1804b1-46fa9af8f39mr138020235e9.23.1760345351098;
        Mon, 13 Oct 2025 01:49:11 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:10 -0700 (PDT)
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
Subject: [PATCH v3 0/5] fast-import: start controlling how tag signatures are handled
Date: Mon, 13 Oct 2025 10:48:52 +0200
Message-ID: <20251013084857.1646783-1-christian.couder@gmail.com>
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

Changes since v2
----------------

Thanks to Patrick Steinhardt, Todd Zullinger and Collin Funk who
reviewed or commented on the v1 and v2.

There is a single change in the first patch (doc: git-tag: stop
focusing on GPG signed tags) where the description of the
`-v | --verify` option of `git tag` has been improved.

CI tests
--------

I haven't run CI tests because there is a single documentation change
since v2 that is very unlikely to make things break.

Range diff since v2
-------------------

1:  eb65af631d ! 1:  ac67d927ad doc: git-tag: stop focusing on GPG signed tags
    @@ Documentation/git-tag.adoc: OPTIONS
      -v::
      --verify::
     -  Verify the GPG signature of the given tag names.
    -+  Verify the signature of the given tag names.
    ++  Verify the cryptographic signature of the given tags.
      
      -n<num>::
        <num> specifies how many lines from the annotation, if any,
2:  640204ef26 = 2:  f0208527ff lib-gpg: allow tests with GPGSM or GPGSSH prereq first
3:  8f788bafe1 = 3:  e9e3d8c081 t9350: properly count annotated tags
4:  d62a43905c = 4:  8d318a0046 fast-export: handle all kinds of tag signatures
5:  9094f37b46 = 5:  962ad96b4a fast-import: add '--signed-tags=<mode>' option


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

