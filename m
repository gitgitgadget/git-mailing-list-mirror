Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E33F485F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537140; cv=none; b=EOHFtxode6T68R0XTaXf5+tDlS5xXZWfYBXejJUg647l7ECfXRSiR1l736x0+t24UMuxJpS3v5r7k1RFOOG/H/tRrPDGjI5PYha37eww1iEUBOvwx8KDdFNf7ZsZM0QXn4owyKldDc5ZFb7+lK9Rdnsjm6Ng7pIDuI0pVuehiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537140; c=relaxed/simple;
	bh=ZZaByhZUZjzfLBholSVFLWoNXj/YXE8oCjJOS5BCERc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLbcuENi6Fhvgi2vX8PZ4FttUY0oEOBcuIwNlaskeaGMWKkBShXlC3DdbeizymSXOHWVTlB1BApaCd97xHvplhXiuU4lOHkrgwcTFZwl+V/yw/Ob85SK/OxQgmHTmUU9nvHts3FAsoTieLyR7P7C5TPRw23/q9qJXbkctR7bIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=chCtijcp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yp0ETIon; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="chCtijcp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yp0ETIon"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 243BC1400071;
	Mon, 15 Jun 2026 11:25:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781537138; x=1781623538; bh=a+ozw6NexB
	iyDNeL7SwoU1M26BieKNcj7ziBAtKt5JY=; b=chCtijcpMtu83mWd5tayxjY2jR
	Ue0R0Uh5q0FGzY9TGh6yjQWbdClB6SUASjzkynRZwO/rfTzPJ7KE6XPfNsIIV/lY
	38Hj3U5nmyms3l52+DX6oAAPd/EJFy9CFWAzHxzwVhYfbfA1zepJgYmxeh50VO+e
	dCX9uFC0QOfXTNGAiZeQ9DfOcONnXayL8e1fSIF1lZL/04RNDbqcJA0Wttd+98Tx
	EpJXBSuR69xEhFR4+8dyMyefcOVwvp31iUCQea3KTDuaFM2GCxGkA5EGZtaQFaWJ
	DVmAXSn/ZpIJkr+7dDbeV3Retab1KyaeZfHq1jfu1/69IhxYH0IoXL61JXig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781537138; x=1781623538; bh=a+ozw6NexBiyDNeL7SwoU1M26BieKNcj7zi
	BAtKt5JY=; b=Yp0ETIonAKcJg30z4YLQIxyZgsd/PJ0NQNZx19xAMBTMO4JyY3a
	WxZH8WvZ6en3G7mxfxr3LWmyIvocTweW1EDO7le2jNAaEASsDCPFvDhHeHng4C9k
	G36kQZ3PPRiLhbhzBg+HFWahADcoDDQVIFLvzpRW/G2zPK17uJD6pMduxCtB9DJl
	HAMWsx3SEFl7FSVThoA90RRmaaOgd7MchFbuhZ+IZP9RzxaOJBnNTUaihCStP/cs
	g3cgw4gkvCkpM5dYrT32TbWGhMTvyLC2T+Cl5TvHox3unK7qq8dlE1mpA5Vk7aM/
	VpdUhKh3z9+5pe3xotxLfQRZkCaVtYVy9Yg==
X-ME-Sender: <xms:chkwah6p_gwYI4aM-xge_STBZIzASdzBOwfm2CdyUxirtyj0Idlcdw>
    <xme:chkwal62NaPVBHCfYl63e8BpQYEla73KHkMMTfkt1PG61-DaATg1fG_nwmGE66-C-
    qyDJVOTQ86R5Rq2_ErNeIIR_YnBggzfb5kTnnLDA00qUXFwMnzYgQ>
