Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B4EADC
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732370; cv=none; b=YxoqssY11jjcvRzdr6Bp4IhGzckfGGY4TiVfGwA4mY4HaH7tKIZ+6GBGgc8D8QpSY084X+sr63eHGfxLZ4fShhDzkl3Yc9h6lWf1PPNqB305kQ/z+fGp3aQiympghxLGp1pXd5vsJWKm6Fxz7NQIPt9N6OkJLIJnee+tV3298R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732370; c=relaxed/simple;
	bh=f5WgHLQiCGuNTjApfivL4sv2Hr7wlYGYr/mO6xVO3dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BiE8ruYjfn12pv8UJCuVuw4TANA0s5Z/SZ0n48++0tBaRPJ4tQsGpQjGgThFxGSs6t8RDwFrxU3dDLzVztvjeVWFC9GmFK2K4nNMIyV6/S3xV0ulw9QUMLhLKtezyh8FGQQniyFeRFO90k9neYjFX4DVVaY2bDf26XHikdIj/xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ia4gGRN3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia4gGRN3"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78c66bdf675so15015347b3.2
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767732368; x=1768337168; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4QpZqhWHUSHaSZhfnFYbQOR8Jantni69P0CXNCa3FE=;
        b=ia4gGRN30vihjYaV30wXYBfcD66uNJ7agn5icjFz2m858nW5Le3iPdeNJLR4gyabE7
         cS2evyAvJEkFIUfGnDYHFWs56cGe4SGE/U/pmWz1i6MzDlZsQG+qkqtF07VcrhYJsazp
         707z8KeFTZKoQgHCrN4ek7gIW5WLwTLZfXfcfp2Kg+UyhUFyIIJh+jL0qDDGaHjeqYBq
         ybcWvqqorl4f4H+HIORmTZszQdVMLEFBwLS62hbOaV4elmAspu0UI890gwzxyCzus63J
         k4SF+qzmpgdxlOwOp9DTDtLQhh2iaS5DEPkjQHpM7yyXdmzOwCXEhRsZkvNTw114lgMu
         r5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767732368; x=1768337168;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4QpZqhWHUSHaSZhfnFYbQOR8Jantni69P0CXNCa3FE=;
        b=R/zk/ecAeAQZdnFkKQgaOyAdYRdsSpKfd0xTQMkGUHvTvkKOCFWeXNfhgC43M8OkHf
         TYHaIkx1k8i17KOKh1YZ77+4fEz4tm9z4QkeJpXsY6QH9qLC4Lt7s4RHugnbS3ZNb/cp
         pkIJ3Ulztqfysmmnaul1HDHgc5mp4dxsIwJFndNO2dlNaZ5hT01w6aFTcXhBujZGCkgI
         rn1lVzcVjRk97GKvm58xq0IrGYlHdqk14f5dNuKLCFUblmC4MyC5PVwuopm7SajcnnTq
         9fYTeGQqs2KfxxuMFW8joKKjegiVlzcCGUwPwyqS4fuuFaGb7VaK4tc81oYXCyGoPyje
         lDCA==
X-Forwarded-Encrypted: i=1; AJvYcCUzwz85MP/Xc2kpmspeOwHMdUlZrjo/MK+eXitNWhtm0GFzG7PLQSFkk9QDSvIJ+xhq5MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAF95bl+Q+zTLVVY/v94fO0QycGoJQveGaowYPaYEWGv8zKPi5
	kDoSL4VfyGd04++CGYaGVk7xQE23kebEXiUMkpEK9poIA+53qzqwYhYVvOt79fnf8WmFwDimDWa
	MzfdnXhO5q990XdDcpvguNcqCx/jekdE=
X-Gm-Gg: AY/fxX5EiSBXHhBpI6ZrzUWbtBBuNYexWmoTt6RV/ANGUPGltRV/5hGSszOopw3y8d+
	M7bNLCsB1JTSMdmmoqIXjU7IIPEZcLOoSNTdA2xgHjwy6hOk1aPBTfX53XdT2XSKN2Mw4TMP093
	5QnQ453vTc/tjDxpxYJn4r0nWEUyx30b3eshVWJk0jK6BwNMMxRfP6G7SeINhYsSp0IevEFLjJr
	AEPAbgKr/WcH2GUsv7eBjkiFbCee3dGKvAdZWZaQ0P7sH9FGNyPiuIWk9UF65haAQLQsJJT6zWt
	TF76Ygs=
X-Google-Smtp-Source: AGHT+IF2iXrrF1OLN3ixe8m6yNZIURivHDBvtx1cRgEmnnYuo8j7A67ssE8TyauE/q/ZRIgkMMF/YyiQc8abyhIv8IA=
X-Received: by 2002:a53:eac3:0:b0:646:518b:bde5 with SMTP id
 956f58d0204a3-64716bbb77bmr230879d50.8.1767732367906; Tue, 06 Jan 2026
 12:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com> <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
