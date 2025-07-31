Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D527F00F
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001979; cv=none; b=XM8bLVwNi7PsYiVWYMSfhsVdf+FqhGb6upYU8hF4Fs2lNfFIa93mK9G06h+QQvDFUTYFS0zd0muNKjMVBDB27qu4aWgRtogUHMtPu6rEYKzuKh1Y4ayb75ecXw0i1EoeUfhTNCcz1nS8h1yT1okVo2W1bJtBjdfKChUvBAxpLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001979; c=relaxed/simple;
	bh=uWz4hoZAxUUjlTjTB07rzN11L9s72hu9pcQa6HpQUr0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPGCK/AfgnOe/Y+iQCGWzvkgIwneyR86dKlo8VMSQ+8BS98YDQ0qNWgyD9YW/QK8EA9owUQoMMq0xRuJ3FpqWnxHeN1vuhzfrf2GZq5czAboFm23qOw6K32bNPo6UQz+trw3qoAOtXzWsDEEMjHoWbj+nNAtc0VDAvGxFzpveKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3slcPdR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S3FoOb0i; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3slcPdR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S3FoOb0i"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8BD12EC1688;
	Thu, 31 Jul 2025 18:46:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 31 Jul 2025 18:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001977; x=
	1754088377; bh=sVWCaZ3CAv0+cpxnDFadfGOWWeujT7VEbrsR1iR4oW8=; b=k
	3slcPdRP4I0OH8MhPKP8qWTj7p24sXJ3bNmt9Z0soz698bMJDllQZvBraLOusBDN
	c8Ngl/Q6jsqRmR1KN541iDQoZaCR0v2h9pC0a2dTdqBpQpnfh5nv1e4mKk3SZ0nS
	CJjErlRFuC8t7ugtudTDBZ/ikXfIzXVbHSMSPO9W70H/GT46NE0pxoB0sxJeiKiG
	vJHwv5w8dy3LG5NYBgeWYiycC2yTagYqfMOABSnlN3+bSLz1oJyVaW4GG1RYWwTr
	ZYbi46G3B8/y4cuRUronNfFwGFxAJgOlny7aBt6WJxGooEBxV5mDcLhkYr+0S20t
	e3BK2H0ZNAm32PHe4hnRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001977; x=1754088377; bh=sVWCaZ3CAv0+cpxnDFadfGOWWeuj
	T7VEbrsR1iR4oW8=; b=S3FoOb0iXgz62FzesB+7QIFdeRQahnTicBaZ9OgwSPdM
	Y8kI2sg+LQUaTlKqZ53BPF2uumlNG6nuJfBpYTFrmXjNq7J3tVFFwjNXfLrQhM3N
	R22v9psKyW8PxJm6nYoVhD+VGc7Fr0acMuiSoT4PxP+nr1JlDmIplCy18McPmnQQ
	T70fT/LmVKsuN4yGoL1hd5y+FjKUQUW4g+70tpgETfAaWZ37qeYzzIarL2xozSFx
	bVGkIWaZXEA7v7yQATcVFYCQsoY2CtpGyN44h9t15oaOYbqNLRysdDThc+xLP7VG
	dIKWJPeKOXB+Ld6QxYehAn6a73vzy7LqSQCaEGNWBA==
X-ME-Sender: <xms:OfKLaHax9X7o8vr-jT985ZXVdZMSx4nIlGXZVkh22ne-lbVCND7Uyw>
    <xme:OfKLaGmJHe0NpQu_0PU3R5d0NSu73pe1CK_szdDcIWx7cOSKnzhhFI3tehlhpadAO
    p2eX_Rg1LK6Q94LVA>
X-ME-Received: <xmr:OfKLaLwgrmFD1_PR_uKkPkBwvLXdmzylCPBBuoF7mx8namQRxvYkmlPLraXqJKiAkVieAt3OlG_xQXuZ1sPZ51K1LH9WpRxgpD4e6KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OfKLaMNVoye-tbAWFv_nUlfg0XgPH1ix9EjtYZu-VWvVDwHcN4AA4g>
    <xmx:OfKLaHSh9GZXvcwR7Gah8J6niv1pnOeIbp1bnZT87_49uEFH3Fi9OA>
    <xmx:OfKLaCapu-mW4wdP2iOQIOSQm_rM6q6K2YhV6aiIr1uzGnRdcaGknQ>
    <xmx:OfKLaM0gubNLQooaHdrEqqe3xUTq0v_hVDYEE_i-0tmsPMYzDUJFkg>
    <xmx:OfKLaB-gmp-t51b8qu5EvOhZQORg3fQ_zZO0Aa_kGNn22xtJtnHPdrQ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 6/7] string-list: optionally omit empty string pieces in string_list_split*()
Date: Thu, 31 Jul 2025 15:46:05 -0700
Message-ID: <20250731224607.3942417-7-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the unified split_string() machinery a new flag bit,
STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces omitted from
the resulting string list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c                |  3 +++
 string-list.h                |  3 +++
 t/unit-tests/u-string-list.c | 15 +++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/string-list.c b/string-list.c
index 86a309f8fb..343cf1ca90 100644
--- a/string-list.c
+++ b/string-list.c
@@ -294,6 +294,9 @@ static int append_one(struct string_list *list,
 				break;
 	}
 
+	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
+		return 0;
+
 	if (in_place) {
 		*((char *)end) = '\0';
 		string_list_append(list, p);
diff --git a/string-list.h b/string-list.h
index ee9922af67..0f73064fd1 100644
--- a/string-list.h
+++ b/string-list.h
@@ -285,6 +285,9 @@ int string_list_split_in_place(struct string_list *list, char *string,
 /* trim() resulting string piece before adding it to the list */
 #define STRING_LIST_SPLIT_TRIM 01
 
+/* omit adding empty string piece to the resulting list */
+#define STRING_LIST_SPLIT_NONEMPTY 02
+
 int string_list_split_f(struct string_list *, const char *string,
 			const char *delim, int maxsplit, unsigned flags);
 
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index daa9307e45..a2457d7b1e 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -92,6 +92,13 @@ void test_string_list__split_f(void)
 			      "foo", "bar", "baz", NULL);
 	t_string_list_split_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 			      "a", "b c", NULL);
+	t_string_list_split_f("::foo::bar:baz:", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "bar", "baz", NULL);
+	t_string_list_split_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "baz", NULL);
+	t_string_list_split_f("foo :: : baz", ":", -1,
+			      STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+			      "foo", "baz", NULL);
 }
 
 static void t_string_list_split_in_place_f(const char *data_, const char *delim,
@@ -125,6 +132,14 @@ void test_string_list__split_in_place_f(void)
 				       "foo", "bar", "baz", NULL);
 	t_string_list_split_in_place_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 				       "a", "b c", NULL);
+	t_string_list_split_in_place_f("::foo::bar:baz:", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "bar", "baz", NULL);
+	t_string_list_split_in_place_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "baz", NULL);
+	t_string_list_split_in_place_f("foo :: : baz", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+				       "foo", "baz", NULL);
 }
 
 void test_string_list__split(void)
-- 
2.50.1-618-g45d530d26b

