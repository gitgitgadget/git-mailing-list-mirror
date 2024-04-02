Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF225A4C7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059028; cv=none; b=k7QxiAKKZWcjqidhBuNHQtW3Tp6VYCI5BvK8pNApAm9UWYCfbHviUM7rIU0HftUiWsgMmTbGxu8OyiRxN+LNTLsbrglb/h8iJHGH6AALTrx1PwScolVZ1yQ5AJ/K7tZdfmhyQERfG9TsxNFaAcCRUIt7KpftqrA26Z9NwjsG4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059028; c=relaxed/simple;
	bh=s38PCSPxEkfXZRJQsR69HpdtXShCxoL0W8qoImKApps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRnKTtjo8OHvWSOV/jMNHIWiLRps6lc+xaBBXM51mOQUwScL1dr+QciFBx299lCYR72aHpKAEz0v1lkqP0aiXBIXYUB9DisxOq0UHAyLenScT2chZSTgpH++Miz3TcUQjjV7G7V+smCo3gBfPGc1C5hCZvtx0VEUbdmnWo5ey/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com; spf=pass smtp.mailfrom=fuseenergy.com; dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b=U7sJXJq6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuseenergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuseenergy-com.20230601.gappssmtp.com header.i=@fuseenergy-com.20230601.gappssmtp.com header.b="U7sJXJq6"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a472f8c6a55so639764966b.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fuseenergy-com.20230601.gappssmtp.com; s=20230601; t=1712059024; x=1712663824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L31DDcaA0+k0Zj5XFrFwjoW5YAiCbmV4Fuw2a/SAyz4=;
        b=U7sJXJq6py9yjBoKMEqvmcISjTo1N4W/jcwwAu4AXeMCZD3HrXvwt23OsJBzgEX32v
         fMoC5vnke/73D6KzJf3C5vxwbFPGC14b2bQsIGQpyfuB3u/3ToUFsZ4xmLRyqifFVck7
         ePSjQBKzxYWzlzGeMEpKgupYbHSQsProRHUIqrqrm4C/hVWonWz/rmMalRK0RVAvnn1s
         BMzGQTzjmW8iJ3Yhso8okRqn+WJgdQhCFq0soL4uS5ylbCuwRnURh1ZZHnHbGxlZzc6g
         XvASIHBkgVHyvzSHqljD1ZIpx+xkghofK9Ht7fYBuxiBBe85MmdX65PtFdxFw//s6SJ3
         I+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059024; x=1712663824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L31DDcaA0+k0Zj5XFrFwjoW5YAiCbmV4Fuw2a/SAyz4=;
        b=kQJT4mZQZhZVjBG38nmE+7LoOiByYgmVc9HDQGzKIhKzVs10902etYhIC4arz5lY4N
         Y1z/3bhM5aS4w79W5u7j67FOga7f55vVTBYve7y2jrPopfeCf/hwdoADpZOv5THbOvLL
         6H2QsK8faPAOYJXeUkiqJMRjFgusH+roaAixb2VzaH4pbXU0I+Zo2ZJ8vG/UjgRy/hmS
         3YIgkuz5T6nYloa9FLZM9Ru3vdBN2RkPvcn2CyPAhxG0z+sW7HD4HaQytreXWroKp3v5
         sBvnSsJAXnwYQc4wCX1HqKHAH0roqawtzi7mYKxjjbFCktXgg0712Z8xFjZhoXF8xB+R
         PAdg==
X-Forwarded-Encrypted: i=1; AJvYcCUILBk4r99P1Suxqns5fk2KSd4y9r2KLlo3r0lUw+jU9vTRXI7LyW2qDoxvcKyNMEVqlUcVn1kaQQcJV8f8UWsI/s9G
X-Gm-Message-State: AOJu0YyTGEjnlbWfzIgnVkC3RUWejzSXV+mlWvMwpCv5bdU5qONnhkqK
	nbv58grR1HIjxe4lxVt7lf4/f5xQmmVwwlmAFdlrl+8J6etGOkuZiIGMcUbOpuzep2AYBO2WRUf
	gXifX0R+5z7iDqvow3u0YV03Q+PXQrV8w9A9VSw==
X-Google-Smtp-Source: AGHT+IGYGWsXkmV6AT+/cFRGgv+tSL6nHlFWnTMAA/bDI+XHCT7gZmDnmladKIP5CD5hZhH0+kqkvSzStWVtOYfLvsw=
X-Received: by 2002:a17:906:aac4:b0:a4a:859e:97b8 with SMTP id
 kt4-20020a170906aac400b00a4a859e97b8mr6687065ejb.24.1712059024497; Tue, 02
 Apr 2024 04:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
 <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com> <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
 <740d1f1a-40ce-4714-91bd-1ba448e9d672@gmail.com>
In-Reply-To: <740d1f1a-40ce-4714-91bd-1ba448e9d672@gmail.com>
From: Tamir Duberstein <tamird@fuseenergy.com>
Date: Tue, 2 Apr 2024 12:56:53 +0100
Message-ID: <CAEYvaskG0BBVr+nsQ+iof=AXu3dcQHx0aRRrKRrf8e_NFANL9A@mail.gmail.com>
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 12:29=E2=80=AFPM <phillip.wood123@gmail.com> wrote:
>
> Hi Tamir
>
> On 02/04/2024 11:26, Tamir Duberstein wrote:
> > On Tue, Apr 2, 2024 at 11:10=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >> On 31/03/2024 07:49, Eric Sunshine wrote:
> >> Thanks Eric. I'd have thought that "git worktree list" would say
> >> something about the branch being rebased if there was enough state lyi=
ng
> >> around to prevent the branch being deleted, but lets see. What does
> >>
> >>       ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
> >> --git-path rebase-apply)
> >>
> >> show when you run it in <my source dir>? Also is <my source dir> the
> >> only worktree?
> >
> > % ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
> > --git-path rebase-apply)
> > ls: .git/rebase-apply: No such file or directory
> > ls: .git/rebase-merge: No such file or directory
>
> Thanks for trying that - at least we know it isn't a problem with
> rebase. Lets check if there is a stale bisect (sorry I forgot about that
> earlier). What do
>
>      cat .git/BISECT_START
>      ls .git | grep -i bisect
>
> show?

This was the culprit! There was indeed a ` .git/BISECT_START`
containing "cleanup". After deleting this file I am able to remove the
branch.

> > Yes, it's the only worktree.
> In that case can you check that
>
>      ls .git/worktrees
>
> fails because the directory is missing or shows an empty directory please=
.

% cat .git/worktrees

cat: .git/worktrees: No such file or directory

> Thanks
>
> Phillip

I guess the only action item would be to improve the error message.
