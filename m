Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523F17BED0
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714117; cv=none; b=r9+/vLwCmkKhgkYCXHTpw8Bimj/vqI9Ssmp56gtJ+RGy130jElKL759R8rKzSYkTB6T/jx+c3eEz9AUZ0LavB6awy78uqeoxIkOzdvkAgHLdc6hxXSs1TWEl9cM5gKH46kSHbl62QqPXdEA+QBbg9eBITJpixLiO6J5yTGjBc1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714117; c=relaxed/simple;
	bh=jlnn1GltTO1qgPtR5MiSWAlyP+z/IUMdnb9XRno1+jU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fm8bkwkjYhGzXm6B5zzliYC877Lnps93IGJ/3dm+25UZW/D66RqS3DXtUgQl2fTN+kMt1hEvcpYwyklBWYbSbJqytlm9ZABVY4DZLnGZrs7GvwKpX8+gd2qpd4IahWP0N3zvn8IgbbuI56HL1KnkD9v7d6vt+rW90MgW03h6RZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7KLsLiS; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7KLsLiS"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbdb139b5bso5190382137.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764714115; x=1765318915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIFrndMryWvAmzW7bGJF6Vq0V+bqzBHLmlXpz3p4Xk0=;
        b=E7KLsLiSZHQOS+zWd3cbbmwhNhkke62D89YZbuxY9Aw3C/ze0lROxer/1XqpcJca9h
         oh6qgCKsyWX8RJpmooLr6G83ceQTLPRrRQkv0dAeQujYxDb7fre/6Xw1tlyTmr9aYu75
         +NyYWwtmawSu5JaZJKIbLo4idpXMoC8qAuOxojMEIXfvxSoFMxqTmIRWcEHOYyLbCWLo
         PVoTkS2bGLVv4B5eyK6s+XVnTQ1+jHasCIwW7L18NNg/nsQL9/dwYSXc5RNGhu/N9oXA
         toXfmslnxBJpuRRr2dYF3uN/lcG8ZFuBxyVIlYIk2VVEAZFwhSg/18zzsP9VvYsJPxLk
         8JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764714115; x=1765318915;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIFrndMryWvAmzW7bGJF6Vq0V+bqzBHLmlXpz3p4Xk0=;
        b=E0aW6VRIdwRa1l3y4oU3bBf/kAq9E6AKTwSyVeCayM+6H/qhhuefqSlIKS+C1wzMgW
         SwZZsO4MhUoea66UceHrGrTE3XigQTRz3hKd92xlhRqLrN2Nc+37XEpY5GWzWdNlwaMN
         k0Dmi5BHT+kVGDulkgsrRxUNE5clp/p6hNjQMgp6FeAyEnonkxMxsEEYI7Pl/pZrRZG6
         uzChdcMC2y+M3fKHPmanEm5bc2eAxli3oMEcIk+otI7xH0lvnOBgoawJ/FBcF9AUWtD6
         rMS9Wo9gg970tjqwAI0BGhGpWQ8rCP5kKXFetb1gKK0Q6Tz1xUEumJJNtjB+VJalbNsM
         aMvg==
X-Gm-Message-State: AOJu0YzBeLcNPEhRaBsWTF9J7HxS7WyNyUpTIFdwp3i5QfPxp2zCBP+K
	5dYnGBywvayDSS0pchvfLyYComxKn8LvnGy6sJblbgFmfkfJ+AQsK0UPlqC+WqOkAUIXCtmkBXb
	NTfyVyEMd3u8IaXfGZxADEDJVGgqDTyhhHA==
X-Gm-Gg: ASbGncsasrg4iEoceD2Fi9JMgKIOK7RQonEMZM1gIeGWP+w53ECcbqwWw2iZz73FpDz
	QfhOOvRGJzCS0nosflMQT0KDMdyXuNC5UW378BM4E+AYYf7v1SvBLdhUh4Ay0qr+YdZgKMC1fft
	DjxMuHCDlUpsbRtjqKiCL1Fa3VbsDExN1mnXbTGdmKco3gXG+gLrl70xbiNSoDJ5q2ISrHLC18R
	kdtej7TwURP1XdGqL5hir2QE1njLwN+g1yqNWeYhUwjYu7f3pqa/TyiuwxdOBgZG3Y/Vu/tpBuI
	c0jd1qfevuD6npgm0w/6LumeqipNoEaO82Mn70o=
X-Google-Smtp-Source: AGHT+IGHynOFO3rdHk4C88ta4zCVpsucJIF6GfOn1vC1nDnGhaOVqVXpG2FdVwFt3+Nbig/RMbtuxUWtRzBumQ8+dSw=
X-Received: by 2002:a05:6102:cce:b0:5d5:f53b:c993 with SMTP id
 ada2fe7eead31-5e48e336b40mr31249137.24.1764714115013; Tue, 02 Dec 2025
 14:21:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:21:53 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Dec 2025 14:21:53 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aS2X7pI8muco7a1Z@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com> <aS2X7pI8muco7a1Z@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Dec 2025 14:21:53 -0800
