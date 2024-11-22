Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319BC171088
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732271156; cv=none; b=PsWAdBUq5pqd9pyINbuak2b4WAWodg6LtsVS3KmjLm/m9b+sM6AKIsq9Wb0d+/YRfbDCe232RKNdqWdtijVzP02j3jnM/ZZhivcHEFwzKCZukuOGh5XyaNSBtaER8AxG3Tu12/qwhpy0fJzWH975T0iEQ0m/rebhsrxzhOe0SKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732271156; c=relaxed/simple;
	bh=lIuw7EfybuX6sAxWWQ1eBiJJo56y0NBi1KBGR472J0E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHWXgMmWZsaTAXBssUYZPjTJkGnp6g1KzuXLD7pAu0kvgkLVgdaBUoVf5LyEsb8wcYeA4x1dzBc401aIO5YE6jqKdvfr9LuIxTGgIVYQDNjPN41s0ZQA5FVuxBTnAJDeqvDx+bpvV43RPnmT6jneN0uuWyvIHG+En0uJIcTvql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQRNb10S; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQRNb10S"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-856a084088bso659451241.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732271154; x=1732875954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZg8OwBD1awIdDrFwxOp1bS4a2O1XBa3xWJeih5ngxE=;
        b=fQRNb10SxOYf1yXS1606XC/bIrJoB5/cuUJ1MyjKTjKibJuyypPi2zt4+P5kDNf20V
         BchmsCJdWTnJRCpV7QQzdAIBy+QCrJ0wdhtCI1Ovu4EzpoB4rGlf/dQxWP8FjW16p/ck
         pMlBhaQWQgNouJQwAahBkpi5wgWF7I8l+rUOVWqmT1OoqrRVWix2JLoBgrkjnC1qbHTm
         sGy4vbmxzVwS2A237kC5OlODLEtsDRyOEjWXp3WUeCUyqvHpFqJDorUVfwsqvA0ArD7B
         bUzww9z0XgqbHb/CQZuoiNuJVP++x2ZLxfSrX0xLSJHuSycfCLTSNfDfhHKIJXA4SqdQ
         TRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732271154; x=1732875954;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZg8OwBD1awIdDrFwxOp1bS4a2O1XBa3xWJeih5ngxE=;
        b=ssxCBjVSlw1V8VkXRL2FDmHFBB65DnPIEW1vrhmoIzkuDGnF2DyDxB5tfFG8egesWg
         IowPflwb7wXWmn+UT5JZLpueb2Hvhwv46cCVh9L+cNuZoApr4AaQA6S5RjLLp4yB4YEp
         ffsRUSvmFyhvCBTOjJ5dwxLiPgjR58ZIu1lSwKoB/QpRRj4TNd0pbf37XCe2Zv3h9R8Q
         EV0l2u+CeywC1htVJ4xmC3Mw0sZ/+waWJfVLfI7O+LKfMxeHYWpmrUUjS/rIErVD8QbJ
         GGLaT7gBZcjc0L2H+V35gJMhTM43CdGnqBXjO2Htg7Ea/hd/lf30AntXTlvhj798GXH+
         5LKg==
X-Gm-Message-State: AOJu0YyhFG2x/mhlMlmLQZBhtNNWYcq0ThyIo/jctbHJd9bX8zB0bd+H
	6YEHuNZE7L1oVdfQ+BFeBNB56dZOZg/8c4yFKM1c7d1fORY9skWTfFkfl7xD/Td38rQ5r+eFmPo
	lSYL77q5o1sQJYcv2eDmfcZU7p8I=
X-Gm-Gg: ASbGncugV3TWKGxAErcO+61KDHvg7YjdTECq0XXvcRgNTwPzYrHxcIoNXK+AjUnuOSK
	RwVD+X0uSbrVlOXaTXv7lhsdv8PxOug==
