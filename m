Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E512F5A5
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914535; cv=none; b=ll9U5kbv2cm3yKwx+g4wH3atoIGuE001ZlBs8sdpqxHoHEs2EIg+jOMD5CUVf2qpp/nhlbHyuUA0viUTweoAO4OcA6RqVB4vkkHDPtw74PkrJUK0tqfTTjZ8+7OU9jXLDgBbaInxEoYdlqgZbTWd1rHfwEmkediP3hnuJsTKj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914535; c=relaxed/simple;
	bh=rzJkk4dlXGp6Carp14aEe/xsseMzSx7yi15cS7KS1Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhbwNUTu7NMyKexO8lgZiH+rHos0JGTHyFn5y+IUAn0m824mHe9BiX0gkffp09m01PUNB/SOXpCVvV17kxzP2B3RaGRLzFx9ookeLdbfIIyW16lQrLKp/mqrpntag5BdO5OjSG7GG74cSjxkOjADh7gVgT6O8guqEkPYfgWlKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9ER8F/p; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9ER8F/p"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45391956bfcso4077622b6e.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914533; x=1766519333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb/WDzrj6VRJVpGLqGrBTfOKxRXoj3DbBQJmn2EFIkQ=;
        b=N9ER8F/puGqTdMLFzrQNgzh7pUBU/BtDzM/2xAoRNYAl2mdUhuAlwQtPNYMMKdaUe7
         oThf1M9VZx5QvV/yhTcR8Oq7W0DoiwSPsxUhWclcZfpbWZ5sUSX46DYF6EREO9FF1OVI
         B4tNs1OiUYqhwXQ4UV0HbnkEuDJmhdX2Jt1bHL0YPZZTky+uLQVrxwTjnepWcPtTuud2
         KJNPedUCI9pb8tOlSRwJVlEpEEqupYDsX4RJ8ZOmQKSeC/+rCHMm72U/zWhnxpbAcIol
         0ftU29qKzPPZbawq5zb2HQwySIGkrscX//GkLx9U81XDsli4huEBMAXxsrADHXeDmO8E
         Qogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914533; x=1766519333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lb/WDzrj6VRJVpGLqGrBTfOKxRXoj3DbBQJmn2EFIkQ=;
        b=QFYOoqU2fYU3ILXCJDV6dU5381zsqmTdnRNxMb2s79ztgkxOP6sb1J42jLwfGktYGg
         PmxoGPNai1yPp7mpi3gqPKBVmDKrzYS6lHOE5NxEpu+iTajTK+/tVVvdVmBlVOfW7GBf
         TaQbeg2d9At6toourL0mwV/OLzpTTTDM42/YaqofAEaK1rE7c9Iv1VTVls34Yb4rir7G
         5HYOiuZ2NyAubaLZRli/etA8/uoAS69iVOfKYHIxvep9C6ayzhjL+XvetBN8zLD3BIhz
         3WsTZ46Ki9Ll5x1YVNFAlw0+XFFU16jc7L/6kmUZ1+ZpROC3U3BIWAUNj0YoY5JvoTjw
         YsiQ==
X-Gm-Message-State: AOJu0Yzv0KjdI58bdS7d9sM0RIVp8l1Zv/l3+g29xGeNGv/Oqasp1ic3
	aNllT+Moi/EeH7AtBqlw2V9kegDxm5Ib+pH8TF4Vt5XPiL6lFPgBxh8dZmt85G4DyTE90kzGg9j
	hdwnP+MJZB1zmf39Rhv8LDXuB/VieNNhpbQ==
