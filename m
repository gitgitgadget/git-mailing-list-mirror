Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96265184532
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318296; cv=none; b=owNQDA77GqRb9d0JS6IOpO0gnFKSQmvxJXb27zM+3RFY3pkjj2Ls2/wsuP563isqUGuphQgc4eLhsSgCXCEbsVXp4jav/TOdscY9YTEOnqEtmWjenzVPjKCBskWKGwrcBPJiVG0ccd7fAK2jGa2XzArWuMfHqSfbALhZp9KuKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318296; c=relaxed/simple;
	bh=zwg0kB4Rcsb8XD2nW8KQ2yJ+gZvuwV/Z3iVedjkkw2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9VclsmUo5SrcROzmbzj7UCjUed/MQLlwew/23ZT0kHAN4MDzzJxFTBwkXKnkZvHtMIPtfftJm3gVVr44Vn0e0DUDSovqcnSuEF8ZkNw1WLb7m8Bm/Ovd4F+zwqZkTUkD1j3hvynSQl7QJ47ic+DDdDrjx9x+XUS31ZgXLmqtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nnS+AQCy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLOWr/sd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nnS+AQCy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLOWr/sd"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E52221151BA8;
	Thu, 22 Aug 2024 05:18:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 05:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318293; x=1724404693; bh=Fx58xHcaAV
	XHT+2XgotGrdn2miPfx3kVxV8MC6HNayM=; b=nnS+AQCyOmpU3ElFQOweEEoIBv
	xpDGUoEsWLl95dXMGyouw3X7Ol6IP4hhdw8cl1dZBpPPl6vqm7KwBClqYUCMN5l2
	bwSVpV50mLFyEnwUm/8wIFht7VpsijBkBDvbXdArfqN7eETu97sdYUJo10coZN80
	DqvmgRLVH+sLS2hj4XcvGOBPDniyctwuLfVOiXxhACISZhsiDAtm6QucKPpQN3S9
	O7N8mB1guToaYx0BEK2IAOKYOdkREGW6o5eHjwaI6927Jg23sz7FIl1tv17jq/ez
	FUWX6nwvp5PwZC26NHqRqZv+LOor9+/ZfRhc9Hr250YJiFpMmNDvC1INA1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318293; x=1724404693; bh=Fx58xHcaAVXHT+2XgotGrdn2miPf
	x3kVxV8MC6HNayM=; b=PLOWr/sdSH6gJhglZDH1tQyhtBggUUdhg8pPuCRnJKB7
	pEh0w9yHRBHCD9nHGQz9oXyv7Pl3EU/qF2pb7x9NjY8BMmwJWBxN7ziOalsK3yRu
	XclJ6QDcmMMoad5KyhNFJY9EydYyIX9wMRd1+6fDlX9tosC682NPaxFWpdwc/My9
	1W379VOFxod5wiGaesMiTn6NCWBooAW0HMkeq7T9OYj7TVRy56RuQHZN9XcBde2J
	GGSHEAVFA7RN+L4Obvn/exT30iU+Pdk5azNHkhhWq2O+biMuxVBDlzk4sl1DA6+M
	XzQQJgqpHNxYLbyB8pQlOIkNPjME/RGHk7+YOh8neQ==
X-ME-Sender: <xms:VQLHZrCnL_px98NhhwyFS6NgxPFjoD7SDaGrQH4GAUqo66KAwLdjaA>
    <xme:VQLHZhiiKNUAadVt5_ytldi5VckBG7Do7BeBTflhkhFVDXBq8E37GGHPs3DZW3xYB
    hHrOVKragG-J8kSXg>
X-ME-Received: <xmr:VQLHZmnsbnlGvRmBGDUBHDWF9djyCrk3HlNMrR04_hnVtdlpjeYfXXS8kTHlLuR47R58ZU_gNjO1an8uYfCFGupYOCWivHhWwbq5OLlA8EmETL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:VQLHZtxqUKAn18qvM5PyOLuJrqNXAmvoqQ0YYqKXfeKOe_LBT0JFbw>
    <xmx:VQLHZgTsUgk10bAHlqlzLg1Z710GVW437tuL4I8uxbGY4VzeEuZF1g>
    <xmx:VQLHZgay8ASbxrMHXggERL5DNNy9hfZHwalGfdJesrXwI3bNPtPUzQ>
    <xmx:VQLHZhTCkh7bnijtRBPfi15_HXwHI9jZtIRXUouA6xv5ZgCJ2pnfGg>
    <xmx:VQLHZrf1pQmSNXQpKg0B86qDQYTc14e-U_QkFAefFX05mXuvm2VTF6JS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:18:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6570c4c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:38 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:18:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/20] transport: fix leaking negotiation tips
Message-ID: <c3d2b035761fa8a14df4d128375a24bf5821da9d.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

We do not free negotiation tips in the transport's smart options. Fix
this by freeing them on disconnect.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh | 1 +
 transport.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 3b3991ab867..0890b9f61c5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,6 +5,7 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/transport.c b/transport.c
index da639d3bff0..0f20fc56e40 100644
--- a/transport.c
+++ b/transport.c
@@ -947,6 +947,10 @@ static int disconnect_git(struct transport *transport)
 		finish_connect(data->conn);
 	}
 
+	if (data->options.negotiation_tips) {
+		oid_array_clear(data->options.negotiation_tips);
+		free(data->options.negotiation_tips);
+	}
 	list_objects_filter_release(&data->options.filter_options);
 	oid_array_clear(&data->extra_have);
 	oid_array_clear(&data->shallow);
-- 
2.46.0.164.g477ce5ccd6.dirty

