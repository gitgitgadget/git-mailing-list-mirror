Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA82676EF
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739310143; cv=none; b=LPKac6zU6Qda3PkOlgf7I3aPTMTKmzNtRSQGzwLibAEU+cIoxV3azcEDw4MIJUcAyY1L2eR2nM3EmIM3siY7uTThRgwgmLmCypW9BEPlrnTqG1fRsf9luezJLw4lPwq+8zQji9Gl+BHDY+6udtJx8hmsgdBTvadJ8DSwd6fsUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739310143; c=relaxed/simple;
	bh=18pl0b5189N0pS83+irbJSuYEpi61VeUgEbcVmNO5C0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIX5uCiFxvzZ0flFsIjgPK6P1FV/q1Iv6LuGUfP/cD/zcmHnG/vnJPsXzm+DDOpznbxr31956pt4p/ILP+rIIQgpB4dQiKj2+04v4sfUWIyk7eBjD8KkQ01NXHy+AYNFtRU+eZOqM8kxxF4eDNhSMZELgkUxleLQkBnT5s3o08s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=d4THa4lw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="d4THa4lw"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3165367f8f.3
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739310139; x=1739914939; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g68laiMiGUIzxwENmB3GBsrWiWiiwnGCceKEhMITADs=;
        b=d4THa4lwNnRf1NnFMh6bHTAlIMfKVGZ/jQDRGP4LIntlhGOX+TlfDUBNou50tzM/Zv
         UIFyiwY20v97DqXmQUK3fmfk3APUNb1lgKoZKH0XzSlQtYwgAu7UvwYkyX+5BcyqYzf8
         YItqzbGrKKO35I6UNXJpT/yvthv5prOoEdXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739310139; x=1739914939;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g68laiMiGUIzxwENmB3GBsrWiWiiwnGCceKEhMITADs=;
        b=QIO0e+vthWosaih0kWgyc8QdSAt0gT2Fp0niNJLh9iIt/nTCYZQ6k6uaR+qfT2ouSW
         ho3p15UA+D754NbYZeZFK2YM4MvrcMn4RIpoUevEQ0YYB8R71EAbZofAnUY3Y56Vivia
         UHCGhXb9fkCx+QpveZ82TBv4UTzlT9vjoapkhMz/uhtW5TrjbK3hf2XbB3I4nZMk4LEJ
         BVAut0m6ydB+GA9WodLsANS9rRzaX69oBqdP9vJLLzBCXnC6bFtymx2jZMbf/LnrnTmg
         bZI9R3TIEzjQ1t/B4fdWYNcdf/OVuCdZZ1DC4amvsRWcbTk41qrzltEmzu6xIiu0lFIj
         1jig==
X-Gm-Message-State: AOJu0YzSHqJkkaNetb4xGCB2j4IniNfEq4aNw/Itp4ktsZRRmlfQhOgD
	4nD7Y82KF32980SFRkTFOGUdWzoLJVbeRzxmL4s8X56TiH4oBJVOvgEcsVwxZyQ=
X-Gm-Gg: ASbGncvl8pWjlclZ6K02GpV7JQ8LRXe/fXQ7Qyu2Y0JXngWnxnj4KfE7WUf542sWqYx
	0G2jFi/1U6Pk3VjB8y1pHghXj75eofdT7HjehYAqKluOWy7E59Fl6tf8GMGXcLPsT8df7buKVcA
	9xqDDFf/vv7vHAXe+i1i6ByO1vHQfIpuV+JwW8Al9U9j+XBZvui/aHRJkkKQORl4TifM2OGsxcu
	UthkqwsA7v7qlU8W+d3XgZks3RMcaesSm3qNUcf2Bpeh4eg3IxG55bSVZSPX3mj2rbnuhtsDjhu
	auttrjZDolMpIGSqdR1SMOo66P35d5r1TE4EmxQ5STR3G7JjeA==
X-Google-Smtp-Source: AGHT+IFgWUHlFmAykmuDrHGveyxZjGq17k4EdABhnzP0/2btGp8BiKS0fqxAXY0gZd0k01IK1e7vDA==
X-Received: by 2002:a05:6000:18a7:b0:38d:e3e2:27e5 with SMTP id ffacd0b85a97d-38dea25136fmr414968f8f.5.1739310139133;
        Tue, 11 Feb 2025 13:42:19 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38ddbfbb4ffsm7711732f8f.94.2025.02.11.13.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 13:42:17 -0800 (PST)
