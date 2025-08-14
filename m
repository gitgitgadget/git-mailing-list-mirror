Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD147347DD
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156218; cv=none; b=UHRID8OzyaGEVVXT5qFR7JRrPYCCN/j+pgYWoyCRCivhJj0nXueadIL3AhCZpZro+jf30rvQuQR/kA1EEZB9GjjCO8k8HjZrY1GAV5dMuhZEiLfppkBhyQKNa24EA8xoNI9iRgf2jEjgfUSLScQIRfqmhaOlH4FDspakMfsh7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156218; c=relaxed/simple;
	bh=+aE2iAacP5W7rBKFXC3x150fGQAbRDtSQdVbNfaQPaw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEB5RSRA9ET3EOIoyGNH8ORfg+4FAW3FgmfzhnKGs2NOt1LhbLQAGSuBXnvQ17Eb7o9w/uQkRI+D4g2hFguO2DHv0hXO1O8aMszfZDhyYRP0miGkLZJm6dr683ckHAgU2cD6CRUOEbT+Oe8GOeCgo/vuR/1zYepzGdoi0gz6LMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxMOVBVs; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxMOVBVs"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018fd51a1so380374241.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755156214; x=1755761014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCzbAUT8u+l8HAe8KKPCeXm7wPatOHqWbeqYS6XpfgM=;
        b=BxMOVBVsIVQ+r8lCMbUS7+oL87BUYkPftW2HAzEzZ9hksEGirZy4K0q+/4+n3oFgvK
         ln0oqBU6j8MIh9zTsDXVGNK1QmuOsmNUw5E+bT3yPQSjprQ+WzuTieqPgfT20INzKvig
         Ppms8gAHJrmG59iT5S7ztdzgb4PQJ/TyevHRYFjVkEX15ahUqxhaov0E5EYT3fiuwuFg
         CD2Z6ln+zdkpTdutez/vhPQmjmSgCTIji6gkCr0uXgU937MXBLLRfHC4StlDsnBcWCQm
         qKeI2Fyq2p8xFIgtdGLkXpiGPijcrdnyaybEmZgNSvwpZz9NWsrZCYJQO3O/ye/vjshG
         IUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156214; x=1755761014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCzbAUT8u+l8HAe8KKPCeXm7wPatOHqWbeqYS6XpfgM=;
        b=tyPf9l/NCG/Y87fZqCrJK3WoJMK5rVD18g5ZV2k629l6lG9NXn4m0wuzGscxEsEM+G
         ihAuVCTdP+su0QCMOsxB3XRfQBsePV8HTGKoEOhmOBIuRxnqHnVo/lIYnAvWLMI05Qxx
         DB7rcmAiFqb/6eQwdnFtAWIAtmY21YwlkP8YKNIDHeMzTxk761BArpbYLLsO/bj1CzsR
         r0UwZTGuXgPQ0lZ55yLemZUONuqfX95dZOFnOoKWKp+GyxuFI5AkRUkeXxrbzBENjfK1
         9rnLjICF1U9+AhjZWg7/3oi0oz0o6x8x4esOooinm63Q9Op3TVarQruJRZCt6JBqRoo9
         7znw==
X-Forwarded-Encrypted: i=1; AJvYcCX3U81pD9Lo0BnFZh6StJxNhS3WpDv5Qb/MJzamXjKwSE68G38/pDq4lwPDUrQslfRU50Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnsg+Kz1CKY3lTKolxDQzfNT/lukXCki5Sd+oY9ZsG7kbtLiIp
	GnudQN2jDocR8yLkMsWPd0IMREnD2sk5GDr8Pr+605LaXWTqOWaTkPpalZmjizHtRgjL7k8kZ9h
	2aukcraRnMqxrclduxaobktfPawF7xUg=
X-Gm-Gg: ASbGncv7bMlXD8mhQxlrGISg4rzvqhJCqeM53098VxhBxo6wG3f5tMiA34CwSZ5ezjQ
	f15stjD0R8etBdOALg/ELW/HOmrjGDjHw+fv+oJQapkPddWv35s1b/5T1CD0NsRKJE63Y4dX9rl
	/jEvq9hswgsfsZ8nWoJ1SJgsULw1lYIcbG/rjIkWv0LShxnXyxMnz5JEkPHmAjyCmcK8iMPFGDl
	iobBc5iLq8btwxO
