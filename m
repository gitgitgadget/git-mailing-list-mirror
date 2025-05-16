Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C922DA1B
	for <git@vger.kernel.org>; Fri, 16 May 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385717; cv=none; b=MnOS4rHWzW9XgG6LzDZRVZCEuyOfeAfFd9BzpOF4Itea9nc8ZIP+CjZs0cbD8FKgRW6CaYdRkpY5cswzXKJpL97lRyYwNwEyrhtJtK4NsROsySXi520ZT0DWyjJqxBxAfpwcbKFNFqGyVB5sjd89lTQRpZSWTvUqyD/84buEVg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385717; c=relaxed/simple;
	bh=+ETVTx6JHcKR8eakNaY0KESxsKuEl1gM42jrDjfmSv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gj4F5voQgsIEGXRTfFYQosRao8v1agvt4ZLISAh7i74gXCgpL2I/dmiwJqmYqjI/JgVO9fTistTWeCNHnT86oTDh+TSDJIUJH9GMJu3MH++uYTpPs4GvBzNS/bouaLOk8pI3GneSzb3QYVKv6IMDqlVUZ89WFKexSzP71ZcCtnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vb46RhAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rPMqw/WS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vb46RhAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rPMqw/WS"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C708E1380422;
	Fri, 16 May 2025 04:55:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 May 2025 04:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1747385713; x=1747472113; bh=4Y1fZUU2UC
	xvT3HZ7DTvJ7QWeCt27avxLIoEz9qdBEE=; b=vb46RhAtKdfQJM6fSHka1EwrOD
	FScayZBu8jYJIlHPa8PIXIWbcPG9bD/m0EIsoTz1G6HWs+X3OmK8Rsyb/auSU+91
	lbZZ2pxwhGI+ScoIJZFh98kKLLrtR1FRicU+kqkizfb24TAgpgcQ3E9ZeniG1hgT
	wvZMq8c4EFqmBUAast7Hm35kUKJJL/dCktMM/T5mMVRpt2uyc0R7DBO+dKW8oaxR
	fRpXgLjUA0OGQ/7hLfvh9gGW6vAqMUnqfyh9Mv+U6TG2aIZbFQrPhtPgNpo2CHjB
	D9QmrIFcNmik4temDHlp0Yj2d0OvhWXEiyEt0RERtdeQ1BD7bGCnIfpA9ZDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747385713; x=1747472113; bh=4Y1fZUU2UCxvT3HZ7DTvJ7QWeCt2
	7avxLIoEz9qdBEE=; b=rPMqw/WStrPZGhs9HqNKdX7M0hGLBfpJHdsEt9MXX42R
	2ohr/smMyNL/aHykWc98CoW8MWtueLixlNm1UcJ4X2uwVET29hSrE4MflXpUL7eQ
	ezQjLJopr5Iv4Vxsv1yF5b4Q74I6CDeBX0qaa+D2Nzvvt3VukgwxA01aaqGZNdNB
	x5ouz3d8m5ntCc/FXO+/3EweExCn20961GBw9Wy5V2EvXYLN0wid2TQ1NIqfM08z
	FRSQM3B1h7gEmN78nO5H8N8l7cjCqk78bupT642i4srLJvPEhvZO2HppzBQWMPrb
	RzDUHlSVCfK0sDRiC98j2oPcJBeeMdzvkLZFq+SJBg==
X-ME-Sender: <xms:cf0maLIzl_f5pBiA3LzudOck2y8aQuPlrcf_DaONPDBslmBPd_BSpA>
    <xme:cf0maPIK4Y_DcBame9-QsXdz2vrSKtaMMRuw4U83aAEfWeHzcpSytY0u6LC3MNznM
    VvxHgUAtIJWRnsZ1A>
X-ME-Received: <xmr:cf0maDttH10i9JjlkUk78UqWDx3EOkA_-ddZeLy6V14O4JXiWUxwsgIErnxz4PPVb43Ugfar91GMq49fhoA97YJJ1uOF3N_emRNsqFSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepiefgiedtff
    ffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:cf0maEbwywPdei1SrFGLZ7awtZaGSB-MEOMhs7msujiFGFwlRSkveg>
    <xmx:cf0maCb2f0i7aUCBVr99z-nkUQz7zfEqSJq5G7MI-4nur2LBIftgVg>
    <xmx:cf0maICOkDVjfVWK7l17R8YQEOznBIfBDpF7Kve9xuzjQB9h1u9gZw>
    <xmx:cf0maAY-MX88pozdgYX3D2qXgjvEKb_cO3c0aNssp_rjeOWG3sap3w>
    <xmx:cf0maMCyiv8JK_AGHczq2GDWlQs2xSiL-IKOXP8iEzu0uXF8B6RKEXh7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 04:55:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0caef0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 08:55:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 16 May 2025 10:55:10 +0200
