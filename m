Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B42236E3
	for <git@vger.kernel.org>; Mon, 11 May 2026 05:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476814; cv=none; b=PgqtJTCnbdG+gwyuGqbNThvKXIu7xagtEY/Tcb7/fs2ZG/gq6sMTgSSaAWaZr8FCfsa8LWqrDN893JLjqa2wbjiAFPIdtZcIXgaDJNLqZ7nKumFEfdIFMQ3lISL+85hjTv2VPANrrgV6hgVfFO6WPnybL/QwF8fUOQtzdUWNkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476814; c=relaxed/simple;
	bh=NiGkbN+IvMZS1h546NXPmW/coU9rafmC2+cY3Hs6pKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dpjy9FIGBMB2+Mpi5IAiB83G6rGIqJ+QihD68HgoOLHhyNfto8qB00o2cIAPtDwzIf9FF4FLitXVPaKAZq4NKZ6iSlQdrCWTfYa99GLErFJrHzMQmviR1JgSB6M5CGSFVrfzeAW1EnKDq9jSAlkUGjNzCizDSaopyVfFmFAlywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqOlw9wW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlUFKhu9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqOlw9wW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlUFKhu9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 968381D0006C;
	Mon, 11 May 2026 01:20:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 01:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778476811; x=1778563211; bh=dTzJ3fTG33
	m656z2eMqE5oyq+/YAbDxSzfEZ2HNe4Sk=; b=gqOlw9wWFtb/VwI181nXOih4bd
	X96ZkraGrOh+L4yuUhN1KV/zGGzrp7iSdzGVoNzLl4hrFZHzXfI4XQIf4nYw1Nvo
	fzWdnZU4Y2v7JqZzzKvLl8PyMugL1nFjxZ/FlpOy5176YJRRvWd5KZQEYC+JaxPz
	CAXLd4E/cO5MvlQpzn8CxUwiPmjQwV/DotPCiXgB9acTc2IEfQbJcp3DVn0eE5ZB
	FG5JT3OB/t62kghUvYn/wvp6ojUbNVjOjQ1Hbb9GZZDiz8YmykWvPRp3UKY1THKy
	quOldhKb1RftT/7qzf0RtYxcNXxjt9htXuit5uFcH52CaoRLvYgbzSs88Z5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778476811; x=1778563211; bh=dTzJ3fTG33m656z2eMqE5oyq+/YAbDxSzfE
	Z2HNe4Sk=; b=nlUFKhu9qcPqdrtdqRj0IQ5MRfHPiB7oaIhUGwecP7FeQxpHffh
	4sVZRDB7LyCsAUExRdqXRrGHO442+Ti4OvGIVbfU7U0J1LHxcU01TpbpnDaimwzv
	hp+AybcwsAOLns6qybW/KBf3B2RQjIKOKIrG5Wlj2vxBjh28+QqYcPI2U/zaE8jH
	TadOQBkuJ08XMBAV4TQF23wmi0cH7X31C+IWYKyDt3zVUQbX8XKLerYWsYSgUmGo
	U9woY7yaEoL2uzwnpuu1ihbXWAYk6eifUWSmq8/WRNZMi4SFDUECHSPpuJpJfLM8
	Wt/cccz7/1xshwF2iU8l8+nYzI6hLp7WvBg==
X-ME-Sender: <xms:C2cBalsB3D3HFwbLglebfK_Z3srS5_7QTCjUN4h1iRquk7GVWCp2Hw>
    <xme:C2cBalcW94y9u-_tal8qyJV7p9EtiTb1Z4SakxYfP9MPWDDmGxi_IenbgWtkccVuq
    bOEebRZV8JwcVIPo1BGaBLj3lbUFdBuhTwDrdDcVqTd_GqC5ciraEU>
