From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Tue, 10 Mar 2015 22:29:08 +0000
Message-ID: <20150310222907.GA36141@vauxhall.crustytoothpaste.net>
References: <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
 <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
 <ABA76895-9BD2-4EA8-B765-0F9DE71A2CEC@cisco.com>
 <3E5DD2BE-1E44-4D0A-89A1-627A1239C72A@cisco.com>
 <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:29:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVSeM-0005aO-8o
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 23:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbbCJW3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 18:29:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50000 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752629AbbCJW3M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 18:29:12 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e0df:a888:a4a7:fd4e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BEDA52808F;
	Tue, 10 Mar 2015 22:29:11 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <E53D99DB-E894-4FA8-9351-39E23FFD677E@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265272>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 06:05:46PM +0000, Dan Langille (dalangil) wrote:
>> We have made progress I think.
>>
>> With stock git:
>>
>> tl;dr: 1 - with a ticket, you get prompted, but hitting ENTER succeeds.
>>       2 - without a ticket, nothing works
>>
>>
>> With patched git:
>>
>> tl;dr: 1 - with a ticket,    entering credentials, SUCCEEDS; just hit en=
ter, failure
>
>If I have a valid ticket, why am I being prompted for credentials?

libcurl won't even attempt authentication if you don't have a username
specified.  I know that the web server should be able to figure it out
=66rom your credentials, so it shouldn't matter what username you provide.
This is an unfortuate quirk of libcurl.

Also, are you using 2.3.0, or one of the earlier patched versions?  That
might affect how it works.

>It appears patched git always wants credentials entered and ignores the
>valid ticket.

So what I think is happening is that you didn't specify a username, but
git got a 401, so it prompted.  Now it actually attempts to use the
password you provided, whereas before it did not.

Does it work with a ticket if you specify a username, as in the
following URL?
https://bmc@git.crustytoothpaste.net/git/bmc/homedir.git
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU/3AzAAoJEL9TXYEfUvaLCYwQALKwRGo1wTLbeNwaq5xODgAx
L0j7hRG32EY61go3m+mNxWvacQmjOnMWfYV1v+rWDGGbu8lFU2s2CdY0bCiavbTk
17l2LlzhtAPjMjQy4xl6qWXtbV4LqWjgx1bp4B0OxzlVNwUBGYEAoitSTpOJ3uQU
Yn9DrWwstP0wzRtXt/Xjyyl8aJE/MNSPw/7UUW+LGNpJORJE9dCzoOAnvb3mgyLW
LJiZXO3pGOUHRBCpWzT2A7c/Sa42h/Pt2BwZ95TytOClSsmSvtsUVUCUN2Xhlbup
Q+xEb45DZVPoflSox407bBLl4i+KwDDDtwIwKr71T3+DD56zmLWHrAQG44k+ssdK
d05fkQtWgHyJa3fX1t2g3kaCT7rPBDKiYxCRworh8ayNxda6WYk4cvzz9bLTmr5K
k/egN2ZgEOX++SFEPfUBCDSUj1w5jAyVz9pLHSScyDml+WUnEdylHRihGgJu8KyG
zzeSiOFu+zicgglcoFvIVOZ49WV6+60F2u96RWoioJlgwmNbRD4WdZv69NvracKI
AHzzIPJifXV6MPb/DQR9lEuXnvhD5e77SIliPUuXMbxEkxec20JknlTkQ/WQjx4M
aaoD/MoPT8rVdu2QWig7e7swsNTDYV5eEr7Nko9mAlPcF7rEO+q/vzo6V0WE3VVb
iUk4HW43Jzhf0O/MWfLi
=OimF
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
