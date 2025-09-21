Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC861A3165
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467262; cv=none; b=q1yG3xReDsxeRaD45ZgFBWptNoZab7jg9qvLyLx8SQAXTpjY0mS2Y0c+GFm1zHHFRispo+wiDVo+yeJrWYqXG7K8zXQ5KPx7yavgrrmpiKjAwQtobGbeFZ09WvQdeVz+nM+wWzl2AVsI63BidJ2ZrE/e3TktGqK/bg7OsPBfYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467262; c=relaxed/simple;
	bh=4OVXj/oHRP8vp3AkCvbqGHJf9/nSlnjB6ADmQozTKYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+mwokDyBNj8PssvAFp9pBw/Pwc3ThUpuCpddplKGS1sqik9W571Zy+8fTuMgbQDusmXlh7U+aRcXhLgY4d3f7bG19Wep3j8kYsyjOwyO2mDdDTTrC1gnHbvsiwLe6Vzpf5vgL6ziesFNAwCgVYB/PEIKgSlPnl4jR7B0PljMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZv83Hu7; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZv83Hu7"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57afc648b7dso1807129e87.2
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758467259; x=1759072059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psDcVhu5BZpcocQFgRmv333ZnEvbKup4MjT/QN4mU1M=;
        b=OZv83Hu7ZGPxI10hJhmvMFy0uL0dCeZSo+TfhdhtuqtL5g6nkmdt0/+Qsln33BLzCQ
         JoHVF5PSjeJ1rLL9YExFZ1lJz6E5UTU96pojImsi5dEl61Lh6K47RgGPSf4WQXLYl89l
         e0Lg15vHwnrtJ2TobmaUhNLTG5KX7KI9J7aCp9/hQpTlEXGf/d81hbqFBOHbJt0NMNii
         G9qfwEzAh3RzsUQkMD5Deu/DWnKEYU/g5G6TrfIU8ml0PTWHtTRmhiqWruSpYv8BN1YL
         zWhDcaA9+5jp83l9/ndfoHtAY/8Oa46BsTg38dmjoLbuIn0MNdNLXPLCPjZrSXBeN60Y
         qabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758467259; x=1759072059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psDcVhu5BZpcocQFgRmv333ZnEvbKup4MjT/QN4mU1M=;
        b=QskkxIMZma7LbOxKIq8k4HDMv40Z7025y6PVkO5AykaA8FvqLZ4XeYGFbwfGUmfzPW
         3jD3BcXnTfVaosw6WsZGar4FNKLOmZwoHLFzWflvTimfCkYMorJhN0KDhv1VV3Fv1xo/
         t7+eWYJodyaHidGN44ElnwGkdaaYDpDLZLOKLshTvI270C4PLReA9sVvgQ7qMivI60sM
         NISgwStSD4Jf/vFjLOphFp4r6CtxVPCi7tfA8MeO52eemce+vdv2ckYk2lnKikXmTUy/
         m4/rPLakL8TwbKQT7KvJnixWbP6WPxfOm9Kzj+KN6BjX1pTZljvunP4/phtRCOLkgbKH
         MeIw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7vskuNNZE4DKkwURgeFZmygHd8snIZkfOb6Fzh3U87LNI17doJoectmXfs/dGogwNBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJYvvuUWq4tpeLRMDzH/GMcIM+JY/ltnpgqQawf3Ev1nJJTEQx
	TG9fZ9yEicZl6QiQ7/psk/8vmhgZolaclSKwig2hjKN/i7ujcCyPMgGKr7hT0q2qfNShenSqxvJ
	OICiu3wPGG4kOurygOzB2u6g3JZQk/lg=
X-Gm-Gg: ASbGncvjDFJlXaInNToHTjJ1BiCsdfKf6qsvkDVxZ5+9p/YTwic9PHg8RIV4LkYlp2n
	+HgAe3Q8JfBvgVJ8B2kU9GIlNbMlJSPfT+vVKoUIZgo3TLnXNM8w9VnFTWVJ3lGEOipj9Z0NByM
	dTsq3/mfjSg9hAzs7holKQr5HFZomm/jWjoP+Ht3Kl/l/WzQ2nmEwXC1zHjE6zes1Uye3a/wvLO
	bADJVuML6KQX2wt2g0=
X-Google-Smtp-Source: AGHT+IGX35d8g2sLiimW7NZzB9Ctmn1F4h25rBPVH5eFxGtJMCuWiJpU3gOxDVbJtMcqlO4NQU9EkDR+BTkfAdg9PFA=
X-Received: by 2002:a05:6512:3b9c:b0:57d:7343:3bf with SMTP id
 2adb3069b0e04-57d734305camr1006411e87.49.1758467258741; Sun, 21 Sep 2025
 08:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com> <ddfee67e06bb56cfa8f11187dc27135bfce63647.1758294992.git.gitgitgadget@gmail.com>
 <cd39a321-a6c4-4126-a716-dc0b0cffa68d@gmail.com>
In-Reply-To: <cd39a321-a6c4-4126-a716-dc0b0cffa68d@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Sun, 21 Sep 2025 09:07:27 -0600
X-Gm-Features: AS18NWBoberyr3Mer7UOuLRoXvkVG3PGzJ6mfgObqgBud4QlW1deZ_b4_mJGsJM
Message-ID: <CAH=ZcbD6aw-=93URRjYKfYvt+0z2YrcwfyY9TmZHSsXXsXiB+g@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] xdiff: delete xdl_get_rec() in xemit
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 7:06=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> Patch 6 goes the other way and introduces a getter function that hides
> the field accesses so I'm not sure why this one is so bad that it needs
> to be removed.

I've added a copy below of the two functions for easy reference.
To quote myself[1]:
```
The fields rindex and ha of xdfile_t are specific to the classic diff
(myers and minimal). I plan on creating a struct for classic diff, but
there's a lot of cleanup that needs to be done before that can happen,
and leaving ha in would make those cleanups harder to follow.
```
get_hash() is a scaffolding function that will reduce refactor churn.
It changes a few times in this patch series alone, and will change a
few more times before the code is cleaned up enough to delete it. By
contrast, xdl_get_rec() merely performs an array index, which is so
trivial that it doesn't justify having its own function.

get_hash() reduces confusion because xdfile_t.ha is an array that is a
sparse copy of xrecord_t.ha values from xdfile_t.recs. The field
xrecord_t.ha is confusing on its own, as it is first used to store the
hash of the line and later repurposed as a minimal perfect hash[2].

static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {

     *rec =3D xdf->recs[ri]->ptr;

     return xdf->recs[ri]->size;
}

static unsigned long get_hash(xdfile_t *xdf, long index)
{
    return xdf->recs[xdf->rindex[index]]->ha;
}

[1] https://lore.kernel.org/git/0bacb1191dad2748d2afa79665f1293b0381bde1.17=
58294992.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/af96763036e13480ed4e6dfedcade5b2c90e414c.17=
57274320.git.gitgitgadget@gmail.com/
