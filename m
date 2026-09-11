Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5149E14F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105912; cv=none; b=csFSa+XjVFEQjLT6heBbJSckMTtWMohLL/z2Gq+kJBQHFcQMTEFVNIHQhcA70Jru79dJUMblMDCFuASW52tT3BPgGTT9hME8hbirOocJjRCbOqegk0EcuHWVof74If1zoM8CkAtzzSwRnkZaL/TsKoGxMBnSHEnPkXvv41JoBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105912; c=relaxed/simple;
	bh=uEQLX3z0S8LofxisSLqgjZA8lCiSU+0jeSchZ+KcCIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=EVjaziEsnEGOIUBhfOaXjnrmhrH+OvB0CSrP0HyCZ2+ZdDWT+S/cAVVQXJMPFaqX44snxMFV8glYO3mUCkgAg9qODKTYXaioPeRAUUZTe/CxBV3mEpuGIJqen8MqIdaNrv2A+HN4Jg0WhBoCL1kXIJlRQqy4K1s6bdYoESY65oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YFysB9Po; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NP+c390y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YFysB9Po";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NP+c390y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E3752EC06D8;
	Fri, 11 Sep 2026 01:51:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105909;
	 x=1789192309; bh=69H5H55zKiFouWej3lpvsu63X8DYo1MP7q+bAPTXwP8=; b=
	YFysB9Poh+xDmK3B3UwS0yHpTCtPDcp5EcLdRWAlxjpFqQGaPOFMUMqR16zkkDd+
	Zr4FcLL+0E0I38TuKfILNPYxIKKokv7pOzCUY0rpOjIs/oBlZbA5H4s3xzkRqty6
	pCJnufjdxhC4ytk/PcPoeRfciOVB2EEMOwg48A+DQzdJ9q+rcTwPsYYYZaG495lR
	BLHQI6bg4coXL0IedaSGW/zzyWZtWJlW0xCCuqwiLcdUnzo9Rnh0rnVR21G7qdmc
	cjl6ydaI4kHMYJoZh6Eg1t9nk+jO53ecSp/cz0XLEAsvtgiI3zNVF3rkZuEjbSRH
	myk4KofyySTfXREkERjI1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105909; x=
	1789192309; bh=69H5H55zKiFouWej3lpvsu63X8DYo1MP7q+bAPTXwP8=; b=N
	P+c390y8IiyenRHNBCNJ3SL1nBbAHvQ1a4Ex8ww6JPtKLXc5X2oi0AqNwIoFn9sQ
	hC+4cDKcF72ddqJgUmpIjb8l7VjuN8tT7o8NneAXuW0aW3JZfkyr/CaZ1VBWwqrr
	6hVS9KLG2lHHQ/q3KG9uCwt+Fs5/mhNy+h24G54mdprzWTMlNwNXchakwTnQATTc
	KAnOgYHBL1whfAeVhTMNQ7Avp2MomhUSuhp3/zDZlaPENEP3JP6ukVIfE8SVM0T8
	oY5RiJ7TD8Zk6drr0i+2xeIliDlex5EI30F/qMSdJfZAUpsrm0ngysOLZpVZtUxH
	ZrBcjKllOKZL/NXjqKIlw==
X-ME-Sender: <xms:9Zajah-g9ESBhUxcBi0_wfgJ4n7YlyIC0mmE6jDBEQFtYCL8vG5XyQ>
    <xme:9ZajatL-aVRPUEnRMNmtOT2ve7Nf8FjIpwdnXMknfJBTlJ6krfMUjDErTHh4xiMqf
    _StdDsfoWE_hCC2BgnG6PlvVoKbV8tbrl-Y-_mJHjCTpmApK-ef_g0>
X-ME-Received: <xmr:9ZajasYzKGZD1fXElcEBuVj3fNZjcLoxycdMaeEvxNHB-ur1_WOjuLOhOj5bAnXZmccbsg>
X-ME-Proxy-Cause: dmFkZTGh/xVIP+DNAhzo2D/WOJoR0iJhN25ddJBxKo8Rq0piSe3c0Ip+Uh0bRtmh/B3R0r
    SAMJXGONtMR5qDUKGezDdXuKvWx5XXVn9tR616Mvy0NlaZPxj7du8J5H3ABbqRm/KCv9IZ
    vwxC4DDic5n8GVg/NCG+HgPGAPukeBFBU7LtEeYq9BKRMeaE6yWiLJ6l6K5wI/vFie58wH
    u9hjN6NO08GFS7KlCGjCyfEclOC6jVEbj6Lf6yXZ3V/Z6b3BHTp+osfq3C3jc5gwOv7PGY
    xKHBBw/CgHKb4Mxsd9QTRgfCiZElc9yCuAgaQ93mi/SBiLPl75O7cQoi/gkcVN1161herh
    MZFEbrvSi7q+ubmJu6omQJHVrfMfOcmmFSkO72E6I2H9cIdBmvyhxxZpPNij/bvzsYxw8q
    SNcT9EQTjkHsG4IthF8gjVPpE1XsJlfIfsRVMUOR1aWzxQ1PeyB1q4hUbAzRPH9wP9TaQ4
    AqCVlJo4B30+IxuEgJfSTXKEIYheZtrJ7qU2QBJEeIPJYvWCtA9EEBz2BX+CzJN1LQGpo2
    1XwGsngykWzvt46xXRhAAH7z7/TAda49xh/zpxeVErFZf4rmzJxAIAqJX/KgA4AqvtjzJr
    rXE38/LXMvdSAusfI204OImrl7uGNHEKhIXdUnQ4yIIX/tuCNvfo3agJg9BA
