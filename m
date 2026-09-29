Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4323911C7
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709764; cv=none; b=QeouV2pVXJZMkSjUFGJjiekLtUM/kl/VRWUlzMDx6FMfGsULtxJPAn8Dz5tSzA2d0SOpeQ6ZZkMC0cIkyWkloGiI9kPIVNnnsME8z6ii2aKXV80zdkrcUHtR/spy3yFsbPd6oieClVopme7hNa9HMmgY/tSFR599ySmZYKbU+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709764; c=relaxed/simple;
	bh=Aam7W+uKEyttw+f9FKuLQNq7WiAcsjkLxlOh01wLLgE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEQzF7eZ/hX7/Alx6cQwMcBBWdpU9mPv9BcTnsvI8qzkFZn7H67XJxAIDOG/C9L4/wuB/7gcNLBHugotUfQ6rWZ8lGx6MKsMjMwOyuGBU2p/NTqG64br4MrYLw1LZHT++opH2xC89iGbZiHxTJnUvREA9uzLWwo3cHuLuSXos8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OHbXXyXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2BjbAbn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OHbXXyXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2BjbAbn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EDA8A1D004FC;
	Tue, 29 Sep 2026 15:22:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 29 Sep 2026 15:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790709761; x=1790796161; bh=ihDwvyKDlB
	jd23+yd+TOby3AURpbmjWIfNYF2XOWp4c=; b=OHbXXyXxTqq/rZL/tJ1tFaytQ0
	cb9XT3x6rhHOX/dVtMyK/C9H8lmtYfdmwK54KIy6UH9T2QlntcbZJ48tPTORM2QR
	o5nmqm6Yi4+3pBU/8/3FTObpRHrhZ8yzzMKr5XCVbe+al+rDa2aXldrJ9pFTnEnH
	nId37Zu+AoqNeC/SuTEL0PDOdTdIl1mXK0E3PlkOfEcJ+aZFsIlVLAt3VdcihQep
	apCNXasxCCleZJ/px/DKf041xqnMS9tll3OUFMqDxMKHv26gd1OPdqPbm9VqCn8G
	Zm01dvARzMuS2aBuVQyxAyhpAH0dyBRCdxalgtKYeMKz1aVCyaYUMmVk32Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790709761; x=1790796161; bh=ihDwvyKDlBjd23+yd+TOby3AURpbmjWIfNY
	F2XOWp4c=; b=R2BjbAbnx5Z1WSeBwWsjpuSKG9tetyvwT/VzKLB1goMx1555vc3
	C4aoIma16frVBtuLT34pBeamqFQ1yexRWTBtA/Ux6rZ6zTdOsS3crSYbcBJJhTr1
	vFExd1u8nXK6zvYRo52+MmgUU3587tBb2ncxfXHPQNR9kj6nbSWsjyGe/rn0UsI+
	ld8fCJuWL/aBouxVmsgZEZlUPEZfq8TX+eYf43Fsg0F+izTCZq9TjnAl1pKqU9OI
	TvdGW0XHukxE9sixbvuI3gB6u8t03f1x/wIpHZl6DMFt+hQHopETzhqXTm09K92u
	WkKUfLJ8KCkGguXPVUeXXyREbSU6myO9n7A==
X-ME-Sender: <xms:ARC8arjA6Zu2yq1HDO8gVz6_E3U-n9VgCRp-rcBHr3D7oKbvTiWm_A>
    <xme:ARC8avAeewKN4HVWmWzfgXd6Rh-3h4DTaJD0nwhCVdGayT9DSScHsyhEHC1qtogun
    6FAWJiZXfQf87Le4ztfGkto1y3uOlEff_py_Ruz8SLYfCKmuXwVO3Q>
