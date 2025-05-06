Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1741C71
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558045; cv=none; b=PeR866ECZabx8BBYLttTnKg8anU3NzBkBsMHmdJ86/07EmxNxpr3IRvfu3z0tvxhGN24vnHk2k7XqSwuCqUkK9LHLPKUFSpkweVRbaU1N4L4i+e0992rMPenjPo/wvYwDpLoQrkr7522QWcgU15yodytqFW3xLUKGUwabohnncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558045; c=relaxed/simple;
	bh=CJ2au3zxxGsQfgh1bLEyljMaME6b5qjmKrjTg/wuK+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYcBnIDuhEpiWy8KMIOGB+DH6xIHdQFBCq7FwY3bOa6T/aVLiRgt/MLCHii5gSv2f+ccEsmffPyKtrRzI6DHfKYNuLxAxU864zA9gGNyugu5qI9bpPcsbmfiD82f/HCD5nyT+0SL4/4oWPHzogXQg+XaMTlxP+oNH9rNW8Csjws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KaHAvy94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wa6LcmY1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KaHAvy94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wa6LcmY1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1503A1140230;
	Tue,  6 May 2025 15:00:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 15:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746558041; x=1746644441; bh=cPEGQ4+I7Z
	BfzdyX2C/Jm+1kTyug9o1bLl6/JY1IzNY=; b=KaHAvy94WOPHYKKu5j6tdPiSXe
	DK7dq1FnJ1dV3eMz3m4rfYTXypZ7hScteRrFwzJsRy3tZxLZp85L6afElxWIqcy2
	8fPhG/y8Ze8AwRjJ3QjjReWV5Lz3X+xOpsh9ce/XF17pNJosytDSbJL0IwV86M85
	0ski/NR5uaDfTUwVZ5DaKTGFEfs0H9D9gldXv738MiOEGpOsxy4B8uZOvUwaoHrr
	1/IpXx+PHuGzVszvEViGB4aeMHUpWyLa/FvZVaSFUQlnFAwA9prJupLesjskMhaV
	S+Dz9vuXwxOhcYHrAKSEDEOWcT+C0n8fIBEx6UADBll7/9SWzLZNDCovkLlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746558041; x=1746644441; bh=cPEGQ4+I7ZBfzdyX2C/Jm+1kTyug9o1bLl6
	/JY1IzNY=; b=wa6LcmY1VAcI6ZCPpIfspqqKJ/SbxltYthtsMPtP8gr8eI5EfBV
	tWX+kcBPOfCg4BSb9J33XOztmGe9T7a2Z6/VXGgfPe11yc/VIgy6kx8eN4CUgXXd
	kp8/+f2KCQFr3H8lum5PVuz1yovQVD9dBR0zjg2g5/QzrvJoqf5b1gZYjBuEvCUE
	M2XFT7+i2gVndADYxcvgafuX5wWp0AOKlkxse7zPDpo49NKk9gHZM88nBlsjheZF
	VqVMGFK4311rtKPOvXHMH+qZ/Zo5K6Z62Bryo+1fhoo1AE5LxsCm8ywqIitLjN0o
	BHr67gxFjBQiLQK7aQGM+gvP4ss5rmHNSkg==
X-ME-Sender: <xms:WVwaaP-MymX7IHH5L-67fg05Ff4XCGtoRZwNLBLRnsYZjkCeY2GJzA>
    <xme:WVwaaLs-9bZL9Bbyqh-aZw5MzujWLqkTmnahvjD-jXykFjv-9HeMAcLbWRwiAkb91
    j4Wr1MM_sKQOLFjrQ>
X-ME-Received: <xmr:WVwaaNAPjDJizkiY8mM9oIe30EdlMLu9itKDuT6b0Qs4KB8iAHxXTu-WOUpTusLyJTxPg62p1Zm4_7W811K13eQi9dtbx18S5vu6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WVwaaLcHe5TpCgJhr0uBaLmc69HHVuLVbodV9mtAz81AX5tdWh7vRQ>
    <xmx:WVwaaEN3SMwLIY--AVaNREGiFApUSNKDYA53fOf6xi8pBxrrBUVO9w>
    <xmx:WVwaaNmVq6IiTeVjZxzS2a7ibKpKMFCKoYQY9B6QgC41EX_2m0AC9Q>
    <xmx:WVwaaOtUWTDm9kyM2qPcX-brV5ioPllVSOYB4b6IcaDR_SNE9kiS_w>
    <xmx:WVwaaNZ4K6DVGTkSzn3TKmXDAvOaYHVjvyqRGXzEvKji4tThWLW3ghzq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:00:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH 4/4] packed-backend: use mmap when opening large
 "packed-refs" file
In-Reply-To: <aBo7tOkheM6zOJpe@ArchLinux> (shejialuo@gmail.com's message of
	"Wed, 7 May 2025 00:41:24 +0800")
References: <aBo7OiCKHTyT4DzH@ArchLinux> <aBo7tOkheM6zOJpe@ArchLinux>
Date: Tue, 06 May 2025 12:00:39 -0700
Message-ID: <xmqqecx1k1ig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> We use "strbuf_read" to read the content of "packed-refs". However, this
> is a bad practice which would consume a lot of memory usage if there are
> multiple processes reading large "packed-refs".

Neither this nor the commit title says that the issue is limited to
the code path that runs fsck on packed-refs file, but I thought the
code paths to use packed-refs to resolve refs correctly uses mmap()
and does not share this issue?  If it is limited to one single code
path, please mention it explicitly.

Also, I think it was already pointed out that "multiple processes"
is not all that interesting issue.  Even if there is a single
process using a single large packed-refs file, alloc+read gives the
system more memory pressure than the read-only mmap like we do.

As to the title

	packed-backend: use mmap when opening large "packed-refs" file
	packed-backend: mmap large "packed-refs" file during fsck

would be shorter and clearer.

The patch looks OK.  Nice to see this one-off strbuf use going away.

> -	struct strbuf packed_ref_content = STRBUF_INIT;
> +	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
>  	unsigned int sorted = 0;
>  	struct stat st;
>  	int ret = 0;
> @@ -2121,21 +2121,21 @@ static int packed_fsck(struct ref_store *ref_store,
>  	if (!st.st_size)
>  		goto cleanup;
>  
> -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> -		ret = error_errno(_("unable to read '%s'"), refs->path);
> +	if (!allocate_snapshot_buffer(snapshot, fd, &st))
>  		goto cleanup;
> -	}
> +	munmap_snapshot_if_temporary(snapshot);
>  
> -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
> -				      packed_ref_content.buf + packed_ref_content.len);
> +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot->start,
> +				      snapshot->eof);
>  	if (!ret && sorted)
> -		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
> -					     packed_ref_content.buf + packed_ref_content.len);
> +		ret = packed_fsck_ref_sorted(o, ref_store, snapshot->start,
> +					     snapshot->eof);
>  
>  cleanup:
>  	if (fd >= 0)
>  		close(fd);
> -	strbuf_release(&packed_ref_content);
> +	clear_snapshot_buffer(snapshot);
> +	free(snapshot);
>  	return ret;
>  }
