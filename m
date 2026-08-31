Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987B37C929
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214209; cv=none; b=iyVWh+3u6jEsOLZQ8QqPWMinzhDGzyx3Ktpnw0/3rt1w+OyTPFnkrhjHOm7lCDdXWobJgAQpaGaPfMPJljpI9gj9iye7R1B3Naq0TaKcBwrFcMSTWuuW5MQyUK9wcH3R1t+gEK9dMPn5H0A/iUDcNV7FPWcrLZhfReZAi3LoHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214209; c=relaxed/simple;
	bh=67yPpFx3yOWUT6fyAuKNa1Q3SpsrMYmFHdlFeGFFET8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrVlSZ+WGD8cizRItgEyzi1W5a/GCp2PIuhK+VL0jW9P1kEzeF7d/Zw54pePrm5ujeG4vpbB/+hO7bV6FmwGA0vRbu2ePM2/ubC/O8/pjSPqXbay/3BJWiBOMXW/mBwxR6i054jHbJL4gofcT2cOLR12KAfhpLa0x/qqErOCMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMmnpTUG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jm8gxQUc; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMmnpTUG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jm8gxQUc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 650B31D001F0;
	Mon, 31 Aug 2026 18:10:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 18:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788214206; x=1788300606; bh=vhOvQO9zKf
	YQX9y4dokl1nYApXXc92/4vDL56zQqGiM=; b=RMmnpTUGGcS+cuk3oGuU4tgomK
	9VT3k/7U+TIDbYyzqMrxJ2KO6glVWsVppTfQhglRSg4qAbi5utozWm8KYPh5hozg
	9tDeBAoPs1KdC5xIK03T/mwWpwmcKj2xkwESId3cDxChmiqali432iW080JZ0RJq
	LdBL935siDNuusKKYgUD3gaJTcJ6QSO99P3Pb0BQ73ngm5Jx6M+1j9jfLV1d55yr
	P3vQGhNf7GwEX0KUyq8/lO0z/MY8IeaykfdUeAT6GOwseSLzK2DR+yaroip8eil/
	DGQRziOEnr6MgPS2TLc2XUpMiGFaJ4Pp2Crg6rPl2BkLMy/MzqQ0yU5auUuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788214206; x=1788300606; bh=vhOvQO9zKfYQX9y4dokl1nYApXXc92/4vDL
	56zQqGiM=; b=jm8gxQUcjpgL7bNHpnSOa8vv4rTuCtgeDeqcIEF8nmQgchl5hjw
	aCU/dzAeLvgB1r0aVuRmOmR5OVkgq9WRKlOKXeO3Td9JQGuYsN6wJ3EfLlx99sAw
	k44iUJZ5RluQttCMHs3EHe90W8g2/yzsVcgaosMHMSTBUsgU/OE6sRrcyz+mSNf4
	9iDDbxfqcXVi8comt4tC4ekz7EbweeU8Uhq872dAsAGX+DOhGxmRyamYsCrDKpY8
	snS7nVjpjcClSpYThqDWoqp41HBjGhrmKPffagahSpnBSwdyQmy5NyPEPBQVEFSe
	JzglzNnWkbPU201iusoIhN1u/pBbSD2ww4A==
X-ME-Sender: <xms:vvuVaiUzfP7_pLJIVj1ch9-Sm8bYcFVSbOjs9aQawRtrPRSOt4__JA>
    <xme:vvuVamD8wt7H0MvXf3nNLmx44ccimjRwnhNBIWjcPw22SPphHDYx0pO9UYkwISfub
    MzJrhzt7gVrv2ACFYu1oyCs62RoqRu_g0agSudeMdzreJOoig9f330>
