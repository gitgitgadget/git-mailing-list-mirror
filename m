Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDB291C10
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363519; cv=none; b=u6JJlzFcUL+qrw53kh3OVUxahv/oN5F48kaBFHPNfVxBV8oXhx5BWJYYWt6exhcdvnH4C48pRbKrAtNT221dlKD8i1y9c302I7erUkbR5NGxPyelsIoJm65oJPn8kjcEwYFufugIBUsSXNx0dt3cvkS0MfhbSKKgaBo2NYcc794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363519; c=relaxed/simple;
	bh=77qGZmWgJgRriC1jcSSlt0gsnsam7tVJ+w1HSHcEdpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YU55J5zssCGOyLtjdZeMVQROc/qYwAaUt33a2I9kU6iGM5gCYUswbHS9QSb0uHBkOlhIAU9v+EEOikFnIqSjPePT5BUKS9uGusxRWGGPxNOxfGrwmXT/cw5Vd8sV4eYKlKV7bmiNRJG2B5C4zQGJi5kSRJiFp4EwdiZv1J9lIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e2QYmNjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhwkuxQy; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e2QYmNjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhwkuxQy"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44F7414000BF;
	Thu, 16 Apr 2026 14:18:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 16 Apr 2026 14:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776363517; x=1776449917; bh=+E2Mr5ZqTr
	wVcqkMrN9z8iEnjSnH/EkgM6pAKmyypHY=; b=e2QYmNjTlcOT7/qH476uVWvGFE
	SyFcL/NZ9CqTb6xzBZqpukBqZRavoaiZkNi94S/3D3ZdRr0fB+HluwKtf71qTbo9
	5brXw0m9uRJlVpJa9yb0TVF4FcB7QEAk4EMo06RQsBEW21223gH8C4Kg4a787Q12
	Q72YDDen1dTilKFzNSDfkTzZEh2HNDvlBDHoPheKgIFvBh2YHEZ5xhPT+FtaFKBg
	gnXxUs5skG2M8VpPNCyzzEXofnLi1GP2VkunuaPjEeQO+izMwlwOYPGO7jkongaj
	MPqErULi2LM6jJbqDqjUH0Zsea33g7q4g/RB6zF0d+4oWU0F154oS3IntFjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776363517; x=1776449917; bh=+E2Mr5ZqTrwVcqkMrN9z8iEnjSnH/EkgM6p
	AKmyypHY=; b=nhwkuxQy/F6YCJaT1scR3YJuo+TQCMyvcuxhnVknrdiSRPm6YfX
	XBOAHZydlAhDLm2K4UrgkmeQSgLZsWY1eJT3CIa/E1DCNV/zdveK0nSo645mB8Qb
	4dPnv8dNax982JdsChaz9t9X1yF+h3GkZZqi/2FsKvwixUQ7/b4jyC+VhFAY8wSB
	jciYZsbUxLhLy4obp2G+9HXZTtbtuYZwKlWUW1QqIUdwJOhzTUzmZAa6DtUGk2g8
	ZgFclXMP9+3OjxwL6qM8xgkJpnI2sQqiTb4lZlsE89NmLRxJ+Ddz6UR3O2HZl1y7
	4BT7aB+DRJhKVR+EZw0uMG5ROobl9GpYD2A==
X-ME-Sender: <xms:_Sfhae_8maMqOh96h70x-Hk3XRS54KKsOP8YbVngH_DFQog9SJnQhw>
    <xme:_SfhaVlSUIvFDXpaZEkV3veso315VudgQ316H3FgdItKtotKaVWqhRZqkCjV0BHvl
    6Vi9j0HKNzUNOCHw6tUimDJfZNLCdjSdE4XLu6qrv8-BCqwZlcamg>
X-ME-Received: <xmr:_SfhacWYTTZUoNWMXeZZLqi9oLQNCJMD11wJBan2PgWHlI6K568l5wxUQuMw6cXrbZwNRgBuXhpbMMW8Ck_zgsO9T1OjiLne0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetleefuddvvdejiedtjeeugfefteetudekteelteevuedttddtkefgieetkeej
    ueenucffohhmrghinhepmhhiugigrdgtfienucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_SfhaSE0iAcLn1gcP1LnA3nODkUPsi3dVVwV7C59OncDZmecabBDzg>
    <xmx:_SfhaQeVVXXeUJKs7AS4dFSEeCUGficBh0ceQMX8gjrwk4hqO6KN2g>
    <xmx:_SfhabIXxVEYzueanSGkyW8PrSZgNogoxWEWnSBUtrGDC1C1Rb4Azg>
    <xmx:_SfhadFKhm7dJM4oNYHq4zmE4lX8AGA-73ohBSjGoeKgO5zBjGt6KQ>
    <xmx:_SfhaQfMWc1MDeCMH62mlRmlE2QEUO7ujKfJRRUPcPZdZ6FbUh6dY6v1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 14:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <xmqqldem22uw.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Apr 2026 11:10:15 -0700")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g>
Date: Thu, 16 Apr 2026 11:18:35 -0700
Message-ID: <xmqqh5pa22h0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Apr 16, 2026 at 01:17:33AM -0400, Jeff King wrote:
>>
>>> I think removing the .midx file (and optionally regenerating with the
>>> old version) would be the appropriate workaround, but I wonder how hard
>>> it would be to go back to generating v1 midx files by default. I know v2
>>> is a building block for more advanced features, but for those who are
>>> not using those features yet it is a strict regression.
>>
>> I think doing so is just this one-liner:
>
> Let's do this before Git 2.54 final, then.

As to the other change, rebased to our current codebase, we could
sell it as "futureproofing" for similar breakages we make next, but
that means we are promising ourselves that we will forever keep the
MIDX purely optional feature.  I do not think we want to decide that
we are comfortable with that position during -rc period, so I am not
sure.  These error() messages should be reworded to make it clear
that we are _ignoring_ the corrupt multi-pack-prefix file(s) as a
result, and then further weakened into warning(), I think, if we
were to go in that direction.

 midx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git c/midx.c w/midx.c
index 81d6ab11e6..06535ffd46 100644
--- c/midx.c
+++ w/midx.c
@@ -145,14 +145,18 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 	m->source = source;
 
 	m->signature = get_be32(m->data);
-	if (m->signature != MIDX_SIGNATURE)
-		die(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
+	if (m->signature != MIDX_SIGNATURE) {
+		error(_("multi-pack-index signature 0x%08x does not match signature 0x%08x"),
 		      m->signature, MIDX_SIGNATURE);
+		goto cleanup_fail;
+	}
 
 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
 	if (m->version != MIDX_VERSION_V1 && m->version != MIDX_VERSION_V2)
-		die(_("multi-pack-index version %d not recognized"),
+		error(_("multi-pack-index version %d not recognized"),
 		      m->version);
+		goto cleanup_fail;
+	}
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
 	if (hash_version != oid_version(r->hash_algo)) {
