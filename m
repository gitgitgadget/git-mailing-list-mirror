Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC341B5EBF
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428518; cv=none; b=Z7EVCtDy0WCz1x8Sj8mIwcOSxWMysaQY/b5eHlCzJiGtnDcH6mmQ306zFQrh+Kt04NmV54ZlaI1oiaUrWKmZ+1Lu2LEJXvafEOc5uuPy2ckJHWhWM2NMYvmdL8UD7Kww2ZtmKJovsILfZd5CyYu+hLXewcffNRv9lfPOaH6U1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428518; c=relaxed/simple;
	bh=7bWeY8j2WgLkMLBXm1WUGbeJ3vfJJxWF1HuBk2rSz5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBKJyEqkXRpaymaNkETz1Ip04C2ykq5AHNCwsU0VQ5z9KnNyg0cEtbnMCKYe2K1TrJEpIyeMPa08hE2wKTCpUVbt93/CyJnT7UUKshaJR3MHpOzoPEfey3fEiWA8VcOdQIqS5YRZpmTKcHTHcOxOZLY0cRGpx4hUo0/uapQ17Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2t/4SVR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2t/4SVR"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so3449340a12.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2024 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727428515; x=1728033315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWhNsb0faxQf710PVJiuVjuvtj01RnwKAbOQPttFwGQ=;
        b=M2t/4SVReDnw27p2TIrXzBfbCIwcxvC+ejMEiHYA+TTdz3Z45F2nrypoJqitFuq9i7
         WH1+IeyRCWd9+O6WkP6W5la+/q0JyU+C1KJlgLYiopjVZ/SyxUhLp76dXfl7NWIJOO0n
         9FKwtoMFabFMQsbjsr5LmnnUDI0wa5iBrFngymNqEgUuNeP2j9+0Dity7CizsXBmubWl
         XEvvwrlftE4dbjHvbYlEHe1uddmKyBRYtQhMlHwiAMYiIZnpjQIXUNinGdBbeoYFuUSc
         +6VUawHJ9CVj5yJzBQpmc0NbxfSXEHEFA0buLScYITLZnDBwDQvgpAaFQPny+rFbKbyc
         8nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428515; x=1728033315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWhNsb0faxQf710PVJiuVjuvtj01RnwKAbOQPttFwGQ=;
        b=IIFvgN9z/LJkzFFk+ZRW8MM3EBCo0V1/jVBv9SPwTvDynvhB4cmhJv/Roi6CbaMvpE
         6dZzwAk6FXNFQZ9QIp486RTtIaEr6pxfTzmddCGJSQ9I2r+i/+BDjpK95kXQLTyrAMdR
         8z3m3OnWEjpzf9OHVSuYk4u/3/p2rrClO0e9w3W+BfDUA2iqm8Z9DyxFahMlCdCTUFqf
         HSGAoCnf6ns8mJkPr1zpaK0jG846g1yz7aML9gzenufu/c90BApBwOV9Az25IqDBA9I5
         849SigPQAKtCjU6dSAvNbCdv2W5EdlbJ39bMstlxMe6sZnMKSWmmXM/+ohJ95p58Ggru
         WPBQ==
X-Gm-Message-State: AOJu0YyGxTsS5HjQIqev9F1PQ1dagoquWGU4eQApYkX16VayYSc3jaI3
	76XeMqvBD456sOhQ8ES7H3EkTgY2MX6PegsTVpRfkPUK/i4itmNGdrz5Iod8LCeZikH38/pgjIX
	n7bqTOa40JNFSlAsjRktRZWaDgZ8=
X-Google-Smtp-Source: AGHT+IH6dU0ZMTXv0rbuWRXdzwnVDYsEbYcNNLXfmtqE6rYVoB1BMVhHZYDVJneN7N3ukoc9KjBFkYhS5Uz8vjpywfk=
X-Received: by 2002:a05:6402:1e93:b0:5c5:cb7f:e56a with SMTP id
 4fb4d7f45d1cf-5c8777af668mr6026923a12.1.1727428513609; Fri, 27 Sep 2024
 02:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com> <xmqqikuijni0.fsf@gitster.g>
In-Reply-To: <xmqqikuijni0.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 27 Sep 2024 11:15:01 +0200
Message-ID: <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 8:09=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Changes compared to version 1
> > ...
> > Thanks to Junio, Patrick, Eric and Taylor for their suggestions.
>
> We haven't heard from anybody in support of (or against, for that
> matter) this series even after a few weeks, which is not a good
> sign, even with everybody away for GitMerge for a few days.

By the way there was an unconference breakout session on day 2 of the
Git Merge called "Git LFS Can we do better?" where this was discussed
with a number of people. Scott Chacon took some notes:

https://github.com/git/git-merge/blob/main/breakouts/git-lfs.md

It was in parallel with the Contributor Summit, so few contributors
participated in this session (maybe only Michael Haggerty, John Cai
and me). But the impression of GitLab people there, including me, was
that folks in general would be happy to have an alternative to Git LFS
based on this.

> IIRC, the comments that the initial iteration have received were
> mostly about clarifying the intent of this new capability (and some
> typofixes).  What are opinions on this round from folks (especially
> those who did not read the initial round)?  Does this round clearly
> explain what the capability means and why projects want to use it
> under what condition?
>
> Personally, I still find that knownName is increasing potential
> attack surface without much benefit, but in a tightly controled
> intranet environment, it might have convenience value.  I dunno.
