Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD2149E16
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926780; cv=none; b=lFPfi+dU1pbyLnanYcvnMpoww3o73MXDrFL0bIzHENDKTHxu/5LLww4DkOWxwwFFQlGtq21iEer7kJ7oGxqWVuNFEr2oWCu7XNPpyh0dLoHVstR/5N0MEM4Cm1AVtcxjJPRw3TuVcnU6CMVY3BTJVnrz7qpYga/uM3E/Y47Ldf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926780; c=relaxed/simple;
	bh=Pn45tbBFMNhoQpi5nm/9gkDozki2TcB5VJLTwa6QtsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NLrHTihENOwqa+ppNectcRXQdKrwGtpdvQHnsfS09NzohPlQ3CpC5VilBuflT61RKSMNWeE70pWc56Mf8mEUWSNNUahUSA6/JHsJ24YNzglpYvRL9rd2nyRzfM7AdDYvzzGSXaeBJId3Q+oWk8rcknrsi4KOQDjWxXeu47sFffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U52fL8Xs; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U52fL8Xs"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-544fe4f254eso272231e87.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738926777; x=1739531577; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj+equ05YPpXeGHS5nkrYxKAkFKew+GcHvcSnIimXt8=;
        b=U52fL8Xsh6ZOJ/bXKIWZPulGGlCytNVrUylwd7rL/N432iuO2tWII6R7YqzL9KzQT+
         xnaXwokllF8c92gUyoYfa072EkAdgkNTIg2dG5QYquI+viNKhKy9KSVIpFh2YS7yxL9m
         sKG1MHk2jORJZvOTb/TMDvbgieBhAFt8veca+Rr1eY7C5t9QWibxyJHqM2G+K7LD38wb
         tMa9v+sObB0vurRkQtDrX5b0xxIE5H/jAyLPWqkurCvuc770Op1g8hGVPwoJmG26t1EM
         m6iaYaK8v60J/irfb0zAmu3eMVSM9GV+6VXJz+Y+PG2i30AV8AqOJbG39YFfkD3YdAcz
         M5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738926777; x=1739531577;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj+equ05YPpXeGHS5nkrYxKAkFKew+GcHvcSnIimXt8=;
        b=gfmJ3jElQopPkVrvAS0KyVoB9ngvufjqsnUICw/V+eONPnQhwM/rH1wW1gZj+z4AR8
         rSs2fRlG2vMyU9WNbDk0n5mVGT2+iT2bV8oltn+wB9H5diygxP3P1H2/atASMs/XRke4
         s6y/JLO8GzTPYCHu3uwfr2JH1Kw30A8Ynffu4oI1AGV9VLgNPKnzicBrWSDcVBhTE19S
         lsoseDK7DbAUzLyK375GsRogzM3uqvMzahK9SDx27KI506zYf943EQiPAoDwRmpSS2fo
         jNY5KqunTK4Zh+aQaNfbZ0jIRHnS7ftNFLQygx6GC1dN21a22rFlRLGrIcBpLI0x7gej
         2UpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+u8ht9DEsMB1fCU/WMtMpjDcYcc+o4d8egV/uZlvzOVzJpcmlu3bW67qQ3W+DRRN9MV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVa2gc9Z4TwBcmZ3lCs1/1Qle/Av7n1CevJrScV3vtp/QXZ1D
	FJ+BLTWRMUUaT4GZK28B3MFqAY2Ks+QyhyYyQR3KVZ2KbfT8lb3j46XAO8iikRd94vFltwfi3Av
	7YDTFrCxTWAyOa8KHoJnGmFEPMUPbuA==
X-Gm-Gg: ASbGncukf2MOdj6P5IhqJNZRUPBGSN1tutnsslyQA81/kFZu5Tg8NCRi51qoX/+WiJC
	1eQ1e8IeLFmdZPI9ay7vIZJEVKW7sz4l42GRsS2SZV9NJ8gTpgY4u1BpSOmWk7UxXuOT99wcmVg
	==
X-Google-Smtp-Source: AGHT+IEC/0FD5hmg0uPRUMJ/UuEak+2SyHO1AA1MWU9OlZc3o8mvBUzFW/Ua28jQPEu8SuKZzbtFOzRu43dE4luPp6g=
X-Received: by 2002:a05:6512:31ce:b0:541:3175:19b4 with SMTP id
 2adb3069b0e04-5440e643812mr2348362e87.11.1738926776791; Fri, 07 Feb 2025
 03:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com> <20250207104510.GE30202@raven.inka.de>
In-Reply-To: <20250207104510.GE30202@raven.inka.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 7 Feb 2025 03:12:44 -0800
X-Gm-Features: AWEUYZkMg4-oomSEZmILi1eEYmbdj7L_0O5MTiLWoPbBiyNrMgOZdhfX8Lnsi5Y
Message-ID: <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:46=E2=80=AFAM Josef Wolf <jw@raven.inka.de> wrote:
> I completely fail to understand why git insists to operate on smudged fil=
es in
> many situations.

It doesn't, really, and that's not the basis of the problem with rebase usi=
ng
merge.  However:

> IIUC, once clean/smudge are installed, all internal operations should be =
done
> on clean files. So why do I need this "git add --renormalize ." at all ..=
.

To simplify (perhaps oversimplify, but I'll hope not), you're running afoul
of an optimization trick.

Git is famously *fast* (as compared to most of the systems that came
before or at the same time anyway). In the old days when I used CVS
and Subversion and the like, we'd run a commit or update, and then go
out for coffee or lunch or whatever, because we knew we were not
going to be able to do anything for another ten minutes or perhaps
even an hour or more. Then Git came along and we'd run "git checkout"
or "git commit" and it would say it was done, often without even a
noticeable pause, and we'd wonder if it actually did anything at all.

Git gets this speed through a lot of clever tricks, and one of them
interacts poorly with clean and smudge filters *if you ever change
the filter*. If the filter says constant, the tricks still work -- but what
you are doing (in effect anyway) here is to change to a new filter
with each commit.

Running with an explicit `--renormalize` turns off the efficiency trick.
This is documented (indirectly) where

> and (in the case of cherry-pick) there is not even any way to
> renormalize before picking.

That's mostly correct. The problem here is that while `git merge`
(both recursive and the new ort) has a renormalize option
internally, it's not exposed to cherry-pick. Oddly, checkout
obeys it. Perhaps builtin/revert.c should as well?

Chris
