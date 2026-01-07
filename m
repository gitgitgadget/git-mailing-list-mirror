Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456B368267
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799998; cv=none; b=dTZkXmCUcDhs1Zx56FeWgmQF7/jV6+YPXIOAeKt/42gbhWUc5xb46ZRqcTzN11AbX6WHKWaSpGI0C0pju8CSU87EZ8ii+LCiP+WqSaGrHlRMxQy1dahB7EYU5NIp27MPM9RAAtgVyasN9GofjuWsXbDI6wtuUwaRnwHQy9P1I1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799998; c=relaxed/simple;
	bh=cdNn8VsN1b/uotnfgSBBmF8dRHNfuIcm61naqm9qOYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPxMfeYjc1aRsVFlsSIHkvik3NdDcJZjc+szm5YvI8CaILdEMZWpnYTTM2eKE0MUBPHVus4paLuCIssO6JXjEtHEDkL3l+2DBWrAAGqXgLW9IBYqaOSh+P5fj8R6IxbJHIHUDvrucIn1CdXwXs3wwzkO/jQ8K0Q2qGVtE0cLfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFpzP0xq; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFpzP0xq"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ae24015dc0so491387eec.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799996; x=1768404796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro7oEqLM9ruOVN/bHO0SXR//qhd/KjBUrf1TvGEyX40=;
        b=AFpzP0xqVB421leFMLWjQQDB1AK7pq2yvAXht56a1jmrWM90ruSwU4rI57J0A8zkUf
         7Xy8kSOcJ0H9TFyqq5i+YtZ2b0TWEAAgBjvWK3yc9xJlJsC9BHtp0x3oWM7NyRJ5XJkT
         G+62I91RUA4lS7G9+YXoSyh384rPtRm4qi8fKUvMf74DXi1zBWa/flalo3FCtZQpDtj9
         vV6hBOaRVhD9+PDhDzzLPvV/VOikQaH9BfUFXgpGIPmedEGwsWLCzUVpcAoUIbVnnAFL
         0s0ToMYDHGspyu1ZtpzdINjXNXoVZeMeIDlTtNGtcLoSzcb3SddQ2w7fM/s4UKuVYZCi
         kbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799996; x=1768404796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ro7oEqLM9ruOVN/bHO0SXR//qhd/KjBUrf1TvGEyX40=;
        b=d2eTsFxFP3KB6HdJLKfe5PoRRG8aA1CyMqeN+ZYlu2UBJLktqdHJm0g7cNy/eYyEPy
         NXPVxR4WG6lSS+wW1pCcHyAvsMfHPkRffTLe4prhnPVzDkhoT9L9mVFbRA/Rn6693iHo
         9xuqgHcM5RNQpekJSIPbXVmluf+Z5sN8xNePjV38csywVgAYO9Kxf3MSKrmsucpBgpgU
         utH3wEpWuIjQa0yYxy4xVPZYgLzTgYvy4mnhirQ3tLxXvzwvEnJdpghqSNTAq+k1Dwvt
         6RulGsbFjInLCBQDtPwwDHJ95HPPueBFA8OSce7I2mvlyzILudRJqtRcobscJL/1NoN2
         Cm1g==
X-Forwarded-Encrypted: i=1; AJvYcCX49WUWBNxDIDKANeXBmM5KOLsNzdTgGcDJMjlwTW9xBaEyKQ44nzGAPa+r+AQSfWHxoOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3bh8pfMni3gNauOHnYwE8Xf5yZ5lWobdXkMzo6IPs3czsHd/
	LUecLokcAKz2TQhjp8emQ66IavTnb6j5UzLwbq8PCpF6X/fB/hBf/7+quRHlpFTkma8aEg4oMpS
	B58LkNlU6zLIsqmuAAMrOSJGuM3+Rz3s=
X-Gm-Gg: AY/fxX5DWlYEqw3e2DZBhUXT1qE+5Pqlxy+zDa7cpdhWNTkpTQWC0eeiCwAF7gr36ce
	lLzp1grkylwk/UehUnkQ9JeSZWLzkVZLZ/gxQDeltyYFpUMYQvoOXVi7/GK2CMAIVW9GnVRMjKr
	/I3ATH1TE5DNyLMBk5KI16REbl++BfGpWDkss/dY1c/yfGFuwfQQguhBhVnWgWCdxBAn4tIUCE6
	tLQgdXBmKnZS6K6geTE69f/L8HQsv+O2hoRXF97Dtdmq1bbS3+hjFq+EX9rPx+Uj7cjJ3K0ukE=
X-Google-Smtp-Source: AGHT+IHOdUCFen60b/lzToVLaysFplA9PQ87fMecgXu0lRLwkwam25UB34q1jX5kPFEdHgmvIC5UCtnmwnYhuR0bdRc=
X-Received: by 2002:a05:7022:8c:b0:119:e569:f85b with SMTP id
 a92af1059eb24-121f1b4513emr3578672c88.18.1767799995861; Wed, 07 Jan 2026
 07:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aVfzMsN2ouY3UBFG@ubuntu> <a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com>
 <3947f777-e08a-4c17-81e3-c4711fe666a0@gmail.com> <xmqqwm1vk83a.fsf@gitster.g>
 <CAD=f0L9BEPSQivgpM7qURT+WFDY-+Ys_M6Knv8hE0JDw4Wjj5A@mail.gmail.com>
 <CAD=f0L9H5Q=zW02nr11OSBNgFH3UMLwVjVjn3zhgZ2rjwE85WA@mail.gmail.com>
 <922629dc-828c-4bdf-939c-b38b7b59e8e8@gmail.com> <8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com>
In-Reply-To: <8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 7 Jan 2026 16:33:03 +0100
X-Gm-Features: AQt7F2rUtYMh1B8fNNfKNIadlPfT0zKu0OW7P1Marp_iXwVR2FU5ue25yzv-uKU
Message-ID: <CAD=f0L9in5tjLNUcM86uzd_caTaZYre9RRygmizO4G=S_DBFRQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2] environment: move "core.attributesFile" into repo-setting
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Jan 2026 at 15:19, Phillip Wood <phillip.wood123@gmail.com> wrote=
:
>
> On 07/01/2026 10:26, Phillip Wood wrote:
> > On 06/01/2026 13:44, Bello Olamide wrote:
> >>
> >> But won't this be a temporary solution since the goal is to prevent
> >> the use of
> >> `the_repository`?
> >
> > Yes but it would be a good start as passing a repository down to
> > git_default_config() will be quite invasive.
>
> To expand on this the first steps could be
>    (i) create a new struct to hold the config settings from
>        git_default_config()
>   (ii) add that struct as a member of `struct repository`
> (iii) one-by-one, for each setting parsed by git_default_config() add a
>        new member to the config struct, store the parsed value in
>        `the_repository` and adjust any code that uses the variable.
>
> Then later we can tackle the intrusive change to pass a `struct
> repository` down to git_default_config() and store the settings in that
> rather than `the_repository`. If we add a local variable to
> git_default_config() in step (iii) above then getting it to use the
> repository passed down the call chain will simply be a matter of doing
> something like
>
> -       struct repository *r =3D the_repository;
> +       struct repository *r =3D cb ? cb : the_repository;
>
> Thanks
>
> Phillip
>

Thanks for the detailed proposal, which makes a lot of sense.
I=E2=80=99ll align my changes with this staged approach.

Bello
