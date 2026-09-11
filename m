Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC032E128
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137798; cv=none; b=Gn/xslLgS0sT5sanRyzhfKFU/NHLdibCIyqW+bgbCCa3iAd+lQsr7dAehLf9d+QEv6/kMWyIOg0LjCuqFP8gb+85TVJVb2+huEs9XQgA2ZsVi66cwmxfAZNbi/Gs+5o7BI1h9uo14MK7wmP93rEcHxgoGjLkTT+lXnSfMbnsBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137798; c=relaxed/simple;
	bh=DbbMfEIxjxgoE2W3GI3ScY+bQVb/GWt0h30xDEULsOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECUHrThBxKXX67EUR/CClHmDPmEU6TpSU6TCL+k3VDhK32EZ8tqV9dxxB9XYlFkCefpQdEFG+qzuwbQwifYMdygSbqOG5AoXMUb3SnWDxG0Q7z8zYVRjveaUn3bZSX06cAbVRI02Mx3B1eycSQY7fQOvYhm6RvVq7g1dw1cQpCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HBZe+10L; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HBZe+10L"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4843e9c5960so924065f8f.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137791; x=1789742591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DbbMfEIxjxgoE2W3GI3ScY+bQVb/GWt0h30xDEULsOA=;
        b=HBZe+10LNrYOk33G1G8RXKXBxci0IxOMNZNTgfu9wyyH+v5LeNlzggHoRsM3DMTEsB
         BH78sgY1973UyXHqXl01xOo+EbKdoJgS5xmRzzIWgaE6KjzZH1ZW44i3QCEK2PGe0qWF
         xpJ6JLWZYNSilm0n4+eM57FY4Y9bvVlg+G/e7iDA8B+Ne4TTiqQtA6j3bGuAEm3G0AY+
         KqhWwD5IYxg9mTjLILSTaJAqzJBBzv1wI+6xJc8srXOzqk/kEHs3pl2MGBclrWnUeNy2
         svojFHsLfhuBxQggkDxUJs/1OwRQ30UZnFCLMdZkSpM+oTlFb0dgUBCmjHCd9nYSGj/j
         M48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137791; x=1789742591;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbbMfEIxjxgoE2W3GI3ScY+bQVb/GWt0h30xDEULsOA=;
        b=m1oL1mX2yJjAzrSwPDvedJHtSV/xwFFI7G+52RLxlHu56DqfjUnG7NnZK8zzdxWFV1
         DXx2ZxI7SxBHfTiIVi1WhmS4ymFZ/bk6aEmTANK5DfeEJORbdt2PrZksD3SpaIWOO/47
         44BY5AX+6zB2H39U6bv3iKYzSZRq6elfoLtQ7y/28qiZ+wpOwSLv89GK0tT9jmlWMIP6
         qGd6R7aJpO/11Paxw9DkfAB/o8U52OWmdFi6vz1PEObWy+eT59bJCljfU77fwQFtf/uW
         WH5x351OLwa6ZWh+q8DOyDrk2D7CDfkedWU7C9htRxsNUqKZkaqBtHYY0cw7BrTYps2C
         8UBg==
X-Gm-Message-State: AFuF++nVSShCjzVkjJAV+j6JLkRSdsCMOmEhHJdoASFlwlvUqw9dcShe
	XbrNR82sPtTi/lcTk5aurRpuVva8IQbtwdfeiRFMKofCBo5QPjRcOixOkV3zmbsDLTM=
X-Gm-Gg: AYBFou3wKykBaNt2XogQvnRIaQ+4qvfZcpKSSXFrpyWD2ArZp+nbYyjCA1SSr6IdA/q
	nIUrk55LgU1dxwHscBh9UMRcVIUnGghTfYx60pzR8dK5M9R3cTHaFHQ0Wkqd3Lo7mQ5A6hKAyJP
	Yi+YGGd3MSCRsrghwdlvK6kgeZv76aIF+Mb+wXLIK2Z+bJcMwMfFikir0Oh0qfSnExDazdF7yO6
	YZb3n+NQNTwJqK8x0j2I1/Et+Rm8fDKHrxLq7MRNMWhRpil0opfYBD8mB8DM4Kp4gpt72s63R2y
	TzSYwlp+WpkXGUTrAveorYHrMItIEOELHWfTCjtCxbnyKNYXtNRetFIrfRZ86uANoQRk7vIPw3M
	Yb06ZoioiA1MEwl7bd9mziI2V+8x5hpVPmUT8fwrT813xO04L8gZrtcT9fH3ULPJeMNzdb82zgo
	wtQdm6Hkb1F1hUn25LIJL4FA2bqm6t4YjsfFrL3eymE21R8z7qaH/yVmhthjgFC5xhwYi0notLg
	w==
X-Received: by 2002:a05:6000:310d:b0:486:ecc3:2d1a with SMTP id ffacd0b85a97d-486ecc32dc6mr5483722f8f.31.1789137790933;
        Fri, 11 Sep 2026 07:43:10 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34fdd2sm6516806f8f.28.2026.09.11.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:43:10 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:43:08 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, 
	Elijah Newren <newren@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] merge-ll: Cleanup merge driver temporaries after
 interrupt
Message-ID: <aqQN_Q6ZAeyTy7WA@localhost.localdomain>
References: <20260910150608.1867930-1-mkoutny@suse.com>
 <20260910162242.GC251185@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="klmsas5leu6xfcne"
Content-Disposition: inline
In-Reply-To: <20260910162242.GC251185@coredump.intra.peff.net>


--klmsas5leu6xfcne
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] merge-ll: Cleanup merge driver temporaries after
 interrupt
MIME-Version: 1.0

Hi.

On Thu, Sep 10, 2026 at 12:22:42PM -0400, Jeff King <peff@peff.net> wrote:
> We have a temporary-file cleanup handler that we install already, which
> handles signal propagation, atomicity, etc. It seems like it would be
> simpler to just use that.

That sounds like even a better idiom to achieve the goal.

>=20
> In the worst case we can just call register_tempfile() on each path, but
> I think this code could be taught to use the actual creation. Something
> like the patch below (only lightly tested).

I've tested it and it works (cleans up both after SIGINT and regular
termination).

(There's only a warning about constness, one should not change the
tempfile's path buffer. But here the ovewrite happens only if there were
trialing dirseps, which they aren't as the filename is under control.)

Do you want me to send your variant as v2 or will you?

Thanks,
Michal

--klmsas5leu6xfcne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaqQTeRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhMfgD/Yi/+B5NzmEECL82M+84M
YnYxVqH9Dkj2cRRqrnBZ3H8BAImMJ4Xw6lz8VMp8o73gHEht2bS5P0Jj/dt7gvEB
n2sO
=zrWf
-----END PGP SIGNATURE-----

--klmsas5leu6xfcne--