Message-ID: <c0e31c9b8da723f4a7bbcc6099ce7e3c00a92fb4.camel@intelfx.name>
Subject: Re: [PATCH 0/3] clean: add `config.exclude` and `--remove-excluded`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason
	 <avarab@gmail.com>
Date: Wed, 12 Feb 2025 01:42:15 +0400
In-Reply-To: <xmqq7c5wxjin.fsf@gitster.g>
References: <20250210191504.309661-1-intelfx@intelfx.name>
		<xmqqcyfoxr7o.fsf@gitster.g>
		<e7e0c581b4caab142989df174ee51e454e97dee1.camel@intelfx.name>
	 <xmqq7c5wxjin.fsf@gitster.g>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ETs7wQaqYuVqaD5xzttQ"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ETs7wQaqYuVqaD5xzttQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-11 at 13:24 -0800, Junio C Hamano wrote:
> Ivan Shapovalov <intelfx@intelfx.name> writes:
>=20
> > On 2025-02-11 at 10:37 -0800, Junio C Hamano wrote:
> > > Ivan Shapovalov <intelfx@intelfx.name> writes:
> > >=20
> > > > This series extends the concept of "excluded files" in `git clean` =
to
> > > > make it useful to protect "precious files" that might be present in=
 a
> > > > specific developer's working tree (see below).
> > >=20
> > > How does it interact with "git status"?
> >=20
> > In the same way as `git clean -e`, i.e., there is no interaction.
>=20
> That is dissapointing.  I was hoping that "git status -u" would list
> precious and ignored ones in two separate sections.

Do I need to implement those interactions in order for this patch set
to be considered viable?

>=20
> > There were no implications behind my usage of the word "precious".
>=20
> Then you should ;-)  We'd like to see us use the same language to
> refer to the same concept within this same project (and more
> importantly, avoid misleading people by calling two different things
> with the same phrase).

I did not intend to mislead anyone (as evident by the fact that I was
simply not aware of any preexisting connotations). I'd appreciate
suggestions for a replacement term.

--=20
Ivan Shapovalov / intelfx /

>=20
> > This email was part of the `perl contrib/contacts/git-contacts` output
> > for this patchset, as documented in Documentation/SubmittingPatches
> > and Documentation/MyFirstContribution.txt. Should I have not done that?
>=20
> No, as I said, I was curious if he is getting involved with the
> project back again behind the curtain.

--=-ETs7wQaqYuVqaD5xzttQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmerxDcVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dwDAP+we2qutLjmysvzNfAdjgRl9OvlDo
b5md410LLy6oJRijrP7OSjXjbUaNZHyCiwMhp6Fq8/TIhpC61Q3m5Fx1EiVnIgx8
KYICfyNhQ/R8yDC8pQuJHNu9GCsQcLhRryRFnzl9aQkeE5bjD4oRpx0XhU5SvUCB
EGcc0X+5nFkUC9mhRK2unldgYMaPUsmdd2Dmgmd0CqVcSfLCu9AeOu2dYzatNGw6
4WT0YcvHYV/W+SR0DHezMbsqXT02YTnsGg/qsVjrX3dx2M10kZLPUXh2+WL/Yrzl
YMJUOrsgv+QsGr6RQ0lyFJAFPUr40pQZcxX44m89ACk2xDBYLvLYMPji/OFkQGxt
/VcBmhCACc5ph5f0YbK1dDWaEiQGqY4TYow/OIf3psdk7c2SNi5xGveOf8Ep+nht
rEAMMudQuTnQ+1mqJ/6cCagxgbaTYyReyHRBKSHdXzXtvmTkSAvkHenYLrWXTIsy
o5oy6IJtT/vSlC/4gRaFoTuRS3q3njPXe0qywLBk4y9MrqBXYuxumHUTxYTSOv84
BG8sP/7+Ffh8bSZGOctUXrjGXylzcdHGeHVQLxZB0nG13cB8X70OyUJXv71aKGU6
cCkCvrfPPHdPzoMK59XzBa2Lsa1QiXdFHtli2BW+vgtCOdoJOdz0OjnUHTlppIhK
mYhY7BoHIrvn35tn
=eco1
-----END PGP SIGNATURE-----

--=-ETs7wQaqYuVqaD5xzttQ--
