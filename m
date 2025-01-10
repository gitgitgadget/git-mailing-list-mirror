Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7545DF78
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513739; cv=none; b=apEuclqsk12jFsUP21+qh6HaiwMDn7iX+0Tl7G4IbQNz3MgkDMfziWpJeX4DC3D/qDuyrSt82Sdn/vnE/30zG128HxB3I8P7wfO7WXkmZKuEY46BK0qv2WjvYEIU8ghWtvUO871zqtW7fak7XhgWH2sM5vqtFGT9bvB7OzzETZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513739; c=relaxed/simple;
	bh=Vb44dozQLkEMVRIwytBBG30xLqY8s6o/N0yR18AdhZE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PjbDe0dnwFjgr3d/grdcyypX6zISl8ofytAWIdKwXopTVrZlzAGAGURRZY2vEodfzZ1lpBeBzKEUk9WArlcwNTVYAtkk2FY4JwGQr5+DuqB7oKFqs2Ims5IgWfMCsHj15upY+OtW6B9kVN9F8n+NqGtC4v19S63MgZ/PpGB/dVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SklgtQXK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qyny0LNq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SklgtQXK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qyny0LNq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C4BC911400FF
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jan 2025 07:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736513735; x=1736600135; bh=tjpIkkXN/4
	A4mlZQwHD80B5bR1WCPVa3V9E7Vukr+/M=; b=SklgtQXKZXUJxkKDAI5rsi1K29
	X9+69aMdFGgkC7unSDcg15F31wcEWNGRCUhoee8ahi1YCkgwjhZtfeQqENOeLhU4
	A7Jxs+FfPJBF+0gLLXUIYpa1wacCB+DUSZcZobQoWOD11PbAryvb0tTbgcOAtajJ
	oWBFHoqw/66g83Up9+IZWZTfWhyqhT3DK8P4yPyIhlgLjLjuSP1rB6Gc1AQb6bFO
	ywfWh1NbovRrxNOq3zt7rAwVXZ/sk7Gb5JVhfKr1eE2CLUGdmRckLWGqeWOdBNsr
	vP+Fr0gprcUxAO0sT7wWwHt2qM9mRPgnbJEh0T0vvmWRBNvrkRDDeww5QISA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736513735; x=1736600135; bh=tjpIkkXN/4A4mlZQwHD80B5bR1WC
	PVa3V9E7Vukr+/M=; b=Qyny0LNqzRPkyW9YL/e+xT6ull+vPLvNxh6J5ijIfLL3
	Y02pi00adn8tYZxNUfxLygF5BxTyE2HMfhj1176dp+EM/NB+jh7t0ceiKeS0J2/m
	lgoaLPNSNz08JZyRef6DSa9FRJl24RiNdGTuTq+J8wDnEF8q1T4wO36QcwhArhRH
	4S69tLIortKz1b2Y/xMHn/Sl9qUjgGd0jF4yKHjfC/ia2+uKT7TjI2TWQr8z9gzu
	Lqq+n8Ir6AIiAI2gpQLO16ANcELZv/YKwl8xQNaKczuWkXQbgWdiZC9ZQKXTtBww
	ez6yYZa57IuNLz3N5AwJ+P+yIk7ym1j8oIMStc6ofA==
X-ME-Sender: <xms:xxiBZz6qHBvOls8VtXYHunZ6rfGxsIGn0a8dmok7E5oBuTNqlWA9Ag>
    <xme:xxiBZ45MRkn1Fwzj7ZLeA817SbQliHR52PBMzeF3Jn_AjD6p1anW7-dxmDXlQa5J6
    pl_G55gObVmUtFCmw>
X-ME-Received: <xmr:xxiBZ6eE_gm20wwugCFOmv9Uydm-mhhP-qt_nm99srxbJ0yJ_aDs40ErW9eHfOnObOqQgBlm5vw0sZkgpkPh-itfLHMqnJ-noGcjne3Rw7IW5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffelgefhjeefje
    dtueeffffgkeekjefhieffudegtdfguedvgedtlefhjeeugeejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xxiBZ0LxY01CrdQADV1S06UrfUw7IXbO66rNTeLNLcBM5z5TvUcrCQ>
    <xmx:xxiBZ3LJap__olrjaSk5iWDxevyud5IGTyTmkxCKbMS-oe6zm5_6iw>
    <xmx:xxiBZ9zNcuPxUZ4otvmMT0XL8Z_64jKg4E0NLiaStv2PHbqOaKJSmA>
    <xmx:xxiBZzLgQv4qt2T5b9Fi7Evob7bwWxC4VlY_QhDm6InJ0fm5cFGAZQ>
    <xmx:xxiBZ9gimwRfW4HCTNqNzkGPSbZaiXoWvjidRHCj5XOplTBjEbGmZFzB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb8d6150 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] compat/zlib: allow use of zlib-ng as backend
