Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808763876A9
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784363882; cv=none; b=qFjODqIW0A/28z6zHjSE1lYZxEuwC8gnjeLAtqdIyYecrB+kUS6lkbz9cy0bmwdtgoVgs+8fjkgJztK31fXiV1Hj520unryw5Gjod8atS1wXH/BIv8AAeyQ2MhdugIItPvh4JyaJHA6pjpPAlNVBQqk18Voru3WuS9H1DULkQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784363882; c=relaxed/simple;
	bh=viJB1HEQRk8HiEEmD+kf97tg/kE3bdVkQj6YlhWFLJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foRXCn45JUicT5hBjYZS0aW1H1TVRNCrWVXgMjOrtpmehhHON6mG1Lu9JjXetKYtLhbUqaL2sfq7DehU0ZipFyvlscwmlHnrVZA7qYLrZnUWu7S8y27cAcORNcefLmI4bBx/Iqf7zRKywztxc9M2Qx6cklKB/KCsGP2Gktog6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eOrFCU04; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eOrFCU04"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so58543695e9.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784363877; x=1784968677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fy344/8s6KayQq2XyAfw8Iht7ifTaYIULzXZssHe+CQ=;
        b=eOrFCU04rAJu1EM/Ygy1cuNKbg7f+ypnavbcuDEY2bX8S9IweFrhGp53JYaovAmExS
         q2RUNpWPSZp4nlS6UQ6pzx8pgwdVlFTkBfrSM19hMA3FiEEuXjL1WKV96vxFGAMeeQ55
         g6ySTFowu+P3bjyzeTwqdhblgbrjRSwvN2Gvlyys6Ob31ZGaDlLxs9T6t+7M0CwuswbS
         oUkmjK0sES6FtFYGRu6HTmnw8hGMiOWOSNPQkXk2zHb6iEqICTUCZsky10cgW5zTX9od
         m6LCdFoQGFn/scGIlVgOiIwwkDpL75cGdl+aoHGsobSPdzPgcz+yb4PdFYlcxfXdCJaL
         pEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784363877; x=1784968677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fy344/8s6KayQq2XyAfw8Iht7ifTaYIULzXZssHe+CQ=;
        b=f53QfKLtjPT8Bab/LvMYF6s1IHqT98OJUPZHgHNRxqUVW1wqr0HRnq1RlAOkwnRqkN
         9fhSIDY9DLVlFOpXNgbZb0a/+LPtUspcP91Efz3UnyTsTrsnrfCCQZiLrkrt32Y553xe
         sl+5Wys672bpFh7H4RWTsstIi7flAAWyS5H1jILj8vIkk9S9Lwh7IqeaLnET9ziOoPa+
         uH16AJXEwDUr5kBN24qeg3O0PvgL1vonDl6Li3QX2sh24hLlaA1Brahmb49w0lWmLY0V
         GJsa/BwI1WR/vr7/Qn822csxw5b+0FS/WbOI/F048axVi/i0WOP1GeOIjKqOpL2jUFSw
         DSjQ==
X-Gm-Message-State: AOJu0YwQwBh0zLMeFn9ks5kN+fF/DT8YQ0OvsruBlDVf/V7XCZf+zdui
	z1/Pp4ys4aw6ea7qnJOJBh1qMDiUNwy4GeTayOMs5dh/x171qEuRJ9xsEOYWTGmlVakFOt5wSZr
	XwXQ8
X-Gm-Gg: AfdE7clxntf/l/f+fOM5OrNQXecXxFzxPEgymDsU3DxrDAWH/VWe/syC9AIf3fPm5w9
	kYqFf+pEKXT7rUt5Y2wKsdVW5POOimyuWxTA74OGbCyPoloRT5Ycoojq8sK7kehhDWjk2/esQVp
	6A014B3FP/YqeIys88qjXKnRpyv+6U017at24n2fTU4F2yyj7pIZjLwLcByITrURYra+TM7afDk
	2kjF9FzEXvwxYmJ776K4UJdBEBEfdMgS21vqDTEhbhIm/XlZTI2QJuNYwJcR1LOMsNRKuLPuOh7
	kfNjpprFODizgTox4TZ7Bee6xK/O8g9VwKMzGLrUdaHSWxUVAf4/OTZLOY0fIKzVkw2J7x2Qctr
	CkQR0aok5/hxanCx1c6wZhaSV+FBU7PzoJDyAN7mukO+WWboVuD68x+/4+O4hNg49Ax927IOZ/V
	qkgp3DSb6IWXLfw80LnQ==
X-Received: by 2002:a05:6000:430d:b0:474:8aad:2e0 with SMTP id ffacd0b85a97d-47f62304899mr6947424f8f.9.1784363877031;
        Sat, 18 Jul 2026 01:37:57 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f63e49500sm10452890f8f.2.2026.07.18.01.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 01:37:55 -0700 (PDT)
