Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86878836
	for <git@vger.kernel.org>; Wed, 25 Dec 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735108479; cv=none; b=oZE5fHENIU9VoIQaUSJH7g+wCiHoLo7Eghs9daYz7ycC+LQq7UBQX8EWocqjpJAcGOKxTO9Bx93Ya+9icmZF2UWk5dq9Gts07w1sQxs00rwHtCCAQkXEGmTY0ei94tzya6W6uFQg9qridSFZwY8XQG9lYbT7Dnj312yssUKA+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735108479; c=relaxed/simple;
	bh=hGq6S/RBplRhDpDvW28g2y8XCQb2bOsFlBzn7YF7Qzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzqYcrcxJwJYR+xAYi1zgH0PQI4ks7qzRV6/3NfpV8G19VJ+bDgoDuwDWOjA12axYkcryfSiO+eVx/j1KXbQAKWHmB1x2rnY4y5Ue/JgT3QO6uZgb/Bq/0MxOnDyZ93ST2bExuKcYXQ2nYfz7vm3x9gCTGVYnoFD93x/hDw1DzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmSUESS5; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmSUESS5"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ab29214f45so18636685ab.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 22:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735108477; x=1735713277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPrxZChLyCDxKUtiREEd1l6NnFdPIF39NEGxonfTsCU=;
        b=RmSUESS5lglavbAIcnh65jwaA42TVhHgUwGVtsoq0tovqc5DSW3iZn+WeyHD53A09w
         4tfK+HS9xli1e+Ja6N4nOTef8pommVfF/Izpt4Qnw6XY6THJUrqAhpGecWM0uj6sHksB
         BprIilvOcXE4cnC/aWC2MHWflWjiY1IiBCJF+UeAI6yJkEQD/EdyEmvXldWhKizEXZft
         IhV3zkDpeVSiUj2e5VXpTdZfMDyJZTsj6ht7OGx4wJ5EMb7LIbfi+cT3EI3SEpLE2SjB
         clHBYXI/++YSbcO48XMwryHoeyvvbF1Ce8RfpubmUuu5Vlvq2Nvg4JxijVKuFxoTxknC
         gxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735108477; x=1735713277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPrxZChLyCDxKUtiREEd1l6NnFdPIF39NEGxonfTsCU=;
        b=d6vgJgdtDT9f5sPCCobdLQh+GC1bZhgmNiJUjgCdK17G8rx59WGCd9oU5+hByN66bw
         FW/s1L6dpdN9LtQATEWT5n6xX0baedh4enOHTGFdwc0x0VeeNXtrX27u0IH85k/1MvyK
         WGj4LmX9oKOFV1H6xI7US+WN4WFj7i+KeJLKeVCDeLFYLpSnCZaTozWSM26v3zck1fVb
         qHJJ8qohrVFlkgG6hX97X436kphMwX7NqLBt6Dn+rqasj4Pvbxw5LVjfdiy/9LFhkCcg
         80gI8DHoyofALKjlN9/peF1qsCJ56R3Eu9mB4qz3FnJsGTTHGQS8legBWtwQ7Nfhyzcq
         KxJQ==
X-Gm-Message-State: AOJu0YzHxzd2gs4PVMjaNCEIVnpf6GfruGXBnpLgpzCV8k+ayHWppzoL
	8QBx+dRiHxZ3OlrZeclIvMQPzkILDAC5ngOfECspuSCCACkUn2+wY6MBRytp3YJ8GI/+gip3Jc5
	IHjDra4e4ab9Vr5kztw+3hpzFCWpcl4x0
X-Gm-Gg: ASbGnctJHMBA6v8rpMjBrYXlHbXDiXlF0A3aOQ4UgbuOD++fXZ+E20jkSXNEgYDD6Ch
	a6ux8JkCJV1Mhmk7NGk4vwkNP0eLIHh9QVlwj0E0=