X-ME-Received: <xmr:vvuVajy9wSSJ1u5wHvtd3ggnAeEQEPdyBIp6gnS3h2MUayaAmGWFyNBpezWBWg6tu2fLxUqaL2FReQACVjuN0onHkgggLWNoEw>
X-ME-Proxy-Cause: dmFkZTFv78RtUZHY8z2Zx6SiZXkM76JTHpw0b6muKuRseOku/ZvL2B1tmH6Ixc24N8EJQ+
    i3ob20/mPsLcwLrHuKst0mJmsfpozTNs+JiN7rfVne0cewysX11iEvBJ9RA2OmyDg6kNlf
    SA0mNFIyt8u3p5Hqjdb105+mQHdo3pCplZI9wS1EPCdr++q+Hh16YQNJljBPTaSy1aRTBs
    joGamjDeudcOcvS+EJv9PCYNziPd+MahfbHn2C79OxxS/PJzdHHA3UWupKl+P/wlgP+rIH
    /3lVpYajX+VlL2zJ2uMYyVRTn+ZmAyaWwaKk2m6kKoMQbJ1plJEmlt1NgZAmWa/Ow17bJl
    iGDvOyjHwahNj7kxD/tTK3T9kcX3vsGSglPCe5EFQbtv5l7/vk0om3lebnOJeiY+F8Kl4c
    kkBXiEpDzuK/CoMoWV1b5tsfgbFkHh1WTlfBrPqafzQDORbqSlwtd6AFGapi1n38zmfpRy
    v6uqEFNijSeLmHKpyLmV8GqUDb90ql8z+Ycs264vYnh1z+ADF2i8t6wTslIxYntOHjuaxJ
    sYSj7NI/XVo38Vwgfhr6z+9P55FaCuzPo2Tb4O9E4geZrT59zhMlKs0A5wrtnG4CAAxgbV
    KkZzrtfnVVM/4a8TyMwr9L4qz2/PQsyACyefKVjbZbBvykM0S0Jm5ff253YA
X-ME-Proxy: <xmx:vvuVajD-mxr13CosVVkx1SOaHiLwgTp9bqXvkWD9eItcBaXrUUJw7g>
    <xmx:vvuVagbWa9nNFYHW0Mqj5sOFmCFA6SG5TSU8LsIoyp6yt-TKAW8R9A>
    <xmx:vvuVargFTQFUUBwU54Zohu8za7oyn6QwueI8XV5mKnDZorR_0Euvow>
    <xmx:vvuVai7JYQTyjXOR4ZNKdGdtmYefX3shsCg4uy-z9dpJ0QiqKETBMQ>
    <xmx:vvuVasaUVBepLYhgHfdp8JEVgiMIr4HsuRPUwcRjcrMENARAWa0zurMg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 18:10:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
In-Reply-To: <20260901-typo-fix-v3-1-cc342f329190@gmail.com> (Hardik Kumar's
	message of "Tue, 01 Sep 2026 00:59:13 +0530")
References: <20260901-typo-fix-v3-1-cc342f329190@gmail.com>
Date: Mon, 31 Aug 2026 15:10:04 -0700
Message-ID: <xmqqik4quekj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hardik Kumar <hardikxk@gmail.com> writes:

> The patch fixes two typos in two places.
> versioncmp.c:           "fractionnal" -> "fractional"
> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"
>
> No functional changes, only update a comment and a test_description.
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
> Changes in v3:
> - fix file name typo in commit message body
> - Link to v2: https://lore.kernel.org/r/20260901-typo-fix-v2-1-6aeafbae6389@gmail.com

Thanks.  Applied.

>
> Changes in v2:
> - refactor commit message
> - Link to v1: https://lore.kernel.org/r/20260828-typo-fix-v1-1-24e80a87ed53@gmail.com
> ---
>  t/t0022-crlf-rename.sh | 2 +-
>  versioncmp.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
> index 9bd863a970..328c6e5903 100755
> --- a/t/t0022-crlf-rename.sh
> +++ b/t/t0022-crlf-rename.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='ignore CR in CRLF sequence while computing similiarity'
> +test_description='ignore CR in CRLF sequence while computing similarity'
>  
>  . ./test-lib.sh
>  
> diff --git a/versioncmp.c b/versioncmp.c
> index 3a81b17bc1..f1e451755a 100644
> --- a/versioncmp.c
> +++ b/versioncmp.c
> @@ -15,7 +15,7 @@
>  
>  /*
>   * states: S_N: normal, S_I: comparing integral part, S_F: comparing
> - * fractionnal parts, S_Z: idem but with leading Zeroes only
> + * fractional parts, S_Z: idem but with leading Zeroes only
>   */
>  #define  S_N    0x0
>  #define  S_I    0x3
>
> ---
> base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
> change-id: 20260828-typo-fix-721b77177721
