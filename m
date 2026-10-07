Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AD381B04
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384341; cv=none; b=YKBApTwvrwcza52FLsTlYLEfmzL556oafBWWICR4Po02Pgezf+pY332aAyqk6Q7i0ktBAjuE0eOC5nlj+Uf2vFsI2N9WX7tBpyqNMEzoQe3aPGwFfMRer/o/mUYlEzktPIE5ZUoP+PfM2YIYPouyg9ZVZYHUcbTtPWsZhK93RI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384341; c=relaxed/simple;
	bh=xTokpMs9Jq7EAR7Vsx7xagMPxFq9U/kH/bmhsMn8yaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EvpMgpUcXmn6PPHmStUmZiIRkIaJX3QWSpalNz3HSxI6Asd3lp/9Kdy32Lguth3XSzMoHiBw+1LJSJ5oFlYyTwM3x3LJsNGtdAIxIX406hCik5RdslZs5ZFNnay1LeafSf2qV/g/fLo+kq6iG21U+qTqWqEmjGlwNNUvKHuZ0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcuJrlLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXdph2+U; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcuJrlLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXdph2+U"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F038DEC0403
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 10:45:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 07 Oct 2026 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791384331; x=1791470731; bh=Y75WWf8X2G
	8eLCNDuEq0PI55alXmP1EFV7eZnf0HdmU=; b=YcuJrlLeouS+Tk6FtPeX6tITsz
	IEc4l6u7UV7O6SXQDomLiVCIKxgk/64gWFjcK3dNkskMYs78TpVzKnfQt5cH+T+c
	899U48d5ZiK/lBp/7Y3KkbEf6XRPoftxdv/fBZrShEgkVBjCsEGxvzB1RhjB87Rh
	Lm+l1XMRfj0AIb7jPbZKZopbwN41N629Q3XstD3UccXep1v7IGvsG/zpN17InuF6
	QkWI1/kRG8pfsElaTt8Id+sUaPSLWqAAwD0suudNsHRVz5HRcEfjaVw0HiOg9F77
	FzlXOLttgIHLMuuFiGT0WQNjptWXA28b1ivil2aMxxzBR5dojP6Sab4J8FSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791384331; x=1791470731; bh=Y75WWf8X2G8eLCNDuEq0PI55alXmP1EFV7e
	Znf0HdmU=; b=nXdph2+UesUAxDnjyUMhHHc8krIrHe3MEAmYt7z4PiNlpeduXxm
	95870B9YYpaYcX74OiZ1Ec84qT3qc9dieEjmyOd0cP5EyhidGr8VTGoFtdKtuDOV
	3yw/GSC9DGf/HYpFlVVHSKJFf99WDrOnfrjuh/wwOA5bkAHdCVsdiCOlJrkFxyQO
	P2g9Lrsnsv82+7p6oZTUnp9enrvbdY+4HX/3eRQGLtrMlqIii2rMqXLE95t+WD0E
	8P3RlLOm1ois8+Q3dF1x8Mrz5S9xIOUjDH01B2iTeRdnBLKus7EPIpzxHxbm6avp
	Rdu0DTuzx02JVMV9A0/bD2WY9LhmpByaIqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791384331; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YQt8iDO2BjviLFiBxXFy8MGh2L/7VMU6TsJdMECdK2YnLMY
	fsR3EpthC5JFJXSJZTI7NpjipGedztIi2XY3FSqUxkwGc5EQ5Btok+TVGQmiqIui
	4E43MthHakELrZ+PfynrSuz5e8vR518rU/txo7ODh8Y93g088XFIzabf3m6KRkkT
	9VFR6Pvpmszi+u53U6e3cwL7cDxpu2mYj+xks14zbO3m0KuMOpK4mCwzznUi7p7G
	HyrXvRvlzBUXOpCVV1q7zQRUEx/1D7aLBoOnAzpcaeSFD6kCgqdYXLPmzY18kaOa
	O4Oy8LB51pce2PRBzMc4tu0ynctJ4uE+tSduUxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:FWCJdYbBhloMTzTy2y7WkSqeTsD+qEGikZYsWKcuWCA=:xTokpMs9Jq7EAR7Vsx7xagMPxFq9U/kH/bmhsMn8yaw=;
X-ME-Sender: <xms:C1vGaolzCLEdw3ny-rLoFH0ctxoeK-7VrmL7q7BOEFYpMvzUtA8hzw>
    <xme:C1vGavQ-hPomihIjtSjI20T8Wp7x0-fmj-yFu-_zrOH8fb5EtGlRiWvtgy66wlnC0
    V8aFa13OegVxN8c2hdR5IHth2tjY4TSWeIhYiyu8Jpv0Fq8TZwmCg>
