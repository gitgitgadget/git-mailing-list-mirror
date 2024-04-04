Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B32E62E
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213098; cv=none; b=cFBq74H1OBqR1uZSdV02+PnZ9B32NUo2WH1P8HLJRAxVcOkiIxCksfhPtMCug41jEnf3bRoVRXwchOQNJv5IQZncHUq0pGnw7EeNEhK7K3zgOJNgCkYuylHa6pqfuxFBdkGJgehsZrZNORnj8uaTKX2GgNK8EY7VnXPnUUaIfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213098; c=relaxed/simple;
	bh=dsh4gIawG/amb64PnkfO4RRfuESY0/pGcXbarFyxMYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDMPh+Ya0APmorWPnndxFA+ryCT+leph7/bprUJTSst9hEu6ioELkx4q4hfD1cY2kZAjyTbXs+rhruIA71GA0xeAv7NtGMaMM4w8nj0ZERxjUYXsdLO4TPBaQbclcN3hMEzqmbVaR1kPVVAZDkDJOAGzzfL88mN8ryc0BFIc0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjbyr3dC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjbyr3dC"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so569619a12.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 23:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712213096; x=1712817896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XBYOvvdfSPjCzXCek+wd8/sNnEQrLYOOqSnAr2C398=;
        b=Mjbyr3dCUIe176+pSUSNbvK+Rmrnl85vmhe92aAmc1OMgVwDvzKUrLvbt5T64oOxKF
         /W1vm93fxqtcT7TVuwCc5YivBw7zglvGP6YwFTa5n9N6GNhOVoOd6ZkhMmUJGCVBe9Fe
         9Ndh+iQYZA5mq1NXsASi26rHNjR5BadDFj+DUbRfETUzjoQwC6poeoQqaGFrB68kBEVq
         z6WbooXLFBRZGAKiGl0POcqKUEiqRDZV391Z6aANc9fe2fH0Hurczbmk+Dx26nTBKw/1
         6qe5CSufBEkmrRYfrekeyul3ychwqBEMVumQWpg5KHngb2zYWsUBVo+tfGU/4I/pHQ0p
         2scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712213096; x=1712817896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XBYOvvdfSPjCzXCek+wd8/sNnEQrLYOOqSnAr2C398=;
        b=JauoTXf+Ib/6bsLNY7mTuxExpo5lPVbsavLKaJmTn5DzigwTGVrzbWK7XFrapR+V9F
         PX0Uchoqf+oQ04FW5NFlPxyuSa093WTKUSokNYZq4ibNv2R73WqQ+HkvL6/0bIOXnMYY
         1X0p/gKyDmZ/Bl/hTW8Yl5GR0iAn0Yj2qk55hWYX0ONjIis66l1XCgxp+V8Anx9ywPNP
         XgQNjJ/Eft6K3rw7kLmAR5dJiUCIbrKzC/1yk77CX6S9RNSAgDizK19NcjDCfOCWeGx/
         TWmn7OSyFRczkIWjC2hccekTw82OB0kEcKXZYBqKTlN1XMuiK+ayN0AN00QjEWLJg64O
         sSjg==
X-Gm-Message-State: AOJu0YzI79sXCapCPdZfBhpDaCH8EM304KvmbXVmYgjJ9judCnf5y1en
	A0qNvBQIc3XIP3zPxbf4AYY9nqwOYIc0DXz0cqk684iXh0D5DIPlACqYPKjvI8szLBNNUUgQGR+
	T5HTtkskN9Xc9rqulp0jp/rDx/f4=
X-Google-Smtp-Source: AGHT+IHxcmzbCxwwPvVQ11c+i0mCUHIetqo23xtVYO9AOSuNMR1W7QMxcPQ9333k2mBQpglAg+rrk9Oq5I+fDKUqcSg=
X-Received: by 2002:a05:6a20:1059:b0:1a7:1695:2bf5 with SMTP id
 gt25-20020a056a20105900b001a716952bf5mr1546417pzc.60.1712213096267; Wed, 03
 Apr 2024 23:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki> <CAOw_e7Y_MwgrrJzuHk7tzBR9a2kDfTnwCzC-7_rgj8UJPKqp9g@mail.gmail.com>
 <Zg5HXZrL_4BsyzfG@tanuki>
In-Reply-To: <Zg5HXZrL_4BsyzfG@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 08:44:44 +0200
Message-ID: <CAOw_e7Zzc2uLX0FtkJ3fB+wuNJt5piMmoYVes+ayApe8BEN3+g@mail.gmail.com>
Subject: Re: reftable & jgit compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git <git@vger.kernel.org>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:23=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:

> > I think the easiest way to make this happen is if CGit would ship a
> > command to dump a raw reftable in a release soonish. Then JGit could
> > use that command to cross-check that a JGit-written reftable can be
> > read correctly by the CGit code.  By shipping just the dumper you
> > avoid having to wait for proper reftable support to land in git.
>
> You do realize that "proper reftable support" has already landed, right?

I had not realized this, and that's great news!

> So you can just use Git to create a reftable-enabled repository, write
> commits and then use JGit to access the whole repository instead of only
> checking a single table.

For testing, it's probably easier if you can work in terms of
individual tables (because that is where the complexity lies:
different blocksizes, restart frequencies, with index, without index,
with reflog, without reflog etc.), but one can create controlled
individual tables by creating a whole repo and then compacting it.
OTOH, this would necessitate exposing all writer options to the git
CLI, which is maybe a bit much.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
