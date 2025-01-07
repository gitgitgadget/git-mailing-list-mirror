Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9F1E1A3D
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285389; cv=none; b=lquTBfcAm8ty8WZUzACVbIr49Y7ApfYVsL6DLhPr2mVVU0w62lQ9RBvemejokn6FIpE12BdtlfQSbYz0O7yJcBjIAGoYUZsFKuuTDkrRR6suSrFdX3Kia/b9r8w7m+7uqJTpQp0KeNe34UpsJ9P81plM5db0uhl9/pw8gIeqqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285389; c=relaxed/simple;
	bh=HIJbG12QFM5uPDzcqc1UsyDAgieygJ0i3MD/r+PICf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNAgJznM3/GAtjEfO2bqBaM27hxPw+JwIhVu8/wJbBLQD4zxEc7OCCFOvDBCVQ855WiLLdlXC5vbHWhiugzYChTq9wrGTI2DLRe4XXrXcZgB1MyRx9OpG/r4Wi/rFM0LtTOxL4MmBmcGC7Cu5sMJfKArWhLD7qXWZJ19tGV8/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VWgI50fg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWgI50fg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so2317a12.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 13:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736285385; x=1736890185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchdQ5NlskFvKaS15Vo60iuDHn7wz2Ue31pdTHJBBzg=;
        b=VWgI50fguWQAwzzmnp86l0WY77nOxGjTKgMXTWCczRijlzy/lqnXgJE0SRNWsWnf6I
         /x0Uyj4sUTyR6Reammq1HpoPQjPvk4+CcWs2kQkON0ng5us+uZ1Fzd0jHReb/WLqdQfc
         XfSL95KxyP3NJMpD+PzGFnoubYb3hr9Ra6N2rovAQUEN/y2Ay4VhOmRYYOMZe4cRDe+m
         yjA2DwEHuqrq+Gz6MyT243PQaSxmOuKLaDuF4Nvxu5b0Nr/QOXFqH5tEZN8Jhcx4IxHm
         gNohEIuzN9JLjcsVboviM+hZ35BMV1nWu3CiwZXFsdTab2H2vnW2IN1PNHbxcxtDHFTo
         zLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736285385; x=1736890185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dchdQ5NlskFvKaS15Vo60iuDHn7wz2Ue31pdTHJBBzg=;
        b=iG61ZsxTma27Z83g+yzME4ZXzp46jUtjJ2JlKRou3CxHpDrtw522hALIwQqttkbOIi
         XWdlvcUfheHpcWtx0PlRsSLqO264Q2Ssu1/7p/jPAgel+pyue2ys46SI9HPnEhyfki/d
         pGMMelwkGnrGUdODlGR8EOYktms860dO59XXKaBnB9x8XhzVoAeSv3gHUFzlNEOw4NH/
         OsMrsCAnYaEA1FH8On4s6XIdmg3C7xFDLn1j9xuPhv3b7UEobAFsR7FtrzTwhi+VVc7B
         sNz4hTJNyZXpCxYp4zlGPAwF4tv8YIoe1UGMXsW7vofFCrQ1RiHOS5BZ+ZQsY3rq4kJV
         c6Cg==
X-Gm-Message-State: AOJu0YxCfidQktrk8risHmre0GtLP5FSreOt8RKHNEAiRqFE+WpMgfGz
	F2qRlDJ/LcIOdIDajt1VzhI9rUGZoZZsEMnL4bzZAtDqgcqTHlg4HYTjwLmm0Tl8L89hw4yJ57u
	wTikM/ruH8v6It4A5UtdY9aXJWtgyuLn5vHW3
X-Gm-Gg: ASbGnctPcUBb1B0vyL22mnn3VusjoGF+0UgMefBX6aCVt2lHNvFbRsqZe4Z2jAR6yVf
	VAJqhSfzR5YkfA1zUxuovdrCl9hoUf74X/Cx/HDZeGszyrHG7hh6tm1nbSdYtu+eyzw==
X-Google-Smtp-Source: AGHT+IEMRszhuBW4a4KXdXQXyUypwm4BSJGY6i+lIaa16ZVJUYlO3+scR7+AmkTOar1Tcxfuy8OcRdPh1NmSvycVgug=
X-Received: by 2002:aa7:da4b:0:b0:5d0:dfe4:488a with SMTP id
 4fb4d7f45d1cf-5d9723c5b60mr20819a12.2.1736285385203; Tue, 07 Jan 2025
 13:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241223232523.76236-1-eric.peijian@gmail.com> <20241223232523.76236-7-eric.peijian@gmail.com>
