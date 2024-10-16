Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5891D1F4F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066405; cv=none; b=UseVMjoB4GNrPLNZLm0rCwK/3ek5f5DFP7hh+LZuTnMnoAj/Z7Hw2lcDSAcA83uLTx5k2CThwfZMtNFDHXDjUZd+dFDlQDhj5pNVEi94nRrA3jcWsj5FFn6EW8nECKOtnvbJ2HbcMiaWDAT/2PzWUFxwWo7kWfrKiDb0cpeycH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066405; c=relaxed/simple;
	bh=l3xYCrq9sa8N1wr7lgRlrBuA0pgklwmFnpVOuzSOvck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSrhq/6hAw9fGm30V5Gj269hs+dVFBHLKco2KLhT3B9vBvo1mG0uOijiK0FtAohfWS8+pRZM/tOwCctRUlwSFb/4Lael4iRfUW5Rh10tLz13aLPv8zBJEMHgIphhgsCwvs/g8T2m87+EwplKc986WxceObI660eE8MTnZ6HTd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FG+mbFrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4PJ9Wad; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FG+mbFrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4PJ9Wad"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0427613800F9;
	Wed, 16 Oct 2024 04:13:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 16 Oct 2024 04:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066402; x=1729152802; bh=UgXRcLeHVC
	4VVMna5Jzrkg9TsA9+N54tfntKt7NIIDs=; b=FG+mbFrgTKlrbbmQPmGguYt2R3
	6nWZ6S1+CIMZOSMHTyy8JjMKQVYZWqR0y+qUqETidrePUY7mtk+TvHzgjUjVn8XG
	0KQXGcw8flpzJh9Ml7KWpDrXDKw1y4PYfoQDtaGMX/JFENdog/i7mRdfHVsQ618O
	Zce+AKCNDSF6ddgNhd0Tx3tXK6GgZ93ZJ26FV4D9On/fKZ4CcFOXmcyRbujikyJ8
	bRTXZzF1M1rkDW0zd64lfF3LaQahN8ONoh0TIMJ50qc5uWgz0XDcEJ0vUwiNmMgm
	a5alSH3mx6WKcILR0ZXr33I6cUOVgnjwU87PUeF7nNTDuY1iU0+Q/Q3KTr+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066402; x=1729152802; bh=UgXRcLeHVC4VVMna5Jzrkg9TsA9+
	N54tfntKt7NIIDs=; b=l4PJ9WadnmV6VI4mgzTVn9K/7hbWPbfTHZwzPlTyqXqU
	mfZ6kEdK1vqRvk90ydE4jojdSokzjKpM71UG9gOzLtwUrnCBUi2FuW2jreEPIzdC
	/w9hBjki8jLhymXrODUclvKJddkCH1U/yvo9eZnIgKwOnUCYvPmvUNRXzxumTnNr
	8k/qEJgzy9/kv6n+Bf5ejo8ADBDVPkV+v6DU0pOS/Jadfg1y3SKewl8Rmf8YOf7Y
	NFvsIUSaZGs+SxXpE8z3dIsrH6tvCTlq/s0lnNiWORwTkSak+q0TlaipsiL2BFqf
	fjBjJJKmXsDJr0VmTtUJk9YS15nvq7sx83T2fFY+wA==
X-ME-Sender: <xms:onUPZ9W41NwNQZtLKKnegVwFzE2jRkiXEJpQSuIvcHpzN5f2Z8Q6Nw>
    <xme:onUPZ9ks9IbRkCr-M-mi_5Sh0HpnTaPio3mjkMNerouwiWGC6LIVQA3h2vynngNIC
    M7eSSFMAUCdS_U0hw>
X-ME-Received: <xmr:onUPZ5ZmrlO7yJMnJydvEj9si8WCh2QIPCD5cOzHsDeLVPdiOwAKqGTtZ4rH0BmU5x9URiNtVE6UzhNi6CIXKvtvsImKX2_-fNxCr2ITG7uE1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:onUPZwXelzyCvcjs85g2qy7kGww_q34nrV_Dzlys8fcWm-IwsvZh0Q>
    <xmx:onUPZ3nKAX2ovRYRlq7bRXaZfJk_PZS8SuHovEMjfNRxX7dQ2Bzjng>
    <xmx:onUPZ9eHHuyiizfXPb2t1TamFJxbmRaHqXtgGmUc66wwP-XSRQCiOA>
    <xmx:onUPZxGS3BVZB5JRzDMihJhxwU5jmtnqXXwrC38lQ8DQNLmdodBoIA>
    <xmx:onUPZ1hxCXdz6jgPjvuiaPJLmaAq8-QsjG2j8Eg7Y6p5n6_L-LgG_xsW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:13:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 635e1675 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:12:05 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:13:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 10/10] http: fix build error on FreeBSD
Message-ID: <c22a94bab4173cdf4d703b4b903b698223f7eae7.1729060405.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <cover.1729060405.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729060405.git.ps@pks.im>

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
2.47.0.72.gef8ce8f3d4.dirty

