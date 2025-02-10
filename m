Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D296A2580D8
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205826; cv=none; b=CjZe5+Whf0xCLIrkLNj8woGfVaOS9qCMQQK/zB7A19JfSqEqsMj4vCjQwV6JT4IrbVGWuzzamOzaONRKXSdFPV5nAFZL0YQxbt35G7MdWoi3poJeVFmKJvXjUo2Rg4Oj7l7m+RDwPMjQohVatDCYcE/G2SqRDB3fxpjsMYKFifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205826; c=relaxed/simple;
	bh=XFCQr1cY7TdAJFTK8c9+ZuO+fYv7b2axZDIP272GmYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWBqWAwm5DHDlqfZfOYSxQw+Id1jmmH9N9Na07rEqjl7HJXA2HlwQ7kFoyrGgjne2mKbg1EtK+MplCRLcEoAS9XwIXr2NqUVdH6zj0PQ2gmto+mkEKXeIGcdpS9Ob9fOJPIbSDKHjZTMb0rW7xxkQPa4nWdyrGymY6RQ60kWoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=VHlT8Pp3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="VHlT8Pp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739205816; x=1739810616; i=ps.report@gmx.net;
	bh=fFdwwfIUz98jUWD0F/wrDXytrIT2An0+ghKLz1AFwJU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VHlT8Pp3UdE6R+FECX9nyTlrY5kr539flAnxeIV4wSqMrqnju5q2HCG3zWlfRRZI
	 DvjpsgWrYGgRNa5KftifoD2fZmP4qZ1q5RBYANN2/+r3C2krh9yhyBduh2fJgUZgo
	 /4SZJkj7gl4ZgZGMCbZMzPHh+4XRLpZVGiH9AUs1wa7trBUETZaGt1QEa8RdUtcOE
	 lbWBQNlcdVC/7DVjCYj/R7R9apK26o7G01Zi5GtM4stNvqC0lfZxZnYq+g5Cno3fw
	 aoRG1juwajo7GbzRKjfEFfxJrEUGcoDn7RtYGCnRSeplWKQl+aE2LLSz+r0KaUWUO
	 Gf+OA8KkcH0b4MHcUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Rm-1txXKY1lq2-00TXjN; Mon, 10
 Feb 2025 17:43:36 +0100
Date: Mon, 10 Feb 2025 17:43:35 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <20250210174335.6d6d2af2@gmx.net>
In-Reply-To: <xmqqlduddb8b.fsf@gitster.g>
References: <20250209133027.64a865aa@gmx.net>
	<Z6mtnmvKMsIOEVz5@pks.im>
	<xmqqlduddb8b.fsf@gitster.g>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I5Rm8aMdU8GsylDrEJvWgEMGWylwuYdCcEYY3JovEWnemXUzn8h
 gXbuB8M98q1qO0GqAwxKMpHoYjQJJgarJEtnunq4dRsbCLgfHn4Xyp0hUN881IOuDYdBCM1
 SnNT3z5sjB0rXLK+sbOEhQJ3a5C8iu1mQbtXFCO88yd279svqGIAGMZBZd5/X258v4fWmoB
 HGCTYPtn96eo14qnvoRmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MISOtL0dA3I=;ohCKtWmRQvh6VM2Xx562XB9G+/p
 o1nCAMfgrFM06s0MbFDcaa8dPm8nG9q3JmQ6pn+bnkwVxmrhlMV0gOFJL+uj01rSfoMp5WSLH
 1lbjUhN1EuZzgApF2h5pBrFexkEBUHB9WaCuD+P0v/ouv6QCJKW1WGrYyWHbZy+gk3z5hqhar
 nF5EEZcNzw5YTNZbIGclx+vcORjPuDWF/rpLCQHKJiv52/rAlu5pVq8IOr0zGGv8xsODZki76
 Uxx/FcTag17/bfgw1U0HGgaw/zfA4zCCHlDEQ7oGwczX5j+yrvr6iWIYawURtfLLarwpy1oWZ
 B1FIFnkb14tZmyxxrtzvcVQKJ9W4z7AnNLMuXHIKfpwmqcaGWkxdJ8LZgtL2zuCQ616rsO5UL
 CeuwXLH9tC9Wfb5NV7fAVynEHtxTHxQ6OICxXipWm4yhTLCIVCu0PIJ+RKE6WkPaBKU/NMr14
 ncP+Vm26nNnpWrvovKmg+lQ5zb2nnykl0DSLnKvg/K0HUw3kR88fql/LO0EyJfnjgNwvJkbWM
 DZaM7RQOUiD7TJVKyx0pGx5Jm4EBfzpIWj/rxWCfyS5BzYY3AA+h++/TQxcJf5lGfxHilr0na
 fwmc9HGDbVr9jWnDdvm2QsNOmHstyujL+UN29AwARLETzmOqeSr0NYaB7gKfnVMtNS7N5A9oP
 uN2FftC389NkI1Yzxbzr1W3UjSMRSM/uJAccwMxBac1gB3MYa3lOhnWgjXeFIEZaqO4Qs9n76
 /RDGPbyuQuHg5EwpPjOgJThF9MogbOuBekkzAja4Bm7vsx/ITiIsVXurJT6fJMB3F+s7wVqgo
 pzuyM5Q9KWjizFT2JjhGSgXzZIlBuiQ6Wc3uvM4hsbikOuBxcfJtKHSmCIRX2tMt92aBfQM/p
 +WbnfxSyMNgDrabhhvOD3yVeqMbxpN5cWiLZwAw7w9Bh1EAYWTRlP/GxH47/0+FpaLTNTipMq
 BqCslO0ZVzdFMy2KbSa+1a7zHEzY9o2R9oTbquPtmODEEFoj+W3fnEPa0ZcfeH85mHH2uB3LX
 km0ZYmkvIf70M9JbZXgYAYlz6OljiJi5RHnMTo+DdWYtQa7A4fvDad38VkM0HouM8s52tuCuc
 7NrgX59JdOJ/K+Bm0cJHO03Q04xlkhOxZ/z9XAGoE9hWMi7AOrg1cazBhOqgX2O6e/fwviZmF
 jgY8LiA+Dl/5ma+Cqk7j3+SN2Q4w0ZGvK7Hy+F58udZfRieuQ4NmK8F69dTFvZOsjmj1Lce7D
 2PC/KSZL7uWwg12Y0HaRwqEQ388Ya5caqRPY7tc6N5eAIIFon+d1YAryda/US6B7Wh5OQTu4i
 G9UCumFingpWKGrDLy/uB+4pk4yaGne/Km4GQEsKBkRE5kCiS8fbT2UZ9j2BvBVhkG08lQnbk
 wjE7dWvkGMppas/MlkkaTCioKsda/DVsbPyBu6RiBbObasbsH7O6bSrSlU

