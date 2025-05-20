Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E020E6E2
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734801; cv=none; b=Qmwz5EG7mWKc75tasjuiDkC114A9yX/csQoH18FVYQrGLQsKCrBRcZ5sSQhUOcSWjgz0TFYfAY5bBvgFBRpuWcBbm1vfpGjLFf7TYDxj83g6FFao8VTIGWnEefAXuMd8dDspA6EaqUwIcPDGE0eYXfeW7IItjxPYYSiBls/KGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734801; c=relaxed/simple;
	bh=SOT1ilVW3ckCAd9mrOUczSeaUs80dXn8psaapsKaUOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtPh6SzdaH8CdvaVjrWsN33q5UjaxidaxbF84oRiyRxvpmDN1+QdsQ/isT54hCHrjlpG9duRkYpBX+iLF+Gojt+IqlEMfQWiXvpOJXKZnc1EZIowCKrRecAa2aytKU5+OTHBax+ED5L8r6G0gOLLTQBqpL5W84Ien2I4KMWegZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EAQLtmWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfN2Z5GD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EAQLtmWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfN2Z5GD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 558D7114014D;
	Tue, 20 May 2025 05:53:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 05:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747734798;
	 x=1747821198; bh=TcH4w7zN5lN71BGqfhTGvE7kYUfEM4OJ8+hc3rXvWxs=; b=
	EAQLtmWTD4TT7j4fWkSrx1R14Z6E/TQfFYFf+UHGHoociFGAC7FkJhH0oX444w0U
	dg1S7EfURB6bb51CB8cRagKKBgFzmiHd5j5KOcYoh/UnZoFXhgpgo2z3fP1LBd3i
	02ZbSpog6b+hpji0WGjrREYm00/BnMbJCi8XJCp2g12HEaT9uR7LYH+HreMpjJnQ
	Ki5oZXv7D3MkPObxSF4tcrEg8SUCKm1CQC6snprgBWbA674C64SXRRTyMEwEhzQx
	sHdBuyAlufddi9n5kVD2qI0PTFJ3jCGOar9EzAUSrkXMNwnNCzj1VTJvb575uPti
	6vRdMshOGASEa3pYHQobHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747734798; x=
	1747821198; bh=TcH4w7zN5lN71BGqfhTGvE7kYUfEM4OJ8+hc3rXvWxs=; b=P
	fN2Z5GD6JTiGyOJwaCyE/MmYz8AvP6B3A1RWN8//44FsxmwkHfagWAicPGINvKN6
	xWq7pMX0c4yiu7VJF/ijK5qdbyicy4Z7LFAjwWYdwGuH9JlCTiNkKaSjd0IsJmbp
	3oYLPUVEgZZjD/E2Rq+QJhy3AwMK9wnD2WI7Fx5I1/5IFwDobSc6VlaYZzhlrSpw
	7tM/5fbHcHhvAhHqXQJl0ZQEeDtNm4ohor9opHs83gqECuZY3BJgGYvvQLGcuoyj
	Tf9691hFDIcLZHTyW43KrnKi2fxTJFCFbj9Qw5mpD9o1Njnf98xdi6hUFXCwQYRF
	+vMZsYjsRLXWzlVumxKsw==
X-ME-Sender: <xms:DlEsaD90OM3gty5h6xyNfQP6wjJukRTtCKh1gfuBAAK9dHbEDUsRdQ>
    <xme:DlEsaPs0hC1xvcNo0ZRjoMYYLdKZ76E5aZW6Z1ICbLfT-jfRzRp9yWDrowTdF2BU0
    dVIe9OGDuOEg-urqg>
X-ME-Received: <xmr:DlEsaBBpqKFK0l2wh3TDiQrRy46Ujoz7_o8betmryl6HIr8GF1pLQCcG--YED16OxqgWTzDERyIfKc5evw-NaqA0fUy-nFV0OBEhbxB7xHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefhue
    egleehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DlEsaPeHvCKLj-BQrZPlZJ-oVGs2pvpAiVxugxlIp1AiSm6CWMcXgw>
    <xmx:DlEsaIOSZfKMUKwIFUdK8ok8XpUVcFkHf8gPEvXy--wa5B1HMiVtsQ>
    <xmx:DlEsaBmwi6KBXb12GPPxe0WiGQnaewDbi8EKBs_0HDQ3LfjyLgcC7w>
    <xmx:DlEsaCsCWi1zUdClAJ6BZEmVuV7N_NCwwudE7bB9cqHyRY0c8CO9qw>
    <xmx:DlEsaM69q4ZTG-x87GzIN4qEvClMrVWOSioCD-Qf7IqPwbwPfQ1BtijA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 05:53:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 615f1483 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 20 May 2025 09:53:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 May 2025 11:53:10 +0200
