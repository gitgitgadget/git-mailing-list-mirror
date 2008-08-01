From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2/2] clone --bare: Add ".git" suffix to the directory
 name to clone into
Date: Fri, 01 Aug 2008 10:01:16 -0400
Message-ID: <4893172C.1060203@griep.us>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808011601200.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3BD0C346574642617EADBD23"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOvDD-00023M-Ka
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 16:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYHAOBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 10:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYHAOBa
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 10:01:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:32119 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbYHAOB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 10:01:29 -0400
Received: by wr-out-0506.google.com with SMTP id 69so801757wri.5
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=eSNpY1L18UcCmtobMjBP6sr6st949cE6sDx7QEdyeFk=;
        b=IthI459Vr9mFUVaZ6ZY80YxCKshAXQ+IAdE2i2I/CnFWUyh3aLg/etwI+1kk5f7sa5
         x/PigB6j+QVqIMHpVpvxzzpyjDOUCdskdgRbfUnROHYZdpC8bbAXgkQPEM7Rb1APc+nG
         zjmRJoHrcfFtZMK2s8P1xtq7EhWPsHSZyIFjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type:sender;
        b=lG+5KIWkWWkyClwtPPZ3Xb0g1GSY3s4KTSAMMiu41m6VI3gFvxYRd2ISTfGxPbjnG+
         fVTCFFIVpY408Bc/mtC8CFyvKZ+rCvCaKpskFQVw8obGlpEb0QUFbTsjIybiTh+NzZOc
         5Y4d1n1eGe5hlvgshzDEsJBr1FJNw8JQWsBNY=
Received: by 10.100.131.3 with SMTP id e3mr12345586and.59.1217599288785;
        Fri, 01 Aug 2008 07:01:28 -0700 (PDT)
Received: from ?208.125.124.67? ( [208.125.124.67])
        by mx.google.com with ESMTPS id 27sm2365950wra.32.2008.08.01.07.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 07:01:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.DEB.1.00.0808011601200.9611@pacific.mpi-cbg.de.mpi-cbg.de>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91068>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BD0C346574642617EADBD23
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does this patch forgo adding a ".git" suffix if one is already present?

Marcus

Johannes Schindelin wrote:
> We have a tradition that bare repositories live in directories ending
> in ".git".  To make this more a convention than just a tradition, teach=

> "git clone --bare" to add a ".git" suffix to the directory name.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>=20
> 	This patch is only conceptionally dependent on patch 1/2.
>=20
>  builtin-clone.c  |   10 ++++++++--
>  t/t5601-clone.sh |    7 +++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/builtin-clone.c b/builtin-clone.c
> index a45179c..82f5b67 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -95,7 +95,7 @@ static char *get_repo_path(const char *repo, int *is_=
bundle)
>  	return NULL;
>  }
> =20
> -static char *guess_dir_name(const char *repo, int is_bundle)
> +static char *guess_dir_name(const char *repo, int is_bundle, int is_ba=
re)
>  {
>  	const char *end =3D repo + strlen(repo), *start;
> =20
> @@ -131,6 +131,12 @@ static char *guess_dir_name(const char *repo, int =
is_bundle)
>  			end -=3D 4;
>  	}
> =20
> +	if (is_bare) {
> +		char *result =3D xmalloc(end - start + 5);
> +		sprintf(result, "%.*s.git", (int)(end - start), start);
> +		return result;
> +	}
> +
>  	return xstrndup(start, end - start);
>  }
> =20
> @@ -388,7 +394,7 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
>  	if (argc =3D=3D 2)
>  		dir =3D xstrdup(argv[1]);
>  	else
> -		dir =3D guess_dir_name(repo_name, is_bundle);
> +		dir =3D guess_dir_name(repo_name, is_bundle, option_bare);
> =20
>  	if (!stat(dir, &buf))
>  		die("destination directory '%s' already exists.", dir);
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 4b2533f..e0a68ab 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -80,4 +80,11 @@ test_expect_success 'clone --mirror' '
> =20
>  '
> =20
> +test_expect_success 'clone --bare names the local repository <name>.gi=
t' '
> +
> +	git clone --bare src &&
> +	test -d src.git
> +
> +'
> +
>  test_done

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enig3BD0C346574642617EADBD23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSJMXMwPFruyc22R/AQKgrBAAnKEPFzwjvE8L/pBMugK7gEzJ5F9aBatW
msTgUptDFrdmasaZEfZYZi0771Co0X/fzD6COKhucZ3OqQOOagLb+6XRlan9MFAb
4NNScQ7BhowIFgVO0zdy9duPZjMdrIFmQjuP5GCgcj8anepVmWm2eNXs4jqp+SQs
0kfI6qUc5n+/LqjheFUlg0g6Z6CgL+30MjPnxDNMOuopbtkQZdW+StHiKM9aZXZJ
z/MeLkfGKFSEmILCRYuXiJBGBB3gCYIEcefEmMsIoPViMRDJY+A8uYAjFrd5s/KD
mD5+9bzgSKrqSrszxpWBWApZOdwfKUQYlvH1jBII4qTg7RiOt2FZQgQHzHfvIl1G
ABU8TW3aBIg6Vfk3BxQfHHhixJxJSYo7h507zptcCLYUtZESYblEEBwpMHC6S9Mp
sXhO6FcmP/oN7VCh8YIdjWxH4wD+v0kyvyVoCUJd4iwWYwnLNZkqTBmEftUK/kwn
CPFsMRDy2ag0eXzAiOtw3PyXNcY4MgsOtG6Wcy+B33VTZGX/7SA4OvJGUGazBiz3
U//bzZtaEJZqDHcvc03SgoGPBQxj/8QS/sYZEt3tlGUg8srF09DuJ7v1Zp5Faf2P
8DFFB+MQMqByXw9oWAvlGgBdBHhKOjpTV7NuMqiXiqKVukRnf9CUABj1qFtjwDDd
aOg/SzYhidg=
=Tp2A
-----END PGP SIGNATURE-----

--------------enig3BD0C346574642617EADBD23--
