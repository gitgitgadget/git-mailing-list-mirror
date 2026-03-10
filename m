Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7703148C2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165197; cv=none; b=MlXn2VFMTY2gWn1XYl4qcOcLqYEGRKGJD+3+kQvEOHyZc+Plqk7MawjcSoPPQkAyiiTBglQATQgPzLVQcIdif4HAHh+lHAofIGVPs3GBMC/YnSYpHq2jbWxsDXBHeHndHv0VTyMuzEQOmWvn04q6ZpZa7As3O0T6IEG9tqOat1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165197; c=relaxed/simple;
	bh=wvzsbmhCg3GwCHjhuWOd4rO26GsVWMIPNftageFGB1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hx83JXoeLIwtptyNr+SJTRzJ1tWCg7GDHbAschTj82VXhfaYW8pS/g8fWBlvWtjXVnhx8CrXavxyhfcXD/4bXUeJuycF7Q5xa+flv6guMH+zLHNMylRpc/6x7uSatpIkN6+1wGegI8tIBreeKHnsEbgsorxkxG2HG6aQ8XxbjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EgozOJEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2fmF71+E; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EgozOJEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2fmF71+E"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 279DF14000B2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 13:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165194;
	 x=1773251594; bh=xEObYSUWMtzefNQVLU7sRRHfRXCGjwXIVJnyDEj15TM=; b=
	EgozOJEui+CkITdQY86eceQOEf6PTDQwPg6O9S1fCjTQFH5+dSyho6Ut9Gw2S495
	VUlVGNannxeAQAfM0mQCDgWxkmAJ2wp6VWyr8+IdZRvB+faz3Qd+s+O/SU9LWtm0
	QFyYq/WeMHpSQU4/Ok6tMbpr+J5kx1VE2dayuasssLddT4qqzqDD3VlDrBF+Mqbx
	aV/UH0DkODCASUwc0tNVbrAQO7u8a06JKVe3AKqxOJ49BMSgXNwTRWPfoDi2i2pf
	mSXWzHTt1zrz2e8xyVdvnTIlGTrFNYP+YZMDi7zz3aIq8h6jIb3uSGqrzEG3kN44
	GnAr7Ss7FgUdZXADMfCq3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165194; x=
	1773251594; bh=xEObYSUWMtzefNQVLU7sRRHfRXCGjwXIVJnyDEj15TM=; b=2
	fmF71+EmiVi8SG9kklgcV8rDT9eTaWx2JXqlHRYMUZ8FgG/51mhKCrKYrSQ5tkH2
	elwSQ2y8mBuuBHF4KjUhASVux/ZkNqarfpXjB/r0Kl1QAz+Jsz2J0D7HBhTHBicj
	qGAfYJ8ZwSevZbcDWOAu4oAYu1W03iz5EpksVrAtAdzYhhWPOLUw5kwdABN+Ed4Y
	XmR8QyuxrM3JJ5oQ1JdJgEWHWr7xPRBiInN359zBGCN3wdZkvlJqFV9Z2rEu8aib
	nymZjAUpF9W/rfqimolLfMiAyAsON0ZAQYNYiP8Lc3pWTc0m9Xidcqnp4HQT6dfR
	wVdjbcrurxbyPB54LTc0A==
X-ME-Sender: <xms:ilqwafdMp6OCTii70_Kxub5yWh6Bd44pK0LqYZtAKkJlypMvadqk_A>
    <xme:ilqwacLDtclwNr1KkPHjW5gr8wEN9hwmq5pHThhDODTWVgTzSXB-VXUiUU0Z4yIxg
    R4wHbvE05rE9b0iWWDePwXrl-j0ZWwa-OJMH_NbXoYf8kGCb06nQw>
X-ME-Received: <xmr:ilqwaeIQP18WtamOJoaedWxCcH-sV_KIAxGOR5N3cou78PTpW9gg9_PFS0M3m9EtyDrj-48yPzt9kWvm9Bx038I4nqGEjjvzrEU0eI-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthekre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfe
    fgtdduffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ilqwaWG90isnhYQoRTBV1fXjf8RMHhPcVqAlgzWi9TrKmXnLb_Su2A>
    <xmx:ilqwabm9cFMYCeOEt_yuUApwnhGO0H9P4vUxVpWRgeuBJ8K6V7Ll8A>
    <xmx:ilqwabLqq-cjdGf9-3V3KnnGq_Szi9JNb95uQ0DFU3qYowTVDVfyyg>
    <xmx:ilqwaUbjJeAns6WGwP62uvonYNSHeyKQBOVNViMZtHzwOOFYZDYCow>
    <xmx:ilqwaRMn5VeOZ3yOtTz4TZiPTexTTDcKmAMfoEQ2wJa6oBSTFJaKBOzI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fdd6001b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:41 +0100
Subject: [PATCH 8/8] meson: precompile "git-compat-util.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-8-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Every compilation unit in Git is expected to include "git-compat-util.h"
first, either directly or indirectly via "builtin.h". This header papers
over differences between platforms so that we can expect the typical
POSIX functions to exist. Furthermore, it provides functionality that we
end up using everywhere.

This header is thus quite heavy as a consequence. Preprocessing it as a
standalone unit via `clang -E git-compat-util.h` yields over 23,000
lines of code overall. Naturally, it takes quite some time to compile
all of this.

Luckily, this is exactly the kind of use case that precompiled headers
aim to solve: instead of recompiling it every single time, we compile it
once and then link the result into the executable. If include guards are
set up properly it means that the file won't need to be reprocessed.

Set up such a precompiled header for "git-compat-util.h" and wire it up
via Meson. This leads to a significant speedup when performing full
builds:

  Benchmark 1: ninja (rev = HEAD~)
  Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
  Range (min … max):   14.195 s … 14.633 s    10 runs

  Benchmark 2: ninja (rev = HEAD)
    Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
    Range (min … max):   10.030 s … 10.433 s    10 runs

  Summary
    ninja (rev = HEAD) ran
      1.40 ± 0.02 times faster than ninja (rev = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build         | 2 ++
 tools/precompiled.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/meson.build b/meson.build
index cd00be1c23..4b3fd47061 100644
--- a/meson.build
+++ b/meson.build
@@ -1760,6 +1760,7 @@ libgit = declare_dependency(
       c_args: libgit_c_args + [
         '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
       ],
+      c_pch: [ 'tools/precompiled.h' ],
       dependencies: libgit_dependencies,
       include_directories: libgit_include_directories,
     ),
@@ -1820,6 +1821,7 @@ test_dependencies = [ ]
 
 git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
+  c_pch: [ 'tools/precompiled.h' ],
   dependencies: [libgit_commonmain],
   install: true,
   install_dir: git_exec_path,
diff --git a/tools/precompiled.h b/tools/precompiled.h
new file mode 100644
index 0000000000..b2bec0d2b4
--- /dev/null
+++ b/tools/precompiled.h
@@ -0,0 +1 @@
+#include "git-compat-util.h"

-- 
2.53.0.880.g73c4285caa.dirty