X-Google-Smtp-Source: AGHT+IHUxLPZU43tEgLceHHmTKCvWswrBuohyQ3pSQKZHYJBpC/D1vzDbB5jgWcMmdV+LoilVpnlleTdsg9q2w17uj0=
X-Received: by 2002:a67:f8d4:0:b0:4ad:de0b:fe0f with SMTP id
 ada2fe7eead31-4adde0c0654mr2217148137.3.1732271153988; Fri, 22 Nov 2024
 02:25:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Nov 2024 04:25:53 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh681fhve.fsf@gitster.g>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <xmqqh681fhve.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 04:25:53 -0600
Message-ID: <CAOLa=ZTMk-xDF1o3jfowLeghxa3uAPdZo2_Fmz2chz9PxAOUaw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Change midx.c and midx-write.c to not use global variables
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, shejialuo@gmail.com, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000c9e22706277dce30"

--000000000000c9e22706277dce30
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Since the `packfile.c` cleanup is still in flight, this series is based
>> on top of master: b31fb630c0 (Merge https://github.com/j6t/git-gui,
>> 2024-11-11) with those patches merged in. This applies cleanly on top
>> of next, but conflicts with `bf/set-head-symref` in seen, the conflict
>> is mostly straight forward. I'll merge the topic in if it is merged into
>> next soon.
>
> I think set_head() part is fairly trivial.  But there seems to be a
> much bigger conflicts with the incremental midx topic.
>

I see that you've merged the topic to seen and the merge resolution
looks ok to me, I'll also merge in `tb/incremental-midx-part-2` for my
next version.

> I actually do not understand offhand why doing anything to the midx
> layer needs to change the calling convention of set_head() or many
> other things that are unrelated to what midx layer does, and that do
> *not* use the new parameter *anyway*.  Shouldn't the "subsubcommand
> can inherit the repository from the builtin subcommand
> implementation" be split out as a separate topic, which the midx
> thing later builds on?
>

That was just the progression of how I worked on these patches. My goal
was to remove global variables, the subsubcommand can inherit just was a
dependency which I bundled along, since it was a single patch.

There is no reason it cannot be split, Let me go ahead and do that.

--000000000000c9e22706277dce30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8720c4b0ae4c73c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kQVhEQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVJHREFDWWpVQ09jdUJ4VEdpSWJ5azJoWHJKTW9rUAozUWNkMkhjSlFE
RzBFTE81bmNJZ0QvSytRWFdkUVdoVXRvK29lOVlmNnUwU0M2K3Q4NGZyTHJZaTJmelhOdVQ1Cjc1
SnAxNDlNNFU2RDFnVU0yVGJLRlYvaUh2eUQ0d05VcmUvc0JJcVVUU1RhTHY0TjNBR1MzT0g3OHU0
eE1nNkIKdzZNSjZuOVlPYmQ2WEZKdUdCb2dVR3FvTmVGQlF0ZzI3anNPMVBVVU1obm1yM2FhcVp3
UUVpNFhyZ2h1enBjdwo4OFlGanRrN094VlQ5NHM4U0NMYnNvdFZFU2ZpM3hrSCt4SjJCVTh4MCt3
bkdxLzgyUUkyLzIwTktzZmNoa2RzClgzOXBDTkVRa1NTcGZDOEFEM0dpcWNMZWJsS2VRbVJTQ0hL
THFmb01YbFREZTZ2aFM2Z3l2SkdHSHlGM3M5VkgKcWY3cHlicjZDK0lhTzN2azhBbFJiWmExVFlh
K3FNTEhBVTF0aGlCSnY0emdNbzM4dlBYYkJpL2tWMGh3cmE4RQp5VVRoVDcvUVVaVDhMYWp1M3Fa
NVZ5YWRiUk9keDN1blAwcFBSblJwL3E2c0RWM1NVbWt2djBvcHZhZGNoVVYvCldrdERBYmVqVGpH
RmY5bUh1eE16THJvSEF5WlpNcHdEUTFhVTZiST0KPXdkR0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c9e22706277dce30--
