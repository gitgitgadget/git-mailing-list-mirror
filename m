Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264893EEADF
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105938; cv=none; b=ujm9DjE6elIZ9q6uVCAVKc9xaIXdtxO9Sm9XWlGWoOKSMKMuZHy8+acx2nOH9bRrUhy9XWPbT5D54gVkpWeKkC/IUJpp+nYRiYMTxCDknIyjUN1vlfkPICqIuUQ3ZOy8fmFvyCjQuqH+JhbqY78Iw7fdlelFkdezYJxWW7ipm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105938; c=relaxed/simple;
	bh=FRNUAg817ta/MIwyHuSCvmY6VKmLJKwygE4CHuEPWxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0lxdEQ3/eHF7E2LtBwsSTeZYT0kvUpI81IOM6Ayp8pIFQFjmgm1hUoJXR2/T7hJlaYbjxY2ASUKC+OchbN1V9lvhe4hCtFLkjyG+wheJVuk9AOa1tEr4tbvgw1mT8fyQbNKMt15siC/OYkxkjm8D6Syqg0J0wnnpQ/FCF9/mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E32NVM7A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQCRM/kY; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E32NVM7A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQCRM/kY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4185D14000F9;
	Fri, 11 Sep 2026 01:52:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 11 Sep 2026 01:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789105935;
	 x=1789192335; bh=N/mqGtQ76wKz4aykjUhR2rQwOHFU86kRCREknIxaayQ=; b=
	E32NVM7AaNdKfDrgIARgQ8r8c5PDOulJ271yil/1MQdKhKpvSNU6ZUQOU1O+IGaK
	dfKC0Tg/x85ZsmUaoEdLcEOtXlGlH0DTEPnW+ZXixBgdDQwLXErg6gJupVfTFtZE
	5oSFMg7s1AbfJ6/cB8MkyZ8BKp8YUC0MWUQj78gYmOQxd+DZqbAN2y88UHogkPBu
	Q+DEZR16/LXc27HYwtHqu9G89wO1n0ZClDhYv8f7mtToVM1MTdyGlJWuIijLBXIg
	VxHIkiit3t+Qlawlc5JQfNyL0CueBFVl0t9ImDN6cbXanWR9aBLxdqwJ7bQZa0ET
	nYq5hz4hvTZf8OyOWBg32g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789105935; x=
	1789192335; bh=N/mqGtQ76wKz4aykjUhR2rQwOHFU86kRCREknIxaayQ=; b=T
	QCRM/kY07tfvL3QfCrfxLfQPCB4MccAVt6koX9RMUXPuwBP1oXiQS6pvea/GbA3G
	p+klOUNBY0v42ZyDBP8jqc1owp6sFCz9uC4I3hVq0CcB7r16js0ei6UHU3CnL0+A
	MSqY/GnXu4OqfzeLnp4/0Lw5HPtmchwxEoIMEw97b/tZmNRLfPtSjhR4qJlP7ETG
	mLUqh/VztxoLj3omszqRgeCj1fvuxwfXczNXThv6rrPJH+cBqqYzK8CESIxxj9Xx
	OsbDKAp2IfTVH7dnMibk8EfMV9N+HykU2LZ3qZRL5Bo5ikYEoOfYFyGilTtzwxfO
	Jtp3QNx4DXLt4siW7hMIg==
X-ME-Sender: <xms:D5ejal0Xf2YDwCz4AyPRzUc54d9YdrsMsNFCgOhHkXWTFzwdJiLbiQ>
    <xme:D5ejajh4qLQWOClEFosJn3ZjJoQS-SDD5HUUX2L8vChuG--SXzdGVuuJxZsDd8qg4
    1AsEfyWVrVdkrdnz4vHS9IclHCexbAAALXJaohH7HvJZkqW_i6B027C>
X-ME-Received: <xmr:D5ejajSI29_VDvNLEAQZksdrIMIiCDjZFB_t4b9oZOMjy3ipxS8MPUGlBe13gyQt85nVIg>
X-ME-Proxy-Cause: dmFkZTFGFEz1AV46mB0H5IUnOtgcTKabM/fOWdn1U32UtnAQCX7C9Kwl1UF/lK3aecPx95
    pwrzbSMo0jFTe4y6M9wP3j4PvyZ/ZbEnXlwcVhCIODBJ2zHPDEgNd6iVKvcXKLFsvGHjJY
    vWs+JOO1zUtcRsF/A4WjHSwr6DdB/6IXCdE8e3Jyy4OKiwY0OVWLq9Z8TBsacm3WsPCloK
    ydyMq7csyq3iJZTpyMsmr5YvZ/wQUfMMCCzLj3JXj48UbmBWjnybLxvLJ7a8U/gD4J8oSE
    nUcFm76zJB8wqT3mqBkmo3OeFknnRDh7XPU0VX9uvjH+wWvsGiO52yVJkRj13Bl6YbnHX5
    UqSHy2eb2TtqDpOHqJHYd8RUS4ueoM1oHxxlaY3M6/DBwv2UpB1A7hwSEolKE/7x4BMEXd
    joOW85d/xraQ4/PXKiLhVqH1u26CsP8znVBumwxG21g/6UkyX6k49FPGZDENi2Q6gBFFpJ
    0TRrM05vJaI/abI3bCVY6Yq8CJO9YXl4nZrM2c/zfyemLxQH72iviSOYXMo4D2cQqQUzoR
    my4lT7xZnCEDF2jBxJH01pfSEihD2BBbqWI8e0um9WbnO89iWn29R80wkcWnt4QjdWPYII
    57E2slaFq90gCyiazjqcX8SrKAvHoCQxguHDXogXLX3NDchy/Dne0LiAZGaw
