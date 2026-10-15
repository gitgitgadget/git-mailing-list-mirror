Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192893EA947
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042095; cv=none; b=gtv3ScwYynWzLgBJUFv6RvG/H91YmWSrkHjPRIPCrjX/Sz1BSC2ffeTMbmFwn2fVadmftYqVMvFttiC52MyLlzJqHRO4TKeww1F1kdDekbVOBmpKyWqXxzTi1Nzmw1I3CAO7BdN2251F/+eIjj2MlMGmi47G4rJeVsBxOZtSjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042095; c=relaxed/simple;
	bh=oqBoQ1KjioLPKX5cVV19FcMqafUqFksTzLMa0FJYQuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYeb+D3DxucDrzqqjOwFb+yd3eVJ7Ff000QWqesUiVUPEzWuPTh5+5OjFB2qH0jOMByRD5OoWPD5mO/QF1879x8ZT+poudChHACdjCkqOeagrL00p4KPWmhzwRD7I+u0p7VKM6t6Yg5VF3uCXmxMGgBX8k9QI3UCTVJKYKL86DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8nCeUq9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xr+pqdqN; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8nCeUq9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xr+pqdqN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 56F771D000F9
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 01:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042092;
	 x=1792128492; bh=c00reCsmpUiPfZSvnEmm+xsSukJbNKCTmXKuDRQg5nA=; b=
	I8nCeUq95F3ban2ZFMI0LOrV/zZ3oEdNX07+vbiNC8dmdqKbvM3bAX6X+wpp/zMM
	4YZM8jHg6MPGwXDbmnahfVAAOFu7FImIki7gkKTuk2i6bEs2SPEo9f74XkbzM4KM
	1NWRBPyVjYeF9ZZOacvaukvTlIWoyhJi+SkPFlXatDDUFil1UNfoHRPTq1ecjIGZ
	hnHWZe0OsQJSGHwB+yQkN1bKqfMtttEWxk18OYHzPemkRNNny1w1Pbx+3+Nzh+b0
	1YaSElTBA5sJWN6Nb7Pxxmk20YQwtsCcBkt/OIQJzrvs3cJwRnenMZx6vexXj57E
	bf2TbddDBfeAzfyDdv8cPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042092; x=
	1792128492; bh=c00reCsmpUiPfZSvnEmm+xsSukJbNKCTmXKuDRQg5nA=; b=x
	r+pqdqNm0rOeMFR4Zxa7KC5TUeyIEbrbQ5j6C+axjyyRPWASvmftArG33IuAr8wH
	gCXuSPKw0URp9AhRcvUinlBC/C6FfaqfzNHkZJwPFE3j0+UEuPijlq1sYijRY/34
	fnW/2FgU46xB+UUY+XY3IFujOZ1VyhW3qSiYh9ranG1AvYy/GQ+XLBnaQnWVUXp6
	ecvp8SjXGxtQLXLq1IDyTILEysJPe/c0at8+VwPFA12bnmeS+xvcW9g9jHtqE8TU
	7xoOKA/zCbw2qcS9i6ba3Kv5tJpzqwnrJNowXnv9akdwIxbRfY1tjrzZ85SjA//+
	ns0FGDcR8TMePC/BF3rOw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042092; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fO28QuPf/fVX18KkVl/xgQ+GdpL+yNmYpyqc/Iw7pQgUY3a
	ZWdD2egL9fZ3g5Ww1+l87nGNvciSGVB9vlyrIWpnSQU2WF8nE88BfW+CnMw0afbH
	g8KRrTC4FZJ6D2uw9c+ipQJDgdt3UljOimoFGtPpn2Eq98WeUYdHT/dTR+uJ6Oan
	pLftzQYYv+COq1GtvsDXbxZLKCrGCn7kgDRjoWvx/rTfjdapfETNDrob21LaPtYW
	BQHtAgUim+QeZFGmCFLl+QF0Ng4jyttpoiMQbIK+cmeMmtrVk2lTHsmogOZFxywv
	qt+oC3+Us8pfR8/W+mCGRyC3WEXqGK30PXA6wrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rOLRcV+m0lS08uoXexusOjhYC97dWOMFlRNRgTIXQfA=:oqBoQ1KjioLPKX5cVV19FcMqafUqFksTzLMa0FJYQuI=;
X-ME-Sender: <xms:bGTQasc42oy7tl43M0JIvVtuK5k6sSJor5ZNMuJkE9wIZdFNzgydag>
    <xme:bGTQalHdjQwljEmydmarvkLI-UKnMSnSYfyE6N1lV4-1UWuuHLOb62qLQYmXHBCR1
    etOJT3Sx2eitstKLlsQxVqliqMvnB02e8lq0yD2QYBDyz3Al6eIBQ>
