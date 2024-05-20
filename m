Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A47E552
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716223733; cv=none; b=V4hoqtopOefe1rVkA/yaJMAE5DZmFm6KntQKhlbTFgTBU0YEUbMpGCu22fzRadcrw0B4jlRwApVVc7fWuYq+l2ldIxdL+Enn/FOkc9WCBw00qNOrPrpJ3ssbTpf0mpYnqpL0UquREsHNtdudwLlONL1cPxyc43LfAGAJlY22vrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716223733; c=relaxed/simple;
	bh=0LCUwEyWIi3C/rfjB3pizOTa2cX1xj5X3Ap0nRJmwn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thA2u7/s/qsPv1tibp4u11FILSft0gaPSZ3+QeXYBiM8ExjtKqC/0oB6WQ60IaSBORwaS2mMdgK3DMRm0wey7UkKZuqrViyY2qvlRHwinh/puov73s+Xcn4bs+A3yUX0Is8k6tOy/a01eUiJKlL/EBkz7jV+EBGTAIlHV8qXOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=HZhY6bH5; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="HZhY6bH5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h+CDZXhd7pACImCudg/PZZAMx8y4fXoH0nPDeENrXG0=; t=1716223730; x=1716828530; 
	b=HZhY6bH5OID2+lsmzcBLk0aoXXc+PAtSQjOpE+pmktSCs9VEduj9f/k1h7Y4Y3L+GpsKtk8vVVP
	nrmV3D5U5urJKyHQFRVWEsasAUQGyXZTSJ26268yKwfnH68thKBU1mXb9E6G1QpAOn6zn9lKhVDjS
	TsIPOczXgq9B4L7+gs480s8Kh1uYRDKJpqDTSqJOdcqq6jmQaFMFzKMjxzN3+4yyK3P9BmnWpLYzj
	LJ5f1IkWdcYddlYkt1TQG/9uJcRx7HPPhHcAmv9itInqttZB7u1lqMHA5bSRU9cfxJNalTEMsBngv
	R8aTHXGUeD91ystGBSVv45yKHXdwSSiioy6A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s96Bp-00000001Jcy-04w6; Mon, 20 May 2024 18:48:45 +0200
Received: from p57bd9a40.dip0.t-ipconnect.de ([87.189.154.64] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s96Bo-000000029tb-3O4Z; Mon, 20 May 2024 18:48:44 +0200
Message-ID: <503a99f3511559722a3eeef15d31027dfe617fa1.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] chainlint.pl: Extend regexp pattern for /proc/cpuinfo
 on Linux SPARC
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, Sam James
	 <sam@gentoo.org>, Andreas Larsson <andreas@gaisler.com>
Date: Mon, 20 May 2024 18:48:44 +0200
In-Reply-To: <xmqqseyclaq8.fsf@gitster.g>
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
	 <xmqqseyclaq8.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Junio,

On Mon, 2024-05-20 at 09:16 -0700, Junio C Hamano wrote:
> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:
>=20
> > On SPARC systems running Linux, individual processors are denoted with
> > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:" so that
> > the current regexp in ncores() returns 0. Extend the regexp to match
> > lines with "CPUnn:" as well to properly detect the number of available
> > cores on these systems.
> >=20
> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > ---
> >  t/chainlint.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/t/chainlint.pl b/t/chainlint.pl
> > index 556ee91a15..63cac942ac 100755
> > --- a/t/chainlint.pl
> > +++ b/t/chainlint.pl
> > @@ -718,7 +718,7 @@ sub ncores {
> >  	# Windows
> >  	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS=
});
> >  	# Linux / MSYS2 / Cygwin / WSL
> > -	do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor[\s=
\d]*:/, <>)); } if -r '/proc/cpuinfo';
> > +	do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor[\s=
\d]*:||^CPU[\d]*:/, <>)); } if -r '/proc/cpuinfo';
>=20
> Is the doubled || intended?  Doesn't it introduce an empty pattern
> that slurps every single line of /proc/cpuinfo?

I'm not a Perl expert by any means, so I wasn't sure what the correct logic=
al OR
operator would be. If it turns out to be wrong, let's fix that.

> I was wondering if we want to first add the "reasonable fallback"
> Eric mentioned ealier, and then build on top, whose result may look
> like the attached.  You can enable the STDERR thing with your double
> "||" added back and see what "cd t && perl chainlint.pl" produces.
>=20
> Thanks.
>=20
> diff --git i/t/chainlint.pl w/t/chainlint.pl
> index 556ee91a15..775f06281b 100755
> --- i/t/chainlint.pl
> +++ w/t/chainlint.pl
> @@ -718,7 +718,13 @@ sub ncores {
>  	# Windows
>  	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS})=
;
>  	# Linux / MSYS2 / Cygwin / WSL
> -	do { local @ARGV=3D'/proc/cpuinfo'; return scalar(grep(/^processor[\s\d=
]*:/, <>)); } if -r '/proc/cpuinfo';
> +	do {
> +		local @ARGV=3D'/proc/cpuinfo';
> +		my @num =3D grep(/^processor[\s\d]*:|^CPU[\d]*:/, <>);
> +# print STDERR "FOUND <@num>\n";
> +		return 1 if (!@num);
> +		return scalar(@num);
> +	} if -r '/proc/cpuinfo';
>  	# macOS & BSD
>  	return qx/sysctl -n hw.ncpu/ if $^O =3D~ /(?:^darwin$|bsd)/;
>  	return 1;

This seems to work fine for me as well. If you post it as a patch, I'm more=
 than
happy to give it a Tested-By.

Btw, it would be great if this could be extended to support the output for =
the
Alpha architecture as well since the testsuite fails the same way [1]. The =
output
for /proc/cpuinfo looks like this [2]:

(alpha-chroot)root@p100:/# cat /proc/cpuinfo
cpu                     : Alpha
cpu model               : ev67
cpu variation           : 0
cpu revision            : 0
cpu serial number       : JA00000000
system type             : QEMU
system variation        : QEMU_v8.0.92
system revision         : 0
system serial number    : AY00000000
cycle frequency [Hz]    : 250000000
timer frequency [Hz]    : 250.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 2500.00
platform string         : AlphaServer QEMU user-mode VM
cpus detected           : 8
cpus active             : 4
cpu active mask         : 0000000000000095
L1 Icache               : n/a
L1 Dcache               : n/a
L2 cache                : n/a
L3 cache                : n/a

Thanks so much for helping with the fix!

Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=3Dgit&arch=3Dalpha&ver=
=3D1%3A2.45.1-1&stamp=3D1716194983&raw=3D0
> [2] https://lore.kernel.org/all/20230901204251.137307-4-richard.henderson=
@linaro.org/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
