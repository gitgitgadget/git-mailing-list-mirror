From: Ryan Anderson <ryan@michonline.com>
Subject: Re: /etc in git?
Date: Thu, 19 Jan 2006 01:23:29 -0500
Message-ID: <43CF3061.2030504@michonline.com>
References: <b476569a0601181943y6a14e703k1b521a7edb9e2e2@mail.gmail.com>	<7vlkxckf7o.fsf@assigned-by-dhcp.cox.net>	<b476569a0601182040w581b72b7xbb99845da4085646@mail.gmail.com> <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6E0736FAF79C51C8A79F49BF"
Cc: Adam Hunt <kinema@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 07:23:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzTCz-0000jp-HW
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 07:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWASGXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 01:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWASGXn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 01:23:43 -0500
Received: from mail.autoweb.net ([198.172.237.26]:51930 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932560AbWASGXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 01:23:42 -0500
Received: from ryan-uml-tap1.internal.autoweb.net ([10.37.1.33])
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EzTCs-0004t3-1Z; Thu, 19 Jan 2006 01:23:40 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ogkdtu.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14890>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6E0736FAF79C51C8A79F49BF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Adam Hunt <kinema@gmail.com> writes:
> 
> 
>>Do you have any more details by chance?  Does it work?  Does it work
>>well?  How does one do it?
> 
> 
> I personally feel it is a horrible and stupid thing to do, if by
> "version control /etc" you mean to have /.git which controls
> /etc/hosts and stuff in place.  It would work (git does not
> refuse to run as root).  But being a *source* control system, we
> deliberately refuse to store the full permission bits, so if
> your /etc/shadow is mode 0600 while /etc/hosts is mode 0644, you
> have to make sure they stay that way after checking things out.

This is, admittedly, a major problem.

If you instead take the viewpoint that the /etc/.git/ repository is for
tracking textual diffs and not for serving as a backup, it should be an
acceptable tool however.  In my opinion, to be truly useful, it would
need to also automatically commit changes during package installation,
upgrade, and removal.  (To be incredibly useful, it would 3-way merge
changes.  That, I think, is a fantasy at this time.)

> 
> You are much better off to keep /usr/src/rootstuff/.git (and
> working tree files are /usr/src/rootstuff/etc/hosts and
> friends), have a build procedure (read: Makefile) there, and
> version control that source directory.  I usually have 'install'
> and 'diff' target in that Makefile, so that I can do this:
> 
> 	$ cd /usr/src/rootstuff
>         $ make diff ;# to see if somebody edited any targets by hand
> 	$ edit etc/hosts
> 	$ git diff ;# to see the source change
>         $ make diff ;# to see the change I am going to install
>         $ su
>         # make install; exit
>         $ git commit -a -m 'Add a new host.'
> 
> Being able to run "diff" before actually doing it is very handy
> and useful safety/sanity measure.
> 
> Obviously, /usr/src/rootstuff/ should be mode 0770 or stricter,
> owned by the operator group; it would contain some sensitive
> information.

If you're doing this, especially if you're doing this on multiple
machines, creating a package is probably a worthwhile thing to
contemplate as well.


--------------enig6E0736FAF79C51C8A79F49BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDzzBlfhVDhkBuUKURApfOAJ91A7fW/hlPQnLkSS8+53yMDTZDcwCgrsJu
qhgKdQMuxpj7KV7d56jEVrM=
=TA1x
-----END PGP SIGNATURE-----

--------------enig6E0736FAF79C51C8A79F49BF--
