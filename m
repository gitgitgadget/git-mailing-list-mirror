Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47318BC0B
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101614; cv=none; b=ouzbSV+3ClL5BJzhWQeafKAKyDq0t788BBhOO1niyGeGP1wjsKLTXchDcfLXkGzv/WnLp54tg0EuZzs1eJQ5mon/EoZiQ2krXHjA7qV7+hzBisrGdvhhj5lNYntN0XqBCbME8Yps5GcZeqEnQYMSvdIPQ5Na6GpV3svxiBbtzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101614; c=relaxed/simple;
	bh=D2/+r8+OhOp8Jym7ursJXODhxgglmMVEwxJIl33Ao90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITJS6PT3Tqi+efZcF/LSGoyyIzZQQNpOUylgx2vTUDF6z4+IYyXiuIgoiDL/mnU5Ufbm2Q9OcNq0VvFZ38ijkjEF0l/7/C315ALfpubuenjPfCHWjWXc2gAxcOMaAv4HorD5Do77tnc2NTqVo68l6MlhY9j+13Ad99eHcDohypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re2T5rUl; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re2T5rUl"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so44297241.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729101612; x=1729706412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2/+r8+OhOp8Jym7ursJXODhxgglmMVEwxJIl33Ao90=;
        b=Re2T5rUljhUB89KjzQg6GJhvxz5y9Har6H8I9GQmhwT/8eH5J0EzoDfho74f+drRTJ
         i3eV+DaqEOLYsU75VgYL6fXA7n8ZHG44+LfsBUyv8K9amOQ3VuvSgYWgtwlquS1c18tV
         NDbmmgPmpIzAVt3E4pWjsqGKP6WaAO5SdZBPB4K0Tkg9nz3NKnWIgYMSXit6yXBiA9dc
         dRTYHoAmQVK85UTs2esRc8Pyif3XacF4iZyDy4azVCdc/GwpnSO3WlS/Hny12ZuB+wCv
         ZzWUTSQjsgBzqdb30+sgTBrXja7kJD6JxRonD6lE5aRcV1B7pxfPaapSrUfdzP2O3v8/
         UQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101612; x=1729706412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2/+r8+OhOp8Jym7ursJXODhxgglmMVEwxJIl33Ao90=;
        b=a99so9zfiFTiwe3vVzNZNxY56RdkER6/m1TOB/zbZyNDgwP0Pl5XO68E1Xx5i1PaiD
         F0spmuqnN9xqGQlQEPFVUeNz7ttb3droK6nXk0NwzVOaHz2tBeEx3rK1gZLSeWAC8vrs
         tV0uhtYGJmLS/MaVHxLmU7ekn5w3uCa8gIIvL44/+vSERCI+g1LPd34en+a4AX3mO7tm
         hDX4wS7GLVg5i54ZtyUDE0jUv2nIHrgrPd/XDDMPIfDnYXfJLamy7lrH3U9NmM4GOlkB
         nm1irFB4IruxYHk4ouXPBxNaQJj5Oah+ya+bLcGpLwyuVGqzArPcrEVmrNlS61Kx6NxR
         lhSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe3/Zb2vSY3Pz+6q+rcQSMAMz5n3VfYPmBgQWLBE7KZF24gR/GVaj/X5s2TEWn9I8LD+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv0hh+5f/ZCaj+v893MiKrMFO6AsGDLkINf/lXJTyUry+wydE/
	5KXlhC98lkomndcrLgtkiBzLesscOF80adpqovnoKYeeSUF2C5vIg1IoxtHSNLCTlyxSA+Jd4Ac
	fPI/6fjwWbzeJFPziw7s04GN4DIhn/qLBGhM=
X-Google-Smtp-Source: AGHT+IGhrBzOqGnY79sBT9hxfYHI9QjOc6fqu5cPl6bi68IcNBUYVXHjBLoRqqsi0gKVsnmCsyfCcyXO25TBiEPip74=
X-Received: by 2002:a05:6102:a53:b0:493:eebc:d77d with SMTP id
 ada2fe7eead31-4a5b599c928mr4820849137.15.1729101611454; Wed, 16 Oct 2024
 11:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com>
 <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com> <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
 <9952b3a7-0ebc-4555-b8b3-f50f6f383704@gmail.com> <87090897-7ff9-4396-b81c-0fc423593602@gmail.com>
In-Reply-To: <87090897-7ff9-4396-b81c-0fc423593602@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 16 Oct 2024 18:00:00 +0000
Message-ID: <CAPSxiM9KnkNjhtcQvZn0sekZimyzqtzX4Q3xpH_GGhy8goCWdw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:20=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 15/10/2024 19:28, phillip.wood123@gmail.com wrote:
> > On 15/10/2024 16:17, Usman Akinyemi wrote:
> >>
> >> I grepped the error message and I noticed that the message is gotten
> >> from parse-options.c and it ensures that the arg is negative. How to
> >> proceed in such a case ?
> >
> > The code you're changing parses the conflict-marker-size attribute so
> > you need to set up a .gitattributes file with an invalid marker size an=
d
> > then run "git merge" or "git cherry-pick"
Thanks.
>
> t/t6406-merge-attr.sh would be a good place to add this test
Thank you Philip.
>
> Best Wishes
>
> Phillip
>
