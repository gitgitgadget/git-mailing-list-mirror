Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2E3B5843
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 01:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978679; cv=none; b=leZaWN3U+iyojYxc5Bzfaa3bFmi/r+W62LtJHaLngKltBYOwx+e+uo9e1T/ftmBD0Pdm+YZdHTpwwRRToSJjPshC9nIzLbN4YS2Fnie8UPh+avtDtDrR3MUXj02dbwXRDyS801jnGe7DRVL/vfqen0kJvu2mB85ewEY9M0MSSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978679; c=relaxed/simple;
	bh=iQ1edL2NmqgudLw/XLptV0pira249tpK76Twxd6gWVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SykEAZW2Vu375zokQH5ZfR1vVKYKT7NpfWB+P1K1xeoN6OQYfjfZjrIqqEN2f6LzYAyoTvs4QXfbxA53wH1dNl+PFWov5PY6msHo4wwkbt6F0K2Gd0eNYQcOzVz+TPE17EXqDNj+qYwff2IM5iu1lVyHJzfuctDK5VNSx+EO8ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HlbdHNLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UK1p24HA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HlbdHNLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UK1p24HA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E84421D0007C;
	Wed,  5 Aug 2026 21:11:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 21:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785978676; x=1786065076; bh=GzGP0XE0Nw
	Q/nK/1IwzkLHN+eIjtTXuKT1dkrO8UTFI=; b=HlbdHNLMVv0L0M68lT93Fvv/el
	SGJw70r+fqPTi+dHw9ODf1EJjDQMn2QpBf0EN5dSYPOn21+mFS0Nhd6Le4963Skc
	kyd8GhQj6+tlSmaVBXaua3INMw9K3wmK5SSLyVAaB1yeD9Ij8vDHs6tTdDFHMHh0
	sthdlW1zStCHYzLzvs7f9Kh940Hix5d4zqAb8gm6zAhO8N70169ug5uUgoxUI7zG
	++AV6jHmFIGPdMSGC8KXNu9xXoESW6AwOvpn9Npw5WGSksilzDbI/3NZu1U3m/WR
	AorV+3KZJayt/XLJMGzoAKU2/3LLbwVNxYvPa9dqCrtCWYymQWNvZESgBOFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785978676; x=1786065076; bh=GzGP0XE0NwQ/nK/1IwzkLHN+eIjtTXuKT1d
	krO8UTFI=; b=UK1p24HAlZWLTgVK24mFg4TJCMdRLDBe/K2v/yitWy4jxRYBsAj
	hYer53ZH6oIw1PjbhCNsukdg8D9r5qGlk8wZ2nSQNKBauSW+DUB3PIWnUj9E9nx+
	O42PYSBekG9TL6yquT1+pXzsC+1QHJi7mkHqC2Rc+mmjSSZBQP0b6xx529PgyYJ0
	kXVIXYoTPHSBkdEHm3+pf/3xFlezq7DmD0+rp46ZXbVs61F6lByLmdx5ED8vhOuu
	3xALfIvh7iaHx3lJ4WNE1QYTq6W/DkobJELpd78BxKZtvp/h7OjXf47UREa6Obua
	TEe8HDL5gop+zWbGqQ05/rdv7Ec8/mLDPMg==
X-ME-Sender: <xms:NN9zaoZSxQqKmVKus3kFbtuKDZr7uiotS_EMq8VlOOT6Uszogxb9-w>
    <xme:NN9zaqRt3UBFK51-TnaxH2wutS1YGG3KqzdZiblQMttI1cb0qZoobc7UdUqubESFy
    1g4oLwpr7d2ULlb_XQGEhjibX8JNBtsCZBSsLSWKLj0xgPvhIj6jQ>
