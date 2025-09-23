Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7823101B4
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618233; cv=none; b=YiguOpiSVyjVKoW2VUtJzAjK9Znv/B5DIVGgNL+64A5OhCW0gv8E89lFiMSeXrHf0Vho6MWKgvobFMIB3kRzKllHa11Gb2/O3uJuIr1di5rqOQFbl34VhE0oJ7CoQkq5Cv56twIyRM+sk+461oSwrgNtGPH4be7IhKflxob1JwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618233; c=relaxed/simple;
	bh=ZWIIgOoYn33QSsEFmRMAA+Tbv/v0ZAUCR86N3xQZshI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAg2attAgH3EGzsjvIH42Z4nj94oKlQ1gZCmYjZsvNpRlTZ2qs6VUftvs0b9gDdqxehk6vBtXbHVtzc6f2KRXTe/Vw7eEn+zwGxj0LaDQJsHzoG+aclyY9bxwfDt4cCjRkYv1rpRU1MtSU0ElgsYUvQSH6Mn8eR9eb6buyntjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpSmb0BE; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpSmb0BE"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54aa6a0babeso1502268e0c.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758618230; x=1759223030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWIIgOoYn33QSsEFmRMAA+Tbv/v0ZAUCR86N3xQZshI=;
        b=jpSmb0BEGYUNhMyZ9YHREcfXbX3TL0nPSSIH0vOIRC/C00UR7ZpKGbaL3J4rgw0S5I
         jq4LaXHtMyI+BI5m8gFmcS2r0NlkAgRw/Ue/RRoBp6+h3J7bx1uRRoN63T48CEJKd2qB
         8z8fVgWdVla5XmE4+Zalmg50h4/RE3/3//iPPoHbi2K0USvliL1EwEDa6UYtrCOZL0Tu
         Foogaeo7dacHgNR4YHNnl7Gz5+cs3lRN2ClI5OogyztJpPXogET0dLZYB/9ZU7/RucIn
         Mue2KSAaxk5K/fCq0rvHva/x1IERdMEpH3ZzG9F9/lvF9KGy8fJZVATVchMexNOXbO1f
         qlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618230; x=1759223030;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWIIgOoYn33QSsEFmRMAA+Tbv/v0ZAUCR86N3xQZshI=;
        b=wS7ht2i91Hu/07XvQSa4jE/OcyNF/YUratNEInzF4JQjsldtLbzWN0/oZdQJqUAUlg
         bE+xkp3LULpFz19KSOL7fn5XPwm/iPiz87hGuIwmVBFAKXzX0+ctB6oXFZtP9JB5IlaU
         19JZbAiv//CqR/NotfhGomO7dMGAkTo2P5dMrLlVCDxNVzmLgTjoXRtExuaK7QE0wWRA
         fg1/n6eVqNd9Yf4NgThCinG6+CorMJMlx52GCDwszr/XgbEs+eZAjDaaUYwS3nHu4ute
         nOZtIBSys3jEt+iNc1Rl5mOzcnF5XZyoamvYkkXd8rc8OMKDGZLaqT5n+naoSHck0nFx
         HbQg==
X-Gm-Message-State: AOJu0YxYIpmtFo2k/lC9Ey5OEC66HAoiJsv7Fa4ScKtSaQH8JFdr5MOL
	Ylofu2wHgg9El//oXFR8p60jeWTKQMHXeGUEtN/MLkIwsmJ8TVCTJwu9GaYbY2wwbV54g9H55/4
	j1+pdcvG5Yo7hcqn46lMuIy9kKW3COMA84G9i
X-Gm-Gg: ASbGncujvfQD/h0Len7JT5m6xG61mYjZoU0Nx1sLDCTspyJJslhXxRQmwdrH/+ClRz8
	f81KNUcK3d0Slxli9HrdTm07e3nJlujg1I2aPV+jhr2F7ElAlXGeZGjPByyhsfbKMKz5JwjPmEa
	gUm3rV0jhBa9Sp0fs6lWTwe2YLN4JRi/c7RNw5OOvX/vrbDgrYYKaCqcTWDseH9er0GuxsE+oPP
	OB5WGppZVAv4fnCi+V0LMu9qPWG1s/IisEPsEPWGQ==
