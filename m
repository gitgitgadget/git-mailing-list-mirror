Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E12127E7DD
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002482; cv=none; b=NpnQKRGq2M++EVe+84nDrSB8ZwQL22BY009iHfr18h3/Wbwl7aUrV4mLW7zBOXt4VI375xUYVsectmNpvfqxI1iHe8VcwhGbjyu8mDtIv1bSHhQ58QI6qC0g8z4MmiR+rzxVkHw5klYaraysuj89a7GZ4IF0mg7FYfkZJMC2xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002482; c=relaxed/simple;
	bh=y1lPZC9q2JLvokKGl2A+oeZIyryw9YbDORgnpqv+jLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJf/c96UcNaO5tGXsdJtNdeGTB/ZRV1pim3fIEUJc3jMFuHw+yar71AeoQQBtOHRVQ3hDfwoVbbfxw+tYK6GLPIhMMHxhIlXj6DmFf1ED33gTnoqVHsQmII8AF9XzntoDaYHfKMkOEg0JRvUmlBone38HTr5uY0f+bcRK+imxoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DPxJ/cYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRK87TiY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DPxJ/cYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRK87TiY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B14C9EC158A;
	Thu, 31 Jul 2025 18:54:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 18:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002478; x=
	1754088878; bh=BZfwfzHRMAoV+QgOnHnlMRhdEOi6PL/HvHFGrfYT5/8=; b=D
	PxJ/cYCjnDC4wlLNORLgTllMu9zvSLYeI2l4ukaJ2+xRmS3zyzzIfxNdQaLYnrU6
	ZEE/rAHxOQ1YMrHgLzmPDc6pxKgCw89Ek7xDXOVY5y4wCUKkCwNF/708MlYAKS7t
	h9io8S4hAUXr2CiFixmAeXOyPfUC4kAYxTixbIWnVCmk6p3kPsxj11//48ByKT21
	1VxENu4SRJ70i2ikN2oi2PsgpV3zJxqPGjcEYVnM8jZkxJ0IMEEAAx8jyQyAD8QU
	A1sKr+5m69BW8x1CrnHAikK57M73P7e6uvxV1EtO2G80nQWSLNomhnuSZcqgrT16
	KTzsqz8j3wWBMQ66O7Y8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002478; x=1754088878; bh=BZfwfzHRMAoV+QgOnHnlMRhdEOi6
	PL/HvHFGrfYT5/8=; b=YRK87TiYc+KUfXrbp5KkL7sSxTYmE7HAmtNWUOOga8wZ
	2OfcOMxa6FdCaIOTb78Qrwt+ipKW+cJw00gUbVcak5h0Fk/cvKC2Vo9HcSSwj6XC
	D8/cld4WQJhqUL7Dg7XsjZuog0QaPLp/XxZn+LGsxwmVdCAiJ0NYBKBx5SX8oij/
	4X1tE3aT2RFyGH5k9zuBJEZMHEzSCzV2ploi4Xjr/+RbetnVfN7GIfIfo4kdpVuF
	Mk3IuFkYi8Jh+nVBe74O7cHprhXFFvALnEAFkdVzYf4O606Yg6Rr+tXLUVDePb3E
	G9vgtjTYmIvB+sGHLwcNuyEAqJUPIpjgr1Ik76DvWA==
X-ME-Sender: <xms:LvSLaBmS9CiBsYx9R9qRoWtS37wNwOG-qzyS36Q53e8sJBUWamcaVA>
    <xme:LvSLaNCgubwW7o7LEPiqLoBnvrE3x5JBtMHSQ1uXQj0PgVQ3fj5cXGZOzqaJw_rIi
    d1r4nk_miwEBtSBVg>
X-ME-Received: <xmr:LvSLaJehHumbqg-ugS8GPDrgXxbRFCwfvn0rClXGzD67ktyAMsOzVUxeGUtwYIt1Jo_T6BtLr2rlt1_AMF16BLJsXs3BO_sLCh7bZlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:LvSLaAL1MppVcr6umccXtZigZUSszuCqFAd7AthNqR6Kodn9LPNvvg>
    <xmx:LvSLaEcJQqcazNgYJwGFKjsAdQzJBzRVXW1Tg6UJijDhgw-YqmhkAg>
    <xmx:LvSLaP1vfIbp1_7zC_pz8DtEOF4agnpO_AusZ8VrkPrrhdWPYMQOoQ>
    <xmx:LvSLaFj0pmTa1NjVIZaOubvVmMRz3UpA2qx57u-Kk4EDEYnZOhoLIw>
    <xmx:LvSLaEKOfcd4UCCjXwafdwEP2IVNYzH00D9vV4mDD2WwSRPjV5bQt57w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 02/11] clean: do not pass strbuf by value
Date: Thu, 31 Jul 2025 15:54:24 -0700
Message-ID: <20250731225433.4028872-3-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
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
2.50.1-618-g45d530d26b

