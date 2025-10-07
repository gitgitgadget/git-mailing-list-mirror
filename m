Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729D71E25F9
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862408; cv=none; b=MOeEIUaYKV5hAlabMwRvvlEs9QiPTx5GNSaoTwnBmbMOFm616qPH6uFF55dnPA9EyoXpIwin+Ls79qwCMwS60nN1C8hm3XUcidB77+HsaD5Xa5xbqA0VwtrCJBWTe5MjT4GQe97hOQI3B4PrmHAvon7VQwFpozYJacyvtWeA7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862408; c=relaxed/simple;
	bh=ZFAt99uQYB05UPv+B2JL4md3H2/1iKrgXfXfHYfnur8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piy0rX6/kflBkuSVSdN3e1gBZFUFL7ct6kI6sTIKjQofL17U6C2GKSx9rt88MTlATYAZoFN1u7DcWaWf5r6tZgqYDjhnwsyqtndF1uVZIkOXHhHEABxhZectSMJCHft9LwK7LqrA+D01cp0npWbs1RNCLV9SehwebTsdPUech1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tpc/s9Md; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tpc/s9Md"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso10663010a12.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759862405; x=1760467205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N5bFzvim4llPInPMo4CbTSUSdWZLKq6v2yj6rC2npU=;
        b=Tpc/s9MdNPox0+UKTt79WU78MD0GoAf7//yLHpBnybcfS3cpEr/8AYX6UX45rJ1on1
         e47XQ+oeI18qxnqIYDtX45rN+5+UJ0wx7W7hEeSefrGDQ5cRhw+wA9Qs+Q6uA6ILb2sO
         DqHVeNBYCA4w7FEFfx/HpKfrpx8YfJY8V3BPqbM8X2VYLjHI1QWw+cwIEgHQLSm88hpg
         C/jRs80TIAiahT8RRuj8n4t9olnv/eTlv5bqrnCBO0yHpLzYBhwn3HmmRim1CobfSB7j
         dEncvxd/27Ct/W1cHOhorf+I5jW3EhUNg0mBJH2J8yyq0HO7absFcpSQe4prKIIZpBJH
         Ykkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862405; x=1760467205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N5bFzvim4llPInPMo4CbTSUSdWZLKq6v2yj6rC2npU=;
        b=Ek43YdkVWXt6pR8pizTvY/DgvIpXigWWXG5OhuXLTJr7GOevABjKD3+BXPKrzQqiH6
         wLq2PdwiCUUGPrqtH0WnaLSfu24WX97Qao11Q33oWcks4Si5AvoBGTF9Hfr3SJ2Oqyq4
         xf4aXbW1+WaT/qL31WA4Vt/t7RsnubqjFUFqE4AcSwBSxifwxd+WLKYmE1/YsC3IwD5s
         vEOiwfERvJ0kY6YU1YOa8GLstey1xIeGr/42tEODKzPC5OYqvETMeImHtVfTrx/TtbQe
         G1o3o8VHnuwHC0W2DZTO/Izjz7DBGwONGDZswnlfBdbMZKj4bj2ul0g6MGIfpAWKFT2+
         99dg==
X-Forwarded-Encrypted: i=1; AJvYcCV0jEMZy/ygQ5eRWbhJhQY4IBIooUIzv37Q0yN+JPEfIX8Byn3XC1TSc+uwNf2oX6RKqn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4NBRJFEUSvekArgAn+maVTawXT9V12vdmTEa9TIT5tCbUa7q
	+IHB1jcUQrXCNtmYbkpAbjWZN+NloBP24WAyS1dOGd4QyKq5fgsdmxmCqL8Nv2JcoeJQSxtqCb2
	A/0PFXEnllWcH2jgpPIaH496mSO5np6m2KgUQ
X-Gm-Gg: ASbGncsBQ+ELejOu1UsQsAik+aRZp4mxn3VsxdeVMvYT7GrfQzwKWxcLZLru22gDUbC
	gHQdvedrfN7dG67uG4pwcBUkYYiLRmf6vcTWkjYXUs0KPEM+Q1SHSp7UUghgLqxM/G8ob1tzH6o
	mJ4D1I62bXGO//PCsFfBwv63uXeJVxP+RJitDuQ0JZGl4Vi7i5Idgl/Ck7xUgP6nU6XcpzbaySq
	IuKwz58FY7lHUPYKKXwLpB86nAS3wJvPWm/Kw/3r6sEdH17DvXXLdIxCVFbCiHKFQ==
X-Google-Smtp-Source: AGHT+IHVnDCf8Iss/aKG6Rv7XATCAwZI0AuWEYCfZ5V1OefZgyBjlQk06pYvvee0qLauJ1tZ1E8h/4VXzcgNYqVdNww=
X-Received: by 2002:a05:6402:42c2:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-639d5c6f3admr385998a12.33.1759862404489; Tue, 07 Oct 2025
 11:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com> <aOUkZa4_fq1hho7Q@pks.im>
In-Reply-To: <aOUkZa4_fq1hho7Q@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 7 Oct 2025 14:39:52 -0400
X-Gm-Features: AS18NWBbI0ffbRkvFvLUHOj04KaonviP9mmRFQI2IkMuqyPZd9JBnf20Da-09eg
Message-ID: <CALnO6CDgB+yWoVv+eP4eNhVkVLw7hXb==1q3Ve+OnkZuERiYYw@mail.gmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 11:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 03, 2025 at 05:34:36PM +0000, Julia Evans via GitGitGadget wr=
ote:
[snip]
> > +    A branch is a name for a commit ID.
> > +    That commit is the latest commit on the branch.
> > +    Branches are stored in the `.git/refs/heads/` directory.
> > ++
> > +To get the history of commits on a branch, Git will start at the commi=
t
> > +ID the branch references, and then look at the commit's parent(s),
> > +the parent's parent, etc.
> > +
> > +[[tag]]
> > +tags: `.git/refs/tags/<name>`::
> > +    A tag is a name for a commit ID, tag object ID, or other object ID=
.
> > +    Tags are stored in the `refs/tags/` directory.
> > ++
> > +Even though branches and commits are both "a name for a commit ID", Gi=
t
> > +treats them very differently.
> > +Branches are expected to be regularly updated as you work on the branc=
h,
> > +but it's expected that a tag will never change after you create it.
>
> This sounds a bit like the user itself needs to update the branch. How
> about this instead:
>
>     Even though branches and commits are both "a name for a commit ID", G=
it
>     treats them very differently:
>
>         - Branches can be checked out directly. If so, creating a new
>           commit will automatically update the checked-out branch to
>           point to the new commit.
>
>         - Tags cannot be checked out directly and don't move when
>           creating a new commit. Instead, one can only check out the
>           commit that a branch points to. This is called "detached
>           HEAD", and the effect is that a new commit will not update

missing "the tag." ?
