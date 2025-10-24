Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BB31A7F7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312324; cv=none; b=XHHsDLmUufZ2noOaq640GvBynHY5EANG9aB3ru08lJ+sggDDiBEQ+QX1+LMapm3jG9H+ydLltSnnJII3QoM5ou2mhbjqZbCXIXFq8rh2+RUE5xppFUJoNPc+mB5B4P0eoNSpk4x+Jy/3ManeOu7In02p4bokSOcB5aSSB/c69WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312324; c=relaxed/simple;
	bh=np8X3cuDYywVrQibCx+Nc4xl7ab5bVIw5TIOc7N4K2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnU9JlWLhRtCpGSfmzb9A+gPr4QwtR4HD+jfzTF/8rrxIGbjjob+w5qDIVvtBglFyuWqe+ivH6lL5zF8v8va2to4kCy2YBZNbQO4BFjRIhYZrpV6dyt+qrt7hEDvqs43mktn9wmwazilOYYO4snLD0HxInj5/N1MCgTwuVfxp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbDVZdNv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbDVZdNv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c4f1e7243so3309280a12.3
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761312321; x=1761917121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tKKjJvbgV6Jp42yunewCfz2llnaZXYQd04YdtVXBgQ=;
        b=FbDVZdNvjFoMkIoOseGjVvy3K+24GRUyhGKyluazl9+4NYvVumaKLxI7c1CO2mAWZz
         vLmshkmNw1CW548fOkTx+f5VkFC746q2+vYAQYluhWrIEqopJE48keU4xMtBqPOFQ5cR
         9clHBQUx7F98+xfznqh7fpx/asMKJsNwNCNCQPAwMUckrUfYL/apWKJpDTNPbqjRoEpR
         lLIMGybh9+xlJIeAv5qRU3Brn6gBtILEEi4mZqX99sFW4OA7kYJ6AMcM9Q4tVo8FCZXA
         pZaYJewb39vTJNlekaAK/AtqOPc1xT+PP+MHz+lzWNIoJjsLDWQuIDudVZohk1HOUqOh
         qMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312321; x=1761917121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tKKjJvbgV6Jp42yunewCfz2llnaZXYQd04YdtVXBgQ=;
        b=H1z9+wEmKpKx6BDqCSMthRD/EhRB8aDVk83sHXkq71WTxH5GaE/lzb5Zjovs0htrBw
         1nADTWREt1Q8YdSgPuqQbh9v6xr0aQSgTedvk7RlfNc79k4nYmQpn4fBbqNGdmPpCCdo
         looWckfGB/THPr2j1WrHn690+UWbJLxOtIQIPBFjJwUalmW3OcToP1AUXnZ67huQAick
         NYEyx8Ytza8Xstg/wjvbwpJB/mEFGvX8Q4Z1StBaDRxCH7iLbfW9CnNw1QOh9lLe1/F9
         CBU8jFKiMMOs+1R52ulbf+aEkpkApJ/fUN948UchT/X5hyE2DBHf/AbZMwVXU8PtZIjM
         w29Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV5P5VsMjpD0ZlL1ksO5/3bsGw1bATFVcajcOCvxbwmKwHsff54d9vFS/hI/kCdcfVr4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzufM8trqckK3M+0tRHtGaxdyjCLhs7yPeV1xzJpegacJTcc3CH
	nO6eIEMqnPoAfcdRJKzJFqG/oljICjku1o7h5pucpNbvScdP9oK0M1svRpupTHrZzhEapwy2bUk
	kkyipi0lYKcquYA5Y06LOxlXQcZydJFA=
X-Gm-Gg: ASbGnctgTxa2dTzufRmBz+JRDcsCK92yQyB/Ppx+GX+df4GqmLtp0rGGFJAxmvXCNKk
	sP5ImOGMxt6qciSZve+y48Z1YUAHQ70dtwHb30w2R/zIhdHNa+BUIFHBakWuyu+221MSvuoHjJt
	7cIKW8V4CGHBBuIia6LQEl8E5CvVFB3EemwubvLeGMmU7H5d3VgwYqZv957/YMpSL3gIDEvo/lB
	/lCUJKLjg+OBZ8gQeFEQYkgbvs2uQv5APHhGLTQD2cfLZSef8qu38hxwciHyEccpQ/8HBk=
X-Google-Smtp-Source: AGHT+IFGIeclcPXPblZTMhpDj0jtkTp2kEGWA8vFc1y3Kh/HiZHZ1NPNxklasr0WVkCOq+1MjM1zvpVRgNE9D0MIM6U=
X-Received: by 2002:a05:6402:3592:b0:63a:5d3:69ef with SMTP id
 4fb4d7f45d1cf-63c1f62ab45mr25933891a12.4.1761312320641; Fri, 24 Oct 2025
 06:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761135129.git.belkid98@gmail.com> <cover.1761217100.git.belkid98@gmail.com>
 <xmqqecqtwpl5.fsf@gitster.g>
In-Reply-To: <xmqqecqtwpl5.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 24 Oct 2025 15:25:08 +0200
X-Gm-Features: AWmQ_bnK-Ma8jQeZOH-VNaZDvXbs9JTFqnYHirQb6dJV-Nn0g-tPhIofNMZCp4c
Message-ID: <CAP8UFD1fousSKKduFAaZrsV9REnOaRDOQYcqB+rTQ0Ys60OWGA@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 0/2] do not use misdesigned strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > Changes in v6
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - Modify commit messages to have proper structure
> > - Changed logic in get_default_ssh_signing_key() to use xmemdupz() if
> >   key has '\n' and xstrdup() if not.
>
> This round looks good to me.  Christian, should we declare victory
> and mark it for 'next' now?

Yeah, v6 looks good to me too. Acked.

Thanks.
