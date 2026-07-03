Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4F33A9DA
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068066; cv=none; b=spUh5jxPBpzS5165YvQ3AVj4CeQQhA83ENh2jAdG2T0lKMb6MCt53J+GZZ2OWLv2jGpUiBoRg1I1ZzXs34UXHvPugXka4lpIqQJF9e8BfzwBenuSyBZqolegXEJ9WqboTzdO/fQvjV2Bj5XdYMthdCvxwB/TUhWGwNKJGjM5DBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068066; c=relaxed/simple;
	bh=A7vFkytohO7nSbj2kRTGN5Q7Q0DoW7CViC2kmcyxNYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/QuzmQrQUszB+DmvwCEJE/3jodBcv+0xRw1dl0VzgF68BI++6GNtMsW/ler+I5MQv8RS9ii3BmukwXfq0PqYdmjJvVCdsLDKaZtFVHqRm23VxxxWij/PtjZZLW3ejrWBFlmQYpUOcditDXrOZXorFbzBgNJeADA55cdC9Apseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hsqCzxCP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QL1YroLt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hsqCzxCP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QL1YroLt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BBC37A0036;
	Fri,  3 Jul 2026 04:41:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 04:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783068064; x=1783154464; bh=UaiuqdSIId
	ziyWYSh/Smphf2Yfsi91SINKCOENuLUf4=; b=hsqCzxCPNNsdijut/IhbjVeBW+
	TCAFi+PXmpTJudMDDnqHpix3MltZxTE03zrllJZJI2uH24YBzxXrDDfl5E9FoODc
	JcaK5wcv2pWwvdAt08ttZ9wBsoKEypClrPCbVOZqmyskMj38ijwbGYWEkwmrlFdv
	XHeFW5eMw2NQD0K3cCMHtjuH7vBFylQH8t8EYPuSOt2ohteH569lwWgCqEhD4DTD
	/ku37R5I4+tRBoR9WSbcJfMjud97zeugwpEbM+NIMIRY0/SnJQwyFRFdupChF+e5
	YWSCqQtds0QYLG0rD6KXdeJ+pjF8wF6Xhn3UNbpG+x7TauXg7HDLZ4vrq6yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783068064; x=1783154464; bh=UaiuqdSIIdziyWYSh/Smphf2Yfsi91SINKC
	OENuLUf4=; b=QL1YroLtxKCLugqwj9e6cUocfbWihd+AzMCN5hkYUCwiblNaQHA
	vNkmSrlt3sSCs1FuQlrZFCEHsrkfKSF9DJrrvfW5k+UP+widfjPWClEG3VgIWnEb
	qxhOfSL4O+XPMRSmvTGXyOutALt6PV6yCH/ME2fDGPOrgsTaHfq48JSYRAjN6bU/
	4CHdnrX+G2AcEFGKxfqxhPgxFVoyqmJGfkNXz1xaOPYkOngbw4ZnC4vT9wALuaKw
	JYXoNN1/KY9eRyWPdYhRtS59lbCfT7tZES/5uRUJTaCWAF7GhRLkE/lCJtNanubC
	ajoqlsjHkT51q216192c0UnsoxEtYtj0RrQ==
X-ME-Sender: <xms:oHVHahaEOxXLj6K8ArPk9PYkxJjWpOLuuwTJltMVHsbfmtgmXIfqDQ>
    <xme:oHVHauag3jNTrhNBovJRkfYz5tXjXSG7c72uNZwQkgyzkU2rB7H5ILY4MHAFLmS2n
    vl3ICT-89r-a-KaRMtXlKgocz7N942aip-uq7vUdml2XS_Q4r75>
X-ME-Received: <xmr:oHVHahkcqhaPDPss1KDsJKOQNhoYd_2wG_N3eo6laeS0Q4TLLCbuN8hrw4XbHHaIglCa6qvwvASlnhQA4Kqx9AGpfdVKM12vnvre0sJRLg>
X-ME-Proxy-Cause: dmFkZTGA8c2xKZZJrYiNtY8/Sx+uHqOz99cMccLOE0h6Gb+I6rtrzurW+xli+98qDluIoo
    ZEfgwGUhW/9k+7huBAfJ51kfFd74XkNV7K6m9HcRfQp3tTYl6NR17Q4G+oAcMK2QsCLpjb
    AdmuAHyDJNsdBYgoJpxh8sZdLBbDvG6d4lrQas35KimNejULPClK5yH3Lb4bSsNq1gFITt
    IFkQQC1Ost8WsgGH5f8dJo/wFesQ1TPhZxuiwS/2tkMqjlNnR7TwDATJPgWmnnUT+X0GA1
    UXSRBSKlAOxNnrenqjjMS4qolr2vej3RzGsOnVA5iX5mqzMOeP3o3NVHqnVDmZJ+zVSHJP
    LxSrnpYc03F3KD04ifUCaI8gucMGdAnz2S9+64kBagGaWG9GLfFOmxWXB+9HypksJideHs
    e38Knu3n+paCJYIequsjO24QUeY46VxZ/Eqdje1PCs/3ymNtoBJcopNQCMMX65d03kKsSu
    JmynUNOJj+m8jByVhTdAFdVH5C1N76+aI2dC5qjgsMTVlhlCelUKjMKEXgj3pRmz9yWwGM
    38vznSw7FVKFe7hSNhrk8S8H5pWJOIwbDIkQEGu+4msk2Z5SdroBLByRqW+HtTqLkDDiRt
    tCDE0PNPCBJzmqiyiVuYawTz2azER/I5bVoEu7OmViNNbT+2MHioO7FPd2gA
