Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADC21B4236
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750267; cv=none; b=DXdAv4xgGujMLzILdl1jeogre5AsiJzq8ZWsr5ZQImvfryg2gdknNdL67Qvtfq2m3vBK+DfCrbxBWz3JwIdKcAKrN8As7x0XKmF+kgR42HAKdU/10jXBGY+1IcdhxOtMLsEJPLXOV6AeO9L6PIv3KGdkETqnQ6eNbV4OIvIPLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750267; c=relaxed/simple;
	bh=UeVpBWE3PFNpNAwqAgXiWyO7VOKjcH8ntKoqg5GKqCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKJR7rz0scCNe4q4g/G/sSwPVIv4DsK61sIdLxbURqsWWE1r/u1Q36zvnQpZTYYW0ev2cnZZTNwF3yTd6hkAyC+Ju9zXxfYhJrWPPVxzUmais8CmFFLjpdwx5oKYpfyYN46Od11z9MFHZ3IUXXYfclq3QpNAuU4A2CxKAL3Kfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hko7fFha; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hko7fFha"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a78b39034dso12248515ab.3
        for <git@vger.kernel.org>; Sun, 12 Jan 2025 22:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736750264; x=1737355064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwSxWwpYA/z04kxwH1EN/UB3/BbH8oSzmD+gHMhpnoA=;
        b=Hko7fFhazREbltJDAUVOrj5Ek0r4RJaDnTM/S6BLc31x3cxrzLJtyLPpaxNeSeoAZ1
         7NXM8jsLgfOz9+pUIzB7GdRFNPm/0aFxe1lERjQJXSoyM0wLcYshSfB4JW8KcRz13x4H
         feVNnMSNj2VNpOznVRSitxoZnsi/rWCX3iUz/VyoXmOwVEg+OznN7RIU/HGVQYyjLaFz
         LrcWny7gxhVbAvDIJte5SJ3C8dwRUb0T5syezP6JkViNUXwofXh2PP4mwHRU/K0AEBwx
         edxDkpMFYlyYw7VzcFjnplRMQ2SUw/GVR5MnA4AawBMhY5w50FolDxArH5WZVEnhZUYq
         bPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750264; x=1737355064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwSxWwpYA/z04kxwH1EN/UB3/BbH8oSzmD+gHMhpnoA=;
        b=b96Nhi8osqpAyY33DkgYtJnYKwXwydqwt+S4NG6qMGJ/rxqmLBLqyqarzqSHDbG8/q
         Vj5SKxi1xh0x/4FTFQqYqGQbcxInt+9W1QKOvGo85k7WKibAm2ZZuYXTK5txrbAfLkkH
         meM2ROLIke2kYoWlM3+4SmVb1rRgnlpa1kBIBN5t3oYvuiCAfXIjTGJpjLDG+H7lZM43
         l0wBVvX8Qyf/NYPxl/GSDj6lVoBtrc9YYjlgLoa9Z+EzWR0LwQSIsxCLG+r1aN+0UUtG
         d/AZoeZJs2KqiQvIcKYaUad3yN1eWgL5s95iy2EN2ArgWsbRnsJ+wrn1hHE8ajgZc2kD
         xBFA==
X-Gm-Message-State: AOJu0YzqlQ8s05rcc+3jduSU25XKK+y1nrowu62VBnHCvhHVuKEU3Q+7
	ruyqQt3pkjoT7aYRZgv+VbGypf+6NSTiUJou9boeFZRZ9/eSYQ8DJQOUc+pkvKuW1+ottLM6Eid
	eNeRVnVUFmLJLsovYHzAPkvaElyDZTk6r08A=
X-Gm-Gg: ASbGnctow+dT2Z1x7lQJGZgNLuBTIV9mTg+TVItn/ZfwAf5NRcf6N0JuDvryymv5ByE
	sbnfwc6hwnxFrcd1FBwP7LZ3ytEQxGCN70zbC/MU=
