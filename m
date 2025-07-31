Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE782857C9
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943997; cv=none; b=XdpfZfuGTtsEdZ9STAoWXIwt2yR5Qw1nh26q7yfiE9DkgYN9vfE6ScsimAxx2wRR6hwAFhs+oogpg+ZtX5OfoI4TYeMiqSn8MfQDVMeJj/O8Zz3wYDCg9KYihVldKvHWmrGDv66QsCMsF/pVvHM9MMTxmkKzlJPhFW/z3SQghQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943997; c=relaxed/simple;
	bh=vZ1qUsghaQ2amdQfSviVWGhMYprqMPqpTDO1jlmKwbg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1pPS804ozqbY84+Gv83jUkSBX5ni3OFkDeM97Gzu4Vu54L4zpaNsaeNt3hWsoMwWHY0RFyfCR4ss4zEQjfv7YW97Ar572XY6RdU7nQJI71AOrAmn1O2+BhetOOevi4ZxXJtwV4j2h1+8kfJrd9SvEQN1Rm6xywgWtOj72PKixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y5SwgICK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jg67Jk9U; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y5SwgICK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jg67Jk9U"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87F617A100D;
	Thu, 31 Jul 2025 02:39:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 02:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753943993; x=
	1754030393; bh=CMPXOnpQHw+8l3u572yTauBQVhVTU7x+dpfTfesc6Fc=; b=Y
	5SwgICK0MnX88qjwAI2kGeWNxDAv1R8h0FMsgsb8h9Jp3rftd529boPk+aL+P6VO
	xyd3EyYLrcX4anFJ7nm5qVUM1dSGWhNXLTZZSdL96rv6D1KSPK1sQfpN/CiB6aVX
	GqLNi+yLXDgkV+G/rftPw+BxLbYIjV5tVDbQ7tikPlFL2FOvrLEHnYTIC9cXEXk3
	5S/AG70GN9inpDyvT65g3vwPNFSUfRK0+ajwvp1YHbk+pUZD0P/8EntRn/MBJ9lD
	udus4B+6TOGAQyTYmkn61dcnB7ZKqTI6kkkvz9vvCAikW0LXSbSe0ZblWsFiW371
	KM9y1eKpC2xLvxxRSIsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753943993; x=1754030393; bh=CMPXOnpQHw+8l3u572yTauBQVhVT
	U7x+dpfTfesc6Fc=; b=Jg67Jk9UZ2J9FgITVY/MVAO/NE68b2/IOqIAAIo3AmPM
	2qMsMp+eYN+0GV0xTfbfqKbRQVyn9wVS6s52i1mtxE8pUaF8nIK9XXU/iJlzKSLZ
	SAL73LKuwrYd4mLwpnubvwCACABv4ZwtgodpIrJI0Q/iCy6HK6DHbPWhM/8qP8q7
	6U+BqRb1HR3xPE+X5Z1wKmObyteG+UQYgGvfV7jpfSJi38E2lWfJUOl0lanefDz8
	j/PaEhqnazllju/dGvc0Vj0bl/px5BeJrpicSEsRVJOVgaC+mYYzHBfbYJUdDvy0
	JahXqmEmJpyMTlBLBYDfLEfzciyqx4jYZZ/1fxfZTg==
X-ME-Sender: <xms:uQ-LaNd97jiconVsDHIuqBpty8TzuI_yGC-3RLp0X_lVrv4jVYbb9w>
    <xme:uQ-LaLa0FysKMQkvQPiPxrFXPHVaKfWmtBIdaFhZqCS4PKRvdPI3AJQdFpvScnodj
    MQYfYi0PWlSpx-K9g>
X-ME-Received: <xmr:uQ-LaIW-FTmzxoxX1lLRzGvbBOR0jzwgmignfGfXQQe_hiyN3mMRtj7H6_SCdSffMtl20jn_No5HTrwpe1OemqSKAk2uSH84Owzv6Mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:uQ-LaFga0LnMcmRC4eLxFtguFgx7p_OyyhDxhYBpDrCitOl2uB1PPQ>
    <xmx:uQ-LaOUy_kt6CWUxwVay6O0qOzhGJD4lTlPFg9X7actZa2z5WKes9Q>
    <xmx:uQ-LaEMcphm_qam73LHJ3u_OwHU8xwSHuqfvSAA_Za2EvRfDg5RA4Q>
    <xmx:uQ-LaCYytAIRVeyJBJJ6DS9bEsJdJ0WH15CbC7gQ0prMoeQc1sQjpg>
    <xmx:uQ-LaAAxvoUy7FXFIUyiKUqpI5lPjEjH07N0dZdX4ikpviJf45BSbj6J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:39:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/5] string-list: report programming error with BUG
Date: Wed, 30 Jul 2025 23:39:45 -0700
Message-ID: <20250731063949.1601669-2-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731063949.1601669-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a string list that has .strdup_strings bit unset to
string_list_split(), orone that has .strdup_strings bit set to
string_list_split_in_place(), is a programmer error.  Do not use
die() to abort the execution.  Use BUG() instead.

As a developer-facing message, the message string itself should
be a lot more concise, but let's keep the original one for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 53faaa8420..0cb920e9b0 100644
--- a/string-list.c
+++ b/string-list.c
@@ -283,7 +283,7 @@ int string_list_split(struct string_list *list, const char *string,
 	const char *p = string, *end;
 
 	if (!list->strdup_strings)
-		die("internal error in string_list_split(): "
+		BUG("internal error in string_list_split(): "
 		    "list->strdup_strings must be set");
 	for (;;) {
 		count++;
@@ -309,7 +309,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 	char *p = string, *end;
 
 	if (list->strdup_strings)
-		die("internal error in string_list_split_in_place(): "
+		BUG("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
 	for (;;) {
 		count++;
-- 
2.50.1-612-g4756c59422

