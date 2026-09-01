Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9547DD4B
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260998; cv=none; b=FTRtLOrL9tY3PnfDaDEfTKOsaLc193gs7p5fNLVjJyrKlnrCG0vPxgoieA8fxNLPOgsRlm81T1vJnMEfI86WmHeS1QQ3FyOb73n5AZOcT1tMbq1xcYkobqbKS9Qwfl+jacKB/edMv0DPC9dMKwxX6ew0qsw/X8FfFpRoH/uvsH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260998; c=relaxed/simple;
	bh=d6fcYxTi9RXvA9S02jD1/CoHcUPQOqpN84rOTYutHJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1dULtH162rBQXKkf/z+F0bl2YzwI7nfzXSIQxuRZrrwe0TKh4RcJQ9X+xkQMbTwvGuj/rsfcV6/uQhMgAiQvmuV/tT1zbr1EdgwdcGN7ItuPRwOoW37PcR13C9S2rwTPO1pQQzIldOHCt8FrK77FeRYPQ5n6wHhRiXXABQNdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a3j9ligb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E62qEdoy; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a3j9ligb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E62qEdoy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E669EC0214
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Sep 2026 07:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260996;
	 x=1788347396; bh=exTYCUYtqPMVGdlExEZttGSBJsJUSysxSrl/1RKehuk=; b=
	a3j9ligbfvW/pg5+NtNiOy5VyWC7Tf6sVAeh4/SdTHeoWhwKvX3we45CBq93lk9y
	HcBSZYunFmNwp3BefP3EHJ0vCPttpJ+UMXaan0MIa4sBjf1dE6C6atOzOzM8nx71
	9wZUOjJtL5MfK8BG/sC8f6k3vQMvoO7oz8JLKV1GLvkVI7JpgyPsRy2BF2hXEF74
	Vui0VzlBZPFV3mMQkZT5uyuFaXOWSbcshzZj2EeRE0XSUKUMtewVBTc1HJYKwAg3
	FHP1JwZft2YE2tbwRGuIso4U9fZXayCf26G3ouQ7cZkjSlqgsXAmsmwbPR4tArlZ
	4KsZlsDXtpYbnVAiR+4fkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260996; x=
	1788347396; bh=exTYCUYtqPMVGdlExEZttGSBJsJUSysxSrl/1RKehuk=; b=E
	62qEdoyonoGcxiNpkV+AdAdu80z78E7rnoQgtDyWgRw77gsKxjRuQ7AMN8TkbVFg
	lG9cNTbXTzrEC7dYMul1czpglz9bEpoWVA1ow+Nd5Nb+s2Ani6Nhr8HCNRhOXb1B
	JO5a8z8iDJFEPgm0SZHerljolOE5qS+FSOBF/P3zVOiXciZs3iYy5OIZfDl/jhOh
	t/uE/Z/jyhDMhRW3BOXuAt/Wh8ocSUgrpkZEN7cbTHIpNi7ME2NNENTEFLP4PLgJ
	bOO/TjWJAlZm0LQPY94u8Jr+pGvDDlVR4zv6ecbNaz7xG+8VlOWBYXF4Eq/ES7kt
	QFPNC/BV7hr752D24Kh9Q==
X-ME-Sender: <xms:hLKWamULlBuAe7XN9BLKtQkO3jhrq5pdPscFJHtrO0FUxX_qKED5vw>
    <xme:hLKWapisAX6L4T2vKoTZ0LyqsdOsbZFablOHhNfjV8v23Q5pb6kesdqm_Jih_cHVi
    iUiPeJWHPi7ILTMbWMfygSLrmGavegcNctQVy1HnUJ0qllSLcd_CJ4>
X-ME-Received: <xmr:hLKWagB4CZAqt7YQANgGsLTcRQBqz5yfYXpzAK_yt7r7aZ3Vzrl8PQ>
X-ME-Proxy-Cause: dmFkZTGS1rkHHGUc6n7MAk+c7jaxkVPtxVMmjShxsUS+KwlyF223YHq9STZxLj6Dz5G9/R
    joAgP+vn48r5PaGHPBRYXGHhZWfmVUjtT580tThaL+9TFWNoTwpwEzXyMxSMzBBdqMd1i7
    W0opEiBA1nURHqNjel1HbNtJlSXd+Aeuh2LudidkHeyNCnKYfCM7rM7wEYTjmATCAFQAyM
    k0lBEfvcfsMNPTZ7d20mOEzVaWDGLU9pyQRgIx+8ZVD1UhjhEl4O07GTb/3ToDsaD5lJ9r
    0N7y4lgAtV0QZfDMG2t+Y73m0U6K2/SBPDeLgUFfNaEMQc1ZhoiDqMUjmZZyCUKhQAboXZ
    1Ts8q+iS5UBLZ24qu+LxatvAoRXU5AiI0PPNGW8rgj4eXlUDb318MwNM1GRRyex2xrjrRm
    KOMrKZqrqyjjK//keNBg0fi9qAcLdtgkjgN/AEK/PBgKzypdQIjfHyUlYRdAaBHVc2A49O
    WE2s4P2NyYFGb63CpZScbE5uPJpTp2+GmzEPAMfZsmw6fzIInaLbAXeQjnhjfzQPZebkjn
    kgmW5+LHzPX9ZvAyJLXc8DgXPsjPF1QERMwdYVL111go3ncryHpFH9Lp+eSGWFtPmtFD7Q
    s63XAyHTfU/VSXBeFMi0PyEicPbIGTcK+SuBpRyRcx5Iu/W7bq2DLaaXSM3A
X-ME-Proxy: <xmx:hLKWaieZTd7VAkRbMN29hfCyDGVg_QCfvbpv2mWC1WStmhM3j2GEXQ>
    <xmx:hLKWagc1vAGeRRtJWQFYQ-IuW0YF3cEPo3_hLFMt-H-G5FF-cL7Oww>
    <xmx:hLKWaujK5Yp9e_6Qv35IdUqdE9SjQLl7O_WmJ1FyrzHDgTO53XHsdw>
    <xmx:hLKWakTeAuV_KDQFxamzfS4oO413FnBlu_nKmwvssoAX_RVhSeNdcg>
    <xmx:hLKWalmAhnTQNjxDTxKbTRdAqp2tuLKlWq14PN3gdu6xHOj-xodHy_bl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 631f942b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:10:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:08 +0200
Subject: [PATCH 09/12] builtin/multi-pack-index: refuse unknown sources
 with "--object-dir="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-9-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
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

