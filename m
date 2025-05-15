Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B186171C9
	for <git@vger.kernel.org>; Thu, 15 May 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747348754; cv=none; b=OadO1CpP261nEImhc+VnSd8/EYfsoXCD20q0dBEwkIrhHULbH0WPc3qK/cznPx2LM12AgzoE/xtmmMQmC+H66JLUnMkCrhjle30stvnO+GzKy6nlBzbxcNWfaBG+Z7cQDKvl2d2gtLPdCCguX2/ylzzZQnpkZ1KtDYqBbqkYI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747348754; c=relaxed/simple;
	bh=zbbR+IskSQZo15u6f/eV3iNa3VRSBC+u/ZpH6iWMzeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+g8gsSPHXbF0ETbKtyGjKqvI5ukEDnE6eOPLSzfzRK7FyCzXCL8WfYg+o4kjm15V7wzMLFs5EBsmP1klSIet4x82ZMsiggC5y+nJlqZw62cYL5Y4nOxPeB2Bd1YfdLpwf5nogK/tayh9qGk0ZTKmihYDgwCi1TLphgWqDZKmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BL2o9KAB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BL2o9KAB"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47666573242so126041cf.0
        for <git@vger.kernel.org>; Thu, 15 May 2025 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747348751; x=1747953551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbbR+IskSQZo15u6f/eV3iNa3VRSBC+u/ZpH6iWMzeA=;
        b=BL2o9KAB24DzK1okZenBj3EIFRD0N3LkuuYlMdOzijQ2WebZmRboY1qNP2UOOqZ/vk
         oulWoqmItM4p1lsx+aqragHIa8Q3WcM0gIqU0xOj5ZEEJK4wqjKtaTtcbsa+zmvAz23d
         AVGMvPH3lhsQZd1DmHAy8Vyd3YGtdiqCwQ/rbjteIvXA8iKUzqNHyGAReOCUvqseDiH0
         F+0g+KOq7zl2hTtKNq/49Jn54wBU7tUEKLRP1TB/YTzJG0FdahZ3LWqZMs8PS+j8wY10
         oGAnJGljkXqaXErxb2jI+sZmBmN+LJxCf4uowiZxOYpDcNVHxsEJYGGU6fvZ/1bAk4d2
         /5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747348751; x=1747953551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbbR+IskSQZo15u6f/eV3iNa3VRSBC+u/ZpH6iWMzeA=;
        b=DLCm5PhxjDAyQ0Lm/dfR92593MB9vd4bFsWcJoO7CAtLfIuE2mdSN5iDTys3shxS7A
         4QADErrNy7wYpo8DrObPcfxGRz4w8oS8rqA6kO5K9i0gYwwkDyVUQvNbqr+CA3HxRSxY
         ffv39XisITEawkG5yLAv2mQKQiGXgN0NAeL8WqxE2G5kw35qV3QTV7P4M53+JnasH2bX
         RICgway+4KCZcP3l4CsDfTZvp0SHCPf+Zt4pJGQ9EPd5lO+FKcf9gxXRiu53VTPbZb++
         IeE7BzSentj0W5BiSkXpeL7o0+hStQkmncnojiIEkQ9AH8HsUx1PZLN11pmxknq1yg59
         Qrsg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ODpDfrp/MVIC4HmMl57nsAyK5E6tOXREO9sgQ8lHSZ3oBLzCp2QlNBqJLZLUhVdNuMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVR2/VJk4KshwrDdmbUNt3NlA35+IT12Mdct2Z4y9qbXoeRPo
	jBQq0orMu+zeVnJqlUGZjKnkp677oA5e3BXtGAuMPty7/KEwy+EHIDY1hb6NjJho8+TrUQu+n4F
	cyaHv+f3/S0S53ntXB6S4+CYlu6ICj5+Muzf/4Bvj
X-Gm-Gg: ASbGncv8TZf2XR4LbzgsRXELdJu5fedSuCvrp5bE6qq9NWSLQoPJxUFPFCXHZpTv/XB
	jH1UubfVneryf8lt/8YgZIXVV6GFFAjWqr0juCsJnWOVBFU4q8AC882QpMO/f3eMTUKXTeh9gK1
	Iz53Z687Dq4MIG/qClYQpiwkwrCJQklF4EK0HS6iaXSpGSR+oz5LBrpiZ1EYkkIoA=
X-Google-Smtp-Source: AGHT+IEdasAZX0pdRmr9JulCLmTgAExk0+yr3TGJi2WzFT/zgXHGHCVmoMUwhOnfUMztRW2Xv0ANQtRC9cHdnm0jHWg=
X-Received: by 2002:ac8:7f83:0:b0:47d:4e8a:97f0 with SMTP id
 d75a77b69052e-494a339f327mr6124371cf.29.1747348751080; Thu, 15 May 2025
 15:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
 <xmqqr01si441.fsf@gitster.g> <CA+rGoLfbshrkPvvQorMq4n1RkVnyL8XfJ9UjMFRA-6dG4QKdcw@mail.gmail.com>
 <xmqqtt5ncq87.fsf@gitster.g> <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
In-Reply-To: <CA+rGoLfcJ2r8S515msG5L-59=0nOBvdOX2TTn+-iaHw8v6Ndtw@mail.gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 15 May 2025 15:38:58 -0700
X-Gm-Features: AX0GCFv6Pq3fQb9ueI-Wpgnm7zW0s4x7qXr-3k0ILzZJ3Hi0L0R99gjuhJLZYhU
Message-ID: <CAJoAoZnYOjqgeW8Stuj5T9qcxmUBE=_j_ufO8Hdbn3GV8LmMzA@mail.gmail.com>
Subject: Re: [PATCH 0/4] update MyFirstContribution with current code base
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, levraiphilippeblain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:07=E2=80=AFAM JAYATHEERTH K
<jayatheerthkulkarni2005@gmail.com> wrote:
> As far as I see
>
> Emily Shaffer (9)
> Philippe Blain (5)
>
> Have the two highest logs
> I think Emily is not active in Git

Mostly I lurk these days :) I do still keep an eye on the list. Will
happily take a look at your series tomorrow, I'm out of time for
today. But per what I mention below, if you don't hear from me, please
don't feel blocked by the review, as I think the MyFirstContribution
doc is comfortably maintained by the whole project by now.

> So for now I will cc Philippe

For what it's worth, I don't think it is harmful to CC people even if
they will be inactive. CCing someone is not necessarily the same thing
as saying that person needs to approve your code change, right? So I
don't see the harm in CCing with low expectations - in fact, in my
case it would help make the email stand out, so you'd be more likely
to get a review from me (I missed this thread going by initially).


 - Emily