In-Reply-To: <20241223232523.76236-7-eric.peijian@gmail.com>
From: Calvin Wan <calvinwan@google.com>
Date: Tue, 7 Jan 2025 13:29:34 -0800
Message-ID: <CAFySSZAnKQdOtAs9AXVQLPqyuZSuG+B-M+6uH3qdY33EaQE9vg@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] cat-file: add remote-object-info to batch-command
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	karthik.188@gmail.com, toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 3:26=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wr=
ote:
>
> Since the `info` command in cat-file --batch-command prints object info
> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.
>
> Add `remote-object-info` to cat-file --batch-command.
>
> While `info` takes object ids one at a time, this creates
> overhead when making requests to a server.So `remote-object-info`
> instead can take multiple object ids at once.
>
> cat-file --batch-command is generally implemented in the following
> manner:
>
>  - Receive and parse input from user
>  - Call respective function attached to command
>  - Get object info, print object info
>
> In --buffer mode, this changes to:
>
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue
>     - Call respective function attached to command
>     - Get object info, print object info
>
> Notice how the getting and printing of object info is accomplished one
> at a time. As described above, this creates a problem for making
> requests to a server. Therefore, `remote-object-info` is implemented in
> the following manner:
>
>  - Receive and parse input from user
>  If command is `remote-object-info`:
>     - Get object info from remote
>     - Loop through and print each object info
>  Else:
>     - Call respective function attached to command
>     - Parse input, get object info, print object info
>
> And finally for --buffer mode `remote-object-info`:
>  - Receive and parse input from user
>  - Store respective function attached to command in a queue
>  - After flush, loop through commands in queue:
>     If command is `remote-object-info`:
>         - Get object info from remote
>         - Loop through and print each object info
>     Else:
>         - Call respective function attached to command
>         - Get object info, print object info
>
> To summarize, `remote-object-info` gets object info from the remote and
> then loop through the object info passed in, printing the info.
>
> In order for remote-object-info to avoid remote communication overhead
> in the non-buffer mode, the objects are passed in as such:
>
> remote-object-info <remote> <oid> <oid> ... <oid>
>
> rather than
>
> remote-object-info <remote> <oid>
> remote-object-info <remote> <oid>
> ...
> remote-object-info <remote> <oid>
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
> ---
>  Documentation/git-cat-file.txt         |  24 +-
>  builtin/cat-file.c                     |  99 ++++
>  object-file.c                          |  11 +
>  object-store-ll.h                      |   3 +
>  t/lib-cat-file.sh                      |  16 +
>  t/t1006-cat-file.sh                    |  13 +-
>  t/t1017-cat-file-remote-object-info.sh | 652 +++++++++++++++++++++++++
>  7 files changed, 802 insertions(+), 16 deletions(-)
>  create mode 100644 t/lib-cat-file.sh
>  create mode 100755 t/t1017-cat-file-remote-object-info.sh
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.=
txt
> index d5890ae368..6a2f9fd752 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -149,6 +149,13 @@ info <object>::
>         Print object info for object reference `<object>`. This correspon=
ds to the
>         output of `--batch-check`.
>
> +remote-object-info <remote> <object>...::
> +       Print object info for object references `<object>` at specified
> +       `<remote>` without downloading objects from the remote.
> +       Error when the `object-info` capability is not supported by the s=
erver.
> +       Error when no object references are provided.
> +       This command may be combined with `--buffer`.
> +
>  flush::
>         Used with `--buffer` to execute all preceding commands that were =
issued
>         since the beginning or since the last flush was issued. When `--b=
uffer`
> @@ -290,7 +297,8 @@ newline. The available atoms are:
>         The full hex representation of the object name.
>
>  `objecttype`::
> -       The type of the object (the same as `cat-file -t` reports).
> +       The type of the object (the same as `cat-file -t` reports). See
> +       `CAVEATS` below. Not supported by `remote-object-info`.
>
>  `objectsize`::
>         The size, in bytes, of the object (the same as `cat-file -s`
> @@ -298,13 +306,14 @@ newline. The available atoms are:
>
>  `objectsize:disk`::
>         The size, in bytes, that the object takes up on disk. See the
> -       note about on-disk sizes in the `CAVEATS` section below.
> +       note about on-disk sizes in the `CAVEATS` section below. Not
> +       supported by `remote-object-info`.
>
>  `deltabase`::
>         If the object is stored as a delta on-disk, this expands to the
>         full hex representation of the delta base object name.
>         Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
> -       below.
> +       below. Not supported by `remote-object-info`.
>
>  `rest`::
>         If this atom is used in the output string, input lines are split
> @@ -314,7 +323,10 @@ newline. The available atoms are:
>         line) are output in place of the `%(rest)` atom.
>
>  If no format is specified, the default format is `%(objectname)
> -%(objecttype) %(objectsize)`.
> +%(objecttype) %(objectsize)`, except for `remote-object-info` commands w=
hich use
> +`%(objectname) %(objectsize)` for now because "%(objecttype)" is not sup=
ported yet.
> +WARNING: When "%(objecttype)" is supported, the default format WILL be u=
nified, so
> +DO NOT RELY on the current the default format to stay the same!!!

I remember this was one of my initial concerns when I first worked on
this series -- without a use case for other fields, it's definitely
hard to say how a default format for such would look and obviously
when implemented, would cause the default format of %(objectsize) to
change as well. I'm glad to see this outcome is well documented so we
can have this feature working with a backdoor to change it if
necessary for the future. Thanks again for your work on this series.
