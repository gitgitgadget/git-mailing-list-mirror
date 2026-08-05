Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147616A395
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921786; cv=none; b=g7AYY9XjJYq0iiH2Y5Aa1a3Rr+j5CR6csRZy5ew4MpZtgAz0WWO2QZ8rZKAeQOVI54LAOIh1Hr7AMFlssS7rYu8hZhIkWi3kpXuzMcieSOiKKNWJFsFQoEtg3pCi6r4D09l7v0vrWIXRX03IAbGY+DN1Xl3dI52KV6cJkOP60lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921786; c=relaxed/simple;
	bh=DZ+JJsRT0GyVheSD2YQsulTwf4MdNRsDKVXP7oeBHtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTkxcnBraCNkVbihQUu4coJygQ3mGgjdLhgDUTdg6uP1hLY2fhwYRkUYlPGhGdsK21DqRp0Xj3mQdVNKPrhFHNOYv84kppGzuq3b8NGDrbiqPxN7VAFZy6e/IslsoIFeHFy+j3UhX8K1kyqr3j5toHP0t40WsR5aDlgxto3Gi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JMKx7FfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=heuuzyS/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JMKx7FfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heuuzyS/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CFBDEC0094;
	Wed,  5 Aug 2026 05:23:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 05:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785921783; x=1786008183; bh=T3otefZbBG
	lDN+kGivs/IK2Uqw0H0DTZhrZalOoNsZI=; b=JMKx7FfLu1+dYk/VFApQUkWNno
	jLwDFtRCnPb2QDeQuqrk7gYIV/TWs3Vl86wQM9a5oJInpXOAb5E+nxKxNuhEZjtb
	0COz54p4mm4fSFptLnpOjv2UKQ/uEg0n/JmVq+HhCJMlxfQrtzCFdtIbGQSTOdyD
	own/9SVJju91rCzM7zAThCHm2yUZIuo7MaikX0Q/bpl4dsLPAPPNptqgP6JKMuQs
	GqmvTV+YwfBN5T2VcXnCRe+kNbUGeqa96sC0+IWSE4QDUEmaXNV85QDS9eQFOxlO
	wWYgqDNWIejhQqhGJoP2B5wFUqzWc9SjfBW3B5gdtPd2SK81XxYoNXAhsoZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785921783; x=1786008183; bh=T3otefZbBGlDN+kGivs/IK2Uqw0H0DTZhrZ
	alOoNsZI=; b=heuuzyS/KApJl8oQl0h/2o8dP74FLwNdX8YMxMgdxp6zWqhXlTc
	hA0+ywY85rl2uOzjLohu/0rfIpicdDCZjojfzBIR7ciJhp2nbpzi+Z38iONmA3jt
	QMIbIcvNH0zH8PbxJ2TadWTiTwajHaRbjN8jWj4nh4btSqFm5uL6k6Lh7r4u0NpT
	DN26OSFqeFYJRb1M+c6DJ848Xm2KN4ombdmDTwPxFJKB/4DP63Qc+QO3bX5D3Bhk
	BzlJRHwF+zK8nx8yx+ej0ZkzNO7jU0iJZA09DiOumSvrMRUzgLdI49HlRZ1giKPz
	6HoHCAP6zj/UJXdPoGnOcdj0PeDxzq9lMHA==
X-ME-Sender: <xms:9wBzapdjPS-oywvnV2xIEqoopH9SC67TyAl0Phfvqo5uF7qvDtq7vQ>
    <xme:9wBzauoIo7dqw45JB0-qILSdKZmUXbsfeKriiZ5RlT0ck2P-d87GcbKbXXzmfWDd5
    daPIpw7AvWgug8sVFl7XDWJ6I-gv5ZqcmGEcG6MYOrJFOURzFybD40>