X-Google-Smtp-Source: AGHT+IFSGR+fzxAghFcrpS5luk7+i+1hfW/ejO1o9GvKyWAcmbY6qGJueg8nL7W59Wg8Zsn0bLsQAkmKzuudtyWE5DI=
X-Received: by 2002:a05:6e02:1747:b0:3a7:e8e1:cbcd with SMTP id
 e9e14a558f8ab-3ce3aa75f60mr151840635ab.22.1736750263921; Sun, 12 Jan 2025
 22:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMmT1pKVMB6ZUbsEdB0RqbWERauGVqgo_RbXj4j9+csXLHCStw@mail.gmail.com>
 <CAMmT1pJnZxxD3wFikiDRCqZZMxO8P6EgVHe9mJEsfA8PK4-OfA@mail.gmail.com>
 <CAMmT1pJ0ReaX+g2_gFQ2oLUrzhR5wCXGvCj_WwDMXcfG2DNG_g@mail.gmail.com>
 <000a01db5546$f034b7a0$d09e26e0$@nexbridge.com> <CAMmT1pLszvmQN06eUdnhZHpqDLrF2aaXFxdniumLt1x9MSdKfQ@mail.gmail.com>
 <CAMmT1pJpKct+zV_WV_QXKCL_A0cGURNbKZDKGzbATCDN3cQDsw@mail.gmail.com>
In-Reply-To: <CAMmT1pJpKct+zV_WV_QXKCL_A0cGURNbKZDKGzbATCDN3cQDsw@mail.gmail.com>
From: Krishnamurthy Ganesh B <ganeshsurfs@gmail.com>
Date: Mon, 13 Jan 2025 12:07:36 +0530
X-Gm-Features: AbW1kvZOTvoAK_ZpxmmCmhKtoggSgKKRgcPerCEq4SWJ2mrz8yzObVYaRXt1CqY
Message-ID: <CAMmT1pJO7t2vyanDko_0ed1VZOP_TOfpJe1JNjN5EpoRbRVByQ@mail.gmail.com>
Subject: Re: [bug] encryption of metadata in .git metadata file inside .git folder
To: git-security@googlegroups.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

@randall: adding a point: While I understand your objective to
"encrypt anything that might have data in it", there are solutions
independent of git what would cover most use cases.

- encrypting everything or all data on .git metadata folder may not be
the point you wish to address in the point along with the export
solutions. the data of the git repository is not being addressed here.
we are discussing the .git metadata folder not the repository here.
- there are no solutions in the market that encrypts all data within
the .git metadata folder. again,  the data of the git repository is
not being addressed here. we are discussing the .git metadata folder.
-  "opens git up to export limitations" is not needed for .git
metadata folder. a few milliseconds of speed into cache with caching
read-write speeding options

ps: .git folder being referred to for the .git metadata folder (not
referring to git repository but hidden .git metadata folder)

[apologies, not sure why my emails are bouncing due to the html
version even when sent as text].

@randall (i am sure we may have interacted before or probably same
name someone else): my answers for your quote below:

- disk encryption has nothing to do with .git storage. local access by
access provided users will always be there.
- disk encryption solves the challenge of modification access in the
server by devops professionals not manipulation intent
- disk encryption solves the challenge of modification access in the
server by devops professionals not any code injection and remote
incorrectly executed issues
- disk encryption solves the challenge of modification access in the
server by devops professionals not any code injection and automated
code drive incorrectly executed issues and access to memory and or
.git folder when appropriate chmod rights are provided
- "opens git up to export limitations" may not be a great reason to
avoid for the same. the object folder inside .git seems encoded if not
a binary store and can be reverse engineered via code
- "opens git up to export limitations" may not be a great reason to
avoid the same. load issues for speed are not that great reason when
tmp cache options can be a viable option. probably, you can work with
optionally encrypt the .git folder option.
- "opens git up to export limitations" may not be a great reason to
avoid the same. what other export limitations and CVEs are limiting
the need?
- symmetrical encryption: i am recommending a personal user provided
or default salt or key based based encryption for the .git folder
- you may wish to take feedback for the organization using git-scm in
their organizations. a bug bounty has been raised for gitlab, github,
and atlassian that are the most rigorous for the number of users in
the domain. i can also raise a bug bounty to azure, aws, google,
oracle, and other networked providers if needed shamelessly to get
this feature enabled (probably using an option to encrypt .git folder
while creating a repository)

