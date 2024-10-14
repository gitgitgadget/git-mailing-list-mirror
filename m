Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC81A7056
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908505; cv=none; b=KvJe4dkOCbXE1RqEdFXf6hJRdQsUkB5DNVH7M3V8Q46/uGIyFzjD45NsY7swTKAw9yZJdtXd35nZgFU5b92hFIA5+S5XzZXFTyc7QldicPslcxsKIjBlJt8+SY5CzEvoSipUICMYgVm5s4V/+UGveXvES4CLowLbJCM3+PeEeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908505; c=relaxed/simple;
	bh=7qF58BLt+iICgHW+tFTbVgpiTxnRkJd++dU6o0JiNaI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2LVgcJTdGeETVeiwtt+FnRg0GcF9tIaFejLJ+aME2zzxWn8k13vQm9jMIkx5wpcZQOHTiWQG7snuYC5dJdYS4+Bhk9WyV6UXZW+07LNJU6Y/wQkRSJWNPQvN6AErckwvgTc2K1jZAIlIp7beGpeItPqSgVI1ce+6CcRTlxi4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HzaJK8xg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNFB6Obw; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HzaJK8xg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNFB6Obw"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05B8911401EE
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 08:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908503; x=1728994903; bh=frPNzSFShv
	Upg6kOQTiAPslU2HEDujTyZKdkJlbeRrU=; b=HzaJK8xgmzDD79J5c1gEo7rzkH
	xBlKWEcrftAoO4UIcRzqgkPOpomcWu1stgQeXik+U2x9k52eWQWdfnL/dQwiwqcR
	AUKaAQwxVmBPPVXtxtJlpi8LZsamVh+AwwOKIw41DsGcrFCDgAKc+xoo7dWEqFCg
	MyfUMWZ1ZBzpDTuq4bnQGEADPTFTNriJi+bdUR4SYXOuJUDAarqXQkfCCQa0shAB
	rDOGeVf3iVaU/wZ3g/1spYOTuMtalOGACu4az9FFqJt9JXvOO5BCQfF7SxiaV7B6
	wrZWDc/88BlpBtHKRgFGBKbsNmlrC8juJNXDtQo0Pw+sq+ZUh7YirdgdoWHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908503; x=1728994903; bh=frPNzSFShvUpg6kOQTiAPslU2HED
	ujTyZKdkJlbeRrU=; b=qNFB6ObwuuqUGoWBWPEbfitRyziMdTMFQ2/aVu6RJbao
	QAtUBPHvnx4lYDWQoTvV4fO9BokuC23j4/E97KQ/800SuKwohPpORyQ7oG6tHFj6
	OVi1TmMERXdMowqj5t50GlqqpoTQcnQgYA1UzkFDGF/MYlDcQeg9qJQysRnlv5py
	nrLebonXO1Ecy+nClljwgiSuXILrcuLAdsU66H6+jWuQL38hxRknVSfnFWoukyxY
	eihntQJP6edB1dwEIMq4SvGXNER34pzFL8Y+Stpt/pnZXjWunldyze0NbxsWJxxD
	2fjdz48egqiRpH58D7IyplLM2+wB4NOZtXtWeTthoQ==
X-ME-Sender: <xms:1gwNZ-J3Kp1ftwbqOTuZvDgURHvI1CgMrnNCetlhGuAAJZQMrqF14Q>
    <xme:1gwNZ2IzGNt_qF3xjCaD74twgly1Y-c26EHjUMLw7u-Tttb6gUC-wUAddylCDSEio
    Tpn8c_N-l-yHMes9g>
X-ME-Received: <xmr:1gwNZ-tEMFl0LOSZrNlQqxjsdqY4WVrCb4kxCOZsReC2PI4bG_l3TPmt-Qjv7EIOCEwhWXt1moXA6uHy_aaXHsO9_aMWSx1NmR-QH9haOMTnRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1gwNZzbm_-7Ra_VzQugH8gK5GVYJwarqxy7HE0SVOeWF6i9YCIunrA>
    <xmx:1gwNZ1ZN1fXFntPaOpE1P4ARGZoyekg-GtkaB-3w23BvE-fz299ORA>
    <xmx:1gwNZ_DNe689WLugZCbJkHAkl-c6MhewmnEwVAessZbVOD_WjL_bNg>
    <xmx:1gwNZ7bgmV7Dz7IecgoakRjhFqviL-n-LfldTSHrRrGkM6QALti-oA>
    <xmx:1gwNZ0xCHapfUzsOxsASpj9_TSc-ZiyC3_I5T5lOmcvktDubP6ZMhRc1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22e98d20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:28 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/10] http: fix build error on FreeBSD
Message-ID: <deb30e12a5861410b6c3b7385fe09599ddd0394b.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

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
2.47.0.dirty

