Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634514FDE42
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419929; cv=none; b=QvVI2yjnQ3vcoeQtrlXBfhCvZPxTAmmRIO9pCoWzAJqN9TLgzEEj1qdLCgFwserWKQcEmt08iromy9BoAWjpkxzGbMJvylaxRGbdPTn4mplgN1CBVOKoRupkk3XT5zabWV5sWDIBHUITbturKhCp069N9Af7SdAD2v+iEwJme3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419929; c=relaxed/simple;
	bh=9gE81C14J3Pmr2vEf9Z5aKqz9yeALteQTxY1XnDPIo4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=dfieaYRHh2Kq7UDoCPYUSLIFAY+R/oL8E8jZo2BcefNlwIKdF6kjX+Ot+vqRvhGMiat9glfCE6oStoEIVVrSampi4iHMovJD3aD/G4zu0zSK2coE3W0xgPk4JFqwVuK++b2r9B4PUhEHnRpqZlYUIroAzV4Nsn+oxNJw0ghuodE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsIKRARX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsIKRARX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b10ac6ab7bso6655047b3.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792419927; x=1793024727; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9gE81C14J3Pmr2vEf9Z5aKqz9yeALteQTxY1XnDPIo4=;
        b=OsIKRARXQBUV5I/LOoYzLFUXkUDivDj/xIT9UWMTW8w7fLGYBZlYjOi/F943D4MLH8
         87OL6CJswuPiP536/n+RXxEZY1TyxOho1DRHj3CFogRjT03yTgTStp++OU/SoFGQ//1z
         GCmn7ehSuC+8kj/ifUPJbImLg3qBku2aVL500bkDMa1Zmcng3gfy+KhCXuRs7HmiXB4L
         or7YAjBGWH0jaa9vO4OAkBWUZ5m3CucnMJATDkP19HeYiR/QOt6DS48VDanoBx1jxzGS
         mtzi1jBeN1vZDi0PpNoxadFxI5hDSilGqfySOoTfLJSs5iRmGhtOA+sHfGhUVY1+iSdN
         /D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419927; x=1793024727;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gE81C14J3Pmr2vEf9Z5aKqz9yeALteQTxY1XnDPIo4=;
        b=NPyc5pVfXlybL4hZJIwN00RG5x2t0TRAkqJVfoEtCZlfPNhmtiYaEi/pLkE8XjpzPz
         4KnD4PQV31J/xiYB9kyAlIkMfF6jvlgm4nC25RYIet1kk4El3wS1ral9EhhwLCFHJfVl
         4QHmE794HjoSsCfyFaxaUyFsOBGXfpPG2klHInmgAO+JaFfrdZs8Igc1WmJFA2MQD8NN
         YWMHMrzRweU6ugwEbacoVEZJY/sxLI1zEUvmtW98tn3/N34+TemJt1CMEsIG5O+LD9bD
         HSmo2hWlde3fwph1s4vuGzUW2NTyt69rhpvSU4yCONPqlAuSYYQwIBBdJmQWvBshRCF8
         pWew==
X-Forwarded-Encrypted: i=1; AKwUvBwubXhgSgbcvULg9hjg/8GFqTu4zBFdVsS7MpXyyRJSfsaatdDBnTJhjzFu2YzhmE1Vduk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwVIQw2vvoHYyKshX8GwDguErdg1yYORDUPtIDuJ9avGERM6ka
	SN1QfJ/rrZwIzBGh3hdSjjw+jWisdecdVdDMeFm+vdahDJVDeTrh6FXw
X-Gm-Gg: AYBFou3kOVbwHhnl+4ey5/YNwCewOVHyZdkAKkng23iSp9XALf9AwNuUCrGsYcTN/uj
	qFAyF+MSBeTT7cf8xJKPdXQu40SoPkkpRnxYwggKLNIgHlvkhxktDwOk7FlNwYuiQopZlhYJYDG
	ql5OU7lK1l1PGqqONLkIc36SfhAL3HvHGHI5zSkB5ErEBb9uEcgG6U8hSoAEDvY/SlS0KhXI1Kr
	A5wDSZONi4o2Fr+PNepC4qZZ7QcwtcfKvb/PteLhm/FrS32Db8P9ejN8YuDD3DjnupM1BQg+a0E
	HfRgmfdwGuLddEc4WQcoXw1Er8vvHQ+xUcQ/kfjQarrqOAw47k77CsYy+6eY6gdw+VPB54/w3Nd
	SgD2AKvMSf9ioes75flXalYfaQ5cz9ZlAMmZOT7rabfb1qRFl0EOP1HVMEX0Q0i6gq75ti8vDQR
	oog951XeioLXWWIYgQFz8KAxv6CKMLSZ8LZTAIbzD76Z2aXj53Tvw9NtJqWlkNwqXwTOni0TTzX
	XKiexuuf5CSA2NcgBEgFWSyr+iOSdkEYjMzDTgdPfzfJhVKdH3XjM7sECosI8H5G73SyHkdVBwb
	OzQy4bbQQrXU5Y39AEAOdJg3gwtUXoOB784dMl+daf2w3dIM
X-Received: by 2002:a05:690c:83:b0:8b0:b1dd:c096 with SMTP id 00721157ae682-8b0f21d0d11mr27440417b3.45.1792419927136;
        Mon, 19 Oct 2026 07:25:27 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1909:b48c:a809:b114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b8579b4sm1034537b3.28.2026.10.19.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:25:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] branch: let inherit track a remote-tracking start point
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <CAHwyqnVwnMi+DzQDvS6mgUzg-CWACUviVkYv-UiYJT+Yq83QLg@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Date: Mon, 19 Oct 2026 10:25:15 -0400
Message-Id: <BCD8B077-5A67-4A56-9DEB-9B482D580226@gmail.com>
References: <CAHwyqnVwnMi+DzQDvS6mgUzg-CWACUviVkYv-UiYJT+Yq83QLg@mail.gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 17 oct. 2026 =C3=A0 05:55, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BFOn Fri, Oct 16, 2026 at 6:55=E2=80=AFPM Junio C Hamano <gitster@p=
obox.com> wrote:
>> Looking at the originating commit d3115660b4 (branch: add flags and
>> config to inherit tracking, 2021-12-20), it only talks about what
>> they want to do when the starting point does track something, and
>> forgets to say what they want when it does not track anything (the
>> author CC'ed in case he retains the memory of the motivation from 5
>> years ago), but if you ask me _now_, not doing anything, i.e., the
>> behaviour the old commit happened to have implemented without
>> explanation does sound like the right thing to do.
>> What we should do if this change of behaviour turns out to be
>> undesirable?
>> Perhaps `inherit` should gain a synonym `inherit-or-ignore` for
>> those who prefer the current behaviour, and we want two extra
>> behaviours, `inherit-or-fail` that complains and dies if the
>> specified starting point does not have anything for the new branch
>> to inherit, and `inherit-or-direct` that uses the fallback
>> definition, or something?
>=20
> Seems quite overkill for the relatively small problem this is solving.
> But it would be interesting to hear the original author's POV.

Overkill, possibly, but easier to expand in a compatible way over time
(other than piling new modifier --options on top, which makes the CLI confus=
ing IMO).=
