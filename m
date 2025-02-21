Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358717CA17
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174621; cv=none; b=PtnEpIkWhuQX41CmD/jzXjKldEC75+DlO1/90JS4jLrXO5+t5b95UomRS7tGyRgnFw+Ymqaby/Jw9TWKJOzZkwZdUC941LkeCFWKwQcbDOxDmKcfxvLOMuFrnABCf8V7VO4lM+63JcQOTsAs/Wd8xrTml5gaTxr3Las7SXnUrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174621; c=relaxed/simple;
	bh=Oer7DiWTTne/lXlK+BOnm5zBzbtraGURLiorQpDTEqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzTHrW1pCHFetoUqeHk61kVPXov2I95+G+F11GfR7T/u2IAusMk8BiaoFj0KrAL47JW8JmG70qejrmyq4yBgZiLm4FT23VQ5djECN9Vj4VGQ8Fu22SqzGEEJdeL/KfD5Y6hmEqfYiNL9fz+2oqSH8CqyqWE+jBaw5fdjruPPplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljpb9QqY; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljpb9QqY"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so19791805ab.0
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740174618; x=1740779418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkVdNJbuTKqX+WAVqFC1UcEJCTGe2IJp9TgKLXAKnV4=;
        b=ljpb9QqYTn5u4Mn9deiJxcrGME22/j2P+/NPJQ5R9L3I8cYxLdNdpYmmj/HF8hPw8Z
         aWLET8UF74NnGqEnsqGD+1fcc9t8rbXAwgEvf5YrbyW3bLNC3I54WN6bRWDrxIoorZ0j
         OkpJ7H3JuIK9SuyvBdt+yKpoGEwzkcR9pBQSk1d5E86UmT4U60ZpH7tTlgGHI0YDyPGc
         Y9WW1NseApRgvETyRK7C67UY4kGJFk+skUJpw1fwrz8Ynvr6a9VMYBHCfi5SbvNSXbDa
         fcu5mqnpSG+DNsz6NIsRFGEbpX2pRbVvP+Tuys3juOs+2v0jH8o4rP6klsrtJaIkDg7s
         0rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740174618; x=1740779418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkVdNJbuTKqX+WAVqFC1UcEJCTGe2IJp9TgKLXAKnV4=;
        b=GRa8XamtW5xoCJsDlvsu1DuxW+qYqKIxHLNs4bwgxhWehQjZpAItDvtwsNmyyZuPDr
         mOaREekpVtJ5wz09TGioelGzXPDOX8yxRYsSMmjBEGo74igH9uhf7h59fh6Nsf2blwpL
         kfB6EyaKV4C5pFzFIXV9mRydXfGiCZSaEs8CsWj64Oc8BHVdI83tA4pkjHPIhNw3ArQd
         T7bu8zPDikzB1dXSGWcqexx5cXPbBHT9ItsGYTgrUB7ggVCzFgRTPZQrpuLsNBeQKz4L
         QzuEUs3fGYGb9dOGM6LCzU6FlMkz4PMwLEjsaia4KEpQ949BvJAMaBMqWXFtyVswNCI/
         ycug==
X-Forwarded-Encrypted: i=1; AJvYcCWfCx/90UKe+DmQc0rFtdgiizSnDgf3PhStRM7TaIts7s+pCNNQawGB4xuAjJQ9VSFHBsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcRN2MAXmJNSi9ijHGHCNCVBGQ+Xdq5sB+pD4wFRSICmAtYL9
	xHOKS6bbdtG2MjEFESKXGih17VLDH4+jQ9rAnOA3rJJ0DZ5KutND13pSrgivGOPgkmCRIrRyt4z
	hJdWmjn59tkG9aAa25zW+R6YJLlk=
