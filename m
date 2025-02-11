Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B926562D
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305365; cv=none; b=MsIaRGGuXwmeF+JVSr0yVybvUkEfrVrzRmsEaWTxsHBihJB8HsVSypT4lMike+wHVuqtensj9ZhGLMWdPmizg7eUSSyk1tTT7hZcAgevhpk5jKj+QHMRCBzvkVrlu4CkL1HikcSrAJyEYBxMsMAV5Ha51OgfGfcJzKhxIyAQrVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305365; c=relaxed/simple;
	bh=t2iUDHwUlElkqgm8jJyn1JQl1iCz1sROXqx6F1VeJ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INDyx/C4TWrwVWbGpthErjYzd7jBOIbUo8ke3h44Fd44uoDLgzUAGrOPQfHQ6wQFHyXidJMoQow+z7p3uR6dSSmMn6kea2sRRKynL/jMG/B5+XN60rNJwZPRUTPJN5GgAhOA+hsYdjwccdxh17E+CcTwockS2ZAxV443hyk6iuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqoHS12x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqoHS12x"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab7cc0c1a37so386069366b.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 12:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739305359; x=1739910159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXhSJv+iHVziGFDcoJZ4RbvZoQxkaznvsiPY5C/bkjM=;
        b=hqoHS12xQiyUeJgouDq4hDzoLmk1Xz4JEtIRWzAUVdp6jTqhiO5wByWDi44PDIuqFG
         VVnDQ+EtiipGOapXhcTZWvtmJfapBlZLgrzfx3l4j3M9UzBSdgY2LczGgwH0WBopNLXF
         p7mlY71falDtvtCzFRb3J8R009bBY+ZEnRrddv6qJgAaVnGM1EclmuuiaiApgjBoexz9
         AmFaPEqEHdw/Tp2Uyr9hKkLlju93ZS4d5dMd0fNnqXMP5xCKJTpoGURM1UUHJIwCCxdb
         RopcMcRj94wpZinPOwwi0zGi9J426v9fd2DYMZLtohAWzsjnQodGEw9VWiedLJkZKdDy
         P1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305359; x=1739910159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXhSJv+iHVziGFDcoJZ4RbvZoQxkaznvsiPY5C/bkjM=;
        b=PUzsEjRhXXPtr3/pk918Obp0al29IUpUze8u9+96lVJyD9OEek/9qqMZiWjHwhaPzT
         AZCTLxC/ot0+3yTqBVPn8GCUEjnyBLAbwmJPh3L+NWyfJxGt7bLxIShkcVHX9LDf/0HA
         NvZykYiA1UYOSbGiTwkIfEekJieyyjdwue2Yg3Gh9gx08kUg38i4f5Q6vmGBlp1QFc6A
         qU7/gaX1aIzMtW7uxmWRh7aSx0FQR5SQfca9kLe73rSoLUCiEz2cZEfJD3WTK7ckiNL5
         n+gErqdI74Y0LOZykBDRHocNm7Djw3m4OATkO2grwtv78mS2Vj8AhU1br4rXG6GTp/38
         eg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsN9NgtwaR7T8j/+nysDkd58C8NEJ0k0iDr23J3+EV4K8Sv8os+u0EAfMTHb1CpKyqSAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhjEpwq7KQcVa88O14Pdrbqvp0MPcPJXHLvzl/W9syMYzDQML
	t1y5hCTjatD60Mi78LtfWpyYHcZBb2ivN4z7GTu5qgsav6n/FaWwdRUyi5ntbASwMa4H4cfcIWb
	O5OAUFEyb/iUx23LS7A/Ldz+jb70=
X-Gm-Gg: ASbGnctvnO5vUG6IrDxiuVXoeXZGF/MvQq0h4+PXgLLjIeLlFqIvjaVvr52ButsCRku
	D0pX7SvWiZlF14qP+c8fcgrdnurDwL19bJWmJZ1a/IDoxyofCDD1cDtkugubvMm0Eq1cOxlD29p
	ajlqsPi+hgAMZo7QDHLtfnBMay7I+9
X-Google-Smtp-Source: AGHT+IErOHb8Fqgq5mi4eao9COBY5Na7FrmxUOr5ToIKYModOiNDu+WoGlN348TJ82/3qzGJDo5ErUcH85Lubdqh7BY=
X-Received: by 2002:a17:907:1909:b0:ab3:84ac:4dbc with SMTP id
 a640c23a62f3a-ab7f31a3665mr40991566b.0.1739305359308; Tue, 11 Feb 2025
 12:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208061702.88469-1-forivall@gmail.com> <Z6sCeYmljrqWRFnS@pks.im>
 <CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
