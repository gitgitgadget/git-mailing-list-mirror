Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193EC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 08:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLGIeG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLGIeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 03:34:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48B234
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 00:34:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u5so7534119pjy.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 00:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XlamJdn8ZK12f5Y/DS3OZeqJOBuFDN9IQhWvqMbUzc=;
        b=gaN29dj/kSg1RtjnK8X6fKQ6vltovq4mi4Eg6H2myGljrXy8C+33ehDc51eFEVXyYC
         mdrOWA6L6VUFcebavW9zC9t3iYYjAOpkLy6E8fTfa6pDNdqnSxZKcShIdvxztiSRsQ72
         Aii6yPV+FzJrAfaaab8ISfV6729v/DzC0dYcVZWWtOP2yNB5NB4qndz9VaCqiHCFxI38
         Pev+hakyelQfOtw6WacxTn+nrpQ7PrNikOHLPyVLqdkh9dBMeJvEnfOL0FY/LHG/ViFs
         98K4lXMKBO20+B0VFyQujabwyJuPC+yibqCz0997ggAWHeJaENKD9jjqT/3eXe/DbfdL
         HlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XlamJdn8ZK12f5Y/DS3OZeqJOBuFDN9IQhWvqMbUzc=;
        b=3EvpBEP89EmmgR4WN/hLKbhsEpdV0M/JKNyoiOfMUqWemakVr1ZoHaW4hD9F9yJb0C
         98xqMDxMKcaExVHKovReMGNBoqkxkibv/j0vKzChh77LQBsbq5r5JylPb7ENYTfhy4nZ
         Gdg6vyUPtlxJxWTtw0THuXqMxQeo0E80wBTQnfgcTTB0Vy+hzkPMeF6zywBRulx4232L
         Ta0lfDERXzIQo4QpKn7kUreprzK+MXbtdfcO70RHz4NJj9gEi1z+LaXRpUxlofRMyXgj
         611N2NJ16J5akVZ5IDUhpdBepGpbVg3cv44DlPzXWSLYbCha+iWqhJ3D3i8cBsgrCIl2
         UiIA==
X-Gm-Message-State: ANoB5pnvG/f4fjcSchI9VF59e91BOcIKWBUMUb9ec3HongQl5ZmlYRP5
        PwvytsaLGXoxgbJrD5idPDs=
X-Google-Smtp-Source: AA0mqf5bOPRmz1xqRCUMmumNpkfKUYgsD3DsWhElhqd1nYqrbJ8TPI3f++nNr5SrHRoOgqBYLAbGPQ==
X-Received: by 2002:a17:902:eb8a:b0:189:cca6:396e with SMTP id q10-20020a170902eb8a00b00189cca6396emr4691955plg.120.1670402043193;
        Wed, 07 Dec 2022 00:34:03 -0800 (PST)
Received: from debian.me (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79ad1000000b005736209dc01sm12933394pfp.47.2022.12.07.00.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 00:34:02 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4F24010444C; Wed,  7 Dec 2022 15:33:59 +0700 (WIB)
Date:   Wed, 7 Dec 2022 15:33:59 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y5BP95xjaA/9C70Q@debian.me>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
 <Y4nN2h4FIYGNjCSI@debian.me>
 <Y4ncAhIqHkckMljb@coredump.intra.peff.net>
 <Y4sCfRdWAzjqw7cq@debian.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jft/s7l/Cf7286OH"
Content-Disposition: inline
In-Reply-To: <Y4sCfRdWAzjqw7cq@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jft/s7l/Cf7286OH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 03, 2022 at 03:02:05PM +0700, Bagas Sanjaya wrote:
> On Fri, Dec 02, 2022 at 06:05:38AM -0500, Jeff King wrote:
> > -- >8 --
> > Subject: [PATCH] git-compat-util: undefine system names before redeclar=
ing
> >  them
> >=20
> > When we define a macro to point a system function (e.g., flockfile) to
> > our custom wrapper, we should make sure that the system did not already
> > define it as a macro. This is rarely a problem, but can cause
> > compilation failures if both of these are true:
> >=20
> >   - we decide to define our own wrapper even though the system provides
> >     the function; we know this happens at least with uclibc, which may
> >     declare flockfile, etc, without _POSIX_THREAD_SAFE_FUNCTIONS
> >=20
> >   - the system version is declared as a macro; we know this happens at
> >     least with uclibc's version of getc_unlocked()
> >=20
> > So just handling getc_unlocked() would be sufficient to deal with the
> > real-world case we've seen. But since it's easy to do, we may as well be
> > defensive about the other macro wrappers added in the previous patch.
> >=20
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > There may be other similar cases lurking throughout the code base, but I
> > don't think it's worth anybody's time to go looking for them. If one of
> > them triggers on a real platform, we can deal with it then.
> >=20
> >  git-compat-util.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 83ec7b7941..76e4b11131 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -346,6 +346,7 @@ static inline int git_setitimer(int which UNUSED,
> >  				struct itimerval *newvalue UNUSED) {
> >  	return 0; /* pretend success */
> >  }
> > +#undef setitimer
> >  #define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
> >  #endif
> > =20
> > @@ -1480,6 +1481,9 @@ static inline void git_funlockfile(FILE *fh UNUSE=
D)
> >  {
> >  	; /* nothing */
> >  }
> > +#undef flockfile
> > +#undef funlockfile
> > +#undef getc_unlocked
> >  #define flockfile(fh) git_flockfile(fh)
> >  #define funlockfile(fh) git_funlockfile(fh)
> >  #define getc_unlocked(fh) getc(fh)
>=20
> The warnings gone away, thanks!
>=20
> For this patch and the previous one [1],
>=20
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>=20
> [1]: https://lore.kernel.org/git/Y4fH4rhcSztHwKvK@coredump.intra.peff.net/
>=20

PING?

Is your patch ready for v2.39?

--=20
An old man doll... just what I always wanted! - Clara

--jft/s7l/Cf7286OH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCY5BP7gAKCRB7tWyQc2rT
CJe7AP0VPzpQ3RbVacjEPpu5M2nj7S1/KL4iWt3iXS3sRJ2WlQEA7FxVcsrtBTAU
kBHJM6PwNcgukZuM+N02az/Xl28OwAM=
=lHM6
-----END PGP SIGNATURE-----

--jft/s7l/Cf7286OH--
