Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371214B959
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053685; cv=none; b=sCF4x04GHaCcGQUAeWuO3nB0JQcODfbMfYEI0Zh9IJr83ce8PSXHi200KmbluVrW5uObMFp6GzI3m6p0udIiJEn73kRyIzjmwjnSmz5fpn/nwxw5Pt7wJ2Y5B5N5bM9+HCmbqjKjiLUG55VgJTSI3RPoqftf0CPdjQFHjBYgrxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053685; c=relaxed/simple;
	bh=qNIcjvoC9TrFsmbVFtosMVuP0YxPoE2nI6D39GW8qJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYOdCu065QMNtM5K/Al67njKEKtXKg1IVOSq+hXX5eWvprjjG+1Azr4ZzG1mgkC52IhmjmIFph7PjuxWYkklGh9h15/ubv5HGBwkhnfZJNMTRfnjyEMz6mWgamLDlVO3BcGebxAVQOy6iWYsBrxzEj+NXaOzKLP2sODJcBx2Pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dcb5oSAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXFO4II6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dcb5oSAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXFO4II6"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2A561138FF5E;
	Mon, 19 Aug 2024 03:48:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Aug 2024 03:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724053683; x=1724140083; bh=J72QfK6UFm
	DdMiKbORGRia/Rorg7EwlLE4xRZVyXSBY=; b=dcb5oSANERiIvvP8ypsImD0Y1u
	cHQzhnMHi0BQtV/zWxoDX5XRqg5SsmuqEsV1dBLr111qESB2rq0tYxRFestyq+g1
	MDMISINbPUZN1QwSg51ojQpfGwDeGoa+nk90I3S3LNa0NqHm/eLYA9ZI2eB84+Fs
	MJ2Yigp838tspDmq48R7pxWHKpdCfYQMl5N604eVVuS6gzw1q+HpAkoRmjQwuZAh
	bxDLvIE2yvQyTGcAM7b1J3K4pNgQ++DKJr9e/ASBj4HX1ru8QwfNsCZzVfNU6pni
	syhjH3GwHoVa4crZ4LrbBP4Bh1Dxgo6OkE+LOia8deiASSn6dkjgOUDlj0eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724053683; x=1724140083; bh=J72QfK6UFmDdMiKbORGRia/Rorg7
	EwlLE4xRZVyXSBY=; b=MXFO4II6Yj4AmnxqA9MGxLLacHWjqhKtVwHntxyJnFey
	oXGBmKe4eI2fHbmAwki7Hn/HhMnsRQ2uddpATUoTnu6Lq9PLAslSeoN90/rGm8YG
	hjuYlZyDiq0DEzOHruz/5Z7VBPdK3lGR1mpBohtEeZefqYSF+7sgh8NinKHB92NL
	jyPmn54JJoEZOJXlhvQtYFXNg8pX2bgUgjNHoAu0KunU8zrmEZActOeqOCrMEnGi
	CSPXX/W56ZKvH6g7IAbWmgydTyYmTpMUwYlEC7evGye33WUnqEUbonoy2GqQf+BW
	Fm0nvlXQYyKYlnQAXTQin51vtlp5OfeTmGJbFAJwgg==
X-ME-Sender: <xms:s_jCZqCml97wUUiy-ppqaB5oFQM2nBDQSFlrFLH94kMsEePUnlht1w>
    <xme:s_jCZkjOu6ma4NEy0Mljnv2IyMXORJTTxxqDsBDAtKrjwN7YwjqIt4jv2mU8gOBhf
    jJjY5yk3wc9Z4HqoQ>
X-ME-Received: <xmr:s_jCZtncC5ItbIW6zDeRm5fUsARU5Ulllj8n9ASeN4Jho69KvoCGxK8jI6bsVusKHCeuSN9yRirfCp9IlaxyG4x0fEjis1j23PTpmD02N2uED4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeelueffgeegheevtdetkeeiffdttdehteekuedtkeeg
    iedtvdfhueevudelkeeghfenucffohhmrghinheplhhoohhsvgdqohgsjhgvtghtshdrrg
    huthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:s_jCZoxqZ-JQHKs4sSWh_dfpUNr6jqgwO96OAWM75aTVMyOV-ntuOQ>
    <xmx:s_jCZvTpFS11D6fF0O1F4W94-Q-HyWnNI7rD2d0WKC99aQx4245DCg>
    <xmx:s_jCZjZxXKjeRV3h8navOhTfw8eTaIYlVuF8wgXWqt6ilOaRpngAzA>
    <xmx:s_jCZoRJeGGzrFCcMOPr61wyHA9D69tCpoSovWCF47J1oaJ5VkAHrg>
    <xmx:s_jCZuHzu98TaOpw7ZQMmA_gmZKBTl42H9aj4Rw0iNvFVmdjE1qbBe0i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 03:48:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc95f052 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 07:47:32 +0000 (UTC)
Date: Mon, 19 Aug 2024 09:47:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t7900: fix flaky test due to leaking background job
Message-ID: <4805bb6f6c2c96a2c40d1d8359b63b8c7045e0b6.1724053639.git.ps@pks.im>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724053639.git.ps@pks.im>

One of the recently-added tests in t7900 exercises git-maintanance(1)
with the `--detach` flag, which causes it to perform maintenance in the
background. We do not wait for the backgrounded process to exit though,
which causes the process to leak outside of the test, leading to racy
behaviour.

Fix this by synchronizing with the process via a separate file
descriptor. This is the same workaround as we use in t6500, see the
function `run_and_wait_for_auto_gc ()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 06ab43cfb5..074eadcd1c 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -967,8 +967,13 @@ test_expect_success '--detach causes maintenance to run in background' '
 		git config set maintenance.loose-objects.auto 1 &&
 		git config set maintenance.incremental-repack.enabled true &&
 
-		git maintenance run --detach >out 2>&1 &&
-		test_must_be_empty out
+		# The extra file descriptor gets inherited to the child
+		# process, and by reading stdout we thus essentially wait for
+		# that descriptor to get closed, which indicates that the child
+		# is done, too.
+		output=$(git maintenance run --detach 2>&1 9>&1) &&
+		printf "%s" "$output" >output &&
+		test_must_be_empty output
 	)
 '
 
-- 
2.46.0.164.g477ce5ccd6.dirty

