Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F5352C3C
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419683; cv=none; b=hX/4nk3tE8IA1wKwphZEk5Iq6KrJ+JgLCkCOH0LuXg7DwLTEIKgkMtlXUMAEHnSSkzhpagw8TSsWVWi92hEV1GkmXe7zUT5tUx50eL3kxJXMvmM6MCdqTG2xIt7fcx6Po5Etatou3d+aG84q76oLNmAxICtfpkCpYmojD2SmMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419683; c=relaxed/simple;
	bh=YYSbrGwgQijvicpI3WQTu4svTC7jRitoOzUOAz2wJBw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ1rWIwUYeiNf+g10Tjr01sj1qUkSc2w1WoXv4ol3zC2kx7OLAzuksBK5IL9TJQO6iNuHqy9xeHApI7kibiJmoPbTkqlOiHZZscQAgaFXRV1nhWF97xIJhGaxpaTqAdTGZNleWw0KjLIOQ2+Jz68hcsQ/oxu5VbVStQB+Rb5swY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KBsnW0e2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5YD4oyDe; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KBsnW0e2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5YD4oyDe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5EFF7A006C;
	Wed, 25 Mar 2026 02:21:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 02:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419681; x=
	1774506081; bh=iY+1C90KpLhyhPcj7s85t3Qj9Q3YBx53QKdg/gL41S0=; b=K
	BsnW0e2A/Nh9gTplnSpYXfPLsLzzMd5D3Hh5Rk63zX4sgdb9Dntp2QZmB4q8i8Om
	Nded7ekvuzk7PeVis22RYsK4PFDdsJJ2i3cTBkRA0+MnmwpoAM/fAmtBhxj7m/oP
	p60xdl8hBOxhLtgYKFuDaApLZ4V6aI7lu7VXaMbH+gJyW6p8fbgBP6Lfp3q/XQ0Q
	AyWd5LN7CTpDAg1Ff8RY0FV8ZVI05lzDrxyRGQ8PqW8x1kw5qiAUmVIMoM8wr4FH
	9IuuVB5T51ZhR93Z8yH5gBD8EiUsxuLYVXKz0LWJY/FvQuKpfi1Aa4dKxI3+sxSB
	LaCpyTQRmH4J2FAwkBI/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419681; x=1774506081; bh=iY+1C90KpLhyhPcj7s85t3Qj9Q3Y
	Bx53QKdg/gL41S0=; b=5YD4oyDeYz0bDJG8rSYwzVgOoEIlT7aRdq8trJYbp/U0
	8R+WZjTOdPjNIUe562Vw3FFMVgnpAui1RjlX0oq0aaTKDTA/CoVmEaZsckwNVApj
	q/JEciw74tTlUUK6KsLMAdXLQZHG3qeAdzO+i9LEm4tW7mdzeFaAOoV9qqXVUW06
	BWl8fu8K0JPdj8cq0xHVaSlh9aWFNlQJE7Woo/uH1xKlg5Byw/e99tkAgLBxrxM7
	ZwCORWQyUcr3ml8GT8D1HhfO741Uw7e99Jv4ChvY0WLcxyI9ytluy7OCZP6aLtIA
	0EMcSGJVcj3tNkrw9XYdbTEW4nrMursyjm6BxGepag==
X-ME-Sender: <xms:4X7DaWLBq0ykM-qQDbaz9NFjyfww6FnDGdz7zAB79zPJuT6070bJvQ>
    <xme:4X7DaUICyw-Ph__1rb2DQR3zyZBtvq1D2piDf9_IgEXeJ8oGtbRLh41Svz5zZL7Xb
    S9k3RDitY7Hx4ZJX45L4TMjjCWj9HPWoHz-L4xo1pMIFsYAwriEQQ>
X-ME-Received: <xmr:4X7DaUU4mKLK1NsyHwQJeC3fdfKcRpPdXhqHMYb2cv0UrK7i0FD4NygRmyWoFMuHcVUc-K8jOFqPnC8nuHOe-AXODkMSWpa3hA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:4X7DaWg81NpMSHVAqONk5sF8BN83MEYp4DIUfXo19DzVVaDQlYaYqQ>
    <xmx:4X7Daf-lSaQJRM0-A5T4cWz58DFuYK4SMD7b4RalclFiIu_5G3ol2g>
    <xmx:4X7DaQCzKuVk1INfe-WFOrcAoGLe1lSfzAYh39xKMW-cx4Fdkmhgjw>
    <xmx:4X7DacLplM9G5w_gyjsR3zuYrwBTy6Fvzrjn9b3FEaisy7g8wqo8EQ>
    <xmx:4X7DaZgotw-Ow5b09G6LE0M6tALXPFlrWKHwfS6KZyTKD4QqRxOuCemo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 03/11] t6002: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:06 -0700
Message-ID: <20260325062114.2067946-4-gitster@pobox.com>
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

We often use

      val=$(expr expression)

only for the computation, and it is good that "expr" exits non-zero
with syntactically invalid expression (it exits with 2) and other
errors (with 3), as we do want to notice such errors.

"expr" however also exits with "1" if it yields 0 or null X-<.

Make sure we do not fail unnecessarily under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6002-rev-list-bisect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1..1a6ffd8fbd 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,9 +27,9 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
+	_bisect_err=$(expr $_list_size - $_bisection_size \* 2) && test $? -le 1
 	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
-	_bisect_err=$(expr $_bisect_err / 2) ; # floor
+	_bisect_err=$(expr $_bisect_err / 2) && test $? -le 1; # floor
 
 	test_expect_success \
 	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
-- 
2.53.0-886-g529cbd14ff

