Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EE19DF4A
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367957; cv=none; b=LI+zX8iGkKOZOgFtwkZydn2MkumcdE/y5J2n6hcQbu+AcLXeJSw/+2iHwirMZCpB46334Pq+1/yM7qJDGtgxR8XzKFlA0X2ezhWjzSw/l6NCh9ra2It0iZXHkHRQWB5BAnGR9C1XzAngavOv0OHXItXQyfgX1RnQE15tyqGAUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367957; c=relaxed/simple;
	bh=5uOidspgG1/qOulhASidvRP/GPzLGo5jRQ+O7eIoecU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdV2rC/Zhd98LbHZXFGyKedyTl9dpKpqhiAZO6xT97qfsiw+wS4Js1KQ119H3pGx8xnO7lfS6+IjUErbFu71G9LU18LiVzLb+fZVYfZRIuaRRWa72/UwH6scpEFpbexOrpqx+fSr/+S3Upt8LNDRA/ySCpEGtGI47z0uCfrWu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeDoWJ78; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeDoWJ78"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85c662ebbc3so666548241.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737367955; x=1737972755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uOidspgG1/qOulhASidvRP/GPzLGo5jRQ+O7eIoecU=;
        b=DeDoWJ789oz3pbN2uVmaTFpvaiAvVgpejB0KWhnGasUVkhbBhd1fKQIEfmQElRJNlc
         5VV6dIMvZ/A9NxT+o4sfrFcRZTAl3T3vVhqjtLfEIPToaZvC4mW1E9fC5fdxfeh7vHIh
         FS5WdiEl6UNynf2unYeTLKPjQt1FqU94JUtIDVLMs9hXMji4PF9avdBEyx3Prl/IiDLn
         6TddTf8jufnKmpi0OM/FZ6P3Z2LNC88wN7IFaAsxNjLTvOlDt4/XDVr0UUnZKl1xr4Q3
         STyZn3jLGJ1CwsWox9GkO5nQiwd+zsuzQe94J/XJFmMkQ+ZztKTWPGVgyVeXHCZs1wVj
         dYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367955; x=1737972755;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uOidspgG1/qOulhASidvRP/GPzLGo5jRQ+O7eIoecU=;
        b=L0QSN2keCQLaZ6NRSDUZHy1BWktRTfTAXiVUbO76l1rZ+o92zWwa8e1XuwBFAdkU/1
         9Ccril9oIjm+Ae9snOYVOiWdiHVoRsVIZ1pdwGn8HzTVBXqKOhImlJY6LOTSj5/EJKIZ
         uvVcRrooTUXYDuWXTw+4XoQub9LxX09uSF0stIy3/J236wDzaPBdVD2CCbHhz2y7SJvf
         2/wssJyR+zKastauHpKrbUhpuMKFsXcjQUrs6wfL8q+386DQmn/FyklFf7jvNyxMY0VR
         7ATr1q47xqBunXN5iefueArf077/h8/r6atM3xdEB3Zec5SX71l0dSdngNvHBHTvl82m
         JfHg==
X-Forwarded-Encrypted: i=1; AJvYcCWQxOnVNGEG99csHdzhN/dz4QDHJX11zuCXYgfiwTnLYfxL/aHjoPqeGbfD+VmoYj2ILfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9A1pky5+gwB/boKEbrpa+cD6sZwhsgRNPzGSA13sKdL79ZqyQ
	ciYkLiIO3ruiFThtD1MdaDP/XPYCmEr+VS7nJkqfM/cW59UhRN7vbEloLRmWCj/oTM54SN8HkEe
	s7H5fgs6rlDDK4FAQOTPDcgDGrgOFj8ac
X-Gm-Gg: ASbGncvqvZAwVfP8AYlyUALZ4fDPr9dd1xdpyteY4jGC7VLXw/L/4Sudbijc8ptoh5a
	+XqCORiWPT0AaRmFSoWViujyRtuKgwsc81Lg/UG2YWKSPyxqdEWS2
