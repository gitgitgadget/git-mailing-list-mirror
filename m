Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA51A4F12
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929130; cv=none; b=K8lsQpjWD2fhLAWAFYmx/WRNVW3mNs9weJS88PS+8jX65kLhBYd0RKP1zSFJW9HgpP77GlGGsw91/IVNlO6elvguknRbCR4hlAXngDtUpu1wvP/rF9hSx0i0aNi+PjdZRJxb9WUbN4eZtbgiNsN1ZSyXuf4B03gt9cSdGtBXZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929130; c=relaxed/simple;
	bh=Lb6B1HNb1RFqbdcwYW/aT4a9hLJ862UJnyNuvrlc2kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epDtTQrbkOzsIdV5hN4JxYYzRwskb10KVOsnxRPFs2BiBKjbqxZlNyYTJ8F1gY/YGoLCy0Tk70TXPFqJY3mbOBBqgH71jQZ8tSqE+R7tOMsD1wuEwpq3qMU3OPTOo5i6SpwEwc//WSpQFSlrxowV1lsEEkilMRW+K5ItK3znonY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jE91DOLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kjT7LEK5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jE91DOLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kjT7LEK5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8598B13801A7;
	Fri,  7 Feb 2025 06:52:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 07 Feb 2025 06:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929127;
	 x=1739015527; bh=Hn3nnoVMXPt9SS+UntNoPYSlAzfDwFyx/kqG2hw1lr4=; b=
	jE91DOLa0ZgVB5EmLmWoNTvv5h4U5lXPz/iU8tjqlAZuUJT5qVnhnhjY0hq9gqFS
	IhHMk84VBcUBmG1IUCec8aL+xTnXWl1bH3gnhT/a8A+IYYayldAVeyZOCH3CvYN9
	gyUL4Grx/kBAUuCA5zc/2FOaO5PjrzTP+V2zy1hJJpMboEczwOoiEYU+8uSr4VVs
	kPi5Su3HCVpW0FUMOlyz2HQlGBvR6FuDMr5jOcJtNjfOJ6GuGW3IbS9neqtDUFo8
	7CN7nXCakqwHY7oldc91RnhVCYDDf42eR4ukrIdRn6gpCW8esR/dyiNGidpwh1M2
	/HleV4Q5K8NCowORSP+7GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929127; x=
	1739015527; bh=Hn3nnoVMXPt9SS+UntNoPYSlAzfDwFyx/kqG2hw1lr4=; b=k
	jT7LEK50tkoH/iYAnqXodYPEHmn4Ne3KmfF5BxaSlObK7ofv48zLetgI+P4QIOQx
	n5I8GO2+hLb5+27DQH6LexrT/iDu3o1oL/YLzucpCckaoBWR8O9IJfsN+jIONg/f
	Zdapn/4/zlsZRtaPTAZUInQfyTnBE16w/4KpsqTsDyzRfq4puVv56nOjNFxDu4+J
	C+Dbna/iexx4bTec2gSe2yZfTIVvUmtntaIKlpFXkiKvXCH+iQ9KkialFgVkwws+
	fnPVqzkSZ0dXQuq6misNdYzl2j4c0amRllqkKFz/LiGlXWp5eDat74RUGxAGT5mb
	5E1uEeuSVcP7ERiCE8+2g==
X-ME-Sender: <xms:5_OlZxfPolU6j5Q90bUgbzR7vDUjWdogwDs0pw0KBtHqO0YG3KuAbg>
    <xme:5_OlZ_Pyit-bex8S-OZMYp1duMzfbluh9CN86UNbms6M3MXCqm2DR38x5jJwIWuEv
    kn2IVJTrIMybeS_xQ>
X-ME-Received: <xmr:5_OlZ6gb1K1z8L8V1gZM8mrePLkT5p-Xn8LmrQ_-TMXFmawrm43VqltJpjN5NEWVn5cEusrP49gC9JixL8GVML3XLFGR5eYvlL4QWx4HscyPuvP5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5_OlZ68i7AduIgYoqKXtNKcSKat7hsZfO4QLw0daH04NTHSnn3O29g>
    <xmx:5_OlZ9vCS34lj-T_f_wfCABkEFhTzyxotAedvG9A_8AL1QBkiFvN9w>
    <xmx:5_OlZ5FVHeSDPJZg4-u681OfMzDMvMpf_xs1OcMwwr80TD5_cXyejg>
    <xmx:5_OlZ0NGp41hkkluulSi81d_D14RFd19EP1g_QAnT_NOPnMaxXIzeg>
    <xmx:5_OlZ7VEQDglwXEzCjmHCiq6fdIucsWLng40aMhJjU_6K07f_ltfI_7z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d4f9b01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:51:58 +0100
Subject: [PATCH v5 03/18] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-3-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

We use `xmmap()` to map reftables into memory. This function has two
problems:

  - It causes us to die in case the mmap fails.

  - It ties us to the Git codebase.

Refactor the code to use mmap(3p) instead with manual error checking.
Note that this function may not be the system-provided mmap(3p), but may
point to our `git_mmap()` wrapper that emulates the syscall on systems
that do not have mmap(3p) available.

Fix `reftable_block_source_from_file()` to properly bubble up the error
code in case the map(3p) call fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index bba4a45b98..02972c46f4 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -98,7 +98,7 @@ static struct reftable_block_source_vtable file_vtable = {
 int reftable_block_source_from_file(struct reftable_block_source *bs,
 				    const char *name)
 {
-	struct file_block_source *p;
+	struct file_block_source *p = NULL;
 	struct stat st;
 	int fd, err;
 
@@ -122,7 +122,12 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	p->size = st.st_size;
-	p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	p->data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (p->data == MAP_FAILED) {
+		err = REFTABLE_IO_ERROR;
+		p->data = NULL;
+		goto out;
+	}
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
@@ -135,5 +140,5 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 		close(fd);
 	if (err < 0)
 		reftable_free(p);
-	return 0;
+	return err;
 }

-- 
2.48.1.538.gc4cfc42d60.dirty

