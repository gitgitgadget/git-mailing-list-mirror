Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D9351C0F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419686; cv=none; b=EGlBBT8ALseZA2ap6JyqztVyDgqkvvFrvI2rkZ9VlsU7D2LPppgr0FlD6iKF2zPLFfsCMj8Uya0zR5S4yapFp5XRgoQsvsK1IvoSu3yiGXIJwGldK1zrlI3dAU1RyTpM4a5xQmbaL9+nrQEhBMuSJ4yktXSxwGgQQPI7PvI454k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419686; c=relaxed/simple;
	bh=ZaLYlnziTjXMdqAqSMt3rugapGiaJXPQ4U/reUfjY9o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMcbfDA7oajC8EbKLW8K4LllLcklA//is4T1RysCXStA/sd+be0xxGdRrcjXuNfDG0NApuvj3vg7W4ewQsgGhSizslAAa1zDQ/iO1FhZ6dZS6I8/Bjj5AqVLpYUpEUkK63aY4UgoUvP+xB0hk76lUxq7BGfjUojHMG2ZRWKHXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j84ytTnl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHpimvl1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j84ytTnl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHpimvl1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 314391D0017D;
	Wed, 25 Mar 2026 02:21:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Mar 2026 02:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419685; x=
	1774506085; bh=sLmLd+Pgsih3wbnmZ7kS6QxRrbG5dNX6gsxMtCXkJ48=; b=j
	84ytTnllD403tpp+koFNCKZE2J15Ej32TM1hiDuWCbcAgswjkaAnSF5eBKE5a55l
	7HSS7sVQ4CfEUPd37iItWaG2PDsnE4V/hsjv6b4IiXt9iYhuMwgiY6EnYK+AJUpk
	LPy/TRQ1cikXzIaiaG1v3aAZln2JAI208bOY6Af1GVe9dCVS7EYGthEIkYFE2Fg4
	iI4exnWs/y6RyRk/NQmFrLSTe/8EMkrQOgIMjizGEFWZS8+ACD5bVRMzpUqhQ+tT
	J80ekZF6EJKxRz2Dk/GWq/GagfuUCJhRDWMf7TBvDFX3r17JeJ43kZM5ls22YxC5
	WZaPb0JZ6rWBwH1JSBK8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419685; x=1774506085; bh=sLmLd+Pgsih3wbnmZ7kS6QxRrbG5
	dNX6gsxMtCXkJ48=; b=FHpimvl1UG46eLb1EsTuHEmpPbm/CwIS51trlBBQ+ITt
	pz3ngyQXW3KoCd3ZijiLb4ZCXEE92G6Gqj3Np7/0W4OWFVC5/7bVJI8woWTpDyjz
	Si1Td6vRBBjBxckDtGeb3CXUq2ZHQN0MiA/PvFRjolsrvWWucJZL5XC+5lUTO2MH
	THUDU8zej5MnpSMXIPfq/sim8vOKwqa9IEvI41kxS+wbyvoEZ4Wv998252c0lrvV
	bV/23tJ42GYQSrfDvDsNuG0wNFOF1TeCrG/VpF+K/iec7frCogf92fUdw3/JCLEE
	4QJmo6BO3fRtNNJAe3Zn1XVKxucc5zlOL1M/05YIIw==
X-ME-Sender: <xms:5H7DaSrW6xggjWsLdW5ZHIowKw0CGveu7MAUnKt37EvlWcwDhfZFlA>
    <xme:5H7DaWqLHzKirA5LZJn4rAURF6Njb_i8UDE34B84Yh5Ip5xp6sOfPJgrhvANCVKrX
    WvGmBE-zZB5WlebfGJIAfgECl9CeH4QKRppcMEKzlfoilf3sducrA>
X-ME-Received: <xmr:5H7DaU2OsFRIRQ1Yhm80rj7nYbF0yF-0LhABOb5SGch_JDuNBMVs6abB5mOn1vYn9iAzbK62zFLH1Q9zfzKZwsrADt4VCLrS1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:5H7DadAN3MveUs-cXmU2sy3_vWuHGaEsoIZQ-qY0FZLJNQU9g0AsVQ>
    <xmx:5X7DaUc_oYZwFo2VXm32GOOaEdGeANIH5DPtM540S2B7rMxj5LJjxA>
    <xmx:5X7DaaimjbZ2lWSpWp50BhOuC8DadZ0necgK_57VuBCbh5bqEyLLuw>
    <xmx:5X7DaUqYfyxEfyhcQEcLAq5x95xxwuLV-GdrbF7N6EiFzFCTUXvUXw>
    <xmx:5X7DaWBByQrcU9WCYvszY9xJnWtErdU4QZ4RWoD5PSlh7CGdV6WVfVxL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 05/11] t7450: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:08 -0700
Message-ID: <20260325062114.2067946-6-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

Often we write "A && test_expect_success ..." and want it to mean
"If and only if A holds true, this needs to be tested", but under
"set -e", this will cause failure when A does not hold true.  We
need to write "!A || test_expect_success ..." if we want to run the
test conditionally.

Or write it properly with if/then/fi, perhaps like:

	if ! A
	then
		test_expect_success ...
	fi

Make sure we do not fail unnecessarily under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7450-bad-git-dotfiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index f512eed278..047e4085d7 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -220,7 +220,7 @@ check_dotx_symlink () {
 		)
 	'
 
-	test -n "$refuse_index" &&
+	test -z "$refuse_index" ||
 	test_expect_success "refuse to load symlinked $name into index ($type)" '
 		test_must_fail \
 			git -C $dir \
-- 
2.53.0-886-g529cbd14ff