X-Google-Smtp-Source: AGHT+IEs3fOqVz3QuTMLtidGq6K9Hwrpj4V9YxONkkGjjGdCMCDAZGgrwG8DlAirSLsXpYpxdRz0AzvVQ8dSqBRND/I=
X-Received: by 2002:a05:6102:3912:b0:4fc:156e:1046 with SMTP id
 ada2fe7eead31-50fea4b4338mr680659137.20.1755156214424; Thu, 14 Aug 2025
 00:23:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Aug 2025 00:23:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Aug 2025 00:23:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrdwtnvq.fsf@gitster.g>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
 <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
 <84258154-322c-4ef0-9ebb-44858a5d58fc@gmail.com> <CAOLa=ZQwwcfEQNbZqp3o6YfTWMhUr=s0Vw5jP87pUELsktLRaw@mail.gmail.com>
 <CALnO6CBqChfU62TJuk9mBd=gSbPKDEyBKv8r-rCygsRDD2yALQ@mail.gmail.com> <xmqqfrdwtnvq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Aug 2025 00:23:33 -0700
X-Gm-Features: Ac12FXz4dUJNxdC5MLpWYplF09S4pCzM-q8pGCaqv9V6SPxALiHovLigRWlFn0U
Message-ID: <CAOLa=ZQa9pNsTasx6oxN54Xiz37_o+qjikZVOJpyyBr9c16gAw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Content-Type: multipart/mixed; boundary="000000000000afc493063c4e26ac"

--000000000000afc493063c4e26ac
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>>> > Junio has already expressed a preference for "checkout" here c.f.
>>> > <xmqqldnte6h3.fsf@gitster.g>. I think that is technically correct as
>>> > "topic" can be a commitish and "git switch <object-id>" fails without
>>> > "--detach".
>
> I wanted the new documentation text to use what was already used in
> the parts of the document that are not touched; otherwise we end up
> with text that uses checkout in some places and switch in others,
> which would invite confusions among uninitiated readers, who
> rightfully would wonder what criteria were used to decide which one
> among these two different commands to use.  And teaching that these
> two commands are quasi-equivalent with possibly subtle differences
> is not what the documentation of "git rebase" needs to do---it is a
> distraction.
>
> I do not mind a new proposal to do a documentation sweep, aiming for
> Git 3.0 timeframe, to examine all mentions of "git checkout" in the
> documentation and replace them with "git switch" or "git restore"
> when appropriate (there are of course ones that are not for obvious
> reasons, like the ones in "git checkout" documentation itself, and
> possibly in "git switch" and "git restore" documentation pages that
> may say things like "'git switch X' is similar to 'git checkout Y'").
>

I think this is the best way to tackle this.

> But let's leave that outside this topic.
>

Agreed.

> Thanks.

--000000000000afc493063c4e26ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a9bc7f7b3599e120_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pZGp2UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOURqREFDZnA2bDNzZjltdkw0ZitIMGhJY04xUVJLSwpFZXlvbkd4Vjcx
YVNWdEpaa0x0V2R1V05xaUQ5YXJpQWNUd0Vka0Uyc1VqenZORmtYVnhxSXBMaE0yK1U2QlVmClI0
OU91OHlYaFY4VmZKNkt2WUpkU25qblNja0xialR1blBsZ25EK1RlK1p5ck1zT0lRUWhEaGh0dlNo
VjV6KzUKZXc4NEZmamh1UE5uTmJsbUgrNXoyaHhwc3RVcTdhM3hVTGlwS2pVTjF4Nmo4dkszRXhG
RS9VN3puMGl4VVUrcAo3MDJiQnhISVBZUnVqbUtxd0FxKzBwTUFHRDZFaHJ6b0ZONmFhVE9GZTZP
RWN4eUhnRkxiRWNlejZNQzZyZTZFCkFPcnF6eGFqZDErc0dHSithbjM5TmVKL3ZMVmk1MHZFK3Bm
RXBQWUJyVldacmcrbUJuK2FaYkt0RjRuZ2pscWsKZDZVSjJYWkhJendzRXV0a2t1bnlVLysrOHhF
d2tzT3pmZ09hcUhqb0FRMCtqamoyKy9IeTYrWEhkYWVGWSs3aQpKNUhtaXRmMTJzZzBUalVYaTlR
VEx6Y3d4bWc4cGxqc0h5cW9BTEc3Z3FreTZRMjZLUHNRc1JoOERTVXA2NlNJCktvVEt1bXR5bnZ5
S2Rra1hmS3NCYkgvb1VOeDZ3SmM2LzhxTll2UT0KPStaaEIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000afc493063c4e26ac--
