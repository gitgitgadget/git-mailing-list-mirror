Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90F281526
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203993; cv=none; b=HXtmnbuQkC51XrOLw0xZmSTjvE0lZYXxoswNh2ff+UAIhffERGVvTnWIBl4bO9GLv/ocyIrMgmkPSrzfmJJ86vmLcHevRU2xq9y8zeA1XfTYQKyYDxKrfSV0zn8fDTByHZjG45jlFS0eZeXoZ2x2xIycugR7nk6MQK17z8Un1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203993; c=relaxed/simple;
	bh=ToOWadr+xltucKoXGj0cRxc/AVjx7MGhMzXZGjUPXfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kid/9K506DnWX8WIIu7JWTJeI8zn9EjIBKKA+5mkiW+AgPRbLTTVxLN7mIdknndKOTRtp4OveBy+8zVM6mOUxlbLoN7OZ7VWpCp1gR00qpMW3j9iDLvc0rcRRcLOKo6qr8fAhi6qbsCm+zfs0hRhpDgmbwJ9/tr9NkWlDa0uO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NQKl8XKC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UBkG6RSU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQKl8XKC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UBkG6RSU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4BD81400350;
	Sun,  3 Aug 2025 02:53:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 02:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203990; x=
	1754290390; bh=xW3JXc00ryvlVuJscPH41U/D8Na6R6Cza98VJetyGYo=; b=N
	QKl8XKCUbaIHMNEEwmL2AQWzfs4A3ylnokUhuMgiR4FYyu5C9QOFVrzcQ6tcr3GQ
	lo1QFUM08Sps182ct+meJ59FAMsFadKm0kHFjcSd18zzld8VliT36n1v2M/S4tMI
	R3rjxbkiDOb06SR9FJVg1eO9tFDs2kwoycfqzVpGHrdIhfk/zoBr6+antiEQMCs9
	KLLprSDhwhm81WNTl49+PAhn60GD7x0Q6r8XRQsl5GjP8IChR7f/MFnid6Th8TRK
	A9cFRR6DkL8F35RSBBd2sDfzI0duYJJfyUJUWOq7ZdQH4h4ffYgHViCOnUvHicQ6
	J5ELZ7UH59Z5tf6yV3b9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203990; x=1754290390; bh=xW3JXc00ryvlVuJscPH41U/D8Na6
	R6Cza98VJetyGYo=; b=UBkG6RSURYMeKkMuPjYrhdsrRk2OiC6ArRheerp/KhKR
	oJ2J5nk+ivGJOFCe50uFrUkznstlGYCWPAHPOlmv2CJqKQyddU+WDq27wXt848EW
	VNnrvGxZz4QCZWQ5+ctW+oSdQARxCV7W2DRV496Z4Y9F0TZWGznqdGPVfZcsaLHI
	UZRMeJZKj5rHAsMMqed6/tJns0kRpRshJClU7bCoGALim8lE6RofxL4ojM/Uwg0E
	O/55UquxsS/xp3DzmrpFAyVERDDpD6v1DtgnFjJcDLafUnsCl/uriJr6JsEncivz
	4OJnXrdBPsJjiCI0hLo1m8TpT9EF/sDNqcp4AG5fnQ==
X-ME-Sender: <xms:VgePaIHJFldhd3Cczy_b4XGGYm6Ss1msOHqsO1x6O304VxyRNx8s4g>
    <xme:VgePaBio8mJogh2m7l6kUmlvS_u_ot-okt7MNWLHEuv0kdiTN8qVWWJDTfEf9cPFU
    5fdhu4x78J1X90DFw>
X-ME-Received: <xmr:VgePaD9rURJ-swmQPdHlrCzB7aIgQP6jqVyb4lPmzc2YTpUM6YwomNVcsxS9omXQTK7pPwe5gjREU4hc4fgmXFFAWY5EMM1F9lF6W1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:VgePaIrB31xc4awdtuk08QgQ2GTQKlxzv4abEl3E6kg_AtRCYxuvXg>
    <xmx:VgePaC9P90dZxa4YYUBU8B2AnQde0U_CcTfc_3wOfR_X3ULbaa88yA>
    <xmx:VgePaMWjWXJMgyh4QOKxzFsvSvvJ9U9aICldLfMCGp6AscCM7xKmow>
    <xmx:VgePaICwu7rMaCNrls8L1lxCmdzxzTpOd3iVjtcxpNOa7TNDZ0zGTg>
    <xmx:VgePaKqZVw6w_It3Kger9gmDQTIJHt7IXC2SEwr8ZJvME_NgfyQki3e2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 04/12] clean: do not pass the whole structure when it is not necessary
Date: Sat,  2 Aug 2025 23:52:56 -0700
Message-ID: <20250803065304.3325286-5-gitster@pobox.com>
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

The callee parse_choice() only needs to access a NUL-terminated
string; instead of insisting to take a pointer to a strbuf, just
take a pointer to a character array.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 708cd9344c..9bb920e7fd 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -477,7 +477,7 @@ static int find_unique(const char *choice, struct menu_stuff *menu_stuff)
  */
 static int parse_choice(struct menu_stuff *menu_stuff,
 			int is_single,
-			struct strbuf *input,
+			char *input,
 			int **chosen)
 {
 	struct string_list choice = STRING_LIST_INIT_NODUP;
@@ -485,7 +485,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 	int nr = 0;
 	int i;
 
-	string_list_split_in_place_f(&choice, input->buf,
+	string_list_split_in_place_f(&choice, input,
 				     is_single ? "\n" : ", ", -1,
 				     STRING_LIST_SPLIT_TRIM);
 
@@ -626,7 +626,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 
 		nr = parse_choice(stuff,
 				  opts->flags & MENU_OPTS_SINGLETON,
-				  &choice,
+				  choice.buf,
 				  &chosen);
 
 		if (opts->flags & MENU_OPTS_SINGLETON) {
-- 
2.50.1-633-g69dfdd50af

