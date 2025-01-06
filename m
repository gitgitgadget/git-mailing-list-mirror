Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40691D90D9
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155475; cv=none; b=bTF78n0qJ54JyRNroWju2Slx382/Go8ts76cMEgUtRw4y7h6G/a3X/yEikw7iWmLj2s8B9BHughn5TOJ4Iu0FqdyE+XQwbwy8iEFh7rncmTjt0J6qHoS+GL1z1pdSarj5IJUnosCfR3y6Pm84kqJ4JJpWpu8xTD8oD9sWvtER3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155475; c=relaxed/simple;
	bh=Y6nuYeT+OIkjBsJQ4e4nwYRfG5kuH7DQnOq0Hf1EHhA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=oawsXrqSBYa+rszILJg8yXkDD5NqjGyXjY2PGVNlbDuUBt44QPjDo23VqfDH4J/stMsKoRc6ggxJP+h5QurMF/+3A3+49VTnOuANTgwceLYOyLYUQ7Q+gO3gyLlbsdftkDcaUjEm2+QW6MeuXeKsL+PynmSDkxw8jvWXo2HfG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tA+F5+N6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d4S/wWQi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tA+F5+N6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d4S/wWQi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F2B8913809AF;
	Mon,  6 Jan 2025 04:24:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 04:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736155471;
	 x=1736241871; bh=TZA0VgulA+biIPMcf6xt5sk11vWDAoSW1DGcI7cm4d4=; b=
	tA+F5+N6eq1wp6nfL0eOczyDnkJpCU5xiQH4e4rUabczu8+o68ftA3bro6De4jzm
	akfL+awUebSQMJIuhjr+y6ayhmPJDEbo4Gn0+vJ7mI7XqGoMecXWJ1PTyp631yyy
	BBPClZWIFSqWL/vdrVkDCRZUKOedjPlx7iEnT7o9tDpNl8ES1A9uR1O46gcF916Z
	c6g8QNvO2GdNz7I0GMsxgfY+UGP14eQ3yL8eTGCXJ58z4K3hBhBvUc4p7WJ3Qk3C
	hl8HL3Pmea/+pnfiN5SqFQxJpzgSqVOLGf7sMp31L7farQFOeLU3VhxxPLAPCNzr
	JgTCpmUPCDOOzKQ1GCr8nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736155471; x=
	1736241871; bh=TZA0VgulA+biIPMcf6xt5sk11vWDAoSW1DGcI7cm4d4=; b=d
	4S/wWQiMJz1VpvQ8rzzWbQKXEvEgeopXqksBpuU7+GsTs4Zi8U301+i6hbP5RwEw
	H1LS5/Ewi4rvqDFhaxUUcNiwRjmb/C5N3AadFgFPlzSb51iuAzUaBChypwLkv7b6
	LnOTHUE1W0/qU6AXOPXtd5xAvb01gPq6pnbdTaqCi3D680t5VKfBo0RJtIfDHIAU
	C/HWOk9GRHXciR5QfaYmkMY4/woFxdFvq7DUjLljs1DHzIVnkdpF5opGOzTnFrkF
	QzUS5zTR8IS4P8NhfOsrELpYHbalxwR5q3zoaH6XIiXCiWqYYqzazZW/hgnGGOcq
	QDkx0WGMyuhrdDTvAVuZg==
X-ME-Sender: <xms:T6F7Z277MlCPct1tuPsjDkQsSeewM8uQGR-8eBktLx_hRTWZ7wz5Ww>
    <xme:T6F7Z_7992hVdAF7HuI087h7EIXfXFEqWu8c54ktLUm9qiNcT9oZ4tH02V3Ojmqiv
    DSj5ugdXZGC3Pr5qw>
X-ME-Received: <xmr:T6F7Z1exUeFK37nirFGlAQBfZGQfirv009RIXBa852-b_7MpnIaaJnBEWoZPNOT6s8aVgoL-DFi54fG_6EWIz4ClLXEEc_WB_CqC5UkBY5dhHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhf
    fhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:T6F7ZzIYNIgAJvUmG_OliHecfcgADYSLpM_PFX4D4jEXsRQrV4XuXg>
    <xmx:T6F7Z6L9RrLu17FFaMHPWvkT8IFMG0akbrBuJVKKCLz0hqi-QCtH6w>
    <xmx:T6F7Z0wmWH51RAAR732rcb3fr43UTcf5aoq-QqPp7l-pMYtlr3Ncpg>
    <xmx:T6F7Z-InnqYFX5cBlHzQQ2ff_V6zcloNF21iRfBMYjZyMsHKzDiRZA>
    <xmx:T6F7Z22JyqvzOtaN9pc9MdI12o6LkDXhFrrFSJeEwaZiLEJGKLrzvYuf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 04:24:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7c36e77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 09:24:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] object-file: retry linking file into place when
 occluding file vanishes
Date: Mon, 06 Jan 2025 10:24:24 +0100
Message-Id: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEihe2cC/5WNQQ6CMBBFr0Jm7Zi2IlpX3sOwaMtURpCSlhAJ4
 e5WbuDy/eT9t0KiyJTgVqwQaebEYcigDgW41gxPQm4ygxLqLKQ4oS1x7BIG+yI3oeeeMBq3oAt
 9v9voWnIdmqrU1npdGa0gv42RPH/20qPO3HKaQlz28Cx/6/+NWaLAirwm1Rjpr5d71o78hnrbt
 i9Em6WN2wAAAA==
