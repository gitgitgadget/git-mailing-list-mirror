Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF41BEF87
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764333; cv=none; b=PgUSj9v3JW7WMU6JXjOcvMNTKZugTOQBXlYxEFeflftNwyTMahAFK91Zw9rKvh1Him3Bv/yqltMDq37Zbe/O+hdKhRH8978ErCYgLAfokYcFGBX1Xklkf15aeA8rqnnta8Qlhw3sNbENtRpbTQx8RxplKdcWTGyaB2PfX7qYPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764333; c=relaxed/simple;
	bh=eZKcg53D70bnMriDJlkU0tlAN+O+udIAryFrA5x+TXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X21WB/3PIC8OVr7DXzuRWrxQtj0Ni7grRFgmrbw4knq2xMEDFDxHtIpheupE9Bm87Edu2KK+VaWhxN3Witt41lwAFLJ4P446wUaLqlwoTxsho97Wv8vtNPqQk8Z+igKfkArXxoh8BpIDggYpYXvnuqcxaM9NK18hVil81LAku0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eFHuE9oe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRefB/+F; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eFHuE9oe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRefB/+F"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4D0B254011B;
	Fri,  4 Apr 2025 06:58:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Apr 2025 06:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1743764329; x=1743850729; bh=jtXV2Uwzaf
	F7M3SC9PwXhSiXwkSk+McrsIqZLniIp2Y=; b=eFHuE9oeNkPW+rZDXNQBDuAuwt
	yComPTMXoVc6cvyeFwQ9+1kp9ezC3hoyUVbzimNB1PGI05pN5/Z5rUU+0KXHC2yM
	JVFRZ8Ajzz/BSSSeXVWrFRBtQzBree+rB6hPIvNGQuEXTMpDyohuqwocWq61rBCB
	o/oVHKPwneOlkmk7+UES9s1ifZavVorgm4oAVWT0a1WaMTYnh/H1twS2I3ceqcYg
	5wUmzBiOo396bvm0O8BmD963jOuVld1VnazQ3lGlYnamS1tnWAZ+o7Op0BJga+0W
	lwzkTrlZUZXIPazsLkTBen5Yq6yzgpu0d8iv9kIeIk1kNgbSymw/UkspzvMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1743764329; x=1743850729; bh=jtXV2UwzafF7M3SC9PwXhSiXwkSk
	+McrsIqZLniIp2Y=; b=FRefB/+FWPs2d4jvZ/sv+OttivZjpOElZNXLsu6GDpwU
	AWA8oU5xLOwR0LpNYnapPnSyEAvibhRaSjwpU0TvrO27LWm9IwcZtJBCZwWaOAtE
	37kuaad0JfLAUFlySoub2mJddOLD9UhfyuTCutWX1aAA9ZEpHtZNvPbKYqStszB4
	I12o3bn9OmwMN81Ku6xf/MtDi8cQr3I/yLhQUNbZ8BWIaycOJUGW6MA4Tz9moxOr
	Qnke2eXdzWYkDZgnBwZ+4w0B56FJQmBYabRVit+dAqOuMstiKoWqnK0FMAVt1/1i
	6WaNDOjsOMwXcZsCvKz2RZo4VmHO1Y0F8j46XM8ZYw==
X-ME-Sender: <xms:abvvZ5_IAunSR-MlH_1_onJxJ8Ds4mCMePtbgce3a4144Fz_V1t6Ag>
    <xme:abvvZ9th-NLrS5YkDqRDWrXVcoDADGu2m7JPQEiq6yc3UYW0dBde-0XWeX4nRRfOw
    6PB8N_z-V09DHH47w>
X-ME-Received: <xmr:abvvZ3DE8BLLc2gC1SeQH5fPant_cpJOtLT2sk3UfZdJ5oT4S5GL7JrUlBG_2jNWXvVNn94RbX2bUVoPQVtDj4pdGTRgmpjLKI0J5KMhNQajI6Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeelfefggfduhfehfedtfeeikeeuvddujeffveel
    ffffudehieejudetgfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:abvvZ9evI91Avm-n8GNk3b2kdreLqPIIirfRPs7EiVo1PeWf57bxrQ>
    <xmx:abvvZ-PMpADYtV6kCFrbgt1bFOAqO3SSogORe9TMthYacVpMbO7KFQ>
    <xmx:abvvZ_nKaZIefp2v18svdQTEogwp8230WRZT0cOZPM5YnTlqstvUBw>
    <xmx:abvvZ4uzkOHSxPnJ9BWPlju2TpP5C9Vh2nBSoWA-Oo-tTKnvskcLMA>
    <xmx:abvvZ7jofGUgGBAoyIVRXlgqcENkIVkvGvtaTsSzhN6mNM7lgSalppNN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 06:58:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d933512a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 10:58:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Apr 2025 12:58:38 +0200
