Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34C307AC6
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819030; cv=none; b=dt/WWVqebIMmNxxizkCORPFct+SsTNQC+Tf2BlRvMwYhX74MyDrpUvEGQRoaMYheYyigHKxZmett3meHSBuVuKcqEPr3Q+5JY0Xd23mpXtAnHW6wWDw8eVSSDrFTGRfsxa8YypanLlSy7ajIfys66rAnWePTS5PKGDa/S75Vuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819030; c=relaxed/simple;
	bh=uShn3BudShvVxhLqOUDmu1GeJHfeUNbrByITEF37w9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xch7f8NszEPdsk2ai6Yzgg1XrEmz1wA14ekDW7JrP3yoEmDOoa+4ThrefvHzMnlHEmT0hOVV6kO9Icd++znQTLpEZklH4O+q80lnk+6g0q7NP/atOTfJkYlQZecVQFboy4U8qxXkwrKzeQgfonM2RDsH8CIXbhk/HKE/CJkWiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ4DS6B/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ4DS6B/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3436d6ca17bso2721041a91.3
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 15:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762819024; x=1763423824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa4zWG/70VzVqBojhqO4hUjuCL0xg8GVROfPhtU6r5A=;
        b=SZ4DS6B/p6B0pQk/8/sLkHAQIpk+M+p24LIj4XINkzWqXhJdmSUN63yliqhpMRq1aK
         xFCJ1cqMbOtu4YNGuRxQCUdsxrvkrm0dCpW8wd8gR3HkpLx82MsZCICL11dYHRN2X/5F
         rHREt+X9pU9y6t5pcGM2jEeo5Qc9BnNh63PqoPNskc1lfIgdjsA+qnHl9PjVqaY5F2N3
         oS4SpaIw4oGojySkwzCyxe7vHZoWDqQ1cvJIB4UfiHxCrx5u9T7xnD9cvyogMnIIGJGo
         5z88cqOeC0iSDy62s71kltaaNQHUvtvhWNPVze4dML/KDfv/zAet8/73G50MMQvX6BHK
         iYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819024; x=1763423824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xa4zWG/70VzVqBojhqO4hUjuCL0xg8GVROfPhtU6r5A=;
        b=Ny9Szr6RLL7zS2ElRlira1lmsZw/Yxi666zZ6uPE6EYUwFYbRFgcG3mWvYIhNeU5gw
         8NZOdxMGo/YOcZyxaGk/Ab8IdhXT+GK1ApNU9DoKsAtYtjA73ESK3OBaOmVxbIiRGGIK
         KQt1G0aoTtm4vQs40Mk9uRpXf33H/IOQTidk+OqSTl2Jq9rdhhKGGCcXvmFo0ayzcWqT
         CM9cOde974Wm7wM0eWp+8Zsy1psz1PYiD0VZxo5EtyOs3U3abHtckDLwN2D18sAYMITE
         Va2n9ii39IINsgLaGdDXjUK4nSUo3KmMAHV751uy/818TriGhATbVO18qcwmwJUT9c4a
         NBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtMOviZgq1uE/FatqEwwnGPWQv43k1YMMR/Hu7OYCaH/LP1aJAJ2Tnnb5x0FHNdEOw4as=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTY3ZLSQbTrWWAFTyKzc4HnkAsNYujPjIp2F+deaJCoMNZtMse
	+GCv7NO4zygeKYIbpwyJej5yNrXqBJozWHieqJoqpPutztI+SCnlHCD55rd59Wv4vfMq4pY1xex
	GbcANrzqQ+aj1aZg3P4poavMDzO/6HWyj25TE
X-Gm-Gg: ASbGnctbbxNqEEeMcswhrdyhzvfgkpurpXefuUt1FcgLZSxakHrB7tzhgzqNW7I80IC
	rzgNvDd6/tiZ7WRy+TgXmhD7eqRujzefQATGZPX0iS4Z6zYKaHlG3eb4Dg8t2g/l79M01y8nQZq
	O0+COPhS4r4jdxROsMBVSHP25uPyN6z9Uxj4ydlcRmqoA98W21hXQnGMn0DCU1bG0PZhP/6O9xx
	yWFUwf1OOtoaJ9M7h5VyfhzoRVXYQEWudWAEC8rRciFZpwRE0q5SiUZsRzprdYy7AEzbWl0
X-Google-Smtp-Source: AGHT+IFkXuglpcqeCB0QNjw6crMNv9Gu0j8VzVS+ZgFGgFpcHp+C2oelwhv/h+M1GlsQ9KMEDcBm9L/85oME6GKR93U=
X-Received: by 2002:a17:90b:2e85:b0:340:c261:f9db with SMTP id
 98e67ed59e1d1-3436cb946c8mr12599780a91.10.1762819024461; Mon, 10 Nov 2025
 15:57:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104020928.582199-1-gitster@pobox.com> <20251104020928.582199-12-gitster@pobox.com>
 <7aa91693-bece-4fa6-ab14-f914d6fd49bd@gmail.com> <xmqq8qgd20no.fsf@gitster.g>
In-Reply-To: <xmqq8qgd20no.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Nov 2025 18:56:53 -0500
X-Gm-Features: AWmQ_bkRqZPijT_ld5n5kc7BhnGoaA_eBj8Yswt_04xtC4k36AzJO196RiRLxWY
Message-ID: <CALnO6CBFmzhDA98N+AvezqSwaDmBsYvq4R4+1iko4c1RkYcwfw@mail.gmail.com>
Subject: Re: [PATCH 11/12] diff: highlight and error out on incomplete lines
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > On 04/11/2025 02:09, Junio C Hamano wrote:
> >> +test_expect_success "incomplete line in both pre- and post-image cont=
ext" '
> >> +    (echo foo && echo baz | tr -d "\012") >x &&
> >
> > 'printf "foo\nbaz"' might be clearer and save us forking "tr"
>
> Perhaps.  I find it much harder to read and uglier, though.

Funny, I find it easier to reason about.

It saves not only the tr fork but the subshell, too.

--=20
D. Ben Knoble
