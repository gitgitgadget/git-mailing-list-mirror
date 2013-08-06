From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCHv3 0/9] Removing deprecated parsing macros
Date: Tue, 06 Aug 2013 15:02:14 +0200
Message-ID: <5200F3D6.5040004@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com> <7v4nb3iaqb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig47D25842B049ED14685800AB"
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 15:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6gu8-0006NT-N8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 15:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab3HFNCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 09:02:18 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:45067 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab3HFNCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 09:02:17 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so209599eaj.11
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=96DJ4ruudGB9PmxBVkDtIXoAwfWRyIgANS26yYtVb0Q=;
        b=tYOmWzrdSwIsCLEPYtKRiNN4eYbk6XEmgSngRpXX97nNxqsaq0FXi0lWnZXof4MpL/
         Stzw2hrfZ7UNUM7WWp2raxiPLCCceEgR58SaipG2yH1Bzhe/o+pJcoq/3WThe4p0KVIq
         LBpH7RbHqflQWn2ap0+zyUkJ8VZQeRY6v3+dUze3CiUV6qdEbIihVahjrcbxz+FIzlEd
         BPMHN1nv2duvwVna/51MhyqGaonHz5VcxhRGyTClq3AwbAWPV219kUzI4qwBl5pGuqN4
         FtB5uLWcFpnT7jxgIbJtuqR4Pt4TlPCU9FLKfF4X4a+hjXkBVw7fGdBmpVU2tfFmFAwQ
         BdGQ==
X-Received: by 10.14.104.130 with SMTP id i2mr1090863eeg.120.1375794135923;
        Tue, 06 Aug 2013 06:02:15 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n48sm2065342eeg.17.2013.08.06.06.02.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 06:02:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v4nb3iaqb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231737>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig47D25842B049ED14685800AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/06/2013 08:39 AM, Junio C Hamano wrote:
> Thanks.  Queued this at the tip of 'pu'.  There seem to be some
> fallouts found in the test suite, though.
>=20

Thanks. I am sorry for forgetting 'make test' before sending patches.
And the test suite is correct.

e35ea450 (branch, commit, name-rev: ease up boolean conditions)
is faulty. In builtin/branch.c the variables 'delete' and 'rename'=20
are not used as a true boolean but I assumed so.=20
These are parsed in via OPT_BIT and depending if you pass -d or -D=20
for deletion you have value 1 or 2 in delete.

Hence this change is incorrect:
-	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!=
unset_upstream > 1)
+	if (delete + rename + force_create + list + unset_upstream +
+	    !!new_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);

The current patch e35ea450 ([PATCHv3 5/9] branch, commit, name-rev: ease =
up boolean conditions)
can be dropped/reverted and I'll resend it. (The order doesn't matter,=20
you can just drop that commit and apply the resend version on top of=20
origin/sb/parseopt-boolean-removal

Stefan




--------------enig47D25842B049ED14685800AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAPPWAAoJEJQCPTzLflhqjfgP/Rf6HT+0dYd9aSoivHRJwHfq
fexgLjDHCqrv2W2i0sfz59n3w2FY0bVze+LxGoV9rl78LGhunVSfe6A+MzloHkrH
wK2eZP82T/9TRYlQaHKWmiVSyFxQnGnNCPcwwN910z4/7E5fVr2z4fOK5VcQtraM
nM1/Yj0rCljkFqtgWGO5xTbl2mNUIGa6kQu1SpoIx1nThcsgpmb7O7T15R5chFsh
FPwq/YyfkoP4kANjyCAS1LJw0gUvGifg3AWxzT4FZ67NftlK3B9bDMP33o2CQdLo
tHURnfC//63H2t2aZAAnso70QFWomfux1s0HingE4oMiWar+ArqzySOTMZ1FUc50
1+XSTq0k/TpZuxJBWP29Xb2TEqfDs9fnnwon9uIBxKFup13nuJDGiqfM4LuGByry
ez+spttPP/BwLU7oeFEI3Z2Smy3ioW/uslJOPzmZixXXJhUIVvByi5pUFlgPRMf4
8MWnF3PaAcC/SgrSPA6CCMpqSqXalK6AijIBaj2410m31QjakrsnyEEMPu5mQJrl
N+lqHCLoFWffVy/3y0ZDigVc3Wvkf0llinCzH78+it3lStCbbP/A+mxdz1SZroyc
j6Xly3USU7FCvHxIc1pXxPTP/38nJXEUvoJUcYIScXZG1AQ8FRtTPsO5CvBi6fsU
reaeCSo2Bj0P2+GBrC5B
=alg9
-----END PGP SIGNATURE-----

--------------enig47D25842B049ED14685800AB--
