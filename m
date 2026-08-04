Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8EB43B4A5
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832201; cv=none; b=hC/pjpnP1OM14ZfhE/7gfy/pyNk9h5oDVYnAWiu5Mq4OOn53Y4cpBfCdU/oZDASwcuWD+3jvOpFOpjKNylBtqYniOAaV6ajjVLAacVu3G+skPT4W2KRp93bntZT+JrDQOWQlIw40isHq2naVlmRA+gP2saDpVgwWnilBWOwwj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832201; c=relaxed/simple;
	bh=f6cFjoLlnFfH2hwTFje89MkuYI1XV44R4voGIAq6Ago=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5HiiMWrmZCyyI93tMp2PnOZJC3FQxo6gVk7GFyV8RMT4d2rnq+0kYyu8ZiR9BGwifjouFJDmgPM7T024jTlJRrEQNQqGmkq2QxCgttlu7D7e0XJmcQ1+CG1C3vsVhsQJV/nUM02YbzM8lrDSz2uc+D3W2i6wlGC880J+/sKjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T+hrjpPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4HkKE3Z; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T+hrjpPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4HkKE3Z"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2641F1D001AC;
	Tue,  4 Aug 2026 04:29:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832198;
	 x=1785918598; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=
	T+hrjpPcBze15hEl+iYI5d60jMepkz6xvorx7eHK8kSDl+2wTdC++lXrg5i4WPB6
	Dc1GY5yp1kQXHv/ThuAN80wIW/vlDAnwNyz743+FKLNQSjG2bB/YUVIewk/F9cYu
	xAvucEqNT6NuU8kSTZ3EBM1F/tqncYzw3noMrggBPPftLWRE+i0S5yQ4q4tCZ4ep
	0bp3+xps+x++aM8Z7rzvD/0MdeUMA6XMK70BlsEERA7n07N9oKNWZBacoOGjiaJY
	6xE0R3IoQWMQqOFguJkkDUEUthWJi63SE6sf6Df88tsYIS/Yy0aCeFfusekVtmxd
	23V72uFs3n9v2PnkP/zzPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832198; x=
	1785918598; bh=TeNNo7XrpFpLNeKgLEZfuDW9c19t2ccAPVUTfXKoXnA=; b=d
	4HkKE3ZfaA4gkIs2e1hHz2i7hGph1ADFksjrkxESewARGPumHD050cn4qVo86AZc
	gj3tLymCKyQjsp2nGQDJdxecu7AZ/e5e8yhZ3IJDhLYDLZj9QF3EEf/ico+lYNVr
	+T+XBS+QSOhospBryUujwLX8osLd2cKUIRTvaRd5jPzSvGRUfhaMqR47HQFqXDzT
	LOXSf1SwAqj6Z+MJuPHqjdrKykN1jXq+sal2q755pvuYX+vNf/aUw3R/6XVktHRU
	CbWOFgcbxsQydTdu0FMWJAudKaiL3uR8SiSiLg2nxMJTX6WHi/5AXqTjkYOrx+Sy
	4WIg0GgrBL1EJAvimBErg==
X-ME-Sender: <xms:BaNxamWP8T1n_Kg1O26cJg5_TEB3bhOrfVbBOH63IJluJf5Z0GmttA>
    <xme:BaNxapmM-ZD8qY3rwP9vCqlim1YGQmJwb_hPys5lvwOD7BIsb3aOpPjf3b-HLPtJq
    Bd-BZfBOpk_cVtP9SDi_kcrH1jvXNeYTwLxeJrjkFUqC4rALzm4ZuU>
X-ME-Received: <xmr:BaNxavZgiKeY4RVg-XyPimSStbv6VgKzVCPA7Yj3zPLo_ue0EfCyfe_05kJr_HdEIw0YiKGK0d_Nr88r4M0NwJ0ra-t0cJcALQnX20Co>
X-ME-Proxy-Cause: dmFkZTEbgtzG3LVU36iLnTJFOTKaJnVb3Xpa8gL5U4HxfIGy3b8t4xIrlpDR2DpqRIZvzf
    n1NI56hVabElJrPx6MSMtz1cn1wl+/2e6XDDCQz5bBcc7tZPYbMw6N04VMFOLBi2SKlZCi
    bIg2EyW+/zEy6CTrZbhGwQc/+oDHdUmiW5xr3HKqR+v9ls9TXLukerfdzTR0S7RkaDq84C
    Pr7XwrqTs0UBCsvWclzxevhVY9QLcuIyCKGZfoFXEvWt3uFBZ852qzUxPP9qmgChakaEfl
    TykiJDiQj60J06EdA2jtQ7uStMrFkhicj42WfaCa9v3sW7CnzNa4vaxT9e6yFwS4In4JeR
    rwWr+2C6TxuZ2vpaEaplwkzivcX5XpRsU9lz5Io0eD9J4PXofOnE093CWchtChZwSD+U1g
    r4gRxVu+PZ3vfDY5MZqyvr1uZjJfnKV5CBnHwl48dbgrfE8DMFDKpvmvffMe82fMZEvd7Q
    9wCKz/l9UFF21Z0iciHO71AnXJM2JbqxRZuS6Nw0Iy/bpnMkVCnUgmt8ORSyh2YQz8GPlw
    QG8HcL9WzMnAN6/DVcrQ4Crf4xBdQf+qGMmmlyUQXfW6AaKn5IWXaHz6jaQSyeTq6Fy2dq
    BgFgqIL0a+9q2K9dfAlOWjWyMSUEEN3bAQ1zHFDLF6ScQZjC03JA9T4rw/Kw
