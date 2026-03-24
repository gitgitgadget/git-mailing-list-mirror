Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5842C324D
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375513; cv=none; b=ffpn3RUDAEUg+GrkC31IaCCy+UAV51snDwq3+KZAGawIr3zt6EpifZ9WxGrWp5vCDXQ1MK3iUr55pQ5AJgtfN3adSGUMC7nHRimcBmu+hzJS3dYdUxiPff/BKHP5qV+0qGahs+fA8Pe0akCbD6IG9WrOI5UuPIbTBJr+Uomkr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375513; c=relaxed/simple;
	bh=fGWc2lZQuTkjl2NQSLE/15xaguoT0mSaIOgNhYxdGm4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiKGIVdwngCDI40QXcl3BWEVzk02ZbJv5IUbiF8XO97POUVn6kp6iUqelqaUmgSBVK50tY4oOULiI/PGeKYb1UwUG9zGdurvvLwjGMRzDW3b77g4GFMIhf4MX4eqOgdrwBot+upIZv4o472Ei2he8wHaB89FQ8q+6vGCqDIFtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VCsj2yrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=useDLp1g; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VCsj2yrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="useDLp1g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 41C56EC0101;
	Tue, 24 Mar 2026 14:05:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 14:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774375511; x=1774461911; bh=f3qzwvVXoK
	JuRrFj5cp9yBUMQ5oF4BgonKyhMknyT5Q=; b=VCsj2yrD5hQNDV4AjbYs4sta8G
	brkPwl0OB2SAhRjiXju2Xy+eqOcc64wQE+uoQdg2F0njrS4ad9AjkgOZoKcINCYF
	tOhTNM+12pfkljXUFHIfjA4H5MbNVSsU/MQhiIeBvlMOUj6MOdfwIi4ML7JMHIvQ
	HFBUNJOMXN6Uyg85FRxGpDWcYObjHU4r6b9B7KIC4Par/GXf+mNGV8eZ9H5goCFT
	mmcSmcE9sOdDsvNy72JKZMLdjkL3bRBxE8vj27C5vo63yPvR39WqhLfheh7OKi4S
	6HBfcPQmLn4ZZYkPTMCeZvbUzguqbP/oSaLwNT8/qePkiMsYB3PNhLhq9b7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774375511; x=1774461911; bh=f3qzwvVXoKJuRrFj5cp9yBUMQ5oF4BgonKy
	hMknyT5Q=; b=useDLp1g5FV3sad7+jMx25PBexzkEFja9tYmDMgOYNZVSc1+q8l
	QRmWV6Hegdqq27NsNmA8DVmSb+qFn+GxQSueYDkAYLbEIKEoiYt0wK2iz8Iom7oD
	iiZBFGAQcf2nsFvjzce54jMnFikgkYqqeL2s7CsmTjWd1NxzkOAiHZN6L43RS2N3
	AuntpvbNx+rT87wyhBesVjQ6sacMBmUdxLfUkqhjn8oiTJJ6BXBO50IwTf6XFJs2
	W98LXpYD2uEI3WySuFLrMcIIF/MLi0EDCGTWt06CrjD4NJwG8DtKRX8FIE+GdQYq
	LKkEGCpqcczbWhYFWrZmT1bN4mTZFzz/W7w==
X-ME-Sender: <xms:V9LCaQ6NN3_1dP_nD1C9yaVm1Sau_9pSgcUo2ANj6XYQDYTaB3EnBQ>
    <xme:V9LCaX5C3Rggwvz6PXbfVodelOdl5WFstAqsvTxjzvmRVAtkSUI-6eTaAOfNLg9x8
    jx_6GBSl6q-kp79h2Rf71GEeS6olsGPByd60oakH22X70X8ghaq6Q>
X-ME-Received: <xmr:V9LCadF5YyQ7cd8SvsJH5Ks_qQwJB0zfd8xu149fKrdNsAKMUOXVDZ4OhLrb4EbCPanhU3-d-DFruMBgsMoU_iTnFPGZU8pXpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:V9LCaQTtUpAEX8V7wK-NEx-LuBc5fvk0sqoHykvR8eeDWcLeavaSpg>
    <xmx:V9LCaWsAt9VrYR9PVAsvmUepRZPBgKnE_XpCE2TMSYedqzmJ-t-74A>
    <xmx:V9LCafw6hzMq7KHcG9ciZKJCl3BtE_P6xGygJpjVuP2mw67jrm613Q>
    <xmx:V9LCaQ44dzO1va8LlgTGv3OwQdQ45Sa50wDAdhn9PxEIIXfe3mPWYQ>
    <xmx:V9LCaUQ6TrpsKWgsvwBT7LiDLWov7j1Cn9dPQiO1oSenblAOKyGW8CUm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:05:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] t6002: make test "set -e" clean
In-Reply-To: <xmqqcy0t178a.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 24 Mar 2026 10:13:09 -0700")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g>
Date: Tue, 24 Mar 2026 11:05:09 -0700
Message-ID: <xmqqwlz1yuga.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

We often use 

      val=$(expr expression)

only for the computation, and it is good that "expr" exits non-zero
with syntactically invalid expression (it exits with 2) and other
errors (with 3).

"expr" however also exits with "1" if it yields 0 or null X-<.

Make sure we do not fail unnecessarily under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It was fun to figure this one out.

 t/t6002-rev-list-bisect.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git i/t/t6002-rev-list-bisect.sh w/t/t6002-rev-list-bisect.sh
index daa009c9a1..1bd720d240 100755
--- i/t/t6002-rev-list-bisect.sh
+++ w/t/t6002-rev-list-bisect.sh
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
