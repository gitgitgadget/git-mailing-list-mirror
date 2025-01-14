Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA78234D00
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855781; cv=none; b=bUS/7J/cGfR/qaj5XURl+oNH+4/qLQaUQEWkRX8HD2nvFIWpnLRbHA4qnHZSb7iskpKQCAwpZjSBmI9YpV3ILb+VGdeyQ3HtwpyELlAP6ZrxKC7vCWE/n1l/yhZZY7tcuP43dWgWhvCOMz8MC9W1SE4h284UPiu2OxFKIwHSIt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855781; c=relaxed/simple;
	bh=smEKV+80UqMktGJ8Vj7dFDn1BQpdk1zpHk/bwpEY9PU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsoBawDK0qB0Wsq7ux2zhjGT53fWGO9ZQFzLqQOLjjar812SLRYGlBSIUyec7OhCdp1bGG8RooBEHC/6/3GYyJeq6aVcRmmVABtnyPnP/R9qn5UJ1n9XlHsRVj33Z6vH1maZPprdIT2c2Xxk8PxUuzqEoMoBmgZlAVg0947sQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tFy8PIEI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=refk10+n; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tFy8PIEI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="refk10+n"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A6781140141;
	Tue, 14 Jan 2025 06:56:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 06:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855778;
	 x=1736942178; bh=Viu82sTd4p0DFlv0KxwzpmjV4EFP0erMsCJ/VOgSuD8=; b=
	tFy8PIEIWbLJSAyuXux7QQ1aM5P91etLuRL4u+8JflZfirnHg+fxJb1Adz7xHxz0
	OpV/kIcHlz7N7mI5ghI2yWxgBPLEZsvheTGxd3NHRV4UB1z72YzMXZqyAy+RybfF
	xiFTsQoePZbXTXOgHBPg3ayt04uh+zJSP0FPBnr8DXORKOCU0el91Ejp+Jj5kma2
	J7ZtwhqIl3neG8W0glXB6Krqsfpf4XZpEzMM7fWyXLNpUUJ8UCP3B68prMv8acYM
	aXbvMSPjgcMd18TzA1eQTOV7ImauKjWzLV2/LgkilUKqMI1fV+EqziEtr7OjxV8K
	K2NwB+dl8dABqIbu+qCaCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855778; x=
	1736942178; bh=Viu82sTd4p0DFlv0KxwzpmjV4EFP0erMsCJ/VOgSuD8=; b=r
	efk10+nIAFnb12QYTX753NZAKGPKHA1Z5f0T8HgRUBTdIrgZ6y0uiV+z+x/wqz+W
	WHdoaGM7mx7CLDfa4EUaIs2WxmSF3k4ehoZcvvqapsZkJau+NhkAUxmI/A2YWiyE
	kvszBPt006Lfg74j9kh2vvEtBeviVkyLSNUPXhoRY1iYEF4ebGVTdXfsQ6tEgUKi
	upM4jGDYAqG/OigXO1fxxpo49YEbwzx7ME2+lkiR4W8bQXuSWSXH/lYi8Q9VknBU
	5Iyaa17Bc78X/Bm6ZIO0yS7NROh+llv/iBEILtDlZ12+SuJ3Vxix2dZQzSZrjUxX
	EkqJfGc/o3ei5vPM84r8w==
X-ME-Sender: <xms:4lCGZ2EFbmJTeQwTGdoxILB1xoWflreVWy6gc_D_Y23RvNf-cGae4A>
    <xme:4lCGZ3WMDx2dCI1ha3fRZwRmusQ8KVSy166xhM3Sdzk9P3cdpispUYyawSpICqjOH
    RxtXpT_bWzEPLORdQ>
X-ME-Received: <xmr:4lCGZwJEDEEutQQj03_K3_qyv3Pv8RFLfm4PrVbIuSCELqzPGvOkC0X6lUd7WDjAnzoQs43HDLCBMLXgKNnaI98fzs_bBoFw8isZBNlvHSn4BA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehm
    ihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4lCGZwEtDmrdn8tH-qbRVGJD2vJuTPUFjJ3DSVJZzU_4m6CPQM6p5g>
    <xmx:4lCGZ8XTp3tcrPRuHm7j09ogcur51DyZYG-2QiUivVFnLn7mGL85NA>
    <xmx:4lCGZzPFOv89fATZByFLJn3LPSSGYPxoH8aeQFulK_v-nlDwldfwIg>
    <xmx:4lCGZz1a0_AdU4BTiaaCGBmgiACTQYcXAEpUq9WW0rAc7t1FvYfk8A>
    <xmx:4lCGZ2feFtt97q7OhGWMYFlAUN6-QlDBbzEkv40-nu-ZK5Y4YWDvRjEv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d1a9bbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:11 +0100
Subject: [PATCH v2 01/11] GIT-VERSION-GEN: simplify computing the dirty
 marker
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-b4-pks-meson-additions-v2-1-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
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
index f2af817feaeb384dee0ffd197f02a31cf2d31f87..b8b683b9337e5771e14a2cfb84022a11489bb432 100755
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
2.48.0.257.gd3603152ad.dirty

