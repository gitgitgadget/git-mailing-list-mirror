From: Andy Parkins <andyparkins@gmail.com>
Subject: Signed git-tag doesn't find default key
Date: Fri, 20 Oct 2006 10:04:17 +0100
Message-ID: <200610201004.17263.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1854979.nKghs3WUzX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 20 11:04:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaqIm-0005Tl-3D
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 11:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWJTJEY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 05:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWJTJEY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 05:04:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:21145 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932219AbWJTJEX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 05:04:23 -0400
Received: by ug-out-1314.google.com with SMTP id o38so698280ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 02:04:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=ky1FqDjJD94riyYeTw4UAbsOAVQ5vjp0VqTXz28GzS3gGxa0U2cui+Q3CZw76BgJ0d5eNmACZDddvQlcAGUTVpeuoA9rx0wi8RCjE+pWa8scY5Rozi2i1RSClkKPr2u/hXmXnUMFarJi6nb6whJETQMqMQHRMyXrlnqgYxPd8wA=
Received: by 10.66.222.9 with SMTP id u9mr1544281ugg;
        Fri, 20 Oct 2006 02:04:21 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id j1sm3556840ugf.2006.10.20.02.04.20;
        Fri, 20 Oct 2006 02:04:20 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29425>

--nextPart1854979.nKghs3WUzX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I did this:

$ git tag -s adp-sign-tag
gpg: skipped "Andy Parkins <andyparkins@gmail.com>": secret key not availab=
le
gpg: signing failed: secret key not available
failed to sign the tag with GPG.

I believe the problem is that I have used the comment field in my key's UID=
=20
definition.

$ gpg --list-keys andy
pub   1024D/4F712F6D 2003-08-14
uid                  Andy Parkins (Google) <andyparkins@gmail.com>

So when git-tag looks for "Andy Parkins <andyparkins@gmail.com>"; it's not=
=20
found.  The answer is (I think) to search only on the email address when=20
looking for a key.  I've simply changed git-tag to have

username=3D$(git-repo-config user.email)

However, this is clearly wrong as what it actually wants is the committer=20
email.  Am I safe to simply process the $tagger variable to extract it?



Andy
=2D-=20
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

--nextPart1854979.nKghs3WUzX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFOJERwQJ9gE9xL20RAsu7AJ9O1w71nRwq3F/pey2tb3yuBjhcnQCdEtdc
nRhAvJiyvlfay0q15Lwrmpw=
=VLaw
-----END PGP SIGNATURE-----

--nextPart1854979.nKghs3WUzX--
