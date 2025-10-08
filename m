Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0380189
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960188; cv=none; b=mHJ8yg3BTES1b0KCJE16fRjKUm1p6MYtcFVu+9wTlA5UGeGFLEn4ju6uO3Xzb3OdLlO6QT2xA/heNB/j33XxBQDW6gYG8EJxb2jVJt9VS/4IbznmGqNRMNaGYBsfCdtf0kI5AsFwBo6E6sM3SAZAxNQC2HL2GvBXW1IZwkteh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960188; c=relaxed/simple;
	bh=nBgD1yTqcp1T+mafQgAUfg9//0cnY5gR8l1Mbkonzjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUogJGcj8/XAhT9U1VZIi4g9Ua6Xtk2waTeFtOQtqShF6yPpeJwvsfszGKDS1IsQOk0oIVHCpYskMNVLDuLXQ7PRhzAzzLUbvAUDWX21WGqISF6Dsh//3aEr6va658pEyKm3iuCTrK/XaQscHzwbHO+MQxy2X3zfe6aXKWx3U2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BWSwph4V; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BWSwph4V"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9032edd72c1so28328939f.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759960186; x=1760564986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMKfi49rqPeH2vme640HmzmsrM70380kao3M09abU50=;
        b=BWSwph4VQcpcq6chyMN05C/GT1w+2qIma8gfKMr9+UdHymUaQBl0SVF0St7RGWczDg
         2LQUEVxxgnXOp36hi2sX048v9zniGayOsyQgOWn6xAgH63fQOMnTGy61ThVKwTyeejQa
         KaLUl6/O78uW/UTx2gvUTBnWeiT6SiEcplTzUbT0cQZ7pOG94035hEjrUN7ZbvYJ175n
         y8IAvZi24UGCgRQlR1JHcNYS2++kQ+FezAWy6oqAxyizkzw2459/BYm2cGXvNCGnEnup
         hSezNGNX04KoQ5j9a1A0vgXFCL+F+Bqc5fQ6qZGNPm5UQqxWrDIvUYKPKphy8PzgijzE
         LMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960186; x=1760564986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMKfi49rqPeH2vme640HmzmsrM70380kao3M09abU50=;
        b=WWQb7cuHU7CvT8uXjab95SRPN+gVvZa8Dac9cJaFlhw9wr8oM3pyBJV9RrRjkOZSA1
         RhoI6+HtLtoIAN7M8vz8W2h0Ax3exth3ivuaegr3e3+OcruG590ANX32wF858OcA3V5D
         4hwmVzkhAbmOh2jAhjpSJVkGVIa+ichvmGGm+KN/WNVCAV/eW+88itkP+l0zOLJmcWRj
         39D9gK9PWbn4aQ6YDEnymS4o41KmHIZOCCM7h6TurYBC2vs2OQvXT4eA3RpMXkbhp9dZ
         HQf9sqJLDLh4RXtYkGuKbStpppFd/zR1WbjIE2vwuiVdlDprUiUGtCqAC3ug8OVANH/v
         RCJg==
X-Gm-Message-State: AOJu0Yw29nArgKNMyG9yl/TPuokCjD+tLicvw3QwiNeeFfP0Ccmqekbi
	NirzjxsRjbl7WmIWocfm/C6pzlDmNAMXMEicUbqQhWLQRUUCplCn+xWhsSmZpr4KzIiZgVuXBCh
	ASWMXxQ1zpQ==
X-Gm-Gg: ASbGncsHgETI4NVGA+4t/lA4PQfcDW31msY0qLWg41gtgLafpn6ldHMhk9fk9XT6Ije
	iFcMg+zhQ1/Bi9msSK98jiYGJb6YsRonNx9auzAJe6nUZxAojYZhHlLgC86NUCwJIBlG5BnxwdS
	RPr3QgCZQsgJVrsVGWH0qPE4UtfuHdvMZg3lTDvPicqPudjqpwFIIcBuhhu8Ssipb9FL8cRsMGq
	DauqRMn8Hwe31m9Vg7JQU00Z38TxxsoPiFgWnTYrrZmQpqGhZ/c/nNs5DEW0lLwQMzHkVBhTWd4
	ks1Zzf2Ve9o4LgTQKp7cFDXNNUHjS0dLfC2hIYbi9Nr7gPALrttNyGp/GfNWSgEV99VLPYLoU5T
	+pXr5KmO7AZgQ6pR4/HWIWUzppXlOCg3MRtlF75sbe8uY5r4UokOiEz36DTuHp/9HDv+zzvW7+p
	Dsu5zxoZkBGlzaOqFmL4ze/fkMwXS8HKV/3G8a3RwzTNf27k290g==
X-Google-Smtp-Source: AGHT+IFnSKesp2uxwOx1zBN6EN1nwBfrJ/DcLLX13iTXNhbZufwXD2xjaWZNjN9uOSTiDIs57hgo5Q==
X-Received: by 2002:a05:6602:2b82:b0:927:3f:411c with SMTP id ca18e2360f4ac-93bd16b5a83mr612764339f.0.1759960185680;
        Wed, 08 Oct 2025 14:49:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ea70054sm7360008173.31.2025.10.08.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:49:45 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:49:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [RCF] Secure git against involuntary arb. code execution without
 feature loss
Message-ID: <aObceC/Ec/TGTEnv@nand.local>
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
 <aObX4C7lMHRnjbYq@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aObX4C7lMHRnjbYq@nand.local>

On Wed, Oct 08, 2025 at 05:30:08PM -0400, Taylor Blau wrote:
> On Wed, Oct 08, 2025 at 11:02:03PM +0200, Michael Lohmann wrote:
> > * Proposed solution (keeping all existing features):
> > - On first use, git generates a secret "token" (e.g. a random string in
> >   ~/.gitsecret)
> > - On calling `git init` or `git clone`, the secret is copied into the
> >   new .git directory and serves as proof that this clone was created by
> >   this user
>
> Sure, but the problem is not with direct clones (at least, not using the
> --local optimization), but with clones that recursively clone other
> submodules.

This is a think-o. I meant to ask whether or not we would respect the
token from the top-most $GIT_DIR in nested bare repositories. I imagine
we would not (otherwise this proposal would not provide any additional
security guarantees), and so...

> > - Editors would no longer need to prompt the user for "Do you trust this
> >   repository?" in most cases, because git could prove the clone is user
> >   generated.
>
> If the above is true (that Git would not copy the token into recursively
> cloned submodules), then I admit to struggling a bit to see how this
> proposal would remove the need to consult the user in this case. Instead
> of the editor doing it, the user would need to do it themselves?

The rest is the same as before (swapping submodules for nested bare
repositories).

Thanks,
Taylor