"Have you explored using disk-level encryption to solve this?  While I
understand your objective to "encrypt anything that might have data in
it", there are solutions independent of git what would cover most use
cases. The problem with adding symmetrical encryption to git is that
it opens git up to export limitations and related CVEs. It would also
cause adoption issues with many organizations who may have
restrictions on whatever techniques git adopts to solve this.

My preferential solution is using COTS hardware encryption to solve
protecting data-at-rest content.

Regards,
Ganesh B

On Wed, Dec 25, 2024 at 12:04=E2=80=AFPM Krishnamurthy Ganesh B
<ganeshsurfs@gmail.com> wrote:
>
> hello,
>
> [apologies, not sure why my emails are bouncing due to the html
> version even when sent as text].
>
> @randall (i am sure we may have interacted before or probably same
> name someone else): my answers for your quote below:
>
> - disk encryption has nothing to do with .git storage. local access by
> access provided users will always be there.
> - disk encryption solves the challenge of modification access in the
> server by devops professionals not manipulation intent
> - disk encryption solves the challenge of modification access in the
> server by devops professionals not any code injection and remote
> incorrectly executed issues
> - disk encryption solves the challenge of modification access in the
> server by devops professionals not any code injection and automated
> code drive incorrectly executed issues and access to memory and or
> .git folder when appropriate chmod rights are provided
> - "opens git up to export limitations" may not be a great reason to
> avoid for the same. the object folder inside .git seems encoded if not
> a binary store and can be reverse engineered via code
> - "opens git up to export limitations" may not be a great reason to
> avoid the same. load issues for speed are not that great reason when
> tmp cache options can be a viable option. probably, you can work with
> optionally encrypt the .git folder option.
> - "opens git up to export limitations" may not be a great reason to
> avoid the same. what other export limitations and CVEs are limiting
> the need?
> - symmetrical encryption: i am recommending a personal user provided
> or default salt or key based based encryption for the .git folder
> - you may wish to take feedback for the organization using git-scm in
> their organizations. a bug bounty has been raised for gitlab, github,
> and atlassian that are the most rigorous for the number of users in
> the domain. i can also raise a bug bounty to azure, aws, google,
> oracle, and other networked providers if needed shamelessly to get
> this feature enabled (probably using an option to encrypt .git folder
> while creating a repository)
>
> "Have you explored using disk-level encryption to solve this?  While I
> understand your
> objective to "encrypt anything that might have data in it", there are sol=
utions
> independent of git what would cover most use cases. The problem with addi=
ng
> symmetrical encryption to git is that it opens git up to export limitatio=
ns and
> related CVEs. It would also cause adoption issues with many organizations
> who may have restrictions on whatever techniques git adopts to solve this=
.
> My preferential solution is using COTS hardware encryption to solve prote=
cting
> data-at-rest content.
>
> Regards,
> Ganesh
>
> On Wed, Dec 25, 2024 at 12:01=E2=80=AFPM Krishnamurthy Ganesh B
> <ganeshsurfs@gmail.com> wrote:
> >
> > hello,
> >
> > [apologies, not sure why my emails are bouncing due to the html version=
 even when sent as text].
> >
> > @randall (i am sure we may have interacted before or probably same name=
 someone else): my answers for your quote below:
