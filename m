Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657863090CD
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299777; cv=none; b=Y13J0bnLx6iaRuVyVuRBGfZugD8LcGYXqUsS3HEQPolOo7JFqqxveCxUtlJidXk9BUGtIMiXU4RNDdN9Nzgvvj7YFZjlJnd7mkrEkXzR2wEN+cmVzf6eziNbRLUWqZYI7D0tc6oFHgQASQC+PUNDveL6fmyfTqzDmdW98MLkX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299777; c=relaxed/simple;
	bh=yBtH7X9Vza+NAt5lFPO2OlW0+fmmlpqw5XrvWwvzCJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGmoMrM8UPSXGstk4XAspngMlKi21i3Mvcu0FdJZ6bhbYUVFdpoqN3QoeX4HXsLAwrT0d336dA/KwFT54SoN6KACooVnKsdcWRh3VHjwX/iJWsnjg0oc1svJW57KqFauE0KUGjTBDV/10pPURMkTsn3pG6F+9B+QM+EHwMbbeHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FSLaYEX2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvGZk3NN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FSLaYEX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvGZk3NN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 86EB3EC02AC
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 24 Oct 2025 05:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299775;
	 x=1761386175; bh=GLa6gPCC+lWCZEQhiymrSPFN6fIfuS4Gh1rMd2twLGE=; b=
	FSLaYEX23XO9WSRxoCbOo0oKMP27E9kUMwEXCAcJI0APYIkevebrwyKqiHV8IuRU
	Gb2RUi1Rw1DZQYi0ZbbPzquw+SDvrRiN0wTiPyKgmWovSMt28m93bPPSljuWj4jo
	RvOkv+BBEVCmsezsuV9ViFUb70THOyQXFioMcUpDZaFHz0C1//Ot95QnLJOURVOT
	/7Jwus8RckodH9nDV1goA/S7AGtV7dq1gSl+P3YD1sOw/wxyiNFZ4hQVeXUowUrn
	OVvyHMSMLVEtz1QwXa4Y0SgfveQCO2ZvPhzf5tag2gZlZF9ZZV5pcorFB/1XoIBf
	on1sNDrui37JFA6+av+yiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299775; x=
	1761386175; bh=GLa6gPCC+lWCZEQhiymrSPFN6fIfuS4Gh1rMd2twLGE=; b=O
	vGZk3NNYA2g1JpMM6GbVAuEVfvOFlcxUnoxaG/b2ybS+NunWhtgW/rwtWFAyX40a
	keC83HkWitNUoOXptS2VUUWFyFa1QJV4tI+2Sov4I63g17eYCjlJ3hTEkQyekEJs
	YzRHaB0H7KdTI4lo2nimLYBeqrr5AysCsAzp2ZKzfN2Skh9FWOVkKT1Y6ieII00i
	3qwvtgfYdCaPdpLJaonvWozYklxzozB8FZVYm1Qbb1DI7dO0pyD9scZZ/if3v0VQ
	KwfY6GwKBC7KfdsoovpDjNsOc0xFP8I9wuw517VjnzTOITrNcvpcGf3onsc0NlLh
	K55SGLJXyugh+op6uOcbw==
X-ME-Sender: <xms:P037aO0UAYTayqjryKnzT8jvCrNVWkDlBQXKSoL9aWWYt_PgZvvEQg>
    <xme:P037aIDrXqQqxcXbo5q3pyP101FRrPqP3Rx2kqnXEZOECoc5mrCyZfyrZWhUhyO8o
    V7DMz07Gdnz8eNXLPvFZhE9buR-G5lkp0osaiDe0B1ZHITf37Tj63w>
X-ME-Received: <xmr:P037aMiwIdrReKfQ8xDGIvt1vW8ZBzHeNtsRFHoODhtTansXBffxafqVt-zCGclf-QEyRIdcC3ZXy0nKGibRDoJG9z-LtaNQM-4O4HaaFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:P037aE92AfbnSB1mwIikps7FN6Qh5KVs-peoml86Um1H56VDiZpFlA>
    <xmx:P037aA9P40JpsN-OteS1OyQs_FE9uqwZlHOm1edLhGpFp8mPmiRg9Q>
    <xmx:P037aFAQT1kUyrAFTEaPhOivJxEmCTfUgtalQEkTWwFFAFfcKknlNQ>
    <xmx:P037aIzbEIjb7PouepT2Ci9bhj-T13pkeCP4pLKfN2RaW92HNhkmHg>
    <xmx:P037aIH3CxfJHxkvnrHh4XwS2hm2qUpqAxinPNwzBtemby43QNs1DJLl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a944b01 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:02 +0200
Subject: [PATCH 03/13] odb: adjust naming to free object sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-3-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The functions `free_object_directory()` and `free_object_directories()`
are responsible for freeing a single object source or all object sources
connected to an object database, respectively. The associated structure
has been renamed from `struct object_directory` to `struct odb_source`
recently though, so the names are somewhat stale nowadays.

Rename them to mention the new struct name instead. Furthermore, while
at it, adapt them to our modern naming schema where we first have the
subject followed by a verb.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index d2d4c514ae5..77490d7fdbe 100644
--- a/odb.c
+++ b/odb.c
@@ -365,7 +365,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	return source->next;
 }
 
-static void free_object_directory(struct odb_source *source)
+static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_clear_loose_cache(source);
@@ -387,7 +387,7 @@ void odb_restore_primary_source(struct object_database *odb,
 		BUG("we expect the old primary object store to be the first alternate");
 
 	odb->sources = restore_source;
-	free_object_directory(cur_source);
+	odb_source_free(cur_source);
 }
 
 char *compute_alternate_path(const char *path, struct strbuf *err)
@@ -1015,13 +1015,13 @@ struct object_database *odb_new(struct repository *repo)
 	return o;
 }
 
-static void free_object_directories(struct object_database *o)
+static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
 		struct odb_source *next;
 
 		next = o->sources->next;
-		free_object_directory(o->sources);
+		odb_source_free(o->sources);
 		o->sources = next;
 	}
 	kh_destroy_odb_path_map(o->source_by_path);
@@ -1039,7 +1039,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph = NULL;
 	o->commit_graph_attempted = 0;
 
-	free_object_directories(o);
+	odb_free_sources(o);
 	o->sources_tail = NULL;
 	o->loaded_alternates = 0;
 

-- 
2.51.1.930.gacf6e81ea2.dirty

