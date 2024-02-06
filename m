Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E01B7E1
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707250212; cv=none; b=Ww5ajDI/KwraGFJbP5laeYR4OtSmd1m6xS3FArJ6njz7Xx2FX6U7zXRZmHdSXi/1hTx37ev7x/vFBrRt63zXwYqUeSZaMCd3xqP9d8pIHceX+fiEJpXGouRdkvKREmHfkcx3iVEoWifw50rloB767BvhU1KcZr/IT4+kkA+tdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707250212; c=relaxed/simple;
	bh=pw+ZXYry/9TT6aC2zbFLymvMH6iDQ6y0aa4BtvLmXHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xl46d/2kQf3ul6qRDCodNVFt6nnzqGiJF2PR2nvx5vNJBXUpJjIsvgbKns9R1r5zIYCEV3X3BVNCIqe0cM7qyzLd3TSXsez2Ke8YZUpO4DJd5Dg9Wx2XcC9DIWzlyBMtvDLidJylC6RbQgkziFs9DrM7+HrhBWdqXbfKPeNQnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp+2viK9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp+2viK9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370e7e1e02so466761366b.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 12:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707250209; x=1707855009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LoBHizEIDb8O6aYNGNXf11h61CJXUIABERm/nlkWr8=;
        b=hp+2viK9yvY1U01gwfUKD/ucYcttco9R6tYoyr5LX7JxazqMnupaVNAiz8BjXTb5D4
         AECvq69sQnZQVDj+OT94kEZmIClzaUKymP6Iy6McbjFd3etRF0qQOZXgXOaleWPkg3Tm
         A2LWS/UVgtZzXsQWedth4pe7a/TVnoFHZN8lYTwpKRoniV6jtzrgnHqrO/RnkTkDM4Bl
         30A3Lzqugls3ZSDsgWP44w1x2lD0R9YFD5SPkVta8i2Bob4Tm0TnNzdEls/eEMbqF70E
         1lp3k6pRWfpqw+rChRMvuI0PHibHgZZitB99Ys7Tm27Ar3fNMw9vv5CvRek+2D+XLUnu
         /43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707250209; x=1707855009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LoBHizEIDb8O6aYNGNXf11h61CJXUIABERm/nlkWr8=;
        b=eAQW0+3G6YvCgq24grPQTpTcIAeAbjvshGOXo9PMsjU29f9nJqYM11rHkQIikTRfSL
         yJaB1XNUxZf1zspD1q5vXj0UmmFXDWwtlSAEu46v3oO/D6I3eTMKdzc8wopbQqny3bvL
         Z/cG+tQySkBdGAfjmuXKo3YenHIsi5NOgYi/Ny+toNNL7lStc5ynLn7Pw4kuqamqq6mr
         Hj6sag/u8NL+ARumpzM5AuLOjGD4HtWulyba2hjynMjbobw9r+04Vqit69L+Zxw3CyJz
         yNzK4jFPnHFUimmH1YVUHzFGluYG4+pACj3vq8fAavElzXnmlpjrQhPW4WtpIXuZB2zu
         LP7w==
X-Gm-Message-State: AOJu0YxxhhHO8OJtkloBvPL0gCoJinYRLawOg910NWxLGMOIH1rANNAu
	78a0acT2W2wpf7gkBY12ygHT4WdyW99HF4rPMjbILk+D6fmaEyZRTcJqLlhhpP9Ua+jpBiQXO1D
	vhosoRv+jzpeDare2khjo+L+d18Q=
X-Google-Smtp-Source: AGHT+IH2ijMA1eASz0pw6HA9Qm+ml7I++75rETDfKx6+CkIUBk1aiPomIWrDCreKtA/fdz/N1lpLOr4aqNEnYOqJJtM=
X-Received: by 2002:a17:906:1c89:b0:a37:e5fd:94ee with SMTP id
 g9-20020a1709061c8900b00a37e5fd94eemr2597679ejh.72.1707250209042; Tue, 06 Feb
 2024 12:10:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC4O8c_oKT+a0hm+tqSOG7d1=AuJJKy5bsh72cJKVsWynvHw+w@mail.gmail.com>
 <ZcIYz82iLxPOVR9Q@ugly>
In-Reply-To: <ZcIYz82iLxPOVR9Q@ugly>
From: Britton Kerin <britton.kerin@gmail.com>
Date: Tue, 6 Feb 2024 11:09:55 -0900
Message-ID: <CAC4O8c_1JnDc5v+_xS9Q=0fJmoK3e8iYiag2gT8KchcJdvgcTg@mail.gmail.com>
Subject: Re: is it a bug that git status show the in-progress 'edit' in an
 interactive rebase as 'done'?
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:32=E2=80=AFAM Oswald Buddenhagen
<oswald.buddenhagen@gmx.de> wrote:
>
> On Tue, Feb 06, 2024 at 01:02:43AM -0900, Britton Kerin wrote:
> >>Last command done (1 command done):
> >>   edit 71b73de914 message for first commit
> >>...
> >>You are currently editing a commit while rebasing branch
> >>...
> >
> >This seems wrong, because until git rebase --continue has been done
> >the edit operation for the first commit is *ongoing* and it would be
> >much clearer for the output of status to accurately say so.
> >
> it makes a lot of more sense when you decompose 'edit' into 'pick'
> followed by 'break', which it essentially is. so from git's perspective,
> the command really _is_ already done. note that in this state, you can

well viewed this way the pick may be done but not the implicit break

> do all kinds of crazy things - including adding new commits (possibly by
> cherry-picking them) and even dropping already rewritten commits (using
> a hard reset). so in a way, the message above is even a bit too
> suggestive.

Yes.  I'd handle this by changing the description of edit offered in
the comments in the todo to better reflect the possibilities.  The
hints that git rebase -i  (or --continue I guess) gives when it hits
the edit commit also don't reflect all the possibilities very well.

Britton
