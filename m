From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Question about git-svn import
Date: Mon, 17 Dec 2007 22:48:36 -0500
Message-ID: <20071218034836.GA27080@dervierte>
References: <4766AF65.5060706@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 04:49:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4TS9-0005Dn-H4
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 04:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbXLRDsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 22:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbXLRDsq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 22:48:46 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:4585 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbXLRDsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 22:48:45 -0500
Received: by an-out-0708.google.com with SMTP id d31so601883and.103
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 19:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=pvN5qZ49xyoDS4KTeXy1uhXUjIOTSYZswiTaLJozt38=;
        b=g6rsuVFX8UM/zddq6lx8THo68k7L/YWriD9BSfrxys38LArAuWbyqSh/hb47YIZpuA5IqLYKkf0tiAnYF3iwzkRNaYeoyiJhB86z5BeIJ5aSd8xWJCmkSlO/vsdYP8o8cxLvPRSvGaZz9QUeG5A11oapn7cgMlX3+ZfZET+9Cz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PcSVlYWAtvloWyXhUFXiFQSimR27eMTcEn70tr2mX10x1TmEXOlcJf92zyR3YaTxqKm6A/KMeU0WzhRdz8xZHp4WqJgQXEhVNpWJEY6Lz+DbE9sQ4skTEVuPe/WHDpsh3QzCAb0R0R8jI/eVxGvlQ0JtMAHycVwKWOxsOttvs2E=
Received: by 10.100.41.16 with SMTP id o16mr16307986ano.118.1197949719705;
        Mon, 17 Dec 2007 19:48:39 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 13sm10876471wrl.2007.12.17.19.48.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2007 19:48:37 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id D1ACFBAAF2F; Mon, 17 Dec 2007 22:48:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4766AF65.5060706@obry.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68694>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2007 at 06:18:29PM +0100, Pascal Obry wrote:
> You'll find a script into this message that reproduce what I'll describe
> below. Basically the Subversion repository add a given structure in the
> past then rearranged to use the "standard" structure. The former
> structure was:
>=20
>    <root>
>       |
>       | - dir1
>       | - dir2
>=20
> The new one is:
>=20
>    <root>
>       |
>       |- trunk
>       |    | - dir1
>       |    | - dir2
>       |- branches
>       |- tags
>=20
> Now I want to import this project into Git (using git-svn) as the
> project won't leave Subversion for the moment. When doing:
>=20
>    $ git svn clone -s <repo> <git-repo>
>=20
> In git-repo we get only the commits done inside <root>/trunk and not the
> commits done in the former repository.
>=20
> The question is what is the best way to deal with such a case with git-sv=
n ?

Not sure if this is the best way, but I would recommend cloning into two
repositories, then combining them.  So you already have the newer
changes with the standard layout.  You would now:

    $ git svn init <repo>

And only fetch the revisions before the layout change.  You could then
combine the two repositories using .git/info/grafts and
git-rewrite-branch.
--=20
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 =3D 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F=20

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZ0MU/IGXd9wono8RAitzAKCltNPwBvXyc6F7FLRpz/3wU6nv+QCdEwui
/GU05YTtakfIPs2EjXKGJ6s=
=Ql6e
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
