Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2E348C4C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977736; cv=none; b=HbzwPhhfAGK2wRGCE/l/B84O0j8HNbhZjJXXIzpQ2TDde+DQh6gWCvYPL0Vmh5ysWETyyI/NWQYvar/7zAZoRzn4Fr8p6gOB8yjrqTsCoesyjfl+wEPpECGp4XOAud7VnASv3GYx/QHdyCLj+IIcJCWh+5C5i9JOtfRFM/Mu8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977736; c=relaxed/simple;
	bh=SanGZ0DGqlvIO7TVY6JzGqqrmroVUu7GvpRCTClcvy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThQLJhq36kpJg1h7Q5wH4YvlsYf4yXrzMKnXFuTRxlTGeMcsHGmAYGnskoVihCHeP9ichEjaEerecwdvxmVE3qPhVdMDPQm7hmy/ZX858U8c38yJGoMat+ibxGqja6T6A6csnDm3Mp7ekKUbOC+YnWVcq2icN15hhz3+6Z8uO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nsksjyyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x4eIEpEt; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nsksjyyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4eIEpEt"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CED1EC00D8;
	Wed,  9 Sep 2026 14:15:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 09 Sep 2026 14:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788977733; x=1789064133; bh=SXcASsmo0/
	n7XifAOwgl9eBkUfSupDP0dbbvjsd5KSU=; b=nsksjyydJdPjZZ0vNhy1U5aWGy
	Kep+mCy5LHDogDgvl4/z2Uhml4p9RprAc6ZRBe0KjBrolrOiUqs7CvvDlXmP115B
	HK8SzSNOBOPtK/Y0TuA/GUXCTAOfMbRCsR2NochZac/BtMM//mG2vn3MINza+Myt
	FJT3jC8RW0+tDSu+u6rhIXyG7mbT6a7+y+PTicLUaJaef32fbjawCqnpezZ7xzzb
	u9oZPP0KgRMmx/OfDLtxlnYadAhhwZWh+A+pTsQ9JNZct7hvmQDVgTpuiHPeCAuI
	yXXlGmj18fnduLUURLKMeVqJXcy8ow7gGhy1CviPciX+z0956w53fh7vM5hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788977733; x=1789064133; bh=SXcASsmo0/n7XifAOwgl9eBkUfSupDP0dbb
	vjsd5KSU=; b=x4eIEpEtBQcONiljPrFBVTiIDNGVOhpBE+Ma1Cr+YdtapMTyI4R
	pXVJgDkdcVG+ls6v6uP6BSA/YvKrKEteXbyF+AEXM1VB11jM/j+1aCakYy4FS0W8
	lfiQsFJeQLsDWWbHZENz4KkMAPQW5269DRr7PQgNgv1ZFKt63zpnpX0aNm3RgGxq
	nmePNpD4kzsloBCJroD7x6BKgRs34iB6mwRfjCjDtecjo5nVtemUQjUmZe5hCwSU
	8WKGyn5egjxJ5j+LErbGL/Omz240Yjx3kamsHxXcvzFYThH/CUz8a4jNdChkEeNy
	m32p7MjrepAYg/Pp3BZdBB4nd/Xx5U/FffQ==
X-ME-Sender: <xms:RaKhahAUsdw0kBjejKJwjSAE8WcYtirVvnNZgXlDDLGwQJUO9OgpPA>
    <xme:RaKham_i_R-D_RnnsXmhJNuuauKFm_GqIBPV6hVzjeNKQP9ktGgsYitnx0iV2s1BX
    hxlpG26kvNeXDNaukFrhXrsbZ420QJ4bXnfw7t5m0a3J7oc5DVbonA>
X-ME-Received: <xmr:RaKhap8rW-0D2eQQteDjV8-omMYk3KtRRzeT6plzG3ZE0GESQSUHt8d6MouTgKJMp0xBBk-mQGBDzYUIw0b0tHSo2jMl2G7UWCUe>
X-ME-Proxy-Cause: dmFkZTFxMtnx6DzLoK9Vkw6PD3SD66hj45xkyQB0oE6+8y89KM2mVb5lI8HjlTETNO7uj/
    JE3CmYbiuOUFsBbapKMgSc/eznTpXHBOUYHoxcvRcn91B5qGZMhpnfpY2Od1MTEEqcOiWi
    lz89uLSpoUEtW+mB/Izta+JSGG5H+tamUpCn2oKd5IO8rZwG3G2MGs8gN+VK8mfMIW5p0U
    eUCK0N23Xw9abYl6gRBd1boEhumXkZVBjJ53omk6vwpdvvWdsjFp9E3fiSZuE/w2ehri63
    2wahavMYgshabh/Ydso4cnMz/AGq4snmsPPuiYaKYQp6AhGyl+JZSd0WK+HuUcnfEDJGDZ
    Q2xa1Bbimg7fEjEvmBm3JvKLVuhER7zygjz44ii9X0m21gZqh1GOFZ83YAWu2M4+FPywmx
    R5UtYoDmVG879UeE1y3JW53kOz6gAbYLjV4Xn+R7sIOm23cvuvivss4vPA/z1vuG3om2v0
    lvouie5leFCCly38sFtlhWP5kFYZiMpJcILAQMWHQC3A+VzzrYUIiYQpplN6UmDqKXhFIa
    41/o2mpqivav2RFSrszCwWWIDil9eArHVJ39YyMuHqxY0wHzjItvRNtpzJDidspMX8dQt3
    vhYSvxPLyM60I9pROkWE9nGt7fGCMWnh1BPLgwXsM46864eUm/J9FDkh6u8g
X-ME-Proxy: <xmx:RaKhalfwYPoUcBAhKajQOukQMcEKol74egrDmUm9x4tcRV2YwqM5aQ>
    <xmx:RaKhaqH6yR9invXoDcT6zgxYZsHBB2nxXEF_rHeJ90hL8-PGYckgMA>
    <xmx:RaKharfdKbUQHWsRHyeKJg5rG0Kdx_DxZdl2JVv_iNby4ddh8o4wmw>
    <xmx:RaKhasHajEQWJkm2wjsLcNDySpQkXX98mZvgm_QsAMvmj3NTCDCGAA>
    <xmx:RaKhajK-DOx94OhzwAsexrMwgNluFr8X5FdWKbU5q-UO1MhDlZbbzKph>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 14:15:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] lint-docs: check the guide list in command-list.txt
In-Reply-To: <20260909052501.8448-3-taahol@utu.fi> (Tuomas Ahola's message of
	"Wed, 9 Sep 2026 08:25:01 +0300")
References: <20260909052501.8448-1-taahol@utu.fi>
	<20260909052501.8448-3-taahol@utu.fi>
Date: Wed, 09 Sep 2026 11:15:29 -0700
Message-ID: <xmqq5x0es33y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

>  extract_variable () {
> +	file=${2:-../Makefile}
>  	(
> -		cat ../Makefile
> +		cat $file

Now you are allowing arbitrary path to be fed to this function, you
should prepare to accept arbitrary path, without assuming that $file
has no $IFS whitespaces.  I.e.,

		cat "$file"

>  	) |
> -	make -C .. -f - print_variable 2>/dev/null |
> +	make -C $(dirname $file) -f - print_variable 2>/dev/null |

Ditto.  $file itself may have $IFS whitespaces, and the result of
running dirname on it may too.

