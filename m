Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F762803F3
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109056; cv=none; b=U5ES7G+DNMsK7M6x/1iGJGPgO0xRV+QDghq9/i0iRwTWZmqmf+09exLWufyHUiJanvQ4KfXwQKD176lscQOPKusmS1ZUUa7A9Cf7LnXKTTkSee+drsZPc7vH/zNI4xIIyfD+qo+ocywNCbE1SOmC/bLbd/g+SPRVvZZ/LdA6+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109056; c=relaxed/simple;
	bh=ZrIwISbcudXmwn9OdE01pfNFktDXKUMJ1w3dOv/gGi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUofAEB5rcpQZobW1gnUqvX56Lyq+D+MEmJAllUMA1J7pRmPmys0L+wYPowO3VzLoQuPLNlEBNamRWl1DEgGIIvKRfflobbYWnzIME/qD4HXnLCeLSxGdcMNHIwg6FIopkXyPb7JL+pB05uNVWFDss9kn/zh2EMB57NgicZhBoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORUpkaes; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORUpkaes"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5452c29bacfso6453335e87.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741109053; x=1741713853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZAzJ4ed4k7hY1Y5BQvSVuUfkkA9LiYR3e3oEEnBV9w=;
        b=ORUpkaesIfnVNMaf2249HazOFAKWyBx77TPvWRPFTH/qz8WhBHitwQIzrnMUwWD+uC
         txGgIF0TUmPnSM8qa7ugNfiT3hf4ipfgrG4F3Y8qpo0dXyws6WE6Fz6baX4JxmTFu93m
         dsoZkWjIdsmi1KmAL2JQJ+agR7XM6ptW/GFg3FqGAUXmZS2hQ5Cx/qvQqia05aNJAHDJ
         +vfQVPvG4Ko/tMpfq9Lnxtoo1V5narHIK9KlWnCHIZaVMrEg0E8TRjlnPRfe4PikZwUg
         68P4VUpcsvcYp+sF3o0gfJR7Zd9HYdEZrgfdIT3Auzm/qcBHuVloTMqeVt895ce7CKbd
         bXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741109053; x=1741713853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZAzJ4ed4k7hY1Y5BQvSVuUfkkA9LiYR3e3oEEnBV9w=;
        b=a81ae6X2sJxC+JSrPQVTOYKniCnIN2a3WlAfBuwoxinviny/QXtHDV1QYdgOay2EsB
         7L8obHimBGbqYzZAjjG6UJ3+1R8RJzQ5AVb+PKYQxrXVbtSCXM00ii+plBvX5CmTbCJ9
         trLSuJEDlmmbQvW3p0Mo8BiaYy97v+WNT72uaev9rS5OzFPvPyQQ9La66Dev5l626ijn
         kOBsYXQ8BQspTajjf51XePavnyiMKRGTSBQ0TT85tYbVpBB2X7Hz6GPRB1jll9xr5avW
         6BvKmMw5/Zb7+E0dg2v3SSGpH5RkxQ9Stx60bQCt8DPhehM/BdnOEyTdeM6i97+EfOZh
         +hQA==
X-Forwarded-Encrypted: i=1; AJvYcCW1738ruZ4M54acOB2YziJXXlFAXJjCt292SAq4g090vbdSQ3n/JQVQULqwcCW5Ec3qzS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJ16qIsG9fRwfB5B4J2Q4yXE5stHhmgkcLdJ24EiyZBYNr+p2
	Zgg4vuUIZNrrnc2ITdPsxfYRSJfnfkl5oIGAoI5oX9kW6wSpECtqr4vnBQADanqCzq9sUOF67AC
	+ZAhxAx576AI6t2j+2kE+gMWKy5A=
X-Gm-Gg: ASbGncssP0ty6F9uyOCguxURHY3C0L61mzxM4l0HexRkbGH6zgVTp6B+jtBYUrd8wsF
	S+bkvkbSlphKaHVXdH3x/F290n7oGcoqwIryEpI7aMpANPCiDjA5JUma+nZhHKC1Xfx7Ub/WLtB
	tYv9VYPAfT3mXI0xZvJOnrr06v/NABj43bgQQbLHiG/btpAi1pDnvAijJ9aA==
X-Google-Smtp-Source: AGHT+IEJgenIk8jYCu+mBUdI3YjfIFIUtFkBn2/wFhu1FIB4OMJ/Evd2P/DKfW2XJ2mkVyxumyveecJHhHdIxuPLLho=
X-Received: by 2002:a05:6512:3189:b0:545:3032:bc50 with SMTP id
 2adb3069b0e04-5494c320d3cmr7557730e87.19.1741109051783; Tue, 04 Mar 2025
 09:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
 <20250301105838.1481-2-danimahendra0904@gmail.com> <Z8WD2MeHpOH7Ni8A@pks.im>
 <CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com> <xmqqldtlt304.fsf@gitster.g>
In-Reply-To: <xmqqldtlt304.fsf@gitster.g>
From: Mahendra Dani <danimahendra0904@gmail.com>
Date: Tue, 4 Mar 2025 22:54:00 +0530
X-Gm-Features: AQ5f1JpSiiNq40zhsgt7JjnC3VjIEwLC1JaagCw5xpP9oUN14irrtJV7Qbq-iqY
Message-ID: <CABGrwBAaN3U8WCtPgd+UjVjsoBniCawWV3U+WdKOzBdG5LxmAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Mahendra Dani <danimahendra0904@gmail.com> writes:
>
> >> >       remove_object() {
> >> >               file=3D$(sha1_file "$*") &&
> >> > -             test -e "$file" &&
> >> > +             test_path_exists "$file" &&
> >> >               rm -f "$file"
> >> >       } &&
> >>
> >> The refactoring is true to the original spirit of the preimage indeed.
> >> But we could also improve it even further if we verified that the path
> >> not only exists, but exists and is a file via `test_path_is_file()`. I=
f
> >> we decide to do that we should also explain the change in the commit
> >> message.
> >
> > Yes, sure.
> > I will improve it further using the `test_path_is_file()` helper
> > function and change the commit message in v2 patch.
>
> You may want to think about why there is "-f" there.  If we remove
> it, do we still need to have any check there?

Here, the "-f" flag in `rm -f "$file"` does not produce an error message ev=
en
if the file does not exist [1], thus the `test -e "$file"` check was redund=
ant,
as pointed out by Patrick in [2].

However, switching to `test_path_is_file()` would provide additional safety=
 by
ensuring that we only attempt to remove a regular file and not a directory.

[References]
1. https://man7.org/linux/man-pages/man1/rm.1.html
2. https://lore.kernel.org/git/Z8bd3iHrhXb4WH6A@pks.im/
