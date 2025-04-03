Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29C2A8D0
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669595; cv=none; b=k/J4VCuZa4ksskBCJRFx4vxvv9mHWqznd0g8ZM8WHMuj+A0tfanK6S6Tp7rRnNG7VMVML+pfepDGZx4ltpGe9ALrhdOKWXpfjB5Z9vQm7Z/wc3pEjYxbyADiiQaEYcmYO8S0wq0qlEBZ831Cn8MrvghdQy3416Jkssx4iLNd+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669595; c=relaxed/simple;
	bh=lhXCcbfm7O3fl+K6GcQGjuoJx35NoTIuuN4nAu6QsWA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJy9T7dLQxeuJ0u7Wxe8Yj5/fgWTJ0BF9NlREleZM3AJeGrh0LRp936CuJkMt8IhJWgZQTzqhdcwC8uVIDXoI0fpo4TM9U5VObmIYgGPDpANwXuQ2fcFRxG4zirHmRT5soRFOBxIKYsX5rCS1OYc6EtTaEphdRYJzqNtyzT6uMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8GsEJ49; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8GsEJ49"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so600422241.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 01:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743669593; x=1744274393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWWbfO/6+iXwwBqUt7uvKiFDwJ299GCXTlRv+/nMvfs=;
        b=Y8GsEJ49Ni4QH+y1SR9EqD03eJoMQYHQPOMonI5BA7JtJferc6ikVxHhidNKpOQu4B
         jnNc4f81fdvMaY+Ni+m44CustLAg2iqNbvxcCMQiZcV+N+aR9LBj3Z3joRCBbb8dY66D
         9I8QW0WDNVywVsnPk5ShghR6ggsPeU1SDDv+oWuM9jp2Hip/uYZpq3XD5913ZtkrVcOZ
         +Zf83t3jrztYp/CsZVNUHq/b50HYD6FDIeeMHsX3DnN6xoKB4hjknxrgyyp8X8ppHV4O
         p43sFfaMRSRQjZpYZIfay4EMUiQ/0EnenRcJMSGmznFMK5Qq9vBfbg7bClEho4gjIz3a
         uKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743669593; x=1744274393;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWWbfO/6+iXwwBqUt7uvKiFDwJ299GCXTlRv+/nMvfs=;
        b=XZbP4alOcLOh+NVk8aV7gksXkBSYhxw2bfEh8nXjztDpHRHzacXdmwmJVaQ18kwXoc
         yiKptIgWGXTDnaTX2OPobqrOZM/xQJz1ngSn9UoVA+lnBs33Sl1EpijjsOguGb7O9vOH
         e1Zg45AkjcxQ8bStqA34v5fXtNhAviAHUkiZGXBOnQIlNEC7SmY+63/On2qm2STO8TzQ
         +/f9i2dR3JvuvDtuHRzalo4FgnoyG97atFI9MY5n2ulzMIQvj+IcQHNJoEZ9dWhs4aTD
         UUG86Pl9Rbq7nsx0PQByrMMdtOXFWU6PurJk+ohko/7pUKmvnNeDjh26ZRI3m9dtG/ES
         6Org==
X-Forwarded-Encrypted: i=1; AJvYcCUlmoWdyicWZ7xW0jjyCVTzxBrC3QVUaakYAncwJFIU0tMG8QWUTAAO5zDk95aYd0ns+8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgGGn05tGtYR7OkgRc8pSr8Sx4CqAgUp7T2ov5KtOo2+a4HlR
	bYxr59UGVYfbLvSZ10bUq+V2DmcvTu4mLcjfquBjDPVwzKPvT2dx3M75lLZHyTphmmcxpiV5R8W
	hu87l469phh1jeK7PMDuwqcLI8bs=
X-Gm-Gg: ASbGncufM6BacTB3KqrmW5CZM47XP9PBc6JoIlA/d3DT6fTVmOlC023tY0+NgNtwZga
	B0o5gN2LAJ7LdRkPhmWQmGmww3O+kfJkd/scIS8LHsOK8Ldl/+55hKpFS1eRIh89z948SUuFAQn
	J7ra+y5Eaf4phNcvEPv9+AkQrB81KZG/1jRplzuWwgLviZR3kHVuRC+96XLA==
X-Google-Smtp-Source: AGHT+IH1C5QOghYnjvrol36rqC8DHDTpJZ5BKi4AJfjp6D2DfeejLEA5Lt9zCa628ga8BNDaRivcJLcVBj5EYhKpDPU=
X-Received: by 2002:a05:6102:f8f:b0:4c1:9bdb:6188 with SMTP id
 ada2fe7eead31-4c839e38348mr4650681137.13.1743669592665; Thu, 03 Apr 2025
 01:39:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 01:39:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im> <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 01:39:52 -0700
X-Gm-Features: ATxdqUFNByht0fxMQRouF21_1GcJMWpNZoZx9SPKeCg6xyxUrdIm6pszVewM07g
Message-ID: <CAOLa=ZQ8bTn-prAs2ycLdLLjVaLQL4GtLw_gFsvAcx_6j=MBjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Collection of build fixes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
	Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, Peter Seiderer <ps.report@gmx.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000ad8e0f0631dbb630"