X-ME-Received: <xmr:ARC8agHaYb-X-KPRr-5zQUQknvagVZa5Mutc3jFvSYf5B8_bAFKs4zcASYmU8OoyM4bG8jCci-F-QmrZLuWz9ixH8XsKtg4jUmIr>
X-ME-Proxy-Cause: dmFkZTGHU/ye+O9HaJdR4L9THBRzvf4lWVU9NwItgJ/SmWEInOfpQC6rqIb+J4/knEf1VV
    s480+F/ucNrXntumw1EF86iQ27tuCIn5SJ5LY7drcS2DTYxXTz9NuUfp8VSWxuFiq8piu/
    5c8tbORmpff9RtKz+JVHjJdQNQ14fEeB14fZVsZleZh1cem/bOQQ+zbBquefzpILckHKfH
    /mPLOtgdzzAmhgGusRX8ciQ4Lj04F/OwlL+s6YBkDB0XqV884/XmJR1pO6xE7M5pWaHW+B
    5Qs7WY+1xQULqLT9iWSB7Ky55CSXK9i1FvVA8boXIltbMlE8pRsFhkc0G087tPV2enDveA
    oDA+h9uf9PtHF67apSch5gOa8H8Ynr6id8wxzcll3xjyilmxeWAnkUxrfyJ04H4ledncfN
    6c/UEONf3pCAUQRCI2SAwgZUJ6o01BZmGbGJUUpbV7uGJ7h/pFcdVkR0YPicgE7eU+uvX9
    U635yGcs3bxByhf8tgN1Vcehfm3cvG/uhmkNC3kCxtFfHTpA1p9lTh40fyBNehdxzt0a9D
    SiT9tm0E5GC8dDudGqn08VYP6OVwXQsJGolmJ4O/JTT6fiXG83f91+nL1heTWTiaVgphRC
    2LWtgFRZgN0wFsdhpnkZIuNDWFyUBn+N2389rHIzSrSuNXSdAmk6qlT7SW8w
X-ME-Proxy: <xmx:ARC8anLGkhYlzRK6irb9DsgRLEPFtncQxb_O71jxt5k7cdgKSPypMw>
    <xmx:ARC8akkgIvW6vwjn66Q0dH4TKl0_Tx0fy75G3Nr-AXSWVH9MIUdBzA>
    <xmx:ARC8avSia2i_hnAOYjwdCOy1mZVsLeOl4aUPyPJzIhA9q98yNVa9JA>
    <xmx:ARC8amKtFoPwhUZynA6nwhcDAMMTvuhyB2g8oPJv3s0yaHrGDBQM2w>
    <xmx:ARC8aqAzWd-BmrFe3JxkyNdzD_DiqZKUYa7A14sSkgvR8d2kqlCVke8D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 15:22:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
In-Reply-To: <20260929065442.GD1697497@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 02:54:42 -0400")
References: <20260929064935.GA1276867@coredump.intra.peff.net>
	<20260929065442.GD1697497@coredump.intra.peff.net>
Date: Tue, 29 Sep 2026 12:22:39 -0700
Message-ID: <xmqqzewzg8w0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> After running an external merge driver, ll_ext_merge() reads the result
> back from a temporary file. We can do the same thing with much less code
> by using read_mmfile().
>
> As a bonus, note that read_mmfile() correctly uses xsize_t() to detect
> the case when we'd truncate the result.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  merge-ll.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/merge-ll.c b/merge-ll.c
> index dfed6411a8..7fab7c5438 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -201,8 +201,7 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  	struct strbuf cmd = STRBUF_INIT;
>  	const char *format = fn->cmdline;
>  	struct child_process child = CHILD_PROCESS_INIT;
> -	int status, fd, i;
> -	struct stat st;
> +	int status, i;
>  	enum ll_merge_result ret;
>  	assert(opts);
>  
> @@ -241,20 +240,10 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  	child.use_shell = 1;
>  	strvec_push(&child.args, cmd.buf);
>  	status = run_command(&child);
> -	fd = open(temp[1], O_RDONLY);
> -	if (fd < 0)
> -		goto bad;
> -	if (fstat(fd, &st))
> -		goto close_bad;
> -	result->size = st.st_size;
> -	result->ptr = xmallocz(result->size);
> -	if (read_in_full(fd, result->ptr, result->size) != result->size) {
> -		FREE_AND_NULL(result->ptr);
> -		result->size = 0;
> -	}
> - close_bad:
> -	close(fd);
> - bad:
> +
> +	/* We can ignore errors; result is left NULL/0 in that case. */
> +	read_mmfile(result, temp[1]);
> +
>  	for (i = 0; i < 3; i++)
>  		unlink_or_warn(temp[i]);
>  	strbuf_release(&cmd);

