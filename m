Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2921C3BFC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345926; cv=none; b=pPH8i7VZoeCJorVFW63zzyOsjDEVq0PKC8lijGQCGo1vlcIj+UlyZ+Bixx3osbHYZVqblulPgfRjrJgW+S5VvFqBiwB73SlivmFjTCFpKEXkRnkBtSanKoBP5CbtbLkp50L7LOi9hsbc3H/0Li/9CRD3RLUpwN8F2EpTAcRS8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345926; c=relaxed/simple;
	bh=Ayj+3xXr/kY6q0jyj0I1BeLn75fk3tF6fethFCTq8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL3fZ/9ka0TyJIszAHejO02UrHdpoXjUs/HscaIrPNdvpMYB92W9nErgmBUAJbyo10zE9Lo0vXltJl5J40WxAbeVazwrQcjCScx6hNZehRPCw1fIC05eDC1kt7OqIkVJ+MMiqFjmeqn9UY54sQS4Ii+5fcGCkE5+rKy1gxASXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U7aHYRKc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myhfTT+C; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U7aHYRKc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myhfTT+C"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CF0EEC0216;
	Mon,  8 Sep 2025 11:38:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 11:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345924;
	 x=1757432324; bh=i5zLJlfE/W4OuLFvcGRbmqiuU/d6kyK1PdMGX3/1xvA=; b=
	U7aHYRKcqKqHLN0DnVh2cy9P/SVf0R/y+9ExEKJeX+iKOkGsT31iLEBuhP20OAy7
	/AwWCCSLPdAAIINlen1MQvGewxg5baPx9WXImLGTNTvxnOE9F/FtWv8uSSQN1Ng3
	gCHgB0j9O3juuXWSzR0nmx79qnXcGzH2WgZsmQ7lZSWcP43g+0v+kYlyh7xCBi+L
	F535PVnxSLq0m8lakCpsPMcdug254/dizc0aHnFyhoefYVA+XgsKJvIGK8diDcqw
	kTmQYVMJCbV1uu5xGa1QBno/3MwBRwpoe7UhHbwuoDzIApcymBnUx9yqSJbhd5fm
	s1hSfv6fVxj/E9GjNKWuPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345924; x=
	1757432324; bh=i5zLJlfE/W4OuLFvcGRbmqiuU/d6kyK1PdMGX3/1xvA=; b=m
	yhfTT+C/9iNE5/zAMeiLQJwDs/VvaxkVJSvUyhm9z2TNsP1equi5KCt25gwEpeuD
	6neVi2lGM6HCxiZkB+KGdn6H0qQXLmxcqJQCIolopgXWZdlJsdCsh57QDKkfx37q
	MnrtXh1Y9n1Zp4C6f+mEbLGIK1sQBYk7iOaVuE9Q/s7xCd6+XiPJ3n9+8JvPohVn
	61BSCuBh2K1LE9+zY0xR2JppYMt7Im7Da1ShS8r6UzP+xIQcT0IbwzH134z0cTmZ
	RE7Y6RJ9JL89VWQ8USBOwYhwMcMks2z647TBUxcMpXrmBmZrmNB6enQGUQ3r3L0u
	dspRIE5BK6fV9TyHmsGeQ==
X-ME-Sender: <xms:g_i-aCraTNjdiRZLnqmLsfxnLcEIyF_YGwIfenghKwRWh0CtMgJaoVo>
    <xme:g_i-aLOtXB0o8lE0SKC7-YEdjpoupM8dv1WwuCjhia5qqAsrPoHUr_59mz7qYRBeJ
    v9yBbMei_-DgeZd-Q>
X-ME-Received: <xmr:g_i-aDzVqPggVJoRp7K9QSZXAM6P-LVFPdMoZi6jK8ZBXC0UgDo0o2UTq-Iy3JZcBhgOVPCDTBMD10gWIesO0lp_6CM8adj8Y0sNeW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhephffggeelhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:g_i-aEvoB9gKTjqRhPCSDOmxqp9MpgDh962ethYH1tr3hSlweSnr9g>
    <xmx:g_i-aM6Xy5MC8zCLRFPpA5yvieteSwGGQJpGcAR3Bs3WzKHA30ktcA>
    <xmx:g_i-aDTK5fWWibZvuvhoZPZNULJ_ZoKx7VsQS8uvzpW3JvCk3eFLYA>
    <xmx:g_i-aLq2nsE3kZzGkhD4NorkwFKaq4ETfZzt60YtCrFboS6x4Oaglw>
    <xmx:hPi-aEZ0XJVUUZsDVNK4meZWroS4K668yiaak_o6Oh4pH1auPqUUDTz6>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:38:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 2/8] git: make the two loops look more symmetric
Date: Mon,  8 Sep 2025 17:36:13 +0200
Message-ID: <183dd68d09d7785b449f0c5295094690f7f35509.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Rewrite the original conditional here to match the new sibling loop
in structure.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    This is just a refactor commit to avoid having to add a “while at it”
    for such small tweaks for the new context.

 git.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 87d61f12594..39dc9f8ec0f 100644
--- a/git.c
+++ b/git.c
@@ -686,11 +686,9 @@ static void list_builtins(struct string_list *out, unsigned int include_option,
 			if (commands[i].option & include_option)
 				string_list_append(out, commands[i].cmd);
 	} else {
-		for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
-			if (commands[i].option & exclude_option)
-				continue;
-			string_list_append(out, commands[i].cmd);
-		}
+		for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
+			if (!(commands[i].option & exclude_option))
+				string_list_append(out, commands[i].cmd);
 	}
 }
 
-- 
2.51.0.16.gcd94ab5bf81

