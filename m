Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CB23D2A8
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467178; cv=none; b=ZLKkzNZ3XVoXaha3QsyTx6Yt0kSB2fbSlK3e2SCXwXz2339VSMBSTaZFHypJ6OnUskbaAh0T0Ue46ECvV9k4iTh9co0v8Hs0bucIES92t3mTk1HAIwlSdXEUsBPma972oVO72ehDFG3S1o1450xKjTxmRNN0okIiOieHpIrAs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467178; c=relaxed/simple;
	bh=n07FLYuU22yxS6BVsjh4nZQooJkO7IeFZeamsWs75dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxb93NAQOERbIIwDIisxndDrrHrYxeESFFdXqVkZH7ezATmI9f9eEFsqBjgPRcmeMuvPuUMiNGyW7fdXZZcxegdkVdlJT5Evd9UoYqNMtVIKzswkNWEmpLNbsLPVbFoh+wu0iNlCnDh1eKP6JGHUR7PgEL9hkh15ocPfxt3fVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tidx49J5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tidx49J5"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so437783166b.3
        for <git@vger.kernel.org>; Fri, 25 Jul 2025 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753467175; x=1754071975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n07FLYuU22yxS6BVsjh4nZQooJkO7IeFZeamsWs75dI=;
        b=Tidx49J5TuuvpXUEb3dSK9UDbmnerZXRmVIhpYRHZQrb3Z5Z7+kCVxdErT7WSaCLRK
         XjdR0Usyh7Fvm9FoNhSuWAdlUiJn5Y6v7fzJDdF+pTwuSUqt4KVLmUlNkj6EDIRtkewT
         MbbWAzT8f/gZ2OBgiwx1XXyOuZ9yw1FJzJN8NZ3c2VfWKk5296LOWyWnmwRbBtCnuHtZ
         ok/JuC3hJpu/c2YpnFHcPeNpBNhijTMEMztflKU2KYQxy0RCdrNcyGmCzdh5Be0f6/HU
         mmowERAfuwMJIgzS+s8mQn//8GwP8bS6/2mVcXPZK+hbAA9iUqr3F6Jh4zfsZJGyH3Nc
         bTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467175; x=1754071975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n07FLYuU22yxS6BVsjh4nZQooJkO7IeFZeamsWs75dI=;
        b=AY23Z5VXAxvzKpeK4h3k3jX3CDxgEb82fhvuuiwdtwyjomsi6gHaxOcfNpV5lnGhn5
         RAFdxuMfEM8ld1nFwTreYn/k6VbtKpjutaKxKITKEBvYfvR5ZoK4oHNt6zGOAQ4jF6Em
         VURXOelpolXl0U3yS2lzOIuBa1x/oVvD4B7HAOmOmOQt01i4JXYjFA60n3Wcczqagnut
         fVCwganjEn9kESkOgQJRKnUjvL8UQmcaN5jPt1ANOjssEVccVTbENeWdn6w2SaGxFsya
         ZXRpiut6ZMXFAhLPDDbwznBHiW3OHMDrWkJjpcgOCYhU44ysYwFeGUjITqUQpGRMtxwj
         oTzA==
X-Gm-Message-State: AOJu0YxuKvdB0K2NbDyJL6Un4ACu4Mn3w6Y3Pm2UJhpcvMiGG4xB7S1x
	f0q0rCKomDTWKoaxpWCuVVvnxsdR8jkk8hnEOWD8U/WDy/0jBJlOicTognesHKJvODNyQokKfIF
	fSpKGd1SRlua+/mHGaiwA8tdy1W0UGLY=
X-Gm-Gg: ASbGncvpxhF4e2zqUjpy4vSftgAGeOsR7bhlN+FA+4/mpLssoDPJ5IP342B6YojImFH
	sxhuwE2wlvF04XKzFqrt27du/30ok3kddpe0eZ6sImICdBeW/W14bRiVEkhERbyK+/5EGAHDPwa
	2RfJ1a1uFwUsQYIPVFWPnAqV/M8KJZy7oGjTfsbG6iQWP2AqtqkB7mM3qOg+w9gtqbDPPgV/XaZ
	w8gzXQoJg==
X-Google-Smtp-Source: AGHT+IGOf/vcfh14ztwQdkVLJM3mjyqzH4arSL4O1jd9QEWIucTYY6fKBxWnMscqZ7C7v0KzaY9G+Os6tIRwD9iidcI=
X-Received: by 2002:a17:907:e84b:b0:ae3:b2b7:7f2f with SMTP id
 a640c23a62f3a-af619414091mr384748666b.40.1753467175039; Fri, 25 Jul 2025
 11:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
In-Reply-To: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 25 Jul 2025 20:12:43 +0200
X-Gm-Features: Ac12FXwB7rN3-4AZaPXY4sB5sWL0FLDELJA8ZJ6QnuIl9vexsVWW1wys1z38qlg
Message-ID: <CAP8UFD10KuuM8Xu5YDxDf+rzN5r0TxgOw=do94dPO51hOCyE1w@mail.gmail.com>
Subject: Re: [ANN] git-phoenix - repository recovery tool
To: Daniil Iaitskov <dyaitskov@gmail.com>
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniil,

On Thu, Jul 24, 2025 at 8:49=E2=80=AFPM Daniil Iaitskov <dyaitskov@gmail.co=
m> wrote:
>
> Hi Git List,
>
> I would like to share a tool for recovery an unpublished Git repository
> after accidental removal or file system failure. VCS usually implies
> backup feature auto of the box, but due to Git decentralized nature and
> developer's laziness source code sometimes can be lost. Recently I
> accidentally deleted all projects, including a few unpulished POCs,
> after infamous rm -rf * typo. Work on them has been interrupted for
> quite awhile and rewriting them from scratch recalling all the hack
> intricacies would be terribly boring. So I decided to invest my dev time
> in a more creative way.
>
> https://github.com/yaitskov/git-phoenix/

Thanks for creating it. It doesn't seem to have a license, which might
prevent some of us from using it, though.

Anyway for now there is the following pull request to talk about it in
the next Git Rev News edition:

https://github.com/git/git.github.io/pull/790

Best,
Christian.
