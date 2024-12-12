Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499E1F2381
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000831; cv=none; b=D0jArs47EWUiO65P2gWI8z4vMzhTIu3OY8DzIGSZDMT5lP6Q6+TCYuyhglVfPj3wnr3dVUMHjqjXBi6Y/+46RSyx4eAGuPsBRpcSQF0MZjTsMaVov1lqe6totgnw1Eo6CLYKFMfPraFN6LcvJq50IhpMt8Ys0Jnvulq4P3r/A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000831; c=relaxed/simple;
	bh=vs46zDKs7VPZxoj9UbJ0IgTezprdzCB4f88cqNE+JOg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=VfpGWlADs/aksHfia/gVkMn2iuwRhY2waikbeBXpM4LtKn3a8AA+x13p5V3e06jYkxUm96CbzkwoW5MsO6swJHFU2uka5zEks17zuC2Lmur78cyFVaEeKYvoy7yZHggp6jVAzHCVTErajp9B9hrNm8D91b8pSR1KxkzllHUxDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtRkS4Jw; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtRkS4Jw"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-85c5316f15cso151644241.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 02:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734000829; x=1734605629; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEqSzjj3OL3+tNZh/cVf3t/bvui1SD97fah/uq1O7u4=;
        b=ZtRkS4JwVI+MoAx58LdcDjtY/P6XCAj3pnYGX2FjkCIgOuf36KnD6dm6yOhPXcWRDA
         JywXxlg1A+McdZ75LQxnBFjcIqpYaT18llFsHj9yXu9aKYhQqB2XbDTnIS3OnMYEr3Uk
         PuhTwLO9SorUEgMJp0zGlgkkHPqGykbsbMOi5z/p0tOKZgilhb4P9rw+YnLxUeyQ+dMx
         huH6+Z1imr/XOyxMHNiKjkgtfrzK7jxWaE32aIdnEiMQhRrYpbCt2RJJj133FxC83fBF
         JAtSxrlNtMlQGK/YsW6WEcDxv82o1oYK5CxJLmsttfjtkO8l9BlFQ+w0vhwCgPqM55Yx
         SJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734000829; x=1734605629;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEqSzjj3OL3+tNZh/cVf3t/bvui1SD97fah/uq1O7u4=;
        b=gER5Nzz1IPa6El6JotYGiSapgJnZpgPzAhyARprWtIVQjDzLuXseUYavc/HtJ/SwEC
         6IhmN9AngX6velHj3qDhuN6a+KFKrnNgW1fRd2SufoEhW0eCuPVF965JcWNBX1vvxnuF
         PPCXVvjbcT6mnVY+MKdv/lZUSBoNhBKnF96on3J5Bxj2Qv5RPF6g+sPImt4bhkfjtsie
         d/bGfCBxLi1MtLcoUXfI/3eUIrUuT7FdWo8rSqGfo4CoKzH7v+8a5CBh5Cu+AcslcnG+
         bhmW3PsmRRUEAoaRz8lI01Vs++Zea5BcsYILWM1JwXDRaiGlO2IrSLDuv5iQYqT46JVM
         E8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWYO0/4mbzhRnbX0l58z3769AKdViRz9ULmbsgiAfWFTUQtPJnAMkZ+P1mYog6XkiM42A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd7sR4mXWafWkW6oWBK6Bnga+Hu688swFulywzV1RFj/j2fo/
	krWrrGdvYb4KN4w3FLHpVYGFa9n5JHpbEzTVARt6Z/NDLTLGzxf/zrEqLq22/GoJZlgjlDvHrT1
	rWg0ZvfjFQLS+p/tUPB1KPB5taL0=
X-Gm-Gg: ASbGncvXr3xbmqezmnUieH+oeNJmMPIYScSrfig4J4p8h5jrZpWKhTHqt5F790fzN9c
	hUqOeQ3oGkuEVH+CFaB361Cj1+0wbvU6CIFRA
X-Google-Smtp-Source: AGHT+IG0vInp0y0O2fvcr/6tQmJWwguXcutnL56W29IqdePTEmD1YM1P2DL6QuwfDLocjiOO2wxl970LS34FeHX2vbo=
X-Received: by 2002:a05:6102:26d6:b0:4b1:8b53:2987 with SMTP id
 ada2fe7eead31-4b247771152mr2907639137.1.1734000828482; Thu, 12 Dec 2024
 02:53:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Dec 2024 02:53:47 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im> <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Dec 2024 02:53:47 -0800
