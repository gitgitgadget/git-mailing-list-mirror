Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428D39DBCA
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165184; cv=none; b=uzwQM15NpIx1qR2n+jcMfZiw7smZvgCM5AQ6fXB1pD+9tbS4maL6AUP5K0FuCu+XySSMhpdrFxuspXWI5a3gk0fB76XG9IbsV8735sxUjXPFcMaK+Nnf79/bXeuLFfcPjMbYaV+px1MTadSDWOt85ozaS4fTq+az9SrLJRMRaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165184; c=relaxed/simple;
	bh=JL93VwbP6GiU3A55SXP9jmlsdtwev20caCyvkftu6oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koMmWe2Kb5cqSs0wD9o/GuoGLiVBIgWA4iiAzJVyfPRAlg/hSLzIMvn6EkCPX2cTT+4poNgUvcXz1/qzCdHwDWiI4Xp/DBcX4ThX7V9/ILFlHVleb7LvT+nsbF2lbDPSMGsnExD2CWVQqZXJzTC7+YtXUzG2QqekQYJrnmDGkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZDtzLVHZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gATDjCAJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZDtzLVHZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gATDjCAJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E82314000B2
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Mar 2026 13:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165181;
	 x=1773251581; bh=5RfvrMt5QYcx/fQeMrdQKl2LVNr5ky/eSKxWx7LzFnE=; b=
	ZDtzLVHZ6L3KAe6xPH4D+DIhBxcC0ajOiYh7jiPG0H44ta6+ho5Fq3tOHMYl1BCK
	CIG/hRX6xhtp3SSmttOzrnPjyRep1/S6cfhoW2IQjPH/qnR09orMn/wDKtDUrhXe
	7bhpafPVWJ7k1gEvTBzMAiPuP1QB2BXtWJj3EThl0WUgMpSygFCjQihEZ+QUezBf
	4C4c+WR+cxZMVRASfswUt3AUCGQh4fb89jDG67mB39LVy/o6ql+AmfDx9bWtyhJh
	ETlGL+MQxBQzA9ddUQlHo1XB6b0KYCFYVdBKQ89IlQGNd/2aPk9Ciw5XHL588oeb
	jf2wHWRSstK3TGRMpFEtvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165181; x=
	1773251581; bh=5RfvrMt5QYcx/fQeMrdQKl2LVNr5ky/eSKxWx7LzFnE=; b=g
	ATDjCAJXT49qjogGX4YIiTqfqtkCGRNHRNGhz5Xqc54B1jox5ulv+7ludSAVj1zk
	xEjYsd8GX5fbZ94eteOtM9KsmBO49Znjp3ibYURRUP5zi0m0eUXz29ouGnjz9nQd
	m4vQV2+a6R8fNH20aNwqBwGjg8JPo5MiX+Yvz9Co6dwJA66HXtLjrwV0gg8tF7W5
	j39BV+cbQPDFdCIL7Cnw1SzjhCE3kpSDUZ+Mp5WPmgvCq4rVK59Vx+qfJvEIwgtl
	SDjuVtUHmPgDoNNgS0ie7QyW/66bCtGg+l67qN/5iGjoLh5ebw4I06838XaCuGQo
	TuFOkJV83nsC34uPieGMA==
X-ME-Sender: <xms:fVqwacnPC587amG0PIq4CjhEdCI_ATSyKKP_Nq7G3al87iNavZjsuQ>
    <xme:fVqwaSwjotY8RcWdEtjF4wFq1xlyelSmPjYrGDnAY_gj04WvKNxQRnGgQ288gAMqO
    fspyy-iU8A3ul0q4ocxirfCqJh116N3pbrOriVH6siBEvLLXUZh>
X-ME-Received: <xmr:fVqwaQTtVB8QaaLfqXMx36B0TAsBEXZdiyxeH53GFxgt8NpWRtL-Wbsi7Lfz7DXmP0ZIVmEmZKaZgnc99W4tyKAn_NW7xohKZzzRkpZK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:fVqwadsDQASdItvYCVxSnd3Mz03RCvwJB4_jVhNMpIaPpHxKD-1Sxw>
    <xmx:fVqwaatbwWsdzF4Q3kW7BOPDlZeKeWlIu2g9gj3GW3GtnkRHKdzMgw>
    <xmx:fVqwabyW_iaCDrrgzNQtn9zVw3QhE7tMY0SCqlTOjLEMaL4qXo38Cg>
    <xmx:fVqwaYgfImLbqhItIx1W9dGI3wK5SupDZCuuQCxLnkGFEmA-8ZWSAA>
    <xmx:fVqwaQ0AedWxXT9by9TuvtRSNyPbDMbpaahpz8lBm_dUuAlIQgaQnsNb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4eb53602 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:36 +0100
Subject: [PATCH 3/8] contrib: move "coverage-diff.sh" script into "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-3-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "coverage-diff.sh" script can be used to get information about test
coverage fro the Git codebase. It is thus rather specific to our build
and test infrastructure and part of the developer-facing tooling. The
fact that this script is part of "contrib/" is thus rather misleading
and a historic wart.

Promote the tool into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/coverage-diff.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/coverage-diff.sh b/tools/coverage-diff.sh
similarity index 100%
rename from contrib/coverage-diff.sh
rename to tools/coverage-diff.sh

-- 
2.53.0.880.g73c4285caa.dirty

