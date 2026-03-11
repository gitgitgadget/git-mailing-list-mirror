Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AF1D7E41
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271684; cv=none; b=Hx0XgE0DAAC8QrjpwZuxpq//RmZ2BkEKy5K63Mir7cMdSel7GHnBcJfBsbCOgCE2pvC2jQlZkVZhQP/+eZbMWr0SO72y+8Fq6zvLUKtt5/tiYpG85A1D7P5o8BRkstlnQaPMBDkrAKkLoF1Plkysy8FEVXYnM0c7yxWy6BSRcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271684; c=relaxed/simple;
	bh=bTkg+kKlww1gGtg6fBiU4gRahcXFLln6TPirYjrxz8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGYT7U/fq4G/zuS3hn7Z+q4zn3RQ2iwOFj4dRSxeBCbunDx+3vKk3F1j0l1dMDnSX2tvMNChalQEKOV1S0Ilsz9kQpUPukhywZqhq4dD3hRHuO562NON+W5EFXc3Lvc5k0yem+850/C5t010kTgwrw7I7zzW0qkppHYmdruoPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyNWkKwH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyNWkKwH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so296193f8f.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 16:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271681; x=1773876481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aN3aZKkgcSOjzP4SusJY5zZAw0No75gf1tSkB4DIvWo=;
        b=PyNWkKwHQEtcS/71X6SJr6kbbYiec1Cd6VIaJLg0q4Gm6y9wqh+Wxc1/vX5JU9AaIS
         YE5DmbPbgG5sX9qlsBapJ+CAeeVPFGP/xJSbRifTvauTZD77h3I2QHXtgTPXgAMeYXHy
         ableSVgU16xOLU8kHjjRH4zZ1H39pcYSFAzkUiv2uvMB8es+KFZfnW1OPHGATslmD3FA
         nL+fJCcdT0xWx+AesXPgY0g96moJmcU2O0ZlsNSAzGhS/lSx6NQWjtQE6B0BCC0Dcq2y
         Nb9j1r5ctjpoGZDrp8pERsTYqAWVNydTP6dvL5aP6WXsOeAujq5IV2CF4xuJT+HEmmHu
         0Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271681; x=1773876481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN3aZKkgcSOjzP4SusJY5zZAw0No75gf1tSkB4DIvWo=;
        b=xSTTzWmFGkkOq/2DHN+aav6kkPGfVZQizAP4A0nWATHSiz7Wht25mBGbjiPzvktlYT
         Rf3bI6SH9+itQVQJKJY5oQRLGTt6oJ1od7CJvc+KGSzQV6wXKdS7bHVts72kVKXeaGzu
         k7Y4re03uwOekRyN8iyWlrrSlbATJZ8B3EcXrgeTKIfKrC/Pyj7c/s4MTUVMltxGQphS
         9YaVtgGYXRD1mvCvmf81AQAfebxvzsQjW6+BOyHuLQFQuJvuDxdfFX4CVCrbhYKd3e4B
         E3R8TAP6Tl1vdUsTMJo3wxQp67dbXQ5DkXwTtpcZy+kkYjaXpKqlwHwJRG7tDvG07Fy2
         a0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgdEKVROFGZrtFVZ3y+6H5A4BQ1j58QCxB70jNXCtCXYFxwGYHEaDagaXkMdJI3o/f+XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCer3SFSyeJ7xoAiBwy6gE7LhJb6MthHIaIAKmh4sqaltCRdpz
	9DJ9VYnHcXEgA5iG7vgbHcidiloK+O5FDskMPhVdW/G3bA/n8uOToV+5