X-ME-Proxy: <xmx:BaNxasNaFmwRhQJ3AGAflT5OFDNhyC3ORFXVTn6gdlGnnImaEjUaaw>
    <xmx:BaNxasYMFY45e5K27dJ16Uz2WAqI-J8LtG92GFYnlFlJeMrQP9LOIA>
    <xmx:BaNxai2ijjGkUZP4LKcZwJr9zqtqXr-hSXNAzZyvKqTTyVlOBlusOA>
    <xmx:BaNxaqeO1k4Dyagz7d_voTfTJTllsMbcI04-AuQ082gEN1kmmvFtRw>
    <xmx:BqNxalaNbZegiJfQzDjRj1gOSTxUrnbjvPI21f9eSxtwNtxegA1FOMWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:29:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d80d36ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:29:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 10:29:06 +0200
Subject: [PATCH v2 1/5] loose: load loose object map for the correct source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-create-on-disk-v2-1-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When loading the loose object map via `load_one_loose_object_map()` we
pass in both a repository and the corresponding source. We ultimately
don't really respect the passed-in source though as we instead always
load the map via the common directory. This doesn't make any sense
though, as the function is called in a loop through all sources, and as
such the expectation is that we'll load the map that belongs to the
given source. The consequence is that we'll ignore loose object maps of
any configured alternates.

Fix this bug by instead loading the map via the loose source's path.

Helped-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c                       | 18 ++++++++++--------
 t/t1016-compatObjectFormat.sh | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/loose.c b/loose.c
index bf01d3e42d..9dad75373b 100644
--- a/loose.c
+++ b/loose.c
@@ -61,9 +61,11 @@ static int insert_loose_map(struct odb_source_loose *loose,
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct odb_source_loose *loose)
+static int load_one_loose_object_map(struct odb_source_loose *loose)
 {
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
+	struct repository *repo = loose->base.odb->repo;
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
 	FILE *fp;
 	int ret = -1;
 
@@ -78,10 +80,10 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
 	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fp = fopen(path.buf, "rb");
+	path = xstrfmt("%s/loose-object-idx", loose->base.path);
+	fp = fopen(path, "rb");
 	if (!fp) {
-		strbuf_release(&path);
+		free(path);
 		return 0;
 	}
 
@@ -102,7 +104,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 err:
 	fclose(fp);
 	strbuf_release(&buf);
-	strbuf_release(&path);
+	free(path);
 	return ret;
 }
 
@@ -117,10 +119,10 @@ int repo_read_loose_object_map(struct repository *repo)
 
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (load_one_loose_object_map(repo, files->loose) < 0) {
+		if (load_one_loose_object_map(files->loose) < 0)
 			return -1;
-		}
 	}
+
 	return 0;
 }
 
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 92d48b96a1..9cafcee509 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -187,6 +187,24 @@ do
 		eval signedtag3_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag3) &&
 		eval signedtag4_${hash}_oid=$(git hash-object -t tag -w ../${hash}_signedtag4)
 	'
+
+	test_expect_success 'rev-parse maps oid of object borrowed from alternate' '
+		for repo in alt borrow
+		do
+			test_when_finished "rm -rf $repo" &&
+			git init --object-format=$hash $repo &&
+			git -C $repo config set core.repositoryformatversion 1 &&
+			git -C $repo config set extensions.compatObjectFormat $(compat_hash $hash) || exit 1
+		done &&
+
+		git -C alt commit --allow-empty --message A &&
+		echo "$(pwd)/alt/.git/objects" >borrow/.git/objects/info/alternates &&
+
+		oid=$(git -C alt rev-parse HEAD) &&
+		git -C alt    rev-parse --output-object-format=$(compat_hash $hash) "$oid" >expect &&
+		git -C borrow rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
+		test_cmp expect actual
+	'
 done
 cd "$base"
 

-- 
2.55.0.679.g6767b8d81c.dirty

