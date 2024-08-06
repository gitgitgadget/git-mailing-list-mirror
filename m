Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71E01C3F33
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950319; cv=none; b=ATRQel7GqklwiBss4C+OPyncrnlLlLltrDHeaFtlh6Hk+kSaA0ZjDwa6NKHQcS3LP3reUP76O+1dCYR2PEPVsKj8OuLZVbNTcAn5TrupRWt4pN8yCO23+wwGD94Ur73AUkUhdzG/pWtZzdXeyENHCqujRXIH7ZuMnvix1mEpMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950319; c=relaxed/simple;
	bh=qNEzOQ0TVDn0UxyI7+SVs1LiKy10IyG2RS0/YNhJ08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AF1jbpxVFkeTSmSnP3Fz/E4UTJUIRCWIWG0X1OfbFc2CNthvVP1YAOaah04POxuS27SF8rpJJV7u+AG13w1/k38A5DDfwFkUVWaQBE/eFgdTUCL4e58NFvExH9b4IsvcepQL2ymdtqqnEq9oTtC2u+FmI2pCUGcNoNWl/4al13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwHkAS6N; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwHkAS6N"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1f9bc80e3so294213a12.2
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950316; x=1723555116; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWps+Jd8agf/NU1zP9Rr9WMvIFk10wmMIpstTuoeYkE=;
        b=lwHkAS6NG1lZTYTpW/vl4CU9rR4QX3ohrP+RVzuCXxKCq2dO//ewwgB7m3LGg8LHkD
         iAcDvwUAO/iYKqhL5MGF5ePF8O4ozPshiatuTNMpus40glXLdf7K6u8KRDlRow+TKICL
         Bm/y5rvEGE68cVVEKUrc6JcwFdRg1zUpvEfRpkuLN5gdCHX+r6om0fAyoZh8g0pkxLgn
         lSqUEz1CrxLYIEwpn3kpHhdJk1rU16H+ZrNRWtEtKkL/26cLnGwh+w88rFgLy5g/pZaB
         sk2loACKE4IcGnrhiTUXgx71g837OI75NWhURNMP8ua0iGnvz6WkaFS0L/58VVmDIg4w
         OCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950316; x=1723555116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWps+Jd8agf/NU1zP9Rr9WMvIFk10wmMIpstTuoeYkE=;
        b=xUee90uC8ahfkJqNwAjp4cVmq3j27MAuBspcclBU1FcYyUf2A1+61NccJKOXAfd3GV
         /xA9cBt6Zccd/WxznY8ANUcSSf3Kx/hPAIqVOsCQZ9xSrl/87WsekmPG+Ku8TMxmU74p
         bibaFbr5gBnAq8V4bzRxLZN8Uub6vyxSazrretL6iuzEXXnQKa3f7zUHSRwQL+EY+wAx
         U5gRs8nfq4yflCEkQX0brozaQsQSNnSgD3lbIuJXzVwDUk0/oJ77Y+iDJeOFT7YyRYbv
         H2S2PlbwDBiEAS2dwpEF0eXTgoaMNQzfbx7U7JCiZ4JWXcPb7x8q4iXTrOhpm6BZNA/N
         jLKg==
X-Gm-Message-State: AOJu0YwLKXbkEFw9kf7OBANrOHVA9Y/iivx/aLvkRZG1gfw/QVQ1jyPj
	DvnI9Y/y3OMwImjM1lejwz0hjtmc/KNbkhbS3wEwMnY3rsY9MOWc6uFhFcGHvkmEGnumHavlbn+
	QoWqJPLEIS03YGSuIJPKItPKmEIGzCpGRvGM=
X-Google-Smtp-Source: AGHT+IEQVS73l4tT9sBtNBYPBZhKX2m9f2KcwMPJQpHRr5cf0oTRqhVXizLpSnhWndGfmM54lphvDewtRVDwghGCqaw=
X-Received: by 2002:a50:fb8c:0:b0:5a3:8077:3c90 with SMTP id
 4fb4d7f45d1cf-5b7f56fb7c0mr13216402a12.33.1722950315451; Tue, 06 Aug 2024
 06:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
In-Reply-To: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Tue, 6 Aug 2024 15:18:25 +0200
Message-ID: <CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
Subject: Re: 2.46 submodule breakage
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I did a bunch of testing to narrow down the cause:

It is not related to the Windows port - all the testing was done in WSL.
It only happens when the clone containing submodules is done with
--ref-format=3Dreftable.
The commit breaking it is: 129cb1b99d hash: drop (mostly) unused
`is_empty_{blob,tree}_sha1()` functions

Regards,
-Jeppe

On Mon, Aug 5, 2024 at 1:31=E2=80=AFPM Jeppe =C3=98land <joland@gmail.com> =
wrote:
>
> Hi there,
>
> I just upgraded from Git 2.45.2 to Git 2.46 (Git for Windows, but I
> don't think this has anything to do with that), and it seems to have
> broken some submodule stuff for me.
>
> Specifically, when I do a recursive pull, I get the following error
> from one of the submodules:
>     fatal: Unable to find current revision in submodule path 'path/to/sub=
'
>
> There are other submodules in the repo that work fine.
> The only difference with this one is that it was added using the
> --name option, so internally it's just known as "sub".
>
> Looks like the problem happens in the final pull stage when it executes:
>     git submodule--helper update --recursive --rebase --
>
> A recursive clone with 2.46 works fine, but any subsequent recursive
> pull gives the error.
> So far I haven't been able to fix it, except by downgrading to 2.45.2.
>
> Any ideas?
>
> Regards,
> -Jeppe
