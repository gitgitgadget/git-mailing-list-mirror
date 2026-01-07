Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE6332912
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805970; cv=none; b=fhG26u8NelEms+Jv1c+X02eFtZRVjMSTjp/NwhzQzbMckFiNeS0r7vh85kIISB6t+RWl23DdwhflZyDS9wGU3N5qSmW+dHoyJMhNO+/pUtg1Ln69cg6fEkS+W3MinC97hcfdHIGxTN1o5xoMU8V8BSDeO5Km5raXdfpXAoIKDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805970; c=relaxed/simple;
	bh=EyVm3i1hBoVY/DKI7UqV4DGJGfuUlGvuJKnOjK2H3Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2gbJZSStu+c3gZxGqGHAaf0FCdmTptPwD9CtjcmAy4NfAjR6mmqkBEvwSdj0b0njUnEKZF/J/bJk63aUuPxXhHiFdUfIgrwUphDIa1ZI/LmClXPKg2w07T6oNG1CSCZkhGXuWWOvQcPQ1h1nyof5d4YQIYA0oPbRcAJ+hPmwoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDN9mk/b; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDN9mk/b"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1641225b3a.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 09:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767805968; x=1768410768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBz15lR9InLUmyL3Aw9dOKGn5iq3JilZVYdjdL/L3gc=;
        b=IDN9mk/blOzjF1DFapqFMe60E/qr7HAoyfK7G5eOz6o1gr33CWfgKduO/iZ0aQ5BTz
         oGQCO2z3NAak3h01Kn5/NVK92hzm7EF57FpF8EPCUiCp+jhgKqrbYOMwkchVSFA+TFUj
         d62EE3s8KK0miKIDm68Ct4Jg71OVx6294qDgT657RjBpBpODK9gIGhSOTsYWcp6v1l86
         wOg7nplxe7mewHht3hvFEHnF71ibTQuJIf6QHF1MI9fNQopEE8sAz514yj4rqp1IjIPN
         3E+H4xiRUuFZS6ey+MrmpKVlBOwgfpgGCOOwupLh+aDFV0iWO4FqxDkhzIRME+qyma5g
         M6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805968; x=1768410768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBz15lR9InLUmyL3Aw9dOKGn5iq3JilZVYdjdL/L3gc=;
        b=u/bwb6PCitSXU0gfMJq1y343325aA0j+b0Oe9k+5whagSrw1447KVAxwx1kbOq/KIV
         WVazy9B6L0N8+gZhJl1r9b6PNTjO9a69Vlog6GYOBS5navkLOugjeLFYc6KmB+WVFJs0
         x0HInA8ho8AjlXsPbNTO6mg8hZBk8jW5taNfKUqF+iEwRQhlHYID9EAJbsyFUkLn6atC
         Vh5tiXyl6sTNeeTnc/3tH8dSU80ULFwxKSCptFrrBmnYYGvv5w2rlp9W2E8h9g0W0f3B
         gdmKLS+7Qye5mpOWoYOrh5hiDa/Q5ueBK5hLYQAYofOxc7w7ftKIDl+MU1BGjx3+T9z3
         y0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXrIeLMBlnkYuB/9Oey+ChobvFf0Kto/YiVltpE2uCLn3gW6+KEk2xNXGaJeMELEHJlL5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5r/d6Qh8mMxUATEFboxp2h8ZRAb4gfEsG8vGkf3YuP7wiZNb
	22jlqHs4tnN/2SFfmW1FQQMUCRPZc8eC9e8uFSoQ8Add10M4rSxqTMzzDf+2BzWjR1W2NZvP7Mh
	ZlgXRYxrMij3tDWMgkl3SJR/UOebbXuA=
X-Gm-Gg: AY/fxX7OxWRYIVVYousefwSzCGfnT1VEP/jO4LG4J06CL+73pL+3r/1weCMAryEz2Mr
	ZD0f/1hc3fC7B+zxZ7kvnQ/UDcfYiCl5SmBuF2Gr5AgOEyXBUf/3L88+Gbp9Dwnq1O7D2GTUWnM
	LQJJ72rDDVaH3MwEtQdHhLGM06cId1Ic+VcdaeM3inFDxA/XVVOAI/aSMSvqKgozfQGMhz9blD+
	BGoPtkQHgvAS9uTX2IxXEkFS3J8GUPQCFSetSMdsd2LgqZpD0OlBbq0mfDSzG/L3Hk33/5EtIZ1
	8Ryyo0FfC+HhPbV7XDpE5r5PL4taYw==
X-Google-Smtp-Source: AGHT+IEQQnMov5qn4kAVTWsa8WQVJyDOvkm+IfYKjkm5hcCXJ2XxS2OEmU/obI2X83YNXblctJ5vzEsEtlS32DT9ruY=
X-Received: by 2002:a05:6a20:9185:b0:36a:ee9f:cefc with SMTP id
 adf61e73a8af0-3898f915622mr2976167637.17.1767805968152; Wed, 07 Jan 2026
 09:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im> <8e6dd4d7-6e0a-477a-b10c-8571d6b7da4c@codeberg.org>
 <aVvWDDtBeJMIF3F0@pks.im> <eecb1c9a-4dc9-4666-b2af-1e3478109db3@codeberg.org>
 <aVzcyYjR8l-xXD4L@pks.im> <39eb6099-49ec-4ebd-8347-e2f2e18f3e8a@app.fastmail.com>
 <xmqqbjj6jnpb.fsf@gitster.g>
In-Reply-To: <xmqqbjj6jnpb.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Jan 2026 12:12:36 -0500
X-Gm-Features: AQt7F2pl2ASqyLJZ53kna7b_8ls25Em6xMejhxoR8rIB1gyIDQ90haCMtTZBXKY
Message-ID: <CALnO6CDRPdXJ-HR0CK7VRf30NCWamX5yBE18uf+nJaM8FMJCmg@mail.gmail.com>
Subject: Re: git-last-modified on bare repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Gusted <gusted@codeberg.org>, git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 7:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > On Tue, Jan 6, 2026, at 10:58, Patrick Steinhardt wrote:
> >> On Tue, Jan 06, 2026 at 10:42:55AM +0100, Gusted wrote:
> >>> On 1/5/26 4:17 PM, Patrick Steinhardt wrote:
> >>>>[snip]
> >>>
> >>> Yup, git from source works! Do you by any chance know if 05491b90ce i=
s going
> >>> to be in v2.52.1?
> >>
> >> No idea, point releases are typically done rather ad-hoc. Let me Cc
> >> Junio though so that he's aware that we might want to pick this if we
> >> ever release v2.52.1.
> >
> > `RelNotes` says that this will be merged to `maint` later which points
> > at tag v2.52.0 currently.
> >
> >      * "git last-modified" used to mishandle "--" to mark the beginning=
 of
> >        pathspec, which has been corrected.
> >        (merge 05491b90ce js/last-modified-with-sparse-checkouts later t=
o maint).
>
> These are really "if we will produce a release out of 'maint', the
> topics marked with these can cleanly be merged to be part of it",
> and does not answer "if we ever have 2.52.1?" at all, though ;-)

Good to know; I'd had questions about that as well.

> I am on a bereavement leave now, so expect that my response will be
> leaky and slow.

Sorry to hear that. The only thing I know for sure is it gets easier with t=
ime.

--=20
D. Ben Knoble