X-Gm-Features: AWmQ_bkd94KYi2mNvjvcciILbCdmDLZfoi8wqZ4h2zswoCYPKWPSIcA1FelWwkc
Message-ID: <CAOLa=ZR+YaWmqUxz+OjtKP88hWj5BEKwpvY78vrgWdoJecEwkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f4b71f0644ff85a9"

--000000000000f4b71f0644ff85a9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 19, 2025 at 10:48:53PM +0100, Karthik Nayak wrote:
>> Git allows setting a different object directory via
>> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
>> This asymmetry makes it difficult to test different reference backends
>> or use alternative reference storage locations without modifying the
>> repository structure.
>>
>> Add a new environment variable 'GIT_REF_URI' that specifies both the
>> reference backend and directory path using a URI format:
>>
>>     <ref_backend>://<path>
>>
>> When set, this variable is used to obtain the main reference store for
>> all Git commands. The variable is checked in `get_main_ref_store()`
>> when lazily assigning `repo->refs_private`. We cannot initialize this
>> earlier in `repo_set_gitdir()` because the repository's hash algorithm
>> isn't known at that point, and the reftable backend requires this
>> information during initialization.
>>
>> When used with worktrees, the specified directory is treated as the
>> reference directory for all worktree operations.
>>
>> Add a new test file 't1423-ref-backend.sh' to test this environment
>> variable.
>
> Based on my reply in <aS2V4TKeS4V_oxAb@pks.im> I wonder whether we want
> to take a bit of a different approach:
>
>   - We extend the format understood by "extensions.refStorage" to
>     understand "schema://data"-style strings and adapt the "data" part
>     to be passed through to the reference backend.
>
>   - We then use the same mechanism to parse both "extensions.refStorage"
>     and the environment variable.
>
> This would have a couple advantages:
>
>   - We make the ref storage extension more flexible so that you can move
>     your reference backends somewhere else entirely.
>
>   - We prepare for a potential future ref format that _needs_ to receive
>     data as input.
>
>   - We have consistent behaviour between the environment variable and
>     the extension. So basically, the environment variable starts to
>     behave as an override to the extension.
>

I did read/respond to your reply there and I agree with your suggested
approach. An additional advantage would be that this would also mean the
ENV variable is more deeply integrated. So the backend override added by
the ENV variable would also show up when running `git repo info`.

> One issue that we'd then have to solve is how to derive the worktree
> references from the backend. Arguably though, I think that the extension
> that was specified should also be sufficient to identify the location of
> the worktree references.
>
> We'd have to refactor the code base a bit though to properly reflect
> that in our tree. One way to do this is to extend `ref_store_init()` so
> that it receives the worktree (or NULL) as input. In that case, we would
> continue to pass the combination of format and "data" to the init
> function, and it would then know to locate the worktree references
> itself.
>

Yeah, I'm considering adding this information to the `repository`
structure, so along with `ref_storage_format`, it would also contain a
`ref_storage_data` which would be passed down to `get_main_ref_store()`
which would in-turn call `ref_store_init()`.

In that sense, when in a worktree the $GIT_DIR is set appropriately and
this should all work accordingly.

> What do you think?
>
> Thanks!
>
> Patrick

Sounds great. Thanks for the input

--000000000000f4b71f0644ff85a9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 88ce6e3855dfb9c9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rdlpvQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0JqQy85N05jTlJ6Smh6eEJRaEh6Q0tLdXFRUUU0dwp3SGFveDA4UE5W
RTVVNkxRMjZQSjExK3pPbkNZQ05Lc0NWbFh5bUVkMndqU3Y5enA4S2d3TWNGUGdtWG5FZkVOCmRj
YjZRTzNSTW1HeXdzbDFFbm1hYjYwRm9tdTQxNU03N05rUk0xcGpjUTB0UkJ2Vk9raVdXdXBGMVY5
ZkhBaDEKeVJQVm9UL3BLeTlMeGd4QzRWTkV2TjdZZmVTMkdMWk5vdEdra29GWDVWZGwrSHFpTHhD
NkZTTFMzaG4xN2k3aApXVEJZNER2ams0UUVMMTdHWENDa2hYUm1WQ1pOckNxOTd2UDhXa1VWV25W
RyttYThGTitobGxnenBSQUg1L3lXClNvZ3Y2TXRHOVdjTXFjVk5nSUhZR0JoQ1RWYlZMbVBtR3pr
ODlHeUM3TkhTSEJqMk9rbGlGNXhKWG1DUUUrUjYKNVVyODN6bFZqbDEwdlNBSlBMSjNQbGUvUENE
OEtPclJiaHY2ZXlJcVVMN3pDSE42TEhQMG1QSHUvcWMxdmg0TwpwN2xPamNTYXROKzN0NklkUmxG
cVNtMUVDekJQdUw2bGQzLytlenc5SDd2Q1JDVWd4ZGl2SGRocytWbk9GZnZqCnlTdDVlS0k5cUZM
Y1pMa054VERxVmE4OSs4THBPbHZMNUNXNEpLaz0KPUZxOWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f4b71f0644ff85a9--
