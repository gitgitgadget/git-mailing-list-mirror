Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333D846D
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466021; cv=none; b=WBQBCFhBo+NEkeeM75AX0tnQimRkVzxEbLms5ZjQf0rLp157mMXrW8M8dlSO0VtWiECVxyZf3aOHJb/Nq1xHofnXmqlOsoL5dw1OeV8eX+0EpoAfnCEGpZdSwzhfTBvaH50f92uS3cQGp8RLXgg4UtJ//EaYrOCsyul5VFX0TEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466021; c=relaxed/simple;
	bh=Mo7wHgFwSuSOCHfPlCGBw2w2FvcZQQG3qmPxS5Ot4Gw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mdbdo8D5cGCwKvWSUd8mxLG8mww5Yq/Sfr1nCqiYNCXj+R4rgjahk1StyE73bk9mG8uIQobJHCFNUqg/bu/e+AlU1VwACW2+dbyREsOo+ZdughvWa7rfoYGZHHhDj9pEMMgSLpuDkNuwHmQlo1lO+jhC2yTMmLaHLgNzpidGshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=RNDEGgc8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="RNDEGgc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1707466015; x=1708070815; i=johannes.schindelin@gmx.de;
	bh=Mo7wHgFwSuSOCHfPlCGBw2w2FvcZQQG3qmPxS5Ot4Gw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=RNDEGgc8L0BJw7dZoFIzDIvAXs4s0nUnw5tmE9LJgWyqNQwq9tSnmjyo6FMFvs1z
	 LH/kWLd4qkJSw4VNqkV+hgjTP7DVWNz6doSLGGTWDnbMjNW1ooEscPufgN72IiZdX
	 Y0DFizTit/0fywzJDel6njCGTeJ7z9/u1ZaPFTnR9EGKuZnYVp7aoaOTjZO9K4+xq
	 OPHLt4Z8HIVmBN5tvB7jtdWCZyMOJUa0Iu2wF6Wh/aFd2c31SMhTQ/8pSr09VCk60
	 KPUdCHfiXZ0xLlt0dJqQkDSlEwoHAp7zBnK5yvAW344LaxcDJz1DNobZHMn9o6/uy
	 14pMGFXQF4pXvJ+aKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLi8g-1rGgX92jNA-00HiWR; Fri, 09
 Feb 2024 09:06:55 +0100
Date: Fri, 9 Feb 2024 09:06:53 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Kyle Lippincott <spectral@google.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
In-Reply-To: <CAO_smVhrMn=-uF1B6+RA8A+VLCEN=o57zbQPtr8hpxRKY=qJRQ@mail.gmail.com>
Message-ID: <5fd95ae0-cd50-ddc4-5095-ee953c2640b3@gmx.de>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com> <CAO_smVhrMn=-uF1B6+RA8A+VLCEN=o57zbQPtr8hpxRKY=qJRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-14761512-1707466015=:544"
X-Provags-ID: V03:K1:ySoqbLp6mY7/hbZQJg5D1+nWxZNjvGcDi9IDfv+2U44COUx96zP
 0o+t9LvUbrMFtEDiyXl7G9SfjkhXNOHJLTMu/UrltbnQUGGdwNUcfS8YJXN/XJgH66+hjjl
 j7FWI2ilG6VfxUxOBdlNYp04A382jVMQ/gY/nyDh7ZXCdEGFKcEgvsVId5M2w+XbedtxHL0
 3cctNkP1EAKns3FASIikg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vPFDOOmyqww=;Rrqx9sG4MHc8sqNeiTnBqMWSm3X
 c48Hu9D4UdKcw0qTorDCzV/nA6UIiahpyeLjHFY12BuegBhCXX5cO7lC8L28yJWOz3iUr3Wrx
 H3AVgTS+FtkSJpK9T8UyBl6dzLU9cIwCR+cu3EDkGHzTQn6rIfAvqrGl+8LUM5cP9LRCccSFt
 rEVd6tw0nZ9D2JVHXEF0y/xvm3W7RjMzbtD8Mu0i/KcpqkZQ9bE7Qu0KcX4t2vI47pYwwsNip
 nLOjogh3iUftZyp2AUafxGfqEG9DnR9TsM4O24RCvgEafNP3dShxBWAAlAO46iNg7SSKqnCyq
 Yck9q0XzVcKQUnc+6e4+GvaNhXHwacT6tOb18vGyNyUyu2yIyJo9hUPhORcx04XI16XSTZalH
 SWkRRxO725w90bicH1VEhbNEITgGG3KyrlaVUTUy7n9ucfThIpNS5MbtU2oZSpqIGpOA/sUOb
 paaCKB+l8I+K8nb1bLoKDBtHx7GrgnpzMGvdPJfirhmbeah3b9DTgfLxHbYNJ3X3sOkPz1Rc0
 RCW927dWmdWSr3b97+rqq9tmTKroSqxraFTMXnvjRC/FMFkgYfuwgk8Iau9IAKGsvFHAJfMdV
 tnv7bsaACJ9pTwvkZqwDeiGrSO1ITnDGshOJO1INqypmm3V7uxG9quEj04Y6qVRKP/vk6lRZ7
 SQwfiifbI9ottm9Ca+xY5Y2dXjLxBE5x18SpmL+c+YVUpYaEvrWCUzoho3JJfSRaaKlXdr3JX
 +PV88LorzNVUTGVuWLad4ILHewyU7+HZYGzI4iHfrj1zaw4SmylN6dYkxXB+3JddWekPfoqXH
 D1iLlK/raJBuwbXlFRliaGZhicr6+t5q+fqUWxgylMTtQ=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-14761512-1707466015=:544
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Mon, 5 Feb 2024, Kyle Lippincott wrote:

> On Mon, Feb 5, 2024 at 6:36=E2=80=AFAM Johannes Schindelin via GitGitGad=
get
> <gitgitgadget@gmail.com> wrote:
> >
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index e65cae0bcf7..caf20fd5bdd 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -716,9 +716,11 @@ static int append_edit(int argc, const char **arg=
v, const char *prefix)
> >                 struct strbuf buf =3D STRBUF_INIT;
> >                 char *prev_buf =3D repo_read_object_file(the_repositor=
y, note, &type, &size);
> >
> > -               if (prev_buf && size)
> > +               if (!prev_buf)
> > +                       die(_("unable to read %s"), oid_to_hex(note));
>
> This changes the behavior of this function. Previously, it would not
> add prev_buf output, but still succeed. This now dies.

It does change behavior. The previous behavior looked up the note OID,
then tried to read it, and if it was missing just pretended that there had
not been a note.

I'm not quite sure whether we should keep that behavior, as it is unclear
in which scenarios it would be desirable to paper over missing objects.

In GitGitGadget, I am a heavy user of notes and it wouldn't do any good to
have this behavior: It would lose information.

And even in scenarios where the `notes` ref is fetch shallowly, I would
expect all of the actual notes blobs to be present, and I would _want_ the
`git note edit ...` command to error out when that blob is not found.

Does that reasoning make sense to you?

Ciao,
Johannes

--8323328-14761512-1707466015=:544--