X-Gm-Gg: AY/fxX7Gf20UAiDMiZ7zdZCQ4QZ3i0ywrGLAE0hu1gKk/td+DvA/1vushdWNe4D70cw
	eExr0GgxRtN5iSu/8AOpUivZIJuhfhCvsFEYtkzSNJUz4JyIFiG3CACaGDlMjhTOwRP9EicnJwS
	cBRo5maDn8MdYWbp/wyPlFNJgg0qlx1kNRJVB13PPpbF+4E46y1Q/OjzdtAAjnWT5ObeBL9nFZI
	wnKkaLIPxq9V1OQ4b9FbKdPsMqFhzuK4Ctf8QoNKlczjEl0MdRz86+CIAeBxlQtOTTYaUzHxolV
	UgZL4H6liCSmArV29RblJLQ4BnO/
X-Google-Smtp-Source: AGHT+IG1gdgRz7Q0uAqtG3sqoifmIlgTnHDh952YCIxsG+tuDPnMnCHq2A0vbs3VIDKlBHvxipYeoLvFk9DcQACn0cY=
X-Received: by 2002:a05:6820:1505:b0:65b:34e8:bab2 with SMTP id
 006d021491bc7-65b452ab111mr7491621eaf.73.1765914533003; Tue, 16 Dec 2025
 11:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
In-Reply-To: <xmqqv7i62r6w.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Dec 2025 11:48:41 -0800
X-Gm-Features: AQt7F2pIkbu2ibnm_Jzf7ygABJERgUAlkRZyxoE6LMpmI1Z7-W1-1BdoJKbGpn0
Message-ID: <CABPp-BFgRLo66P49dzgaS0TCbTKtA9J_Fw17QWQUhsLoFXeLnw@mail.gmail.com>
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be added
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 10:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Every now and then we see this coming up on the list.  Let's help
> new contributors who are not aware of past discussions by clearly
> documenting our past consensus.
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The text is from Elijah and Johannes this round; I am merely
>    playing a copybot.

The text was derived from what you wrote, though...

>  Documentation/gitfaq.adoc         | 19 +++++++++++++++++++
>  Documentation/signoff-option.adoc |  4 ++++
>  2 files changed, 23 insertions(+)
>
> diff --git c/Documentation/gitfaq.adoc w/Documentation/gitfaq.adoc
> index f2917d142c..0e40befb77 100644
> --- c/Documentation/gitfaq.adoc
> +++ w/Documentation/gitfaq.adoc
> @@ -83,6 +83,25 @@ Windows would be the configuration `"C:\Program Files\=
Vim\gvim.exe" --nofork`,
>  which quotes the filename with spaces and specifies the `--nofork` optio=
n to
>  avoid backgrounding the process.
>
> +[[sign-off]]
> +Why not have `commit.signoff` and other configuration variables?::
> +       Git intentionally does not (and will not) provide a
> +       configuration variable, such as `commit.signoff`, to
> +       automatically add `--signoff` by default.  The reason is to
> +       protect the legal and intentional significance of a sign-off.
> +       If there were more automated and widely publicized ways for
> +       sign-offs to be appended, it would become easier for someone
> +       to argue later that a "Signed-off-by" trailer was just added
> +       out of habit or by automation, without the committer's full
> +       awareness or intent to certify their agreement with the
> +       Developer Certificate of Origin (DCO) or a similar statement.
> +       This could undermine the sign-off=E2=80=99s credibility in legal =
or
> +       contractual situations.
> ++
> +There exists `format.signoff`, but that is a historical mistake, and
> +it is not an excuse to pile on more mistakes of the same kind on top.
> +
> +
>  Credentials
>  -----------
>
> diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-op=
tion.adoc
> index cddfb225d1..9a80d60f1b 100644
> --- c/Documentation/signoff-option.adoc
> +++ w/Documentation/signoff-option.adoc
> @@ -16,3 +16,7 @@ endif::git-commit[]
>  +
>  The `--no-signoff` option can be used to countermand an earlier `--signo=
ff`
>  option on the command line.
> ++
> +Git does not (and will not) have a configuration variable to enable
> +the `--signoff` command line option by default; see the
> +`commit.signoff` entry in the gitfaq for more details.

I like Johannes' edits to the text I had; this commit looks good to me.
