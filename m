From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 09/10] fast-export: add support to delete refs
Date: Thu, 31 Oct 2013 20:47:25 +0100
Message-ID: <78D9AAB6-09EC-4E81-A7BE-D36B9A9869D1@quendi.de>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com> <1383212197-14259-8-git-send-email-felipe.contreras@gmail.com> <6F276334-DFDB-40B8-8B24-38FFB6DBED9B@quendi.de> <CAMP44s3vxfN5Wc+S+VjimisUgZGQMzR7Z2YkO8J4UEk7+cPy_Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DF32B98C-4086-4977-A468-B10ECCAE6C06"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:47:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyDQ-0004Yk-1G
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab3JaTrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:47:32 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41511 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753887Ab3JaTrb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 15:47:31 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VbyDK-0005QY-1v; Thu, 31 Oct 2013 20:47:30 +0100
In-Reply-To: <CAMP44s3vxfN5Wc+S+VjimisUgZGQMzR7Z2YkO8J4UEk7+cPy_Q@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383248851;f481971a;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237170>


--Apple-Mail=_DF32B98C-4086-4977-A468-B10ECCAE6C06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 20:41, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> On Thu, Oct 31, 2013 at 1:29 PM, Max Horn <max@quendi.de> wrote:
>> Actually, I just noticed one thing that I *do* have a question about:
>>=20
>> On 31.10.2013, at 10:36, Felipe Contreras =
<felipe.contreras@gmail.com> wrote:
>>=20
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>> builtin/fast-export.c  | 14 ++++++++++++++
>>> t/t9350-fast-export.sh | 11 +++++++++++
>>> 2 files changed, 25 insertions(+)
>>>=20
>>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>>> index b6f623e..8ed41b4 100644
>>> --- a/builtin/fast-export.c
>>> +++ b/builtin/fast-export.c
>>> @@ -673,6 +673,19 @@ static void import_marks(char *input_file)
>>>      fclose(f);
>>> }
>>>=20
>>> +static void handle_deletes(void)
>>> +{
>>> +     int i;
>>> +     for (i =3D 0; i < refspecs_nr; i++) {
>>> +             struct refspec *refspec =3D &refspecs[i];
>>> +             if (*refspec->src)
>>> +                     continue;
>>> +
>>> +             printf("reset %s\nfrom %s\n\n",
>>> +                             refspec->dst, sha1_to_hex(null_sha1));
>>=20
>> If I understand it right, this issues a "reset" command in the =
fast-import stream, resetting a ref to an all-zero SHA1. I had a look at =
the git-fast-import documentation, but I found that it does not =
explicitly cover this case. In particular, the "reset" command does not =
specify that an all-zero SHA1 should be treated as "delete this ref".
>=20
> That's what the previous patch does.

Right *facepalm*.

But then this should be documented in git-fast-import.txt, shouldn't it?

>=20
>> On the other hand, the docs for "reset" seem to indicate that one can =
omit the "from" part, although I couldn't tell for sure what that would =
mean, either.
>=20
> It means something different.

Yeah, I figured that -- just wanted to point out that this, too, is not =
very clear in the documentation and should be improved (not saying that =
I expect you to do that, just pointing it out).


--Apple-Mail=_DF32B98C-4086-4977-A468-B10ECCAE6C06
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJys9EACgkQIpJVslrhe1kZAQEAyUH8wyD5UOVfmeOzkkq91JTJ
HbBCm0BtxM6StLB5SoQA+wftpElDzC7kM9DsydMhlHjKxtohN12Ap1lKJUcDHAtw
=Ua05
-----END PGP SIGNATURE-----

--Apple-Mail=_DF32B98C-4086-4977-A468-B10ECCAE6C06--
