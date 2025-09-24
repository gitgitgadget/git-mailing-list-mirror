Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CB620E6
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734924; cv=none; b=Kazmh50InzbAPHJaMP8DbYesZVMeljCHGjMduh4ZTVRTKmR0MlnvsnqTv6DQtistVrxDrxdGbRWIp9UcIt/w7yUsQ+H4s/QHME4D/jNn/6p/vki/ZscBQNur0m2Wv4XkJMgrjbXGz725u9u9rgUQX4bfs5QZXUapnn5WNia46VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734924; c=relaxed/simple;
	bh=2UErnSGRiqnL4ouFeFzra7vUJJ5J4xupIY5UXy+QWa4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=riuoiIKttxqo0V8jZU6rPGaxAaNuRtRqli6cuaeQrKWbOBGdptYeJfycT4Bofbqj5DsSX+iq9/mgmbSqiKYxwpauMTmo8rRI370kfFlZoWTHBOCXCW9iml1hrfUXEwanLGRahI1QeO6y/JiB2wZbLszc6vlcelwUb+UyhM4NJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiFdTaU0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiFdTaU0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6051aeafso1136347b3.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758734922; x=1759339722; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzyX+R/qT2qGk5xGGxSAAPQoA6nuEyKLbwE5YukmbgQ=;
        b=SiFdTaU0TRPj3Sn7dmwW1DaC29bR3tbVaIZrLroCbVNU++TqxnkfpSh019wMhriqwv
         gtHtjkUe2Na3p24+2/biMStbPyAbT64Q6rBSFX3lmYOCOv0/w198OeUQnx+LPJVGbtTO
         p9C/Yfsc34UKfyiVa0TDNTItS+MSpT3h5Nvz1xirvCmy0zZA4z5q0meZVIqWG8sTVmaU
         5ZN1yCDQh7fTbaIOK6xZvsoCAYn/b+lzuS46IV8UVUL0j9FF4T1BfhhqKpjF8/r7Dx3h
         dn2ANLmTVLolzNi5hMmVHySDwaqgZ8QTudmjspeayGpZE3ZQbqf82cu7ryvJmUQEWegF
         KOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758734922; x=1759339722;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzyX+R/qT2qGk5xGGxSAAPQoA6nuEyKLbwE5YukmbgQ=;
        b=CKWwDXrSy3aDzo224TuKe++W4nupirhSCwTbS0eD51zdO6irhMJrV4Y39IHYURyVoS
         +CPo+VYqXdNGYBojilCkgmXn7U1HKYddEOmS+27udSQuTo69ehZnmJiBQWWONIjH2Z+l
         DCJbUpeY47GIA7/ar68BaNfSTebQZjoGCjKLQwhc1J1cPDne7fvyey1XiCWjb6PUnRby
         j+joW6dP+Ru2boW9ThFjR6EUS5dptX4rlTMYLavzNMgWWlfoXD3e2tPkN7k2JJspJdjN
         NiSBksYTQyy9IyR4NaWybM5iddZkisHZ4lJmBliygKnZnSw1kIW19plRdjxPwvloAqII
         YzOA==
X-Forwarded-Encrypted: i=1; AJvYcCX2wP/kdoJDlPUAQbmSt8X1ZMiG/3Mk2DfjmIBcOw1gUJsg5xmnIAJhjcUvIzG6AKYhXAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VrczWJh3z21rwtRo0j6eLd5yarUxiYH3zTSlvM1RNTk71JFu
	SK0G8TEI+NuQiulJNple0JI83akRldnDcz3B5MepMFW0R+XgFOrmVeQVBst2QTnf
X-Gm-Gg: ASbGncsipIcR6+73SW0wMPhgFaMUwylENL+I+9IbHPStjdYS1iJyKhpPwfZIGWdxR8/
	T2iEYSCraWW8XFOxueK3HGDip/U/GgYBNmGczELfqJEc+lSYYO4tPu2yJ9o9Qp44bRYmhH8eZ5U
	tsEjHzjzAMiCyaKzeS+KsSbvLkVqew6kjnCTY3GP7/u5e0xBQY/HreA7oBODJ6OpgdNX3DKWy0O
	hjLQGrrF6XnnvQzbA+6XHxHNmXqG7b3I1JC2GcbBCsElGgHRJ0p5FyP89DzIf83wkWwFEHrkbum
	JZ+kg66wKGUfnwrx+JR7OO4wfRu7yFPNgYpsxIQIOOqKWIrNYgywJMF2FCqqKdQUF7AHe40udDo
	+adJYXaB1cXJjjEAQ8CgFASn6nJXDvYANPI6ejg/yNd2T/qumaX4=
X-Google-Smtp-Source: AGHT+IGdsuE1r7JBib6BG9uF2cRYxh9R9rnGFKaGQ7nNHpf+nf+2C7faEM3GNp5FtFBEuKsL2/0h/w==
X-Received: by 2002:a05:690c:62c4:b0:730:b9f4:bb15 with SMTP id 00721157ae682-763f87777cemr5877077b3.7.1758734922219;
        Wed, 24 Sep 2025 10:28:42 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:5194:54a6:d414:9d55])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397186ac2dsm50655647b3.42.2025.09.24.10.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 10:28:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: 0-Based indexes for git log
Date: Wed, 24 Sep 2025 13:28:31 -0400
Message-Id: <95F22D6A-38D9-4F4D-B71E-59320B86B4E8@gmail.com>
References: <xmqqh5wrn66m.fsf@gitster.g>
Cc: Nico Williams <nico@cryptonector.com>,
 =?utf-8?B?8J2VjfCdlZbwnZWd8J2VoPCdlZTwnZWa8J2Vl/CdlarwnZWW?=
 =?utf-8?B?8J2Vow==?= <velocifyer@velocifyer.com>,
 git@vger.kernel.org
In-Reply-To: <xmqqh5wrn66m.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 24 sept. 2025 =C3=A0 12:53, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFNico Williams <nico@cryptonector.com> writes:
>=20
>>> On Tue, Sep 23, 2025 at 05:15:46PM -0400, =F0=9D=95=8D=F0=9D=95=96=F0=9D=
=95=9D=F0=9D=95=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=
=F0=9D=95=A3 wrote:
>>> In git log it uses a 1-based index for the date instead of a 0 based ind=
ex.
>>> So it says "Fri Sep 19 14:23:24 2025 -0400" when it should say "Fri Sep 1=
8
>>> 14:23:24 2025 -0400" (or "Friday 2025-8-18 14:23:24 (-4:00.00)"  to get a=

>>> better format)
>>=20
>> Day of month numbers are 1-based.
>=20
> Correct.
>=20
> There are a few things in Git that are 0 based, but not so many.
>=20
> * parent numbers are 1-based.  HEAD~1 is the "previous commit", aka
>   "first parent".  HEAD~0 is the HEAD itself.
>=20
> * merge parent numbers are 2-based (sanity of this statement is
>   already questionable).  If HEAD is a merge, HEAD~2 is the
>   "(first) side branch that was merged", HEAD~3 is the "(second)
>   side brnach that was merged (in an octopus merge), and so on.

HEAD^2, 3, etc., rather? :)=
