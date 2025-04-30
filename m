Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D31E25EF
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017109; cv=none; b=Sdos3hr/dbLOZjm3sAjwj2NncuH1Tc9d2HG1CqKtfgrYkt66MGL59e9pLJ7i/E0J1V1J9qh8IeT/DOtjlslkaWXH1AgEa0TILmXWd5XvfEQ5+uXQ9qV/xMGTV731osK8UlEgRrDKDGUqGQBsEN2uM4g3HdFLO75jnGsbRTUrRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017109; c=relaxed/simple;
	bh=1IvwN25UnrF34sTIU209qm9ejVtl4MMID6tXcTmcJQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLYieviqCWRWKB35kFivHuw/MWe6XZ+0oX/AzdhJZQ96qoWDJNv2RbDYNGUAEW7DTibK/nhJ/htlPcgpmI54H5CU2mYzJ89I+n/jqzPnb7c1/8OUVFIgaCmpi3xpRueovk5DsCu8mZE1zkSBF2qq6a7JmIVgW7l6VHgs/h6W/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=By+KzFmm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyL74NS9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="By+KzFmm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyL74NS9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A81C1380CCC;
	Wed, 30 Apr 2025 08:45:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 30 Apr 2025 08:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746017107;
	 x=1746103507; bh=5JrNRlDYiQQ7Z26Zso574+P70wtRSmcF3/qVQzOwMVA=; b=
	By+KzFmmD+UnRfLf8KrPsJmnRphkhDxgcFe36oDs9RNWEuS6AHyzZW1n9i1w1vOO
	6b+nXkYy1qRv3LqYOMX9GTfgkX4qCnEsNUWniLef2mYeSaGzDHpqtHQwY4G9+57j
	JBJUnAiFHXPb+Oio9UFeK3UsiZ4nyASQxckHJMeWsULLhrXbAPjP+5pFgitkgzTq
	pXX0q1lyhjARcLg4p2MlVnxjKJSxCtbOJ5S3oc04XKmJMOLj5r8h9yTUdxaOhKuD
	S7C6gg8zEaOAqD+2ikpXYI4YvMucir7lYT3mZ5US3JRZ2snuVRP+YDzmNJiAb7o/
	trlpHV+y74z6UXOICgADhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746017107; x=
	1746103507; bh=5JrNRlDYiQQ7Z26Zso574+P70wtRSmcF3/qVQzOwMVA=; b=K
	yL74NS9EiWkNakM3NN6UfwE82lmQ1kFEleRZ1DKnaOyx3enUIKTBpXwzW4FJ0O2X
	UJLyGplHtICN0I8aPOoWD3/S0TwEt75r1934KUFarGpxdjBz8ZLXH0p71jYaKIxu
	6hdjZwTQV9U2YR4laLv0Xu4JArIKaGcweADpfTEvHJ2IvUM6e/bXsL+Jq1NHkSLp
	viUBGHu8hVvgSH6pzqvV4eCbnQccrEd4JHjVTDudtBZVR8IFL+RW/IZ2I2r9Ixnw
	MFiKOdRm1QOzZfX9ayeh+Sp29fk4cXW7wtgsmx7wsWAh7SAOPwa1hE9+iPgapmTu
	7EsQy3U1IbIYxJ9Ew0aXg==
X-ME-Sender: <xms:UhsSaOoXyqll3WNFQYXXh6lWl8DppjcXk4nMet_p3ZMgFhSDl2-oKA>
    <xme:UhsSaMqGNhx6HcsvxQeTTV-gGQvuri4iVCz2W_FMPKcPZnMQgOBZt4WzSKH-Xy7M8
    YTc_ZShfJKRtJALAw>
X-ME-Received: <xmr:UhsSaDM46WUOF_by1jGsM5b1ALltfUyOXGR2a0Opk3u6SpZssWRZI3u5FJWR62LKb4lujNCzOeuXnAj6GhA1dp7x1HFDc-dROAWa0G5KyX7QqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:UhsSaN4rsjq0ORsp0v1uCVCZqRik91u9HEU-u-Ud6xbO1u27d5YcYA>
    <xmx:UhsSaN7lMUJyGsObEDst_4eipyPPcy9UOCUJB7jwypTlqcQHsxlg1g>
    <xmx:UhsSaNjvUvHQZ-TuITjP2oVRWuoBzI8AwZeYKv5JM-9f3E7e7kQVjg>
    <xmx:UhsSaH7AiSGjZP7OnXkJLIs9bTC39_UCML8D8R5kUqYsaqJ-gRT4Gg>
    <xmx:UxsSaIPSL7_4ZczOKStfr5axTfUhZvXH2H6jbnAsh3e7w3rkYqTzllWm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 08:45:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 176d0fb8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 12:45:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 14:44:58 +0200
Subject: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
In-Reply-To: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
 Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The use of asserts is discouraged in our codebase because they lead to
different behaviour depending on how Git is built. When being unsure
enough whether a condition always holds so that one adds the assert,
then the assert should probably trigger regardless of how Git is being
built.

Drop the call to assert(3p) in git-mv(1) and instead use `BUG()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index edb854677d9..07548fe96ae 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -562,7 +562,8 @@ int cmd_mv(int argc,
 			continue;
 
 		pos = index_name_pos(the_repository->index, src, strlen(src));
-		assert(pos >= 0);
+		if (pos < 0)
+			BUG("could not find source in index: '%s'", src);
 		if (!(mode & SPARSE) && !lstat(src, &st))
 			sparse_and_dirty = ie_modified(the_repository->index,
 						       the_repository->index->cache[pos],

-- 
2.49.0.987.g0cc8ee98dc.dirty