X-ME-Received: <xmr:C1vGakAOTFBTlY6HYVOWj82cdWxGvFYcKDOtp-jUn099NE-xoeD7x1y6w99PkRXEOj0_0Na9cmj7dRLSIHb1zFkZnE6ChVu4-XP7>
X-ME-Proxy-Cause: dmFkZTEE7Q04awpJR9aQ0X73zHSD85Dpu0yl9yUjOa/3+4/uUDghQzEPuvGmOYAxcIvxa2
    DgLzOnRVT4XuWFus36G/0Sy/enD/wGaRbTDgKqyft6Z4Ctcy6wNiMXnOOXZ5fun34GOEdR
    eNgsFVa1EyBCe54MNv4H9bX+WwqfW7zaE4RsSvfVFabeDeHvz1qZA50ucuGD1sGuxrxD1b
    RSjrZzU5Mm6H9wKGCfGzDy1M5DI0+Wrg8M5mp/aVEB27KIX0TH/dQXQ1UVaXJhpfKEeZ8I
    J/jnUswI+y4jB07KNxmAiosb1QLyg/qMEpw6trnNrOiZF/0Us2Ca7Mwklhxy+eAFafx6f3
    C86Vh/HTbgx6/aUTIEJp0oksSpoNEI4KDk/mk0wjQ7DD8O+Dyuaqno43FP20uhoVOxV5YB
    JhHyBj+vsbfIFzFLjrwKhB4CXzjfHhomlKY8VfbFxxmaWv5ei6RJ3T1L5Nv/u3GpMtLf78
    nX0u1fpqZ6gd6588gU59cuMm8NRVbL7QU4zPCwg3m72ez9hHqQzBMNp+aCX/qGcGaL8We8
    +ywPbrNewVpycjlkjMbScFrLCe+ywyBxeEcHL5hyENkt513VWmobZ8W+03H7B4vzeQcl8x
    nCvI02CQLfQ8GoLxRsBlQkxgoTx1aZlcpAgGWvvlXbwdrWsnY/C7BrauytPg
X-ME-Proxy: <xmx:C1vGauQU-hCC8OYV1BD2DwZjvdtB34hpCG22kUY2QNqB8HtM3pdxVA>
    <xmx:C1vGaqo40U3l0RbD5MjGyw63navaFnJaCLNW8BSCdUqe9ZGLSlROjg>
    <xmx:C1vGaoxdR87tlr2pRFRNZccBL-O1hX3hG-7DpSh7tkqvMUKHElU-fA>
    <xmx:C1vGanKmUQVYKkCJI_2fvngB-tZjTpDsdGqJlhxqkkNwf-OTqiGgwQ>
    <xmx:C1vGajSiZoWXmzdPx6O9qPqJEPepNqkBGgOsksBijmPmSHWAqeg91K1w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 10:45:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] combine-diff: honor --relative when printing paths
In-Reply-To: <20261007051734.62590-1-dilsheddilu123@gmail.com> (Muhammed
	Dilshad A.'s message of "Wed, 7 Oct 2026 10:47:34 +0530")
References: <20261007051734.62590-1-dilsheddilu123@gmail.com>
Date: Wed, 07 Oct 2026 07:45:30 -0700
Message-ID: <xmqqld89bmd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Muhammed Dilshad A <dilsheddilu123@gmail.com> writes:

> +static const char *strip_relative_prefix(const struct diff_options *opt,
> +					const char *path)
> +{
> +	if (opt->prefix && skip_prefix(path, opt->prefix, &path) && *path == '/')
> +		path++;
> +	return path;
> +}

That's quite a long line.  Read about coding guidelines in our
Documentation/ directory.

Also, do callers guarantee that path may have only up to one
trailing slashes and never two or more?

> @@ -932,6 +940,7 @@ static void show_combined_header(struct combine_diff_path *elem,
>  	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
>  	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
>  	const char *c_reset = diff_get_color_opt(opt, DIFF_RESET);
> +	const char *name = strip_relative_prefix(opt, elem->path);
>  	const char *abb;
>  	int added = 0;
>  	int deleted = 0;
> @@ -942,7 +951,7 @@ static void show_combined_header(struct combine_diff_path *elem,
>  		show_log(rev);
>  
>  	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
> -			 "", elem->path, line_prefix, c_meta, c_reset);
> +			 "", name, line_prefix, c_meta, c_reset);
>  	printf("%s%sindex ", line_prefix, c_meta);
>  	for (i = 0; i < num_parent; i++) {
>  		abb = repo_find_unique_abbrev(the_repository,
> @@ -987,6 +996,7 @@ static void show_combined_header(struct combine_diff_path *elem,
>  			const char *path = elem->parent[i].path ?
>  					   elem->parent[i].path :
>  					   elem->path;
> +			path = strip_relative_prefix(opt, path);

When a rename is involved (e.g., originally the contents was in
here/file we have made our changes in place, while the other side
moved the file to there/file and made changes there, these were
matched up and are shown as a merge into here/file.  Wouldn't a
elem->parent[].path point at here/file while another points at
there/file in such a case?  What should happen when our prefix is in
"here/"?  I know "here/file" should become "file", but what about
"there/file" that they bring into the picture?

Not striping anything does give consistent result and would not
mislead the readers as long as they understand --relative is
ignored.  Contrasting to that, "we strip if the path is inside our
prefix, but otherwise we give full path" would give ambiguous
output, wouldn't it?