--000000000000ad8e0f0631dbb630
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this small patch series collects various different smallish fixes for
> issues with the build systems. The intent here is to bundle all of them
> into a single series to make it a bit easier for Junio to keep track of
> them.
>
> More specifically, this series:
>
>   - Fixes an issue with handling "-Dcurl=auto" that I spotted recently.
>
>   - Replaces Sam's "sj/meson-test-environ-fix" [1] with an alternative
>     solution. The branch is currently in "seen".
>
>   - Picks up and massages Thorsten's patch from [2] to fix generation of
>     "gitweb.js". The fix has not yet been picked up by Junio.
>
>   - Picks up a cross-compilation fix for Meson [3]. There has been a bit
>     of discussion with Peter whether this is the proper fix, but based
>     on Eli's feedback it should be okay. I'm still open for alternative
>     implementations in case anybody has suggestions for how to do them.
>
> Please let me know if any of you are unhappy with the way I have given
> credit. I'm totally happy to change authorship or adjust trailers.
>

These patches look good to me, as someone who is getting upto date with
the meson build system, I really appreciate the commit messages.

> Changes in v2:
>   - Drop the fix for Perl-less documentation builds.
>   - Pick up the fix to use correct environment in our CI builds.
>     Johannes mentioned that he wants to eventually get rid of those
>     builds completely, but meanwhile this is a trivial change to make
>     the jobs do what they should.
>   - Pick up the improvement for cross-compiling Git.
>   - Link to v1: https://lore.kernel.org/r/20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>
> [2]: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
> [3]: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
>
> ---
> Patrick Steinhardt (5):
>       meson: fix handling of '-Dcurl=auto'
>       gitweb: fix generation of "gitweb.js"
>       meson: respect 'tests' build option in contrib
>       meson: distinguish build and target host binaries
>       ci: use Visual Studio for win+meson job on GitHub Workflows
>
>  .github/workflows/main.yml           |  2 +-
>  .gitlab-ci.yml                       |  2 +-
>  Documentation/meson.build            | 12 +++----
>  contrib/credential/netrc/meson.build | 22 ++++++------
>  contrib/subtree/meson.build          | 20 ++++++-----
>  gitweb/Makefile                      |  2 +-
>  gitweb/meson.build                   |  2 +-
>  meson.build                          | 68 +++++++++++++++++++++++++++---------
>  templates/meson.build                |  4 +--
>  9 files changed, 87 insertions(+), 47 deletions(-)
>
> Range-diff versus v1:
>
> 1:  4bc8060a975 = 1:  3e9137c2d18 meson: fix handling of '-Dcurl=auto'
> 2:  4365cfc4a4e = 2:  7ba983d446e gitweb: fix generation of "gitweb.js"
> 3:  02d6ae13dd2 < -:  ----------- meson: require Perl when building docs
> 4:  fcf2478bd82 = 3:  33cd3e490eb meson: respect 'tests' build option in contrib
> -:  ----------- > 4:  1cb210c91a1 meson: distinguish build and target host binaries
> -:  ----------- > 5:  3172db10a10 ci: use Visual Studio for win+meson job on GitHub Workflows
>
> ---
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> change-id: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72

--000000000000ad8e0f0631dbb630
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 76a3e2e16ccc230b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdVNWWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUh2Qy80ejRtQ2xKbzJmdk9QcjBhL1FjeUQ2TDBPUgowZWQ0dTYyUmhN
Y01kS1J2d1ZEbTQ4bGdqaGEzRmRFYXQ4M0NGRlJjamU5bDlIbmEvTmxYazhRaHFQZXppcHh4Cm1W
c1V6TWsxeU81eEd4Z2x0bmI5WkF1dXlQYUdWNnFDcjRFczFEa3ZxSTJITnVtTFQ1d1MybzFlSVZU
QWRhNnAKTlNnalJhWHpTTnF0emhJRzVvSkhTbTcwN3RmaFVxYWRXL083U1VVNzJkbHE0QUpuR0d5
elRhd05XeGt3MC84ZwpEaUs0T0E2NUFHTXJEYnNIRERZaUNKNWF6QmxHZjZRcVNkRjRJaU5uQkQ3
ZUNPZWF3UEdYaW5rMzNXTGNsZDMvClVCV25UeTVTaHpZbDIzektYbjhFQ2w4ZHZ0Z2FaUjFVL2NZ
ajhMVmtFdXJGM1gxYUVOdnVKTHhIY0w4eitrczQKVyt3VFpqc1pZcU0zVXBzODIzWXlpcDVzUU5s
Zy9IalhEV3F5UmVkWG1RbFVSRTIrSzhQQVdmUTcvL3RuQk1OeQpNcHU4TTU1bjQ2RXNqbVpoTjZa
UmxocGR1dW9uNXdETThyS0d2WFRVWjBnRXRaUVNwM1FyaDllL2s3VUhBeDRkCnBkdmZQODNZTi9a
Szk0djM3UW9uZGFPa2c2MDZEazFlS0tuUWZ0dz0KPXhBT0YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ad8e0f0631dbb630--
