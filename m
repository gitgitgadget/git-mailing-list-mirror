Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E91C4A17
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432228; cv=none; b=leSV0YTYYmhqxGVThhf1oFul98vib03ChGRJpNaTf0/HzoJrzdXmIyOPOsPV74niX4f8Oea09EsSqCJ0GrlPBOIknKAeY+g7XS7Uy4w/f88LAUGkgWGGUka3UgMVN4JvuNJ0U0F//bIFJ9uuoADj/a4iotX+bUpbuavvfThbwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432228; c=relaxed/simple;
	bh=FaGsBM9pprJfTAAPzxWE5LKXCJ8W1T7TUqIBcjfzbns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFrgux4pycOR9biXORXRrTXM9yKCCXX2SlvOSPEqTWLVWbOjqx9SW/MWUQdAPoKo6P7+bk6XlVrthBQj3nQMcTPt1iBAbNJ+XQPwuSsGra8IN442K9+F/oGTOECU/ePWWIwwGiYkii+WgC3UKFx5Oo4hwY1rTO1RnRsRegdZ3tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIofCIqy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIofCIqy"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3d50882cc2so947154966b.2
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432225; x=1761037025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaGsBM9pprJfTAAPzxWE5LKXCJ8W1T7TUqIBcjfzbns=;
        b=cIofCIqyxwLdE7mu3XalTlScemqlUh/PEawKjJIMXCiXhF90QP+TBwuo9hJ9chee9b
         6MkggolzHghND5aOwUUkzyKcw0+zK+ob/i3qKwcVeGJLmK2GjoDkVO60tu+v3FaSldTK
         FqKQ2NkNOzrX/4J8/Hti2wmrfxbnxsnfYm2qMf9EgCvAVwdm3v5bjlYUInlhgzfhVlfp
         wVqytQJwPO48baMtMkUZuLaF4a3rsl3HqX9v/vi0ABHf4yq+5zrXBB73poXFLwTLNt9I
         TzI4+0x7KRkEQN8e+Vu8+00ABLeKVWjMFe5xbTEuQXNSuGZpxT8M3+MxfE/ypEFKBewY
         turA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432225; x=1761037025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaGsBM9pprJfTAAPzxWE5LKXCJ8W1T7TUqIBcjfzbns=;
        b=Gwf6ZZqWc92izNxdqiz/LqIxJ3fNHCzxhi1BL7dKihaXMVVNi5uD37SiKUFjIQmUEG
         IotBcNZ22pDwGj2NT/7nohfihnBE8vuP4HEOeecvTiwQOEzFzXMRnpdY0XxvSeRKur+t
         eu9BWuUaqvL4lJKpfLoIYlf6EQTfxhI0svsj5K4IsiEPPEyjPuODfb2WpAPZQeQpF+/z
         kQ3cVrppD3T/9knFZFIqcdlqtY/mF+FN0IFdJ8KviaeOzOxv/0dGPVy3tzhGzvw5TzdO
         5Kaz8IABrq/4n1VB9g/1+tNV+Dca5UHpTXDW5Ebn9eoD+4+udblowOWL7lgT+jfrAtGq
         GHRw==
X-Gm-Message-State: AOJu0YwVytpR69Fgt3J5aDS1E34Vvxjcrs0r4MEH20wxMa0HcHDDBLvk
	+c538WUHgKwgHevkF8M0llyB/FMZxgE+PnuFwpidM8QckAUnCCzYrjdWqO9sDpI6eMOdrBD+zdL
	fQcH4ZDVG6LNX7K67tA5EN4q0OAIvSmU=
X-Gm-Gg: ASbGncvrDOT2UrSSGiynw0o6lUHkRTUHdBTKeQ2we0AvvxVCnbouyLa3Fp4nfz/+vjj
	Kx81ZTNAbufmDHLAA+ixxZSUR+MgQYj4t0HlkEjIW0beaJGjd6Si1QNXHozug8uIiMcfppSU6lD
	iGseXn0t+N4bV/XxnhMuLl1iF/n0u5z/bSMfBvfUfD7bjqZaQBo8vzCnjWzaP+fOYWjhrJUpWGd
	mVY08JEWKUzgRkx2gw59SZL0A==
X-Google-Smtp-Source: AGHT+IFvu+hG56YiE++CxqN6cJhMkEv7DRcS6cvk8me0xrwq8z7pyqTzCqJmDPL4oim2328eC3bzCQdrL4cklWWiErQ=
X-Received: by 2002:a17:907:948f:b0:b3d:d6be:4cbc with SMTP id
 a640c23a62f3a-b50aaa97c94mr2361081066b.24.1760432225224; Tue, 14 Oct 2025
 01:57:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L9Z2kPWv-=wPbtytbMS7BuUtmAKCv2X_2rq0hB_Wsh=UA@mail.gmail.com>
In-Reply-To: <CAD=f0L9Z2kPWv-=wPbtytbMS7BuUtmAKCv2X_2rq0hB_Wsh=UA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 14 Oct 2025 10:56:53 +0200
X-Gm-Features: AS18NWDOjexr73z2WyWGDx8hjRLsGEZo8elfnIOixNR1TGatVftf7D5eVT-q1x4
Message-ID: <CAP8UFD2azLtbeMzGhgxHcdnCF=jD5esOs3BjhLWGCXvMmppX4w@mail.gmail.com>
Subject: Re: [RFC Outreachy] gpg-interface: Replace strbuf_split()* with string_list_split()
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 14, 2025 at 2:44=E2=80=AFAM Bello Olamide <belkid98@gmail.com> =
wrote:
>
> Hello,
>
> In continuation of my search for an appropriate microproject after
> temporarily moving on from my mail to the list which was about
> the check-whitespace script check for \No newline, I stumbled on the
> thread
> https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com/.
> After studying the thread and searching the codebase for other
> instances where strbuf_split()* can be replaced with string_list_split(),
> I saw some cases in gpg-interface.c where get_ssh_key_fingerprint and
> get_default_ssh_signing_key functions use the strbuf_split_max to split t=
he
> input string and I think they can be good candidates for replacement with
> string_list_split().
>
> Please, will this be good for a microproject?
> I will also appreciate any guides.

Yeah, I think it could be a good microproject.

The functions you mention don't modify the strings resulting from the
split, so those strings don't need to be strbufs. This should be noted
in the commit message (which should provide the reasons why the change
makes sense).
