Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD37450415
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974970; cv=none; b=hEas3ik17JYOhqDRaSj/xAxgZaUezJAbRbh118MXlJ0KYoav4Xs5TfgwDWl6zpSkr4h75YJBS5X0mt5XdSuh82HhdXJ328v1mIo/NiOJjR7AQAPvrXa0rD2ocjMpcEqIldt2OoFo105irRp9nLLHbQnYhsKd3I1GhBA/Xq0W6I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974970; c=relaxed/simple;
	bh=45HDq15ZVmbU6BXw4LvyvWZRu4qPjueuMyfysiJh3lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rtptvdZP4ngE7N3i12q7Tr2u2I3qywly6lqCFOuWbIxF4g7zf36NirmqWp2GfigiKCuGhsK6ozZDeM6dcMr3B2aHiYqVNsIHl8WCXhWSafW78OMBKnfHumo+bKzeagON9BEa3Q1oFDFx8Kt10kOz2597LY4XbwRDMn+e5sGVSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VIOfMcI6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZ2xH8ZJ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VIOfMcI6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZ2xH8ZJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F20614000A2
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:49:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 06:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1791974968; x=1792061368; bh=8kAGUFNvvl
	OGDHTol7xgC3SBogYiCM4AnOA9o5477jc=; b=VIOfMcI60XFZ01s3DLU1raMeWh
	cYlpJFGf+Hvn7C83ZwHE7upefZmK9OyaWNSTrazKPY8GDOFbppflBprDMAW7XoK6
	Q4TsJOI/vGNz8yj01ACOZsQ5jqfkjhzGsSHvJ92Wi5VB6ae1mOra4sFyYZSVf6qx
	al53nkP++9C+Z6V0teljHpPxsl4NlnI99n3EqciQ64Mqr+9jbmWKK2Lk3n30AS5g
	bf48Qbmi5qQsl6CcXvdxg50tGkQrvCaRS4f9pMGFSsXpLxc14+D7snnpoXkjZ+ut
	wH07xw0XON+TSrsecW544rLhFZAnp/mXl3xEb15g0J0w0FSj1gd0BB4s73mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791974968; x=1792061368; bh=8kAGUFNvvlOGDHTol7xgC3SBogYi
	CM4AnOA9o5477jc=; b=vZ2xH8ZJC2jsAIMgBIRJqljB3p12n6N4rJsVNPPCO0OZ
	bwDSHxt26N1VQPdVK0O/a+7kIzjHHXjrZ9ykFkvEhJin+AjybABXq2G+ikEwWPw1
	tb9X80fonayPqqGDjRIwq0FYJq6Eko9/Rtl1fk+h7Z1cy0qFWw44kFpLgnzXsveE
	1owjyt0FFAj1GphcDjRrY8bCwp36OVCYqN+mWH9lMwiyC9vij4uR+zypka+nRzKC
	c4s0HgfXMLUBmriZDB1d/ibyDcKvI41GZr4As/a6Dvjaba0jMizwJF2IVr90DkfY
	gWnd/aPkIrZAIqxLnSGHJsJRaTn2UBkVDU5w1IB3uw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791974968; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nT72MwguRHGzlxhR0PrhfXv0gXbyBByAStNEiBLfdLEc2SM
	kT5IMi2/5j3Ou/n6gHf/skaH7sYyvci4qR40yDdkPTLTGa3JUtmhYdMer2YaQk48
	GbORMQEge7Wm8xaPOLL8eFYrLTtvU3OXW5+B5nvBn6EzHxckqjiWYtovyUq2uPdl
	LgTmY/c8RgL+93eTP3ay3OQwc1QzC8Gi62AecduUuUzwVM4/3Q0RZd4wmLM5Vtn8
	baPj34/4e3PKG0f8fMU+8YIuD5Hx+I/csM10EfYTQP6Sja1+HmRTuzZyPhSn6fdG
	F2XunQ+IQ5/AB3iHPF3CrU3aMtSaLT+BdbH5DbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:Jfxfw2j4NX7Nh3L4XGC+FLhyHFmFNyokqBzCLeZJ564=:45HDq15ZVmbU6BXw4LvyvWZRu4qPjueuMyfysiJh3lU=;