X-Google-Smtp-Source: AGHT+IEk/bwbdKrqSTGmVHQN1hc9P+aQzyqCHiTdpTlZ72HjyCOH3IpRnc3PxQQH757WjYKNxzrChI8bvRJCIjOyWe8=
X-Received: by 2002:a05:6122:1d07:b0:54a:a3b1:db63 with SMTP id
 71dfb90a1353d-54bcc277ff1mr539050e0c.6.1758618230186; Tue, 23 Sep 2025
 02:03:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:03:48 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Sep 2025 05:03:48 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aNJSnUGzzMlmrDQw@pks.im>
References: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com> <aNJSnUGzzMlmrDQw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Sep 2025 05:03:48 -0400
X-Gm-Features: AS18NWBYqZsZV-g41Ya4yREHuKD_wblRQqcvI-d1fKZVJYaPGsoN6u-dkV3mH4o
Message-ID: <CAOLa=ZQKygjjW8s3wfyCyrv1CwHzHnmMPPSU_4pNAzEuy-hx+Q@mail.gmail.com>
Subject: Re: [PATCH] lockfile: add case insensitive filesystem note
To: Patrick Steinhardt <ps@pks.im>, Alan Da Costa via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alan Da Costa <alandacosta@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e800bb063f743611"

--000000000000e800bb063f743611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Sep 22, 2025 at 09:54:44PM +0000, Alan Da Costa via GitGitGadget =
wrote:
>> From: Alan Da Costa <alandacosta@gmail.com>
>> When running git fetch or git pull on a case insensitive filesystem
>> (e.g., default macOS), if multiple case variants of the same remote ref
>> exist (often after a case-only rename), both variant locks map to the
>> same on-disk path. When a local update is required, Git creates a lock
>> for the first variant and then attempts to lock the second, which
>> collides with the same lock file, so an =E2=80=9Cexisting lock=E2=80=9D =
error is
>> reported. The underlying issue is mixed-case refs; resolve it by
>> consolidating the remote to a single-case variant and update local refs
>> accordingly.
>
> Are you aware of Karthik's recent patch series at [1]? It looks like
> this addresses your exact problem in a more direct way, and the
> resulting error messages that we have in that patch series also give a
> bit more advice for how to handle the situation.
>

Thanks for tagging me.

>
> The patch series wasn't merged yet, but will probably be merged soon.
> Could you maybe test that series and say whether it addresses your need?
>

I agree. This should ideally be fixed with my series. Do let us know if
you test it. My series also has the added advantage that it would
suggest using reftables, wherein, the user can still use
case-conflicting refs in their repository.

> Thanks!
>
> Patrick
>
> [1]: https://lore.kernel.org/git/20250902-587-git-fetch-1-fails-fetches-o=
n-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com/

--000000000000e800bb063f743611
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f559ef728fa1c4f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qU1luQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjV2Qy85N3NWVEk2bGJZa0h2OXg5S3M4dDVHcXY0eAp2cnNlQjZCUE5I
YnVKZndqdnNYV3ZPSi9WSk9tWVdYRGJpNnVlOG9CV3JJVjdrY1hiODNNckMvL3ZGckVKSUlaCnk0
RUZVY2RCMjZPdGgrME5jTXpsaXpLRjNBd2lVaVBZVzBYUU1VQnRwSHFsWDlUYkphMmpZbTJXZ3VO
WVM4bncKWUwvU0dZOWxiTDloWVpvYyttRFlDaEpqTWJKMmQ0UFdUNStERXR2TUg1QU4zelRMZUZJ
ZGY4eWFkVkNmdWdIVgpIR2JBY096TEVBdjM0M3VxUDd0R29rbWR3NGwwT1dCaE54blRkY2s1TnN5
MUNkaDV4S3kvZERKMTdzbU1GYnBmCnBpVFpGZU5PYTlObllxWVdyTi9jZWw0d256elNHR3VLRHFC
K1owdUJsQXo0MkgrRUFZZlZNTGtMM1hrS29LWXkKeE9iVHo1OVF1UGVYSGh3NTZ0OXpybG9Jb0N3
RGtyQzl4U291dWpuRWllMnAwbW8xV2VuSG15clBPK3JJV2dtTgpqM2pvdmQ3eTNnSGZHNzNBdXk4
WmF3RUF0NDZqM0hPM3JhbmpSZEhzUGJZRFZxTEs0dU1ZU3BjRHU1ZHV5V25RCmRLSHhoR2pTN0lE
bVVHbGxOdkI0cnVZd1hKeTNYZTkzcUFnN2IxYz0KPXZkdzAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e800bb063f743611--
