Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1228208B8
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433932; cv=none; b=KsPzqQvuzt+Z28VILu2l5kMhj1TDVtAUJwPvxuZ/f+tEycw25O36Ue5UYUmS9+nPvaruIahIdL1ZJl4gSTTWqKkk61jQfnhNRZANp4QTwxLSFxBDIH85D8xIQ/fXyLU6RoGeIIVLoFNu8KxCUjT855e8ZwNNPJzU2elbshhOZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433932; c=relaxed/simple;
	bh=4Ty+0UBJvEKADa1usupwTbDUDx9JJlyI3eRYETLUl1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5sb4txNiLbsoBzV0QbKjcogzNWCk+Pv4yP9rGgSQjvDwoYkVengpqfB8w/XpIqTfkJFNIP92EkET02iTQeYjnYYuc7o2ZgBeG60cy3F0xgMYmz7MltRdPPZf8CAyWrmD733kKzi6YsAM4zoBxBJvwogfWlgMiii/JwGP8fDHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzgrRXdw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzgrRXdw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so4937109a12.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720433929; x=1721038729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8Gm/MjmUZnP/VVNK22ABxsipnZAhZ6v75gsXiHfMC0=;
        b=mzgrRXdwGvzWXSizhXy2pAYvWvD6WO48nj7TU4cbeE4l/5ksvAZE7XMB5or5xYr2YE
         WoqQUPimk6rtBOfBYLBg4VcnDFRkfHpBhyD3KgLyshoU6u0ZQ30hBTCefGV6qVrn1q01
         ATjWTMeDaqGpKDGaDg2eXAbD2NQS1nYXHFkgxhT7cbnlf7HXjuhIBapFd3/Luy/YDPEm
         u0n/7lo+FY8TUtXaZne9zll8MXmIus/nk2BZey4lvaQis5Ofov3TyPHXTzETxZqvCG2u
         l/cdtFvz1nBXMlqw9R0uZT+XC9ELsryQS8CEKjUf0F1f8+xVpKwr9A/Zz5+AKssCMWyR
         uuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433929; x=1721038729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8Gm/MjmUZnP/VVNK22ABxsipnZAhZ6v75gsXiHfMC0=;
        b=DpuFPpApfIqI9ZuVfWhjQ4E6gjwDgD+H+O+m7JaLjqfoLRjZ0omkLsG5kbo3vNrxS7
         FBc09r/q2/mv+4/0bg+UubDfq1jeCSB9GEqODBSDBFxMAadif/PceukDVDzsAwYwoP7i
         tEFykMFbxioZnh0jOxZB9Ll+Y6IHMR6aAKLoqkr5IBIOC8n3OuR26odgaAGvAJjUwep/
         wYUbxb9Q9KY8mD5FXrn5hf4Eo9mc9fdzymmSFiMJbhwc/5mrjPvRKnjMX/JGL8EtLYVE
         5dPsYXGHAQ7ikyL6OM70JaoEmMxYNcg6t1jr3b2jsSEeXVN7UNeNwvkNKxthH4M/794T
         kpRA==
X-Gm-Message-State: AOJu0YxDB3mUHAdyXS+YqUg4lD4PgTjFhQ8JzZdq2qII7ZErnPnsmzGS
	PgH0sqLQS858uVwOawNtUs0lnUngYF51PjckKDK08bj/gigaJYaPsC1xZZ1RF0foGL9xugLPhUy
	lRgLLniesqr+IZ2VCLmjxzB81xB8=
X-Google-Smtp-Source: AGHT+IGlSYTQRBfMUgELbZLo1tlRGfDjpC7dTDov+1nkGPIKvfmCH8lum+uBoVzo99tt7ySmzqhksw3X2SzvsUo/MQI=
X-Received: by 2002:a05:6402:1e92:b0:58d:ebf9:4e2b with SMTP id
 4fb4d7f45d1cf-58e5916cde3mr8020855a12.2.1720433929045; Mon, 08 Jul 2024
 03:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708092317.267915-1-karthik.188@gmail.com> <20240708092317.267915-9-karthik.188@gmail.com>
In-Reply-To: <20240708092317.267915-9-karthik.188@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 8 Jul 2024 03:18:35 -0700
Message-ID: <CAPx1GvfkC0rv_8_q5_HfduhuKX4csO+sBZiZqV+Sh+Q0dV8+4w@mail.gmail.com>
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is provided
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:24=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> index db399097a5..ab023f9519 100755
> --- a/ci/check-whitespace.sh
> +++ b/ci/check-whitespace.sh
> @@ -9,12 +9,19 @@ baseCommit=3D$1
>  outputFile=3D$2
>  url=3D$3
>
> -if test "$#" -ne 1 && test "$#" -ne 3
> +if { test "$#" -ne 1 && test "$#" -ne 3; } || test -z "$1"
>  then

The braces `{ ... }` here are unnecessary as `&&`will bind first
(sh and bash give both operators the same precedence but
then use left associativity). Dropping them drops the need for
the semicolon. Of course some might prefer this to be explicit.

The `test` command has AND and OR operators of its own,
which give `-a` (AND) higher precedence than `-o` (OR).  In
addition, `$#` can only expand to an integer value, so quotes
are not required, and the whole thing can be written as:

    if test $# -ne 1 -a $# -ne 3 -o -z "$1"

(which is what I would do myself, unless I wanted a separate
error message for an empty "$1").  It's fine as is though.

Chris