X-ME-Sender: <xms:OF7PatipYvPKvLJH5BP0yqmV187S6RAVyzr34bLsScDk_lqubaLq9w>
    <xme:OF7PaoAATgG3juEZUBUBrXvnz9fDCnG136eX9PAvLyJUNBbjZWhsPaOwXKnl4I9wb
    1-PsCovOQz4XxWRLMPpSnh_5pgbTu109CZrWoAIymNBFEo8FP0rOg>
X-ME-Received: <xmr:OF7Paqss8kz20zTKQrcpsSI61RX43Xdim-_Fg0A4hod2GHyA5ay7hQ>
X-ME-Proxy-Cause: dmFkZTFUG9K2elqLav4Fok2d3sDKislC1dmUdESIPoTjlq69VwqSV1SaT9Ag645BPrbwV8
    aPW9do63dlvyx2Na1SrFGxr6Trza/LQ5vXKcxj1fhNFWWguWOjAZ0YM3ThISa2Hxk5Ietn
    W2Z4XMNerwnljB/bhLTA8xHHXMI2IqgTagDhd2N79KPp3BYTaxORi5A0ZkbvTJ3mZenJMZ
    CIIu+evzjxrycWvmaMF0D9557TrJ0wrJnTZo7n+9eM1d87Yx1PmV0byr320NL+Yi3QC7im
    3MrsYZOL9oZKm9KTtTGRFzLKiRZ/Zb0Wgh6e/KXQfwQUQgzWkarJHmkvDS7/sYetKQxIgw
    SNGK43SYgeOrSbqkxlqMFp8KAzrtmKFoH6Esh+SKXgJwRD4hWNNwIMruJ0G4rdXGWf9PaB
    +TEygKyalCy1BJjAySTCqVfgpoueqUvwdGAtMzNTYovxJemMlJGRUs58UOrRa+hYW0hJnj
    8j7nenJYTWzG3/DC/mvkF9iVUGiqCmDgprD4juU14Hk+CMbfyrzNWnDgjus9fyLQgOOFu0
    yFag+gm74VGnwX+oWCz1zw4rqjbTiZjFS7rTqnFPnEyyqZI5xRKrge4b5Cb7lmRdVVU4m9
    tqTEbYs5cWv9AKP7ESRYpyVO+25aOp4Xm0vfXWL3wBhvT7XLyTqsPxrbOgEg
X-ME-Proxy: <xmx:OF7PatbvvPbD-WLyziHAHbP3l0wn8PfNocxlxtusLoH3RZjadNNwyw>
    <xmx:OF7PatXf-mTBMvQp3zwVnTp4JK54Ag19cFaiTy0XBaZIzTmI6afWrA>
    <xmx:OF7Pah6X3g9fZTVgI4doaLrC1k0uF5S_SyWmuAtvXhYsZkZLWZ-Raw>
    <xmx:OF7Paoj-x-xU3tOr4G5sGMj6L6jekTMMsV1Cs8YVBqcmxq7uTvGu4g>
    <xmx:OF7PalSCxllNM-tS_d48DeEyxIfH6fXQcohiDaW78qSYivCAH3Oan4RD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 06:49:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df882464 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 10:49:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 12:49:19 +0200
Subject: [PATCH] pack-check: fix bogus corruption report with
 core.bigFileThreshold
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-b4-pks-pack-check-matching-large-file-threshold-v1-1-de6d8455eaaa@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrDIBBFfyXMugNRJIH+SunCxxinsUbUlELIv
 9e2mwsHLuccUKkwVbgOBxR6ceUtdRCXAWzQaSFk1xnkKCcxCoVGYV4rZm1XtIH6PnWzgdOCUZf
 +9xwJWyhUwxYdejcbmqVwk1bQrbmQ5/eveLv/ue7mQbZ9M3CeHw73uuKTAAAA
