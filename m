Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1414532A
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711924059; cv=none; b=ffhoDzTqIU3W+X9weHI0gymXW6HHBo/21sUbibGCydudp/aq7Vy3NmEaFuHNwIEev6pqCg4PSEtlNgCpWlNdOoUCSu2l1naXEkGF91mc9VKJsasNkm6HTGGTzSHW/dR5vQUkskB4zd/qJALMsAmVGJa2wS/5IqBC1Phwa04gtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711924059; c=relaxed/simple;
	bh=JWrJ5wCzwBoq6qv6NmGmbWY974Mir5cqaj0SPDrhFdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgECYCc8moybthmjagKtYpLrgC9XlmJVAk/GRX8k8LQeP5Hq+thX2zYuUqGxffQ3BFCjZw0YhbnOLXxPapijmj1ojVHuqAs3lytOWa3CjJj0Lf1bPIpNBXbv2S52rqe5fg8gXJ5vB0RVoy7DTZ7bRBDHw/n62xAEQP5eAhZGERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5X+YVpC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5X+YVpC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56bc8cfc19fso3704446a12.1
        for <git@vger.kernel.org>; Sun, 31 Mar 2024 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711924056; x=1712528856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrS3O25xtiqQXozIELIwNWzEmEY9o5tKOXmnawrR/Ek=;
        b=V5X+YVpCvMl9GOSmEd2Se3dfk5/6gGUyA6zqlUWHqpNzWY1Sl0WN9k69xFoK3kXKYS
         MLbkPeU6Sc9y+iWHlWzW8lbMQTLKmtszDPCN5Nmw3bN0RimuvzRh6m7vS7EoqmNbLzGB
         BzRtnGaSqvJJNpSVBfm5YpovSZSjCC+my+GaAR1JJ4h0mExb9ojkXKTm/Hzx0KkesfhY
         kcnqUQYyc8GMzm6jNfUvvA089osoO5/ruRDtHwXvi1mKjs/hz+RV/jmCNBFIKfHBlef0
         D9anQtpIM+w7AlR3h6H8hYhp8alHBMTU8lur9/sjc7bAraVKg3lnxDKh0X3GbIzRKKyG
         /XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711924056; x=1712528856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrS3O25xtiqQXozIELIwNWzEmEY9o5tKOXmnawrR/Ek=;
        b=Dyp5BRAoRL6tGtL6/xF/0udR8DDig/DeITfY7qo3+1eLmuVqhqSs9+qOjTEg7dBBuU
         iCNxHw4sAy6Q2ZHAvrBtaWE0KVdrfpTbBO+4bFn9gZZ2BcmQ6hpp/Lr8+RRUvPvOwQEE
         N0YkWId2gt9Omhz5g8GxXS6BLu6bcwZvpgcPCgG9Sl5T91byCZ4oz9N1TWdBHQegO2A0
         YTcE18b9XFi00BvanYoReQNaOar2r4srtqUGTfx4H7RRftvafazmfIA2r6yhEucMTpFc
         MdXi3YZ+yxq3CiQzp/8E8R9NlLIHHCXz3jfL9PoxpicXmM41yJFivrrQWZlSidZWmim3
         kGiw==
X-Forwarded-Encrypted: i=1; AJvYcCXopU/9jzTRbMq++MejgN5KuIqfOXXy0S9gboqNvgaXRL900va7p9k8ScyhdLxnLdxUXG+Emp21zaMR0O+ZPI1cdlTE
X-Gm-Message-State: AOJu0YzX8/4/xUdZg7ReQu05QDSPo3foadhn7GICqir3IWUJ8ykNyM4Y
	ukK0Kxl3q5oaLBzrhHUVPhOJlzqh5QELeZhWU8DI9RknLAf8Yah3jsZPhQRh2lsUpILr0JitOJX
	SDWgvjvzUnDoD50m3H0ihY8192u0=
X-Google-Smtp-Source: AGHT+IF6/PstFXLR2godX0e2muPeOMGky7O9pC5zG+0NQX6Q7IyImdpw+LUjVqV6pgkqvQLL0ykclf863Wgk8hpIn20=
X-Received: by 2002:a50:8d0c:0:b0:56a:ae8a:acc0 with SMTP id
 s12-20020a508d0c000000b0056aae8aacc0mr4823175eds.21.1711924055707; Sun, 31
 Mar 2024 15:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330224623.579457-1-knayak@gitlab.com> <20240330224623.579457-8-knayak@gitlab.com>
 <xmqqy19yf40l.fsf@gitster.g>
In-Reply-To: <xmqqy19yf40l.fsf@gitster.g>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 31 Mar 2024 15:27:24 -0700
Message-ID: <CAPx1GvdXdH3OdY1nC2ijVSdpWfg8jn5=j0KB+Wgv70wWeCNH5g@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 3:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> ... we are giving to "update-symref" is not an object name, but a
> refname (i.e. the target of the symref at <ref> points at), so
> "newvalue" -> "new-ref" or something is needed.

I kept this line just to say, I agree on all of the above ...

> Existing "update" command can be used to create (by having "zero"
> <old-oid>) and to delete (by having "zero" <new-oid>), but we still
> have "create" and "delete" separately.  Given that we are teaching
> the command to also work with symrefs by adding command(s) for
> symrefs to an existing vocabulary, we should offer "create-symref"
> and "delete-symref" for consistency between refs and symrefs.

.. and on this, but:

> It probably is a good idea to allow "update-symref" to also create
> and delete a symref in similar ways with the existing "update"
> allows creation and deletion of a ref.  An "zero" <old-ref> may be
> an update that can happen only when the <ref> does not exist, i.e.,
> creation, and an "zero" <new-ref> may be an update that makes <ref>
> disappear.
>
> "zero" value in the context of refs is a 0{40} object name (side
> note: we have an explicit mention of 40 in the doc, which needs to
> be updated eventually, probably outside this series).  But in the
> new context of symrefs, a safe "zero" value needs to be picked
> carefully.  An empty string may not work well syntactically
> especially in the `-z` format, because you cannot tell if
>
>         update-symref NUL HEAD NUL refs/heads/main NUL NUL
>
> wants to say that <old-ref> is an empty string, or if it is missing.

For these reasons, I'd suggest that the all-zero hash be officially
deprecated in favor of create/delete and of course create-symref
and delete-symref. Of course, compatibility requires some sort
of support for the old system for some time.  As to whether that
means something like the suggestion of ".missing" etc, I have no
particular opinion -- but since the symref options are new, they
would not *need* symmetric options, if we just say that "update-symref"
cannot create or delete a symref.

Meanwhile, for testing purposes I was curious as to what happens
if you ask `git update-ref` to delete an existing symref, so after
creating a test repository:

$ git branch
* main
  symref -> main
$ git update-ref --stdin
delete refs/heads/symref
$ git branch

Whoops, this doesn't look good...

Restoring the branch name (I had saved the hash ID Just In Case):

$ echo d88ee82e6a5c29c95f712030f5efc9d43116ae79 > .git/refs/heads/main

brings things back, after which this works properly:

$ git branch -d symref
Deleted branch symref (was refs/heads/main).
$ git branch
* main

If this (deleting the target of the symref when using "delete")
is a bug, and I think it is, that's a separate topic of course...

Chris
