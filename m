Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF4241103
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007802; cv=none; b=F7+cm/WgqKBAIbrum/lozdSnD9n6iSdKLHhajJOlx+2k8ywBiICL9OqjiF1NKBdmRW9uLYvM+kwbV1gNfOfzbPPZPNR87p+y1AtIJG97uc7H9BKqVz4svKFttGfAqKao3BUpinbZsVcrV8ghXGda6Qwtq+JDMxetV1U9KurPAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007802; c=relaxed/simple;
	bh=LyByWPiZI5eMjVnjPQdOCx6XM+BhtHq6av+TK9G5q/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glqsN3FigDwZpE8oLgKXmNbMMDIiz+//NxPxin7ehget7Ywuj2CVwIqW2CpDLRwigJBnkAQkWZk/3cBXDMdktdMfNi2P4v/AaY8HEIyi61wmPL4Vn56wDxQTtORyGfHDoFq9lwyctltqv+QjhqW7J80/xsqNzElc34sr2Wfaejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0g4knY4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0g4knY4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73a44512c8aso1267869a34.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 13:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752007799; x=1752612599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nV4AkV2wUrN/UwIvslPCLs6KtrBQ3y8eAxqHT5uMPA=;
        b=g0g4knY4BPpKk34yoVxSTTu21W8ulWg6nv+e18qLEaqyjPi15bkwGOB8FOf/p990+B
         dAL7rGhFHWR9zNhJnE7tYdyLtEW7m/X3eREydNQG3ugDPWJpvZez3vQawQ+3cArOa1uq
         WLCA9PaoOjcog/93TDCXi5S3WxdRRw+Fk11BL1XnJbmNFIHR4toluuNLDyCVWfzhFHCx
         3+6yLmOsQkajzO1FKVpsBrBAQSCyXa5DV4BF7McRKCmcYl8ox7/1cgXtsVflPm9mA150
         rCkK/pFY88Nb0Sq5HqnEcEMhVx9sJaTu+ykQ3WMZ1mHFWaBXzNa20ii54voCFo2xy85i
         fLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752007799; x=1752612599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nV4AkV2wUrN/UwIvslPCLs6KtrBQ3y8eAxqHT5uMPA=;
        b=DC2UA+WdlilT5kyHurzwDB1ykuZpbggndYcft6MV5yhu5J6SYjHB9079M8EOcUUdwn
         Bx0G8w6KCXaRTpbEnY8dtN0nE810bwBiUSDzvNMknoLu5trPc+BPsIjVxKLFZ/Sw8VeE
         n3d66Yveaa2rISEI0F8wkabg1ILyCpbmbH1UooqbLDgtouJ/9P1SyoG2Bx+BcnCpDcx6
         Igy/LsHzB5AbIdlOuSpyTqxXmQqA8Cv9V1hjE1iC5hJOq17Gn/j/IUJoF+RjlhCV3zW1
         bnxsfWnmVAgjESrW5hqMLbisJqaLOlwwHiOWFfxfKTKAgKN5xGl7QvwaotilppqcIrkl
         9jyA==
X-Gm-Message-State: AOJu0YzQ9qKkcAQv6orItwQa9s7uhuLGDznw9CMXIMEZ1AMs2a/6wE2z
	0Qv9TZnuAp+HaMFTQ4gggdu5TqtuZf/zE2ENRnjq2iYZzEBfbpNHiEpQ
X-Gm-Gg: ASbGncseCSnaX7qX60E1eDhjaqzGfyu48iYnMCL6T+wgsy0FNWrfdhVY2pL0tr30nFE
	5FC4cxSaj9rG5yAflybGxR1atx0yJPVEZ7pc0llYUCl9NUMfcBIABeaLJDYQjDkMbpz35STq2/r
	O4l7t26rIBS/fqzLcz8o5vRnooLJ7UDhKHmn2mc1irq49hVBTU7f/7tIkm4znikz4UWEqKSqbWv
	eo97cUFSlazCUDzpBdBlfY1MWUU3hmBiebO4/GiA4vMIXf8zqlh859aNIHYd0lsS3tLLmvJdCk/
	ROgz0elcAB5FZIDYCuS3LoUZTU/azk9IJmaVcX1vNZOpQPGlKqCtpX8=
