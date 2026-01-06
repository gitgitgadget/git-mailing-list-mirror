Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE041309EE5
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767698991; cv=none; b=ucyJB7R+iHMEzjOMKwDKz2pt9rUEW87Z3IqOyPwVorjedR05k6WaGiXH4utc8Fowl7p+n3xEMbI4UpG60AgR9xsFAOmOQSr/nO6vUzz6uXsB10YA0Pp2v+4jUNG9S0HBCmj+4rbXINJc51j7ExGlHYJpxuNA8LiwgxrbsIo8zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767698991; c=relaxed/simple;
	bh=iyIUp4cOO+0FXr4kRDL1lax0gcR4bes41ZqMil37pDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9LyetGPzd2wCnRiHWSx30wmG3gY+VbTuwWHNZXDaZWf8yoMR2dhUbDv5VjiUXCw+miNM6rFSVOVeayXvkLoeB+XhcAQwqyT+MPZcsalI75fDQ3TlaIB3+HThQaCZiuowxX77mK+UgwA6YbxFUjAnrZnZDi+2sLoPA09AylNSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnEdQysR; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnEdQysR"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b26461e78so252758e0c.3
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767698987; x=1768303787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jAAAZkrOYtqlA0a6Ieu5TRkcUp6ZjRn/MJzirrPlZkU=;
        b=jnEdQysRWXYeuh0m/hbIonE9bPVEZwFLIg/7TZHP2Oy9zXoVVPbzDqX/yxEiQTtjqi
         WO9AQiGOT+Jt+VIemh4a17eAx3ecS88TPTDLwZAriE+AQKRpclu0zhJHUQifdYip193u
         fs9zLXiORryqbcUDtzrVEMFelF3G++PCQC5a6t1L2RO38CAhKvqk02X22W0zlU6kjL0h
         iHf6JCrETgmn0ppraoUNoks/TMcASfhunRE5eCWOhU+FGqlcIxTKC8PIEW9t4jYKYkts
         iUUN75zyA2LbnbMu6KXq/0b9zdvCktgTKBjZJkKIfFHv2vT31xylsy0qU9sFZLpRUQWj
         l6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767698987; x=1768303787;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAAAZkrOYtqlA0a6Ieu5TRkcUp6ZjRn/MJzirrPlZkU=;
        b=YXZffHvMb29wLHZraaYEOrzigNYW9nayOyFZchflIp66hqzqn+Aw/3wyqxOR0oaoGw
         9sAme6lxT0yJ3z2Vp+UCM2OUdjmTSaxdVT8t9TeQ/Aaa5Ir1qQsAaqwMjKPmT78gWav9
         2mXUNu1/MTJhCyeZ/ynnTC3ZqiZfoV0RoiocPt+MS0m4z1rcE7SUiJwp0VTJnd4Pgufq
         fO0LpPhlLpyYyp299aRUdvf6A3kbzI/oegjekMkAWifsSs+pl08tdnC5F7Yt+0W7OWDG
         G6ZJulceWA886V92PgzGfHfhdRvZ9CSP6rojjh0HsMY++uHODAzh90wTXpleE38LA1US
         0TWw==
X-Forwarded-Encrypted: i=1; AJvYcCWr8VBu7+xFMZ2niTHrhCJJZ9OpN7tFjKTxAgvGzpD8Loi1zhc7e3pEQ5pHukx3NCo7ge0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEbsd/Oynp/Bmqor+/je3n0AEKQ6kpd9w8Rd1GCvSZmAN1TRZ
	ChX1pyQcFYEC0YjwwS3nPtgGmdDHkv3lcxyht1XtrEq70eZKdOAN/l+EYz7bzj7kFfprbOotm5P
	qlxAr/C0E3WkRVQh9K1T01Oh4cnaKTHk=
X-Gm-Gg: AY/fxX5oJqpk7fzA8x2VqBghsor8S10CKwEwakti1tBS4FAWVg+FEObpfSX0eNGGRcC
	vwhccN0b9mIRUOfTPyVspOH4WmGA881kCbAtjEojfgc+Ey/t1F6XxSO8xTzfU65flcxs9nEjK8t
	OW+qrFaOjXHb4NGISbzjP1w4G6TNwwmFqA1F6iWMoqtieulPkPiUDmF5DD6rBvZGNT0PNcWVIjY
	lnj1daN8nBHZbqZZbhPLjwZiga/yk0R/Rmc72T7ZNiOs/RUtdGNcrvHpbV4GyQVjyVVU0SDEKKR
	hlR/N7cOA+buONp6UvGxsCNanjs3gA==
