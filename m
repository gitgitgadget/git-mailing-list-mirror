From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 09:26:51 +0200
Message-ID: <20080819072650.GE11842@schiele.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9hzSyicXuByfNYJd"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:28:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLdG-0001RC-HG
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYHSH0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbYHSH0z
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:26:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38069 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYHSH0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:26:54 -0400
Received: by ug-out-1314.google.com with SMTP id c2so405362ugf.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:from:reply-to;
        bh=6Dg/VZL8M7JLN6pjnAeV4eGr2e+Ane+cOw8rvUEaSMI=;
        b=agu7/nBswY3f3TEht84drB/8DdKV14ebu0y5e1ebnKJrcvNbneyJoOU7lcdwpylzmr
         +09y5favd4Op7SJtRq8eAggYwMzLZHm9IEd5kT5pJTvt7P4FqRFc7ezaoNdW3ScFm8BW
         Yp1acCwCmskytJz8wLuYEVZmI5o5/TcW8Dt5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent:from:reply-to;
        b=vMfgqrckfLi9dM7syYhkKijd2iB7WJgi7yoWuBcgBWRhFAQLtlwG0qNjLVfQOFZKYu
         kFJejb1jG2vdXU9+GAoYiekCWD0Zak7FmdMPxeHCD/+8Wkfk2BEIHIFP6y+ZQmH3InXr
         4CrEqY7LQR1pVm46IhZlH7+3Md03EUkX/POeU=
Received: by 10.66.234.8 with SMTP id g8mr4707951ugh.43.1219130812959;
        Tue, 19 Aug 2008 00:26:52 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [91.18.123.131])
        by mx.google.com with ESMTPS id 18sm10149196ugk.82.2008.08.19.00.26.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 00:26:52 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 2648D16051; Tue, 19 Aug 2008 09:26:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92821>


--9hzSyicXuByfNYJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2008 at 05:29:11PM -0700, Junio C Hamano wrote:
> Haven't looked at the real declarations but if the decl are "extern" and
> nobody refers to them, why should the resulting object file require them
> to be defined anywhere?  If the decl are not and in (fortran-ish) "common"
> section, on the other hand, you shouldn't have to define them yourself
> like this either.
>=20
> This sounds like a compiler bug to me.

This was my first thought as well but after more inspection there are two
things to consider:

1. I was not really precise enough in my description since I didn't spot th=
at
   when I looked into the issue first: Actually there are references to the=
se
   variables in static inline functions in cache.h.  Thus there actually is=
 a
   reference though one that will never be used since abspath.c (that inclu=
des
   cache.h) is not calling any of these functions.

2. Since these symbols turn out to be referenced though in dead code only I
   wouldn't call it a compiler bug.  Obviously a smart compiler would do de=
ad
   code elimination here but the fact that this compiler is not doing so is
   bad but not really a bug.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--9hzSyicXuByfNYJd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFIqnW6xcDFxyGNGNcRAqwGAJ9jmiO6b4RPW2RzKu97RhLewRZXOQCfeRNR
NWpj53SJ9Wb+GACtEXK+Img=
=BL5G
-----END PGP SIGNATURE-----

--9hzSyicXuByfNYJd--