X-Change-ID: 20250103-b4-pks-object-file-racy-collision-check-a649bbf96a92
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series adapts the race fix for collision checks when
moving object files into place [1] to retry linking the object into
place instead of silently ignoring the error, as suggested by Peff in
[2].

The series at [1] has already been merged into 'next', so this is built
on top of 1b4e9a5f8b (Merge branch 'ps/build-meson-html', 2025-01-02)
with ps/object-collision-check at 0ad3d65652 (object-file: fix race in
object collision check, 2024-12-30) merged into it.

Changes in v2:

  - Add retry counter so that we eventually abort in case the colliding
    files repeatedly reappears and vanishes again.
  - Evict the change to stop handling ENOENT for the source file specially
    into a separate commit.
  - Commit message improvements.
  - Link to v1: https://lore.kernel.org/r/20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im

Thanks!

Patrick

[1]: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
[2]: <20241231014220.GA225521@coredump.intra.peff.net>

---
Patrick Steinhardt (3):
      object-file: rename variables in `check_collision()`
      object-file: don't special-case missing source file in collision check
      object-file: retry linking file into place when occluding file vanishes

 object-file.c | 66 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

Range-diff versus v1:

1:  389b9e4180 = 1:  0c38089e9f object-file: rename variables in `check_collision()`
-:  ---------- > 2:  d4a7ec11c8 object-file: don't special-case missing source file in collision check
2:  91a8bdf37d ! 3:  587fd01fb6 object-file: retry linking file into place when occluding file vanishes
    @@ Metadata
      ## Commit message ##
         object-file: retry linking file into place when occluding file vanishes
     
    -    In a preceding commit, we have adapted `check_collision()` to ignore
    -    the case where either of the colliding files vanishes. This should be
    -    safe in general when we assume that the contents of these two files were
    -    the same. But the check is all about detecting collisions, so that
    -    assumption may be too optimistic.
    +    Prior to 0ad3d65652 (object-file: fix race in object collision check,
    +    2024-12-30), callers could expect that a successful return from
    +    `finalize_object_file()` means that either the file was moved into
    +    place, or the identical bytes were already present. If neither of those
    +    happens, we'd return an error.
     
    -    Adapt the code to retry linking the object into place when we see that
    -    the destination file has racily vanished. This should generally succeed
    -    as we have just observed that the destination file does not exist
    -    anymore, except in the very unlikely event that it gets recreated by
    -    another concurrent process again.
    +    Since that commit, if the destination file disappears between our
    +    link(3p) call and the collision check, we'd return success without
    +    actually checking the contents, and without retrying the link. This
    +    solves the common case that the files were indeed the same, but it means
    +    that we may corrupt the repository if they weren't (this implies a hash
    +    collision, but the whole point of this function is protecting against
    +    hash collisions).
     
    -    Furthermore, stop treating `ENOENT` specially for the source file. It
    -    shouldn't happen that the source vanishes as we're using a fresh
    -    temporary file for it, so if it does vanish it indicates an actual
    -    error.
    +    We can't be pessimistic and assume they're different; that hurts the
    +    common case that the mentioned commit was trying to fix. But after
    +    seeing that the destination file went away, we can retry linking again.
    +    Adapt the code to do so when we see that the destination file has racily
    +    vanished. This should generally succeed as we have just observed that
    +    the destination file does not exist anymore, except in the very unlikely
    +    event that it gets recreated by another concurrent process again.
     
    -    Suggested-by: Jeff King <peff@peff.net>
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## object-file.c ##
    @@ object-file.c: static void write_object_file_prepare_literally(const struct git_
      static int check_collision(const char *source, const char *dest)
      {
      	char buf_source[4096], buf_dest[4096];
    -@@ object-file.c: static int check_collision(const char *source, const char *dest)
    - 
    - 	fd_source = open(source, O_RDONLY);
    - 	if (fd_source < 0) {
    --		if (errno != ENOENT)
    --			ret = error_errno(_("unable to open %s"), source);
    -+		ret = error_errno(_("unable to open %s"), source);
    - 		goto out;
    - 	}
    - 
     @@ object-file.c: static int check_collision(const char *source, const char *dest)
      	if (fd_dest < 0) {
      		if (errno != ENOENT)
    @@ object-file.c: int finalize_object_file(const char *tmpfile, const char *filenam
      {
     -	struct stat st;
     -	int ret = 0;
    ++	unsigned retries = 0;
     +	int ret;
     +
     +retry:
    @@ object-file.c: int finalize_object_file_flags(const char *tmpfile, const char *f
     -		    check_collision(tmpfile, filename))
     +		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
     +			ret = check_collision(tmpfile, filename);
    -+			if (ret == CHECK_COLLISION_DEST_VANISHED)
    ++			if (ret == CHECK_COLLISION_DEST_VANISHED) {
    ++				if (retries++ > 5)
    ++					return error(_("unable to write repeatedly vanishing file %s"),
    ++						     filename);
     +				goto retry;
    ++			}
     +			else if (ret)
      				return -1;
     +		}

---
base-commit: 2be278337fd02495a86577a89fbf9387b2df6523
change-id: 20250103-b4-pks-object-file-racy-collision-check-a649bbf96a92