Message-ID: <CAOLa=ZTgQLgWWsgOCufvkaUDD1RwP+cs8eSAK0XuLXXHiZa_4Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] t: fix out-of-tree tests for some git-p4 tests
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006c639a06291087a2"

--0000000000006c639a06291087a2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Both t9835 and t9836 exercise git-p4, but one exercises Python 2 whereas
> the other one uses Python 3. These tests do not exercise "git p4", but
> instead they use "git p4.py" so that the unbuilt version of "git-p4.py"
> is used that has "#!/usr/bin/env python" as shebang instead of the
> replaced shebang.
>
> But "git-p4.py" is not in our PATH during out-of-tree builds, and thus
> we cannot locate "git-p4.py". The tests thus break with CMake and Meson.
>
> Fix this by instead manually setting up script wrappers that invoke the
> respective Python interpreter directly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9835-git-p4-metadata-encoding-python2.sh | 48 ++++++++++++++-------------
>  t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
>  2 files changed, 50 insertions(+), 48 deletions(-)
>
> diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
> index 036bf79c6674f6f1f0d667c7270674168428ffee..02f9ec09053890a4d41b7dc95644066d6481bbb6 100755
> --- a/t/t9835-git-p4-metadata-encoding-python2.sh
> +++ b/t/t9835-git-p4-metadata-encoding-python2.sh
> @@ -14,23 +14,25 @@ python_target_version='2'
>  ## SECTION REPEATED IN t9836 ##
>  ###############################
>
> -# Please note: this test calls "git-p4.py" rather than "git-p4", because the
> -# latter references a specific path so we can't easily force it to run under
> -# the python version we need to.
> -
> -python_major_version=$(python -V 2>&1 | cut -c  8)
> -python_target_binary=$(which python$python_target_version)
> -if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
> +# These tests are specific to Python 2. Write a custom script that executes
> +# git-p4 directly with the Python 2 interpreter to ensure that we use that
> +# version even if Git was compiled with Python 3.
> +python_target_binary=$(which python2)
> +if test -n "$python_target_binary"
>  then
>  	mkdir temp_python
> -	PATH="$(pwd)/temp_python:$PATH" && export PATH
> -	ln -s $python_target_binary temp_python/python
> +	PATH="$(pwd)/temp_python:$PATH"
> +	export PATH
> +
> +	write_script temp_python/git-p4-python2 <<-EOF
> +	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
> +	EOF
>  fi
>

So if the python version (2 here), is available, we create a temp script
which will use that version. That script is then used in all the
commands below. Makes sense.

This is similarly replicated in `t9836` but with Python 3.

[snip]

--0000000000006c639a06291087a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 70b36a3958c88edf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kYXdMZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOE10REFDUjc1TkxYL1FVVHVUbEdPQ2RSdmxlY1dsaQpVTlJsb3psWGFj
aE1CbWZoYXNnTHV1RzgreFA3WXdEVmhhd1V1L0ZISXFYTjBJaDdjcldVaUZjVkNLaUZKbEdDClFG
L04reVRTNFlxL1AvQUdkOTdaNHl6T2toYmpCc2NKM09JMVpWZnVQZmtqdTRMVEVrN3UxZlhCWmN6
R0tFSkgKNU40S1ErbDBFMzNUQnNVVmYwejdZdDRJczBTbVVlRkViYXpOSjYwTTVCMEYwQk9yZHZU
ZGtjVjFvU1Fnd0NNOQpmQUEzYTUybkZaWUw1Vm9iQ1YrTG96SWdQeWJzZllRTC93SCtIbjFycC9n
SDlGNjV6VWp4MEN5MXBkTnF5RUR5ClJnZ1VBQWJNSXRqOHpmZng0TjY5WFl4KzcyRzc5L1dMekZD
b3ZzS3EzYzVJSGx0MXBTQjRnWm5ab2hKbGJzK20KNmt1ZDBJUFp5R3lrRVJndEloeEdDRHNxS0V2
RklRZ1d0dCt5b2d3QjFpV24yYUgrcmRMc0ZPcmg2Q0Z5cTlnQgpjTzFTT0Z3RlBLS2ZVcGJhVzVr
TUZsNDYxYktOTm85bUJRZ24wZ0JVVGlKSlc1Z2dTd3M4ZmtQYU1ZRFA1b2g4Ck1MMHdKY0dRTkdK
YittcHpGQ24za2ZXMnJ6RFFERjhKdVlEMkZOOD0KPVFGUnYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006c639a06291087a2--
