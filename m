Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE192F46
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672724; cv=none; b=eTN9ukMdB3PM90ABe8CyY+KwBiS2MMq0qJE+8X3obExo4KkaPiTxhcEJExdpzxpgJYvw51TJTPtxSSGlyMffxcsuWoHlffGY6IrxBpSgzYbFQ17IZqEdCigLqVuji7SkI+31LlZIt3Pmr30+aZjdfZzl7TtYUw6hCC2uDULNKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672724; c=relaxed/simple;
	bh=rk8d+MgQiqPHX0GNiixSDzQtmU8bvInDB5bWXAcPZag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSa8oaNhovi6j4MjjwGc2jCrXWMTk5W7OHto6uOnO3YDXc99nxKZfBXNSlRIz9YeKsqJDDPQXazt113tzmjnVERJDh7hiJ9BFpESe1CK5w47OILGH2DQ2ldUtrYEKY1nVLYFANez0r33jdad4g8WhizeQbhKOdSxLv8xofXl64o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqAbExhS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqAbExhS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso9584355a91.0
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 04:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738672722; x=1739277522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V96+mHvY2Ol7cix3RbAKXyybmIihhiHp2Fs2o6VSO4U=;
        b=YqAbExhS+zT4OEiP6ri25SC6Wt7HVtGpyEsm0VvCF2+Vhfo5iBPqiYrRlyApLEhG8N
         hSeglfj7x9LuJjqfyBblsVmnr42ulRKZKwqEl3QVN8rfenDyBY2iKeMSCfbLDe45SuWk
         pZ0rRf3gCo0QZlx/77OCdx35AL+If1dzoqdQiusF2gYmAVpOnIe6/YmS71D8wIwdtGOq
         xugl/GSkg4qutXAr5BTtdrmDWtUo62IPMNhWSr9Wu7wzCSM0SYJ0NySGHgO9BzEzCm6k
         5Yi5r2ZrCNvLxvXHFH+9R/zjbRGwqpgvfhNpxLqcYX/4LYbOyR8mhuikfrm5BWkjIZFq
         jJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738672722; x=1739277522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V96+mHvY2Ol7cix3RbAKXyybmIihhiHp2Fs2o6VSO4U=;
        b=EtV0WWz3J2kcMWhgNfyx70uY2J2rSRcBIt3iB8OXjZY4mesbbPq7bWifXsNWirsrd2
         TNj3RajCTt4D3lshzPBocXUmuuUhR0J8MgveX1ilx55vroLuWsKevPxAQtRZsKYl/7MR
         suNn8JZEMBJH5L8rPwhVVGw6qRNvq7ManzHLDFI8j7WT4vZcsSxzn3XZFU4ALiLi6GGl
         mtCc3BFSMD49bE1J38V2AMtLfYdPZqNhQlV5Kv51phEYHaKxP9fuYJkBCjdJc40Wuzzu
         O7ktlzrqsGsdbSQWNfUXU/URholQrwGxPXRCnfaWKmDSFPAd0pjtsAGV9XpgpMZ2eCwq
         fC9g==
X-Gm-Message-State: AOJu0YwqFezMckJDRfZ1HlPvzm/bIpUUD3Fx4gkajcI7I8vnk6+S1qm8
	r3i0LxOrGWgXSPI/69cxl7QAVMkreGuEGU+z1Ff/FtjJiZTVqdf0utXTkCaz7NDwpVe1sT84xMx
	0R4KeoXEEHNAe+pO5TIaW4uVx5lc=
X-Gm-Gg: ASbGncsT9fsCuCYJGkTgDBuAJ0MlW/Mrff19iID5tY7OKglKDipCEsH0AtRj1vJUmY4
	jkPCu4LakeUSFj1FdC6wxn7gAnx+Mfw0/6Dwk2F5J0zboa7rzqWT8L0uG7fIl8PL3N56G7fk=