X-ME-Received: <xmr:chkwatcnSdAIHoa4ar2zFNb2LgZLDyvKGJSZtyo__JInD0JM2KSW8YqHn_1avDjzrNHwudXtKQhUFcn2mQjUiUJdAYtt1lwRd7MH>
X-ME-Proxy-Cause: dmFkZTGwIzkRyPZ9MvpjorgJiM7AKxzkMahw53laZzAKrg+8DxrIZrvHbmzSRgv7DRP4NR
    26s1WwhNqUw6R05Lxuan+MspU9wiHJibJAn0F54kSa4VpTOvf7GUdnV1/vS/QwNvRPkUab
    BlLpVUpp+pTmakv/Cw0wOWeS6LlTjFM2XNDJYDVBfs39y4Htty0n0lPbUjZgf2EthfF4m0
    Up+EEMdYC85xpS69gMVzDXAmgdTXMRlAik1gJLzIlDdll1KnRawNTYyHRBT89Ir3Wz7tqL
    dU5jrzf/NQa3gXOBYHaq0zhtnrx+FYLhD0U4vr26XklLpiFIXMeec83udzgPRRpXKgy0Fd
    SdYoFxDYKPUaeB/WK5Nw8+7FWQ9OoVbnj/kJ76NgJ5ddPIOCFiyOC9rcDKhqlzTFt5w4Vi
    ggVdJAhznttzbYsgRz2bSoV8qDmrCzc5l+gR2diCI5+njeElhJrWsUmkGmcV919ZGYW8m5
    wQhqmcmiyWdhGk4MQUnPSkhpYT4BgbUewDhmj9wFhc5+O5wYIjgo9PUHlnk+ROIorbyEOv
    DlXm2wwJWbJ5JPZEPpeQyh5cXEO5ssmxRwNS5c6DW/h5H1B0tH82lfCbTd+QDljsDvR8wY
    FfUbjuO0KNzVPMlG1bE6Tc3MsC2rlaO6OS/um63gM4/WDAf4XpwrjI5OD3cA
X-ME-Proxy: <xmx:chkwapAuRW7k4GHvtNKXjo-9DkjVDK8EaNuESSwfirYsVWd6ykL1RA>
    <xmx:chkwag9pS5WyInLJrSZTlX5sGlllLJn0MDsH1GHP8oFuoJpi0OAPlQ>
    <xmx:chkwakKD6Xt7qC9Qm8bLKIM7mP2Waq5MpRZPn5D_vnd-ollLGx9dpA>
    <xmx:chkwaphCHVMsR5COdW_HEiDq_WFFTO96IVBzm1W44KF2GdiX0UgjDg>
    <xmx:chkwas_gxJZYkFAPjXH7LprfOpf7jxWS_qObkVzqjiCQqnukh9sKXJky>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 11:25:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Koutian Wu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koutian Wu <ktwu01@gmail.com>
Subject: Re: [PATCH] gitattributes: fix eol attribute for Perl scripts
In-Reply-To: <pull.2151.git.1781497525828.gitgitgadget@gmail.com> (Koutian Wu
	via GitGitGadget's message of "Mon, 15 Jun 2026 04:25:25 +0000")
References: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 08:25:36 -0700
Message-ID: <xmqqa4svddvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koutian Wu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ktwu01 <ktwu01@gmail.com>
> ...
> Signed-off-by: ktwu01 <ktwu01@gmail.com>
> ---

Thanks.

This typo come from 1f34e0cd (.gitattributes: include `text`
attribute for eol attributes, 2023-02-03), that added "text" to
those entries with eol=lf, which inherited from 20460635
(.gitattributes: use the "perl" differ for Perl, 2018-04-26), which
inherited it while it was adding diff=perl from 00acdbc6
(.gitattributes: add *.pl extension for Perl, 2018-04-26) that added
the .pl pattern.  It is interesting that nobody seems to have
noticed the typo during the reviews of these three patches that
touched these lines ;-).

By the way, we'd prefer to interact with humans with real sounding
names rather than handles, especially when it is not particularly
secret.  Your authorship and sign-off information will blend better
in the community if you used "Koutian Wu".


> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2151%2Fktwu01%2Fkw%2Ffix-pl-eol-attribute-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2151/ktwu01/kw/fix-pl-eol-attribute-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2151
>
>  .gitattributes | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitattributes b/.gitattributes
> index 556322be01..26490ad60a 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -2,7 +2,7 @@
>  *.[ch] whitespace=indent,trail,space,incomplete diff=cpp
>  *.sh whitespace=indent,trail,space,incomplete text eol=lf
>  *.perl text eol=lf diff=perl
> -*.pl text eof=lf diff=perl
> +*.pl text eol=lf diff=perl
>  *.pm text eol=lf diff=perl
>  *.py text eol=lf diff=python
>  *.bat text eol=crlf
>
> base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
