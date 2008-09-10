From: Simon Hausmann <simon@lst.de>
Subject: Re: PATCH: git-p4 optional handling of RCS keywords
Date: Wed, 10 Sep 2008 21:18:52 +0200
Message-ID: <200809102119.01630.simon@lst.de>
References: <646617.59689.qm@web95011.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5138431.danGmDdy0Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, GIT SCM <git@vger.kernel.org>,
	Jing Xue <jingxue@digizenstudio.com>
To: dhruva <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 21:20:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdVEg-0003Oe-3T
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 21:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYIJTTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 15:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbYIJTTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 15:19:09 -0400
Received: from hoat.troll.no ([62.70.27.150]:58508 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYIJTTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 15:19:08 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 4C003209FF;
	Wed, 10 Sep 2008 21:19:02 +0200 (CEST)
Received: from rani.localnet (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 2D7EC20995;
	Wed, 10 Sep 2008 21:19:02 +0200 (CEST)
User-Agent: KMail/1.10.1 (Linux/2.6.26-5-generic; KDE/4.1.1; i686; ; )
In-Reply-To: <646617.59689.qm@web95011.mail.in2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95547>

--nextPart5138431.danGmDdy0Z
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 10 September 2008 08:29:56 dhruva wrote:
> Hi,
>  Incorporated the style tip, sure makes it look cleaner.
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2216cac..3e72e43 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -16,6 +16,9 @@ from sets import Set;
>
>  verbose =3D False
>
> +# Handling of RCS keyowrds. To ensure backward compatibility, the default
> +# is to strip keywords. Default behavior is controlled here
> +kwstrip =3D True
>
>  def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
> @@ -975,7 +978,9 @@ class P4Sync(Command):
>                  sys.stderr.write("p4 print fails with: %s\n" % repr(stat=
))
>                  continue
>
> -            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
> +            if not kwstrip:
> +               pass
> +            elif stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
>                  text =3D re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', te=
xt)
>              elif stat['type'] in ('text+k', 'ktext', 'kxtext',
> 'unicode+k', 'binary+k'): text =3D
> re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$'=
,r
>'$\1$', text) @@ -1850,6 +1855,16 @@ def main():
>          (cmd, args) =3D parser.parse_args(sys.argv[2:], cmd);
>      global verbose
>      verbose =3D cmd.verbose
> +
> +    global kwstrip
> +    kwval =3D gitConfig("git-p4.kwstrip")
> +    if len(kwval) > 0:
> +       kwval =3D kwval.lower();
> +        if "false" =3D=3D kwval:
> +            kwstrip =3D False
> +        elif "true" =3D=3D kwval:
> +            kwstrip =3D True

I have another style nitpick, sorry :). Please use "kwval =3D=3D "false" in=
stead=20
of the other way around.

Otherwise your patch looks good to me, I think it's a very good option to a=
dd.=20
Please resend with commit message so that Junio can include it.


Simon

--nextPart5138431.danGmDdy0Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIyB2lWXvMThJCpvIRAmK1AKD06qNan2YOvF3mA1nGWVz+aV0HOgCeN6bJ
wjAIvUbpStE5HgSh6U76AJI=
=F9nS
-----END PGP SIGNATURE-----

--nextPart5138431.danGmDdy0Z--