X-ME-Received: <xmr:9wBzav4PowLUzyRD2LvqvfR6sDTXkhCk3xmYVH4kRXSHKD8G104pQKQFQaHqY6zeXjvOz2sTuRBjSJuKRCHRmwM5dlRRrPeLv9kl27tniA>
X-ME-Proxy-Cause: dmFkZTFyIzAgb92UmTVzDwCNq439D/cqIDozpQV4mDedqx7VxzQEB9Ko4wtEijOsBFLQOF
    hnQCskqRSDxf2ESyNopWXpGt8rVYkJ80U1kxCvrCp7uVknXGSoQhoAzXJPd2s/YzlQrf3V
    hCQtYf+0iszNeFSCD2NDhhk4tB4GiNMrTwvChNLZ+0JOEf0Q0rxpEglC1vHNBMeglJneFO
    /lYFThYgOq4GoAfN7KYoLDWXVsDhY25IOuZqjaMqlIlA/3AWZvzDKpVPFekn/tsgebeM6F
    4VgMWAJcGZlgoxBY36BfBL06TkRS65PhpDeNZyqPFC8vS+oZr9HU30vJQRVSxTYh9XzLsL
    o7GnbzC6ZbEXkNSPTbsrioCNAls9Rh8C0emZYlWxYiSUShM45yq6GOOxL9h96rs2pLKt77
    zmEbnMItFVfM22PgrDVuYPwuHsSTZhS8Z2Ww6vdfc7+RCY8Y3yh54rMxonT6tvKf9STIVH
    ADfCMEb/4dftlRx9WK3lCyjAPkllR2fAzb4cNfms3h+lP0pbo9VUf1kb0DM2bfr/kmaqE2
    xBhBkb7kIHZh4hkuI57nwt9YAwkaS/d+SGR8kw9Fmeba7YOUsR5lQqassMSte6cJCVdiHn
    nFU+w1fQQotkX+piKgsOQ/6ULF5b1dnv0SMEpGNgeZxrbdQ+8VTF1c/bUyaw
X-ME-Proxy: <xmx:9wBzasqGvoqSsQ1MDbH_HkJOuK2WhFdd5wgpLz67gtaYxOiW3Ra6UQ>
    <xmx:9wBzaphb0hhRJE4i26ugMgS-lT6hgpNU9sVq9VgfQjzJJesHIqr0HQ>
    <xmx:9wBzauIQjdoq-hU9NZlyjO-QGSqV3U603kVuXaCwQjSO6PMI7zqBhQ>
    <xmx:9wBzahBGZsUCuqjO0YrHYVH3iRblDIy2jtwpXCsC9DzOePTIXCIq-w>
    <xmx:9wBzaiK6sugAzt1uULH-ZA1s3VH5FBaO0_sRqalRrut_4MM8gsrtUhKi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:23:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c4e421c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:23:00 +0000 (UTC)
Date: Wed, 5 Aug 2026 11:22:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/12] diff-delta: widen `struct delta_index`' size
 fields to `size_t`
Message-ID: <anMA8QmycpIksrQ6@pks.im>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
 <69c2c21f05a2aec95f1ef61f861051c289b03dd4.1783615780.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c2c21f05a2aec95f1ef61f861051c289b03dd4.1783615780.git.gitgitgadget@gmail.com>

On Thu, Jul 09, 2026 at 04:49:28PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/diff-delta.c b/diff-delta.c
> index 43c339f010..b6b65d7607 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -125,9 +125,9 @@ struct unpacked_index_entry {
>  };
>  
>  struct delta_index {
> -	unsigned long memsize;
> +	size_t memsize;
>  	const void *src_buf;
> -	unsigned long src_size;
> +	size_t src_size;
>  	unsigned int hash_mask;
>  	struct index_entry *hash[FLEX_ARRAY];
>  };

`sizeof_delta_index` returns `index->memsize`, so we'll also have to
adapt that function's return value and its callers.

> @@ -140,7 +140,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)

I was about to complain that the input parameter here uses `unsigned
long`, too. But the next patch addresses that.

>  	struct unpacked_index_entry *entry, **hash;
>  	struct index_entry *packed_entry, **packed_hash;
>  	void *mem;
> -	unsigned long memsize;
> +	size_t memsize;
>  
>  	if (!buf || !bufsize)
>  		return NULL;

Patrick
