Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893393EB80E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448597; cv=none; b=eMATtyN1wM9MJXlfOwHlKr4SNwgqyjA1ub+6N9vHu6BmPXbZh2pWWUr+TICgDwMi/9O/R+XZmUNTJZBzS6Wcci+RgKdibcILIikFUH80IcS0pFpNljyXrPYH7Mj2pqEE2OX1Zj/I+WNAtYyLMN/fIGks3rCShCIsJ/8yH5F8OiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448597; c=relaxed/simple;
	bh=yCw/KqWM12oHSs7BIX9GEguKv2GYzeN4SZKYvy6cjcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrZUwAZqKhSwQeSY7J0fJyB2heyeE1M+mZT7Hxi4LpQ4RHhIKYnvs87uvzXuYM17ufgGqQjZPwybp1PTalf3GfwTe6IfbgoB3afpn9/R8zrXM9Khh6MmyhqnZ7YsxOVyW3jDI7x+96YJrQirmw4g9Zq4apatB70+Z3iD2JbBaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaYoXsXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCLaEXwE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaYoXsXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCLaEXwE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBA6B140015E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448595;
	 x=1791534995; bh=6zZ7whboiVUwmTqsHJwqUTdKhFg3iNcfCKLMq8AR35A=; b=
	BaYoXsXIz+9NvFwfQpLEIBJ9TUhU0agAsNsr25W0e92FWQkm2g6UMLbfgx/aGyri
	gCRN7kPqHT2c+dy0qi9KpwEqzImN3AnI8A19mrh9HX7TNg4SBTALt+enwIEnqb/o
	cAtawCQXOenx/UT+wI4Yxb6FA44WrdkN7u9twsL7ga1Fd3SLNFJjuMEom5LPwR/d
	E8MLArkOBCN23XjOHCeLdOq/so08VDx2KhniEtFYnzMGcyKL+GfOH9cVYgUpxRK/
	rckh2dV6OYkPqzMIsb6L4Q3Yezj0M9B9q5lPbsIM+l4fNnXzC+YCoRWtj8JdQhIc
	O14b9TonN5uM83sBxUyhgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448595; x=
	1791534995; bh=6zZ7whboiVUwmTqsHJwqUTdKhFg3iNcfCKLMq8AR35A=; b=i
	CLaEXwEgyoV6Twf5AJQQfy5KWrhNLh0Va6jeQFtXy+liNKDb4OEO/oUW4kDH18cJ
	nwTI60oXA0kMV6pbmWlbTxxOcSehTW/SDb8I9tR4VyUsjpBJzeTxhPKcLuGwlJ75
	phSnNFAmqdbww8EMR7xiuPRvLddclgm7g+/RxjW7+Ly7CYNwYpdpATA5bgql3zmg
	QCWUkMzr8XNLBd8fAw7oDbdRbPBkvSE8IXvilGQ6Zug8wshHzukZrxdJytEX6z+O
	x62RPGCpmQm9sB+PkY0+se5pa0amvF2VDZe058cHbjvgo/hPUPfYqUR6JYygM7Pt
	nMocSTrEDqJc/PTpHkjuA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448595; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NZGDXDc1j1YRyc7ijey4TvlJ5QXUfbIX1UJC+ndHa773lWR
	x4EqevmTL84yovfU3HV4VRZf+gfr1HldLqzDYakMBf4RWFGu7mvm14UEfq8LGi5M
	/KRlnPqB9saX1p3PibWNnI3u1hFLbe+ITqVW4krRqkneT82vM0RQ7BnW0zz4KKqA
	dXNcGiDAfD5/A3t7bWL6mENDji01ie7e/rxI9GrOEW4WHCgHz68UEPJRhf0RJssu
	8bAmzNxtEkS1rNN0z2K9sWSbEoFeGMQqeE2GCJ5yQURp96RtxDolSkg57jJQKQ05
	Oou4ZwodVJfMnMBPT1v3kD+MmNPgy7hAPoiAJ2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:MtEEnzgX8YVYfU2SzF3greX++lxzfnnLDJ6/Q3Qp5V8=:yCw/KqWM12oHSs7BIX9GEguKv2GYzeN4SZKYvy6cjcc=;
X-ME-Sender: <xms:E1bHahaeiINEt8Gsoa3yfXQ7v-Ql8chSvZxzWFRXWVtCF5AxYRTJNQ>
    <xme:E1bHauayDmjwH7Q_YWJtZz-nH2ReVNJcuxPB9HTTI331VyIA4ivwrzSq1oEuX0E27
    4ypQ5XVLnJG1EfRTR439DG8xGnS2N_X-L29R1Fn4r-ayaYwbftzkso>