X-ME-Proxy: <xmx:D5ejasg5kh3zbQBX8ezzgDtk1cQVd6sHHWx5nhOEDVT5dSjSx-utug>
    <xmx:D5ejar7F7RWYaJw4NsyjA8nT4dLUa3vHFUThU-rX2pq76DRJm6MhSA>
    <xmx:D5ejahBnnw8KmWi6P_iGsRSzrJSWxwMAtmXavPVzUcCiD9RQM-L0IQ>
    <xmx:D5ejaqZLCi6l5_LWW1fsTQHJD1ZVP975HsGf0T2A_zgTaXMscOl_cg>
    <xmx:D5ejar7FhHLAh-C3m1ARlITohNhPenDYDgj-wMy4lU30aeR3B6N7--96>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:52:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41df1300 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:52:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Sep 2026 07:51:53 +0200
Subject: [PATCH v3 10/13] builtin/multi-pack-index: refuse unknown sources
 with "--object-dir="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-pks-odb-registering-in-memory-sources-v3-10-447e6882ed14@pks.im>
References: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
In-Reply-To: <20260911-pks-odb-registering-in-memory-sources-v3-0-447e6882ed14@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Users can tell git-multi-pack-index(1) to access multi-pack indices that
are stored in a different object directory via the "--object-dir="
option. This allows them to for example write or verify a multi-pack
index other than the one located in the main object directory in case a
repository has alternates with multiple multi-pack indices.

But while the documentation explicitly points out that the specified
object directory must be an alternate of the current repository, we
never verify that property. Instead, starting with 017db7bb14 (midx:
load multi-pack indices via their source, 2025-08-11), we now construct
an ad-hoc source and link it to the main object directory.

Besides contradicting the documentation, it's dubious that this really
ought to work in the first place: creating a multi-pack index (and
potentially a bitmap) for a completely foreign object directory is of
questionable value, as bitmap commit selection operates on the invoking
repository's refs. Furthermore, this is the only remaining caller
outside of our test helpers that constructs an ad-hoc source and links
it to the database, and we want to get rid of this mechanism as part of
this series.

Stop constructing the ad-hoc source and instead refuse the operation.
While this results in a change in behaviour, this restriction has been
documented as such ever since f57a739691 (midx: avoid opening multiple
MIDXs when writing, 2021-09-01).

Note that this change requires us to adapt one test chain in t5319, as
it creates an object directory that is not connected to any repository
and then uses it via "--object-dir=". The setup itself already documents
this and does the necessary gymnastics to link the object directory to a
temporary repository, but subsequent tests don't. Adapt those tests to
retain and reuse the temporary repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/multi-pack-index.c  | 3 ++-
 t/t5319-multi-pack-index.sh | 9 ++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 6e73c85cde..753bd53a70 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -90,7 +90,8 @@ static struct odb_source_files *handle_object_dir_option(struct repository *repo
 {
 	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
 	if (!source)
-		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
+		die(_("object directory is not an alternate of the current repository: '%s'"),
+		    opts.object_dir);
 	return odb_source_files_downcast(source);
 }
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 68143cb5b7..00e90f163f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -698,10 +698,9 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	corrupt_data $idx64 $(test_oid idxoff) "\02" &&
 	# objects64 is not a real repository, but can serve as an alternate
 	# anyway so we can write a MIDX into it
-	git init repo &&
-	test_when_finished "rm -fr repo" &&
+	git init repo64 &&
 	(
-		cd repo &&
+		cd repo64 &&
 		( cd ../objects64 && pwd ) >.git/objects/info/alternates &&
 		midx64=$(git multi-pack-index --object-dir=../objects64 write)
 	) &&
@@ -709,7 +708,7 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 '
 
 test_expect_success 'verify multi-pack-index with 64-bit offsets' '
-	git multi-pack-index verify --object-dir=objects64
+	git -C repo64 multi-pack-index verify --object-dir=../objects64
 '
 
 NUM_OBJECTS=63
@@ -721,7 +720,7 @@ MIDX_BYTE_LARGE_OFFSET=$(($MIDX_OFFSET_LARGE_OFFSETS + 3))
 
 test_expect_success 'verify incorrect 64-bit offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_LARGE_OFFSET "\07" objects64 \
-		"incorrect object offset"
+		"incorrect object offset" "git -C repo64 multi-pack-index verify --object-dir=../objects64"
 '
 
 test_expect_success 'setup expire tests' '

-- 
2.55.0.1074.ge7621b4bad.dirty

