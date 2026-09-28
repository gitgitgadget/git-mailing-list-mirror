Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7B1DDC37
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577390; cv=none; b=Z56hE9XEatVFSemxtwjXLHYRVVRQkZvDBvIm4Ycac4wLnLucng4YbYaJO/MnuGYnICELPDDn6ONGAvxkKsgPvbTd55lUne5i80Dpo1LLEmH0VYrDLOnuZoKwK9pSx+0CbE/R4vj6L9Pcfd3qTBDQIfd+3BKdrdZ8yXnVlUpxp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577390; c=relaxed/simple;
	bh=YR4vem/MDj4CXpLECVfal2MsEqRZE9bL+VOKhs+Uw2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc54JDQXGhrWiWGimBOWjY3AvTADalI4LUqqRxbT5z8iS3xAM9FIcKUTZoQPwF9QOzuXDAvt4YWASmrIONGoMIgBiV3yFONZNpAmW4iD8VVZW11Eo8sJ0eXKLkM/dtSxv2XR+u0acmTNOjK13Q9COCd/vm02Z0lmjhfjZCcrAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ulvzfAwt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IeP22P26; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ulvzfAwt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeP22P26"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68E0C140008E;
	Mon, 28 Sep 2026 02:36:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 02:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790577387; x=1790663787; bh=521McMfsmj
	tKNuyaFo61huRKFJUsVmB1Mq0hZ5MOb9M=; b=ulvzfAwtKD3Zr+xhttYIskTaUM
	3YWnwvujiabAZTVzAJmOXDh38StETb3HhVYsGPOCG9cHFeTtZxuVKuruk9FcSwmK
	Ta8LrmlFAXpbyQUPXwLl5PGwX5rWJS974B6yU9CLAH8wXLuxbqOKawP3WDi/yzR2
	tVi3AXHE0Tsne6svPe/vjiYqlg9NL61etxmJngkAnkIZrhiYf0/MXk/2cScTdKeD
	41E/ePPsji8SOU9G1zFoZEPW8LJJ8lRRlH+7ptmWf/dzxjfoBHEuhT5okfH+LSDz
	0GUfSqoj8P05YIu34V9TqjTxYezV/uAt0jMrSZLtCHAJGx/KNzCiMeroMK0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790577387; x=1790663787; bh=521McMfsmjtKNuyaFo61huRKFJUsVmB1Mq0
	hZ5MOb9M=; b=IeP22P26/LgGUn+/9RbDEDcguGkdzbOBvQwrUzc2pLs15WveEgD
	aJcBfdN2dfhmfR8jqIWZvZFTTtPJ/41YQBqH5hv7//JV5+N7B447fHp8ZLdWPS4f
	Q33zgB7mwDkatQW8Asb5WQ2NawmlUsT9anZO1zrOF86xx7++2BZV4n2Doh8XEp0T
	CR6cNXDN/jz4G5r8jtRK/MCNBoZOzJ8wBqIkOwsVZtuip6s3GDKgJwy7MM3+yI12
	JMfQs/0n9MWGzsSO1Ej9GYHNvT6c82ZHJqV7CPULwSgl8dlZ+/Zoh3zaLb9EZfNE
	PmCFVjqyCVYaVFPmm1UqTojCFu9X87DeyAQ==
X-ME-Sender: <xms:6wq6apc5kf5YCrJhAko3dOYiXsj69ccJ8G0S5HK0JsSFnZQjEfui7g>
    <xme:6wq6auPv9Um8ItlUYRRI_f1WikmnML6I3Jh5IHu3cmt_6DVZDEWNb0577uS1Sx3Dg
    nXwrqM8KIHGOIQP2Z8_klHRk_e-s28K1gdZgYN75ZIOw89Uv5rFmw>