Subject: [PATCH] refs/packed: fix BUG when seeking refs with UTF-8
 characters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250404-b4-pks-packed-backend-seek-with-utf8-v1-1-6ceb694e3bd7@pks.im>
X-B4-Tracking: v=1; b=H4sIAF2772cC/x2NQQqDMBAAvyJ77kIMqQ39SulBs5u6BNKQ1VYQ/
 27a0zCXmR2Uq7DCvduh8kdU3rlJf+kgzGN+MQo1B2vs1TjjcHJYkmIZQ2LC6YdMqMwJv7LMuC7
 R4zD40HtLFOINWqpUjrL9N4/ncZymfg/1dgAAAA==
X-Change-ID: 20250404-b4-pks-packed-backend-seek-with-utf8-668c182ddcf7
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

It was reported that using git-pull(1) in a repository whose remote
contains branches with emojis leads to the following bug:

    $ git pull
    remote: Enumerating objects: 161255, done.
    remote: Counting objects: 100% (55884/55884), done.
    remote: Compressing objects: 100% (5518/5518), done.
    remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
    pack-reused 105371 (from 4)
    Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, done.
    Resolving deltas: 100% (118048/118048), completed with 13416 local objects.
    From github.com:github/github
       97ab7ae3f3745..8fb2f9fa180ed  master -> origin/master
    [...snip many screenfuls of updates to origin remotes...]
    BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
    preceding its prefix
    error: fetch died of signal 6

This issue bisects to 22600c04529 (refs/iterator: implement seeking for
packed-ref iterators, 2025-03-12) where we have implemented seeking for
the packed-ref iterator. As part of that change we introduced a check
that verifies that the iterator only returns refnames bigger than the
prefix. In theory, this check should always hold: when a prefix is set
we know that we would've seeked that prefix first, so we should never
see a reference sorting before that prefix.

But in practice the check itself is misbehaving when handling unicode
characters. The particular issue triggered with a branch that got the
"shaved ice" unicode character in its name, which is composed of the
bytes "0xEE 0x90 0xBF". The bug triggers when we compare the refname
"refs/heads/<shaved-ice>" to something like "refs/heads/z", and it
specifically hits when comparing the first byte, "0xEE".

The root cause is that the most-significant bit of 0xEE is set. The
`refname` and `prefix` pointers that we use to compare bytes with one
another are both pointers to signed characters. As such, when we
dereference the 0xEE byte the result is a _negative_ value, and this
value will of course compare smaller than "z".

We can see that this issue is avoided in `cmp_packed_refname()`, where
we explicitly cast each byte to its unsigned form. Fix the bug by doing
the same in `packed_ref_iterator_advance()`.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch addresses the issue reported by Elijah at [1]. Thanks!

Patrick

[1]: <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
---
 refs/packed-backend.c  |  4 ++--
 t/t1408-packed-refs.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b4289a7d9ce..7e31904bd41 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -980,9 +980,9 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		while (prefix && *prefix) {
-			if (*refname < *prefix)
+			if ((unsigned char)*refname < (unsigned char)*prefix)
 				BUG("packed-refs backend yielded reference preceding its prefix");
-			else if (*refname > *prefix)
+			else if ((unsigned char)*refname > (unsigned char)*prefix)
 				return ITER_DONE;
 			prefix++;
 			refname++;
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 41ba1f1d7fc..833477f0fa3 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -42,4 +42,19 @@ test_expect_success 'no error from stale entry in packed-refs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'list packed refs with unicode characters' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit --no-tag A &&
+		git update-ref refs/heads/ HEAD &&
+		git update-ref refs/heads/z HEAD &&
+		git pack-refs --all &&
+		printf "%s commit\trefs/heads/z\n" $(git rev-parse HEAD) >expect &&
+		git for-each-ref refs/heads/z >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

---
base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
change-id: 20250404-b4-pks-packed-backend-seek-with-utf8-668c182ddcf7

