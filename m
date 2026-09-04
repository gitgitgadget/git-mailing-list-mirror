Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91425470E96
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518191; cv=none; b=S2HQnrB750KuJwmE9BJpKCinTlO1/BIL/QAIgjIqxTQnKPBkfJ6N7tIGWTxvFW/IOatlJr7fUbEjd0NyPmw0u7A/nCqwxEgx8vWCAdlk40iistHDPYH7xcja5saNoczvVRC/vqKhEmYKQ43DenFmykIrQQZUjv8Gg27DbBXNM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518191; c=relaxed/simple;
	bh=KqAmFC4k5qugm/aSUKr0d/+Lut2vp0djRC3SB0IPbUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTKhHtdcpGubVmEMtWiROxQJhLF1vGhTrbMNVGPWxfPhQM3PS/ihJuth4JDSrj2Czp0CfaMqYKyGmCd+Us+RTC2qFF7tZD1NIhKAQsnrLi0FmJbrCrSiI+Fy0F/PfcgiReendUSC9YIkvB+YOYeCWjB0zyDNU9F65iZO5N0jy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PyyMbB4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUJoKTaV; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PyyMbB4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUJoKTaV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D78BF1D00128;
	Fri,  4 Sep 2026 06:36:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 06:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518188;
	 x=1788604588; bh=lnNIOm3FUmLTx108xvlM2kM9sOx3rZkZoCzAmRCErPE=; b=
	PyyMbB4xjnjF9eJrOhU8/H5jg0JiJZt/G3Z1sTT2F9i4ALrrbN93REKhD/HVaDOZ
	RDXwt5NFDBcaIIA5BMBZEfvO2HM+XaPBYke1v9t5NfX2nfYrfMEPIX07C+tyBjL5
	h/vaW/nGiWIwJWhtOWAPl8BjKBeFfqYAaL3/QUDLrf2Zad+ITHlZzaWhuVTS3S9c
	O/7PbBAP08cPbqPZbqklT6vd4zNxJFZP7/XbRKtDGfcTZmacgvrRorviEjm5j6g3
	PMGnONDLug/+rYNJ9OgzXnM3yg/ZAwuKgNpfk41aL3GMMDD60YTX8J6aENGHL8Wc
	aLRBY8jZiFrUYBE2MEUrbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518188; x=
	1788604588; bh=lnNIOm3FUmLTx108xvlM2kM9sOx3rZkZoCzAmRCErPE=; b=i
	UJoKTaVgikU1Wsy+DY7PlzeLm6uqFsMc0LSeTlKqCd+0jgyrlcJ39nwTP6wzVRw6
	MRTDlLFLf/NW0Mn2WGAVZyC/E2oH1AXRFTpJSDeAvOC6rTJCTF8KPyQSDdgo3jsv
	umiyHRQWDPmnvIca7lYXviCdzU3N6JAe4hvTkyY2WIww8gaD0+QBPljVzo7RrCDO
	E56tdtRDiXivx2bEZnJ35H89frci/kBwStFTuXfxayPK7VsvRQKhatJeJ+EpyzwX
	s5AzNG5gvq8FtdYm66xuRQXkQK2VXr+7yGKRflZV2QDuBuWIkTgKkwdju/bgixND
	LH/OFLGmH9pg5xBhkX8Aw==
X-ME-Sender: <xms:LJ-aakEAv2OWT4EoALiZb4WWzhGBmxRedKem8nAXc0F5By6mcwcYZg>
    <xme:LJ-aajUhDYXykCWzQO1yaTHtFOGjs9DJP9J9_ciW1E4iE7mzVvBLwKcymB6fUoTt7
    CQ7y0VRTa61L7FEuVrgNO-cnuGjGRwKc33MBH_bU_zPIu8KHBHyUao>
