From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Mon, 05 Apr 2010 07:14:54 -0600
Organization: Red Hat
Message-ID: <4BB9E24E.4090206@redhat.com>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com> <7vaatmmju9.fsf@alter.siamese.dyndns.org> <4BB5F94F.3090403@redhat.com> <20100403074700.GA24176@progeny.tock>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig605641185EB44463AD3CEB6F"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 15:16:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NymAV-0002R8-TD
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 15:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0DENQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 09:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab0DENQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 09:16:34 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o35DGBfU003473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 5 Apr 2010 09:16:12 -0400
Received: from [10.11.9.20] (vpn-9-20.rdu.redhat.com [10.11.9.20])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o35DGAxr014708;
	Mon, 5 Apr 2010 09:16:10 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b1 Thunderbird/3.0.4
In-Reply-To: <20100403074700.GA24176@progeny.tock>
X-Enigmail-Version: 1.0.1
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143980>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig605641185EB44463AD3CEB6F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2010 01:47 AM, Jonathan Nieder wrote:
> Red Hat internal people might want to be able to use 1.8 when it comes
> out.  Maybe something like this would do the trick?  I don=E2=80=99t kn=
ow whether
> Cygwin 1.6 has the fixes 1.7 does, so in my ignorance I lumped it with
> 1.5.

Cygwin 1.6 is on par with 1.5 feature-wise, so your cutoff of 1.6 as the
last old version is correct.

> @@ -831,7 +831,7 @@ ifeq ($(uname_S),SunOS)
>  	BASIC_CFLAGS +=3D -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
>  endif
>  ifeq ($(uname_O),Cygwin)
> -	ifneq ($(wordlist 1, 2, $(subst ., ,$(uname_R))),1 7)
> +	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)

It would be nice to use fewer processes, since forking is so expensive
on cygwin:

ifeq ($(shell case '$(uname_R)' in 1.[1-6].*) echo old;; esac),old)

But does that work to have unbalanced ) in a makefile $(shell)?  On the
other hand, this is already in a chunk guarded by $(uname_S) being
cygwin, and we know that cygwin shells understand:

ifeq ($(shell case '$(uname_R)' in (1.[1-6].*) echo old;; esac),old)

even though it is not portable to other shells, like Solaris /bin/sh.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig605641185EB44463AD3CEB6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku54lAACgkQ84KuGfSFAYBczgCgs73sEfvj0n9q94N1fsZVmEig
uIYAn1hPLRsgHBx8kXrgaFsbpBLn34Su
=smLx
-----END PGP SIGNATURE-----

--------------enig605641185EB44463AD3CEB6F--
