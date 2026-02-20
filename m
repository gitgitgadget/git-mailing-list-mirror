Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C321B9F6
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575983; cv=none; b=aMB3PrSX5MfhD1WokvzrSQZjF7ZriJ3kj6Ichv5yeMz4R9G8VzoVjlSDEycIxMa5f/C98ItdmCISaw/GGkM2vml/n+frO1+t9qxaB2gWKqkN/VbCwev7NfnB8KpC3/S9RsVyuHBT8/SqoHyWBwkGGh8C3RfZpulhV6qrDy559w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575983; c=relaxed/simple;
	bh=J8Cg1qnjv0DT2grQA+mnBW7/LHNDWgeLveRy+pUX44o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwHA+mvH27j+0lLDm7FV1Q6+0fkZdERuHKJXbkTQtsHQ+jt4kMToPH5nf1Fj3wghlMu5za/TIAcr309jDPfpuj8KqcZ4QEwWnij5CGSKE193AWgERxYoUHXrBIfIix0b5SbDiVEy3iL1SjUVRTUZD/9fCD5xAA37nmyRfylh7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ap8GkZfb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFFo8/aL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ap8GkZfb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFFo8/aL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F06F1D00173;
	Fri, 20 Feb 2026 03:26:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 20 Feb 2026 03:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575979;
	 x=1771662379; bh=J6Q0f03DpYPLSSeBtAq7wro9f+tLAx1tztAM/1wL1DQ=; b=
	Ap8GkZfbJvEAY2FTpm9nu7yKtC3MdVfSJ7dmgmOivgZl1S6RbPs791evb5EbBSII
	QjAqWnhou0SOifbPFkLMv2lbUguNFDG3rFPfaB75Aos8HkTJIVQcu3Mj9EozqTvJ
	sDHecUv5mx5SbedX6MhKxGhwNXj6DecsOoUNPjr9LEKUFFz+uEeNYqanCPhIc2GE
	0lerUq2DODOnXUO1M+1Sit50Iip40Qzzly21UqpR1JAUp8omGJCnurObDuFY9mQP
	Hj15IpsMx0d92nD3WMRjEE2x2Suy1JjReID/bEDozAfD2LmwP5gBGVn+/JwclvKi
	gjd6FSdmNMxUy8SQfjsovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575979; x=
	1771662379; bh=J6Q0f03DpYPLSSeBtAq7wro9f+tLAx1tztAM/1wL1DQ=; b=I
	FFo8/aLNUrf+WxOIfysdQVaqIu4DpFDBYc6zoTIEX7zPLtMbfxGEOQA2uM/+A2RB
	3BZhYEiNTyAWPhorxwyPu40aRDgTyM0SeLTF9Yp6ffBh/27zbeiS7n4L42Cmm9PJ
	U1edNp2Nv1K1eLzXHIAu9kQAfa2jIWorep+7viUy2jD1KPtkfa/4YSsXj5l93hTg
	WB7+OZR3sLtGtY2YfX6f2rtAKDQJMlwwAHQFe3ZZdYTJb1iVQD96Kn9xyZMPVqup
	RLbvFHzV7PVTSpHAhQTE8KTjTA+fu7S1gz+22HiM/fYW961DIDOA7ISo2ShXZHPH
	H9vGEgisrzN1+1y8XHshQ==
X-ME-Sender: <xms:qxqYaZnToOJaAXYv_l384rJ9BUAbb7k3RuMNUII7MOjd7GkDUxgJmw>
    <xme:qxqYab1O0B6fILZwlOwwzPlh5zHBEFjbNB7yZ9ijY0XdvuX_OdmG4uxqRLX1P2EnF
    lOtHHL0wgJ_yt5U4CZMd79S5EthymSqRcqrnAho2KAmVoPMuiIGHg>
X-ME-Received: <xmr:qxqYaUpilS87EKjzHPSrcJSC5EFlJ0vaASAce-jrKypz6mhB_jygixoqqlRfRcOaGkTIb1I4AgKu8G041onExYiNXzqkOnbScB85mZrs8ewC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:qxqYaYdjQRp1e5U5VvCJHMSlczQFOywlUrn-j2_r9pxTJW-VFFBcKg>
    <xmx:qxqYaTrg92zFDIj2fY7UaYtHVSaq7isKblVoFv1eLaEcIZB9ZRG95g>
    <xmx:qxqYaZHiDGmnMzHo_AWGYVEO5KVzc5njAf6pszeBYg5bnkiXiv5SUA>
    <xmx:qxqYaTvRoXFiZZ9KIiBxLEu1z2KpYd1jDuGlLDYO6twdsm-xGL00Lw>
    <xmx:qxqYaX6JakWuW_V8gjfWGjnDGE8oo5ShravrrrNEljjWGqXRInU_-Nfj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76eeea73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:26:03 +0100
Subject: [PATCH v4 5/5] t6006: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-5-e0e6bbcaeb5b@pks.im>
References: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

Two tests in t6006 depend on the iconv(1) prerequisite to reencode a
commit message. This executable may not even exist though in case the
prereq is not set, which will cause the tests to fail.

Fix this by using UTF-8 instead when the prereq is not set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6006-rev-list-format.sh | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index eb93d68d7d..581984467d 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -378,15 +378,23 @@ test_expect_success 'rev-list %C(auto,...) respects --color' '
 	test_cmp expect actual
 '
 
-iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
-Test printing of complex bodies
+test_expect_success 'setup complex body' '
+	message=$(cat <<-EOF
+	Test printing of complex bodies
 
-This commit message is much longer than the others,
-and it will be encoded in $test_encoding. We should therefore
-include an ISO8859 character: ¡bueno!
-EOF
+	This commit message is much longer than the others,
+	and it will be encoded in $test_encoding. We should therefore
+	include an ISO8859 character: ¡bueno!
+	EOF
+	) &&
+
+	if test_have_prereq ICONV
+	then
+		echo "$message" | iconv -f utf-8 -t $test_encoding >commit-msg
+	else
+		echo "$message" >commit-msg
+	fi &&
 
-test_expect_success 'setup complex body' '
 	git config i18n.commitencoding $test_encoding &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=$(git rev-parse --verify HEAD) &&
@@ -448,7 +456,12 @@ test_expect_success 'setup expected messages (for test %b)' '
 	commit $head2
 	commit $head1
 	EOF
-	iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
+	if test_have_prereq ICONV
+	then
+		iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
+	else
+		cp expected.utf-8 expected.ISO8859-1
+	fi
 '
 
 test_format complex-body %b <expected.ISO8859-1

-- 
2.53.0.414.gf7e9f6c205.dirty