Subject: [PATCH] packfile: avoid access(3p) calls for missing packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-pks-pack-avoid-stats-on-missing-v1-1-e2ef4d8798a3@pks.im>
X-B4-Tracking: v=1; b=H4sIAG39JmgC/x3NQQqDMBBA0avIrDsQLVOLV5Eu0mRiB2kSMhIE8
 e4Gl2/z/wHKRVhh6g4oXEUlxYb+0YH72bgwim+GwQxkqH9hXhWzdSvamsSjbnZTTBH/oipxwTc
 /vyONRC4YaJVcOMh+H+bPeV5O/5s2cQAAAA==
X-Change-ID: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

The function `add_packed_git()` adds a packfile to the known list of
packs in case it exists. In case the packfile doesn't look like a pack
though, or in case it doesn't exist, the function will simply return a
`NULL` pointer.

The ordering in which those checks are done is somewhat curious though:
we first perform a couple of access(3p) syscalls for auxiliary files
like ".keep" before we determine whether the ".pack" file itself exists.
And if we see that the ".pack" file does not exist, we bail out and thus
effectively discard all the information. This means that the access(3p)
calls were a complete waste of time.

The reason why we do this is likely because we reuse `p->pack_name` to
derive the other files' names, as well, so that we only have to allocate
this buffer once. As such, we have to compute the packfile name last so
that it doesn't get overwritten by the other names.

All of this likely doesn't matter in the general case: Git shouldn't end
up looking too many nonexistent packfiles anyway. But there are edge
cases where it _does_ matter. One such edge case that we have hit in our
production systems was a stale "multi-pack-index" file that contained
references to nonexistent packfiles. As there is no negative lookup
cache this causes us to repeatedly look up the same packfiles via the
multi-pack index, only to realize that they don't exist. This translated
into hundreds of thousands of syscalls to access(3p) and stat(3p).

While the issue was entirely self-made because the multi-pack index
should have been regenerated, we can still reduce the number of syscalls
by 75% in the case of nonexistent packfiles by reordering these calls.
This requires us to restore the final packfile name after the access(3p)
calls. But given that this is a mere memory copy it is very unlikely to
matter in comparison to the four syscalls we performed beforehand.

Another mitigation would be to introduce a negative lookup cache so that
we don't try to add missing packfiles repeatedly. But that refactoring
would be a bit more involved for dubious gains, so for now the author
has decided against it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch addresses an issue we have recently seen in our production
systems due to a stale MIDX. The MIDX contained entries for packfiles
that didn't exist anymore, which caused Git to repeatedly look up those
packfiles. Each missing packfile resulted in four repeated syscalls:
three access(3p) calls to check for supporting data structures, and one
call to stat(3p) to check for the packfile itself. The first three calls
are essentially wasted though when the stat(3p) call itself fails, which
is being fixed by this patch.

I doubt that the patch matters in almost any repository, but given that
the refactoring is trivial I thought to submit the patch regardless of
that. Another step would be to introduce a negative lookup cache -- but
that would be a bit more involved, so I decided against it for now as I
don't want to introduce complexity for dubious gains.

Thanks!

Patrick
---
 packfile.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index d91016f1c7f..870d48bd949 100644
--- a/packfile.c
+++ b/packfile.c
@@ -737,6 +737,12 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	p = alloc_packed_git(r, alloc);
 	memcpy(p->pack_name, path, path_len);
 
+	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
+	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
+		free(p);
+		return NULL;
+	}
+
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
 	if (!access(p->pack_name, F_OK))
 		p->pack_keep = 1;
@@ -749,11 +755,8 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	if (!access(p->pack_name, F_OK))
 		p->is_cruft = 1;
 
+	/* Restore the final packfile name. */
 	xsnprintf(p->pack_name + path_len, alloc - path_len, ".pack");
-	if (stat(p->pack_name, &st) || !S_ISREG(st.st_mode)) {
-		free(p);
-		return NULL;
-	}
 
 	/* ok, it looks sane as far as we can check without
 	 * actually mapping the pack file.

---
base-commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
change-id: 20250516-pks-pack-avoid-stats-on-missing-8e3b75755cf0