X-Google-Smtp-Source: AGHT+IFKszg7GaTWwzr6fByVWNqVqcHxjqn7i17E5azHGGo3xzsg/keDJM4Mr3Y0A362XlfRXXQOYA1AToY+KAEbmKQ=
X-Received: by 2002:a05:6e02:b24:b0:3a7:8270:3e69 with SMTP id
 e9e14a558f8ab-3c2d514ff6cmr170964245ab.15.1735108476867; Tue, 24 Dec 2024
 22:34:36 -0800 (PST)
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
In-Reply-To: <CAMmT1pLszvmQN06eUdnhZHpqDLrF2aaXFxdniumLt1x9MSdKfQ@mail.gmail.com>
From: Krishnamurthy Ganesh B <ganeshsurfs@gmail.com>
Date: Wed, 25 Dec 2024 12:04:26 +0530
Message-ID: <CAMmT1pJpKct+zV_WV_QXKCL_A0cGURNbKZDKGzbATCDN3cQDsw@mail.gmail.com>
Subject: Re: [bug] encryption of metadata in .git metadata file inside .git folder
To: git-security@googlegroups.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

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
understand your
objective to "encrypt anything that might have data in it", there are solut=
ions
independent of git what would cover most use cases. The problem with adding
symmetrical encryption to git is that it opens git up to export limitations=
 and
related CVEs. It would also cause adoption issues with many organizations
who may have restrictions on whatever techniques git adopts to solve this.
My preferential solution is using COTS hardware encryption to solve protect=
ing
data-at-rest content.

Regards,
Ganesh

On Wed, Dec 25, 2024 at 12:01=E2=80=AFPM Krishnamurthy Ganesh B
<ganeshsurfs@gmail.com> wrote:
>
> hello,
>
> [apologies, not sure why my emails are bouncing due to the html version e=
ven when sent as text].
>
> @randall (i am sure we may have interacted before or probably same name s=
omeone else): my answers for your quote below:
>
> - disk encryption has nothing to do with .git storage. local access by ac=
cess provided users will always be there.
> - disk encryption solves the challenge of modification access in the serv=
er by devops professionals not manipulation intent
> - disk encryption solves the challenge of modification access in the serv=
er by devops professionals not any code injection and remote incorrectly ex=
ecuted issues
> - disk encryption solves the challenge of modification access in the serv=
er by devops professionals not any code injection and automated code drive =
incorrectly executed issues and access to memory and or .git folder when ap=
propriate chmod rights are provided
> - "opens git up to export limitations" may not be a great reason to avoid=
 for the same. the object folder inside .git seems encoded if not a binary =
store and can be reverse engineered via code
> - "opens git up to export limitations" may not be a great reason to avoid=
 the same. load issues for speed are not that great reason when tmp cache o=
ptions can be a viable option. probably, you can work with optionally encry=
pt the .git folder option.
> - "opens git up to export limitations" may not be a great reason to avoid=
 the same. what other export limitations and CVEs are limiting the need?
> - symmetrical encryption: i am recommending a personal user provided or d=
efault salt or key based based encryption for the .git folder
> - you may wish to take feedback for the organization using git-scm in the=
ir organizations. a bug bounty has been raised for gitlab, github, and atla=
ssian that are the most rigorous for the number of users in the domain. i c=
an also raise a bug bounty to azure, aws, google, oracle, and other network=
ed providers if needed shamelessly to get this feature enabled (probably us=
ing an option to encrypt .git folder while creating a repository)
>
> "Have you explored using disk-level encryption to solve this?  While I un=
derstand your
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
>
> On Mon, Dec 23, 2024 at 7:58=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
> > On December 23, 2024 7:04 AM, Krishnamurthy Ganesh B wrote:
> > >i am raising a git security red flag on the.git metadata files storing=
 git logs, commits,
> > >and other metadata inside .git folder not encrypted using a two way sa=
lt or some
> > >other way like using a key for a two way encryption or some method of =
software
> > >encryption internally if / because the .git folder metadata is not enc=
rypted.
> > >
> > >this has been raised to github before but will be raised again via hac=
kerone security
> > >bug and to gitlab and altassian and other git repository source users =
if they are
> > >using their own internal modified sources.
> > >
> > >most of the errors like these will be directly closed.
> > >
> > >https://kondukto.io/blog/git-scm-affected-by-cve-2024-32002
> > >
> > >https://socradar.io/critical-security-updates-for-git-scm-cve-2024-320=
02-cve-
> > >2024-32004-lead-to-rce/
> > >
> > >https://stackoverflow.com/questions/45578579/what-file-metadata-is-
> > >preserved-by-git
> > >
> > >even packages like git-crypt do not encrypt metadata.
> > >https://github.com/AGWA/git-crypt
> >
> > Have you explored using disk-level encryption to solve this?  While I u=
nderstand your
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
> > --Randall
> >
>
>
