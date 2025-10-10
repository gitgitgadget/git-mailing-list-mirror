Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1CF1D435F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088130; cv=none; b=jTgAAU/0ebp5v6QKAKg1V5YSePYkkJ9z0+HlUdmeYuEt5fa0V25gfwEu+KCN6IqHVVR2S/6pprLMy1a4q3sNXWkXA0A60dGIfZDU7dm65Jjhe1etfh5J+LDPY7EaLNUyApU6CeL3khgM4HHpH4gSopCrUSiOpI7TKHGZaYQ40qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088130; c=relaxed/simple;
	bh=lKB/u2A9IS3GIrjk6C/6ZloSL9GxTcisLugiZ/z3pKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJYta4DZk18cPFXfjXf24oAGOOB8/FZwd8C3+EgmjuWrIXnPsQgz9853n2TjbnuIhHAvD0gOoq/3ZFCVv1p9TAzlte9IU9jjwdfS2TbTbuQNqLMQtsAvVhpsLPF9uxJIWrgU1UasfSigjq4s4RLH6AiXTG9RVHp8ec9WUXNb708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCOWqat/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCOWqat/"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so356030966b.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760088127; x=1760692927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKB/u2A9IS3GIrjk6C/6ZloSL9GxTcisLugiZ/z3pKA=;
        b=JCOWqat/323B4lU6D8LyRTTaMRJFcQhFPR4zyfMIy6e63v9e9RF6sYVzn38SXPOkIo
         gfAJajMUfevBuND1Ky3NjFW/oWIZAiohgNZtx41/VV/pfJ8XkwBPEhbWxavPK3+Xo7b4
         J4ie7nuK3oQ3y/YQz7Z1tV3GqxLFJQm9bGEyBtduecfhWzm9HGVSawiGjlzl0/ECNjvw
         +cxFwf5ovRMypQbs733q8t24cqhxMckz9pAxYdtegv/yfvhwmkqKBPDSDNd3TEyAU3+u
         wQxdCLKKFN819vMEhRIMxLRR+UqR3peeyRvQjLDuQK13GlP5ZVpScx7TbwM1eGC9wl8R
         0vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088127; x=1760692927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKB/u2A9IS3GIrjk6C/6ZloSL9GxTcisLugiZ/z3pKA=;
        b=TxfCFLcr1XO0VRvW3Orb7AfQMGKVDgXZX99vWV9p43tYfAkKvdqA7KU3cs6gECBtZO
         xRCJVihjNXuMIrkdyRGrqKaTYvcdXBD2MplexaCVU6kowQ51X0YD5UY3uIfldaMrvKhk
         E6VFZMbrckDLCq8+Ddq0qQ+6vmIl042oVpnMPzgSBj+JSUKCw8fV+qRD+YnNgbpelKwk
         H/DfEHB4CvJB9VGM7hKLnFDGjTgKYFYtOGxjn06gc8Z+hM80KcPQheektbLckP7vol1/
         PUa9rQf1sTFGdn/6skkEVLBVrrKwCV3NZhTYyuVj2LKuS/hq82bF6gONCzXFJqa9w1fR
         LuGA==
X-Forwarded-Encrypted: i=1; AJvYcCWEXNlmxnBLELYh7y7MEzDb7Tyd/x2QsSlGs9W/dN+22eBk5wy8x43tDgYqgmcOzpxGZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshlhodbbY6IdQQhVSPyR5v29wEDhXJioGkhvlqcAh52nTlEcn
	SSS9Pzd3/nEmzhWCw1AyNWmmKhjOejRvg/yeEL/oypig5bIRx49Hlan8OV4bzap23WsSM4s7Ung
	zjMT/qQ0zHHi395i5dO3MsBdyMihYk80=
X-Gm-Gg: ASbGnctql8sfUGKaJsRGZA7GraDmXv9H0sMpSzt59t727w7KOTiByfEScxP7Czu79g+
	zIoK2TTz33JTY7L5BlOxE+JgKVnMGUWbORo++/C3QBM2QkSrnad9Mwsc44xSzijSDU5SPJaiJ06
	SjxVFvfhsET04FAIufcZAUGrQ3Wi2aTNO0QQ2mYQX6BkIIExxd9CdFyA4lLri47ozsQiQkHFdqh
	b3/rSHdrjNOI9j6B0w56Axjpn5P
X-Google-Smtp-Source: AGHT+IEbeVi257GidYVg9TCm3A4Odl/9t0C6OFKjAZ1qYhkVjrKuP8XEZNYgnhyaWg5n1roVTf0jQ92cI7b1qsDqRxk=
X-Received: by 2002:a17:906:f59e:b0:aff:c306:de51 with SMTP id
 a640c23a62f3a-b50aa387326mr1155957666b.4.1760088127018; Fri, 10 Oct 2025
 02:22:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qbehd3whkgrofsmvkrtgbfo3tiqhyv3friz56xrehkgduld3ou@e4ck6nfloaq3>
 <CAJXmEzTVJiDLe_9gv-6MkNcztAezQJob90S=HW7r_AkVZUMukA@mail.gmail.com> <CAPSxiM_nkXDaieL+2oq9=KqG9eMkKjMhHzQz7SzEQ96bN=q=vw@mail.gmail.com>
In-Reply-To: <CAPSxiM_nkXDaieL+2oq9=KqG9eMkKjMhHzQz7SzEQ96bN=q=vw@mail.gmail.com>
From: Immaculate Atim <immaculateatim56@gmail.com>
Date: Fri, 10 Oct 2025 12:21:54 +0300
X-Gm-Features: AS18NWBPQcoMHod5CDeP-JgiGy_w47C5nE1I_SU7ZZHQfoLbWgz7GSRwxVPdy7o
Message-ID: <CAJXmEzQERNzSdW1kBaZiFi35NuA28jDtB5CEhQEm6csnCBn-=A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtPdXRyZWFjaHldIEludHJvZHVjdGlvbiAow4FnYXRoYSk=?=
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Agatha <code@agatha.dev>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 9:31=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 5:05=E2=80=AFAM Immaculate Atim
> <immaculateatim56@gmail.com> wrote:
> >
> Hi Immaculate,
> > Hello Agatha,
> >
> > Welcome here. Please feel free to reachout to this mailing list or the
> > mentors in case you get challenges while working on your micro
> > project.
> Thanks for this.
>
> Importantly and I hope other contributors can see this,
> We do not "top post" when replying to email in Git. You can find more
> information about this in [1].
>
> Thank you.
> [1]: https://git.github.io/General-Microproject-Information/
> >

Thanks for the clarification, Usman! I=E2=80=99ve read through the link you
shared and I have learned more. I=E2=80=99ll make sure to follow this forma=
t
in all my future mailing list messages.

Best,


--=20
Immaculate!
