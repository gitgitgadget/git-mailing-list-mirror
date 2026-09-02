Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8A49F114
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356127; cv=none; b=b6YLbVllIHcjw4E+2zNOUBck4mKs/WQfKBzn4/lQmVOWU3gdvT/jaTFt98JV6cfyahORQoHnCEqtwpDj0RgRG52G+eURu1cOTNJxVXK6hrH73Gf6vlQUD3mk5DGypNKxxWeq4R3wXbHBQq+bT31wgAW100/vkoH18JnoHhSA+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356127; c=relaxed/simple;
	bh=d6fcYxTi9RXvA9S02jD1/CoHcUPQOqpN84rOTYutHJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwXkUjWr48/g6zz2WhP/di/exBMx5A50xtXb8TkfD9DR3vPk8TmS/e7V16t0VXOcqgwXH17MAaiOECAEL0uMQqzXzXBQbxohox2krKP/KXdTzDKHj9xIEFlKm1m84mkSHHgMs+fiJIhpnZm+IWfgEYPr6+Y7Jm6tLyi0taOSemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vMOWYuew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iRKoib9K; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vMOWYuew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iRKoib9K"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED68D7A012A;
	Wed,  2 Sep 2026 09:35:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 09:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356124;
	 x=1788442524; bh=exTYCUYtqPMVGdlExEZttGSBJsJUSysxSrl/1RKehuk=; b=
	vMOWYuewn5+ea/I1Lo+YqCVYYF6zanA6GI82NWa5MENggEPYjn45bbooIxypnU/D
	3OwgfnIywVOa1tvA07zobquKjtUobVmm+hNu8mT78E6SDOBSRZDBdAKGWsJI+rZ+
	CV2T/kY6JdygKD43jGKl7oOjlVdeQuMeWZjI8byfOhTMrEWkcpPhe7U/E8a9WNu1
	jfGDmCuprDaRcO9UuR7i/tuPACpOP5o7abjQOf5HxvEpACVrDKLlsz13BQcsTYEn
	1+Ww0bJWLJZ/OIaiagJ/0I+oY5Gp+MeqqrAeAmadLgqw4o4ipLK3VFtLY0j3B5gA
	3qQ+5wN2g0g23U5F7zui2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356124; x=
	1788442524; bh=exTYCUYtqPMVGdlExEZttGSBJsJUSysxSrl/1RKehuk=; b=i
	RKoib9K/DeufO59sfQZ9kNYxLrGnqIy7UTFnft17LnEOkjvcxH/AXy8vYfxtr/vT
	b/S1hpkE1wmwQHfOko/0VtCEqjhRABH4FTZMvfRIsemxr+yoxIJ2pTUVmm/n1/8X
	WxrRsIAEn8mpU0zPWNg2bFxVM36yJNka5WujV4KepPHt3W0tm87CqXxGMxCShJos
	EOBXQV071zL6i/Aak8Gi9zdg2wFsuGt6+iI0lob9i1jWVKMQjhm725rNLIOQNe2q
	+d0ds1IXzrg7hIm/mpfZl2+CFkmtTdTWqp2KcgWjzL731ZDrs/2QYYqrf+NKv0MA
	5zaxAzimMUH+mg6kIfDGA==
X-ME-Sender: <xms:HCaYas7i12y6SttZ94RVSTWL_up2Vh5IJAken8TPFhR4GjuoDW8A0A>
    <xme:HCaYaj5FLOBpgCDhcY70OuaJJwCF05KfegiZbcjgboQ7lVNJ1HrwvJ3xccfIaxMGU
    XcdBilsCBbVq21zl0ATmdCJ4QT9YZ_D19a5oCyXpk-urSY7nj6fRTM>
X-ME-Received: <xmr:HCaYapElgAb-F91kIqmRtVJWeELvExvspIpqO9bGF58Diu9P28M6RUFu3w0UZvmZi_1ZVi0>
X-ME-Proxy-Cause: dmFkZTEYhr9e4Ywlb1TBHLwsOW3Qx1tjtKD+uhP71WKh33QJrNZx9AVMt7nD22Jis4lPrv
    MTCD/EPB8RsDNVjlqEtIpjdnI06qWWOaQew+wKEg9KR8NEV3XDj5+C+lq0GNXMUCyo4igS
    5U9v+KFkw0Evpwnc6cWUohg4b6qCrXyvPX0B7hrQw7zRUjz5YwzGQrgU3UxDXxxyR53YC+
    YQIYAIRjLTSjVluUg4RI0n2rU5GvrWBHjQHZRsaSRDQMiPpgohYZUdgz5LN2ECLLwBR9zC
    HYaTCafKUfTxhWvjtOGLyd4VXGi9YWUXrplxaROw1Cvb4DVWcs3zD8ZSMBcPlpw1IaHWAS
    9wd7zcjzpSI1WKRl0rWAeJ9mwNCsL7qVZbOMkmrGxTwC/K4TqLzR9tpgkAPseI1dL+TTo/
    J6qFZEhEusnDaDJCR3SZgh7duOsfVATp/VA0sgM61yNhyM7xV0TjOwNcvyw6gF5/L3L8+1
    LnITocSAeiEaq34w+ZnL7vsqgqHq5/PpvC0M4xGDIfXwubBpj3pEzgqiVUJPEC/GeF3Z++
    PdBuKKjtfyUdvsuekbHrYBTQ1J64yy2jJG4UjdH82x708QFIqeQ34bHszZPVeZpW2vsFYE
    Z87STnRkMWtRJt5mQWAPznrcE+Hbmr7kF3UhC8dpiVegTKdMDZorhTejuCGg
X-ME-Proxy: <xmx:HCaYasSN1m3IqHouTBcRhemRw6_SI5cQ1AwbVd4aLZS6bfFJGbbxuQ>
    <xmx:HCaYaivyLhrgWa3vRvBRTotuZSC2J1Z9i3NZhjLj3L0z3Y7ySUexYQ>
    <xmx:HCaYarypy3q9N_DJ7iwTZ-TBSBlTr-jp2SwfMeD4r-oEBQgXQpNa4g>
    <xmx:HCaYas7fGqDE7Br0PvH7odINSBu1c1A-oKaaqhVVwYc7gBA-R7e_Lw>
    <xmx:HCaYagRwjOHt_EGhKKqdG8ihJ9OS9DYWHAZxI-G-rciBbQ-DTFZdSkll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a33bfbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:58 +0200
Subject: [PATCH v2 10/13] builtin/multi-pack-index: refuse unknown sources
 with "--object-dir="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-10-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.979.g7e5102b832.dirty