X-ME-Received: <xmr:6wq6angja-Duba_XEfH8ZyXbMsegje9PR9_eWyVpM-i1ZLRCkJzqcQ>
X-ME-Proxy-Cause: dmFkZTF8nJIusJd7Ore5bg5GkdU06qhnz63/5yXVuSt+673fzXcwtBNOFnQVqHisO0CWWG
    NYzq2yylV/2k4Z+TYq1U4jlFbsOnpatb28tPpx5ftMmD6BU5Zi1uO0XOspE/j/Ut1ELSsJ
    qdeW/ze1LOD2EPavawP7AikhF+YardzhG0HtHjgP6urwJbOzJk738b6dw6otrvSt+f4BQo
    hWqTpOx7JCbpEKaLZ9zOfqgRrdcvEcEr6lx3G7yFp1rVfWMXILeoG9n4S6rDcKYLiDgbHW
    mLkqzJ3hpCZ58MRxMu23l0SpIoHs1NbEonL8QoX6y9fIseIxpkC9GDonlVQdvyFcPM9GMF
    UqaKru7oFf7b226tR1DNXqlYS6FFITEg4hEPQebOJZOPJZVQxza4NhE/YkKX8H5uYXHQkD
    hzlZJ4mMmwkNncZrrgtf5ZyxrVyNUVDreKa9NaRkiM66Nm/dxf38DGsoK3e9Ntl9sMP0Cc
    AbrbEvNa9IbGPcNIhbJI0/Ju7AtBU3ZOG5NPb+R6oESfaqRB39Q0XoiagXrIq8GWbZyxfP
    OPD+0QPlwy1nwNLiKz9H8Rw+/5LOvJAsbaqsP9NiUUz/idN+ik7BulVIITvM9FBsOyfq+f
    NgCevLaRVpKdns4vdUUtNmhC0t4AahfAYzFUPGPuf5s/sCYHJQxo4jHR5a3A
X-ME-Proxy: <xmx:6wq6ah34O2tVZZ3vmrKEow5za7JVfMjbQMmPjnFfaeSY-S_6ZoJ8WQ>
    <xmx:6wq6ahjobxdnl9L8DJKjs0mnN_xqionTWvNkD5w9hOQ1foNlg1IUug>
    <xmx:6wq6ahew4ZnpfPjD5gxRb_Vi6haeizt3rb91Tc1A4CU0pkGSdfCA_A>
    <xmx:6wq6akm3axi9VnabmLnCN5uOibA9VJz8Bz7Q6VP4E8ypx9zh2aMAhw>
    <xmx:6wq6arcH70qSPFKuHr1ibcmHWjJ59DFtZvaY1GyjZ3Vx-bkY_gMt67FT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 02:36:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0f3825b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 06:36:25 +0000 (UTC)
Date: Mon, 28 Sep 2026 08:36:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t4205: compare huge output without diff
Message-ID: <aroK5js5U2t0IUIc@pks.im>
References: <20260925-ci-large-test-resources-v2-0-f632cf319756@gmail.com>
 <20260925-ci-large-test-resources-v2-1-f632cf319756@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-ci-large-test-resources-v2-1-f632cf319756@gmail.com>

On Fri, Sep 25, 2026 at 12:35:38PM -0400, Tamir Duberstein wrote:
> The huge-commit test compares output containing a line larger than 2 GiB.
> For two identical files containing 2,147,483,649 "1" bytes followed by
> "0\n", GNU diffutils 3.8 on Linux arm64 gives these measurements:
> 
>   Command               Mean +/- stddev       Maximum RSS (KiB)
>   diff -u expect actual  5.276 +/- 0.572 s              4199924
>   cmp expect actual      0.506 +/- 0.099 s                 1264
> 
> The test needs only an equality check. Use test_cmp_bin, which runs cmp,
> to compare the output byte for byte with less time and memory.

Yup, this is much more compelling as an argument now :)

> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 4be5c51489..01b97c8888 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -1189,7 +1189,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
>  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
>  	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
>  	echo 0 >>expect &&
> -	test_cmp expect actual
> +	test_cmp_bin expect actual
>  '

And the patch looks obviously good to me.

Patrick
