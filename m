Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82843DF018
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744155; cv=none; b=JoVb6uCi/btLYvNFmnWMhT9wcTwl4g24VH5rZHLhXzMc64+tw0pT8RsbCyzjiIldifcClXJEumJwy+TAVxmr8LmeDbN/9oi700V/tseE2SXto9e0tyB8dgBfJLvGb5twtWf/l4Bd8n1IuRgf7TuouMdf+lAMbEuLwrPNG+5kZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744155; c=relaxed/simple;
	bh=wPgS7kHt/4kIPJJFSBLR7MR2JutCIYOLh2cDInSzMzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qqQ7GORt3hx+3WLcOrhRxk5W3R2Xee9S5NXGbnSSgkTfYrQoc2pLuniOH8xwSJzrqztngOCWfWeupQZYfCCJZWtxBHpZm0NV/p+vZH797JOu6tTluDVhjuIn5dueeytv8w9kJoKHqOHJTGsmPVQiKsWrAxDb3tLcRMcEnZHaljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b84FN3Ac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/kxq9vV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b84FN3Ac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/kxq9vV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 335A17A00D4;
	Mon, 29 Jun 2026 10:42:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782744153; x=1782830553; bh=jOYqDQurWr
	0MxjSvt2suy4x9pZJ5yI4nCV+ukkjGQb8=; b=b84FN3AcBQtppFw5dNQ/7yZ0r+
	HgNXwElZ17Ja+xvwexfsMntVYsCPe293TflNAe2EqV17jGjfSeuu4jHDWH4Lm+RW
	M3O5P93ppifywvrkGyees3MZNFU4h8ltH42Fj4iZ5u6//fU2+ckMxnfbWGsMRTOV
	XnD1m/7xetAFjYHw+staRkmE0eaAiEfVwPOh0kHPGYemRVBGZmDeu/Kzh+CukRJe
	xiH8BnGUnMK0SO7lD/MIqdhHd4hPnmVGJRDO/rtQtejU55AbvYyby0TWQuyNl2sZ
	mqQ9+mhpnb9eil0eD22NsmZ77dKRqIiZo7huMcxoy+IiVme0n3isaBTadhRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782744153; x=1782830553; bh=jOYqDQurWr0MxjSvt2suy4x9pZJ5yI4nCV+
	ukkjGQb8=; b=h/kxq9vVl+739zDjhpm/notv0KWfVMyd5Pj1H6AzZOvINFE5VOL
	P5r/5nzi5mKlxWUFIF1EyiWjskrkMxUJS4E9sfJvY/oFAaryTLBR1S7YCpzvKJFX
	bBtSCpeZFUt8S+oB3h9BG/3Rf99TNkp9NxAt/HhL0JKAyw7Eny6KcEK6ErZ8nqje
	VWnxkjOilKMmx4OQyyVQLlb1eXHKU1i1wa8k/7onx+TlyrVx7xmgFRwLF16JY/zP
	/FtqnVMFX0FKZUPpuyO9EciUg07gFDJ7gLpqq2uTj2dyFQ1d/2SIZDz6Cpp8uIkX
	a4qd2gFldCVHNog1ehaPLcMAKe32/CxMptw==
X-ME-Sender: <xms:WIRCaums-WceKH02Oo6eK3BPX7mQBQmIXZTbUd7cacIlnbRwiNyoDg>
    <xme:WIRCahWIhq6nclhRvSHM959ATxUAUcpKKEhwe7n1gP9JHUND5YnZY3dbDiQ6doSEk
    Vn6vzYEIrBuoeWG_yF3WA9wvI8eEEXy7FJ0eo5hQKM_hmFsYYlRkis>
