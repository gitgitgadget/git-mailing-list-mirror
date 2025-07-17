Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1B207A16
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728250; cv=none; b=Bkbb5Yw6EqkguhWXjv88MrqGhUPWSi644HwavOten1q4FRq9Kf7x/ftdLnrNKRWdc9WEpxIsVI0o6eJz37mH1arJpcA7JQlie97uQKDIUh+zY1dHirBnpyI6eISruYtAj5Vf93h8sFA2H6Dw2zq1Wob1JIWxQ92lNyNYn+lw8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728250; c=relaxed/simple;
	bh=QH4e2mTvQzbqtxJixL5HiWYoOTfurpsvBNfJkqrdv0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ktp92KD94N8W+iM2h3crnn5nYxXv3+cSTzXBJLuwGeO4gtA/5PXW7NSJEfsb6jmptX44hrpxPIagJ6JKgk2R6IkFNNfwappO+UFdHfty6uXGIVVf093o21QnckmT5EkZkUNukc87j9BohxEdrVRqYB2Oy1Oxo7j2leySIl3pGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=x79C5c8I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A17TTXjV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x79C5c8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A17TTXjV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A4BF31D001A7;
	Thu, 17 Jul 2025 00:57:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Jul 2025 00:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728247;
	 x=1752814647; bh=yjv4ucBdt/GuSzJxajsbsu3NGv9nYu7ukJHF34j3P80=; b=
	x79C5c8IR36LfMLjS8pUglKZ0ap+mG6MscdG3/opw5+P/LK4q/x3Bf/sgUedpeeK
	tA+bBZ5llqTNh3SqhXEwTg22rgGHFlY1vDMJfmf26PQHElWDKovsUguTC1oDiw2r
	8GmZLUlNwMpbk6wnY/n2sqNmKMZIPSakUpHp/tSkXWcyTP7qxm9eh3Xy7rOdWU/F
	oX1SOYxebzAJvPDykqAuXumZoRVv6tMZgIqpL8Cvc0gGcZQ4Dc+ZJf9O/EnGmUfJ
	g10ahLvfwazNFlOwxuum+fXuqr2jzPfHxHu/spvj1fgSwxACVmo5CPKWNAkhONS5
	OlR4bWQBh37hnsor3Kxzpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728247; x=
	1752814647; bh=yjv4ucBdt/GuSzJxajsbsu3NGv9nYu7ukJHF34j3P80=; b=A
	17TTXjVxyZPlT9/vJSZluwXzxSeWUc6Cm8aEkdhMLNt/IwpM7ulOftsNlYykStHg
	CWBbsEQZKiZdtrHtSpgOETtcmyOUbplYpUBgIzg5UJS/6IlXXRd/UIVgUylxCVg2
	GZkzuVVHqaVTNym9pxvD5cE6vroZ7LuJ2M75/xBoAkFdnIQDC8jWWbM+916a42Q3
	q3FnUWSU0DEgTBkKsCe8HtKcMhi13Ixsuvk2HxVll4ALRZU7aZ4z2HTTSECsD1Y9
	C8gTqRwF/XZR+U7ke/7TFis0aMO2i002u9VSqayf8mQp27+4/xVvOwk0r41ZYPK/
	KY0mPr9tDyyeVoaTAOwQA==
X-ME-Sender: <xms:t4J4aES2KRRumha5LLarBIyo2Y2GBkgh14r2mVPJMm1jXG6yNRpleg>
    <xme:t4J4aNRFRrG-hEiiNEY5LTe39CYKwA2HCeHgDBSqUee20ov4QKJ5PO_4IyGwTt0rQ
    6xSr_Dja3eofVQdWw>
X-ME-Received: <xmr:t4J4aIRduVrWuhsYEbH_3_2v7385qXKQcyeSYjaOBG9csapRoDZKwM3ZtJKObsQaGD8uA61T-L_3bqxURj7a5QWae0_icglnJKnJpJu9ipSO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:t4J4aC4mtw3mJc5fTsPBs_c_s6YsAS8X8wrJ24Qy4u_lszipnPMRfg>
    <xmx:t4J4aE3vrH1eH2pDU2T-8Tl17Oq1P41fideQQFpDZ49DYA-PHedCKg>
    <xmx:t4J4aNBZ1pjgdoIozOMNOYhypiiLzXWYj1trlv3cdzfU12jxRkjoXA>
    <xmx:t4J4aPNeJsv8nGfQY20TcI-yKQPORiZjCYQulN3uSKTJHL52cKVdFA>
    <xmx:t4J4aKP2LWp1I4rRrRtdH4Jw6fUJ0TPLxLs6Zl0QaBPpdwxD8ap1JPkP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:57:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f5b0b60 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:57:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:42 +0200
Subject: [PATCH v2 16/16] object-file: get rid of `the_repository` in
 index-related functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-16-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Both `index_fd()` and `index_path()` still use `the_repository` even
though they have a repository available via `struct index_state`. Adapt
them so that they use the index' repository instead to get rid of this
global dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index e9152d9e04c..2bc36ab3ee8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1257,7 +1257,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(the_repository)) ||
+	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
 		 type != OBJ_BLOB ||
 		 (path && would_convert_to_git(istate, path)))
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
@@ -1291,12 +1291,12 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (!(flags & INDEX_WRITE_OBJECT))
 			hash_object_file(istate->repo->hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
-		else if (odb_write_object(the_repository->objects, sb.buf, sb.len, OBJ_BLOB, oid))
+		else if (odb_write_object(istate->repo->objects, sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
-		return repo_resolve_gitlink_ref(the_repository, path, "HEAD", oid);
+		return repo_resolve_gitlink_ref(istate->repo, path, "HEAD", oid);
 	default:
 		return error(_("%s: unsupported file type"), path);
 	}

-- 
2.50.1.465.gcb3da1c9e6.dirty

