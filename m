Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF133A1AC
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726776666; cv=none; b=ndjn9IMF4XmEQIIN7Kav8cy5dsblpF58Ck11IQbotWOMU6FuIvX4YW8KxiCHQjBDf3MD6P+XudTXuxSfrHTFgOXfCCZ39Q+1Uk5X0GqyrqId7ahzSnuXAa/dysMS2JSeYlUQSNy0rjxcqsxiv6Dh2oD3vjRwp4DM6mUgFGX6WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726776666; c=relaxed/simple;
	bh=dHMOPMlpPSVvrWwPu5mXMypFD8TiMysNRIYcembj8Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q40AczW391/dZHDZ+rZNodLIVtVUx6LnEYsQa/mX3jO1mQ3eRnjtvF3Z1RNbPhUsf0+RTnmVghIrVrRqYSIyoNjJPoG9bFPRvilmTputYR8mkAotaurnh2a9xU0JW0GG1KSnkp/ayz6d0c2pOyG4P+wUn2IFNj1IIOgPXSEPnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com; spf=pass smtp.mailfrom=precisioninno.com; dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b=g5t4wOl5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=precisioninno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=precisioninno.com header.i=@precisioninno.com header.b="g5t4wOl5"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e0465e6bd5so661399b6e.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 13:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=precisioninno.com; s=google; t=1726776662; x=1727381462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a21VwwWI/0bproFnbC+j5kfjJUKLNB4bD437L98OPo=;
        b=g5t4wOl56ELcgqOY8vhTsDf9l6Hqr/BFR/JIYz4AiTt2lSFrFhM8v7/RxzM+zU7PDI
         KD6BIbQPrbOgO7kfKuyOKmZP9fXgaHZJkv/oTm/9nC6I2rxnde24ws+IAKj4f2bcfZCC
         uKoHvOXbcUDLXBYgCQbN8jQOgpgdq5sIzv6UHn6AostgQ9BYlrgn40qsntdIDTX8UBhf
         vcQKMAOhmq1/OPmU+nMUUIPUJVN1z8JJ9rmU0CFA2zhAq2vyEeKKWjI6yvCJan5Pj64U
         kz0X0Z2/P5DxAm1SISTJHvh2FKlOtcz0AWqaf2KOsWAUofpABWK2jyzCKxtZV3Ak1CAE
         v1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726776662; x=1727381462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a21VwwWI/0bproFnbC+j5kfjJUKLNB4bD437L98OPo=;
        b=hGZEOhiSAGe8VVxuGRg47/f27pN8/rs6RNeCJs9TuTj64ODj0JLZSwK90bp+wi5Mzm
         oTBTZQBItOXuuuBF2D4Fl8+rwcVo535LD1NIzxIat9hFIYpDqbabbEcBbhAN+30NyZlS
         qQsyqVQMt/eCjxc/jaaxefxOUoM3uD7aJMD8SdZ06gS+nnHBvxjstlWrU5L9AVioQcpZ
         y42h0RGyfa58m62S3m1qza3fjkEnxP+IwHtcwlEP/OOx4NQXtkfMbm10XulMn3/1B6yn
         L7VDSeIjaAzBHkmmzRfvMmQYO+GZ2tCMU63FcWxGb57uq7czThUshtydeBOj72TFkmkk
         oyIA==
X-Forwarded-Encrypted: i=1; AJvYcCX7qxpefpXfxODPNLAycV2XHeJR13otohbvYJVdXh9o+Ut7zCs9R7zghsA7vZx37TxxRj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHl1Sba1i061PxJ0d8EDXGzpD0GWLuvAnzr7uZB1LF9tzkDvnJ
	HKT4rsUsulKwlJxurAa0WcI2XFlgKsCmHMA9XO7yZQZmih7xscnlrQkai//vt2g8/F/+fqiQ2hn
	DoEK0icolXfA2aCYfg7+OGOr3bZmLgY1Cq2bLow==
X-Google-Smtp-Source: AGHT+IEz2St+oougTQ8MqFuKuJUVfWWVyuoxnzbTYWuyapnt5J+bL+U5ZXlo8Is497jWF5UeoMYLMHnxFL5OrtSiHjg=
X-Received: by 2002:a05:6870:a1a8:b0:277:c027:1960 with SMTP id
 586e51a60fabf-2803a666717mr419542fac.25.1726776662497; Thu, 19 Sep 2024
 13:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKDm0rNaHbzoiPg=DeuCoxzooNAsxw2BJfc0wg7fC_-=o9uJ7w@mail.gmail.com>
 <7b4ce2fc-3763-4881-8459-e0c1f2cbc69d@gmail.com> <CAKDm0rMsXUpFSWRWkW0J0FUpEbot6wQqdzYTT5CLZ=3TGbV-OA@mail.gmail.com>
 <467f6fb4-5f83-416b-bc09-572a82f210ea@gmail.com> <CAKDm0rO6H4RTa5EXMrNvSy2swVegHveasY1koZXF5V7HvZzK0Q@mail.gmail.com>
 <xmqqsetv795s.fsf@gitster.g> <CAPig+cTDFcJiig7=Sf5vxsgzc8_ax5t7Vqy+-_x8OK_U5U6Qnw@mail.gmail.com>
In-Reply-To: <CAPig+cTDFcJiig7=Sf5vxsgzc8_ax5t7Vqy+-_x8OK_U5U6Qnw@mail.gmail.com>
From: Matt Liberty <mliberty@precisioninno.com>
Date: Thu, 19 Sep 2024 13:10:51 -0700
Message-ID: <CAKDm0rPNLtv48P4JOKNicMcrz=ZZwr9PwE207D_foj1r-pn5UQ@mail.gmail.com>
Subject: Re: fatal from submodule status --recursive when used with grep -q
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The exit code matters if you do "set -euo pipefail".

Matt


On Thu, Sep 19, 2024 at 12:40=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Thu, Sep 19, 2024 at 3:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > Matt Liberty <mliberty@precisioninno.com> writes:
> > > Yes and also to have a 0 exit code.  No error occurred from my perspe=
ctive.
> >
> > I am sympathetic to the line of reasoning, but I wouldn't go that
> > far.
> >
> > Running "yes | less" and killing it with 'q' saying "ok I've seen
> > enough", and running "yes" and killing it with '^C' saying "ok I've
> > seen enough" are pretty much the same from the end-user perspective.
> > You told the command to go away, and the command complied.  But I
> > haven't seen anybody complaining if they see a "Killed" message or
> > "echo $?" immediately after it says 130 for the latter.
>
> Regarding the exit code, it's not even clear how that factors into
> this discussion considering that, in the presented example,
> git-submodule is upstream of a pipe, thus its exit code is lost
> anyhow.
