Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66E6979D
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz7ZV0B1"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d89f278cc9so472570b3a.0
        for <git@vger.kernel.org>; Thu, 21 Dec 2023 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703155792; x=1703760592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYYDRtR8Hs11qjOkgYoq7ySgu9WVWcH8blqM2eWukfQ=;
        b=Rz7ZV0B1QBUHQIHQxjYaiH3HZoKrIPSaNlutUO8FPrZ2FBb5XFvWuTn49945UfCAT8
         Z/XDhxgJBGPAeqWSwLaUwlmw3doernyQoXIPabO0BMGI2WGXZmax0nVPqVxdw/U/QWR0
         eEBKhyImuIxDm4UwZzpxHMmDQy4/CkEczRNt+9Yrc/O8lv54U5lklWHs2F5p9X/q74xY
         RSPhML3zjEA1tCxjyHkMYtK5ru2yUguk/7O9jXxnsFRBugrJqrFzkxhfYklP7QsuvnHC
         4tdLIEALoo7Y5zoMhLC3NWwiU0yafRY4iv2nLAOHPxypTO25DsWVGOXE527V0rRmJ4gt
         /jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703155792; x=1703760592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYYDRtR8Hs11qjOkgYoq7ySgu9WVWcH8blqM2eWukfQ=;
        b=tyJnNfd83wqh2CDV0MmyABEsnO0AnOCuIb6TPP6aqZwLe2Tl4wI6XQpQ0UK3/ju55U
         gH4m2MC1WC6Y0QGpwBfgVO1ciFS3eHojAa97Ga3jPXCT3VchTHUz7NV8MMkmS4rzQYmm
         PrKRPHbPndWYPVbAP5eWGC2Zo7Apu0A2g7rjlFLLYVLDRuadMblbOSb1RR/U73s795hO
         pzw7Wlb0AJ3DIRYs283bhr9I6bnmTum7XsN6C9mQr9YmluQC5xHzIQ7aElCgf7LVsrWV
         uQWF1k0aALi3iv9VjpxlwCp50zm/9hheU2bLa4Ts+ndZPP+azkoe3HTjzBfj498FH8Ar
         80gw==
X-Gm-Message-State: AOJu0YzYlKbZDIZz67QC21mjYR5wna4habQh1+PFvzoRIuYFKNGYZHBR
	e8K6JsvKIU4yDKq4Az/MxgiuH+BBO2Iqcpn4cpY=
X-Google-Smtp-Source: AGHT+IGIQUZAsqE71AU1E8ZsG4Vxqz6YRkAUoNnklR6RBRcGx4fvp4cOc6CH7LiIsY0WEvQVfxdY3uyMVvq60kA6f7Y=
X-Received: by 2002:a05:6a00:a14:b0:6d9:3e48:a782 with SMTP id
 p20-20020a056a000a1400b006d93e48a782mr617895pfh.18.1703155792279; Thu, 21 Dec
 2023 02:49:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1700549493.git.ps@pks.im> <cover.1702047081.git.ps@pks.im> <bab4fb93df8d1a620eefeef99a49ea52c98dfc6e.1702047081.git.ps@pks.im>
In-Reply-To: <bab4fb93df8d1a620eefeef99a49ea52c98dfc6e.1702047081.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 21 Dec 2023 11:49:41 +0100
Message-ID: <CAOw_e7Zh025FdRmHdxr4M43cZkKmO8W0W+h=Gb6+DJ-O2V-_3g@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] reftable/stack: fix use of unseeded randomness
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:53=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> When writing a new reftable stack, Git will first create the stack with
> a random suffix so that concurrent updates will not try to write to the

I had noticed this already. Thanks for fixing!

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