X-Gm-Gg: ATEYQzx1DkQd4kdGrKkkYAQpwlRgJW3kOCN8zP/7LTvEv218Xm0srm7yxb+1oFzTZh+
	Tn9yx8PCO1NgGjk19gszd6mdTFPkVTuTobx/D4aAZQTWgYDum1QVpGhCcItM9IEo3ToiuAAKuht
	VP1NJWur3ZaZhRqs1PJPI4ZzEPWWX6GNSBgc36S/F+jqaNKR0jA0telcuDsRhgVaLZDYi29muR+
	Y+28j+2jP570Y8/ShyKMrNpZjaJBLgG+bQfRIOnULOZqqXJJnSHuZ3AfvuuATTcKHihQXJwyGBS
	Vvy85eIXupD2qqss6u8lw4oyaXV5ZWNU1ZrnKXFom4n61sOFqVqMoSkIeeH3a3GXidrZrGsINoI
	MGiAhHH1HYwRpBlgqcqa+NpRcqnvvsE08jZ5PjZrmclUOAqrXfpYYRRrwtFDmfhXOaqFiv3RkIo
	CWw6jbmVCTuC10C7MFAkGcikaQ4Qd6V+hvNhofJLvIDyIPu86Oow9yvrqMUsGl
X-Received: by 2002:a05:600c:c4b7:b0:485:3ff1:d5c5 with SMTP id 5b1f17b1804b1-4854b0a5669mr70838145e9.7.1773271681210;
        Wed, 11 Mar 2026 16:28:01 -0700 (PDT)
Received: from localhost (94-21-146-27.pool.digikabel.hu. [94.21.146.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm332660325e9.10.2026.03.11.16.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:28:00 -0700 (PDT)
Date: Thu, 12 Mar 2026 00:27:49 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 7/8] meson: compile compatibility sources separately
Message-ID: <abH6dayn5tJBMY9p@szeder.dev>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
 <20260310-b4-pks-build-infra-improvements-v1-7-ec75d0710d6a@pks.im>
 <a5d1ea70-12dd-461d-b5c5-a1127e017d01@gmail.com>
 <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <debb89c9-2fab-4922-af1a-6048094baf9f@gmail.com>

On Wed, Mar 11, 2026 at 02:56:24PM +0000, Phillip Wood wrote:
> On 11/03/2026 14:32, Phillip Wood wrote:
> > On 10/03/2026 17:52, Patrick Steinhardt wrote:
> > > In the next commit we're about to introduce a precompiled header for
> > > "git-compat-util.h". The consequence of this change is that we'll
> > > implicitly include that header for every compilation unit that uses the
> > > precompiled headers.
> > 
> > Is that a meson thing? I know it defines precompiled headers on a per-
> > target basis but does it somehow force each source file to include the
> > precompiled header? Looking at the gcc documentation it seems like the
> > precompiled header is only included where the original header is
> > included.
> 
> Answering my own question the precompiled header is included via "-include"
> on the commandline. This is necessary in the general case because a
> precompiled header cannot be used once the first C token is seen.
> 
> As an aside in git we could probably get away without using "-include"
> because if we include "git-compat-util.h" it is always the first thing we
> do, or we inculde another file like "builtin.h" which immediately includes
> "git-compat-util.h" and so it is included before the first C token is seen.

I couldn't find this in the GCC docs, but Make's documentation states
that "you cannot include a precompiled header from inside another
header." [1]

The strace of compiling a 'builtin/*.c' source file seems to confirm
it, the compiler (gcc-12) does look for 'builtin.h.gch', but doesn't
look for 'git-compat-util.h.gch':

  592662 newfstatat(AT_FDCWD, "builtin/builtin.h.gch", 0x7fff2066e610, 0) = -1 ENOENT (No such file or directory)
  592662 openat(AT_FDCWD, "builtin/builtin.h", O_RDONLY|O_NOCTTY) = -1 ENOENT (No such file or directory)
  592662 newfstatat(AT_FDCWD, "./builtin.h.gch", 0x7fff2066e610, 0) = -1 ENOENT (No such file or directory)
  592662 openat(AT_FDCWD, "./builtin.h", O_RDONLY|O_NOCTTY) = 4
  592662 newfstatat(4, "", {st_mode=S_IFREG|0664, st_size=17968, ...}, AT_EMPTY_PATH) = 0
  592662 read(4, "#ifndef BUILTIN_H\n#define BUILTI"..., 17968) = 17968
  592662 close(4)                         = 0
  592662 openat(AT_FDCWD, "./git-compat-util.h", O_RDONLY|O_NOCTTY) = 4


[1] Second bullet point at:
    https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

