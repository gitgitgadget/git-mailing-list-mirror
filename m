From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 5/5] do not overwrite files in leading path
Date: Thu, 14 Oct 2010 00:34:25 +0200
Message-ID: <20101013223425.GB2558@localhost>
References: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <1286632380-7002-6-git-send-email-drizzd@aon.at>
 <7v1v7tkb6g.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 00:34:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69tr-00073T-NW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 00:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab0JMWeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 18:34:11 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62270 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0JMWeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 18:34:10 -0400
Received: by bwz15 with SMTP id 15so149857bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=HmGxCYvr3fh98o4+o0URF/KuChiEYZZFOcnAjNGSVIs=;
        b=E8NEIErlY5nTFvHTWuQf+IPj72fNl+tEzKwLT9MFrNS67eyJuGPXtohqji9sJZlPpM
         mZLKaL8/ZJwztYNcUVKi5yVB8KOOiE+ZUmZSx4GftIeaMsT8ec/yXZqPRF8EIHvfPHkn
         vIKL+jUG8WBEKyAYCEusurYSPJ4Y4ZqzXi4nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=tjAfiHSo2d3uhgXno8UuDuzcmSvo0GY/4wGV2SsoyX4vKEa8iwFmjKM7fVPJ1rq4YA
         py/xDDjj6UzZw518LcS3dBbO5TCil4jj8B/U0oL/PHBY2cAvQfC+6ctjBKOC4uxTyAMJ
         pDkRM39n5X94FphnvjqJ3ZSA5Uew3nko5zz6w=
Received: by 10.204.51.3 with SMTP id b3mr7784264bkg.44.1287009248139;
        Wed, 13 Oct 2010 15:34:08 -0700 (PDT)
Received: from darc.lan (p549A5B77.dip.t-dialin.net [84.154.91.119])
        by mx.google.com with ESMTPS id g12sm9433366bkb.14.2010.10.13.15.34.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 15:34:06 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P69tx-0000vQ-1w; Thu, 14 Oct 2010 00:34:25 +0200
Content-Disposition: inline
In-Reply-To: <7v1v7tkb6g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158994>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2010 at 02:57:59PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
>=20
> > If the work tree contains an untracked file x, and
> > unpack-trees wants to checkout a path x/*, the
> > file x is removed unconditionally.
> >
> > Instead, apply the same checks that are normally
> > used for untracked files, and abort if the file
> > cannot be removed.
> >
>=20
> Too short a line is also hard to read as too long a line.

Ok.

> > diff --git a/cache.h b/cache.h
> > index 2ef2fa3..f65d6f9 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -852,7 +852,7 @@ struct cache_def {
> > =20
> >  extern int has_symlink_leading_path(const char *name, int len);
> >  extern int threaded_has_symlink_leading_path(struct cache_def *, const=
 char *, int);
> > -extern int has_symlink_or_noent_leading_path(const char *name, int len=
);
> > +extern int check_leading_path(const char *name, int len);
>=20
> This is an API regression.  "check" in function name "check-blah" does not
> tell what you are checking (is it checking if the path is Ok?  is it
> checking if the path has symlinked components?  is it checking if some
> part of the path overlaps with tracked content?  is it checking if you
> have already run lstat(2) on some of the leading path components?), nor
> for what purpose the check can be used (it is Ok to overwrite it?, is it
> Ok to create a directory there?  is it Ok to create a file there?).
>
> At least the old name told us what it checked, didn't it?

Yes, but that's not what it does any more. I worded it vague on
purpose, because there is really no way to explain all it does in
one function name. This is the full description.

/*
 * Return zero if path 'name' has a leading symlink component or
 * if some leading path component does not exists.
 *
 * Return -1 if leading path exists and is a directory.
 *
 * Return path length if leading path exists and is neither a
 * directory nor a symlink.
 */

But if you prefer, we can call it "verify_clean_leading_path"?

> The approach you took looks sound, though.  What did you feel was "not
> exactly pretty" about it?

First, check_leading_path bothers me. It does too many things and
encodes all of that in one integer return value.

Second, I also have to copy the offending path manually to a local
path variable, even though lstat_cache already has that path stored
in a buffer.

Third, check_ok_to_remove expects a cache_entry. But in case of a
match in check_leading_path, we do not have one and pass NULL to
check_ok_to_rmove. It will not be used anyways, because
check_leading_path should return > 0 only for regular files, and
the cache_entry is only used for directories in
verify_clean_subdirectory.

If lstat returns with an error other than NOENT, or if
check_ok_to_remove is called with anything other than a directory
and cache_entry is NULL, we get a segmentation fault. Before, an
error was simply ignored. I don't know which is worse.

On the other hand, I think the patch fixes a nasty bug, so maybe we
can accept those issues for now.

Clemens

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMtjPwAAoJELKdZexG8uqMgzkH/2EGoU7M4bvflzN0tJd+YuNK
wD+zWLZQSo2flcXYNuLlYU7msAaj19EQftSoLKtuOgSz5P59+KxZ72cq4kr5t8iN
fqnJjsJSP0fDgcCtzSu17lBY/5o1KQ9BF2+TbnO4Tyu0wD0qjU5gasrbmX6ONNoW
RxW8NsIVno01wLrKPcX6cr82AqdFGjqh9VPITQR5GyM53RRPeUDgOH236Vj69leX
DOQnMGL1oW8hFPLO3RR3uAMVlrHNKRCaKHhqTXKxlPGgF8IanmeBlZCQQ4VIwEpt
9rKBmIKjtZrPNX0DDYKmWpAS265yt6GgwDTo76rDZ77N3qjh+PDMtw01OCsIHdc=
=GMf0
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