Date: Sat, 18 Jul 2026 10:37:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
Message-ID: <als4huLvpnHsl_Mi@monoceros>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <akSuP-IWiH2wPd6S@monoceros>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37ovuavyvzn2irzp"
Content-Disposition: inline
In-Reply-To: <akSuP-IWiH2wPd6S@monoceros>


--37ovuavyvzn2irzp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
MIME-Version: 1.0

Hello,

On Wed, Jul 01, 2026 at 11:38:27AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Jun 30, 2026 at 04:28:50PM +0100, Phillip Wood wrote:
> > On 19/06/2026 11:13, Phillip Wood wrote:
> > > I'm happy to take this forward and try and fix at least some of the
> > > other bugs I've listed above. Uwe - if I don't cc you on some patches
> > > within the next couple of weeks please feel free to send a reminder.
> >=20
> > Here is the first batch that fixes the same problem as Uwe's patch. I've
> > taken a slightly different approach that uses the return value from
> > do_pick_commit() to signal that a commit was dropped rather than
> > adding another function argument. That involves a number of preparatory
> > patches, but they are hopefully reasonably small and easy to follow.
> >=20
> > If a commit gets dropped because its changes are already upstream
> > then we should not record it as rewritten. As well as confusing any
> > post-rewrite hooks this means we end up copying the notes from the
> > dropped commit to the commit that was picked immediately before the
> > one that was dropped.
> >=20
> > This series is structured as follows:
> >=20
> > Patch 1 restores some test coverage that was lost when the default
> > rebase backend was changed.
> >=20
> > Patch 2 moves a function so it can be called without a forward
> > declaration in Patch 11.
> >=20
> > Patches 3 & 4 fix the return value of do_pick_commit() when an external
> > command fails (this is in preparation for patch 10).
> >=20
> > Patches 5-9 try and simplify the control flow in pick_one_commit()
> > in preparation for patch 10.
> >=20
> > Patch 10 changes the return type of do_pick_commit() to an enum.
> >=20
> > Patch 11 adds a new member to the enum from patch 10 for commits that
> > are dropped when they become empty and uses that to stop them from
> > being recorded as rewritten.
>=20
> With my very little knowledge about git internals, this looks
> reasonable, and it behaves as I expect in my test case. I installed a
> local=20
>=20
> Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

While it works fine in my test case, it doesn't in my real-life
workflow.

I have a big branch of changes that I maintain on top of next/master, on
todays rebase I experience:

	uwe@monoceros:~/gsrc/linux-2nd$ git rebase --onto=3Dnext-20260717 next-202=
60716 -r -i device_id^{}
	... handling commits that get empty using `git rebase --skip` ...

	uwe@monoceros:~/gsrc/linux-2nd$ git range-diff next-20260716..device_id ne=
xt-20260717..
	...
	 24:  901ca5f67bc5 !  24:  9f3e8813f6b4 mtd: nand-omap2: Move omap_nand_id=
s[] to raw nand driver
	    @@ Commit message
	      ## Notes ##
		 Forwarded: id:901ca5f67bc57219a9222115fabe1a1729b87e25.1784229863.git.uk=
leinek@kernel.org

	    +    Forwarded: id:20260716123646.1933293-2-u.kleine-koenig@baylibre.c=
om
	    +
	      ## drivers/memory/omap-gpmc.c ##
	     @@ drivers/memory/omap-gpmc.c: static void __maybe_unused gpmc_read_t=
imings_dt(struct device_node *np,
			of_property_read_bool(np, "gpmc,time-para-granularity");
	 25:  69be5d4f9f13 <   -:  ------------ drm/radeon: Only define radeon_acp=
i_vfct_match when actually used
	...

with:

	uwe@monoceros:~/gsrc/linux-2nd$ git notes show 69be5d4f9f13
	Forwarded: id:20260716123646.1933293-2-u.kleine-koenig@baylibre.com

When I rebase without -i, the rebase happens without hitting empty
commits that I have to manually skip and then the notes for 69be5d4f9f13
doesn't make it into the neighbour commit after rebase.

So it seems there is still something fishy with interactive rebase.

Best regards
Uwe

--37ovuavyvzn2irzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpbO2AACgkQj4D7WH0S
/k5Q5AgApRrzgASPuUnC+wuNd2ZOLb/LdlpWt6MMcxZMmQzi1oKb2x7tmVSx4F9y
mh7LlGXk8PbcbChBdecC9MEemc4KjQhIlbRzE/VcB/OWIKkB2K+yM4lw5Dxiym+M
YpN1SkGN3KFmg6/9I2AVafEPprEEPzUELZtAvNN4vHZ2lGvha4Z2CiLjh9VvRwsk
nbHDbbSQlhSvnYk074tkSOy0QLnJJlHVaw3G4EtH6rFB3eB9tkBJ12EvcBi0fORZ
XkVe0TXGe7H8Y6mo8wkqN8yBMUyn8C67kYrGqIbmGGMbINsXlV66Mbdq4SUJXpVx
N28wN0v1vPrOBNlTp3u5ScY1TEtmNg==
=WSXF
-----END PGP SIGNATURE-----

--37ovuavyvzn2irzp--
