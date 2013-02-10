From: Robert Clausecker <fuzxxl@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sun, 10 Feb 2013 04:57:08 +0100
Message-ID: <1360468628.6610.5.camel@t520>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com>
	 <1359915086.24730.19.camel@t520> <510F03FC.6080501@gmail.com>
	 <CABURp0rMk-W8VMRhXoR9YYQSwjWTfPbXz5mhPX3-HKsBSu5_mw@mail.gmail.com>
	 <1360425499.3369.10.camel@t520> <7vehgpum7n.fsf@alter.siamese.dyndns.org>
	 <7vpq08u903.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-N4v1lohl4B+u+lO6Bhm7"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 04:57:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4O32-0006BX-SE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 04:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761045Ab3BJD5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 22:57:18 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:51272 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760999Ab3BJD5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 22:57:17 -0500
Received: by mail-bk0-f42.google.com with SMTP id jk7so2174329bkc.15
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 19:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:in-reply-to:references
         :content-type:x-mailer:mime-version;
        bh=8WIGuX/j/cdW81f8GGKUwiHX5WJPQ5F3DSsboae3bLM=;
        b=xB4an7xUZRqa3evg+IRr4ggkt7CclOKWRQd27XG5P99bBqJh0Yl5teEUr8dGPE0k4G
         5QbQOwPGcwFsxjrfZBtGnWacBzZI0nPqnvWXd4vNlz8sHCjN2dKUhQXKF1g8rPrUoAQJ
         Vax+5zwZGWCR5q+2E8b0RTWHYWTgBrQToquvaVzPhBeuqUjMkLN4HIGa/bwrHvz6jCEP
         VQko4zJmD5ZdFAVLor2/SgjIRmzu1ZTuE5jkrm/1g/FHeBLfOs9pf0ED0oh8arWjmGz/
         t4ZuX5oTtmz4Htj0jPu5P44Pglo+xDx+mw0YAOKA2peozTG8/PMyrFL+meOTA3SkBDlF
         Hdww==
X-Received: by 10.204.145.83 with SMTP id c19mr2802672bkv.69.1360468636096;
        Sat, 09 Feb 2013 19:57:16 -0800 (PST)
Received: from ?IPv6:2001:bf0:c001:30:344f:f7d:d92a:db7e? ([2001:bf0:c001:30:344f:f7d:d92a:db7e])
        by mx.google.com with ESMTPS id o9sm11699237bko.15.2013.02.09.19.57.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Feb 2013 19:57:15 -0800 (PST)
In-Reply-To: <7vpq08u903.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215893>


--=-N4v1lohl4B+u+lO6Bhm7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are two things git archive is missing that are needed in my use
case:

First, git archive in combination with tar won't remove unneeded files.
You have to run rm -rf before manually which brings me to the next
point; git archive can't really make incremental updates. Consider an
export that overwrites a tree that resembles the state of an export two
commits before and contains a lot of files. I don't like to idea of
needing to remove all files and write all of them again just to change
one or two lines.

Perhaps my real problem is not "export" but rather "Can I have multiple
work trees with multiple checked out revisions?"...

Am Samstag, den 09.02.2013, 19:45 -0800 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > I am not Phil, but if you ask me, I think it is borderline between
> > "meh" and "no way we would give a short-and-sweet -i to something
> > like this".
>=20
> I think one reason it was "meh" for me is that we never did an
> equivalent of "cvs export" and "svn export", primarily because
> we had "tar-tree" (aka "archive --format=3Dtar") first, and it was
> sufficient to pipe its outputto "tar xf -" if somebody wanted to do
> the non-existent "git export".  Also "tar-tree" was more useful for
> people who wanted to eventually want to have a tarball (you can
> first "export" and then "tar cf" the resulting directory).
>=20
> But I think it is fine to add "git export <revision> <directory>",
> which may look like this, perhaps.
>=20
> 	#!/bin/sh
> 	# git export <rev> <directory>
> 	rev=3D${1?revision} dir=3D${2?directory}
> 	. $(git --exec-path)/git-sh-setup
>=20
>         mkdir -p "$dir" || exit
>         git archive --format=3Dtar "$rev" |
>         tar Cxf "$dir" -
>=20


--=-N4v1lohl4B+u+lO6Bhm7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJRFxqUAAoJEDpa/qG5y+V5IjEH/2blEoP36U7K9uAQNvSxgnrk
a5oiEvFsb92g2k/Fyeh9FDyHOttGzG7dIKpUsdHNY21ReD71uAdYfMkJ3pekNTFJ
IsQ+Q8lFAJYcGfA5dXy0JQGoMwO1IoEILid0d3GpvxygL29OrVor7GVSy0qFUPeZ
HJWUQGsD/XYaMAeY8weU2PWGZuhIW3DVJjHe6daEhdv12csz0uZwu8aT8NcCqhOU
X3rlDJg8NRo9LgErsFm9YkE6+UODiDi+weoMdAnBu6aIsm6iGLy2Jx8N7eyAwTh+
VjIxpUaW93qmmyQDQVYadlOBaxcIWYhmAgb2pkeqwrppdrg4aaW6n8Cgbda1eDg=
=8UCW
-----END PGP SIGNATURE-----

--=-N4v1lohl4B+u+lO6Bhm7--