Date: Fri, 10 Jan 2025 13:55:27 +0100
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL8YgWcC/x3NQQ6DIBCF4auQWXcSQFjoVZouFEc7aQTC1KaJ4
 e6iy+9fvHeAUGESGNQBhX4snGKDeSgI7zGuhDw3g9XWa2M0Tg7zRzCkLY9fnEvKuMdLhUQs0uR
 745zvQ2ehjbS88P8+eL5qPQGVMWlZcAAAAA==
X-Change-ID: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

I have recently started to play around with zlib-ng a bit, which is a
hard fork of the zlib library. It describes itself as zlib replacement
with optimizations for "next generation" systems. As such, it contains
several implementations of central algorithms using for example SSE2,
AVX2 and other vectorized CPU intrinsics that supposedly speed up in-
and deflating data.

And indeed, compiling Git against zlib-ng leads to a significant speedup
when reading objects. The following benchmark uses git-cat-file(1) with
`--batch --batch-all-objects` in the Git repository:

    Benchmark 1: zlib
      Time (mean ± σ):     52.085 s ±  0.141 s    [User: 51.500 s, System: 0.456 s]
      Range (min … max):   52.004 s … 52.335 s    5 runs

    Benchmark 2: zlib-ng
      Time (mean ± σ):     40.324 s ±  0.134 s    [User: 39.731 s, System: 0.490 s]
      Range (min … max):   40.135 s … 40.484 s    5 runs

    Summary
      zlib-ng ran
        1.29 ± 0.01 times faster than zlib

So we're looking at a ~25% speedup compared to zlib. This is of course
an extreme example, as it makes us read through all objects in the
repository. But regardless, it should be possible to see some sort of
speedup in most commands that end up accessing the object database.

This patch series refactors how we wire up zlib in our project by
introducing a new "compat/zlib.h" header function. This header is then
later extended to patch over the differences between zlib and zlib-ng,
which is mostly just that zlib-ng has a `zng_` prefix for each of its
symbols. Like this, we can support both libraries directly, and a new
Meson build options allows users to pick whichever backend they like.

In theory, these changes shouldn't be necessary because zlib-ng provides
a compatibility layer that make it directly compatible with zlib. But
most distros don't allow you to install zlib-ng with that layer is it
would mean that zlib would need to be replaced globally. Instead, they
typically only provide a version of zlib-ng that only has the `zng_`
prefixed symbols.

Given the observed speedup I do think that this is a worthwhile change
so that users (or especially hosting providers) can easily switch to
zlib-ng without impacting the rest of their system.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      compat: drop `uncompress2()` compatibility shim
      git-compat-util: drop `z_const` define
      compat: introduce new "zlib.h" header
      git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
      compat/zlib: provide `deflateBound()` shim centrally
      compat/zlib: provide stubs for `deflateSetHeader()`
      git-zlib: cast away potential constness of `next_in` pointer
      compat/zlib: allow use of zlib-ng as backend

 Makefile                  |  1 -
 archive-tar.c             |  4 --
 archive.c                 |  1 +
 compat/zlib-compat.h      | 47 +++++++++++++++++++++++
 compat/zlib-uncompress2.c | 96 -----------------------------------------------
 config.c                  |  1 +
 csum-file.c               |  3 +-
 environment.c             |  1 +
 git-compat-util.h         | 12 ------
 git-zlib.c                |  6 +--
 git-zlib.h                |  2 +
 meson.build               | 22 ++++++++---
 meson_options.txt         |  2 +
 reftable/block.c          |  1 -
 reftable/system.h         |  1 +
 15 files changed, 75 insertions(+), 125 deletions(-)


---
base-commit: 05388c0e69a3497fceb0b5c80ca76d1a6bc3afcd
change-id: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32

