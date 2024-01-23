Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196945384
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988449; cv=none; b=SrPZizMQJi9ChJJEAfYyqqyu9ik9NbxzSzB3yniOzioef1O1tM6USp+izMaQJ4muwL8lyJckyjeFNGBw2LmagMWlv1xkFdZxYY1lyMjElmvp3jjAFwhLCLExVR5aDOwPY8Ly9h4tCxHDssY+Ll4tJZzxaU/Ohgq5k+yt2v0lpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988449; c=relaxed/simple;
	bh=G3GuQoGmXsFvZ2uBpF7+uKrb0VSITXbpgnAc+r99LME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgjhXaeu6zIrbwdSCCm9P0Vx3OcxMI3HLD1i8mkl9b7T0FbGtJs/ItMUnASH9D1/HyNBIR2ASDPWGZeSbZDsEXuJB0Lo8918DccWTBFYb8DW2wkUFskkqgH6hrPaYkV55QoVZNANcmCJq56xakv3CECQcwd1AimwikhMDmQUnfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmmP9xgD; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmmP9xgD"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so3376522276.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 21:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705988447; x=1706593247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnUWxpf6CnaCDYvKSaOVoQJ1WzNcntjtQvGzdzJJqao=;
        b=nmmP9xgD1G/ERfLzrrNcn+zc+vg17e1i46BKzwQ4ETwKH/lx+amq+PclQNz27xrO8r
         uafW9Pt+FvdLy+EMigflErdoekNcRccRDXPezyg0r7cs+KGwoDf96CA0iKNh5r82IQkc
         ZV1wrAD6D8HmrkFzK72lzAZtdPnzqkEIC9SvfnTSYfmUnCYGtuflzrwMuWFoIFMwiSEQ
         qQhZNwrDD2v1Qut7J9nuWG0Qti4xJrDQ6P8o2DDFoVUFgpFZxVR417j626Aca5SUWnp3
         IUL6pwk61ouoprjxSu9sNFXotUC7ao2v9VkS7PIdS3x71OHRY+f/n85AFczgyogca4j9
         3q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705988447; x=1706593247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnUWxpf6CnaCDYvKSaOVoQJ1WzNcntjtQvGzdzJJqao=;
        b=NewV4UxnaU+fxeq7aIT9aMQpRnEfddTKq7apAacPJuPt6lOowR7QS+MjpMAOjw2VgO
         ZDSsbRSBSSf89kHhv87bScJA3xshmPHKZW2C5hT6HX31qQGv2IiwvUg2qQXMXxBHqzaM
         rffFmKRN2qDnop6jHMIIVqRSjoha5c0APel50mxZ3s8pVI7BQnY5UXzdarFxNCFQU71E
         IkBlYdn958LaUrPXZsOM2SyYT8QB8FDELWrzei3ARzF9XdGLA+FqEZfKm8D527FtyEXm
         1nOBvaJWe6swrsy6ozEHm/iISrOZas8+ekfGFGhdpQHnpm9+ft5+wMTGk7L11smmYkEq
         We8Q==
X-Gm-Message-State: AOJu0YyYMOZuMjw0yaw4/9NTnd9kNEofCB9+6Z3LWERuNgXR3YIBqm/X
	IV1fqt8bi9Vz0Wl10Q9nTJH6lqTteNV0dwikeAjsMwZTDi33nnpU2Z20VhcXJ/5MwpNCS9xcmbC
	xEiU7q3AQoTv0ybBZ7uhaScPHo2fJS8Y2
X-Google-Smtp-Source: AGHT+IFVGhb5oKQFhS1w+2295cboVAlXHXotGiefEMdClcY7jDQkA9ZudNnhOLoSd2j+MCokPaMEBEAU2KvPeihz874=
X-Received: by 2002:a25:d894:0:b0:dc2:30f8:da7f with SMTP id
 p142-20020a25d894000000b00dc230f8da7fmr3032543ybg.72.1705988446827; Mon, 22
 Jan 2024 21:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
 <CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com> <20240122213410.GA811766@coredump.intra.peff.net>
In-Reply-To: <20240122213410.GA811766@coredump.intra.peff.net>
From: =?UTF-8?B?UmHDumwgTsO6w7FleiBkZSBBcmVuYXMgQ29yb25hZG8=?= <raulnac@gmail.com>
Date: Tue, 23 Jan 2024 06:40:10 +0100
Message-ID: <CAGF1KhWaOrnV8d2f_vajOT0hFK2N_8m7-p_vnZhw92ZdhXfsag@mail.gmail.com>
Subject: Re: Fwd: Unexpected behavior of ls-files command when using --others
 --exclude-from, and a .gitignore file which resides in a subdirectory
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff, and thanks for your reply :)

El lun, 22 ene 2024 a las 22:34, Jeff King (<peff@peff.net>) escribi=C3=B3:
> For example, I get:
>
>   [setup]
>   $ git init
>   $ mkdir subdir
>   $ echo '*' >subdir/.gitignore
>   $ git add -f subdir/.gitignore && git commit -m "add gitignore"
>   $ touch subdir/file file
>
>   [no exclusions]
>   $ git ls-files -o
>   file
>   subdir/file
>
>   [use .gitignore]
>   $ git ls-files --exclude-per-directory=3D.gitignore -o
>   file
>
>   [using standard excludes]
>   $ git ls-files --exclude-standard -o
>   file
>
> Do you get different results from that toy repo? If not, then what is
> different about your main repo? Do you perhaps have a stray "*" match
> somewhere in .git/info/exclude, etc? Or are you still providing
> --exclude-from in addition to --exclude-standard?

The difference lies in how I deal in my computer with ignored files. I
have some files in all my repos which have to be ignored always, so I
have that pattern in my core.excludes file. BUT those files have to be
backed up on my system, just in case my local copy of the repo is lost
for some reason, as they are files I need for development in my
personal machine.

If I use --exclude-standard, no matter if those files are being
ignored by core.excludes OR .git/info/exclude, they won't appear in
that 'list other files' command output.

So, my previous idea was ignore ONLY those files ignored by the
repository .gitignore file. That way, the other files that go in my
core.excludes or .git/info/exclude will be listed and backed up. The
problem here is that some of the repository gitignored files (files
related to building, testing, etc.) have their own .gitignore file
containing '*", but they are NOT present in the repo .gitignore. This
is a common practice for Python virtual environments, for example.

Summing up: or I end up backing up those directories that have their
own .gitignore file (not the end of the world) or I use a different
solution to decide which files are ignored but "precious" (I love that
concept, see Junio C Hamano message for that) OR I add those
directories to the .gitignore present in the repo. This last idea I
don't like very much, as they are particular to my system, not the
repo, for example, *I* may decide to use ESLint and node_modules for
some particular web page I'm writing, but the related configuration
should not go into the repository and should not be ignored in
.gitignore, but in .git/info/exclude. I won't backup node_modules, of
course, it is going to be recreated, but I may want to back up
packages.json and .eslintrc. And both of those files will go into
.git/info/exclude, so if I use --exclude-standard, they won't be
backed up.

Since as both Junio and you correctly pointed, this is in fact the
expected, I'll try to find a different solution while the "precious"
concept is finally implemented. I have a couple of ideas, like using a
.giprecious file which my backup script can process easily, containing
the untracked files to back-up.

Thanks for the toy repo, helped me test the differences with my setup!

--=20
Ra=C3=BAl N=C3=BA=C3=B1ez de Arenas Coronado
.
