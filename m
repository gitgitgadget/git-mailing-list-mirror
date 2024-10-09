Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5E19ABB4
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485804; cv=none; b=suc+my6yb5ddePn+VtVfXwO1qPmfRJzG6XOzIhEGs4QHfNP2e7daFuexbo9fwMyFs/hUWTmlPEkVuRALlbUiMa6pBXC9aPhoqvsIe0TNm4b3Oy8Z85UbPh052v+Yoyrhan0rnwTVnravYgm6yNcTl4p1XddpEU59AX5Yp4pzRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485804; c=relaxed/simple;
	bh=kNfiY0nZiQdr8/PQWWx8B/jOLPij4m/0of+73XP5QNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXb+6uBD5QwAZ2ezEYlUPEMFPNou5aNX2S0EZIBl6NPQmu2A6Ly1KmI2AL1Mp2n/09cq/phm0dc2D6MGyNr4zQhjRkSZj0WDuGxuLTVhnZbnRKWO4rJlp88rLzo9oNlWqPgN0n9wA8K752UKNPvvnM0SMbRzqkMAtNigagNCdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e8TagWIL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMDH92Zq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e8TagWIL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMDH92Zq"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CED821140170;
	Wed,  9 Oct 2024 10:56:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 10:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485801; x=1728572201; bh=Bogt4+iT0R
	BusDmJrhAyRYq1hr55jIYxp2MCUYsPP8s=; b=e8TagWILvah095e1e+5+WZ/oEE
	Cx9ih8gA0M6y8UfEAu/vtBOVoz8WDJ+P9BjxAXnrdYSoA6sssjCF1DHjljkopV1W
	rgsYE2jKtjU8kZSETw/ENoZ6TsL8W5NfftVZxehqgM9bzwW7J0DR3V1psj1sOO/b
	4W+JDv0EvsrO+4T9tLvvqCk3zEE/2aljwnQr1xe+G5AdaqT43gN3veJGBqb7BJhM
	ELE2LxoqJxT0AEOS5oQgAOs4DIfGfTCSXM88yltikGRUih+IcRjTXgnPRS/+O20w
	SRpjYvD9ShoMtkFQ45AE2kH8BhkYmfu6yudIfmutWS4KaR8Wf8RPcEZT3Kgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485801; x=1728572201; bh=Bogt4+iT0RBusDmJrhAyRYq1hr55
	jIYxp2MCUYsPP8s=; b=LMDH92ZqPYbQ/T9PlDw50v8cStwye5IfqI/kEWOZobRf
	EXp8QZKZCmP5VFkjygGl0D1EKhdNv7XrJ/LDCv8iX5OAnBbgxxw6ukE0dP6WWOq9
	iH58RN0eJJy8wOYcSTei9DpjnRDS5OCmRhLgYS3IIYsKCYkJDR1+Asws5H/fAY/M
	N9orIkrVM4BDCzJw4BeNmPqeygBJpOu/ALFrcyQcwkhDGmfmhChxqFy+QuZ1Tybh
	y65K79ui09E0iL573gv3d5PilHK9SjTswgp7D3iz9nq2JTJ0nVKXuW/dVik7lR5I
	MG8tTCCZ4SKb1iu3hY1J96/eKum73U1Yz3WphLusbA==
X-ME-Sender: <xms:qZkGZ4NeqS3jQdp7RpFccoj3E07sZSXe-li6wI_IzKcyXPMA3Fv2Pg>
    <xme:qZkGZ-8LwZ7rwc4NB2QqggINJsO6I8Toiam_CPo7r6e9oWjJZVITmVYSEKELH3ocR
    UkNfEh1iZ4iBh48Bw>
X-ME-Received: <xmr:qZkGZ_Qmn0ISdChF2M-utI6rJ0cej5H36aBT0y1GWN-VbGc2e7U2k5Pr1UQIqNuQM2ccLqbFR8h1EbqnE4lY_bhLNHKjK-VjXU4so17F0bS2Kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:qZkGZws6liBhB_UNjjJRfyDzn4BULt_BK1Dsf69f2LEXRa28sFHaaQ>
    <xmx:qZkGZwddhCBsbY1nv2WXI5oeyrcm7c6pS3fZtDjCHXNZj71Qh1x8Ew>
    <xmx:qZkGZ02CShm5F5k1Xh22v4f8h1cTAO6DT7C7TBoCX5AX60YTX-dXug>
    <xmx:qZkGZ086ZA17hQQjvMIAn7BOkN16yaQcu0AovohOVI6tbd94JiesWQ>
    <xmx:qZkGZ1F96V-NnswL_Mt5UcRQ2EVMl0YOHbn65_GIqyPc11aLst4MNW-1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4a60c0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:37 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 11/24] http: fix build error on FreeBSD
Message-ID: <e4ef4bdf1c562b6ab30a315fe46ff95d57bf7bd9.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

The `result` parameter passed to `http_request_reauth()` may either
point to a `struct strbuf` or a `FILE *`, where the `target` parameter
tells us which of either it actually is. To accommodate for both types
the pointer is a `void *`, which we then pass directly to functions
without doing a cast.

This is fine on most platforms, but it breaks on FreeBSD because
`fileno()` is implemented as a macro that tries to directly access the
`FILE *` structure.

Fix this issue by storing the `FILE *` in a local variable before we
pass it on to other functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/http.c b/http.c
index d59e59f66b1..72973175a85 100644
--- a/http.c
+++ b/http.c
@@ -2290,17 +2290,19 @@ static int http_request_reauth(const char *url,
 		case HTTP_REQUEST_STRBUF:
 			strbuf_reset(result);
 			break;
-		case HTTP_REQUEST_FILE:
-			if (fflush(result)) {
+		case HTTP_REQUEST_FILE: {
+			FILE *f = result;
+			if (fflush(f)) {
 				error_errno("unable to flush a file");
 				return HTTP_START_FAILED;
 			}
-			rewind(result);
-			if (ftruncate(fileno(result), 0) < 0) {
+			rewind(f);
+			if (ftruncate(fileno(f), 0) < 0) {
 				error_errno("unable to truncate a file");
 				return HTTP_START_FAILED;
 			}
 			break;
+		}
 		default:
 			BUG("Unknown http_request target");
 		}
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