> >
> > - disk encryption has nothing to do with .git storage. local access by =
access provided users will always be there.
> > - disk encryption solves the challenge of modification access in the se=
rver by devops professionals not manipulation intent
> > - disk encryption solves the challenge of modification access in the se=
rver by devops professionals not any code injection and remote incorrectly =
executed issues
> > - disk encryption solves the challenge of modification access in the se=
rver by devops professionals not any code injection and automated code driv=
e incorrectly executed issues and access to memory and or .git folder when =
appropriate chmod rights are provided
> > - "opens git up to export limitations" may not be a great reason to avo=
id for the same. the object folder inside .git seems encoded if not a binar=
y store and can be reverse engineered via code
> > - "opens git up to export limitations" may not be a great reason to avo=
id the same. load issues for speed are not that great reason when tmp cache=
 options can be a viable option. probably, you can work with optionally enc=
rypt the .git folder option.
> > - "opens git up to export limitations" may not be a great reason to avo=
id the same. what other export limitations and CVEs are limiting the need?
> > - symmetrical encryption: i am recommending a personal user provided or=
 default salt or key based based encryption for the .git folder
> > - you may wish to take feedback for the organization using git-scm in t=
heir organizations. a bug bounty has been raised for gitlab, github, and at=
lassian that are the most rigorous for the number of users in the domain. i=
 can also raise a bug bounty to azure, aws, google, oracle, and other netwo=
rked providers if needed shamelessly to get this feature enabled (probably =
using an option to encrypt .git folder while creating a repository)
> >
> > "Have you explored using disk-level encryption to solve this?  While I =
understand your
> > objective to "encrypt anything that might have data in it", there are s=
olutions
> > independent of git what would cover most use cases. The problem with ad=
ding
> > symmetrical encryption to git is that it opens git up to export limitat=
ions and
> > related CVEs. It would also cause adoption issues with many organizatio=
ns
> > who may have restrictions on whatever techniques git adopts to solve th=
is.
> > My preferential solution is using COTS hardware encryption to solve pro=
tecting
> > data-at-rest content.
> >
> > Regards,
> > Ganesh
> >
> >
> > On Mon, Dec 23, 2024 at 7:58=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> > >
> > > On December 23, 2024 7:04 AM, Krishnamurthy Ganesh B wrote:
> > > >i am raising a git security red flag on the.git metadata files stori=
ng git logs, commits,
> > > >and other metadata inside .git folder not encrypted using a two way =
salt or some
> > > >other way like using a key for a two way encryption or some method o=
f software
> > > >encryption internally if / because the .git folder metadata is not e=
ncrypted.
> > > >
> > > >this has been raised to github before but will be raised again via h=
ackerone security
> > > >bug and to gitlab and altassian and other git repository source user=
s if they are
> > > >using their own internal modified sources.
> > > >
> > > >most of the errors like these will be directly closed.
> > > >
> > > >https://kondukto.io/blog/git-scm-affected-by-cve-2024-32002
> > > >
> > > >https://socradar.io/critical-security-updates-for-git-scm-cve-2024-3=
2002-cve-
> > > >2024-32004-lead-to-rce/
> > > >
> > > >https://stackoverflow.com/questions/45578579/what-file-metadata-is-
> > > >preserved-by-git
> > > >
> > > >even packages like git-crypt do not encrypt metadata.
> > > >https://github.com/AGWA/git-crypt
> > >
> > > Have you explored using disk-level encryption to solve this?  While I=
 understand your
> > > objective to "encrypt anything that might have data in it", there are=
 solutions
> > > independent of git what would cover most use cases. The problem with =
adding
> > > symmetrical encryption to git is that it opens git up to export limit=
ations and
> > > related CVEs. It would also cause adoption issues with many organizat=
ions
> > > who may have restrictions on whatever techniques git adopts to solve =
this.
> > > My preferential solution is using COTS hardware encryption to solve p=
rotecting
> > > data-at-rest content.
> > >
> > > --Randall
> > >
> >
> >
