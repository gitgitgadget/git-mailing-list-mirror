Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2A344DAC
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784892972; cv=none; b=SuWzN1FWxRJc0nL/WtOeqCHJYTwgQbexzECjKDHz4oF+DtiS1uYZpnC2rOjbEbIZShs7fR1p0OLGhiscBV6UJgwL4+vr34kzqhcC6ECq/rak5f5p46y/r2B+13NnIlSRmgHjnqNAsDWyrMVXVmZYGCdMkeqIVq8XlhEV4Kfqt3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784892972; c=relaxed/simple;
	bh=hqUOMVyLXXZeVNy2fLjkdALD7JEbw2twK17STE6UJAs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=jDgSosxXIuuFelC9uESCQnTQ6acKpOGOpWu0YMx89KFIPjTY2ceg4S/TzjSxqjGac/C/3zVb0e/yN5O94zKBK/bo0OwCSObyc9ubTDXi3/lQiSFsJA0crSyraw7lpAVzL9tSq3hX6rJYgQBjquNiDWjFxaPWUM5JdkQZhO4JTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwi7PM2U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwi7PM2U"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8485ef63b68so251451b3a.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784892969; x=1785497769; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0JDtbsHq5BSAxC2846+k5v/MNsjZcQZynoidxi+UUA=;
        b=nwi7PM2UysPlCqzJFdB9ZD4Te2iYZHpF710bUiH82rRub6wEsJgzbtunO17Mo8N7tC
         /8N2jJj61IEKAbrPcMJdQL2CWEliH6HPpi0E3JdJvs9jXaqIi4OOazLrwA9WNARCwxpm
         Y72BDpEcnGtZR01BvL4grt05qITAEixob8YNa97Vk4q4ecyxm0VIHshN2oVrd5XCAgd+
         Qk3DxJPPOnpPwAsSarVMtZmgcSvTC9U11RmSjUmZkpe0oiwCJqXqm3WYKa7u0XZ21O/f
         mI4uvZf25vWQNB557jPiYia+ElVULLQsZcWwqRVyN+9lfZE21sNqiqYK/YDb9jC+hy1u
         k7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784892969; x=1785497769;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0JDtbsHq5BSAxC2846+k5v/MNsjZcQZynoidxi+UUA=;
        b=fTDAAW64jqE5Ss8GsChTP1d/zJjo4OvPD1Nq003fXcuUmC+daADDozv6Gah7nERuEb
         5VD4waB5auSUvRe2mtN1M6FEXMdrf2g+Oq8F9GATm8HDNnIyDVUswtYXJWRvHSCYMf6S
         p65yY6ZVl6VqAQMNWsGecr0YqqSWWXFta73znwYyFhRvOusbucLc53imn6W2ZmoOfU+B
         3KzvONnqTH1rcqWY+EpnRauqiN0yl3FCNu2S+LHBhe1ZqfVOG6NryZxSR0r2tLYsBjHe
         MnDDjZ4t7fHZ58yiOTP3jf8ZdTJ81dKvuf4XmIc38yr4SR7MMeu0ZNDy/BT+u/camPNm
         VrRg==
X-Gm-Message-State: AOJu0YyztnKU0ZrXD6h9gT3MWQ4bttI5ievS1Z527bKyzZhV3ng3nS0C
	toXLE8V/z88NUJMyceh4LSoiqREo5T3cxrkTBd7IXCM07EgHT+sTr7bh4xb9jSvW