X-Google-Smtp-Source: AGHT+IHYeoG6Qhmyei0Zn3vvPOWVZLc3hBmhRfh3qqWCIkEc9F100QjBwbB8VI1Cnrwo3Gd8UH2yFlxkAiYkKTIooRI=
X-Received: by 2002:a05:6a00:10cb:b0:72a:bc54:84f7 with SMTP id
 d2e1a72fcca58-72fd0bffad9mr1538383b3a.12.1738672721743; Tue, 04 Feb 2025
 04:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
 <xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g>
In-Reply-To: <xmqq34guzi0f.fsf@gitster.g>
From: =?UTF-8?Q?Manuel_Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Date: Tue, 4 Feb 2025 09:38:30 -0300
X-Gm-Features: AWEUYZm50jpktezA2W8sga6A_DCScNkRF_JdBWXA7cRqQs-Kk-6BS7Y0SNrnAYc
Message-ID: <CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
Subject: Re: Usability issue: "Your branch is up to date"
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 3 feb 2025 a la(s) 9:10=E2=80=AFp.m., Junio C Hamano
(gitster@pobox.com) escribi=C3=B3:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Manuel Qui=C3=B1ones <manuel.por.aca@gmail.com> writes:
> >
> >> that can be fetched from the remote. My proposal: Add the timestamp of
> >> the last fetch to the message. For example:
> >>
> >> ```
> >> $ git switch main
> >> Switched to branch 'main'
> >> Your branch is up to date with 'origin/main'. Last check was 2 hours a=
go.
> >> ```
> >>
> >> It looks like the timestamp of file `.git/FETCH_HEAD` would be enough
> >> to implement it.
> >
> > Not generally.  Your last fetch may not have been about origin/main
> > (e.g., "git fetch origin next"), or it may even have been about a
> > totally different remote (e.g., "git fetch elsewhere").
> >
> > The timestamp of the last entry of the reflog of origin/main may be
> > a lot better place to look for the information, if available.
>
> Unfortunately, this is not quite enough.
>
> I do not think a "git fetch" that noticed that the remote-tracking
> branch is up-to-date updates the reflog of the remote-tracking
> branch, so if you observed that their 'main' is at certain value 10
> hours ago, and if your more recent fetch done two hours ago found
> that they haven't made any progress, the reflog says "You observed
> that their 'main' is at this commit as of 10 hours ago" and not the
> number you want.
>
> However, as I said, the fetch that touched the FETCH_HEAD file may
> not have been about the ref in question, so while a two-hour old
> FETCH_HEAD can guarantee that update of any ref by fetching
> (including a fetch done as part of "git pull") did not happen in the
> last two hours, it does not really mean what you have in your
> remote-tracking branch is not stale from reality by more than two
> hours.
>
> You could inspect the contents of FETCH_HEAD to see if the source of
> the remote-tracking branch is listed there, and when it appears in
> the file, can use the timestamp of the file.  If you did this:
>
>     $ git fetch origin main
>
> and it left something like
>
>         f93ff170b... branch 'main' of https://www.kernel.org/...
>
> in the file, you can reverse map the URL and the branch using the
> remote.*.URL and the remote.*.fetch configuration variables to
> figure out that it must have been stored at our 'origin/main'.
> At that point, you know that the timestamp of FETCH_HEAD would be
> when we observed that value in the 'origin/main'.
>
> But even then, because the FETCH_HEAD file is not versioned, if you
> did
>
>     $ git fetch elsewhere main
>
> then the file gets overwritten, and you would no longer know when
> was the last time you observed the value of 'origin/main'.
>
> In short, there is not enough information kept anywhere to compute
> the number you want to show reliably.

Thanks for the insightful explanation Junio! Looking forward, do you
think that it could be possible to record the timestamp that the
remote-tracking branch has been updated with the remote branch? In
order to make such information available to the end user.

--=20
.. manuq ..