X-ME-Received: <xmr:C2cBaty6ZHvFyHPBL_nEhakAOAypO1LkRaoNSjXnSm9r4C83cp7hdPj0GKPpSO1eLhoFG9G7PBmOroKdT1KD1NAUkFfW-uUvMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieffveefleejudeikeeiudekgfegvdetuedtuedvgefghfejuedtfeefjeff
    jedtnecuffhomhgrihhnpehmrghkrdguvghvpdhrvgguhhgrthdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhnrghtuhesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C2cBarFFte2b5p_2JpD4iVv6gQXx0MZzF7lfwLm-N4c-IavD5jnEVw>
    <xmx:C2cBahzoOH0jR8JC_AhSx6aTn83To3B3m3bmGCT6OqeYWBHkENQy5w>
    <xmx:C2cBastJKgLA_8J56H5IwE-5LJ70apG9zxIrTFN_BgPoWKzNteNRMQ>
    <xmx:C2cBau3gXIMnhfkRRH6AN8rvlf5IfKg62Ow0Kaeow36-MiYkHmbJ-g>
    <xmx:C2cBav07qJsHCjpi-Jl72eq3UbPBMbD8IfnfK66neqtGsZ4PQsiO8JBa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 01:20:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Shardul Natu <snatu@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] build: tolerate use of _Generic from glibc 2.43 with Clang
In-Reply-To: <xmqqzf26sk80.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	11 May 2026 12:23:11 +0900")
References: <20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im>
	<xmqqzf26sk80.fsf@gitster.g>
Date: Mon, 11 May 2026 14:20:09 +0900
Message-ID: <xmqqqzniset2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Wouldn't the approach you took on the meson side to pass
> "-Wno-c11-extensions" be yet another alternative?

In other words, I would imagine something like this patch that uses
the same strategy on both sides may be easier to reason about.

----- >8 -----
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] build: tolerate use of _Generic from glibc 2.43 with Clang

When building with `make DEVELOPER=1` we explicitly pass "-std=gnu99" to
the compiler so that we don't start leaning on features exposed by more
recent versions of the C standard. Unfortunately though, glibc 2.43
started to use type-generic expressions. This works alright with GCC,
but when compiling with Clang this leads to errors:

  $ make DEVELOPER=1 CC=clang
  CC daemon.o
  In file included from daemon.c:3:
  ./git-compat-util.h:344:11: error: '_Generic' is a C11 extension [-Werror,-Wc11-extensions]
    344 |         return !!strchr(path, '/');
        |                  ^
  /usr/include/string.h:265:3: note: expanded from macro 'strchr'
    265 |   __glibc_const_generic (S, const char *, strchr (S, C))
        |   ^
  /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from macro '__glibc_const_generic'
    838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
        |   ^

In theory, the `__glibc_const_generic` macro does have feature gating:

  #if !defined __cplusplus \
      && (__GNUC_PREREQ (4, 9) \
          || __glibc_has_extension (c_generic_selections) \
          || (!defined __GNUC__ && defined __STDC_VERSION__ \
              && __STDC_VERSION__ >= 201112L))
  # define __HAVE_GENERIC_SELECTION 1
  #else
  # define __HAVE_GENERIC_SELECTION 0
  #endif

But this feature gating isn't effective because `_has_extension()` will
always evaluate to true as C generics _are_ available as a language
extension to GNU C99 when using Clang. This would have been different if
`_has_feature()` was used instead, in which case it would have properly
evaluated to `false`.

GCC has a workaround to squelch this warning from standard system
headers, but because clang fails due to [-Werror,-Wc11-extensions],
as it lacks the corresponding workaround.

For both meson and Makefile, pass -Wno-c11-extensions when we are
building with clang.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Shardul Natu <snatu@google.com>
[jc: replaced Makefile side with Shardul's approach]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.dev | 7 +++++++
 meson.build    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/config.mak.dev b/config.mak.dev
index e86b6e1b34..794b1c9627 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -98,6 +98,13 @@ endif
 endif
 endif
 
+# glibc 2.43 headers unconditionally use _Generic even when we ask the
+# compiler to stick to -std=gnu99 and unlike GCC, clang lacks a
+# workaround to squelch warnings from system headers.
+ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using clang
+DEVELOPER_CFLAGS += -Wno-c11-extensions
+endif
+
 # https://bugzilla.redhat.com/show_bug.cgi?id=2075786
 ifneq ($(filter gcc12,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wno-error=stringop-overread
diff --git a/meson.build b/meson.build
index dd52efd1c8..536bd2679c 100644
--- a/meson.build
+++ b/meson.build
@@ -854,6 +854,12 @@ if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argum
       libgit_c_args += cflag
     endif
   endforeach
+
+  # Clang generates warnings when compiling glibc 2.43 because of the use of
+  # _Generic.
+  if compiler.get_id() == 'clang'
+    libgit_c_args += '-Wno-c11-extensions'
+  endif
 endif
 
 if get_option('breaking_changes')
-- 
2.54.0-170-g88022b8681

