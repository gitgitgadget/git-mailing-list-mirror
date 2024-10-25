Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40C18C92C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836680; cv=none; b=KAcs/RUvWAan9aEl0kfTXZTGoq9TVaX9qyH5M55yJYl1H6DiXYHALtwQr61Rv63bgP1wor6S4JBneKC13CPG0axasblcBJ1gf6k5182cvnRcZ+zSoqP0/fpTOzfryyj+MFui9uzWskw1dikbKS8n2yt9vavZdF+Rj9Fgdyj8TBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836680; c=relaxed/simple;
	bh=EwD/JTHT61grrLvk5SVjEl3DSHuOEChOw2+ZWO/ErLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvDFvOJkOBGgEvSA1rYPUDFbQHPoec/37ODraw7MAa5+JivDr7UB1btjDZi7jjO7YsFErHxW0xjQl8+b1MV3OScBsFMflHNp6KECmRUiwWImA1cHXyPmEJ4lcsCqEOVAOM2BSyZTlwaLEG9Za+t+ZRRirlev55V8n8hp7U/zD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj+ErUDc; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj+ErUDc"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso1418140241.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729836677; x=1730441477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo6fOWrYHBDzQK91fu3PRBv1whM7MIwA9whLgpBrhLg=;
        b=Lj+ErUDci7WdV90XBEsZGy0aFk14sqKwNIAg+Po9j7G7GpS7rYQY94bMpQmn/Af15Q
         CX4PDQmToYFptOS+LbTdwmCQpAV59LnTe0EPDjjbeOIUe/kJ3fUVFqfdyDwS1pKD9m1Z
         zFVvj8wmmPGAAQTjwXzI3T4MS6Ooi51+LgZ06CgsALd+AAunI6sKgRY/RnIn7+F18PRA
         pj8XP1UuK+SAsdItUIo7CRBoHN37AJ2UWvIPL1X0A8fAwImBrXtVZXdRbpXOtgQLTVxY
         GAYp1kCVx23q1n/D3atI+FeAB8uu1qvP4BT7rUyzPDOrdMxrIvUyb8KpT+RmKXcPTdEs
         qnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836677; x=1730441477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eo6fOWrYHBDzQK91fu3PRBv1whM7MIwA9whLgpBrhLg=;
        b=HQUiJKCCx8B11knGSOqfwqyY0eLzUUO+VWRsCalgBtegJJfb5A7QiSjPSkfTgi3F3J
         Dug8QvPSLnAOdK4RpDifwW5Emrw33hsBQZH5W8NnGASvVl6NTccnrAtgtPzKaOq2baiK
         ONPyYxg3hkcSiaUdyCHHqIM9McKuPx5IxfBV1bfuhfYmzMuLNxXHBRbHXRVglJXdrinG
         UuJmxTzUrQmZ8VN8Np9tb/p4wyz+t116y0pNeH8TAgBImRslpjnPUbBgIY2xJsvmC8+w
         eaheq57mhBIE37XXUK4JCKRUYIxye6ZfK+sx9HeU9IF9pbhf7fKfpDP1p7LH109uwwa7
         dTWg==
X-Forwarded-Encrypted: i=1; AJvYcCU79xSic2LmCaVkW14jXHGOfjpvGbwB2rnklpI2Jfb3U+uG84t/ChIpQnqXrLAUNhdeqrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKwMKSOB4ReQFp7YWOctkQHLZYbsWDzH4oa/nKMOSApQYRqvJ
	GhquuV4oKLoLEfnSj2Z3VHa7LIwskAqA2a55YwqzxGNHS0RLPVttrH8G+BjDbKwBnz+V9urDOah
	ywr0A7L9+TD9TK9266km+Y8SIiK/iObk4
X-Google-Smtp-Source: AGHT+IEaejMWyJ6rcXBLw5Iacgaly05x96niRQEQuva+LudiQ4TePnnqrQfFD6Ud5rMNBKp+LmOc8lyHRJTpVDeR7Bk=
X-Received: by 2002:a05:6122:922:b0:50a:cbdb:b929 with SMTP id
 71dfb90a1353d-50feb3002ffmr4096409e0c.2.1729836677302; Thu, 24 Oct 2024
 23:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
 <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com> <ZxqL4MId4ah+OmTW@nand.local>
 <Zxsncryo3cdbgxu7@pks.im>
In-Reply-To: <Zxsncryo3cdbgxu7@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 25 Oct 2024 06:11:05 +0000
Message-ID: <CAPSxiM-jFOjiX2QpJjLM-LD9ci0JMV_vvD0Y0QiPNkwS1GPfLg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, 
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Oct 24, 2024 at 02:03:12PM -0400, Taylor Blau wrote:
> > On Thu, Oct 24, 2024 at 12:24:55AM +0000, Usman Akinyemi via GitGitGadg=
et wrote:
> > > Usman Akinyemi (3):
> > >   daemon: replace atoi() with strtoul_ui() and strtol_i()
> > >   merge: replace atoi() with strtol_i() for marker size validation
> > >   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
> > >     parsing
> >
> > Thanks, this new round looks quite good to me. Do others have thoughts
> > on this, or are we ready to start merging it down?
>
> I'm happy with this version.
>
> Patrick
Thanks to Patrick and Taylor, I really appreciate your time and mentorship.
