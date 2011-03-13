From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] find_unique_abbrev(): honor caller-supplied "len"
 better
Date: Sun, 13 Mar 2011 22:30:26 +0900
Message-ID: <1300023026.1450.1.camel@leonhard>
References: <E1PBKT9-0004Uk-Sm@tytso-glaptop>
	 <20101028075631.GA7690@elte.hu>
	 <AANLkTi=8SbOZizWpxLg=Bgp7atdgr8MsR6tnRDYr1+eW@mail.gmail.com>
	 <20101028163854.GA15450@elte.hu>
	 <AANLkTin62vAwJxcsrFk6Yn7Q6tzr-D=EmKKwPazuAJ11@mail.gmail.com>
	 <7veiba9ev2.fsf@alter.siamese.dyndns.org>
	 <7vhbba38mm.fsf_-_@alter.siamese.dyndns.org>
	 <AANLkTimH9=OWD4+dPsdYaL2VPdDkTsUG_N3GBf168XqD@mail.gmail.com>
	 <7vzkp21ocm.fsf@alter.siamese.dyndns.org>
	 <AANLkTikPxSspRFQWke4=u55cmmHw8NsyizeH2gL1kD0y@mail.gmail.com>
	 <7vmxl21lwr.fsf@alter.siamese.dyndns.org>
	 <7vipvq1hpw.fsf@alter.siamese.dyndns.org>
	 <7vvczpff89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 14:30:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PylNY-0007lw-H5
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 14:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab1CMNaf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2011 09:30:35 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:45650 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887Ab1CMNae (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 09:30:34 -0400
Received: by pxi2 with SMTP id 2so1123640pxi.10
        for <git@vger.kernel.org>; Sun, 13 Mar 2011 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=GTgFSylaVw4IXlWcebso9iT+FqwlujOyefwybtlWI88=;
        b=Ew9Bj3VkkzSc9WVf2WHoE3fFDWqz/ZI/M1PC2jeBJKMzDNyUoi0zkR6/AaI5gohR6l
         hO06OhTrYS02gU+g/midDUZ+FNcZtw/0CjK+QhZAkeCRAIs/QGEf/qv+fFyl0UJ/AsA6
         4NKrDMrIa2En5xZgn0O6nFj2ZIEOR4sUhQWis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=YGpygqLPjhCGk0kMT92mVH1GR0nSsgrxVzB9O1/INrVm7jY7bUs69A1pP8O3YN+YO/
         ShbgL1/nbLaKkSPEhujJq4LCsM7zTCQvUKnGyRBKbbCeq8vh8vaupSIwY1AZddIUVNxe
         r+HZuPoj5Ao1c6PITqHKsCcuIEPy+MPtExPzM=
Received: by 10.142.120.40 with SMTP id s40mr9638522wfc.193.1300023034228;
        Sun, 13 Mar 2011 06:30:34 -0700 (PDT)
Received: from [118.176.78.238] ([118.176.78.238])
        by mx.google.com with ESMTPS id x11sm2016140wfd.13.2011.03.13.06.30.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Mar 2011 06:30:32 -0700 (PDT)
In-Reply-To: <7vvczpff89.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168967>

2011-03-11 (=EA=B8=88), 14:45 -0800, Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > So let's scrap the abbrevguard thing.  I somehow thought that I alr=
eady
> > took your "make DEFAULT_ABBREV tweakable" patch, but apparently I d=
idn't.
> > That one is the real fix to the issue of futureproofing.
>=20
> In return for a free education last night, I now owe you your patch f=
rom
> October last year, resurrected from the list archive, and here it is.
>=20
> With a forged sign-off from you, as I know that everything you write =
is
> supposed to be open source.
>=20
>  - I do not think making minimum configurable is worth it, but I left=
 it in
>    (there is no UI to tweak it anyway).
>=20
>  - I somewhat tweaked "describe" and "describe --abbrev" implementati=
on.
>    OPT__ABBREV() uses DEFAULT_ABBREV in its callback, so we need to r=
ead
>    from the configuration before calling parse_options().  As it won'=
t
>    make any sense to call "git describe" outside repository where you
>    cannot get to your configuration, I think it is safe to add a call=
 to
>    git_config() in this codepath. Other users of OPT__ABBREV() may ne=
ed to
>    be audited.
>=20
> By the way, I've already reverted the abbrevguard thing away.
>=20
> -- >8 --
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Thu, 28 Oct 2010 11:28:04 -0700
> Subject: [PATCH] Make the default abbrev length configurable
>=20
> The default of 7 comes from fairly early in git development, when
> seven hex digits was a lot (it covers about 250+ million hash
> values). Back then I thought that 65k revisions was a lot (it was wha=
t
> we were about to hit in BK), and each revision tends to be about 5-10
> new objects or so, so a million objects was a big number.
>=20
> These days, the kernel isn't even the largest git project, and even
> the kernel has about 220k revisions (_much_ bigger than the BK tree
> ever was) and we are approaching two million objects. At that point,
> seven hex digits is still unique for a lot of them, but when we're
> talking about just two orders of magnitude difference between number
> of objects and the hash size, there _will_ be collisions in truncated
> hash values. It's no longer even close to unrealistic - it happens al=
l
> the time.
>=20
> We should both increase the default abbrev that was unrealistically
> small, _and_ add a way for people to set their own default per-projec=
t
> in the git config file.
>=20
> This is the first step to first make it configurable; the default of =
7
> is not raised yet.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Reviewed-by: Namhyung Kim <namhyung@gmail.com>

Thanks.


--=20
Regards,
Namhyung Kim
