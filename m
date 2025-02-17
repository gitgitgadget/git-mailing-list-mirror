Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA121C16A
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797760; cv=none; b=F+e3iuCjNZutkBZ6Fs6esBcDOZgAoSp0rhyusVYBb71FhYc3BMRPMaUrx8YGaV0XfZfnuusGpHT1t/48ubboPcLwjKJA/a6HolCNqaV2zefu5slt5hMO0sgc7FpUdOl7ihoEK4/0R8wkIOQq4dS3fl9cez+0i//uNM40So4QD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797760; c=relaxed/simple;
	bh=vQqeHiZtvDnwdmV6mU6aYQuDBScGsIz0/N4sSDv5hFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXBBRKzioNTR2vLFBbhtrWHcPV1vu6DHunpjIkY6ETh72zqzBVbdBJSAK0QLxRTkokze+4QsA9yFnY5nnbfhwxUO+RqUHgw7PMMF/5I696+YBFy8/aE0FxYPjV50TZS/c8yGBbXkqTCN9gUo/+McvhIn9+lhS1RFVBQDXqTPYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu; spf=pass smtp.mailfrom=cepl.eu; dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b=F8lkV82p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e1oCpH2X; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cepl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cepl.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cepl.eu header.i=@cepl.eu header.b="F8lkV82p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e1oCpH2X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 748701140156;
	Mon, 17 Feb 2025 08:09:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 17 Feb 2025 08:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cepl.eu; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1739797755; x=1739884155; bh=GTl6cUxL/A
	V2cBj8UW0xbe4UC0KGqiBV0YR4KwvsEZ8=; b=F8lkV82ptER7hYgbwA/IBC2ght
	ce8r7wtq8Ni6Q5q2BCwp+qPgpMmm+PTFVi7P/jgshb9mgA876hsbsRx0pVQt2W1A
	EgXQ/muHlLLeHittS9aSdo2FvFQB2XBY+8i+k7jcDr8OUvaSWw5uYE36RMJb7Nbe
	GOZicBB+5QIUK9NK7KQw60/lNU/c6VnUeCcFRQd2QxJetg2Cgmgs0GjydhCrLKLU
	WhAlPfdRkZtkJArctVXX/W4QDl3qCBmCkZKBz38XC4VJ49nkLwB1RmP4Rqk3UbwL
	N/390rZFxuClGX1p6U5/JmVefRX0jKqtDemZnREnXkE2sHk+33q07omCOKNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1739797755; x=1739884155; bh=GTl6cUxL/AV2cBj8UW0xbe4UC0KG
	qiBV0YR4KwvsEZ8=; b=e1oCpH2XQA635eiRT+HvBr+RlmV68+88MXkndVmujkXh
	4LOuFBEsj+B3awCRudNMXpUn1IoecLF2fiMn+J9gCIgHjiq+KdLOL8bU8AzCfyhg
	V40BDFKpdazljFwdVmV5Ki9SKN/taBgVH19JrPp5Ik+QSbhsCPtQoAmvgetdiKDE
	FV0h2ZzJRnp5BcND1x8bjineeVTBR1RT47J/qjUvCmF2sGzLKw/P/PTM2JKA1CNd
	OaQ0mJDQV5sFZ4/sq95pAuQbXoi92L+TICue4bz4/8+xyTeNFBx2Q+M4Y3IUB/7q
	3Zwt27hFPsplN+4xjqjczP/HNMgrLJcW/AUD8jSz5A==
X-ME-Sender: <xms:-jSzZ8b-lNx0pjPUByFm9kH8W1Hn1AtRnePWt_krhT_uQ378v2Beag>
    <xme:-jSzZ3Z61KJRAGp5d86HAsSafzUEDHHWkghQwrX0WASO-z5OlY6t9O3DX4CSyyS4G
    B7l3vhM-39wxe6voCg>
X-ME-Received: <xmr:-jSzZ2-Apmo3gCitD7LY7V8Lzu2wll21D-e-wNShjCpY-7LaDPfX1W-zEROs08TX6-k1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghtvmhjucevvghplhcuoehm
    tggvphhlsegtvghplhdrvghuqeenucggtffrrghtthgvrhhnpeelffdvuddtkeehvdehhe
    euudfggfehffelhfegjeefudegveduhfdtffffudejjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmtggvphhlsegtvghplhdrvghupdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuh
X-ME-Proxy: <xmx:-jSzZ2rVf-3nkaLwnjl9tNxfD_pkMNZEGJ7Fv-8W6UohGdnv9NcELw>
    <xmx:-jSzZ3reJt-fXA0yLaUNDynexFf28SZQuc1_BFD5tO6taD9YGuJ9tg>
    <xmx:-jSzZ0TyzFRJNs6ygk5di_R8HzTWMtEoYzbcOt8IJyTkOrvEko5mkw>
    <xmx:-jSzZ3rQOf4XWCfkX74hnqF92tbODoxamqIc-FLKRhNesD_mqaIWUA>
    <xmx:-zSzZ-2AnZJlTJNjhjT153wRFDxTieb1HAx9JAESaMc4kNfE_woC_1eB>
Feedback-ID: i8c5e488c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 08:09:14 -0500 (EST)
From: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Mat=C4=9Bj=20Cepl?= <mcepl@cepl.eu>
Subject: [PATCH] doc: fix typo
Date: Mon, 17 Feb 2025 14:08:50 +0100
Message-ID: <20250217130902.2706880-1-mcepl@cepl.eu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I don’t think there is an option --signed-off-cc (without -by)
for git send-email.

Signed-off-by: Matěj Cepl <mcepl@cepl.eu>
---
 Documentation/git-send-email.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index bc3ef45acb..d762058907 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -389,7 +389,7 @@ Automating
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+specified, as well as 'body' if --no-signed-off-by-cc is specified.
 
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
-- 
2.48.1