X-Google-Smtp-Source: AGHT+IEKp2IuyG7UiMqSUyxFJSBvSpj2Y7+UflHp2/287jTn9WpwHy0b5UTy2a2TO2urMmnZr4MielE6uaEzoerT8lk=
X-Received: by 2002:a05:6122:3c84:b0:55f:f2f3:699b with SMTP id
 71dfb90a1353d-563394fe155mr772883e0c.11.1767698987431; Tue, 06 Jan 2026
 03:29:47 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:29:46 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 03:29:46 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im> <20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 03:29:46 -0800
X-Gm-Features: AQt7F2qksArv5F_uV7UiPa_Eg2AeGCcbyfRGWszwB63ow6WhFm5r6Kz1nyvAjxQ
Message-ID: <CAOLa=ZTdLgsUcii0hunbh3t-zz4QU5weWXmqQ6KcjT8fWK_b5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Some random object database related fixes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000003757310647b67e97"

--0000000000003757310647b67e97
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series fixes some small issues I've discovered while working
> on some other patch series. I've decided to split it out of these
> because I'm hitting the same issues in multiple series, and I don't want
> those to become dependent on one another.
>
> The patch series is built on top of f0ef5b6d9b with
> ps/object-source-management at ac65c70663 (odb: handle recreation of
> quarantine directories, 2025-11-19) merged into it.
>
> Changes in v2:
>   - Drop the first commit that regards geometric repacking with promisor
>     remotes. As it turns out my assertion was wrong: geometric repacks
>     do and have to consider promisors, but they will fail to handle
>     them. This is a bigger topic to fix though, so I'll rather want to
>     move this into a separate patch series.
>   - Tighten tests a bit for the commit-graph generation.
>   - Stop referring to a "subsequent" commit that doesn't exist.
>   - Link to v1: https://lore.kernel.org/r/20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im
>
> Thanks!
>
> Patrick
>

I think we are missing a test case in 1/2 but the series looks close to
done. Thanks

- Karthik

--0000000000003757310647b67e97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 683139b4244295a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sYzhpa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTQ1Qy85Ukt3d0MyUm1ZSVA1Tk83c2gvK2NJQ2p6SApZZVV3VCsydTRy
ekJYd3BwVENWc3BGdEhyUjZ6NTZLYUVzazAxVFQ0bWZPaVdma0NFVEJ1K1IzY1o1QUEzeGp2CkxY
QjJoaU9JTm9ISVFJK1dZZlgrQk81QUp6Yjc0cW5TcGQ1dVJXa2M1REp3d2lwakROU2t3M3NzNWRM
SE43SnYKbklEZ3RBNkNvMVZSbG8wRDF3c0ZGQ0hPalBjejFiemQyTUdBRGJyWmZSWVVkay80Wkp0
SHRZc1lvVDFvaEhPbQpzcGF4UHVWTGJDaVBxNU5aUldwS0xqTkF3OHFGTUMrM2xmYytVQmU1cWFt
aThnMG1lUnNtcW82TFFnTSsxKzBYCm1rUkxFQWhidlY0MjJTUmdFWHJoYTluOVZaamM2cTUxMjlU
eHdJVEl4ZzMxbitMT2lzek9ueU0yT0xKRXV0eC8KM1V5L1JLaHNQMTI5NEZtekdmdFhjRVVncVdQ
NjFCZE9ZSDIxOE9wWG5SL0hlRFhRaTg5VDYyblJKK3kzZjJTWQp0U3JVUjdpMmNSNUd5dlV6WC84
V2sxN1huVTFvb1lTYmQ0Uy9KekdId1grY0VSUFNWQWhwWTZQcTFUekVtYndnCk53aE9MVi9TT3hO
Y2t4QzJMUm9ETi9TcDFtK0ZabmRiUHh6SDNMcz0KPWNaQWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003757310647b67e97--
