Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EC524AF
	for <git@vger.kernel.org>; Fri, 17 May 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951332; cv=none; b=Vd2/8LsYVPJWwA/jMGfY57XNqUtBbKhKjiE2fjGNXqJ/yvsWuQlKriCoW1Kn0kaKw9ikVgysQI5kz7SI0CdUEckUPR1+kQjsUTstfIQW2fP3nTZrzOjIK8+wek7IvWZlAPtaI3pml8Z2HOyihhb+RTqd3fvwTScoI8WcTrH69dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951332; c=relaxed/simple;
	bh=hp8fWV9Ewj9hWOZl94raG1VkfrEldnbpmtUbMMXFYp4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mV1JkUM97H4ZI6VhjBoAZMf6djNeFOnJlbTh4EH+jSprpnQxlCJ10FRRXBfzuuuOUn5ClVyo/HxqKdiaFnHDBpiBru9w5MTbGnZeBkwnVJbNhbmSB/WGFE+TDNBcDLUBNcj40YX57uIcyKFuBJApimp8woasa0K0CibvLQIybaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=l+XUZImh; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="l+XUZImh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715951322; x=1716556122;
	i=johannes.schindelin@gmx.de;
	bh=bxtBIVsIrusglN/Iw7jpNkpi4sxbtoewD8MEsq8XoK4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l+XUZImhR+1vAvtrNtha5aIg78aytFdfY82i6hIKAFViBT2EH6bsQBRWyBCiWAwS
	 jxfWoI/O7eHNdRJZECC63gtEyOalnY2dwx0KfNZxII+CUogX+s8a/Pk/GWrqGa3pN
	 77M1CpZ4XdXudQKUtNgkmlp8MEMIMbWcsTfVLBZ80EwpTsngqeUnkBxDoVkeNcyxb
	 myegADiXA2o7vA7Ej6aAEq4oO0XZEmcNVRm630PPa4WphfkhedmkEjF0Lw5kjiQhs
	 iZ5RzwWzRIIdb4ECxZrSORIZz4YN/khBrSCpktda0agF2oJvUUlqVlX9fggUxcgkr
	 oA36RgpJ+sKIDCZX0w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1rrwbj3WG2-00JHQF; Fri, 17
 May 2024 15:08:41 +0200
Date: Fri, 17 May 2024 15:08:40 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Brooke Kuhlmann <brooke@alchemists.io>, git@vger.kernel.org
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
In-Reply-To: <xmqq4jaxvm8z.fsf@gitster.g>
Message-ID: <6c5160b3-e5b3-996c-bdfa-90c0a38ba19a@gmx.de>
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io> <5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de> <xmqq4jaxvm8z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UoprwgsPVSlDNZO3IR2+TYemi4QSaKq0C8WkyK90hENzmi6Ovb8
 ZETXAVHAw/Lr/USkM91F/ZvGjBacuCdcIigyDm9RT9/u7iudoL34Y03tQ9tpvDnJ1JWLdTz
 ANJHu6x8MT71NG01BWu5lyHHOhm/P6IxjiGFFQq8LdFIDrJzEk8uCAwSV9O6WOe20zzMUjP
 Z3c2Tj5oceQkAkH9tMtaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+8uLMnDlo8Y=;H9E3SjVWQ8oAq9c6pmAlQUstdxu
 CNSdlzLCmkvE7ApWYIdSuq4tmY/kdxBubWq0Q+2PzhwlunWSvJE0hV0BCJoWZpBxIAi4ri1Uw
 ZCuW04qfoasSa+C/mzbJGgm+xwfRgyk96X+THZAJ2YLh6r2keLr0V1nR4kD4WeiXWr89tfZL7
 KxdCbmhxgrT+puWPc7JKKFBV/lbHyaPaCgK8HoGMSQI4T9RrxNBxpXLfvlL18SnIFX8aeHW6L
 WXuE3r5EYzd98ujktpAUyAqT7Zxk5Bgz8cRAw1FXVQfa6+wODCQyKjLaTMEgHJ6bzk6s64Rim
 27TYKCxuMyjgf1BX+4kCvhFdBYxqTZIzVn2RqcEpFhoe0p6zCZ7u5UUpQDwQrO/YPFwLDrOsG
 Jy1gSXoblGvcoI+/6MVC/DS2nHDzanBGsZ8H+mtOxLCHTh3FlPFH6YYSnK/UU9vzifkCIDP8r
 N55Unl/CZij0/ajW7qbRNHo9gw/Ti7XVdWCngUFupCYcBhaiONZIDu4j6t75awLXZed87S3Br
 0Efh0IblkBGOTsD0Hk2RaWbLrWfoe12rYqukE/cW1oUGlMuCaXV5B4rBH2eBxCH9veC9181h7
 hNyRFQgHx8f7QSpDrCbREPHdqsRLLRt7UBkq7+ueugi3RJEjc0gfFPkHNQcHlUGA73EONXT/T
 3G38+l0Rki9b009x113s8OpufdpUrcVjqbsjOky7KunDhT9zG2DbEI7lcILTQ/SJc/QlI6h5j
 qbRj3ImgaSu5wu7yfGQUp6WXZWm27O1pGUkYkzE2w2bSLUznphNJJ/dlsjjSurlgDi9X879/j
 VvG0p9aIDfemah4uLHkKappxdnko0HWok2LU5uw1CL7qo=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 16 May 2024, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I plan on sending out a patch series later either today or tomorrow to