X-ME-Received: <xmr:LJ-aary3kTmgqlnaf5Soa7-sEHacyJoKtT4gL5vcB631XNRRddjfXWzphMv-StcIsmIt3A>
X-ME-Proxy-Cause: dmFkZTGz6D4YEbRdDrI6Swe/8q+Lu7kgrJ4joEx/DD4DhnNY9fOvRsdqoyg+mhwVBRG6wg
    ANR+o05wxYgYD0OE9AlLxIBBz+MyJp5OTVWpiY1EiLOW3Shz/hWnIdk2kSS0QkDhli39oN
    +6ZznalTze7BAokCKwPeM9gubUaHIjLuuDil0CZsLyLG34fFQiAUKYcp9j9NW0AegGdYwD
    UA2or6p9scc4e7xkswRC7oCGXib0KoFAcPdcw0/u/UCf/r6CqdDYbccUyBLSfeb0e35Y5O
    M9A+2vK75VDWfPtw23erXdwwYT0euNi7l5eUiSuShz40VSHywMTvBa1qJ8DeiIXQuocPb+
    FtQ2PPU6bbHj/QDxozOMiTKVKj77P0InewG1HjTxk+aAjBY3sDN95UHB9VHhRO497b3y2h
    7erU8pRJVrPHJEGmcQjPPAs0coMkAW5DQiZ5aMtCZBeOrwUnB8G71B4szq8Es9jb9vnhwo
    whcWYJvmoztclWgTiT7KLJzK9yuiqAi7a5eIlDSuFploLwhqAzI7hTuhzHcipxSC7hTYDi
    75Jf1QwfnLe9f9rz/ShdZYjPbdsx6LXsAOF1FNXwHOPR8oz5/gWcZlF8IYUDFHctNOSiTJ
    DVYWPmeVLjgIDcc4G7Vb0Tol1jXCmcokXic/tlXKUWoAFOgRoPV0dxHe3Ljg
X-ME-Proxy: <xmx:LJ-aahNsSP_Hk6orbAvemgTSJqJaRFJMmFhRBg0U2Z0ch-jGSPRCzw>
    <xmx:LJ-aas6TOcgWrQ-qfon0olBL8YzAR8Bn9iBmdkxHNFKx-MeMI1XEVA>
    <xmx:LJ-aaiPuzn6njkjOAs52jwj2iB7OmfshlMM1dMfawmm1m40CkEgTCg>
    <xmx:LJ-aaqmJ56WMBtmtlLVjddHANHtGwIyyBN_NrR51Up6mJBARhOLbIA>
    <xmx:LJ-aak1XZDVYZIC_rmGEGnGzQH8eI0RN3g2ZwcWo58QU5jd4Fi06paZW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3e67fa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:07 +0200
Subject: [PATCH 06/11] help: rename "default-ref-format" to
 "default-ref-storage"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-6-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

When printing information about how specifically Git was built and what
defaults it has we also print the default ref storage format used when
initializing new repositories. This is to prepare for Git 3.0, where the
default storage format will change from the "files" backend to the
"reftable" backend.

In preceding commits we have adapted "ref-format" parameters to be
called "ref-storage" instead to resolve some conceptual mismatches. The
build information is now the only place where we still refer to it as
"default-ref-format".

Rename the field to "default-ref-storage" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 help.c          | 2 +-
 t/t0001-init.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 46241492ce..61ffadcdc4 100644
--- a/help.c
+++ b/help.c
@@ -824,7 +824,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 			    SHA1_UNSAFE_BACKEND);
 #endif
 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
-		strbuf_addf(buf, "default-ref-format: %s\n",
+		strbuf_addf(buf, "default-ref-storage: %s\n",
 			    ref_storage_format_to_name(REF_STORAGE_FORMAT_DEFAULT));
 		strbuf_addf(buf, "default-hash: %s\n", hash_algos[GIT_HASH_DEFAULT].name);
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 26bd8c6822..24590ce908 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -668,7 +668,7 @@ test_expect_success 'default ref format' '
 		sane_unset GIT_DEFAULT_REF_FORMAT &&
 		git init refformat
 	) &&
-	git version --build-options | sed -ne "s/^default-ref-format: //p" >expect &&
+	git version --build-options | sed -ne "s/^default-ref-storage: //p" >expect &&
 	git -C refformat rev-parse --show-ref-storage >actual &&
 	test_cmp expect actual
 '

-- 
2.55.0.1007.g17ff1f9808.dirty