X-Gm-Gg: AR+sD13miFWGGxKtQynNA4ruFcrfrq51sewdlj8AEhB/8oWRFagXWlG3jf/1Xwzp027
	BYI3HX3F+9MArT7FYZc4j8uJV50UABUmXFQ0sZkHiwv3Pr8NJe2bZ/iY+ts1+rcwnDOPdZikdNk
	RMAQf1Xf13cvPyG0TnKfXZWk6JiETAV/AspsTl1TuNM6OMCT+VBtltHeP2iYvJllZuA1GSzxFfG
	rYorpbknVZuHbn3erDmvLFdUvFTFbmlJpOLQ61ma36oDFrG1o400PQVpotB6Z95KGsM81zxyt2J
	0gh8qN4oSwQ70sWOONAlRuiiYIiiSWdQ2vJ15kZuLoZ4NTVDuZ56+MuEZcpE1+aJ8U5t4BNiRBy
	CPceBgolSUtPIQdtUZsmXdXCFAJYqFSq7iT5AbCh/3U7x4+gqqpye46A8hUoCQ54ktrw+NePaFO
	SAeH3Lvp5J+fBUu2rJm+I0yHXs72bDue7l2fUyWrV1dFDbzR0VTsCnlIL8Fv5qI2KrRso0ofee8
	WAZVmZwwptjePCn2WuktozP2gCgyYCmWfyQIkcKow==
X-Received: by 2002:a05:6a00:1913:b0:847:8b0f:2508 with SMTP id d2e1a72fcca58-84e2b7f966dmr8038689b3a.13.1784892969508;
        Fri, 24 Jul 2026 04:36:09 -0700 (PDT)
Received: from smtpclient.apple ([61.83.230.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175a3d6csm4468388b3a.40.2026.07.24.04.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:36:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] urlmatch: normalize ssh and ftp default ports
Date: Fri, 24 Jul 2026 20:35:57 +0900
Message-Id: <DE62DFBE-ED4C-4EF5-8F4D-FAAB3519F86A@gmail.com>
References: <20260724004011.41795-2-fpottbaecker+git@mailbox.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?Fabian_Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
In-Reply-To: <20260724004011.41795-2-fpottbaecker+git@mailbox.org>
To: =?utf-8?Q?Fabian_Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
X-Mailer: iPhone Mail (23D8133)


> Le 24 juil. 2026 =C3=A0 09:41, Fabian Pottb=C3=A4cker <fpottbaecker+git@ma=
ilbox.org> a =C3=A9crit :
>=20
> =EF=BB=BFThese protocols are still supported by git and have well known
> default ports. This leaves FTPS, which does not have one default
> port.
>=20
> Signed-off-by: Fabian Pottb=C3=A4cker <fpottbaecker+git@mailbox.org>
> ---
> t/unit-tests/u-urlmatch-normalization.c |  9 +++++++++
> urlmatch.c                              | 16 ++++++++++++----
> 2 files changed, 21 insertions(+), 4 deletions(-)
>=20

[snip]

> diff --git a/urlmatch.c b/urlmatch.c
> index 20bc2d009c..0c2ddf2e40 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -274,12 +274,20 @@ static char *url_normalize_1(const char *url, struct=
 url_info *out_info, bool al
>        if (url =3D=3D slash_ptr) {
>            /* Skip ":" port with no number, it's same as default */
>        } else if (slash_ptr - url =3D=3D 2 &&
> -               starts_with(norm.buf, "http:") &&
> -               !strncmp(url, "80", 2)) {
> +                starts_with(norm.buf, "ftp:") &&
> +                !strncmp(url, "21", 2)) {
> +            /* Skip http :21 as it's the default */
> +        } else if (slash_ptr - url =3D=3D 2 &&
> +                starts_with(norm.buf, "ssh:") &&
> +                !strncmp(url, "22", 2)) {
> +            /* Skip http :22 as it's the default */
> +        } else if (slash_ptr - url =3D=3D 2 &&
> +                starts_with(norm.buf, "http:") &&
> +                !strncmp(url, "80", 2)) {
>            /* Skip http :80 as it's the default */
>        } else if (slash_ptr - url =3D=3D 3 &&
> -               starts_with(norm.buf, "https:") &&
> -               !strncmp(url, "443", 3)) {
> +                starts_with(norm.buf, "https:") &&
> +                !strncmp(url, "443", 3)) {
>            /* Skip https :443 as it's the default */
>        } else {
>            /*
> --
> 2.50.1 (Apple Git-155)

Just offhand, not commenting on the rest of the series : the comments look w=
rong for ftp, ssh to me.=20=
