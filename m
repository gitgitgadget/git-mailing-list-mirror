Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC0C121
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520405; cv=none; b=spApGdoWMHn1/t3yofYDGCBycqBPmXfIaEMxeAiU1CAPifY+ME6ZNpe1kduj6Hw0AWrbvZV2RiE6o0fZm5ERDR3QUQjX/81Mi3BaJgSbBZQLP9Jgj0s3XDJgxWlZRSnoeyHIcXxByJp3Gyu1TeV+9itXIOfe3RpOCNb2A72Axks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520405; c=relaxed/simple;
	bh=zF5ZIeGVGhHYX0cfKJVNre8Xmwzg6sQ8hNMyAWnyeJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVbsUWwL1p80y0GQ3edEYcoQ6GAJponrI4oUidAkhOJQD8nLddrtvM0uGWukFZ6knhBTNRbEpNa+oVCokO5MirfvIf1tNvYrCYutexaxfiUtuZrPs9HOz+lC6AVT6Ee3yAvRMrU/i4mhDMAvWFR7Zc/1cGrBMKttnf8PBbOWXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRdOClg8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRdOClg8"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86e9db75b9so75845666b.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728520402; x=1729125202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zF5ZIeGVGhHYX0cfKJVNre8Xmwzg6sQ8hNMyAWnyeJY=;
        b=nRdOClg8XoscXMhYBqPM0KHWmHGPRNUKP6WY1dbnRgOI9epQRTndxPBumkH8zfkZ6o
         GI5Yy0npbCLpWh5VSk1N/ouEyPEwR5RqCLKIaXLrqdU1i9/61LBibXZAa4Em8pTqMyWT
         pEH3i5po0SQ/7kQrDEhsV1z8dQS+7qqZIaQOfcBqqJNK4Hp+N2Fg49CeExzoK5ZliPvt
         kaSe44mwVEMO/viCnFocul55iMlCyKNs+DA9aQtEqQUyx1GyYhPvFl4BeWou+bbYIoez
         6i59ObULOULltc866fOXdDcGmFYIk65+pEG9wS0AjeQjkzoyWb5GImLmwek7KVuz+uf4
         xFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728520402; x=1729125202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zF5ZIeGVGhHYX0cfKJVNre8Xmwzg6sQ8hNMyAWnyeJY=;
        b=OIZDOpyqSEr9pmh1yDhlcsEUUFSOJlzA6yMEtDM5X/3uwVP/U7aUrqV+94gouAOi0h
         eZNpsvSueS9IIilIhh0HfYkAWSk4UikaZVOYO8vmbCP38HELAPOied1R9NvhbM5XaIs0
         d6iVoPGCZM8AEvJTYFwJAPucO2M0osMwBdso84zGbbbJIjgmWLFE6LXLkvq3vnru5WeU
         wwzUMiUvyUMmO0F2iUP5XFJIoWvcKrTBOZ4DZ/cI+aPuu6eP6f5lzg81P74t6N9dm9If
         UdtFLgABfRfH3E3mPJ/GlxHLPSIjjN8QZq6R9w6dUofUckQ0CwSNgDi8qXGizbvZzMQ4
         RqzA==
X-Gm-Message-State: AOJu0YxQmOPuJr8WKZIPqylom06TZ/31rlfPnlJCxQvKMPrQaNBe1sjS
	+Titdrbh33GZHnlhjNvHQRfw02e6trOGmxw7XA8R4UAyCSeXnC0GBnfIIX9+BPfFOA231QogpoP
	xBkqN3f4jmpDcno51JVJG5BYfU0pabvi8XnBb
X-Google-Smtp-Source: AGHT+IHUOfo/1BtMtyTmzDcoIcCIoQz5Ign/+6gvGl5UijAHPd4o+mXmiVM695fIpLxYyx0qiNSa8NgN8Qr8rOYaqz0=
X-Received: by 2002:a17:907:9618:b0:a99:529d:81b7 with SMTP id
 a640c23a62f3a-a998d121e8amr382805266b.4.1728520401955; Wed, 09 Oct 2024
 17:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2yH+k801G0z4BO6T2Gc2c6vVDieSr=2B6kT_1P-j0smZw@mail.gmail.com>
 <CAF+8dM9k=z+KR6xd_1jhsM86e=BOwOKkxdJDbX2VUYeu8yMkdA@mail.gmail.com>
 <CACS=G2w_rUUntaCU2NXYODUNfh+kDRPiftCRg04TPapTM_KPSg@mail.gmail.com> <ZwY3ZtHPBWWHU3wP@pks.im>
In-Reply-To: <ZwY3ZtHPBWWHU3wP@pks.im>
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Wed, 9 Oct 2024 17:33:13 -0700
Message-ID: <CACS=G2yNRA0FxTMgRS8a0VYE2PtuHmgR6mo8vDVZdcEAgBqEvQ@mail.gmail.com>
Subject: Re: [Outreachy] Indication Of Interest To Intern At Git
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much. I have decided to work on "Modernize a test
script" and I would like to work on modernizing some section of any of
the 3 files below if this is accepted as a valid microproject.
1) https://github.com/git/git/blob/master/t/lib-read-tree.sh
2) https://github.com/git/git/blob/master/t/t9112-git-svn-md5less-file.sh
3) https://github.com/git/git/blob/master/t/t9113-git-svn-dcommit-new-file.=
sh

On Wed, Oct 9, 2024 at 12:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Oct 08, 2024 at 11:04:05AM -0700, Naomi Ibe wrote:
> > I have trouble finding a microproject task, I know mentors are not
> > going to assign us tasks but I can not seem to find a microproject. If
> > there is a link to available microprojects, could someone please point
> > me to it? And yes, I have read:
> > [1]: https://git.github.io/Mentoring-Program-Guide/
> > [2]: https://git.github.io/General-Microproject-Information/
>
> Hum, true. I expected that [2] would contain a list of microproject
> ideas, but in fact it does not. You can find that list at [3].
>
> Patrick
>
> [3]: https://git.github.io/SoC-2024-Microprojects/
