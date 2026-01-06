Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382E72621
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731585; cv=none; b=X9Rm6CIrDoBFYuV5YGdLatjvM8Izq2QEaxYuXiBm0V2/NFBwH1t2Exejx2aPEOf/iJ/PeN9Cr5DBqkdnhgWS3cqSf3Yg3MEM/tSVlejdCxx1L9obKkIRxYtssaUuDvpvsZoE19DuPhLepkqL7PYWigVUUV/V9wx5Y1t7J7WY8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731585; c=relaxed/simple;
	bh=Fc1/EZEXHDV42SYe9qiwQs1boY5sQVOB2Nt0mzY6osQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ3y3NAMC/ti9vBrXcX8Fz5V12DbrUg6HgDoum6aRJ70Z5/sHn+iYLLn1pEFu6pI79A+GglD8News3OdQy7jp9W56K3QojDLbeTW9ecMPJ0TWRHDLXjUOeHxyL8rCZ0Xg01HkIKKyyMG3D2Ssjkr6/kfzhe/zENdbi3xcK0AaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXm4FeGO; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXm4FeGO"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6467c5acb7dso1409629d50.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 12:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767731583; x=1768336383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj9g0PydnmXoOGwf4uX9DXPnMUW8UJYAqGBGZXHN04o=;
        b=iXm4FeGONc1E5b1QBG0HCCA0hcmEuDQgo9JA/58BIjZgoFnfgIDMktYAJzCneV/ISG
         WCOt5/NwqEjw9O7+rpQhdQegTCdLxfqHyYY0JdvBJInHe/nnmuEqY65hqOPoDS5gpQyp
         ZWtZGlJEhGBxXI8P4ptEEaqqB1sw0/18FP3HZ01LxNUKaaVwK88avCU3uHB7WrwQ9TXJ
         seZ8ux7++Fl6MRTxOCuY6n0Fb2YuvqNH1IOTwkN9kJbO9SHW8HFsD1ngCJ+h1buiaGWy
         93dtJEhgPtYB86W+OgRORiwn615xcU2TSiwJiLGvZcHTD1TwXRFMQ3FQXa1MSL/XQtSR
         ucaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731583; x=1768336383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mj9g0PydnmXoOGwf4uX9DXPnMUW8UJYAqGBGZXHN04o=;
        b=jnkno8GLaOtXlxxt8zuSRtwTH9gdVujXr3rpUgLPorKN6XQ6/yXJF3gFHwSBkcUPdP
         KJVgzNRPCwfK/Nu1OZ/e+F0B+1WX/1sG6GtfiDzQ/YIlwmlUJ5KJihBPPXGi6DrpMrYG
         oZlf1g5QFWu2krqz8wTu9IYcSWS+S784CL4GQifBEMAi0F+Akni9UUokJuh20H3x9g5D
         3zLtCh22084xOmNpwXLgBmkERuyA3ibRn4KVg+nVnVamfXuYMYXdP2ZqZZfGSr0dEIBj
         HiANdS49VNUQLetdsf2cD2+1ZEIUus/2Dz08KDw3UwadkSUr41Vb0XBRrpDy3ZlHFP0v
         wR3g==
X-Forwarded-Encrypted: i=1; AJvYcCWXyx4p1V7js9M6MVcN8DagaKxyQr7lvIf2+TW8qy8kJnsGYyrIvzLPklgAgFTlzStqkkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegZ2l8bFofqg3Zm//i/UH2MZGW1F5BPZju4WKpjxYxD0XL/1a
	sTUJGhHVlm79X3csGQJ9+JAcpRkly/7LBM4wHpJ4zaEoyZRKOTYa1wyzUnztVKTnmZhLEix7gii
	TXdzCwm7nVOsWZzY+fsdCcr6WwI03qe8=
X-Gm-Gg: AY/fxX70Awau9nMBuuhTpLf3OuwxJFPXldRT2X7lH9wHyL8GqfJvg7prWwS/eveDPBF
	o3cHyBgaubcC3iuN/azMxaqaMdXmnp59mnliWM9M55L7uHns+A7KVAIZI+oPbfLcPIZVhrdg0uK
	PVIwIpBUcFgo/ogydOXeSigVPDfnRuwxwAGEN/EXP2IKvZnIDQHSxHs0DUPNTA6GTYzPtchTP0e
	Ef883CNtikVFV690bM8S4Q8XtlkhjKd2ACwBBAUe9fR8bOmk1EB1s0wEt6hkFoqgUD+E/YMbm55
	WVMMqsU=
X-Google-Smtp-Source: AGHT+IEaFwTlup0lEKYYBLEBi1bUvgiaxXHFPhK3sqLrDAHC4Aw/dOxeiFzNQowbHvEHn7MP9sAQ0btFg0vo4kWZ/pA=
X-Received: by 2002:a05:690e:1186:b0:63f:a488:ba46 with SMTP id
 956f58d0204a3-64716bcc5c5mr284737d50.32.1767731582675; Tue, 06 Jan 2026
 12:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com> <20260104173524.GA29867@tb-raspi4>