X-ME-Received: <xmr:NN9zarSZC33TNI-ECZTSznfKIXbFaidzeY_Tperzm3w-4QYw0bwcdxVu7c1rrDbLGvevCkYuaZ529mAujVc3f3DGdybCoD2YcA>
X-ME-Proxy-Cause: dmFkZTEym4Gx5iC4nK0fpK0q6jO8eG/hhhEZkzVYQnsPKgKUldCggjEymXT6kTM3Uv2A6Z
    pPD/SHxCZ9GUWyg6f5vHAbzj3JK9kRIacb3FDz2fxKZ9TQnETR4T7st+hOvX9qdPUNX4P/
    jXW9+drUzNcIvilX7Lp5j9R+JpYlTRKBdpLE/ny+g9U0IgzfARSIsCjYjPunjkI9bRwqUO
    LFTBJYvS8KiSj1DsDhOcveAaDRD352ICpXarN5OoN1lZymkqjjCAiDUgreLeXW6W7qJTu6
    6GvTGarkTylgl3bPSrgjFTRaSSUKN4FYVs7eDO43Y1vZqO9LSN/Py24eiEbntbXAHOEpG/
    GLf0n+8BSA23BvzIZweN9H0TASZ/tfcsHR3rZSf90N1MEm0mG4bliZH1T56QdofUJbmNsq
    5bDN1/dhP81x4lr+1UhWyaosA38lfBmmXTKsB9J8F0PxJssBMQ5/a2MkHjn8CEbX3uF/So
    3r7ZMHIEjHWobxT3F3CtaoY9Thx21+18QDyzvxRWYBaYem/s2txdvSRexWyCUIPLzxXBuF
    M8bTpUqs8ekF+D5fDkGIPExd/6sLSbMzdyoe1NrqV7rzpRGuPOtLPXxwAR27Tw+iBO+4sC
    lvoRRh+MCVFGLPYpn+EeYw6zfXPPWQfFJZktmBUdHc4HZfVCgNl8mBU5o1iA
X-ME-Proxy: <xmx:NN9zauRTmflnckTrQY9jAY6W0Wenm545612OMsrriuMa_SYiRvjD-Q>
    <xmx:NN9zag5N7Up9r-wgL876qPdePRHTbsItbHb1GQ6vTSUYUZitzfMvfA>
    <xmx:NN9zaq28KEuzkC2iBnpJUW8kjOggeiYm48IMWsJ-qKVisLp9K20L9g>
    <xmx:NN9zarALkeVYGQU4m8M4TZDdCIWGW5-rNrlZfiDOiYptt5USrhMpnw>
    <xmx:NN9zakqEFyOqEXSBC1Q_M0yxC-xAuMlcFrqAaKcKHAeR32PQskAKCMA1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 21:11:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 03/11] reftable/block: check deflateInit() return value
In-Reply-To: <9bf7e737c740d8a80467ee3b38df9c86bbf7a566.1785954661.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	18:30:52 +0000")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
	<9bf7e737c740d8a80467ee3b38df9c86bbf7a566.1785954661.git.gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:11:15 -0700
Message-ID: <xmqqse4sm4ss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The function already uses REFTABLE_ZLIB_ERROR for deflate()
> failures later in the code path (lines 171, 199), so returning
> the same error code for deflateInit() failure is consistent.
>
> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  reftable/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index 920b3f4486..ec81fd0493 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -87,7 +87,8 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
>  		REFTABLE_CALLOC_ARRAY(bw->zstream, 1);
>  		if (!bw->zstream)
>  			return REFTABLE_OUT_OF_MEMORY_ERROR;
> -		deflateInit(bw->zstream, 9);
> +		if (deflateInit(bw->zstream, 9) != Z_OK)
> +			return REFTABLE_ZLIB_ERROR;
>  	}

Presumably bw->zstream occupies some memory allocated on the heap.
Does a failing deflateInit() release it?  If not, do we leak memory
here?    Or do we need

		if (deflateInit(bw->zstream, 9) !+ Z_OK) {
			REFTABLE_FREE_AND_NULL(bw->zstream);
			return REFTABLE_ZLIB_ERROR;
		}

here?

Noticing and returning an error is a good first step.  The only
caller of it is reftable/writer.c:writer_reinit_block_writer(), and
it checks and relays the error code from here to its callers, but
not all callers of it check the error condition.  The most blatant
offender being reftable_writer_new() that happily keeps going.  I do
not know if we end up calling zlib on bw->zstream for such a broken
block_writer(), as I didn't trace the call graph fully myself.

Stepping back a bit, if REFTABLE_CALLOC_ARRAY() fails, bw->zstream
would be NULL, and a caller that does not check the return value of
writer_reinit_block_writer() would be holding a block writer whose
zstream is NULL.  If the block writer is eventually passed to the
block_writer_release() function, we would call deflateEnd() on it.