In-Reply-To: <CALnO6CDHZerHKaWwGc-9CmwEMiFVY+Ds5-GNWYKUi1yO7=U_Rg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 11 Feb 2025 15:22:28 -0500
X-Gm-Features: AWEUYZmGI2_-Tag-d_es1I9WNYZ6kZWG8jCBavdAgcbCPYyPjDmQMN6xjxbr1gk
Message-ID: <CALnO6CDdJ4abqxZKMaevPO+aCzSqriM98JuVOX068gQrxWZt5Q@mail.gmail.com>
Subject: Re: [PATCH] revision: fix missing null for freed memory
To: Patrick Steinhardt <ps@pks.im>
Cc: Emily M Klassen <forivall@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:31=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Tue, Feb 11, 2025 at 2:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> >
> > On Fri, Feb 07, 2025 at 10:17:02PM -0800, Emily M Klassen wrote:
> > > "git log --graph --no-graph" missed cleaning up the output_prefix and
> > > output_prefix_data pointers. This resulted in a segfault when using "=
--patch",
> > > "--name-status" or "--name-only", as the output_prefix_data continued=
 to be in
> > > use after free()
> > >
> > > Signed-off-by: Emily M Klassen <forivall@gmail.com>
> > > ---
> > > I previously reported this a few hours ago, and ended up digging in a=
nd figuring
> > > it out. I'll make sure to bottom reply in the follow ups to this patc=
h.
> >
> > Do we know when this bug was introduced? Is it a recent regression or a
> > long-standing issue? Might be nice to point out in the commit message i=
f
> > we do know.
> >
> > Patrick
>
> Out of morbid curiosity, I've started bisecting this, but it's proven
> slightly more subtle than I anticipated. If nobody beats me to it,
> I'll post my results when I have them.
>
> --
> D. Ben Knoble

2.{30,35}.0 fails to recognize --no-graph, so I checked "git log --grep no-=
graph
origin/master" with "git describe --contains" and decided that 2.36.0 was f=
irst
release recognizing --no-graph, but it didn't build for me (possibly an iss=
ue on
my end). I got 2.37.0 built, and it was "good," so that's where I started.

Here's my "bisect run" script.

    #! /bin/sh -x
    make || exit 125
    # segfault has exit >128
    ./bin-wrappers/git --no-pager log -2 --graph --no-graph --patch
--cc || exit 1

The --cc is important, since this repro logs from where the bisect is! With=
out
it, if the head commits are both merges (likely), the repro will accidental=
ly
mark the commit as good when looking further for a commit with a patch will
fail. Omitting -2 might work, too, but that makes "git log" take longer.

With --first-parent on bisect, we find 3eb4cc451e (Merge branch
'jk/output-prefix-cleanup', 2024-10-10), which looks like a reasonable
candidate. Restarting between that commit and it's first parent, we get
19752d9c91 (diff: return line_prefix directly when possible, 2024-10-03). T=
hat
commit actually looks relatively innocuous, and I haven't tracked down how =
it
really impacts the problem or fix.

Perhaps the topic merge is more helpful to folks in assessing where the bug=
 came
from. Otherwise, it may be that --cc is not enough and we should
bisect with --diff-merges=3D1 or something else guaranteed to generate a
diff and trip the bug.

To my shame, I didn't save the log from the --first-parent bisect from 2.37=
.0 to
388218fac7 (The ninth batch, 2025-02-10), but I did save the smaller one.

    # bad: [3eb4cc451ed97123ff76e183a5be8a7dc164d1f6] Merge branch
'jk/output-prefix-cleanup'
    # good: [31bc4454de66c22bc8570fd3af52a99843ac69b0] Merge branch
'ps/leakfixes-part-8'
    git bisect start '@' '@^'
    # good: [436728fe9d75d05fa2439f867ca2039012b86e69] diff: return
const char from output_prefix callback
    git bisect good 436728fe9d75d05fa2439f867ca2039012b86e69
    # bad: [1164e270b5af80516625b628945ec7365d992055] diff: store
graph prefix buf in git_graph struct
    git bisect bad 1164e270b5af80516625b628945ec7365d992055
    # bad: [19752d9c912478b9eef0bd83c2cf6da98974f536] diff: return
line_prefix directly when possible
    git bisect bad 19752d9c912478b9eef0bd83c2cf6da98974f536
    # first bad commit: [19752d9c912478b9eef0bd83c2cf6da98974f536]
diff: return line_prefix directly when possible

--=20
D. Ben Knoble
