Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98851A08C5
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109993; cv=none; b=EhDKzgkAGUK5HM0kUO6xxCI5juySvoWCi+kHnUyyVDM050l208Du+FQCBZwORws3JPCdm2IW4m1qubX7fzmVcHcu1/FQSaY3ZDuNF8APuKBBNvFkFog9HkCTp/7Q66BMfgNfqiI1Ri5eoDCKMYEYW94TKzCBDg3MCdqMaE67rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109993; c=relaxed/simple;
	bh=1YzmaHrT+mahvHcmEjQbulnMH0hKJc2J7RLUWVFLZSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r770j2UnUP+zlAbwXigv78x+ulNdBZ8TlJ/Zu1VGvo/P+Pcr9N8qS8k+XE5pdWrKYREEJgtjNS9SDzdgg+m5ba34KCQNUohAfdJ2+vzR4TrOSHJE7FsF23kp7vFyzLzqSvhHZLDTkFgzJiKbhbEiJAhUswUqNjVZkkCObw7gqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D7ppDkBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpXO4j9U; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D7ppDkBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpXO4j9U"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E2F5713806DB;
	Wed, 20 Nov 2024 08:39:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 08:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109990;
	 x=1732196390; bh=w+HTTkoiT4wj6/BZHwxAdbO/rF8kiNDTlTCqi3lg/zk=; b=
	D7ppDkBgY5sd99dTwKKGu1u0OxEiKBtlbKD2navW50XBo8WMpHD8IB2ncvWoNQTS
	vrEBogHU9yiXxQWpd2JxaqR+Jm76EabisUwGQoplO0ecXAV8+CrOKwLUnJnvgjOq
	bX/9NRPbxZM+vuVeu5/QOK8a9nzk6ScjkABV4l1lSquk3LLzsfGd2SwTLtdy9pvZ
	FiOC2uaFAVa7NlsILItJkXQYOaTKyfygKgGrz4fMVd/21ZJKjC5f4oDe9dJk4rkB
	FJ4CFgdv+/l01/0KnkItJ5UAf6UZhrSgaDn2FnAT69bUiNMV6aPUwde/UJ3GStBg
	qwvwrEKpY9Rcykww0ntN8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109990; x=
	1732196390; bh=w+HTTkoiT4wj6/BZHwxAdbO/rF8kiNDTlTCqi3lg/zk=; b=k
	pXO4j9Us0tod8BE2uzM+Fx9+OUV2vAI2jdemopzopsbzdXzf/+1YXrp7RKxZdNQZ
	LpYvkh75E2eTRFDoimUZXuQazhFRSPqTHUXb8eayQvzan0CyEd4kngf6oeU1M9hC
	wasOsXwHEPmiLzFktEb17p1W3gexEU7JDnqrSJyNjaxVje2N1EAEeXFStaNpeTDk
	cOaR4ecviYCVX0UatZ/zSPVcoejKc5g8WbR9UcXMY8RHY/5mbHJEDWmVb6DogHb4
	fa0A98g3U5B5tM5fYd7/tFzY6O/dZ4s5/E2gmf4hcWl8aiBFXb5zfynSFXvZAe4y
	x63rlnOKPkksOSF8jpygw==
X-ME-Sender: <xms:puY9Z5euLI1SJRocrHpJOBU7NJAFlys5FTTxWRUhLMmfdobdsj8abw>
    <xme:puY9Z3McDG4ytOm5vjJJ4ZGEWdPmgzOvlUTVsZOjzVIzB8cirYUUwRSLggy-cy2ZO
    xDnMJ4G3d2Lar6QCw>
X-ME-Received: <xmr:puY9ZyjHG6jof5ZdaKA10zusx4Rkdz5TiRldkVnD7hOMyJejKMlp1hiU5zStYJcp7aRlPRQRdb_lyWe2kWoG32ShUHLfLkooS9zCbUfDVWnP3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:puY9Zy8ohRZ_erbkDDknwS2jH5LfkCYydgoFw9STIbXZFFwfvz3BkA>
    <xmx:puY9Z1saZEIgMp-y-2Plcqij9xK8pX7xtjBv__m14rHN5oP9OBgcIQ>
    <xmx:puY9ZxGXF-sJ4xi4tnptH5HRIL4Dl-SDJ4_Y7aO5-TYbTt01Kj9VvA>
    <xmx:puY9Z8MpDr-NWJdHwxAvnzC6n_xqlQ8t7IUnJ5c2cxBtKnBl2znEYQ>
    <xmx:puY9Z_IN5OcGUcnWAWp3Dj2xkePwgXeWTSUdVKVWBGtxNPB7kfgtnI7v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5263c3a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:33 +0100
Subject: [PATCH v3 04/27] bisect: fix leaking `current_bad_oid`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-4-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When reading bisect refs we read the reference mapping to the "bad" term
into the global `current_bad_oid` variable. This is an allocated string,
but because it is global we never have to free it. This changes though
when `register_ref()` is being called multiple times, at which point
we'll overwrite the previous pointer and thus make it unreachable.

Fix this issue by freeing the previous value. This leak is exposed by
t6030, but plugging it does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect.c b/bisect.c
index e9e603877eba059c878ff92bc11dd84553d0649e..6dbc22f84fce11743f0e79eb4f8100c7ec07238f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -456,6 +456,7 @@ static int register_ref(const char *refname, const char *referent UNUSED, const
 	strbuf_addstr(&good_prefix, "-");
 
 	if (!strcmp(refname, term_bad)) {
+		free(current_bad_oid);
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {

-- 
2.47.0.274.g962d0b743d.dirty