X-Google-Smtp-Source: AGHT+IFaTobD8V/yCuoAOFwCj3unWJyDXg42F0TPZHtC2Li19MRbYIRwXVZc5eowoazxQkChCC6Iqg==
X-Received: by 2002:a05:6830:33e9:b0:72a:10ec:3542 with SMTP id 46e09a7af769-73ce6341f15mr31452a34.13.1752007799398;
        Tue, 08 Jul 2025 13:49:59 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73c9f7351cbsm2150360a34.7.2025.07.08.13.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:49:58 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:44:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	irecca.kun@gmail.com, Eli Schwartz <eschwartz@gentoo.org>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/8] meson: fix lookup of shell on MINGW64
Message-ID: <jrpk2ydgoc7o2yj5nyr73gvgfjkyjkyqkfunu7showh7uvfuoj@bqiwcidm6gbk>
References: <20250708-b4-pks-meson-cleanups-v2-0-94ac53cd4b95@pks.im>
 <20250708-b4-pks-meson-cleanups-v2-5-94ac53cd4b95@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-b4-pks-meson-cleanups-v2-5-94ac53cd4b95@pks.im>

On 25/07/08 09:57AM, Patrick Steinhardt wrote:
> In 4cba20fbdc6 (meson: prefer shell at "/bin/sh", 2025-04-25) we have
> addressed an issue where the shell path embedded into Git was looked up
> via PATH, which easily led to unportable shell paths other than the
> usual "/bin/sh" location. The fix was to simply add '/bin' to the search
> path explicitly, which made us prefer that directory over the PATH-based
> lookup.
> 
> This fix causes issues on MINGW64 though, which uses Windows-style
> paths. "/bin" is not an absolute Windows-style path, but Meson expects
> the directories to be absolute. This leads to the following error:
> 
>     meson.build:248:15: ERROR: Search directory /bin is not an absolute path.

Ok so the specifed `dirs` takes higher precedence over searching the
$PATH and appending `/bin` was how we ensured `/bin/sh` was checked
first. The problem is that for MINGW64, `/bin` is not a valid absolute
path and results in the above mention error.

> Fix this by instead searching for both '/bin/sh' and 'sh', which also
> causes us to prefer '/bin/sh' over a PATH-based lookup. Meson does
> accept that path alright on MINGW64, even though it's not an absolute
> Windows-style path, either.

To avoid this problem, we instead search for `/bin/sh` directly. By
specifying `/bin/sh` first, we maintain the same preference without
affecting MINGW64. Makes sense.

> Furthermore, this continues to work alright with cross-files, as well,
> in case one wants to explicitly override the shell path:
> 
>     $ meson setup build
>     ...
>       Runtime executable paths
>         perl       : /nix/store/gy10hw004rl2xfbfq41vnw0yb1w8rvbl-perl-5.40.0/bin/perl
>         python     : /nix/store/sd81bvmch7njdpwx3lkjslixcbj5mivz-python3-3.13.4/bin/python3
>         shell      : /bin/sh
> 
>     $ cat >cross.ini <<-EOF
>     [binaries]
>     sh = '/nix/store/94lg0shvsfc845zy8gnflvpqxxiyijbz-bash-interactive-5.2p37/bin/bash'
>     EOF
> 
>     $ meson setup build --cross-file=cross.ini --wipe
>     ...
>       Runtime executable paths
>         perl       : /nix/store/gy10hw004rl2xfbfq41vnw0yb1w8rvbl-perl-5.40.0/bin/perl
>         python     : /nix/store/sd81bvmch7njdpwx3lkjslixcbj5mivz-python3-3.13.4/bin/python3
>         shell      : /nix/store/94lg0shvsfc845zy8gnflvpqxxiyijbz-bash-interactive-5.2p37/bin/bash
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index 4f22d72641e..bef80b118a8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -245,7 +245,7 @@ time = find_program('time', dirs: program_path, required: get_option('benchmarks
>  # "/bin/sh" over a PATH-based lookup, which provides a working shell on most
>  # supported systems. This path is also the default shell path used by our
>  # Makefile. This lookup can be overridden via `program_path`.
> -target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)
> +target_shell = find_program('/bin/sh', 'sh', dirs: program_path, native: false)

Looks good!

-Justin
