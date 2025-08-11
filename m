Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F32DE1FE
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754925997; cv=none; b=dhnhaNYg0RHUBTbfPABQJQDCxHj1nUjdq3RaUyGMnBcRqyqM61gV5fdYCjhMAwYWv7fO8qU+0JyspbS2z1mmE42LoEgis56xiKFgt16/YWYct1nkRws2jFMUMNLq61yJ1gId9zsmdJiuF5R406mXlgkx4PVoYnx7/D70LZ2F7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754925997; c=relaxed/simple;
	bh=fZ2F5mj6qp/t4TrkzkYA910p2AtsVWJs5Ke2YAtsTeY=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=TDx/5WUHYu13hINCd8UED1xhe5ZQShJzux+B8K5MGynRP2BpS51+P3LaRfCbXss/3X+tsNWCSStYUAvI4p+Uptp96s8aehodQyTOlZZ+GCTGJs2e80pRm0aHZQpGSuE0j2qvdrIOJpktx4JBg4C5i1qalvHpkWi6S35N6mnvebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DEVx1SVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b2JAPqpe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DEVx1SVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2JAPqpe"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D0D91D00094;
	Mon, 11 Aug 2025 11:26:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 11 Aug 2025 11:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1754925994; x=1755012394; bh=+iuV6Bjt/pg11bXDf8VFMPzdVQjbiZhq
	TVenqarA/Wo=; b=DEVx1SVQBqvMR9mNpbA9i2qRv0Oh036RvzN2R+HrEFxi451w
	3i/mowi4wrP9fMOc+dQenkLYrEul8vpqZPGVkaONu1+nkrT66o5xeOOpcuINm5Go
	Vwf9oSCb64KDOU2LTMLDGyr5+8YsE4G/h+Sv5zyCIsIFGxrF8UETMoFnbTGDkErr
	rPTsDPWgBbY4MR2Ns2IxnN3AvtQZO+8/uUktBAos5sUosdyGFCkfQkA8EBma8dpS
	cCJcEcwvmy1Jk7wI4MZH+/7wPZYOIVQxGo+qV22M1J8qADYqMj0t1fxfFLHFuiW1
	qFnCAJ20MlcyHonffY9s0Ilhp4/bU8I8L3zsyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754925994; x=
	1755012394; bh=+iuV6Bjt/pg11bXDf8VFMPzdVQjbiZhqTVenqarA/Wo=; b=b
	2JAPqpe26xE6u4MAax0ow5+HIvkvmIY4ZJxrYZ4HEdJAjsbb4luFjE/+fktb2fbL
	ZNGXMqx4VuokvICbvdQArqOdqGUNMakB6fNC9VFTqzTfKuM4pS2FXaXL+ARkx6OH
	dGoBuzPaMlkb4hfjKAKC6wzya85ImaaU4MPeWf2R2L4cJGoNJfR4f1KmhT7JyQVq
	LAGVaAtEwDecnwneZguT9dFvvFzJyu/eNx4oGtokMBX4jokmkQ6FZ4AjFB+utoKQ
	hzUcQU/8HbsvDUTON/zIyqKyQ2caesOL7xjb5gYGHzzNeZsY2nr29/dG9Fd0L5ws
	GVR/6mHM4KZiQCw2/dsPw==
X-ME-Sender: <xms:qguaaCfCeo4LY0GElI7D3gzufWzJSDlSrbnts8_-p5beMQnASANFUQ>
    <xme:qguaaGzCkTCL35U-gGU7DrxfYHdMieWgsxfqEfg23F-VJUfDXE43l91W6aQqcuM2N
    z505HT-gt-X1rYm7w>
X-ME-Received: <xmr:qguaaAHebF-OQNysadg2kynHi2AAIerPE_qOUwOVO3vmy8J3exnS0uTpLki55uZsRMGoVxcEh2oHfaaAiCXjuijf11HEvbkrI5VC2DE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvufevfffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepgfetudeggfduudeludegfedtjefgueeujeekiedtgfeuheefkedugeehueelvdev
    necuffhomhgrihhnpehosghjvggtthdqnhgrmhgvrdgtfienucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qguaaCyi_KRbH5-ownZXP8gHUPgW_YC-5oOXyhTungGbLM3RdHdcew>
    <xmx:qguaaJviajDQU1g-zXWCFuTrEytivXFvHsN-BI-mdRbM9vxOjqcqwA>
    <xmx:qguaaH3R6H1y9lhBkSyiBWI8md5jpKB-bBdIpK0h2bKgz4y4tTQ11g>
    <xmx:qguaaM9mwGhvbDDSMV95IBvEfex1x_BePOpoQJ78eMK4B514JcalOw>
    <xmx:qguaaAs3nIb33w5sGNWxynLdLOJMVJShUIZMe520URAoRYX779nfpheA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:26:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] abbrev: allow extending beyond 20 chars to disambiguate
cc: Jon Forrest <nobozo@gmail.com>,
    Derrick Stolee <stolee@gmail.com>
Date: Mon, 11 Aug 2025 08:26:32 -0700
Message-ID: <xmqqfrdx517b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When you have two or more objects with object names that share more
than half the length of the hash algorithm in use (e.g. 10 bytes for
SHA-1 that produces 20-byte/160-bit hash), find_unique_abbrev()
fails to show disambiguation.

To see how many leading letters of a given full object name is
sufficiently unambiguous, the algorithm starts from a initial
length, guessed based on the estimated number of objects in the
repository, and see if another object that shares the prefix, and
keeps extending the abbreviation.  The loop stops at GIT_MAX_RAWSZ,
which is counted as the number of bytes, since 5b20ace6 (sha1_name:
unroll len loop in find_unique_abbrev_r(), 2017-10-08); before that
change, it extended up to GIT_MAX_HEXSZ, which is the correct limit
because the loop is adding one output letter per iteration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * No tests added, since I do not think I want to find two valid
   objects with their object names sharing the same prefix that is
   more than 20 letters long.  The current abbreviation code happens
   to ignore validity of the object and takes invalid objects into
   account when disambiguating, but I do not want to see a test rely
   on that.

   Git 2.15 (that predates 5b20ace6 which is in Git 2.16) does the
   right thing, even though it is a bit too old codebase to build
   these days (I had to omit curl and pcre, as I didn't need to get
   them working again only to see how its disambiguation code works)
   with the up-to-date libraries.

 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/object-name.c w/object-name.c
index 11aa0e6afc..13e8a4e47d 100644
--- c/object-name.c
+++ w/object-name.c
@@ -704,7 +704,7 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
-	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+	if (i < GIT_MAX_HEXSZ && i >= mad->cur_len)
 		mad->cur_len = i + 1;
 
 	return 0;