> > address a couple of regressions introduced by v2.45.1, and this patch
> > would address your specific scenario:
> >
> > -- snip --
> > diff --git a/config.c b/config.c
> > index 85b37f2ee09..380f7777a6e 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1527,6 +1527,7 @@ static int git_default_core_config(const char *v=
ar, const char *value, void *cb)
> >
> >  	if (!strcmp(var, "core.hookspath")) {
> >  		if (current_config_scope() =3D=3D CONFIG_SCOPE_LOCAL &&
> > +		    (!value || (*value && strcmp(value, "/dev/null"))) &&
> >  		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
> >  			die(_("active `core.hooksPath` found in the local "
> >  			      "repository config:\n\t%s\nFor security "
>
> This does not make much sense to me.  Why is /dev/null so special,
> compared to say /etc/passwd?
>
> I do think the defence-in-depth aspect of the other half of what
> went into 2.45.1 and friends, around the "hooks" theme has merit,
> i.e. "any activated hooks in the resulting $GIT_DIR/hooks/ directory
> that is different from what came from the templates directory is
> suspicious".  It has a plausible attack scenario to realize such a
> suspicious configuration by using directory name munging and other
> tricks to confuse "git clone" into thinking what the repository sent
> as a part of its payload belongs to $GIT_DIR/.  It did have fallout
> as the way "git lfs" mucked with user repository's metadata by
> abusing the overly wide trust the user gave to its smudge filter [*]
> crashed directly with the reasoning behind the "hooks must match
> template" protection, which is "Until the clone finishes and gives
> control back to the end user, external influence like hooks must not
> muck with the contents checked out without user's knowledge and
> consent before the user has a chance to inspect the resulting
> repository".  And it is a reasonable expectation to have when
> cloning a repository that has not proven to be trustworthy.  So
> instead of throwing the protection with bathwater, we should add a
> reasonable (i.e. easy to use for "git lfs" developers to follow)
> escape hatch that is a bit more nuanced than "rip out the whole
> protection" revert or "disable all of the GIT_CLONE_PROTECTION
> mechanisms" escape hatch 2.45.1 and friends had.
>
> But I cannot quite tell what the threat model this "core.hookspath"
> one is trying to protect against.

My thinking was this: if, for whatever reason, it is possible for a `git
clone` to write to the Git directory during a clone (and I had those
submodules and recursive clones in mind, in particular), then an attacker
can not only manipulate Git into writing into the `hooks/` directory, but
they can also reroute `core.hooksPath`. And if we ignore the latter, the
former protections can be side-stepped rather easily.

> If some attacker manages to muck with the configuration file, it is
> already game over, and they have better ways than pointing your
> hookspath to other places to take advantage of their ability to write to
> your configuration file to attack you.

Hmm. You have a good point there. The aforementioned `smudge` filter would
be a prime target.

> So, my recommendation for this one is to just rip the whole new
> logic added in 2.45.1 and friends out of the "core.hookspath"
> handling.

I guess that's the easier path for now.

We should seriously think about better ways to protect against config
manipulations during clone operations, though. In particular with the
current state of the submodule support code, recursive clones continue to
seem like highly likely target for attackers.

Ciao,
Johannes

> [Footnote]
>
>  * The user most likely consented only to allow the smudge filter to
>    transform small token recorded in the object store into a large
>    blob taken from elsewhere, which means it can read from the
>    object store and write to the working tree, but the user may not
>    necessarily agreed to give it full read/write/delete/create
>    control over anything in $GIT_dir/ or in the configuration files.
>
