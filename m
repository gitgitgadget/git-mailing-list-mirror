Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E623182D
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527248; cv=none; b=KTqneztGzziU4XdkDI02WVHp8eDNQ0sT0sMYsmTDNDxoKEJ0N/4mLEHiLY2YkwV/Jy3Q0ZcoitdjpRJakl+glVeQFPpjZlndT3ooMVGkMf5GbTtsAT+iHwTlpBcuO2JEXd1curZmuyC1W+Ooj7bHaNP4nw3yQCmAduPN91HIo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527248; c=relaxed/simple;
	bh=hygco9OgAxBhvfXpz6QF4gZRJVxIjyGSEYuZr+fhLQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXeQAadMFsPcIPqgQrccH48myk9Qqtp2jMMoNckut0IonNqTQvpe4DdsqJFvN3UuVd46v7fwMNAqXWYnnF35Yp1/XJc+mVjiPi6Cfdg0qz+ojjqUdpCUo+iA19dQ3vxeqBTrvsbas6K6fNHZ6TAvbU+UdlSrdL8ljPIUzr6Gj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agvUsZ+B; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agvUsZ+B"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df2ddd39c6so18588735ab.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752527246; x=1753132046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mggomhgn7zGkm2+E2/wv+XacTCR6Pk+5I4VC8McpyHk=;
        b=agvUsZ+BvTd8fUgClWL/HXcD13Glz1WnTacGdx6iINMDkvkcQgT0u55oVfJp7Anv84
         DdFZVvCD40cRrtyosXMr+LaxkQhUJpZeDx7OeQ6Yjd/FaE+cKj63buag8wtW4iRzIgIH
         bQtuiprc6h6OSb7GQvma9MJhZcAEr/MpqZf3ppJ61s+423R3kf8ZJxI8RjyGI2KlpbnU
         SQigIWl5W74UplKJFeE8a1h/MXqhCN4Y3eGFlA8IBj05vkFQg6ghT+mRoOzr0iXoyBMt
         /jwLefy2P6uSIqxas88Dcfk3gssQvtrpi2eIaQafcc2QKIdmtrUcCapnyQvu116VoKNT
         vzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527246; x=1753132046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mggomhgn7zGkm2+E2/wv+XacTCR6Pk+5I4VC8McpyHk=;
        b=RIypWtudd7OhhT1P5kBZ7boc2i4+7Udo5s9wlqJIQyV1rj5zGj5yeZfi8L7rQwS31E
         q8pt/jO4IvEHE0Qd2w+k6OL9a0i84e95YaeSxblPT6PVYu+QsgCua7LNIJCuuqPgHjTX
         OoTqCZKgXx97b861/rbyQP+RW0KR2QTHqkHpyYS6U0RsmFRZOHp2l9N+QEYYJk1aF4dd
         KO6bulwbf8tnVJpEA9UIOJn1rJwPL1ma1oKGUITUZ1fKYy8fjGXPluZ7y90BbGLE5yM6
         gbamb9HBoCmj6p1ROe996Km+rCXqaGvIK5js3cJKbNI4yIUZSuu6v90c+G6B3ozN3KSr
         XmoA==
X-Gm-Message-State: AOJu0YxxuAYE8BKhDKAu16W7r0mdsu+kKNjLj9cln+yBVkdU8fYWddKS
	vVsIgC8nXd1Zow4iJn3qCKTIIztyj+LdcJvxBLU9eUmj/KCNLOQPyj0dAUh2u3zY3FaZMMj6mAn
	orB5H1AbKzXz1TPMvws6IgwN7zZj53sY=
X-Gm-Gg: ASbGnctVp8Oh1sEGu1fdHLG1PqTb/Sc6oMj+WxRgTn6Y7OxKOsOoHYspa+1+6KkECYK
	87wZ+YiDumKsX1vzUCUAmMJjzSc8h/kb1WR1c0d5gBE0Yai+NTKaJRivDIn9atZrCqe46b3RwTH
	7vtMmncG4hd/nskFaE5VkOeryOUZ0jxFXyanU9VohF4vwWiXn1AlAfzJjmvWyA7ap5tuWnftC9b
	R4URT+3triVy8AA6fwXEOlfmk4xwFSYDD/2KpVwqASMWF7HSys=