Hello Junio,

On Mon, 10 Feb 2025 08:18:44 -0800, Junio C Hamano <gitster@pobox.com> wro=
te:

> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
> > [snip]
> >>   The meson build tries to execute the non-existent '/usr/bin/sh' (in=
stead of
> >>   '/bin/sh' as the autoconf build), 'which sh' on the host returns
> >>   '/usr/bin/sh'...
> >>
> >>   From meson.build
> >>
> >>    [...]
> >>    186 shell =3D find_program('sh', dirs: program_path)
> >>    [...]
> >>    685   '-DSHELL_PATH=3D"' + fs.as_posix(shell.full_path()) + '"',
> >>
> >>   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH=
=3D'
> >>   (at least not for cross-compile), use fix '/bin/sh' instead or make=
 it
> >>   configurable via a meson option?
> >
> > Hm, very true. We're mixing up concerns here by treating the build
> > environment and the target environment the same.
> > ...
> > The patch should look somewhat like the attached patch, but it conflic=
ts
> > with my in-flight patch series at [1]. I'll wait for that series to be
> > merged to `next` before sending out the fix.
>
> Interesting.  When we did our make-based build, we never seriously
> considered cross building into a platform where the path to the
> basic tools differed between the host and target hosts.  At least in
> our build procedure in olden times, I think we used to assume that
> what we just built can be run inside the build procedure on the host
> platform even outside the tests, which would make cross building
> impossible.
>
> Now, since we are "fixing" this aspect of the build for meson-based
> build, should we also make the same fix for make-based build as well?
>
> I'd have to say that I prefer to see it done out of pure principle
> (i.e. we earlier declared that meson is not yet replacing make, so
> adding new shinies only to meson-world is like making the make-world
> bitrot as if we do not care).
>
> But on the other hand, nobody complained that they cannot cross
> build with make-based build seriously enough to cause us consider
> doing something about it for the past 20 years, so the pragmast in
> me tells me that it is not worth it doing it in make-based build.

Maybe all doing (autoconf) cross builds where happy with the defaults
from the Makefile (SHELL_PATH =3D /bin/sh, PERL_PATH =3D /usr/bin/perl)
on host and target (as the buildroot autoconf package since 2013) and
only users doing native builds fiddled around with non-default values?

Regards,
Peter

>
> > Thanks for your report!
>
> Yup, thanks.

