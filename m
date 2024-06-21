Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1DD168C0C
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955487; cv=none; b=T1+QPYBOGeOAz5uGPRfgD45VHr9bUA48KPv3K1ots2K60Hm6A840gC+8J6+XGpIYH5ktk7RwQ+lWy1emux/f4WsA1SzCLGr/zByNO5MjEIz06IS6X+UE6l3RywvALzdR9SSsE/BspJp+RwZ4USqbHunaa8lEVU7m1/GITEysviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955487; c=relaxed/simple;
	bh=5NJvX6iaN/1GfTjKeK7/IqEQBj8LVfE7RttqQjA/l/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAV/LdC9g9CRMUp7zlXpWMxK9fjFkPmHcNiUD9n0A4Drrpa6Z73nStnff4pSU0IDMSsM4Kgu91oNbFj6yJ/AFxm1b0ZEJvo+dtt79StlaL4MyQ8rO2H8aOWILqEMBKozt/h4wTGYJeZ0RwfQKkNYBHWCLTg+Gl6b6E82lbtOvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdHvBwh+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdHvBwh+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f1da33826so210370266b.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 00:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718955484; x=1719560284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4eU55SVbl4neYpkK++hpqsKUyZkQ3MROPsJCB9E42c=;
        b=hdHvBwh+jP0DNi9fFLPwuoD/0+8czVgaeGIP9gkhB0i/idFXXvBKgP+qbsIpEZbACD
         7ALsp/y9AsPWklQgXaeCBHErxNMcsiknDKSwln37SRh85/Ji2x3nejRDDfrwYaYvXL+f
         IIb/6syinItoX6I7+upbp0iuJDKwEaSqO0+uSzRnvctN2dfJsd+GtBATdtBJZNosMciD
         MhTAuEAexKTO3oQUxjGf2vxRRUOR5qFP1F3vMmWs1TyWZJbN8xN8A2WsCeMarenpugWs
         qWmTzqfVHNHr0ayKJk3yltM5RU3qUL71CMZgCxMAaUCAFNGBhyFdWeiVi3P7fyvOGvbZ
         lx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955484; x=1719560284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4eU55SVbl4neYpkK++hpqsKUyZkQ3MROPsJCB9E42c=;
        b=B0J7oXEGnpsFmgea8vxqKNSIqUTTMEXAJS/KEuXIhCJF36VzAUVxrU8kXUe/lvIko9
         k+hZ800AcUGFgwm6yZDF7/mVLgHBx6jjP/QxnPGVQpMRocFCNDzTKY6zO+PoHZofKsAC
         QDpV9KHjdi4Tnuwf3brdjNHlmxyZuqhQtbI+gxQaR9RJ+6uB4VyU8BRYnBuSuxGtFrri
         WgljJ1sR5NAb/VvFYsUDUo3TlymNknt22sLqxvDyXQIa6HhZ4rmHm/qI13Zf0mYULAGC
         FFmbWUu74jQT6l5YmthlOQLNc57jw9JRExxsyhAnIxEW0VlNJw7VoApqhv4Qb+gwzQRq
         SFIw==
X-Gm-Message-State: AOJu0YwYsCyrq23Wbj22/giAe2Mw0XW0L+Mck5X8oq0LhpzPpS3f+B+S
	3QywDOHun7Hp4KJyQ53kkrWMSzDgw0WvlgQUHQ1Ix4uUtj9LK55BDZkFniPZbX/CY59orIc/u1/
	L21yO04ia69ldHIHBJL6F2KT4v0A=
X-Google-Smtp-Source: AGHT+IEAW7f7Hjw/AtLIoOCY52YFdvG7SFCG+5YWNR1kYZm5HZqI+WTg3ZtXwqAIHBHPsf/vumqJGowKmTwHcvGqaLQ=
X-Received: by 2002:a17:907:7293:b0:a6f:6f4a:b25c with SMTP id
 a640c23a62f3a-a6fab60a2acmr724779766b.14.1718955483170; Fri, 21 Jun 2024
 00:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <968676664.8436621.1718941871973.ref@mail.yahoo.com> <968676664.8436621.1718941871973@mail.yahoo.com>
In-Reply-To: <968676664.8436621.1718941871973@mail.yahoo.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 21 Jun 2024 09:37:50 +0200
Message-ID: <CAP8UFD2mX+6f0TX4M2YKGC0v4rqR-Ng6syJzBDdtDZX93HF7zQ@mail.gmail.com>
Subject: Re: Git bisect skip
To: Michael Gofron <gofronm@yahoo.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 21, 2024 at 6:01=E2=80=AFAM Michael Gofron <gofronm@yahoo.com> =
wrote:
>
> Hello,
>
> My question is can using `git bisect skip` cause a bisect to be indetermi=
nate and/or fail if the commits that are skipped couldn't have caused the i=
ssue?

If some skipped commits haven't caused the issue but they are direct
ancestors of the commit that caused the issue, then git bisect might
not be able to tell which one among those commits and the commit that
caused the issue is the actual commit that caused the issue.

For example if there is the following history:

G1-S1-G2-G3-S2-S3-B1-S4-S5-B2-B3-S6

(where G* are "good" commits, S* are skipped commits and B* are "bad"
commits) then git bisect will not be able to determine which one is
the first bad commit between S2, S3 and B1.

> Consider if my commits are like this:
>
> 1P - 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F.
> P for "Pass", B for "Broken", and F for "Fail".
> Broken commits are commits that we can't create a build for but wouldn't =
cause the issue.
> Failing commits are failing because of a bug.

Similarly as the case above, I would say that git bisect will not be
able to determine which one is the first bad between 6B, 7B and 8F.

> In this case, 8F caused the bug.
> If you tell git bisect that 1P is good and 9F is bad, bisect picks a comm=
it between the known newest Good commit (1P) and the known oldest Bad commi=
t (9F).

Yeah, it should pick one in the middle, so likely 4P, 5P or 6B.

> 1P -- 2P - 3B - 4P - 5P - 6B - 7B - 8F - 9F
> G                                        B
>       <------------------------------>
> Perhaps 4P. That builds and passes, so it marks that as Good.
>
> If it then goes to 6B which is a Broken commit and we do `git bisect skip=
` what happens next? It seems from the code it uses a psuedo random number =
generator with bias to determine the next commit.

Yeah, because it tries to avoid testing broken commits that are likely
to be around the broken commit it already picked, while at the same
time it tries to be efficient which means to pick a commit near the
middle of the range of commits left.

> Would it ever get in a state where it can't determine the commit that cau=
sed the issue even if these broken commits would never cause an issue?

It can't know that the broken commits that are direct ancestors of a
"bad" (or "failed" commit as you call them) would never cause the
issue, so it should eventually say that it can't determine which
commit is the first bad commit among 6B, 7B and 8F.

If you are sure that some broken commits don't have the issue you can
mark them as "good" to help git bisect which should then be able to
find the first "bad" commit.

Best,
Christian.