X-Google-Smtp-Source: AGHT+IEUbCSgxZIhpuJZqnZwUg5WK5gTPQ7VsuGORiYg7+YuyrjRPDn/mpOVm6H67wZ4aOQhuPFdRusUtadPDhfEqyg=
X-Received: by 2002:a92:ca09:0:b0:3dc:7f3b:acb1 with SMTP id
 e9e14a558f8ab-3e25426be83mr113602505ab.13.1752527246305; Mon, 14 Jul 2025
 14:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708091738.4072857-1-christian.couder@gmail.com> <20250709141253.623563-1-christian.couder@gmail.com>
In-Reply-To: <20250709141253.623563-1-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Jul 2025 14:07:14 -0700
X-Gm-Features: Ac12FXzgL10c5CbA8KUy40XhIlFqePmrLLava9zfKNzIPachKsao_u3jJqNdkbc
Message-ID: <CABPp-BHM5afgiUf7GsTPWmrf_tm6mWnvHWMKiZPxApJzN-U8gg@mail.gmail.com>
Subject: Re: [PATCH v6] fast-(import|export): improve on commit signature
 output format
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay; noticed this in what's cooking and wanted to
double check whether I missed anything, and decided to add a comment
here...

On Wed, Jul 9, 2025 at 7:13=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
[...]
> Let's improve on these limitations by improving fast-export and
> fast-import so that:
>
>   - all the signatures are exported,
>   - at most one signature on the SHA-1 object and one on the SHA-256
>     are imported,
>   - if there is more than one signature on the SHA-1 object or on
>     the SHA-256 object, fast-import emits a warning for each
>     additional signature,
>   - the output format is "gpgsig <git-hash-algo> <signature-format>",
>     where <git-hash-algo> is the Git object format as before, and
>     <signature-format> is the signature type ("openpgp", "x509",
>     "ssh" or "unknown"),
>   - the output is properly documented.
>
[...]
>
> +test_expect_success GPGSM 'setup X.509 signed commit' '
> +
> +       git checkout -b x509-signing main &&
> +       test_config gpg.format x509 &&
> +       test_config user.signingkey $GIT_COMMITTER_EMAIL &&
> +       echo "X.509 content" >file &&
> +       git add file &&
> +       git commit -S -m "X.509 signed commit" &&
> +       X509_COMMIT=3D$(git rev-parse HEAD) &&
> +       git checkout main
> +
> +'
> +
> +test_expect_success GPGSM 'round-trip X.509 signed commit' '
> +
> +       git fast-export --signed-commits=3Dverbatim x509-signing >output =
&&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH x509" output &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               git cat-file commit refs/heads/x509-signing >actual &&
> +               grep "^gpgsig" actual &&
> +               IMPORTED=3D$(git rev-parse refs/heads/x509-signing) &&
> +               test $X509_COMMIT =3D $IMPORTED
> +       ) <output
> +
[...]
> +
> +test_expect_success GPGSSH 'round-trip SSH signed commit' '
> +
> +       git fast-export --signed-commits=3Dverbatim ssh-signing >output &=
&
> +       test_grep -E "^gpgsig $GIT_DEFAULT_HASH ssh" output &&
> +       (
> +               cd new &&
> +               git fast-import &&
> +               git cat-file commit refs/heads/ssh-signing >actual &&
> +               grep "^gpgsig" actual &&
> +               IMPORTED=3D$(git rev-parse refs/heads/ssh-signing) &&
> +               test $SSH_COMMIT =3D $IMPORTED
> +       ) <output
> +
> +'
> +

Overall, the patch looks great now.  There's just one little nit-pick
left; I'm still not a fan of tests of the form

  (
    cd dir &&
    git fast-import
    ...lots of other commands...
  ) <output

because I think the "<output" should really be moved to the "git
fast-import" line since it's only meant to be used there.

This series adds 2 such tests.  You did point out in the discussion on
v5 that the testsuite already uses this idiom and you wanted to match
existing style.  (Though there were only 2 tests previously that used
it, and you already modified both as part of this patch.)

However...we've been through enough rounds and this is really just a
nit-pick; I can submit a follow-on patch later to clean up the four
tests and see if others agree with me that this is an eyesore, or if
I'm just weird.

I think it's good to merge down.