X-Google-Smtp-Source: AGHT+IFd0ZzKuaX1VAn23B9wktsGBL96uFiKFeOtyxBg+UmLlK1oIhID0ida+IXTjk/FzFzCzTu7FB79R7Ac/UcQcos=
X-Received: by 2002:a05:6102:c52:b0:4af:bb06:62d with SMTP id
 ada2fe7eead31-4b690bdcbabmr9092586137.11.1737367953426; Mon, 20 Jan 2025
 02:12:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 02:12:32 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 02:12:32 -0800
X-Gm-Features: AbW1kvaL-Lf56QQyMu2-pVIkE55nY474VZnEOIUtZbAvZpiS88Fr9mTyANdKftk
Message-ID: <CAOLa=ZR4PAche0J+Lju3GRcKBDQYEkte9Zn6M10R5p+jXq53cg@mail.gmail.com>
Subject: Re: Git in GSoC 2025
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Git Mailing List <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000b56f4b062c207faa"

--000000000000b56f4b062c207faa
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hello everyone,
>
> It is that time of year. GSoC Org Applications for 2025 are open now[1].
> They are due before Tuesday, February 11 at 1800 UTC. It's good to see
> that few contributors have already started working on microprojects this
> year :-)
>
> I could help as an Org Admin like previous years. I prefer not to
> volunteer as a mentor this time owing to other commitments, though.

Thanks for volunteering again :)

> There are no noticeable changes to the program this year.
>
> The GSoC contributor application period is March 24 - April 8, so
> (co-)mentors and org admins are already welcome to volunteer. As usual,
> we also need project ideas to refresh our idea page from last year
> (https://git.github.io/SoC-2024-Ideas/). Feel free to share your
> thoughts and discuss. It would be great if we could come up with a good
> mix of small, medium and large projects.
>

I'd be up for mentoring again this year. I see Patrick has posted some
projects already, I'll reply inline if I come up with something!

> Do feel free to ask if there's anything that needs to be clarified.
>
> Just like previous year, there will be a GSoC Meetup in Brussels during
> FOSDEM weekend on Saturday, February 1st in the evening. If you are
> around, interested and haven't received the link to register directly
> from Google, let me know so I can send it to you.
>
> [1]:
> https://opensource.googleblog.com/2025/01/google-summer-of-code-2025-is-here.html
>
> --
> Sivaraam

--000000000000b56f4b062c207faa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c42581c868d743f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT0lZNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzNGQy93S0hsWlMrNWlXT3lET1NVdklPenNZK0MxNQpKakEyWDlna0Zt
anE2VGw3aFlkalBBQ3duZDlSNi90Ym5KY2NYZmw3ZFpvbGZFUmxjd21NYmtiUlM0VjAxWWI3CmlH
MlRpOENmN1hCNU9NZTJXQUZ0bzFDTWVNZnY2Q1JuSkFsT3VNbDd1NnpZSUkyTm9KNjV3WER6YlVR
YlRjZFgKazlnTzRRN0d1SUJRTmsyaDFrVjBxdlRyWFMvMDc4QUFsdVdQNWtTQ0VqeUdmUER6amd2
NXBkMGNGUENrOW9idAp2em4yV0NlT0xPSnJZYjFZZ1pWd3dnMnVQbXZHWjZhS09sL3R0RUhKRjVI
c0RNdFYraHBoaXpDa1N2Y2htamhhCm94cDJ6Y0pGcFNJaXo5UWtCa280aGNLang3OVZnYjlLTERN
ci9mTjBmNUYwWklGK0ZvTHBwT0hTYXFhSWFBbXkKMFU1V2ZITWVmVkROVGJ1WFR5V2NBam1SeXov
MTRsWjJldWhvVFVmYnhPVDJ2SCt2OFVWQlhSWThwVWNnUlZQcgo5TGRuVHdTYWhRbkZ5L0c5TmE0
MzV2ZVZTcnB1V2ZNSXJYaGwxOHhpZkhPdnhzaHk2UHZLZUFITkFyN0s2MkdTCmE2SUUwNzFzTTVS
NGcrb1B6OUhOWHYvN3lOYTJkMy9hNW9Zazk1Yz0KPVB6ZUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b56f4b062c207faa--
