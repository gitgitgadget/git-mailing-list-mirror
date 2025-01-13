Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30549231A50
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757243; cv=none; b=RB6qYrOXKKztkweAXP54JSvewwUs7z4lLRMMJuCWogNndCWxBy4gy5GXWFS21LA0a/lV2rwo8QlKIGP/a7hfUbACGUktfQgRoSUpPo0yxb/+dLcQzJONhGElPSZjpqslRA51/Gb5Lb5AH67DbD2NBEhYibv4IMi+r3ALXZ2YP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757243; c=relaxed/simple;
	bh=o2iWhaRDbf4mZTtvqjXbtUYxc5edAYKfxsFRwJR5zAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riHcjKGhJ6EuKKV+quLKBc1gezm3/3K2pQI6D/o8b2wVrbkapPE/dKe0WM8b2w7/1rnWHgAX6gbNZGPFsg903iuzd7NoRrPX/uTYWf8uLkF5Z6uPnpkK1qfPtIQhrwr8kdVctYU0LHyn9/FjSUEaQUNpTZOAat84Mm1Fy/BfZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s86uoz+i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2gIlwC3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s86uoz+i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2gIlwC3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 245E1254018C;
	Mon, 13 Jan 2025 03:34:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 03:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757240;
	 x=1736843640; bh=GHRJtpRx/lqITinIvR5+zJ7UEPtBKThxQtPc3SuCxLE=; b=
	s86uoz+iHQNrqSwUpuMbZOHa81543TG+C+CH/xFcp2BlbCJfqrz/w6wtdbhKywAj
	h925Ul7d5Ho3XgqWLCvYTy+SCvf2v9IsmSCMt+peb37Q8RnP1Cx9bYvoZzE0gslz
	cn+60JP/4w5JxLIeoTnKI9tznt0PJMoT+vFSJgLI4GEUDBm/aejYnYNB8F9qYqWt
	f7gzdXmWRPFd92YsLE9F6Z8eNGt3o1qabrEmJk7ksUMoDcVTflNKu0iAINl29Lsx
	Uo63pv6PNrRHHfX6MWGK0gvbvN5rR6fXJv/Nt0ZoVS1nXU7frdk69762ngkl9eSQ
	vbRoBwmMLyLmiT/MnVAYPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757240; x=
	1736843640; bh=GHRJtpRx/lqITinIvR5+zJ7UEPtBKThxQtPc3SuCxLE=; b=Q
	2gIlwC3I+NqK7wTWLnx4w56yAdS6X86kWzO0K1iSuN095zHr/FfMY1abn78/A9FG
	JtZOf6J9QgFHvoegfSZkyGyONBBYWLLZCWz/YVnOxtVtZHC9T0yaub7ngSczwuN+
	mPC/fWjSAelZsHTKrRra3pffdJpG2pj+k2gz/GrdsCY7hfrOAPly54v8+2im1fOX
	/aU2QUlBKBoBUFC/1clZHd/FJ+x5E94h/hBNnw+H/beJFMygdk2VegAauwsdECJq
	YggPtlJ2jvNQDcNfLGWgg5vW5ok06DT6DW+cYDpbAeMCjG3IL5VsVDxYf5XJNQUL
	gnKOeU8r17Zn+mEUNtLUA==
X-ME-Sender: <xms:-M-EZweBDeoXqmEp7nnBYQxNNtRbDskMA5UsmqB_Ut_bbGpfCpi6CQ>
    <xme:-M-EZyNWFhbxQuFE7JJp_ZMX_GB6NBeknIK0nnTppmWXCjyNhN2RTMogctMBFIsgx
    XRGi2EHYMIJxXR2ig>
X-ME-Received: <xmr:-M-EZxh3ijIN61jmN2phjoKLkoYB7d-j0WItx5-sfDUpYDwNOMRnLOGLyQ7QfvUnGUIJJRzSC9GO64CqB0127n8f-IufU9JQg1jMIw9kIRYKbhp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorh
    hgpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-M-EZ1-x98pR65Rp_mLX2WqF4OIfOVFfYg5s_o8uz8aCalIZOqVGJw>
    <xmx:-M-EZ8ujqRZTVIbtzWePR5RzCZiFAwcf_grYRExdJtE3s4DawrZoiA>
    <xmx:-M-EZ8G7bZnvpTKWFiSx4JFeLqUrqiASTobyuHtqTRFfPWfOOBAXTg>
    <xmx:-M-EZ7Po8dDYGV7gyE43tldUgPYnzmOV4riMLcXX5DQ3KLwVIJAlFQ>
    <xmx:-M-EZ4J4T9almZJNpfmv6d7N2FM1TOxr4dvwNzCKS_9V-oOPer6xQ8-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f8b8c8d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:33:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:34 +0100
Subject: [PATCH 1/9] GIT-VERSION-GEN: simplify computing the dirty marker
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-b4-pks-meson-additions-v1-1-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The GIT-VERSION-GEN script computes the version that Git is being built
from. When building from a commit with an unclean worktree it knows to
append "-dirty" to that version to indicate that there were custom
changes applied and that it isn't the exact same as that commit.

The dirtiness check is done manually via git-diff-index(1), which is
somewhat puzzling though: we already use git-describe(1) to compute the
version, which also knows to compute dirtiness via the "--dirty" flag.
But digging back in history explains why: the "-dirty" suffix was added
in 31e0b2ca81 (GIT 1.5.4.3, 2008-02-23), and git-describe(1) didn't yet
have support for "--dirty" back then.

Refactor the script to use git-describe(1). Despite being simpler, it
also results in a small speedup:

    Benchmark 1: git describe --dirty --match "v[0-9]*"
      Time (mean ± σ):      12.5 ms ±   0.3 ms    [User: 6.3 ms, System: 8.8 ms]
      Range (min … max):    12.0 ms …  13.5 ms    200 runs

    Benchmark 2: git describe --match "v[0-9]*" HEAD && git update-index -q --refresh && git diff-index --name-only HEAD --
      Time (mean ± σ):      17.9 ms ±   1.1 ms    [User: 8.8 ms, System: 14.4 ms]
      Range (min … max):    17.0 ms …  30.6 ms    148 runs

    Summary
      git describe --dirty --match "v[0-9]*" ran
        1.43 ± 0.09 times faster than git describe --match "v[0-9]*" && git update-index -q --refresh && git diff-index --name-only HEAD --

While the speedup doesn't really matter on Unix-based systems, where
filesystem operations are typically fast, they do matter on Windows
where the commands take a couple hundred milliseconds. A quick and dirty
check on that system shows a speedup from ~800ms to ~400ms.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index f2af817feaeb384dee0ffd197f02a31cf2d31f87..754b8ca9eedaa2f7e3b61c83c1cc763538394fe6 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -39,13 +39,9 @@ then
 			test -d "${GIT_DIR:-.git}" ||
 			test -f "$SOURCE_DIR"/.git;
 		} &&
-		VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
+		VN=$(git -C "$SOURCE_DIR" describe --match --dirty "v[0-9]*" 2>/dev/null) &&
 		case "$VN" in
 		*$LF*) (exit 1) ;;
-		v[0-9]*)
-			git -C "$SOURCE_DIR" update-index -q --refresh
-			test -z "$(git -C "$SOURCE_DIR" diff-index --name-only HEAD --)" ||
-			VN="$VN-dirty" ;;
 		esac
 	then
 		VN=$(echo "$VN" | sed -e 's/-/./g');

-- 
2.48.0.257.gd3603152ad.dirty

