Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2B2AE93
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738519794; cv=none; b=bAmlAoTHSaYtvK0S2co3YGhPYqfWgOjptIOtGHLU2X4HTI8qrCMbreePVnw8PgloV5A5JwSrJ2rRGLB/zJve88sdRQXxZcyU0RWN3bTFlt2S49eNjTn/sA9OoIKM5rm6cY5bzeqa9iDYlyTo5KSmt23cD2M1zq8F7J9FuHz5DHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738519794; c=relaxed/simple;
	bh=w12NJWXTOLrwiw3N73GbTp8GIM61tuhwJEBDjdK6RTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4IWExQA2/akl1vdm6bT23cN836afEeWbgIrxg7lWyJ3SBAJWVG7AmBJb5o3nWubtq8BisJW0Go7Zoo68PELO8MWAiWAL9ROGZL4bhR2OA95VXdzACxbba7RIROx8NxEFSGAvGNwg/xwlHMFY0+0LjiTuzFY41Mf4sYiFKpODlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7et8gvh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7et8gvh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa68b513abcso642017166b.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738519791; x=1739124591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ60EdowXN/LPLUbgYbkqrZJoh82OEDyCHfdupEtbvE=;
        b=m7et8gvhG8LVpDDXRYY4n2+JFniilZCcHMBldBa+4rQCoC7epiCuVKQbLms8p6jmMI
         lOQ8OuZqY8OEK8ep2/q2std8QjYSM45MpQh0DmUo92kTwdf1KXJ2Mf3qaPi+DG37EMne
         fNyhJMMIyXn/QO6sH/htCxtc6eO44Qlg22DwapPWQfT/USSxafNzEwD+22nV8f9mVX2x
         +u25fUkQlJFrMicZFKHnsgtYS4eXpBMwEv3irVcU1f4jSmZMkwTr926aeoOoFDzZeDBJ
         zQNzVlx1OJbKBzBu+5CZ5T8MGuV9aE9fc1mIzxqS4g05nqLRbKTtJDE8GSsAJCk6H/PO
         VWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738519791; x=1739124591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ60EdowXN/LPLUbgYbkqrZJoh82OEDyCHfdupEtbvE=;
        b=ctfpQ8svlnp6MCXetzjzgoj5FQi6ISjGenATXHCqDZdX6VbvC+7cBvck2x/dpwQt7b
         k7vTMib4JKthimZtroGQCMEtbvs1/kXC0n2sntsf92QQcdD4w+uBrLFkoEN/m8H5PrQe
         3f6xNCsDIz4KJQDL2Fx7oTkxTC9F1fk6aRy4/J0g24Ve4lVE0JlyFOx2FwK1nMN6RMgk
         Veh4HeEHyLErtaR080QiG/9TKih/WKTCLyRbUr+ZH18PMUsT26+Qp6v4NN7NKcoxNIuK
         pbqk7KxYr8Tb/CwjvG+pIC2oAZAFRdeu7yE7o2XUg05KKfhHMxqe8QrqVsN/O/esYB1B
         Td3g==
X-Forwarded-Encrypted: i=1; AJvYcCWg3XVSHj9mK2eCpPP4rZCnBTMGNZ9vNWbQUpaXxLcN7T8zVwSTQ1m10JAquz5QkTF1jt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BDpQm0NLH3qQBMUg5Z9L+rnxq8PP7O9hDGhm5SmD13h1XUSV
	K8qe2VKcSuXeFHRFHDGgOFBFlrN5oqLyZT7WdnG57YcpIm0/9LSuB5FYP440UPg0skcISRN5bAx
	4qVbsSlnKLgLyQOxXXUQGvMrgaOF7gw==
X-Gm-Gg: ASbGncv5vw4qGy1C+9W7rUaylI3aF1/YVyoVDzRBQVk4VIMtj3xS/1RnsKUd2i5a9G5
	/8ahmjhEU0kc5ezJXZh4EXOGOeOOiV+OhlPxjLNeV0YLsh3thhp3f4fVq9gZ5X9p0NAxPVyUlY+
	BjF1LLpWjJLl8mcLVHYWvo0kVzR6s=
X-Google-Smtp-Source: AGHT+IHUTspYDQZX4It9W8sr+LjrVnyn/DHfW/t7dz7BbWSfkuJX68YnaMAYz3eEcjVem2gZTiWF/7zViscr5Qu0Tic=
X-Received: by 2002:a17:907:869f:b0:ab7:371:d150 with SMTP id
 a640c23a62f3a-ab70371d301mr1090558966b.15.1738519790637; Sun, 02 Feb 2025
 10:09:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbjvyv510.fsf@gitster.g> <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g> <20250131233452.GB3544301@coredump.intra.peff.net>
In-Reply-To: <20250131233452.GB3544301@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 2 Feb 2025 13:09:39 -0500
X-Gm-Features: AWEUYZn-pKrKagXo3LbhhlBJLsKbqQZza6PvdugilflpErmqVzvubwvDWpOo6tA
Message-ID: <CALnO6CDqHJP_wa_8eKHBkU+_1vQ6D+C=QRZyW1FKnG71wDxnnQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:35=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 22, 2025 at 05:52:30PM -0800, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
>
> > Nice way to use extended context to show why the change makes sense.
>
> I've been tempted to support a:
>
>   Diff-options: -U10
>
> trailer, but that is probably overkill and full of annoying corner
> cases.
>
> -Peff
>

Fairly off-topic, but I've been writing "Best-viewed-with:" trailers
now, and also had a similar thought (what would it take to make it
"safe" from ACEs + obvious when something is influencing diff
options?).


--=20
D. Ben Knoble