Subject: [PATCH v2 2/2] midx: stop repeatedly looking up nonexistent
 packfiles
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-pks-pack-avoid-stats-on-missing-v2-2-333c5217fb05@pks.im>
References: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
In-Reply-To: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The multi-pack index acts as a cache across a set of packfiles so that
we can quickly look up which of those packfiles contains a given object.
As such, the multi-pack index naturally needs to be updated every time
one of the packfiles goes away, or otherwise the multi-pack index has
grown stale.

A stale multi-pack index should be handled gracefully by Git though, and
in fact it is: if the indexed pack cannot be found we simply ignore it
and eventually we fall back to doing the object lookup by just iterating
through all packs, even if those aren't indexed.

But while this fallback works, it has one significant downside: we don't
cache the fact that a pack has vanished. This leads to us repeatedly
trying to look up the same pack only to realize that it (still) doesn't
exist.

This issue can be easily demonstrated by creating a repository with a
stale multi-pack index and a couple of objects. We do so by creating a
repository with two packfiles, both of which are indexed by the
multi-pack index, and then repack those two packfiles. Note that we have
to move the multi-pack-index before doing the final repack, as Git knows
to delete it otherwise.

    $ git init repo
    $ cd repo/
    $ git config set maintenance.auto false
    $ for i in $(seq 1000); do printf "%d-original" $i >file-$i; done
    $ git add .
    $ git commit -moriginal
    $ git repack -dl
    $ for i in $(seq 1000); do printf "%d-modified" $i >file-$i; done
    $ git commit -a -mmodified
    $ git repack -dl
    $ git multi-pack-index write
    $ mv .git/objects/pack/multi-pack-index .
    $ git repack -Adl
    $ mv multi-pack-index .git/objects/pack/

Commands that cause a lot of objects lookups will now repeatedly invoke
`add_packed_git()`, which leads to three failed access(3p) calls as well
as one failed stat(3p) call. The following strace for example is done
for `git log --patch` in the above repository:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     74.67    0.024693           1     18038     18031 access
     25.33    0.008378           1      6045      6017 newfstatat
    ------ ----------- ----------- --------- --------- ----------------
    100.00    0.033071           1     24083     24048 total

Fix the issue by introducing a negative lookup cache for indexed packs.
This cache works by simply storing an invalid pointer for a missing pack
when `prepare_midx_pack()` fails to look up the pack. Most users of the
`packs` array don't need to be adjusted, either, as they all know to
call `prepare_midx_pack()` before accessing the array.

With this change in place we can now see a significantly reduced number
of syscalls:

    % time     seconds  usecs/call     calls    errors syscall
    ------ ----------- ----------- --------- --------- ----------------
     73.58    0.000323           5        60        28 newfstatat
     26.42    0.000116           5        23        16 access
    ------ ----------- ----------- --------- --------- ----------------
    100.00    0.000439           5        83        44 total

Furthermore, this change also results in a speedup:

    Benchmark 1: git log --patch (revision = HEAD~)
      Time (mean ± σ):      50.4 ms ±   2.5 ms    [User: 22.0 ms, System: 24.4 ms]
      Range (min … max):    45.4 ms …  54.9 ms    53 runs

    Benchmark 2: git log --patch (revision = HEAD)
      Time (mean ± σ):      12.7 ms ±   0.4 ms    [User: 11.1 ms, System: 1.6 ms]
      Range (min … max):    12.4 ms …  15.0 ms    191 runs

    Summary
      git log --patch (revision = HEAD) ran
        3.96 ± 0.22 times faster than git log --patch (revision = HEAD~)

In the end, it should in theory never be necessary to have this negative
lookup cache given that we know to update the multi-pack index together
with repacks. But as the change is quite contained and as the speedup
can be significant as demonstrated above, it does feel sensible to have
the negative lookup cache regardless.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 3d0015f7828..fbce88bd463 100644
--- a/midx.c
+++ b/midx.c
@@ -405,7 +405,7 @@ void close_midx(struct multi_pack_index *m)
 	munmap((unsigned char *)m->data, m->data_len);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (m->packs[i])
+		if (m->packs[i] && m->packs[i] != (void *)(intptr_t)-1)
 			m->packs[i]->multi_pack_index = 0;
 	}
 	FREE_AND_NULL(m->packs);
@@ -458,6 +458,8 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 
 	pack_int_id = midx_for_pack(&m, pack_int_id);
 
+	if (m->packs[pack_int_id] == (void *)(intptr_t)-1)
+		return 1;
 	if (m->packs[pack_int_id])
 		return 0;
 
@@ -482,8 +484,10 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_release(&pack_name);
 	strbuf_release(&key);
 
-	if (!p)
+	if (!p) {
+		m->packs[pack_int_id] = (void *)(intptr_t)-1;
 		return 1;
+	}
 
 	p->multi_pack_index = 1;
 	m->packs[pack_int_id] = p;
@@ -495,6 +499,8 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id)
 {
 	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+	if (m->packs[local_pack_int_id] == (void *)(intptr_t)-1)
+		return NULL;
 	return m->packs[local_pack_int_id];
 }
 

-- 
2.49.0.1151.ga128411c76.dirty

