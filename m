Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D99249E5
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754184472; cv=none; b=VqKT4ziJN96i0MLwQl4r3AwKMoeaNMPYlBU3g+joqUYq2ln6vCyNkfY0fQggy3R7mJf3Wr1iVSxdUYlz39r3e0dp6nFQzeSt/aI+BZhqVPIE67chwBfXdXVLuHxnDXGfac6Z4hVLdcY+ih8dd2clttfhfDs+Tf/ORjYyUDTLl68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754184472; c=relaxed/simple;
	bh=Sis5PnNAfBMlAVeFw8+wnWUKq/SryQ+D5a6Zv1k1rKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEw8zovlH+qLHXJiQP0vcnJxaUbnuax5CywOcn5xGVwASD8vxMxKTUE51BzVJyFfz0VT6PORVXgvf7taSry1ehYC7c7WenCjKGwuowiAYroyMcNM8ml2R5SBG8wWyTQmPjPjv26B2mFuOVNAY4Lj5s5aTIrp3sboRQ0LJNx1wX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvHkSCYZ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvHkSCYZ"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4fbf1326dfeso2491607137.3
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 18:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754184470; x=1754789270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sis5PnNAfBMlAVeFw8+wnWUKq/SryQ+D5a6Zv1k1rKc=;
        b=XvHkSCYZyuI77e7aI72q1XJOEX6qahmY4YqpTDCkYYhN9aUNlhH7C/YZ4dxlaWNXj+
         ZQfXGKP3to51iTuxMn2JEnJ9Zn9KPqdbcEELaLRDJAjJVMzklzvryBnm6EHc9gM4BVQt
         RyKGViOaVGQ5goZ4O08VK1+uflKGLpbzXI3KMN9RHoUv7AOY9MDQQ0uMZpfUaGfFMgHl
         Qx+dvyWt7rd3C9aS4RzaNFat5d0wV0oljR2hHlseyRu6dnMqNJPqGrX2MVz0+bgUR5wd
         G60/qXwddcfg0I6bviOxcr0t5CtKbupivsLh7EAahKqhjdnlM5RQZfXWiSUIdDqgKfrI
         cPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754184470; x=1754789270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sis5PnNAfBMlAVeFw8+wnWUKq/SryQ+D5a6Zv1k1rKc=;
        b=sNFIzoEUBQyu8l6CFpPghZnkE15Oc2v+zMHttwOZq9vsMgLYge+hWiB3STvPvRHoqM
         Ti3AtqYCVr2BLzaWT4lNjHecA7xjax8mC3NjoP0PwkIqdYDZmR84IuSnCruRIfWQF5qp
         LDkH4ZS8iiUQAwk5DDQzgsIVBeitcGWYAu0t8Q7TA3QnC0nhaQHKcjjvsmOqGng/Y/bE
         mARZ/xjYQSZewloPwBosOZuL7aMd82LOTmcXG6WgSor16Y5w3ZMkVP5BvBqFF7iBKJ5I
         jbcuQjZCfOMFc/Bllh6n8eUawCgGI9gKEwfse8QlrNnRpDl0VmOYIOWgb9XFmgh8byQI
         n+dg==
X-Gm-Message-State: AOJu0YzX/J+BphsnXzarTDhCxVwpn9jSoFIFOuQbeBAirZBhLvUB/8p+
	pCR6j5GhFM3VBL6pMDJWUG0Sy7UmokedxehoJVtqSmaP117Blg32R4X3n098SXqmg5+gYb1aUf2
	kzkNYOaPw77FjzGkXmcmYkrD9aaQC3Og=
X-Gm-Gg: ASbGncu2A6TS6TTCMz7HvCE5YJVcjRlBUksdCt422kPo6d+l77QEnYCCMkUzARIGmdp
	7AUzaWv4ixC8Srj0M1VNciumYu46Hi0w5uCmze600QKF3uEsbI9V6/Sw/8c7Luw5cm2j+D/kVq9
	t7OSl6jkhvrfFITQUvSCMDFTM6yRrXbrloL8GP9QP6lLHDSehNs9D/92KMnnPWWEuald1j0LZvs
	E45c9k=
X-Google-Smtp-Source: AGHT+IGJucIg2+cNlGaAx38ai1KqWuRSdCuWJwiqFY5129nVVlTXEPxMqePVLMQK2DcU4ptmTUY9YTONQGOAhISDj5c=
X-Received: by 2002:a05:6102:5090:b0:4e5:fe5e:2be4 with SMTP id
 ada2fe7eead31-4fdc40131b8mr1646874137.22.1754184469867; Sat, 02 Aug 2025
 18:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
 <CALnO6CAPBsxg=-aXVUUJSKrPLWWPLGdEM=k5J=GVoh5fVTAhYQ@mail.gmail.com>
In-Reply-To: <CALnO6CAPBsxg=-aXVUUJSKrPLWWPLGdEM=k5J=GVoh5fVTAhYQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 3 Aug 2025 06:57:38 +0530
X-Gm-Features: Ac12FXzjss-dXvJAsCXmDyyCvanR1JNurvBGNuei4JDnItUYZg_GDVf0NuQHr54
Message-ID: <CAPSxiM978fqvC_TO8fKQrx=S4yPEkp3ZufTq+zv+Ws7zJx6yDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Hm=E2=80=94if we strip the suffix with ${cmd%.*}, do we need a p4.py pa=
ttern
> > too? Actually, at first I wondered why we need to strip the suffix at
> > all. My local Git produces only unsuffixed commands. But
> > bin-wrappers/git produces both p4 and p4.py; request-pull and
> > request-pull.sh; and several others. So I think stripping is probably
> > right, just drop the .py pattern.
>
> I think that using "instaweb.sh" instead of "instaweb" also causes
> this to fail on Windows, like:
>
> https://github.com/benknoble/git/actions/runs/16695826272/job/47259908953
I think this is expected breakage. Removing ".sh" makes the #TODO to pass.
>
> --
> D. Ben Knoble
