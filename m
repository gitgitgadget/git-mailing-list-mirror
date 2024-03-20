Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364817E761
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960714; cv=none; b=BRMv1k+6kFrHNfNNXK9qLTwePKBH61DvGPNG4k0QzyeoRWrDqBHtY6Fnl5x4PE0xciqqwA5p1YTHdfavbTck3u0ayFXFaFbmncamd3VkoJxc4ZjmHuJAxh5rHV6zZMh5aiEmPs8rTe23YbQQiUHAatpnb1k+Z/zICNpXM74t4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960714; c=relaxed/simple;
	bh=GYi+eKM2ONWuXPJSxiiLjGcTzFFfPGVuBMhNKAjG4rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lts6uIR4bvT9hfXDTEzjjY2CldO7I8i98RSdD1pY3UEd02WswaoigpIomzhvywXxcEjcMgBe4QSgnF+iaUdyru1f9QSW05oskxaxAs3EMt8GYA1n5qobV/4FW5As4rmGGS+rtGiPLdyXFK1HAOK8N2nvIj1ib+UlhiF4FA2IRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgQUBAFU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgQUBAFU"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513d23be0b6so285237e87.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710960711; x=1711565511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYi+eKM2ONWuXPJSxiiLjGcTzFFfPGVuBMhNKAjG4rM=;
        b=FgQUBAFUWprdXRUWLm6PXMV0dJV85bzDu1qI6c7dBSOhErsRtPOFLOQsbTrPerjrao
         563PBZ3nxkyThIvvPXgUbe1VJT6F2Kq/7l8HmmNLtMHP14tLFkrSgQzLNViP7Q2DE7m6
         L1vlzHRIF0jf1kKZ4rekuYcowW/Tyfj7SKbtVtsycUwg1RAlJn4DoU0vgBNKfsICZno9
         d7j1lRqrOKjIA/K7fG4470zXjoCSpezYxLbEDDQQZue1pleBuDzw8VkoU98SsxOFVjT5
         pUHMUIMNenefQUflRP39bzGb/4uhVwby7Lr9Qg4UHtRsuPckEiX95iW2seTQNjygtE7s
         06ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960711; x=1711565511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYi+eKM2ONWuXPJSxiiLjGcTzFFfPGVuBMhNKAjG4rM=;
        b=OFWZ89M7lu5DiH2oiDWK0bVQHZB5c4fN52lfuKdNLF24B2J2ZyppdiOosxvBJxlTZW
         c7GRv4M/t9+QWoAUHabgxrfww1+5ACFQogZ4hazEMh+ouTUsZJxueNCP2CViNylMxtzG
         qBRUgxSNANiFBHybRQKjtpvybhZSrvogQ1+gzLP13zy/oRUjUnovV2hP1MInjieDjnp0
         +JH5jPhn65giyCtdvYmh0yyrsNLBuu+iexZa5wWO+KVpdlGk6dn2oF7UPk3cu5Bqk+hi
         VwoIgLOWhpFL9NcKTGy7t3tg7RHytC/J0D72o+OoFtZd3+bUVr9ZqwWa7dqSqPu2jvYP
         qOAQ==
X-Gm-Message-State: AOJu0YyZ3OWwS5kaTW6UZA7Yo5CDmPckQagWZESwYlnM4xUyFB1JaWBO
	utxyj8HGFXJ8FQ0c8K8ZFJgNaEP54lQnkawKC8WF/WotH3WQ2kU6JpowvOg0hMNQP68TLLGMcMX
	VCRyOT8ov8d8SBQ2qMhmvMjBO098=
X-Google-Smtp-Source: AGHT+IHlob9+wFGh3F93Ig86C1ox9ObkPueaTEA5wi/9wyQFvPBIdtB8kj1RimUo6vGBO33XvaX8ZyXm5u10diqmhmc=
X-Received: by 2002:a05:6512:2027:b0:515:8130:e3bf with SMTP id
 s7-20020a056512202700b005158130e3bfmr1852852lfs.63.1710960711010; Wed, 20 Mar
 2024 11:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_3_ys4tAJ3B5uy1aUpzknEgQRwdADNxFXDmLxgCL2bZrg@mail.gmail.com>
 <CAN7Jk_0hKTacR4cQiYFW-dcj6ipA=8QcCGrVd7rrJ4vVUxUBKg@mail.gmail.com> <CAPig+cS_L=CS7TQhrt5m8M+O-OsdH0oiZkttWp9SxdbZw0Cu6Q@mail.gmail.com>
In-Reply-To: <CAPig+cS_L=CS7TQhrt5m8M+O-OsdH0oiZkttWp9SxdbZw0Cu6Q@mail.gmail.com>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Thu, 21 Mar 2024 00:21:41 +0530
Message-ID: <CAN7Jk_0Jhr3SvG6Sk=5BXt-W3UpSvOoenUBUZ_XieAdApoo3kQ@mail.gmail.com>
Subject: Re: [GSOC] Microproject: Use `test_path_is_*` functions in test scripts
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Mar 2024 at 02:04, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Tue, Mar 19, 2024 at 4:21=E2=80=AFPM Sanchit Jindal <sanchit1053@gmail=
.com> wrote:
> > For the microproject, I can update the file
> > `t/t9803-git-p4-shell-metachars.sh` with the `test_path_*` asserts as
> > required,the tests only have the checks at 6 locations which can be
> > replaced with `test_path_exists`, `test_path_is_missing` and
> > `test_path_is_file`, Please let me know if this is enough for a
> > microproject.
>
> Utilizing `test_path_*` in t9803 would be suitable for a microproject.

Hello,
I am having some trouble with the institutes firewall and `git
send-email` due to which I am not able to send a patch email, I have
created a PR on gitgitgadget, can I please be allowed to submit it,

Thank you
Sanchit Jindal