X-ME-Proxy: <xmx:9ZajavJy9PSkENkdb89V25ZifN_3iStijpHclsiUn8OosrhiCApMfQ>
    <xmx:9ZajaqDY0ygGelwg4cO40_H-i4-AEIVuxdVNDS9OmpXiMs7r3QGQaQ>
    <xmx:9Zajakp95DR539o1QF6aANOAmdRA1j7YHpy1ja61-8ZOSjy33t7ryQ>
    <xmx:9Zajalje5OeqKMQlHWAQtCpU0KfuyFd2Pmovd_-f1QlVi4wHYSe9rw>
    <xmx:9ZajapKjaWkO4iRVBP0pCxPdTFaS4rQLoqygNU1HNzAe6IZgE3N-rcr0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:51:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e7b6308 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:51:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/13] odb: stop registering in-memory sources
Date: Fri, 11 Sep 2026 07:51:43 +0200
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Oyw6DIBAF0F9pWHcaQPHRVf+j6QJhVNr4CChpY
 /z3giZNly5vcufcWYhDa9CR62khFr1xZuhDSM4nolrZNwhGh0w45RktGIPx5WDQFVhsjJvCcd+
 A6aHDbrAfcMNsFTooiiwtlC5FnggSrNFibd7bzv2xZzdXT1RTxGOjDVoQtkc8i719s6RHNz0DC
 mUuE8a1qCUXt3B3MR2Jg57/k/woyQOpMiUZrzXKVP/IdV2/6C5FszwBAAA=
X-Change-ID: 20260811-pks-odb-registering-in-memory-sources-88648cd95735
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

the object database has a list of sources that is used for two
different purposes:

  - We use it to track the list of alternates.

  - We use it to track temporary in-memory sources that we create for
    various purposes. Most importantly, this is used to link object
    database sources from submodules into the main store.

This dual-use is quite awkward, as it mixes two different levels of
concerns and thus as a consequence makes both harder to reason about.
It's also a source of bugs: we make assumptions about the ordering of
sources all over the place, and we furthermore assume in other places
that the sources only contain alternates in the first place. I don't
think this surfaces in the form of real bugs, but I've long disliked
this dual-use.

Furthermore, we want to migrate handling of alternates into the "files"
backend itself in a subsequent patch series. This is most importantly to
fix a performance regression by making the backend own all of its
alternates, but it also fixes a couple of longer-standing design issues
that I've been struggling with [1].

Most importantly though: this whole machinery is not even needed at all.
A couple years ago we have already refactored our codebase so that
submodule sources don't even have to be linked into the main object
database anymore. And all the other use cases where we link sources into
the main object database can be trivially converted, too.

So this patch series does exactly that: it removes the mechanism to link
ad-hoc sources into the object database entirely. This ensures that the
list of sources is exactly the list of alternates, and that makes it
easier to move them into the "files" backend in a subsequent patch
series.

There is one exception though: creating transactions still creates a
temporary quarantine directory. This mechanism is left as-is for now,
but as it's an implementation detail of the "files" backend anyway
that's not conflicting with our above stated goals.

This series is built on top of 1630431f32 (The 21st batch, 2026-08-31)
with ty/repository-fetch-if-missing at 508ec9837c (repository: move
fetch_if_missing into struct repository, 2026-08-15) merged into it.
There's still two merge conflicts, but these are trivial to resolve: in
"odb.c" and "odb.h" you simply remove both ours and theirs, and in
"builtin/multi-pack-index.c" you only need to munge the parameters a
bit.

Changes in v3:
  - Improve commit message clarity a tiny bit :)
  - Link to v2: https://patch.msgid.link/20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im

Changes in v2:
  - Adapt `cache_tree_fully_valid()` to take a `struct index_state` as
    input instead of taking both a repository and a cache tree, as
    suggested by Junio.
  - Link to v1: https://patch.msgid.link/20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im