In-Reply-To: <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
From: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>
Date: Tue, 6 Jan 2026 15:45:56 -0500
X-Gm-Features: AQt7F2oyxBUrS2BX0nZ9R4qznfigqA2GoSbiMhJ6zZiQfDmVjUYONXA6SGl6rGw
Message-ID: <CALH9GrYOjb92gjrtdjwapFH9L73XGg1Kan8uz1aVLpSXNURi+Q@mail.gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matheus Tavares <matheus.tavb@gmail.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 2:40=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-01-03 at 22:16:57, Matthieu Beauchamp-Boulay via GitGitGadget wro=
te:
> > When reading exclude files, git assumes it is encoded in UTF-8 and will
> > fail to apply patterns if it isn't. This is a silent failure as no warn=
ing
> > or errors are shown to the users. This is a problem that can take a whi=
le
> > to diagnose as many users will not think of checking the encoding of th=
eir
> > file and may believe their patterns are wrong instead. Users may also
> > accidentally commit undesired files.
>
> This isn't actually true.  Git allows arbitrary byte sequences in the
> file because Git allows filenames to have arbitrary byte sequences, just
> like Unix.

Yes thank you for pointing that out, I had some wrong assumptions about the
encodings.

> > On Windows, this happens if a user uses Windows PowerShell to create th=
e
> > file, which results in a UTF-16LE file with a BOM. This issue was discu=
ssed
> > here https://github.com/git-for-windows/git/issues/3329. An example of
> > where a user was confused that his exclude file was not working is cite=
d
> > https://github.com/git-for-windows/git/issues/3227.
>
> Ah, yes, here's the problem.  UTF-16LE is used on Windows, and on
> Windows, Git stores pathnames as if they were converted into UTF-8, so
> you do need to write the filenames in UTF-8 in the ignore file.
>

Yes, the conversion from UTF16-LE to UTF-8 would need to be platform
specific.

> > A minimal fix should at least warn the user if git cannot properly deco=
de
> > the exclude file. Ideally, git would handle any given Unicode file.
>
> As I mentioned, the file isn't necessarily in UTF-8 or Unicode.  Here's
> an example shell script to demonstrate (requires a non-macOS Unix):
>
> ----
> #!/bin/sh
>
> rm -fr test-repo
> git init --object-format=3Dsha256 test-repo
> cd test-repo
> touch abc.txt
> touch "$(printf '\220')"
> printf '\220\n' >.gitignore
> git add .
> git status
> git ls-files -io --exclude-standard
> ----
>
> I'll point out that all of this is also true for things like config
> files (which are also used in `.gitmodules`) and `.gitattributes` files.
> If we wanted to make a change, we would be wise to make it everywhere.
>
> However, if we wanted to force `.gitignore` to UTF-8, we'd need to have
> an escape mechanism to write non-UTF-8 sequences, and as far as I know,
> we don't.

Right, I don't think forcing UTF-8 everywhere is worth it for a relatively
simple issue. If I can find a portable way to determine that an encoding
is incorrect (and possibly reencode it), I could apply it to those other fi=
les
as well.

> > First, check if a BOM is present. If it is, decode the file to UTF-8.
> > If no BOM is detected, then try to parse the file as UTF-8. If that fai=
ls,
> > attempt to decode the file using the working tree encoding of the file,
> > if any. If that fails, print a warning to tell the user that the exclud=
e
> > file could not be decoded and skip the file.
>
> We do not accept and strip BOMs in UTF-8 files elsewhere (including in
> things like `git diff` output), so we should not do so here, either.
> For Unicode files, if there is no BOM, then the standard is that it's
> assumed to automatically be UTF-8, so a BOM is superfluous and not
> recommended.

I meant checking for UTF-16 and UTF-32 BOMs and then converting to UTF-8,
I will clarify if this part is still in the revision.

> > diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
> > index 2dabc8c73e..1b1cc357ba 100644
> > --- a/t/lib-encoding.sh
> > +++ b/t/lib-encoding.sh
> > @@ -23,3 +23,11 @@ write_utf32 () {
> >       fi &&
> >       iconv -f UTF-8 -t UTF-32
> >  }
> > +
> > +write_encoded () {
> > +  iconv -f UTF-8 -t "$1"
> > +}
> > +
> > +write_bom () {
> > +  echo "$@" | perl -pe 's/\s+//g; $_=3Dpack("H*", $_)'
> > +}
> > \ No newline at end of file
>
> We place newlines at the end of our text files unless there's a good
> reason no to.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA

I will fix it, I would've assumed that clang-format would fix that.
