Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1A6BB20
	for <git@vger.kernel.org>; Tue,  7 May 2024 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061114; cv=none; b=H6vf3LycYVzXSMU9+gJk2zwlVtxa7nod4XSzbjAc0iObYc+V98z/J4OTeOLaCJ9QPITqd/BK665R9Ed/lS8ZijS+w3Bh3PuWqXmfDstfT/tupyluOsZQVEwAsVUuYC1A4EgYLxRZIE85jP2eaCoMlCO+Eryp6JCoSFOtBWbO0EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061114; c=relaxed/simple;
	bh=LNnrYFQNa9wvCsgUghCsSZIxm5H42BPTFnq32jBgoBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLDMdyvl6Hh6touZ/P040GiB+5akYTZGQOTgEh3Ai4n2MRN4TaXWjMCf4A5oIqfYGhS0P7H30bZArBIM2ivm371uqr6NI1GhoSWFSAwOd6A3UgiBC0aYWeDZSMKuuRP+E32QmsxkTAyUYHGEcbB4fUm0xkKTHNg0Uprwlyqp2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1KlhEcg; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1KlhEcg"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7da37436e36so157443839f.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 22:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061112; x=1715665912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjnBBsnv3DpOYTI5DZjo2oPVZ6AaU1WxnNaDxv/lhbE=;
        b=D1KlhEcghULGcU8yTH10g90P04Pfr5O99fme3o5d7JMe/fd9QORu+pRy0Lv/UeN0ap
         C6u79ocLWa8XgYbeHjAtOdsfy5+H9pqIwGt34qP69agzVQrs4OfqTMwCkrT8KT0XFtPn
         xVjRj6l2lhPvJu2j5UCArtARSMsvXKhlXlLJYNTDXUyorwQBdpIM1OL8J74SgQ0Eo2xm
         yABazOjhG/lRbNbJRvRv6Okn5O0MW1MIAeAq5yBC9BPw+xNw6hj8ZGe2D+dXBS+NKCYj
         4kyJzc/n+TT0+DC84gPLNJc2HOQHBwX4hlyRwEI8UDi4Now0pU1ppS49R9tWwSUeMwSP
         juWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061112; x=1715665912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjnBBsnv3DpOYTI5DZjo2oPVZ6AaU1WxnNaDxv/lhbE=;
        b=qU/Tz2fju51nmzNWhnBhaF2ROkvaOzPd+5YeW2quPP0fjtYMn85o43nOCkanF6cPRe
         UCOr6xKu9DGZFB+qfTzwu7B/j5GxbbD5ME4OuMn0NZo5pv9p0C18aktAR07GKLW+6JzC
         for43hctDR+fnTF1oI4YCsjtqdoy0WkXi31droZ4KXwjwm7ozU5mMXTKRWfnCw5SsivS
         yJ7Nd9e+ld33cz1+YbFuade0ZQIPPWeJ6wBfQowg5BL4uKu5lN0I4Ii6Xwl8gHkxD5MA
         4j2QswSwEd/5hJAIXa4jHAVFi9jtn1rYx1Uh1j98nXwtgXmCAkn3EJ4vGMYp+idUBW7f
         HTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvm6sUnEbY0qTusRDgNzNfFTFqIa+yyigEITt6yjpAyJKxYPCnSr7hulDXLP+lYpyXk54leWRhkZ0Kr9vRfTg89a+L
X-Gm-Message-State: AOJu0Yz3669QzMJ7Esq88THvAk5zwrjXB2X8nZCrVvWGlwfOfJiGHRw5
	q7nqg5rKn92uk2hVeMJPbzMqrDvXY97UWqZnAhs7h06YyUj2Rwe/2RlvyRQ6UjA+kG7rGuoSG12
	J8reuGAZUPCOl1V4WfuwdYkj8ZikxNA==
X-Google-Smtp-Source: AGHT+IFJ4r3H2WJX02bu6+Ml026plwHPutToeYPLV4ZikPax9CK7IDPPwelIWWHTe1q+qXCm6BUcq5As6BAt3y8UziU=
X-Received: by 2002:a6b:f115:0:b0:7e1:7ae7:9cda with SMTP id
 e21-20020a6bf115000000b007e17ae79cdamr2581403iog.12.1715061111722; Mon, 06
 May 2024 22:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
 <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
 <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com> <xmqqttjaydbw.fsf@gitster.g>
In-Reply-To: <xmqqttjaydbw.fsf@gitster.g>
From: Ivan Tse <ivan.tse1@gmail.com>
Date: Tue, 7 May 2024 01:51:40 -0400
Message-ID: <CA+WCWMyxBA90QRsxn-i0H1TRi7WrhRcD=Tgj07f_Y_=UVNkhbw@mail.gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, 
	Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 3:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> index a098d14ea00..97473f377d1 100644
> >> --- a/refs/files-backend.c
> >> +++ b/refs/files-backend.c
> >> @@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *r=
efs,
> >>               */
> >>              if (refs_verify_refname_available(
> >>                                  refs->packed_ref_store, refname,
> >> -                                extras, NULL, err))
> >> +                                extras, NULL, err)) {
> >> +                    ret =3D TRANSACTION_NAME_CONFLICT;
> >>                      goto error_return;
> >> +            }
> >>      }
> >>
> >>      ret =3D 0;
> >>
> >
> > Shouldn't we also do this change in `lock_ref_oid_basic` where we gathe=
r
> > the same lock again for creating the reflog entry?
>
> An interesting question.

Hi!

Apologies but I'm not sure I follow - could you elaborate? I am not
too familiar with the Git source code (or C language) but from looking
at `lock_ref_oid_basic`, it looks like that function returns a lock
struct and not an integer success/error code. I'm not sure how we
would apply this change in that function as well?