X-Gm-Gg: ASbGncsqhTvf/yLKWhDmuXR4LNXkRWMwVCGVb/O9g0/c9ECAc5NeljJM/x77rhDDr3/
	Ls7Bd7EPosU4c/QRUDFEw0IfEXpyjWBiB3aaXLSygP+RmTrC3ZpPZOsflEIoGMG5FFmq2lzIa1a
	Jl1SUyWZ+ZfVVeBPSwSwq+2HX/F9lKtUMX5i2suqdG
X-Google-Smtp-Source: AGHT+IEpe1dB5uWcJuZPyedXQaHxseg6rKmXJlsWAE3udrNxe2po8CWuRi3F8Ayat3050NZqSJT4FAS6cLwO3F6UOFg=
X-Received: by 2002:a05:6e02:12e8:b0:3d2:aa73:7b65 with SMTP id
 e9e14a558f8ab-3d2cae699b6mr48807545ab.6.1740174618259; Fri, 21 Feb 2025
 13:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
 <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net> <20250221-intrepid-furry-wapiti-eebff0@lemur>
In-Reply-To: <20250221-intrepid-furry-wapiti-eebff0@lemur>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 21 Feb 2025 13:50:06 -0800
X-Gm-Features: AWEUYZnBevswXuNwI2bopic8-1sbYgbhGfH2r5BAUUDRA19gGWSZ02Mpup-bMMM
Message-ID: <CABPp-BG7eLXtHk-r3svmaipOrMjM8oOEUEJ9CRjBUjUQjKC6sA@mail.gmail.com>
Subject: Re: Deleting first commits; maintaining last commits
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:18=E2=80=AFAM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Fri, Feb 21, 2025 at 12:18:09AM +0000, brian m. carlson wrote:
> > > My Git repository on GitHub <https://github.com/espindula/br-blfs> ha=
s
> > > about 23,500 commits. However, there are several old (before Feb, 28
> > > 2022) commits I would like to delete and maintain the newer ones
> > > (after Feb, 28 2022). So, Is there any Git command (or combined
> > > commands) I could use?
> >
> > No, Git doesn't offer such a thing.  Due to the use of cryptographic
> > hashes used, it would be impossible to verify the integrity of the
> > repository if it could just be truncated like that.  In addition, the
> > goal of Git as a version control system is to track history, not to
> > destroy it.
> >
> > However, if the concern is size and not something else (like removing
> > personal information), then you could use a shallow clone to just
> > download a certain number of revisions and work on that.  The full
> > history would remain on the server, and you could still push newer
> > changes, but the size on your local machine would be smaller.  If you
> > need more history, you could use a partial clone instead if you're
> > willing to be online to work.
>
> Another approach is to create a new repository and use a graft/replacemen=
t
> commit to indicate that history continues in a different repository, righ=
t? I
> do sometimes wish this was a bit easier/more accessible to perform, becau=
se
> that would allow creating "epochs" for very large repos. Unfortunately,
> shallow clones tend to be very heavy on the server-side.

I'm totally in support of the "friends don't let friends use
shallow-clones" point of view, even if I've had rather less success
than I would have liked at promoting it.  But throwing shade at
shallow clones is just an impulse, not the real reason I'm responding
here.

Yes, if you're willing to rewrite history, invalidating all hashes and
rewriting the recent-enough-ones-that-you-still-want-to-keep, you can
go that route too.  In fact, doing so is as easy as creating a replace
ref graft (or grafts) which make the oldest commit(s) you want to keep
look parentless, and then rewriting history to make that graft
permanent and remove the graft.  (Afterwards, you can make a separate
graft from that new root commit to the original real commit if you
want.)

It turns out this is an example from user filed issues that comes up
occasionally in git-filter-repo.  While it's an example I documented
with the commands to run, just so I can link to it if it's asked
again, I really don't like the strategy of destroying history,
especially since most users who ask for this kind of capability
(Konstantin, you're a notable exception here) don't understand the
points that brian brought up in his first paragraph.  And I make sure
to say as much right before I provide the example in my docs.  But,
yes, this is a possibility for those that don't mind destroying
history.
