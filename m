Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8937A
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709943146; cv=none; b=QfQbm3lMJCn04i/LmHKmYXIisaMWcmEwJ5NRVTMX0jXrIbnyR4YaHe/p1fuVCWPoO+rscYFmFPqWanCSm27HIkLko3dTK3W6uBivtH+ZvUE12mT361NAUPm8AM3SaDPVonM/Xq9DknNa/M2+Ncc/km/Z/HmmkuUGEyhF54hsY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709943146; c=relaxed/simple;
	bh=GBcLh0VgS5JGxsyMxXe0hdDwOX5EYDc6uQEox0NB2eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy5Tan34eJdmMKxVcyXUMGKLfBHiUSJVjYXHLOXpM1XzlaS7lr8suxvxsrgjS3kzvUePXqx2VFIbyIsC/3FAAi29+jb1r2vn1FpvH1cj4i4WEgl6p0KWGJPx/KXxGEYzldUdhPgxUe8AztImJe9o0bnFw5SfCaMKm21PVueacpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDJA0t05; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDJA0t05"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so1908956a12.0
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 16:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709943143; x=1710547943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1iiFWkUc0AHaT3QCpMrp0CqxjL0eKTbeN3C5fY8YwI=;
        b=nDJA0t058utN1aSarnuHF1pL/VsQ7awVtCrBgvKewo7dBSHDHGEFuduC5JysAUNzMP
         jMiPMRsVHdCQVKBwQXCcZZk/M2RCAg6MYFcTIKkyRi22VE7LcwSkjkrAh7+7YJbKomnj
         Rpx1gXMJ/fgWz1oWlvLNxZyssL2ukC/QKT+S7sLhvg8Wa5xbIYcb0smB0tLDkjE6BV6q
         FjkVuLGTZ30Ue1NT87JNeaBmxNvOkLLnlt7x3YUQ4/sUYOGzStOx+U+siOhcCK3iVvrP
         /vFhDFv5mUx3BwRc4XfpArItJeP1Jb18dnEbihtGeMnyNNnys5Y09r03R7PcUlK8RRFu
         asqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709943143; x=1710547943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1iiFWkUc0AHaT3QCpMrp0CqxjL0eKTbeN3C5fY8YwI=;
        b=wbP1sV2ZeCEAEenKVtMFpsMrO7Er/XGlTo21QE2cQ1SzT3p9fvSt4vTzCvTBaze1j6
         JWoRj4ZdFvoV6QEMIOH9CVJEWmnESXGgZsjttLcP/zqRJKZ6ntXwEuXx8wPK7Lsuj9xr
         UyaFSc+4wUu4chtcZYrjoOlWSx/Gl5B6a5vB61G8tl1FypsrIVVP0agyn6LNcrgRif1Q
         76RoZ0T0t39cAMqbrgDziDH54nSqQNuPfb3ErhpYOqC0B7WVOy8pxep9W4VPyulVpbTW
         RJ3to2xqFgaS7yGgh8o7gMqlM19fnC1DZdy7mEVQcV+fNRjOORjxWPODjwEdQag5zOlW
         rOww==
X-Gm-Message-State: AOJu0Yz/+77kfJB5X8dDGhXrUNDACs0ogG/BpbMxbKlpaJ2/WdMYF7rs
	NxCSex8O/e8p1ZFlIpxKacYTxBMz/xiRTxlBbqtol0ktwKxF52z3G7WjI+P4FOnSlwzNTdkl7ln
	DvZd9Jg5cPz/rnzNZa9imCu3uDgm9EaKZOOchsLYLklG1NPGulvcj
X-Google-Smtp-Source: AGHT+IF9HspGBnorObzJ32P1uEmHt4jXuGQRZLsZPbi8AAHNGXV8N6Y+TVtVxWUySePnh6/zu/QVsewQEFzjdDZOZOM=
X-Received: by 2002:a17:906:415:b0:a44:deba:2e6 with SMTP id
 d21-20020a170906041500b00a44deba02e6mr106647eja.36.1709943142851; Fri, 08 Mar
 2024 16:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqv85zqniu.fsf@gitster.g> <20240308211957.3758770-1-gitster@pobox.com>
 <20240308211957.3758770-3-gitster@pobox.com> <CAO_smVjrKJeKr7QgQWryZRErStFk=Y+1T=dwrR_boXQD_X9_Mg@mail.gmail.com>
 <xmqqy1ase1vo.fsf@gitster.g>
In-Reply-To: <xmqqy1ase1vo.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 8 Mar 2024 16:12:07 -0800
Message-ID: <CAO_smVjD8DFcvveAg2iiWGhtNJGCT1ieAUzJbX3TNNJjm-5rMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: make bareRepository=explicit work in GIT_DIR
 of a secondary worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 3:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> >>     $ cat ../seconary/.git
> >
> > Nit: typo, should be `secondary` (missing the `d`)
>
> Good eyes.  Thanks.
>
> >> +       /*
> >> +        * We should be a subdirectory of /.git/worktrees inside
> >> +        * the $GIT_DIR of the primary worktree.
> >> +        *
> >> +        * NEEDSWORK: some folks create secondary worktrees out of a
> >> +        * bare repository; they don't count ;-), at least not yet.
> >> +        */
> >> +       if (!strstr(path, "/.git/worktrees/"))
> >
> > Do we need to be concerned about path separators being different on
> > Windows? Or have they already been normalized here?
>
> I am not certain offhand, but if they need to tolerate different
> separators, they can send in patches.
>
> >> +               goto out;
> >> +
> >> +       /*
> >> +        * Does gitdir that points at the ".git" file at the root of
> >> +        * the secondary worktree roundtrip here?
> >> +        */
> >
> > What loss of security do we have if we don't have as stringent of a
> > check? i.e. if we just did `return !!strstr(path, "/.git/worktrees/)`?
>
> No loss of security.

Then should we just do that?

+ /* Assumption: `path` points to the root of a $GIT_DIR. */
 static int is_repo_with_working_tree(const char *path)
 {
-       return ends_with_path_components(path, ".git");
+       /* $GIT_DIR immediately below the primary working tree */
+       if (ends_with_path_components(path, ".git"))
+               return 1;
+
+       /*
+        * Also allow $GIT_DIRs in secondary worktrees.
+        * These do not end in .git, but are still considered safe because
+        * of the .git component in the path.
+        */
+       if (strstr(path, "/.git/worktrees/"))
+               return 1;
+
+       return 0;
 }

>
> These "keep result the status we want to return if we want to return
> immediately here, and always jump to the out label instead of
> returning" patterns is mere a disciplined way to make it easier to
> write code that does not leak.  The very first one may not have to
> do the "goto out" and instead immediately return, but by writing
> this way, I do not need to be always looking out to shoot down
> patches that adds new check and/or allocations before this
> condition and early "out".
>
> > Or maybe we even combine the existing ends_with(.git) check with this
>
> At the mechanical level, perhaps, but I'd want logically separate
> things treated as distinct cases.  One is about being inside
> $GIT_DIR of the primary worktrees (where more than majority of users
> will encounter) and the new one is about being inside $GIT_DIR of
> secondaries.
