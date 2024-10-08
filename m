Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197620ADC9
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728410659; cv=none; b=iIQP7VTk5cHYQLGtKJubnSgQCtz7z4GS5zZdtd2/1erf+Lb+GBVOn+BC7ulPnRhyUPDHp2D0iTLqpNlXx8U+hNlG8PRpaLd1PIbDbEvSDPh2DZo98GIclBKiS88C6oFzJdrbpFiO5p/fBDuDZHJxNHZdyjoQxQoVxNf/CQ88gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728410659; c=relaxed/simple;
	bh=HE6uXc2O29EHRm7wg7yCQpPZRYnjmCUsM2gpOjvQd0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6TXKumE5VG2wl4OLwOYVsxNw6yNUztGV73Hf0yasT77DzE6fvIWMnURNXOcs2xdijoFlPezCjdZXJ3Z2jNYSv4xQLRMId2v5gBxMU7bRlaGeEJ4eqYA1NEIiINSC399UU5bD6X9fF24LLFYh1hYuJApllKMc7pejUI4cOZ1Z9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isf6BNIh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isf6BNIh"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so8267696a12.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728410655; x=1729015455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE6uXc2O29EHRm7wg7yCQpPZRYnjmCUsM2gpOjvQd0c=;
        b=isf6BNIhXfTCu2W6yc6SO47En6gbe7jOHXjyE/KV0Hxeix5itB50OZQInJTeCU6+jo
         0OZ9XMRYoEGopDbZYwwfPAqAzFY4VVMS+Y6Fa4hI2F5Tm3/8eY6wkCleuLcg0qYLUzts
         jOcQdz01aOiukJeLdtxXsFpMXBGcX95ArreuhZwtKz+v/QN7Zk8XaNcfHMiDhiKkcHhn
         WcpTMRXEFnI6chG3wRJ8Z/+t/jszsBWihNWQPM9tyrOO2Z/sJ9RSxNsGO7++y7ibhHge
         lwBtxtFg/VNYfK4w3xBigxzgbI4n5c0CVbBcrRo8zc1rWfq/RwVgEwAQR6qK5lYJxA9E
         rnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728410655; x=1729015455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE6uXc2O29EHRm7wg7yCQpPZRYnjmCUsM2gpOjvQd0c=;
        b=Dblv0tDVRuZZc5k2FnA6PqrG+r1TpD85t4kIUd716que3D38I2Y/vLwjk92JCtOn7k
         J/rgmkdUmJjaZce+63ExIfflP/3Z8zwqqzZiFSNcaNivIe/yLo7IAC9G7q3ybJv7kyQk
         fmb2C73MGsjr/qRglNETyWdUiQRGAyF2ZOdy+ddMy8ZG0wwePY9FT54Vyt7WWhQ3UvSn
         T6D9dKdQG1HRhFrwDdxl1FdvSMIObLtk8hnmvMdrChWKZBMIAC+U0RfVwt/BZlAb9ppd
         aWpHlEcryfMh+ZxmcZ6WFYjDT2v9h5dD9q/3EnKX0Ejwr2LEGvO3q64us3sCdoZJnkOn
         nMEw==
X-Gm-Message-State: AOJu0Yz+CeyPcnHn8+2A0ZRtK2JwsBbVP26LqQyv9roPnLyOs7lc/mKl
	9HNCETX7iiAntb18KGGjW46CchqLRx6jQciK6qfHUZdcqO3sEYl/Bk/owi5Tu9JAGkcRv3QurXq
	zYdO3SCwqNCyZ3ZiJq24xiRDnNdmE8SEX4w==
X-Google-Smtp-Source: AGHT+IGCx2Y+FKbCnnLvO9yt99E3Daz59nIuxmsiXg5wihUEbk9V9mK2j0ayXrsj8IO74oGrWG+NKvkyzUfpHr+lCqU=
X-Received: by 2002:a17:907:6e8b:b0:a99:52aa:cae9 with SMTP id
 a640c23a62f3a-a9952ab0a42mr831999266b.24.1728410655223; Tue, 08 Oct 2024
 11:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACS=G2yH+k801G0z4BO6T2Gc2c6vVDieSr=2B6kT_1P-j0smZw@mail.gmail.com>
 <CAF+8dM9k=z+KR6xd_1jhsM86e=BOwOKkxdJDbX2VUYeu8yMkdA@mail.gmail.com>
In-Reply-To: <CAF+8dM9k=z+KR6xd_1jhsM86e=BOwOKkxdJDbX2VUYeu8yMkdA@mail.gmail.com>
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Tue, 8 Oct 2024 11:04:05 -0700
Message-ID: <CACS=G2w_rUUntaCU2NXYODUNfh+kDRPiftCRg04TPapTM_KPSg@mail.gmail.com>
Subject: Re: [Outreachy] Indication Of Interest To Intern At Git
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have trouble finding a microproject task, I know mentors are not
going to assign us tasks but I can not seem to find a microproject. If
there is a link to available microprojects, could someone please point
me to it? And yes, I have read:
[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/


On Thu, Oct 3, 2024 at 6:57=E2=80=AFAM Shinshu manne <shinshumanne@gmail.co=
m> wrote:
>
> Congratulations
>
>
> On Wed, 2 Oct 2024, 21:22 Naomi Ibe, <naomi.ibeh69@gmail.com> wrote:
>>
>> Hi, my name is Naomi, and I would love to intern at Git under the
>> Outreachy remote internship scheme, and work on project #2: Finish
>> adding an os-version capability to Git protocol v2.
>> I applied to intern here last year but I did not get in, but I will
>> put in extra effort this year and I really hope I get in. I will get
>> started on the micro project task today, and I am glad I got the
>> opportunity to apply to Git again.
>>