Thanks!

Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>

---
Patrick Steinhardt (13):
      cache-tree: drop `the_repository` in `cache_tree_fully_valid()`
      cache-tree: remove dependency on `the_repository`
      submodule-config: remove uses of `the_repository`
      submodule-config: stop using `the_hash_algo`
      submodule-config: stop registering submodule sources
      builtin/grep: stop registering submodule ODB as source
      odb: remove infrastructure to register submodule sources
      tmp-objdir: drop unused function to register alternate
      odb/packed: fix memory leaks when freeing source
      builtin/multi-pack-index: refuse unknown sources with "--object-dir="
      t/helper: adapt read-midx to not link ad-hoc source anymore
      t/helper: stop registering alternates in "ref-store" command
      odb: remove the ability to link sources ad-hoc

 builtin/checkout.c                     |  2 +-
 builtin/commit.c                       |  2 +-
 builtin/fetch.c                        |  2 +-
 builtin/grep.c                         | 28 +++-------
 builtin/multi-pack-index.c             |  3 +-
 builtin/submodule--helper.c            |  8 +--
 cache-tree.c                           | 95 +++++++++++++++++++---------------
 cache-tree.h                           |  7 +--
 odb.c                                  | 42 ---------------
 odb.h                                  | 22 --------
 odb/source-packed.c                    |  1 +
 read-cache-ll.h                        |  5 +-
 read-cache.c                           |  9 ++--
 sequencer.c                            |  2 +-
 sparse-index.c                         |  2 +-
 submodule-config.c                     | 59 +++++++++++----------
 submodule-config.h                     | 12 +++--
 submodule.c                            |  2 +-
 t/README                               |  7 ---
 t/helper/test-read-midx.c              | 43 ++++++++++-----
 t/helper/test-ref-store.c              |  8 ---
 t/helper/test-submodule.c              |  4 +-
 t/t5319-multi-pack-index.sh            |  9 ++--
 t/t5526-fetch-submodules.sh            |  3 --
 t/t5531-deep-submodule-push.sh         |  3 --
 t/t5545-push-options.sh                |  3 --
 t/t5572-pull-submodule.sh              |  3 --
 t/t6437-submodule-merge.sh             |  3 --
 t/t7418-submodule-sparse-gitmodules.sh |  3 --
 t/t7814-grep-recurse-submodules.sh     |  3 --
 tmp-objdir.c                           |  5 --
 tmp-objdir.h                           |  6 ---
 unpack-trees.c                         |  9 ++--
 33 files changed, 168 insertions(+), 247 deletions(-)

Range-diff versus v2:

 1:  95ff726928 =  1:  a785e29859 cache-tree: drop `the_repository` in `cache_tree_fully_valid()`
 2:  2b2cf592c4 =  2:  002cca01eb cache-tree: remove dependency on `the_repository`
 3:  7727c40da8 =  3:  17ab3e4553 submodule-config: remove uses of `the_repository`
 4:  6c2168af46 =  4:  586a786dc6 submodule-config: stop using `the_hash_algo`
 5:  60c1c9558d !  5:  539dd9f9d5 submodule-config: stop registering submodule sources
    @@ Commit message
         submodule-config: stop registering submodule sources
     
         When reading the ".gitmodules" file from a blob in a repository other
    -    than `the_repository`, we register the repository's object database as
    +    than `the_repository`, we register that repository's object database as
         an in-memory source of `the_repository`'s object database. This call has
         its origins in d9b8b8f896 (submodule-config.c: use repo_get_oid for
         reading .gitmodules, 2019-04-16): back then, `config_with_options()` was
 6:  7f5354c2bf =  6:  11db0ac853 builtin/grep: stop registering submodule ODB as source
 7:  24e5a2a3b7 =  7:  5d4660657c odb: remove infrastructure to register submodule sources
 8:  c07db4254f =  8:  577e58d475 tmp-objdir: drop unused function to register alternate
 9:  e1022b26a6 =  9:  00bc8549a9 odb/packed: fix memory leaks when freeing source
10:  8c5c827595 = 10:  d66457c73a builtin/multi-pack-index: refuse unknown sources with "--object-dir="
11:  7d7cb53936 = 11:  7d13925a93 t/helper: adapt read-midx to not link ad-hoc source anymore
12:  537a58d286 = 12:  6a0092d870 t/helper: stop registering alternates in "ref-store" command
13:  d704faeb44 = 13:  4e446e8a51 odb: remove the ability to link sources ad-hoc

---
base-commit: e5d60560f61f520e9ea350645a6cc9770b0f1607
change-id: 20260811-pks-odb-registering-in-memory-sources-88648cd95735

