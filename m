Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD2211A04
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547554; cv=none; b=QckLwLV/HbM+E5CmZ/Yb0UJsj7m0N8daskmCzFKNM5HLyKksTWp9hhNNLPvdMI7Ey1FNgRk9caH9JYjwDoy7HgGnDNVf8KCR0QNfSBghKExgjfw46ZzFsb+HAwlBpq/PtTdVWlR0/SL7zsxSCFmHzy5aFrjK5rxkf8Pep7TT5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547554; c=relaxed/simple;
	bh=SNz+W5KyHThpkeUld53cKAIhGTl5SnveEvsSuV6M1kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A5ccpmBY8kWo/eePtnfPunlWVNUeIX/YENezf67YKBpOH8eAlVjP8rLuKbugY+GljxJm0x0PWtUQ7UN/hJV9GY8nF6v+Na6eSr1B+uWw+79GjrlNrpfmnhDWRssl32w1vlS8hfhdu635BV63jPEyl5OF+862qxhUA9KVVAMPO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rVR8oUNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpkRI45B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rVR8oUNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpkRI45B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id BA09A138084A;
	Wed, 22 Jan 2025 07:05:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 22 Jan 2025 07:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737547551;
	 x=1737633951; bh=vy0jYuJFzTzYbPR4fPcvIHXOBMaQuaJxwwbnOhAgqaI=; b=
	rVR8oUNZTzJpjkseSNZ3Jd6WPB2LLq0DZadKlTddcb8K4eA7GdlKf+fDcJAdjKdZ
	3mXSzJEYb9nmNVQt193Ck5KHVzvBmM/bznvuPqi6xgXGgcBq4Q8er7yPv41LjBZp
	GX8cU+XUY76uYn6g0+Qjzn9Et9COwGjeyxHcaiwPzkS53vKvmv02GrwUc2vNifAm
	w23n/iaAhwF3+3qOkiatAzaHt4V/eNBoSVuLPa5eiq05VMGWNzlU+RO250XsvsLj
	5A/2wa2qbsKJsw2XKj4yZ40QU7yT75edyn9DK4VRzsvHPotTmzGQAJHzjX33PZWm
	UPcOTfYejAo3ZEzJmvemTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737547551; x=
	1737633951; bh=vy0jYuJFzTzYbPR4fPcvIHXOBMaQuaJxwwbnOhAgqaI=; b=k
	pkRI45BgVK2BowC2uzOsyWY3LP50GDq7DndAWD59e+RjaDEAHN4Aso4WYYfRE7J5
	Rl//dKfqKoIuDm1hJieSCscqURaUNiHoFnVE9ZPw6rOftoyleyRXLXdoqQW/WE6c
	4qWI91Ef+8AXuj7jE7d32Iy8JK5HD5vxboikgGd+8eI/ZrbNrVyaQVZsnIUYMOVa
	ATAiTr8kMXDruCUFWENou0oEf9QtRkiBrP2kgngPnz0N+6kcLuS0HD+6CgmpiVRu
	XaclaYHIwhmFT42qxEKfQsOIHd3vmhkAFJ4pWYPkZ8q6Vg5lLAnal2EUOTH1plus
	SCzEf/Xp2L8I74KVIm9Iw==
X-ME-Sender: <xms:H9-QZ3YFWmsR47q3h0LQ3QW0KXC5RRINZPsQ4AZBiR_RsJnLFi4xGw>
    <xme:H9-QZ2Zz-jrak7ce09Io-cahnzwqV8YfaosN9Apoe-QMW9d9A5VFp9WnHE307dgup
    1HOM58qQF3bo9j4Xg>
X-ME-Received: <xmr:H9-QZ58eue2ut_JhEowKIHgxMe28UOcvGekht6xAam5wfCpvvdTyvg9gUdOTKrF17xCgOhbACSoQMT_QzSpJX7oJA32JZcHBMEuAopqNAF7RnjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfh
    horhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhht
    ohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H9-QZ9pPzOooHkghjs3mKzqx691fmr5YkqoHb4TWDgmY_qW2etHlqg>
    <xmx:H9-QZyqg921KFC0ayCYw5ME-uAYikc96c2oES1_1zUmIR_X2SaVURg>
    <xmx:H9-QZzSK899KHeaKhNVRz1MqTxFDFWyXgs9YTcAPO62vYYpxRVdW8w>
    <xmx:H9-QZ6ohaht-hGoKv0FpzcpIAR2-7xJXgFAGxdLgEOVWfUnC-DImaw>
    <xmx:H9-QZze0y1rq_NGh0uh8fbVbhUoguZYqeidlXFkv6sBR2SJMV7CdYVsw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d3f31b2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Jan 2025 13:05:44 +0100
Subject: [PATCH v3 01/11] GIT-VERSION-GEN: simplify computing the dirty
 marker
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-b4-pks-meson-additions-v3-1-5a51eb5d3dcd@pks.im>
References: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
In-Reply-To: <20250122-b4-pks-meson-additions-v3-0-5a51eb5d3dcd@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>, Toon Claes <toon@iotcl.com>
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
index f2af817fea..b8b683b933 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -39,13 +39,9 @@ then
 			test -d "${GIT_DIR:-.git}" ||
 			test -f "$SOURCE_DIR"/.git;
 		} &&
-		VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
+		VN=$(git -C "$SOURCE_DIR" describe --dirty --match="v[0-9]*" 2>/dev/null) &&
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
2.48.1.321.gbf1f004a4a.dirty

