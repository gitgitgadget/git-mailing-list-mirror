Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40194307492
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803324; cv=none; b=ioEVq0b4hLyA3T/bJJRs4l9Yo+kO0uxoApzU3T5krp8QWCZpck5gpLfsq/f8ZoB/H15vL9t5VURdhRXv1t7oX6YSZLN87Ju1jidrw/d7Vj5u2dMHQPGHq5NlWshmO9E+P/IW4IdIJReel+qyHV76wiYclzXlq0ti+Km0EaiRZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803324; c=relaxed/simple;
	bh=syqhr3fwhTnic8TOuAJWw60qoSXMDQLEMW6C2SoLZCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X8Rn/20zxxhu+wfHm/IZovlyTP7nTLcW83NMPMBqoXoTdSYy3JSOpWeM3SsNRd1YvNd12j0ZnJC3jH6rOoawi0M6RzmhsNKG43aWF12DTX9NhQComJy+HzBICjmR0ShKZT5TiDxqaHbmwT8cT5q2Sw3sUwugjBwM1TD+mWUWpRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pMO7KCzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VcmQzukw; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pMO7KCzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VcmQzukw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 82FDAEC00B6;
	Sat, 11 Jul 2026 16:55:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 11 Jul 2026 16:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783803322; x=1783889722; bh=UOb3tbLr5r
	gi9Wgldp+2TVAkK3OU9s8dAESjdbKVs+c=; b=pMO7KCzmsfYgn4+zkZlfjrFDbO
	ADUIoJ20+dyx8AQ8nn5TNSiH2EDbRkUBCMNO3/2l+0OO7+CiuSVWYDqSYmPrRgr5
	uyd/jRxh84Gj/3Y+hZnuM+ZdMF5AF82HV9twyKj3qGQx4beBQ/Si/F0JCq5MB0PR
	Zg96qubSfF+x1DxrvUIldXDUJMIZXtySy3ecMiTrAR82eAA+TZVdVIXkEMej4c7G
	iLnj2tTMLxuWdLx6084o8Rhkb1y82e34Cu2ny4/CpC/FjRFcqHdDpfblG+fqKC9R
	QhsZOssUKLhUMArSvHlGb6P+13k/OLNmku40DNWKTAU9jiZN2/n8Tj+iwPwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783803322; x=1783889722; bh=UOb3tbLr5rgi9Wgldp+2TVAkK3OU9s8dAES
	jdbKVs+c=; b=VcmQzukwYCfiBL5XeKB4n7Y+JFGcMoDRGv0temNZOybMEs9GhJI
	neDlsJWc5Vhl5+C+Ga2nSi9GJZJT9q57T4TRTtfklxQlBnqTg4655STWHwWHvQU9
	aFEz5qI8m8ZlNtfmVhctrRwkhM4G7c6O/To3nEbOitv+Kb5OUPnH8QIRda8hRX3+
	S7iA8hcjByMgqqbYh1FcHNywUbzfzLQYdnA2bko0xBEJqSBpsEWsk0KYG+OPipOH
	MTS3DJ49MbF9eZODoAQjCxOUDYgGb0M/DvFB34w+O+3jxQExKBlp+4c+jMX+2IaV
	WlwSA703jXtGPnADMMPEjVhW+FRClnRpYQw==
X-ME-Sender: <xms:uq1Sai3-ZkcOAejg_2EH1hOGBOXXyOQcFPbOPRNXC8PGrBqMNice7g>
    <xme:uq1Sas0qfS_QtxnWU4KsLtSpGjnYpAifmhGS7n1aB2a1dHvz5pcOSeoyhhlOQ3Z76
    ii7vvhXKeaILcOQ302A8UCjGOXJib8NNuQ2piYP8uZlswkeO8JtdQ>
X-ME-Received: <xmr:uq1Sat_iHFKOJAumpASCLYFeBgC6DWHuztz2rkbQ9J9Kr32MlMnrWK3HOBBB8ibF8TzUKDshHOF-k8SCoiv2E7p1s6GGMB5JIctNToM>
X-ME-Proxy-Cause: dmFkZTEaq+1GZw6Hp45sQcPmpj2vhjv+hpBjhYI9Xsd1Q45eEnlNGM7CYDh15eq8zptsug
    MiWPT7cmQtJUVs9EL4jv0AMYu0X3FgwrtFolHxmORHtK5D6RrgW9BYXV6jpyZUMzJLG8hc
    4zzIoDJbUsC/2jObTGEfb+3KGHxvcX7bMP67oOdecJDYI3iiwJEPJx3QfLVCI3xUgmOWNj
    7+SShF+TvZzh5LBKNAS963ocimVzOMEKs5BNsSbZH9ryW1y3ho2Kx9XFtqLVcTqvGuxKUu
    9lCbreOtSk91YoarGM05dSVqOWCiQZ52nrN3+NOBz2zF7IPYNlVRbaBKgYcYXTGXs50nll
    nRmxTCaYOFvkbwquwI41ZoML+wLnhu8Sq9WqmCnxEWLQyVjF3S0rOKnjdiL8NE5zI4PFvT
    XKxKs86el0E5gO8mjykwNQXrTgOPHvJytFOlJo0tE4k+RborvqiSq9vRhcRfiAlIw7RuNl
    Fja9XD7N6lqtDRZItJU4WmOtKBPdZy112yDLaXNt9IB330n2/Ed4eJo6bAA+SbPNzP30z1
    nKlHar6Yrw8e1TvksPKjhE+DC7bsyKmwHlJCBtiO6bxHUCg/AGKCCDYgakW8J/Ibhc1f/G
    HPp2HUvJiGwztIkgjNo0UhjiqTx90OU725YuoNJGMVhaoMUaA8oXUZG+K/1A
X-ME-Proxy: <xmx:uq1Sah10Rnw4xcdQphgXDygaoQjfINnBboIKoql5f3omGiW1k9BYTA>
    <xmx:uq1Sai-I4NQ6rsztWYShQs9f7jI6awgXIaQTKXmXNo5DEyU_piRaww>
    <xmx:uq1Sapv2dg5eqBouRmjAACYD8MH-sh_ijzMsQ40P4fasDacbdtuV8A>
    <xmx:uq1SatBPBDknkO7W7lEi3mdEdoopoHOUjc5CvmDcg7trBJPOVLvHdg>
    <xmx:uq1SauFma3r53aAQVgAO-vdiY3mqXljNoQKI6KbYebjSdjxOR-1ZV-QB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 16:55:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! fetch: add fetch.submoduleErrors to make
 submodule fetch errors non-fatal
In-Reply-To: <387a34d5-fdf5-4513-9aaf-4e73d9304c1d@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sat, 11 Jul 2026 14:22:30 +0100")
References: <387a34d5-fdf5-4513-9aaf-4e73d9304c1d@ramsayjones.plus.com>
Date: Sat, 11 Jul 2026 13:55:20 -0700
Message-ID: <xmqqzezx9rgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> You have probably already noticed, but just in case, I had to fixup commit df9481e6d6
> ("fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal", 2026-07-10)
> in order to get a clean test-suite run on the 'seen' branch (@a77a48500d) this afternoon.
>
> [this is part of the 'pz/fetch-submodule-errors-config' branch].

Thanks.  I am being lazy and expecting the author to send in a fix
before my next integration cycle ;-)

> -	grep "Errors during submodule fetch" err
> +	test_grep "Errors during submodule fetch" err