In-Reply-To: <20260104173524.GA29867@tb-raspi4>
From: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>
Date: Tue, 6 Jan 2026 15:32:50 -0500
X-Gm-Features: AQt7F2o2jsBz22rudUtfExrD2pZBoN2L2q7JZKUbwh_qi0U9JdhXKYp8XZ2Vqdw
Message-ID: <CALH9GrYi0dYo4LJg8ww1cDOETiOT44m0zQgkxLsxqEuMmv_myQ@mail.gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matheus Tavares <matheus.tavb@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 12:35=E2=80=AFPM Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>
> On Sat, Jan 03, 2026 at 10:16:57PM +0000, Matthieu Beauchamp-Boulay via G=
itGitGadget wrote:
> > From: Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
> Thanks for contributing - some comments inlie
> >
> > When reading exclude files, git assumes it is encoded in UTF-8 and will
> Question: The report citet below talks about ignore files.
>
> > fail to apply patterns if it isn't. This is a silent failure as no warn=
ing
> > or errors are shown to the users. This is a problem that can take a whi=
le
> > to diagnose as many users will not think of checking the encoding of th=
eir
> > file and may believe their patterns are wrong instead. Users may also
> > accidentally commit undesired files.
> Note:
> git status is your friend.
> Blindly commiting without checking what is staged or not may
> lead to unwanted results.

Yes of course, I'll remove that last line as it is not the problem I'm
really trying to fix.

> >
> > On Windows, this happens if a user uses Windows PowerShell to create th=
e
> > file, which results in a UTF-16LE file with a BOM.
> >  This issue was discussed
> > here https://github.com/git-for-windows/git/issues/3329. An example of
> > where a user was confused that his exclude file was not working is cite=
d
> > https://github.com/git-for-windows/git/issues/3227.
> A very short research indicates that powershell can be configured
> to use UTF-8. I am not a powershell user, please correct if I am wrong.
>

Yes you are correct, but I want to address the issues for users who may not
realize that they used the wrong encoding when creating their exclude file.
For that case I don't see how the fact that powershell can be configured to
UTF-8 helps, aside from preventing repeating the same mistake.

> >
> > A minimal fix should at least warn the user if git cannot properly deco=
de
> > the exclude file.
> I think that reading an ignore file that contains a '\0' could/should
> Git to complain. If someone asks my, most users are tempted to ignore
> warnings for different reasons. Bailing out may feel more unpolite
> but more clear that somethinh is wrong.

While I agree that warnings may be ignored, I feel like a wrongly encoded
exclude file is not an error that warrants stopping git entirely.

As other reviewers mentioned, I wrongly assumed that the encoding would
be UTF-8. The idea of looking for the null byte in the exclude file
may be helpful
since any d_name from readdir (3) is null terminated. Checking for a null b=
yte
before the end of the file could be a simple check to detect a bad exclude =
file.

> >Ideally, git would handle any given Unicode file.
> That is debatable.

Of course, I'll rephrase that part.

> >
> > First, check if a BOM is present. If it is, decode the file to UTF-8.
> > If no BOM is detected, then try to parse the file as UTF-8. If that fai=
ls,
> > attempt to decode the file using the working tree encoding of the file,
> > if any. If that fails, print a warning to tell the user that the exclud=
e
> > file could not be decoded and skip the file.
> >
> > This raises the issue that if the entire tree is encoded in, for exampl=
e
> > UTF-16BE (no BOM), then even if the encoding is given in .gitattributes=
,
> > git would not be able to decode it.
> "able to decode: Yes. But willing to do so: not with the patch, right ?
> > I believe that this is still
> > acceptable since a warning will be emitted for the file (since it has n=
o
> > BOM, is not valid UTF-8 and no working tree encoding could be found).
> >
> > One case that isn't handled is if a wrong encoding is given in the
> > attributes and the exclude file has no BOM and is not UTF-8. Using
> > iconv to convert an UTF16BE file to UTF-8 while specifying UTF-16LE
> > yields gibberish without an error and so this case is a silent failure
> > where no patterns will match.
> One question is, if we should look at working_tree_encoding at all.
> The other one is, how much UTF-16 handling of ignore or
> other file should we have have in Git ?
> It seems that this fix is for a very special case only ?
>
> From
> https://github.com/git-for-windows/git/issues/3329
> we read:
> /******/
> if (size > 1 && buf[0] =3D=3D 0xff && buf[1] =3D=3D 0xfe) {
>     char *reencoded =3D reencode_string_len(buf, size, "UTF-8", "UTF16-LE=
-BOM", &size);
>     if (!reencoded)
>         die(_("could not convert contents of '%s' from UTF-16"), fname);
>     free(buf);
>     buf =3D reencoded;
> }
> /******/
> (Which seems a simpler suggestion)
> However,  there is no UTF-16-LE-BOM in iconv
> (at least in the majority of implementations),
> so a better approach, totaly untested, may be:
>
> if (size >=3D 2 && buf[0] =3D=3D 0xff && buf[1] =3D=3D 0xfe) {
>     char *reencoded =3D reencode_string_len(buf+2, size-2, "UTF-8", "UTF1=
6", &size);
>     if (!reencoded)
>         die(_("could not convert contents of '%s' from UTF-16"), fname);
>     free(buf);
>     buf =3D reencoded;
> }
>
> This leads to some free thinking, especially when we look at
> other implementations of Git:
> Would it be better to simply bail out on UTF-16 files ?
> Techically all files with a '\0'.
> [snip]

I was trying to cover more possible use cases, but this may not be a desire=
d
behavior after all. Other reviewers pointed out that the exclude file may h=
ave
an abitrary encoding that needs to match the encoding of the paths as read
by git when using readdir (3).

You are correct, UTF-16-LE-BOM is a 'fictional' encoding handled by git. Gi=
t
handles the BOM and iconv will be passed the UTF-16LE encoding instead.

I would've liked to be able to handle any wrongly encoded exclude files, bu=
t
it's more complicated than I originally thought. Checking for a null byte
could be a simple way to detect some wrong encodings.
