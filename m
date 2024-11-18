Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CC1C07D9
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944059; cv=none; b=M3IkdVHmsnIVzcdE4thIyC9+XCEJaNMwIYniKgLcL/ipH5o/5uH3G+7bB7FCdd5NukhCkPH3JnrbD0sAHCa0uD4tLcLhgxcBrPv+m4b/1BVimiJw0Z16RuxI3x+5tsad07rQQ+uLi3xeWSlU5i+CwcqUVtHvFLW0SNNJJCXASCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944059; c=relaxed/simple;
	bh=MqmRnsZu+3+hUMVTy5yh0Jrcvus3SnW1rHSyx+lQgkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgblI/bLQ3s/ofrPSQ1vFKoqNerDqoRb0RzEgOrlQ7ZAz/S/scng+O3WndrF5318/C86UyiiMckyACCEXClgjia9ZP532MD6hrANw+yjbgXjToE7K9X7vbjq/UVoINhIJW8UMmdvFVModbFnKdxvoJcXTXdTu7+GTX2rtlvya0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZXCL0bk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QiaVM5wb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZXCL0bk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QiaVM5wb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC8D5114022D;
	Mon, 18 Nov 2024 10:34:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 10:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944056; x=1732030456; bh=+VNWPqLF6N
	LI/to6uLo4QfXE4JHBqq9EgGE4AuHO57U=; b=iZXCL0bkyTc4w1OlD0QriSJCsh
	EpNRKmtTHoHvT1mtSwPFZfzx0c7h6T4A7kQKLh3qC/wT0R4jsog0/qCiq1RxAZuy
	zcJpnY2ZGP/hxZPwdIeUatRDK7Cpn7/8aMEmtT8AdvXtA9sWVIIyOYImnGjQCKaH
	I5fPug4Lhhd+vP051Btn2vXHP8BtWdb3DYP8F/7KsnzhLj5P5ZhOJFcbPms3dgL2
	+7zW6P9Gm2wh5jdjpjH+kT/dOYQwzm7iCh5ZVYciafkyky9F9F3QW+KHhAWWXrtH
	p7froVvqED2SN53rTPidV4+t3ltY4q1ghI6zLMrjrLJi6L+oxvoTeUyxyNqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944056; x=1732030456; bh=+VNWPqLF6NLI/to6uLo4QfXE4JHBqq9EgGE
	4AuHO57U=; b=QiaVM5wbUIGWFiHXa01LZ+axtwrwyRUpA5i4iya1MlBQs4s5kno
	hQIJtcttCiZeZqiU9Iz9Eft0o8fwCOb/mdbhWzy+JSGnbn5c/OnyteaPK2W/FHmK
	C8sH5CHNSyX6xoVAnAdJHyX+l/gAv2nHvxRisEcA88BmA5/clU6EzY4G7Ks7taKR
	yqDm+vsS4LkSpIlEGuFpAmzIty2gZoMZG8TKvbEtscBmnTm/5Osz+LYSS1+QVKDE
	Dgf2tVYEtjf6PXJpj5ia2hBPosPCI2okzjvYKeoemrPYQWvEwxsLu2stobTd/6av
	mtQg3XshLVXISQ3i/Xh7KRfGTLvivjWhaqA==
X-ME-Sender: <xms:eF47Z3Ld1IZFkuQ15DrXTYiF1dB_94qos5KRiQyu3Nv9DIsRlF9Ntg>
    <xme:eF47Z7LRpPAUdoIiLKOqXe27AkoJHCPkytKxG0-rz1mJt-yGW9kMXz_iV0p0cnVU3
    Y575ns01U6o097Bxw>
X-ME-Received: <xmr:eF47Z_uMCy4MKWCbdgO9QLAQstt6i7v8Y74W6FKqbr2HDhMfuVDYSb-RhAuM5rZbLtN0UBewwvWzkJIzfSPby0IPC7cmtRdpLZK78DlEAFlN7YV5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghr
    ughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:eF47Zwb12-EX7AFmfzbzijZV9aYyAy42SbS6IiOlKhCRuSexfoQ7DA>
    <xmx:eF47Z-Z7lhrHXQfa1uCWNUzJTw2chej0-JC9D2If1S7QmndMSTtXlA>
    <xmx:eF47Z0ABUrL6kYSalYcDNXCyBgwHo3MUx8N7cpOL6UixGJFglmlBqg>
    <xmx:eF47Z8aZp7PMWZE7N2swgOT-fQnm_YbVjgsnYEwPbSpWboyd1KfDjA>
    <xmx:eF47Z24sjhrhuie2cTizcNbDHjxyy6M9o8KfHF-EMRqol3HWzKWdAD_y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ea93160 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:27 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:34:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 6/7] reftable/stack: drop only use of
 `get_locked_file_path()`
Message-ID: <b9ffdc605b9122fe0ba9525db0b8b3aef1a58186.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731943954.git.ps@pks.im>

We've got a single callsite where we call `get_locked_file_path()`. As
we're about to convert our usage of the lockfile subsystem to instead be
used via a compatibility shim we'd have to implement more logic for this
single callsite. While that would be okay if Git was the only supposed
user of the reftable library, it's a bit more awkward when considering
that we have to reimplement this functionality for every user of the
library eventually.

Refactor the code such that we don't call `get_locked_file_path()`
anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2ac6a371516..223d7c622d9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1493,9 +1493,15 @@ static int stack_compact_range(struct reftable_stack *st,
 	 */
 	for (i = 0; i < nlocks; i++) {
 		struct lock_file *table_lock = &table_locks[i];
-		char *table_path = get_locked_file_path(table_lock);
-		unlink(table_path);
-		reftable_free(table_path);
+		const char *lock_path = get_lock_file_path(table_lock);
+
+		reftable_buf_reset(&table_name);
+		err = reftable_buf_add(&table_name, lock_path,
+				       strlen(lock_path) - strlen(".lock"));
+		if (err)
+			continue;
+
+		unlink(table_name.buf);
 	}
 
 done:
-- 
2.47.0.274.g962d0b743d.dirty