X-ME-Proxy: <xmx:oHVHaqy1kjgp7POvLmJNCjTGSKewHq0nylV6TXkxkv57fMxhmWOxQg>
    <xmx:oHVHavNfBnJlwZopW4oiJNNMgcIQg1BQwaOzII12OeP1W7uITcCi3A>
    <xmx:oHVHauQXhxJUv1R3zHXbs8-97yhvedzisfmmclUPUj4Sthsn1i2ckg>
    <xmx:oHVHata2wNxbVokcgkkmo_NJdgkcimAnOyWB3J_orWoXPmB8M1UtsA>
    <xmx:oHVHanJQIpXpNa5M8EGqF1RGPdxpOSXSOOeKMqgtJ2eYvZ2GfsB_g0b->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:41:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4df7dea3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 08:41:02 +0000 (UTC)
Date: Fri, 3 Jul 2026 10:40:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ihar Hrachyshka <ihar.hrachyshka@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] precompose_utf8: use a flex array for d_name
Message-ID: <akd1m6KoUh7N8yyE@pks.im>
References: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703023554.36577-1-ihar.hrachyshka@gmail.com>

On Thu, Jul 02, 2026 at 10:35:54PM -0400, Ihar Hrachyshka wrote:
> On macOS, git status may abort while reading a directory entry
> whose UTF-8 name grows past NAME_MAX bytes:
> 
>   __chk_fail_overflow
>   __strlcpy_chk
>   precompose_utf8_readdir
>   read_directory_recursive
>   wt_status_collect
>   cmd_status
> 
> The precompose wrapper already reallocates dirent_prec_psx for
> long names, but d_name is declared as char[NAME_MAX + 1]. A
> fortified libc can still see that declared object size and reject a
> larger strlcpy bound, even though the allocation was grown.
> 
> Make d_name a FLEX_ARRAY and size allocations from offsetof(). That
> matches the actual object layout with the dynamic allocation, so the
> fortified copy sees a destination whose size can grow with max_name_len.
> 
> Add a regression test that creates a 261-byte non-ASCII basename and
> runs status with core.precomposeunicode enabled.

Hm. Why does macOS even allow you to create a file that has a basename
longer than NAME_MAX? Does macOS count unicode characters specially?

> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 1711794..8077f62 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -19,6 +19,11 @@ typedef char *iconv_ibp;
>  static const char *repo_encoding = "UTF-8";
>  static const char *path_encoding = "UTF-8-MAC";
>  
> +static size_t dirent_prec_psx_size(size_t max_name_len)
> +{
> +	return st_add(offsetof(dirent_prec_psx, d_name), max_name_len);
> +}
> +
>  static size_t has_non_ascii(const char *s, size_t maxlen, size_t *strlen_c)
>  {
>  	const uint8_t *ptr = (const uint8_t *)s;
> @@ -114,8 +119,8 @@ const char *precompose_argv_prefix(int argc, const char **argv, const char *pref
>  PREC_DIR *precompose_utf8_opendir(const char *dirname)
>  {
>  	PREC_DIR *prec_dir = xmalloc(sizeof(PREC_DIR));
> -	prec_dir->dirent_nfc = xmalloc(sizeof(dirent_prec_psx));
> -	prec_dir->dirent_nfc->max_name_len = sizeof(prec_dir->dirent_nfc->d_name);
> +	prec_dir->dirent_nfc = xmalloc(dirent_prec_psx_size(NAME_MAX + 1));
> +	prec_dir->dirent_nfc->max_name_len = NAME_MAX + 1;

We have the `FLEX_ALLOC_MEM()` macro that would probably be a better fit
compared to introducing `dirent_prec_psx_size()`.

Also, when converting this to a flex array, can't we do better here and
allocate the structures with the right size? Otherwise, I expect that we
overallocate most of the entrise.

> @@ -145,8 +150,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>  		int ret_errno = errno;
>  
>  		if (new_maxlen > prec_dir->dirent_nfc->max_name_len) {
> -			size_t new_len = sizeof(dirent_prec_psx) + new_maxlen -
> -				sizeof(prec_dir->dirent_nfc->d_name);
> +			size_t new_len = dirent_prec_psx_size(new_maxlen);
>  
>  			prec_dir->dirent_nfc = xrealloc(prec_dir->dirent_nfc, new_len);
>  			prec_dir->dirent_nfc->max_name_len = new_maxlen;

Okay, here we indeed have to realloc though, and thus we can't quite
avoid `dirent_prec_psx_size()`. Too bad.

Thanks!

Patrick
