Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512125A659
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203990; cv=none; b=Nx/8m/z+mS6M7DVzUCXsrSK1R/tVhWBbiWrtXS3UFdo4tS6Ad+cGPETCchZ0qLYLxxFAAeghuk8p0eLiCuCM45C6QmrGgbOEy+qVlKJlOz3ahrjoeEeYEgsmr790x8uIEUdPqyv3349H70sLt6lz9BlIBY7FyEe9OzEYmkrAuSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203990; c=relaxed/simple;
	bh=m7SJBLJK7Oo6ckRji5jWL+vsx4zsdX0DKCZiAkBGH9M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfVo78Js6aQBXKbktJotN/WCrb6Ckv5dDtJV66jZbk24jone5vejTWslJEW6O94KUDbhZlJ0qT+IrsjmVr3HJsUOsn/iTv5evJ531gWjIIueE5wh4Kcib9j+sQOqc8Z8+fyPI1DoOTi2bqGPeQFFD6CsDnUzZLp8LCpN1wdyrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W/ajOCIj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2Xr+tRK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W/ajOCIj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2Xr+tRK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 39957EC1275;
	Sun,  3 Aug 2025 02:53:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 03 Aug 2025 02:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203988; x=
	1754290388; bh=sy8XF6OGq0e2GXFijw4jUrWHLCO8vw8Ca21sFbMkVcE=; b=W
	/ajOCIj53dEQxQQa0QLDwPpppp8l0s/9eZpsCSPD9+3STDfcUNmUOoT8Cglncqd/
	pK83P1T3qKSL1bCeIJjUe+mWLwGemL9dW/v0kYFzLYPS/0to9vYN60JSam9MR3nN
	Pi1xvyAnTgl/ScbHD9qNLdcVpScF+q+JFeL6Vb5J5+x/KO+KDZ77ik0SK2w4bUUN
	gW07uvqht/ZJYS1D4OhqL65oeXpzTVGsQ35oMFYsJL18Jnfs7mZlMr4b4bRvmMVF
	eZF8tg7FX6rSXjmHexmV1uzKqBNKf4O58P/lnq/xuH1NIPJvFa0SdUbQlBt/vdbq
	enED3u/NE5eHDqvZDXMqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203988; x=1754290388; bh=sy8XF6OGq0e2GXFijw4jUrWHLCO8
	vw8Ca21sFbMkVcE=; b=k2Xr+tRK4JcCLiOkTvGpU+YZx/GNN7QW3Q4CICJqz6Yx
	PTBw2/yPzSgm+rJwtirvBmxtMPfkOioreUy59r8vjXA2iPKVLIiY/cHqzqamtX1Q
	W2aGsggeR7boaJwlO+17aqfKYXdRFnn2VqAiYCf9ig76owZxmRQOHEY0vHAzvo/t
	R2t9na8pTF3qWr6bGfDzoKU7kOc7FW0Dye1meJTU7SjX/c3EnCo7uhS2gCZkC6ON
	jgYRuoWQlS/cfr9ntS6tc/8ILHSA2zZQId4pKLyULxsTlOT2046KnpgEVYQtTApU
	weXWe1MJu/9jif8pEk/IjrfUjBa0E5rOYzO98+Wxlw==
X-ME-Sender: <xms:VAePaPx-12YpeK_v-O1PVU2XYXGh_960CKea8aYkMDeLVgKCK9jVMA>
    <xme:VAePaHdvcDLRm5exrqdVpcPw9JPO9RznRXnaRTjDcn-qniHiv0_nVHBUPt7ya4bkG
    aNWGA2xN6ltAWSG9A>
X-ME-Received: <xmr:VAePaLKokpnElQzbpXdPEKQsFZY6mAnimyApvNai2DCLU8Y5nx9X0Txty7MKM7FoMp2-08DuGwLJ5_YFyWWrXlrqtRRBgTca9WWNLZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:VAePaIE94PA_27EOhcp6KSX8djEcx34CjE__k32tfAa-RGA_H_tIeA>
    <xmx:VAePaFoBQDUShKx6pw2YgRWjf9W53h6ToS01t_TKPazq3jGsA6rIvQ>
    <xmx:VAePaBQiBFTIeV8uwBJmSxrnjH5-z93XEVfOWvkECbUZxgGhl4XCRQ>
    <xmx:VAePaCNyovCo2YrblxZrPcMKTunwUSsrYnQN0CXcomMajBz42S_KIg>
    <xmx:VAePaKWofx0L0RMoTZyjcsyWx5MNC4fl1Nv_Hy4K1Yku36uWeEPuqNNm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 02/12] clean: do not pass strbuf by value
Date: Sat,  2 Aug 2025 23:52:54 -0700
Message-ID: <20250803065304.3325286-3-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you pass a structure by value, the callee can modify the
contents of the structure that was passed in without having to worry
about changing the structure the caller has.  Passing structure by
value sometimes (but not very often) can be a valid way to give
callee a temporary variable it can freely modify.

But not a structure with members that are pointers, like a strbuf.

builtin/clean.c:list_and_choose() reads a line interactively from
the user, and passes the line (in a strbuf) to parse_choice() by
value, which then munges by replacing ',' with ' ' (to accept both
comma and space separated list of choices).  But because the strbuf
passed by value still shares the underlying character array buf[],
this ends up munging the caller's strbuf contents.

This is a catastrophe waiting to happen.  If the callee causes the
strbuf to be reallocated, the buf[] the caller has will become
dangling, and when the caller does strbuf_release(), it would result
in double-free.

Stop calling the function with misleading call-by-value with strbuf.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 053c94fc6b..224551537e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -477,7 +477,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
  */
 static int parse_choice(struct menu_stuff *menu_stuff,
 			int is_single,
-			struct strbuf input,
+			struct strbuf *input,
 			int **chosen)
 {
 	struct strbuf **choice_list, **ptr;
@@ -485,14 +485,14 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 	int i;
 
 	if (is_single) {
-		choice_list = strbuf_split_max(&input, '\n', 0);
+		choice_list = strbuf_split_max(input, '\n', 0);
 	} else {
-		char *p = input.buf;
+		char *p = input->buf;
 		do {
 			if (*p == ',')
 				*p = ' ';
 		} while (*p++);
-		choice_list = strbuf_split_max(&input, ' ', 0);
+		choice_list = strbuf_split_max(input, ' ', 0);
 	}
 
 	for (ptr = choice_list; *ptr; ptr++) {
@@ -630,7 +630,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 
 		nr = parse_choice(stuff,
 				  opts->flags & MENU_OPTS_SINGLETON,
-				  choice,
+				  &choice,
 				  &chosen);
 
 		if (opts->flags & MENU_OPTS_SINGLETON) {
-- 
2.50.1-633-g69dfdd50af