X-ME-Received: <xmr:E1bHahnGTReaqh1nmZn2mDWEvs5z39I10ruv4AFPEJxvsoe-zG9fPw>
X-ME-Proxy-Cause: dmFkZTEocIhRSWW7R76AdnGp/zz/VhKki2f52Q6P92mveZbe1h1oUnxvuC7EbAVZ8Ju1rk
    ySiXLO+wq9krMVD6yhxJxeJDzHcOQGRK2KXq5oOsOHUElaxmyx+YVZYDFEHLaycRdrhEYR
    3HePyFDzvanDS6q01NCAqtYeR9yc/UyY/WN0ytSP+sjuIB306QBtdjP/QqtTPVXq6EJK+3
    8ZDYyLtye7Ou8Cj2Xl85TBSoFPQ0KkDwnVAGIILZArvZAjuDv/KvFRswlfOrbnuQNvOmiD
    XleM+3txX0RQTg7jac9WnxuK95Hdwb7dkzaWgaocE8TjiuJSOQvd0b8UlmemuzGjsk/WFR
    Qn9ea+p1P9isMUOzqF5j/1hUZb+FJpnAlDBU6GnTgl2t9nRH5zZAtbKIQ3oKo2Ak9gw1++
    e0BCg/Q6gC51dqdlU6zaQZQ6ruppxtgPffsfw/qB11hW1r14Vi+EqWWFe2b/qYF1k0F08L
    FGUo2aUXoy7jLxv3HFjQk57u6EZK6oNlpvMph9Umj1biaUFJhcU2pwccL0adN5bFsvB1Am
    NNRneYOrjZEAtkMDLMYSIRC3+Nv7QQVNmrXCIoqjOCQ090SgVwMANS0Sx9MizMjCfv1Bs9
    3uSmvva/MfoKIKx65/clQRFd6oB71dNtSWf8BN9ntVHuEE2b4wiePJoMyrtw
X-ME-Proxy: <xmx:E1bHaqwX_kCgRQWJg3UV5fcgj8byBKL6I1wrJP-Naw9P6iKvWAmYBQ>
    <xmx:E1bHavMZy9mSVTX6E50sZR7d3AQiyJyEaYvDhCp7dQEyA351x_5chw>
    <xmx:E1bHauRJZnhKR1D6LDaF3jrQfHoznpqqmfEWXQxRjHoe_jePJ6LHyg>
    <xmx:E1bHatYAtduVAX6HFcG3Aq2gU1kHnWnCF4obEjmR_PRjOowOVByiCA>
    <xmx:E1bHanIKMTkiKkajO3xWMWqI_s3bCpjnIQYG9XEc_65qbAOwDM1TEmh1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5f4f64a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:36:01 +0200
Subject: [PATCH v2 11/13] odb/source-files: extract reading alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-11-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the next commit we'll add a new callsite that wants to read
alternates without having a proper object database source for a given
alternate available to it. Prepare for this by extracting the logic into
a separate function that only requires an object directory path as
input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 9389546b3e..6aaf625352 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -174,6 +174,24 @@ static int odb_source_files_create_on_disk(struct odb_source *source,
 	return ret;
 }
 
+static int read_alternates(const char *object_dir, struct strvec *out)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *path;
+
+	path = xstrfmt("%s/info/alternates", object_dir);
+	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		warn_on_fopen_errors(path);
+		free(path);
+		return 0;
+	}
+	parse_alternates(buf.buf, '\n', object_dir, out);
+
+	strbuf_release(&buf);
+	free(path);
+	return 0;
+}
+
 static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
@@ -364,20 +382,7 @@ static int odb_source_files_begin_transaction(struct odb_source *source,
 static int odb_source_files_read_alternates(struct odb_source *source,
 					    struct strvec *out)
 {
-	struct strbuf buf = STRBUF_INIT;
-	char *path;
-
-	path = xstrfmt("%s/info/alternates", source->path);
-	if (strbuf_read_file(&buf, path, 1024) < 0) {
-		warn_on_fopen_errors(path);
-		free(path);
-		return 0;
-	}
-	parse_alternates(buf.buf, '\n', source->path, out);
-
-	strbuf_release(&buf);
-	free(path);
-	return 0;
+	return read_alternates(source->path, out);
 }
 
 static int too_many_loose_objects(struct odb_source_files *files, int limit)

-- 
2.56.0.406.ga2d225a756.dirty