Lets see if I understand why we can safely ignore errors.

If the external driver claims that it successfully merged (i.e.,
status = run_command(&child) returns 0), and yet read_mmfile() fails
(e.g., perhaps the driver unlinks "%A"), read_mmfile() will leave
result->ptr and result->size as initialized, and we return
LL_MERGE_OK from this function.  The result is eventually relayed to
the caller of ll_merge(), like merge-ort.c:merge_3way(), or
apply.c:three_way_merge().  Both have something like

	status = ll_merge(&result, path,
			  &base_file, "base",
			  &our_file, "ours",
			  &their_file, "theirs",
			  state->repo->index,
			  &merge_opts);
	if (status == LL_MERGE_BINARY_CONFLICT)
		warning("Cannot merge binary files: %s (%s vs. %s)",
			path, "ours", "theirs");
	free(base_file.ptr);
	free(our_file.ptr);
	free(their_file.ptr);
	if (status < 0 || !result.ptr) {
		free(result.ptr);
		return -1;
	}

to treat that result.ptr==NULL is just as bad as any error from
ll_merge() (i.e., status < 0).

merge-blobs.c:merge_blobs() does not check the !result.ptr
condition, and its sole caller builtin/merge-tree.c:result() passes
the NULL to show_diff(), which uses a <NULL, 0> mmfile_t as one side
of xdi_diff(), which the callee is prepared to handle, so this is OK.

rerere.c:try_merge() does not check the !result.ptr condition, and
its caller rerere.c:merge() ends up calling

	fwrite(NULL, (size_t)0, 1, f)

which may happen to work on most systems, but is not exactly kosher.

Perhaps something like this on top might make it safer?  Not even
compile tested and I haven't thought through the ramifications to
rerere.c:merge() code path, that used to take such a bogus merge
result as successful merge and relied on the fwrite(NULL) becoming
a no-op to produce an empty file.

 merge-ll.c | 16 +++++++++++++---
 merge-ll.h |  4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git c/merge-ll.c w/merge-ll.c
index 7fab7c5438..518c05636f 100644
--- c/merge-ll.c
+++ w/merge-ll.c
@@ -405,6 +405,7 @@ enum ll_merge_result ll_merge(mmfile_t *result_buf,
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
+	enum ll_merge_result result;
 
 	if (!opts)
 		opts = &default_opts;
@@ -434,9 +435,18 @@ enum ll_merge_result ll_merge(mmfile_t *result_buf,
 	if (opts->extra_marker_size) {
 		marker_size += opts->extra_marker_size;
 	}
-	return driver->fn(driver, result_buf, path, ancestor, ancestor_label,
-			  ours, our_label, theirs, their_label,
-			  opts, marker_size);
+	result = driver->fn(driver, result_buf, path, ancestor, ancestor_label,
+			    ours, our_label, theirs, their_label,
+			    opts, marker_size);
+	if (!result_buf.ptr && result == LL_MERGE_OK) {
+		/*
+		 * Forbid the driver from giving bogus result and claim
+		 * that the merge succeeded.
+		 */
+		result = LL_MERGE_ERROR;
+		result_buf.size = 0;
+	}
+	return result;
 }
 
 int ll_merge_marker_size(struct index_state *istate, const char *path)
diff --git c/merge-ll.h w/merge-ll.h
index f95332c682..c5e11f397e 100644
--- c/merge-ll.h
+++ w/merge-ll.h
@@ -23,6 +23,10 @@
  *
  * - Call `ll_merge()`.
  *
+ * - Notice a merge error by checking return value from ll_merge().  If the
+ *   .ptr member of the result is NULL, that may indicate that we failed to
+ *   read the merge results from an external merge driver.
+ *
  * - Read the merged content from `result_buf.ptr` and `result_buf.size`.
  *
  * - Release buffers when finished.  A simple
