Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08E22126A
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910147; cv=none; b=HdYD9C6PPKQ5IP8H4+A3cIyqoPNtPhzwXeLCAULHs3sBgtDFAJ6xxjDxSTMuHvbyicqm/abt/KrjteHEPEQvNkLw1+Nca42x1qUYHg9CvF6lig1Fk/C4UN2PRjOMD+sSiaBPpgfu0o4I62ETw3UtTFJdnAVb2hS30qIKFch+W2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910147; c=relaxed/simple;
	bh=1M/nEQ4+TCi2eTFldLVo5TNMGaQ5DsWCHs4l6AaQBWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHmaOyjA5bY2Ey2mtmXkNZqRjOOqvubu4jkX219pgXZpYz1hzv/pWG9wNaRrnjbDraMrnuYF6a0ZEXIxzirlgAHHPmQhd0Qj/f4jvEb7LriAcxkjE8Y2FqCJDB24xHwZsYnnMDpxtZ1Xkix1FG5eMXeU66cAx6a0wNQSgQZJ3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6H9VAYG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6H9VAYG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso298540a12.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753910143; x=1754514943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqOyBRdFv3LXfuIbcYFjQKvotIEBDOKaIQ3YrVmeApI=;
        b=B6H9VAYG/rX/XYYJv2xMepDcR/hvdc6Uuzl/2tCyfcJsfn+l85Zbn4y2yATFZoJPu+
         OYKW5uYgObVwkGkAAUp6M6n3syNsAnAnIjQxVyKVAYfjdvIVkKWBhl/o9pP0jf1yeLO3
         OyPquIe7idVjAFchMgfz6yQwvpvGwbbOK/QMfdBioTpLEotB/oZMAQIsvfEiTq/h04/H
         A2C/Z1zSXdm7vihPEcWBjKP1bhTlFZ7EDvB8NwYIMWozLL7RpBrzhCSKuhBJRCQhuxaj
         sZWhS+asnznJoDdEtBSsvjpX+C5plJ95OxGGdsbvyPXLP1G2jSV3aGG2u1IkwtXqycly
         QhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910143; x=1754514943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqOyBRdFv3LXfuIbcYFjQKvotIEBDOKaIQ3YrVmeApI=;
        b=mpX4Vq8vwmT0QeWbF+OsF7xlpzo+Q9w2Om28r9+R3aXxTHIHOVOz5YBS70VDTbCDVx
         a2gIZDeaXbYxBrVMLCPINF3AlhAhRXEjXAlmF7MiwfZluVuRdHS2j++5zmt4umuX7FqN
         P4QtxECvRFBLDnJ6Gb0LL3PkHL/g9+LuM2OtmmpJxqGZre1ioXuVVWz+KDd1EKNxV1HT
         EBJz8x6pjaD+eqzeOg9evb9anZafOIaUpqz1zW8zNAFhZ9pAsRgP683ujeUacXLvtVSp
         GPtSBcpQzcb+ipD+AKahMGIfA/z7/uFr6b8iNzarZZ0/xtdtb7xUeF11FdMyEIL7LmUz
         M16Q==
X-Gm-Message-State: AOJu0YzpMbOC600PKGtzxIdO3/Dd898QSOhVp3zmFZ2YE97RtmiC5Mfw
	qSXCtyU9+dbtUVftGNPtUTRbXYJ/ltA2GmHXnY1KzwOzhq8EkuJgNRpeHANL0h3p9V6mV975+LZ
	z598QEY81me5o8Xg2Zccu3XGjdJohoHl8Tewy
X-Gm-Gg: ASbGnctUur4j4WaUou8KrEQlSOtbKfx4BNf+NoOu9KXFDs3m0bDhSOX10XHJVabnE7W
	ihzX8Ht7ko32EB8BAzy6Sgm0TCkxqK1qwSizvP5efbPub6kKCcOXChbXTtT6dIhpPzKs5NJ3T7+
	YcUpShDMVkYi+RQ3Wad1bxkz+cVPsbhEan9MZRu9mnVAIVuG6nB72zYbGuFeG7X5EnQs5RqpLMU
	t0igpkmxH4pIqGzOpeLPCRKf/xwooIkpiMiVxUwUg==
X-Google-Smtp-Source: AGHT+IEageXGfYzVyYK7N6twfuIXeEs+MCb8aXtKC1uPRT6csDyRzT4GXkWKyVxl8P3Ib0Ozrzv6AIg8bBbU3YNdSnw=
X-Received: by 2002:a17:907:3f1b:b0:af1:8be4:768 with SMTP id
 a640c23a62f3a-af8fd680fd2mr571147866b.5.1753910143363; Wed, 30 Jul 2025
 14:15:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
 <CAPSxiM_sP7MG5SDLe-_-FULhqmW10M=8Ssu3PMoZD8=rS6CkAA@mail.gmail.com>
In-Reply-To: <CAPSxiM_sP7MG5SDLe-_-FULhqmW10M=8Ssu3PMoZD8=rS6CkAA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 30 Jul 2025 17:15:32 -0400
X-Gm-Features: Ac12FXyO4DgmFy9x-G4K7FoEsQtMC5ZkQI8ZGuydGvKO7MEq1Bi60KC873cScWk
Message-ID: <CALnO6CBB6AR+PKVveyB0oo0Ax3cFqZ-AAs7o0oo+n9doyJL8KA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:51=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> > > +for cmd in $(git --list-cmds=3Dmain)
> > > +do
> > > +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> > > +       case "$cmd" in
> > > +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon=
 | \
> > > +       difftool--helper | filter-branch | fsck-objects | get-tar-com=
mit-id | \
> > > +       http-backend | http-fetch | http-push | init-db | instaweb.sh=
 | \
> > > +       merge-octopus | merge-one-file | merge-resolve | mergetool | =
\
> > > +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | rem=
ote-ftps | \
> > > +       remote-http | remote-https | replay | request-pull | send-ema=
il | \
> > > +       sh-i18n--envsubst | shell | show | stage | submodule | svn | =
\
> > > +       upload-archive--writer | upload-pack | web--browse | whatchan=
ged)
> >
> > Sorry, one more thing: I spot-checked a few of these, and it seems the
> > main issue that causes failures is the exit code; they seem to work
> > with "-h" outside a repo. Out of scope for this series, but something
> > worth tidying up as #leftoverbits ?
> >
> You meant the exit code of 129 right ?

Yep: some of our commands (often the ones implemented as scripts?)
don't exit 129. Fixing that is certainly out-of-scope for this
otherwise-tightly focused series.

--=20
D. Ben Knoble
