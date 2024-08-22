Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3301617DFE8
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318268; cv=none; b=iqXRkN+sN99tj6SGYc0/C4V0/+v9D+srCwSsJTdV8BmzoimeHLRXdG/DxF9VJEg7p4lVX19rbkmALiYvQu6sn+ljXp6nWRUR1G/9tPfBSsCbrbmzqNIJdAW74ln3RHlrfORK182Zt8bpaTj2TXo0Of9ABaTh9K4WCstXca7/Uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318268; c=relaxed/simple;
	bh=frzfgQegaiMTWqYDcpcJFAN6SevmLupG95bK/iyYZMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiJisM2o9GmtAvlhKlAYHg83gRjQZ3IRUv4p45AHvqKpVuaZWLcXINy9TWP1p/axM06Y1cerktsqGurEr9XOx/hoYy6D+H/Dy3s0Zz3DPtV4l9YA3IPNn+eu9NHcLnDQi8laS+R5rbCMoqWpl7sT0JdHd0AvfPw2Op1z3cfFIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D/NL0iIF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6HyoH5N; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D/NL0iIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6HyoH5N"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7FB4F1390049;
	Thu, 22 Aug 2024 05:17:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 05:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318266; x=1724404666; bh=vXKoifygpu
	jg1nDhlKxsTPXskdygzLtZUauu5641c+8=; b=D/NL0iIFNXQn6nysYGv3jteEAJ
	M0ECifeq5ynzGSBKhjCMXE2Ig8KBzATGgmPheTEbE55H1k6ISJxNevlHYBcUGRcZ
	4AWietlQ7Xiz/D0EpWR4RXxy/+sp1h+81o/j6gVkqVRfjP6Noob68uHwVpNevWRU
	MqBG4DjF5erqW6slZijYdnYiOGED4OLc41lMqMthvuILgKXPofL0HtKtLCkG89CQ
	QdpyMFupPQv64dFXl5w/IGuL28fgcE2NeIebIQtAq/BQK/9FxLP/tmlxkmx9Azsu
	lAWPd89Pleh/VvkrMSfbpm/cLAne8YlDIZwrPxshowW7OeOw6Gg2HyFUN3nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318266; x=1724404666; bh=vXKoifygpujg1nDhlKxsTPXskdyg
	zLtZUauu5641c+8=; b=J6HyoH5NHQVdKjofH3FBd6ZPwICQHWNdX5kUXGMjAJPu
	e/15OG1uNrI4WEmvYeLIyqrEs/b1Hm4Sp/2OSanyUAV0NasA64SV+MrqECM3ROtK
	q1xOpXGjl8mm0tSMhdW65WEloaRqQn2GZp9Gdaa9nQJdtEbeRaQFuwT4xglcPglb
	kt48zWv9SAJsG7THCzQpuorMscjg4gZN1K0VJGPtgj1mcT31MfXQsC9uXjsWioVm
	dH1twT5D9jA7FtAHjytrlj8OwbBF/01MQZDoyzF+euDtvkPCjOXspHFzQv+BNe7b
	HfxHOrfvBS2o69G3BLZnUzAtslOIEQlu3gL/gs4ahA==
X-ME-Sender: <xms:OgLHZipsqn-YWE2SvyvjX-je9ws4ZG-dq-Zki1ZJypX9fhL80XXdow>
    <xme:OgLHZgrma-Par-i3c4V4fdYXsX4pSLiKpbYJkHEYOmNrNPpLPY6fWU2lOrjUYuVj4
    TZxTml3JuEdNeNYVA>
X-ME-Received: <xmr:OgLHZnNGNnrEyMfTyGZnocO4Ay0dWc5llwRDbrI0EfiPCp3uNGgf-4qM64Clpktmqo8R6zN7LFJgxmwr1Vh6Ix83OcUnjZ2-FosUCYTFXfyWrLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:OgLHZh69Tr2p7BXO0dcuyCyB0v8d09YPrkryvsGr5jP9HYPh_95Tgg>
    <xmx:OgLHZh4-W_BOinVhYOxk3Y_pZSomYWepqCXXbaWC2Uzy-3fQ0FGueA>
    <xmx:OgLHZhgDNxkioX51dLPbvq0hBUiJ8RAT2HoFwkh3I18yxhdGrlmelg>
    <xmx:OgLHZr5y8UWYbxxvJxj64UHrVUQ7mMlBTHhUL22puGtDF64TsIy-jw>
    <xmx:OgLHZhGxeADO6a4NKb6gJxqYCjWtzuR4TL4QH1ze1x2nTpnhmPOMyidD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 20ce2f54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:10 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/20] transport: fix leaking OID arrays in git://
 transport data
Message-ID: <0cb440ef6482a09c3b25435bb9f0e9b0088a7b29.1724315484.git.ps@pks.im>
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

The transport data for the "git://" protocol contains two OID arrays
that we never free, creating a memory leak. Plug them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5501-fetch-push-alternates.sh | 1 +
 t/t5519-push-alternates.sh       | 1 +
 transport.c                      | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 66f19a4ef2b..0c8668a1b8e 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -4,6 +4,7 @@ test_description='fetch/push involving alternates'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count_objects () {
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 20ba604dfde..72e97b15fab 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -5,6 +5,7 @@ test_description='push to a repository that borrows from elsewhere'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/transport.c b/transport.c
index 7c4af9f56f2..f0672fdc505 100644
--- a/transport.c
+++ b/transport.c
@@ -946,6 +946,8 @@ static int disconnect_git(struct transport *transport)
 	}
 
 	list_objects_filter_release(&data->options.filter_options);
+	oid_array_clear(&data->extra_have);
+	oid_array_clear(&data->shallow);
 	free(data);
 	return 0;
 }
-- 
2.46.0.164.g477ce5ccd6.dirty

