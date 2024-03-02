Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2621754F
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709375344; cv=none; b=M7+Wt9V95icWI9u7nJKaQezJK7WaDl9BTFfD6jJw4ZxJka3YSTwMpxuFz+i9AJMp5X0cCJxWmfvY8JtQc94Z1S28nvdnVP0uNYEVci233utWv2+cuq8p+IHvA9wsU7pQoGJe/tjhDfU/GuXuNkWt8CGvnk4xlY4h64AEPVexnIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709375344; c=relaxed/simple;
	bh=1xDwblOG9cC5963uXxW6MqWbftSEEb0A/Ka4vPNsmbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2xKtF/p0T6BwBRwGx/VDCr48KRPVLpamScCqj6shrM8vhuU+Wj1pkOwOj8aHWsgbwULWPlblt6RB4dpsd5TAYp//KvoV0hy080dUVdz4FFWOWuWs1hPTjIOY13HPNlp99T2KHpT/RPgWRKwSVTEpUqthJesc3aYh3R6zFhl3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJPFdXw1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJPFdXw1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44665605f3so311371866b.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709375341; x=1709980141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEG/3gLv5n0Kkh+L8Rlmc1EG5umTJS8F4EeoRPCB0Lc=;
        b=iJPFdXw1e3aKAv8V9d9t3KXV6jZXb18Yn9uvG/3RMgskS6lGzPkS20xvBeIJeg+D1p
         ux4h+wT8ZGMedTiRG7Bc5FTWLNjfvso3Xpy4bbylkO4SGHqIZMJUwWsQovY7D3nUiz7F
         Wo5uWbo/xqZVq5Am8c1V8c0UBuUunudZWraUPaFmJDMvM1/D21WamhJ1OpsUu2cPbAwC
         uTUYqKye0gNjGKg8e8DMOG+qIokOKeYpaA+ZlysI0wroAAj/p2RicvNKr88aqWakTm+j
         okN3acowjvMuk1vMqtdtm5h20qlZX+C0lpz6eSIzviQjkVv6B+pnfg/y7qNhUWXnkkyf
         kD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709375341; x=1709980141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEG/3gLv5n0Kkh+L8Rlmc1EG5umTJS8F4EeoRPCB0Lc=;
        b=M0T4i+ot0xpgEBItvDr/nKRRnoTonTR3NBKotGfkbsTsi+sb+G9EidQ/GcYyiPM7wF
         nce83UvHHiDpRdB/JK/Ay7jPJYbAaeUr18LsSRM4dvlPVyKSkbNMIW/sy6PX9Z/0CeLV
         OgNf5MHomfms7jeq9+ZfL8XuT3GpYAA5aHqEoDQmsKm4WujKXERq4V7mYjrCeHjcAzDb
         eWjJnYmk4eBT4T3/0vFVowvGDU4klz4cO4JEUqgSMSM3lR3NadhVZmDXJO4rsaRIzpnc
         asIUnxL65e88tS61B7DnU6ICBYdEvdz9lABzYrorD+fubm5VDDzR5YG85U7sy2kMKLqx
         oCkQ==
X-Gm-Message-State: AOJu0YzGviGZhgXPaGLxjwCfFLOA3ysVzSsgX5cQbLLSMqS5smyakw/M
	A6BnypUUyZODxaxof0XolBTup+IDCQm1VTPHOX1nMTkt1E2Y+50/61nVtxMNYDqJo7uoo+5YP/q
	z5dS9SDEzf4iY5Sh6WzZ1k+jQUvE=
X-Google-Smtp-Source: AGHT+IH7GFKBmFIqEMxAtJRRyuOu/GWqpc+J29vz+1Rd4HNbgAvauTyqa3bTtw87CbEbMrNOn8DlJWJdAjglySECDz4=
X-Received: by 2002:a17:906:f8d2:b0:a43:793b:5b05 with SMTP id
 lh18-20020a170906f8d200b00a43793b5b05mr3044308ejb.60.1709375341106; Sat, 02
 Mar 2024 02:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqttlsjvsi.fsf@gitster.g> <20240301074048.188835-1-sergiusnyah@gmail.com>
In-Reply-To: <20240301074048.188835-1-sergiusnyah@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 2 Mar 2024 11:28:48 +0100
Message-ID: <CAP8UFD1sAYORc_q20t4Y28mSjNa0BZ69XQ-hGFsNTzbThsG1KQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH] userdiff: Add JavaScript function patterns
To: Sergius Nyah <sergiusnyah@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, pk@pks.im, 
	shyamthakkar001@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The subject should be "userdiff: add JavaScript function patterns" so
with "add" instead of "Add". See the SubmittingPatches document which
contains:

"The title sentence after the "area:" prefix omits the full stop at the
end, and its first word is not capitalized (the omission
of capitalization applies only to the word after the "area:"
prefix of the title) unless there is a reason to
capitalize it other than because it is the first word in the sentence."


On Fri, Mar 1, 2024 at 8:40=E2=80=AFAM Sergius Nyah <sergiusnyah@gmail.com>=
 wrote:
>
> This commit adds a patterns used to match JavaScript functions.

It should be either "add patterns" or "add a pattern".

Also instead of "This commit" please use the imperative mood or
"Let's". See the SubmittingPatches document which contains:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behavior."

> It now correctly identifies function declarations, function expressions,
> and functions defined inside blocks. Add test for corresponding change in=
 userdiff.
>
> Signed-off-by: Sergius Nyah <sergiusnyah@gmail.com>
> ---
>  t/t4018-diff-funcname.sh | 22 ++++++++++++++++++++++
>  userdiff.c               | 12 ++++++++++++
>  2 files changed, 34 insertions(+)

In t4034-diff-words.sh there is:

test_language_driver ada
test_language_driver bibtex
test_language_driver cpp
test_language_driver csharp
test_language_driver css
test_language_driver dts
test_language_driver fortran
test_language_driver html
test_language_driver java
test_language_driver kotlin
test_language_driver matlab
test_language_driver objc
test_language_driver pascal
test_language_driver perl
test_language_driver php
test_language_driver python
test_language_driver ruby
test_language_driver scheme
test_language_driver tex

So I would have thought that you would just add a
`test_language_driver javascript` line in this file and associated
material in the t/t4034/ directory.

> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index e026fac1f4..d35cce18a0 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -120,3 +120,25 @@ do
>  done
>
>  test_done
> +
> +test_expect_success 'identify builtin patterns in JavaScript' '
> +       # setup
> +       echo "function myFunction() { return true; }" > test.js &&
> +       echo "var myVar =3D function() { return false; }" >> test.js &&
> +       git add test.js &&
> +       git commit -m "add test.js" &&
> +
> +       # modify the file
> +       echo "function myFunction() { return false; }" > test.js &&
> +       echo "var myVar =3D function() { return true; }" >> test.js &&
> +
> +       # command under test
> +       git diff >output &&
> +
> +       # check results
> +       test_i18ngrep "function myFunction() { return true; }" output &&
> +       test_i18ngrep "function myFunction() { return false; }" output &&
> +       test_i18ngrep "var myVar =3D function() { return false; }" output=
 &&
> +       test_i18ngrep "var myVar =3D function() { return true; }" output

I think we try to use just test_grep instead of test_i18ngrep these days.

> +'
> +test_done
> \ No newline at end of file

Please add a new line at the end of this file if you still change it.

Thanks!