X-Change-ID: 20261014-b4-pks-pack-check-matching-large-file-threshold-fd7be721d6a4
To: git@vger.kernel.org
Cc: =?utf-8?q?Andr=C3=A9_D=C3=BCwel?= <duewel1982@googlemail.com>
X-Mailer: b4 0.15.2

When verifying packed blobs for consistency we have two different paths:

  - When the blob is larger than or equal to "core.bigFileThreshold"
    we verify its object ID by streaming it.

  - Otherwise we read the object's data into memory and then hash it.

When a packed blob is exactly at the threshold then we'll also take the
streaming path. This is at odds with the rest of the codebase though,
where we consider an object large only when it exceeds the threshold.
This off-by-one error was introduced via ec9d224903 (fsck: use streaming
interface for large blobs in pack, 2016-07-13), but was mostly harmless.

But starting with 13eb65d366 (pack-check: fix verification of large
objects, 2026-02-23), we use `packfile_read_object_stream()` directly to
read the blob, and that function will always return an error when
invoked with a blob smaller than or equal to the threshold. So in the
particular case where object size and threshold match, we'll try to take
the streaming path, but the streaming path will always refuse creating
the stream. Consequently, we'll treat the object as corrupt during
git-fsck(1).

Now it's somewhat dubious that `packfile_read_object_stream()` would
refuse creating the stream in the first place. The intent of this is for
`istream_source()` (and thus `odb_stream_from_object()`, its only
caller) to fall back to reading the whole object into memory when the
blob is below the big file threshold. This allows us to inflate smallish
objects in a single go, which is supposedly more efficient. But even so,
this is a policy-based decision, and arguably the backend should not
worry about such decisions but just honor the request.

The most sensible fix for this would be to lift the logic out of
`packfile_read_object_stream()` and into `istream_source()`, and if so
the call to this function in `verify_packfile()` would always succeed.
But that would require us to do two reads in `istream_source()`: one to
derive the object's size, and one to construct either the in-core or
the proper stream. And that would negatively impact performance. It's
unlikely that anybody really cares about the performance impact, but I'm
still a bit hesitant.

Instead, let's do the dumb-and-easy fix for now, which is to correct the
threshold to be inclusive, same as everywhere else in our codebase.

Reported-by: André Düwel <duewel1982@googlemail.com>
Original-patch-by: André Düwel <duewel1982@googlemail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this was reported via [1]. The original reporter has also proposed a fix
that I mostly took as-is while rewriting the commit message, but we
agreed that I'll take it from there.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/gitaly/-/work_items/7397
---
 pack-check.c    |  2 +-
 t/t1450-fsck.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/pack-check.c b/pack-check.c
index c7275f4b92..605811b7b0 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -134,7 +134,7 @@ static int verify_packfile(struct repository *r,
 		unuse_pack(w_curs);
 
 		if (type == OBJ_BLOB &&
-		    repo_settings_get_big_file_threshold(r) <= size) {
+		    repo_settings_get_big_file_threshold(r) < size) {
 			/*
 			 * Let stream_object_signature() check it with
 			 * the streaming interface; no point slurping
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1b4074304c..16cc5d5dcb 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1152,4 +1152,17 @@ test_expect_success 'fsck reports problems in current worktree index without fil
 	test_cmp expect actual
 '
 
+test_expect_success 'fsck with blob size equal to core.bigFileThreshold' '
+	test_when_finished rm -rf big-blob-fsck &&
+	git init big-blob-fsck &&
+	(
+		cd big-blob-fsck &&
+		test-tool genzeros 1024 >blob &&
+		git add blob &&
+		git commit -m "blob equal to threshold" &&
+		git repack -ad &&
+		git -c core.bigFileThreshold=1k fsck --no-dangling
+	)
+'
+
 test_done

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261014-b4-pks-pack-check-matching-large-file-threshold-fd7be721d6a4

