Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12213126C03
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629145; cv=none; b=LPlgZ6eiZSyPU8CtJ13bA9dzqkaKCKe4ASRBb4Pzbld4bscnY6NRFv/SUs6vSrrM4+IUssT1lQXv2XeF1G5cGsJ0O/6mVMBlo0vHtRLAs3jST74lF29HDRAr9GJdsi11PO2hQQqu7cuBqbv1aXImizukXThYFV5VLxDUDzs6GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629145; c=relaxed/simple;
	bh=XW9WveIAkxDdRmOgKoN3Gu2p+pDa3DzGMeCTSCmpZ0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YmV4s+wtukkL61X9BWDsRDSZ5VIpXWHpJ3omRz4bpxSL9qkotNpYsT2pT/pNDkWikAds5LbBhzRUQSrzWdbhzaDwfOlaEBOjad9SkZ19LdAOm76hOtQ/TPdCNx3Z8iLTrtw2GXPdX4dELdzcGPZcv8j0MaAdT/s54PNKgf43x3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2w0SbDK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2w0SbDK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso1396848a91.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 11:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762629143; x=1763233943; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW9WveIAkxDdRmOgKoN3Gu2p+pDa3DzGMeCTSCmpZ0k=;
        b=h2w0SbDKLrTBy8hYW93D3uPcrV+Zlfr541rWifallqjg/zhGFRhiJzNccipUIn4Zf7
         9gDGtk1oqKklpu1sYyBYWFPKW53wA15N5EU/MKZ4ZH8/M4cZCIVr84CbhZjdOIKflf0b
         ATEgAGdcbLXEm5oygEymdPoFSw4AbJ0uhIxY7UXEDo//1qwOl+JFUWCnfWAsmk5k8+ZD
         MZwC1F/VNR1qkcd2+YINjvrIjUR3XCY8MsnHKY9wkp85S1i4paHqSW0F7ozr69Or4nOX
         hiMWKdDMmoAnXhAJ9wCTRVirgUKBTI0oJLth38HjofDWycV+GgiaKem/h/7tjC2YzepE
         eoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762629143; x=1763233943;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XW9WveIAkxDdRmOgKoN3Gu2p+pDa3DzGMeCTSCmpZ0k=;
        b=SSTh3dHm1Q9qzQVcVk4gHpcC1jNuln+QbGtaHANMG4nVPy8Uz2oPQFQ+6vbnXJgpK0
         6E8AmTUH9TLg6mT5nTTDx4inzFpX9qTvaGUOEz9TYIzNKCYbDrD5LY7C3VY/ihxXi42M
         C60QI+N8zjVQ5GXgLAIBq+VEKmkIq371ewQieh1ARohl93rsfc/UdbmO6ZCUS6DVBKS9
         iwCMi1GaCsMkIk8cjaV4NkbPeRnlpNpbRnfkNfmMEZguRqL/fbI98Y3XV81xi4aJ2UzV
         Jp2OfToTa4MrpcEUDa90GIwLQhaymcmGBzNJTZPsryUm4Wlwk5IzAjBoiFX+TZ8KsX0j
         /Ucw==
X-Gm-Message-State: AOJu0YwGDxCy9qb3y2MhfYqiHxxNjyf812iLLeSsbsLI71tBMfmzLScf
	ixrgNXnzG8fttQWwriYtENLqTHiQh2yvGnHeiSAIFoqv8k1aVSVySMBKuE1yutzNdNqrjjjOKaj
	2AqiZjEw767kD4/WN5rtDArjHPxwvKRZoiI7p
X-Gm-Gg: ASbGncuYws5945EYbcUsdFKmDwOxdI6ZTVFv6vJaws95ufwkk+TcXDExuE03Lg4xRls
	rhC1p9gS6sZcyWI16hAntYICrBU0DWLOrq7Zre1Xnl59LbFKjgPIjNAdApvlncODLE3FA/2H8YF
	/2ugWwx0jiNoLZ3ikVyJJfu4A6m7JL3NpV5IMM1MLEl5Rh+Lo/sYwDVe9bfG1BC/2CerJQxEoyb
	rrkmKe10ijd/vsdSsi81QylEfClZb2EOUEKzxZjZNFnzffXHTWcG49gnv/BQI+FNoSCOG7OusVq
	JPYIZbc=
X-Google-Smtp-Source: AGHT+IHWAEL+BC/aanuW/ciRgLtttKL+MWt7D3qGvOGm2scg5R34j2R6PMBpiL6m319fRNlNUkNpD0QmWjrzFezjjWM=
X-Received: by 2002:a17:90b:3851:b0:341:c964:126c with SMTP id
 98e67ed59e1d1-3436cbc8f3dmr3906099a91.34.1762629142999; Sat, 08 Nov 2025
 11:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <CALnO6CBsXEpeCTS=FpcOvXEOw7sNGT8fdb4Z8PBewoW0iRMnXQ@mail.gmail.com>
In-Reply-To: <CALnO6CBsXEpeCTS=FpcOvXEOw7sNGT8fdb4Z8PBewoW0iRMnXQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 8 Nov 2025 14:12:12 -0500
X-Gm-Features: AWmQ_bm8Ci0VYuNgfIqEPUBTJ41Q3BlFo5gwK46lA8Jf5FRG_Kkx82xGLG12ORY
Message-ID: <CALnO6CA187833M7SFDTrbSaTOpo5vSt3UGUFEiLGpiJnk_ekmg@mail.gmail.com>
Subject: Re: diff --cached --no-ext-diff --find-copies-harder --quiet exits
 with wrong status code
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 2:08=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>
> On Sat, Nov 8, 2025 at 2:05=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
> >
> > AFAICT, you need all of the mentioned options to trigger the bug.
> > Allowing ext-diff works fine, I don't think it's triggered in
> > non-cached diffs, and I've never seen it without --find-copies-harder.
> > Notably, s/quiet/exit-code works just fine.
>
>
> I think I also spotted a difference in diff_from_contents, but not
> sure if that's relevant.

Yeesh. You know how writing for others clarifies thoughts? Well...

I just noticed that diff_setup_done tweaks diff_from_contents based on
whether external diffs are allowed. Possibly relevant? I haven't been
able to easily identify a place where all 3 relevant options come
together, but this would be 2 of them (quiet and ext-diff).

--=20
D. Ben Knoble