X-ME-Received: <xmr:WIRCajH5h1xQ2l0OEXnPxX_8VPLpNMBPcDrUMd6AzQDd-rYx9anwfeTnBrcwocMuc7B8MbvYPr-4FEChMet1jOYLbuFoAwCvHLLblMw>
X-ME-Proxy-Cause: dmFkZTECZqMWegm7iR0JyqgNvhOTKZ8ejb1DRi+K3Z/Lp/4I9jhbfMlNaoEgHg+NPbf1EA
    mi62HLRYzXrGzukNcKMlWeOZO7MwlQSOVvWh/ewIsNuqJEX1J+IJ7nv+8TooeViDIJSjKe
    oe9YJvgvBR3oagJfyDNu9IjUmQPlnH7uH6Qai/EqZ18p5r9kRrN38G/XtGxZ2OvcbBN4vb
    B/56rqDlvWZntqrulzjxIQEOtOcFY5qhI6skjvO2Kez1X6CrHyuGD/StlTlARKCnOX2uJz
    2sj2NVdvrfQE8q9sqDWhdlr2vDfdl0EtX9N3agVUZnbNC2LnOw3GQy7aHKnQJlZMN/atTm
    Vh/5luYywSwiUAE6N0eM/BV3WiPT1rzAT+eLi64xiEfaTLYj08DYTta4KWbnPn7CHtkBC4
    dzQdiqQOvRNxR0cNNyOQR4Qx/cMJrvjqqTro9sVOyq2dfDi+oyHAUFiJD5z6V9sz44ZsUm
    3xuCeYhD9GA2Mt51lPP2QRdwqK6w8VOXDgQHi68FDLdxDQBFmvRm0ZEMJQUjENkPKCiyjr
    Jqo+voWnxWrgnxorSox9qTNmfOrXBb6A8w+rLjU0Dd00xSYMYNnqZb4Gd8uJV4ryc3GoPx
    okfom5PUjU0XHSojjXFMhSq8w5rnfAQWrqTYMgFpGNCal3rUU6+c1AGa/NMA
X-ME-Proxy: <xmx:WIRCatfcCPx_AJAY4C6eGuVp0_XOuXuyEITCMKuCMeVIivg5AzCrnA>
    <xmx:WIRCakKLX1KsSvyTR9TGFRSp7WfNrC-4Bzrvu1ledB02X-tPVPdFEQ>
    <xmx:WIRCaiHf3NxA2z-G639-QHkDzbRCDcvxJn_oKBPVMl7XMFzUgtrdZw>
    <xmx:WIRCanDoX8J0sLB5yQT-Fl4SJt51VA5XuZGZEXUn_jjpoaKs53HWzg>
    <xmx:WYRCamS04KWM02EhKuHQDSXOxcVAubwvy8jvyPeD0S6VSA3DsQzPigWj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 10:42:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael Montalbo <mmontalbo@gmail.com>,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/3] t5551: put many-tags case into its own repo
In-Reply-To: <20260629003434.GA1228461@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Jun 2026 20:34:34 -0400")
References: <20260628075716.GA3525066@coredump.intra.peff.net>
	<20260628080345.GB107826@coredump.intra.peff.net>
	<xmqqh5mm1gsf.fsf@gitster.g>
	<20260629003434.GA1228461@coredump.intra.peff.net>
Date: Mon, 29 Jun 2026 07:42:31 -0700
Message-ID: <xmqqh5mlz9uw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sun, Jun 28, 2026 at 02:44:32PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
>> > index e236e526f0..cd851f24b8 100755
>> > --- a/t/t5551-http-fetch-smart.sh
>> > +++ b/t/t5551-http-fetch-smart.sh
>> > @@ -397,15 +397,16 @@ create_tags () {
>> >  }
>> >  
>> >  test_expect_success 'create 2,000 tags in the repo' '
>> > +	git init "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
>> >  	(
>> > -		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
>> > +		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
>> >  		create_tags 1 2000
>> >  	)
>> >  '
>> 
>> While all the other repositories used in this tests are bare
>> repositories, this new one is a non-bare repository.
>> 
>> It shouldn't make any difference, but since I noticed it...
>
> Ah, yeah. It should work either way, but it is slightly confusing for it
> to be non-bare. I'll wait to re-send (though if nothing else comes up,
> it may be simpler for you to just amend on your side).

OK.  It seems both Patrick and you are in favor of using only [1/3]
& [2/3] but dropping [3/3]?  If that is the concensus I can just
tweak this one and apply before 2.55 final.

Thanks.
