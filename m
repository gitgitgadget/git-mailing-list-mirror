Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8152156678
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749532; cv=none; b=VpfNxqmi5yko4rPRGEgw/XicnDwU2swfCVyLj20SVbIxNGPsCXDw4lNOCkF/KLMm/nthHudwaxpqk2pnLAgf9TFW5Am2Uv/tF4KF7Nnp4tPZcSoz5bFJFd9ArKvpxO44S7ukh1ri5MBiyV7usLxWYdNcpMOTwVzA6rJ5UWEyCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749532; c=relaxed/simple;
	bh=XEOphPKD5ea2zLDmiCFzZYHFF2c5REi/T6YXyhDza4E=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=KUQu/ocdv3D2BkT2HMf3Qxv4DmzP3i3nsJEycFPHgaGgMhP+I9bUoCp39hrNVIT5rv5T4VRoGpgP5W/fziPqzGjB8+tFUtRZ/v0q4rTUmeKWtk3hC3UnM8+Q8EfqutPFfQHrF0lYzW6VNt8mbg00Kl/Tf+ZpXzopQ8Bue80G6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqhHdA1+; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqhHdA1+"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8e0aa2e3f9so1906964276.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753749530; x=1754354330; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+sVGJLSF5QBk6pNha8guoi9W2Plt9XZwTM8nBMZ6Ww=;
        b=hqhHdA1+3SDoJMKN4WAitIIi4uAMYS2PXHa62nduQPe4A3TYrTntwWxgcyWZg9rnH5
         38Vqm2AO/IRLICuSZauUqi7uNhxbMNCrq9tZ0Od8GyviZ2jn19b2RqRvQB1t/ymFtvBn
         LeJyMJ4L2jNtmBFH1Gz03sUFekRkEEoUGDolkCzeRoAx/8xwK0NftQgcez/2C9Y0nfeB
         NKria4ySc2jWLE5CPKAGPpMUVDknXACkcatK2hSy+lUriYyjSuEYJmLOyYG9QzZsq8Ew
         tfg4p9mQexCmLciLwDJzCQzoya6a8hzsIH0/mB7cQfKpMCcOoaftgbB7Q9sDOpX99kGG
         V0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749530; x=1754354330;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+sVGJLSF5QBk6pNha8guoi9W2Plt9XZwTM8nBMZ6Ww=;
        b=dhprciKLlaK30USVyiWvXem6LTNtFbLYwgSg3a5d9DcW74f5lup6rGtiMdddLfh0v2
         oylc5jm7P7dew6xeJ0/causbAuAvJA32+9A7yoEgyl1j/LrY6BN6pod6Ulx6P82fHxbR
         Ik0fZweY3MN5MNRXPG6d4Sr3v2oIYOTGqwHUh6g9wvx+0u4n5EV/J8JTn6Q3dhWXBKq3
         fLTMizlLS8js6snj+AyBVUFC5hM0KEkhJ7QliUjDhVkBUYtr/eGlaVWksegeeKme5VWy
         iW076DxPhdDeKWVfA1rm6Uk9Um7uk/JX1pwyPDIriaOiI4gH2vOhZLukUtQ7YZTLuAll
         K21Q==
X-Forwarded-Encrypted: i=1; AJvYcCV59D8fKYd8iiEGVC9sUgh2eb4EUKaUl4q7D7+He9LNvpF518SsgUVyarKUFJO+GzVWooM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzztcig/JC2DI4iJvKE9rj5XIJStvgEkId4XP4e5k+blCgF4jHx
	1NhSjUciIGyetl2Wn9sBZb5kqh4czAFcx5e2eTnSwEBh/j6BivygDxZv
X-Gm-Gg: ASbGncucItG7tomo9Nmst82jd+JtL3UfAwF1QcLqIrliSM58yQrhXU86XMHBL/Vr3BF
	c7uPA/SdupxyIMpjzkDlQrQoaUK6sKpv/JdOyDjkpjoo+hDrkkGK4+MGKvacNkMy5Z5t+ykGcgz
	xaZS6TmtAhIV7tZh/702uJ60av4SgG3MVVA7e4IytbK8YJiUl8ILN5Nh5O+VhRb3g0VklmJuD4Z
	L/nICJvLCXsxgP/9EAbXXd72u7z+o7EY9QKRkNb7KhTeh5+PhafEHpGvFSMd7Zuvvh4+/+ts+wR
	+LiomMYxhWlW4DsoMV9ZIKh6zfZnPRBXJLjeJizHWdN1MugJUzPGoXVLQFOv++zd2+Rez1WQ8KX
	aXtLWdboDyXv0/qPYXON8Zch12kSKrdpzxpMGN3kYyw+pdUl22XwgpPkT
X-Google-Smtp-Source: AGHT+IE9bkp9yxEU6QB8sW4t1zYC7TmXnNSXuL+xZ/UkvKvoZa8kWG562exFoL18cioYujgQT2UdrA==
X-Received: by 2002:a05:6902:124c:b0:e8e:a59:897c with SMTP id 3f1490d57ef6-e8e0a59a237mr8881941276.14.1753749529773;
        Mon, 28 Jul 2025 17:38:49 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:59fa:4cd3:495a:22ea])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df86c4932sm2332761276.29.2025.07.28.17.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 17:38:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [GSoC PATCH v5 5/5] repo: add the --format flag
Date: Mon, 28 Jul 2025 20:38:39 -0400
Message-Id: <D1CA8142-1090-4492-B11B-F3CAACD0ACC9@gmail.com>
References: <CAPig+cSUnejuxYHvk3hzb_nM6bdEPydBsKgD2FkOX5sfQ2FUAA@mail.gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
 oswald.buddenhagen@gmx.de, ps@pks.im, karthik.188@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk, jltobler@gmail.com, jn.avila@free.fr
In-Reply-To: <CAPig+cSUnejuxYHvk3hzb_nM6bdEPydBsKgD2FkOX5sfQ2FUAA@mail.gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: iPhone Mail (21F90)


> Le 28 juil. 2025 =C3=A0 20:27, Eric Sunshine <sunshine@sunshineco.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFOn Mon, Jul 28, 2025 at 8:15=E2=80=AFPM Ben Knoble <ben.knoble@gm=
ail.com> wrote:
>>>> Le 27 juil. 2025 =C3=A0 18:02, Eric Sunshine <sunshine@sunshineco.com> a=
 =C3=A9crit :
>>> Simpler:
>>>   printf "$expected_value\0" >expected &&
>>=20
>> (Below as well): the shell linter I use does prefer to see
>>=20
>>    printf %s\\0 "$var"
>>=20
>> to avoid issues with the variable containing format specifiers.
>=20
> That's a very good point about using "%s"; I should have suggested
> that myself. Thanks for the correction.
>=20
>> (Backslash has to be quoted in double-quotes, too, I think? So I left out=
 the quotes here.)
>=20
> No, backslash does not need to be escaped in double-quotes. The
> literal form `printf "%s\0"` is common enough in Git test scripts, so,
> for consistency, that should be the form we recommend in reviews, not
> the form lacking quotes, I'd think.

Right; on second thought, shell quotes (mostly) don=E2=80=99t nest like that=
. Thanks for the catch.=20=