X-ME-Received: <xmr:bGTQal2U_LTmNix5pg53daYeGcE8SmOvxwXJUU0huS2xngHEWSpeiWZM7xikxxPDtmRpCV0>
X-ME-Proxy-Cause: dmFkZTFlm4xBwnnUrq0iXE9WdfR1pU34OlAmKCKASgwyj8Sm/x+s8aMAc2Xuf+9EQW2hFH
    hrDx+1BhCYEpYhpy1Vv5FW5eK+Aa071VRZOsZB+0xHK6vEnH0QGqRITWRSTZ4DIS2q0hGr
    wU2OLM+4+2+QNPcOkBppZH8JSEu+iudyEJmIa46pFIygoEFJUM4drEyfJhNltgHvq5N+uD
    USlnpYcEuJvpjsV/mnQlNRmVC5pSN3FszjK+vz/d/rBLGEMMpX1ipe/16OOHTNCxtcpepk
    Tdp7IDVhtrO8P/F9deNsGMPzpWmOC3rMcfAEfBRIUJQKbd8UmDjR9hj167GMfCIBJuqHIK
    B99WDusQKxT80DG22ft0uNK5cSzT595Q/0f21avPujRtIJkiS0OvnHL2qCJsPJORTZsXIo
    smf2Q1XB5gQ1WkB7vbePYc2tud9g6cXyH6SMnuNeCr4NSNZxlDHlPBSIIuxZtGtpkcsq0V
    SDPRscq45jRcCa7H9iNIFjsKedVHbyzrfKnEwSU7aGVWpRWlESt0Z+61LQHTGIfEwAA5gC
    jqU0rGZTSfU0JJ8j20RXMSGWGXl/tvArd/ldt3xpVLjw7mLCwuvNKRWAiuoEV4AnCbTPcY
    uNw9SHLVtU5s7Zu9wgzrF8wzgzmGXw17thajJTUebgeQ16aOUs5cOd3bxvmA
X-ME-Proxy: <xmx:bGTQatnjM-7j6HWIaP_L4-3SgKiNHYU5s19mJfXF548FjK1EAPZNBA>
    <xmx:bGTQal-27nkya4u3I-uuYOVq0yjpaVkxYQJTUW8KeF9frOC47DPU-g>
    <xmx:bGTQaipaDeh2u-tK9HHQnKi8DKOGunYAj0ebbb-Lc0mrHeb2BQa2BQ>
    <xmx:bGTQaulnoq2c4pKZQoPOBcQdUqCQdnITfII5uzI4UE3c_QG73NQw8Q>
    <xmx:bGTQaqBed_3fTRgdVEXIzKcKjhqkpacARiCSyQJjAEtWzOH4RwUmguTM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc9f4d5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:27:59 +0200
Subject: [PATCH v3 5/6] odb: don't try re-fetching corrupt objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-5-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
X-Mailer: b4 0.15.2

When we failed reading an object in a repository with a promisor remote
we try to fetch it from the promisor and then re-read it. This logic
kicks in not only when the object couldn't be found, but also in the
case where it could be found but the object is corrupt. It feels dubious
though to just paper over corruption and proceed as if nothing has
happened, happily fetching data from the promisor.

Adapt the code so that we only fetch objects in case they are missing.

Suggested-by: Justin Tobler <jltobler@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/odb.c b/odb.c
index 095183aec0..2c93a9490c 100644
--- a/odb.c
+++ b/odb.c
@@ -265,7 +265,6 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 	struct strbuf corrupt_err = STRBUF_INIT;
 	const struct object_id *real = oid;
 	enum odb_read_status ret;
-	bool corrupt = false;
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(odb->repo, oid);
@@ -278,38 +277,27 @@ static enum odb_read_status do_oid_object_info_extended(struct object_database *
 
 	ret = odb_source_read_object_info(odb->source, real, oi, flags,
 					  &corrupt_err);
-	if (!ret)
-		goto out;
-	if (ret != ODB_READ_NOT_FOUND)
-		corrupt = true;
-
-	/* Try to fetch the missing object from a promisor remote. */
-	if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
-	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+	if (ret == ODB_READ_NOT_FOUND &&
+	    odb->repo->fetch_if_missing &&
+	    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT) &&
+	    repo_has_promisor_remote(odb->repo)) {
+		/* Try to fetch the missing object from a promisor remote. */
 		promisor_remote_get_direct(odb->repo, real, 1);
-
 		ret = odb_source_read_object_info(odb->source, real, oi, flags,
-						  corrupt_err.len ? NULL : &corrupt_err);
-		if (!ret)
-			goto out;
-		if (ret != ODB_READ_NOT_FOUND)
-			corrupt = true;
+						  &corrupt_err);
 	}
 
-	if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+	if (ret < 0 && (flags & OBJECT_INFO_DIE_IF_CORRUPT)) {
 		if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
 			die(_("replacement %s not found for %s"),
 			    oid_to_hex(real), oid_to_hex(oid));
-		if (corrupt) {
+		if (ret != ODB_READ_NOT_FOUND) {
 			if (corrupt_err.len)
 				die("%s", corrupt_err.buf);
 			die(_("object %s is corrupt"), oid_to_hex(real));
 		}
 	}
 
-	ret = corrupt ? ODB_READ_ERROR : ODB_READ_NOT_FOUND;
-
-out:
 	strbuf_release(&corrupt_err);
 	return ret;
 }

-- 
2.56.0.212.g129ede20d9.dirty

