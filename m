From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Dokumenting api-paths.txt
Date: Tue, 20 Aug 2013 23:40:16 +0200
Message-ID: <5213E240.9080106@googlemail.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com> <1376954619-24314-1-git-send-email-stefanbeller@googlemail.com> <52136F9C.6030308@kdbg.org> <5213DE72.3000308@googlemail.com> <20130820213452.GI4110@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61AE04A22070872AC5FF91EA"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 23:40:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBtf5-0004oG-RZ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 23:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab3HTVkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 17:40:17 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:33875 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3HTVkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 17:40:16 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so459278eak.18
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=LNUNcQiiMYW3QGJ0yQL9TMuSMzVmyS9svxAqzPAcWOs=;
        b=s0w31OGIJZHUC7Ow+1mS0bAk3qCygEx04RfnP13Kf3VR+CfHc10llgTYnhnjCEqSSF
         184F9hT91cxbmxO55LfHuiX4VLJxVNKz0CoIysLZnkoB9l/j7v8vi3aDphtLZCN7oXDM
         aiUc+Otwsb7ve43ztoqUpF6cA4KQbIBeekktf3GAhfvZFJIKzQjnhm18INrnbz5HqUWS
         gijoXuLmqOYjJreDsvCpc938RMIddFSBT6ko/D7oYSrhdYXa9+W8iDA0HRBcwwT3Yh4U
         xEdz/Zi6KIZszLJ+576kR/oFTyL9e5i9zt65cEd8RiO3xITd9goChbsqhNwYL1HzsUkK
         Zmww==
X-Received: by 10.14.122.132 with SMTP id t4mr4717590eeh.20.1377034814750;
        Tue, 20 Aug 2013 14:40:14 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm4999696eex.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 14:40:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <20130820213452.GI4110@google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232650>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61AE04A22070872AC5FF91EA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 11:34 PM, Jonathan Nieder wrote:
> Stefan Beller wrote:
>> On 08/20/2013 03:31 PM, Johannes Sixt wrote:
>=20
>>>> +    packdir =3D mkpathdup("%s/pack", get_object_directory());
>>>> +    packtmp =3D mkpathdup("%s/.tmp-%d-pack", packdir, getpid());
>>>
>>> Should this not be
>>>
>>>     packdir =3D xstrdup(git_path("pack"));
>>>     packtmp =3D xstrdup(git_path("pack/.tmp-%d-pack", getpid()));
>>
>> Just a question for documentational purpose. ;)
>> Am I right suggesting the following:
>>
>> `mkpathdup`::
>> 	Use parameters to build the path on the filesystem,
>> 	i.e. create required folders and then return a duplicate
>> 	of that path. The caller is responsible to free the memory
>=20
> Right.  mkpathdup is basically just mkpath composed with xstrdup,
> except that it avoids stomping on mkpath's buffers.
>=20
> The corresponding almost-shortcut for xstrdup(git_path(s)) is
> git_pathdup(s).  But that's a minor detail.
>=20
> Maybe a new Documentation/technical/api-paths.txt is in order.
>=20
> Thanks,
> Jonathan
>=20

Is there a way to create a path, without being using git_path?
git_path seems to imply adding .git.

So if I have=20
	packdir =3D xstrdup(git_path("pack"));
	...
	path =3D git_path("%s/%s", packdir, filename)

This produces something as:
=2Egit/.git/objects/pack/.tmp-13199-pack-c59c5758ef159b272f6ab10cb9fadee4=
43966e71.idx
definitely having one .git too much.

Also interesting to add would be that git_path operates in the
=2Egit/objects directory?

Thanks,
Stefan


--------------enig61AE04A22070872AC5FF91EA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE+JAAAoJEJQCPTzLflhqkg0P/2hwj8PR2QwtREJPbkWVzk7U
vOoGXHf5WW0lV4EiJLAfVcbh6c24oCIo263vBDVfYiWRR25Dw6PsOcy8MPjKE210
Iek4+1wZYFjUTw6slDgtWvKDvW63pAYM4awbhAougAb1PoQHzElyyWFVUn1uoefA
BrdAXHYYjz07uH1U9YACUZDGr45Omd7l+SW5FAlvz2e48Gwj1EGszHixLe7q6PLf
zprwVTrQb2GbEjGjZFrpBFMsOyfWJvtfXTjzS+gLHuIZXEjlfv/9+EGj7xRqn3pS
b1HPsYv/DgcFm5fkiytBucschs6NzzULyYtx+SRLqJUnwEZuTUPJR0GyrK/JCGhs
o1rrRGpqXmXBsN6yUTvCPyIgn2NW3yRu02XdGCs9O1zBvxh7Ly7TBGNiIfBNhr4R
UWWIG/HHcqtaflhpLnQo63ZdWPiZmgKFPqTU1VjNBVzqKgvcKEFfX8v4xL/4/DfM
XwJZA/c+FYlbhGzyc21yMdqSZEhU3nKVOcJdNBT1Lcd6P9+kXY0Vj3PY2vk70lCv
73nUdMK8uienJDezD5wzbRwKnl7X6WNX1QnaA/XQCZVMYHfrsMkcJYCdG31rQcC0
AYOpzNF+r1BHnxVaGFcoLFMCsTphX8cWxdE9iUBXh+pKhxdPJXBqAc7q2rBHBorf
FZ1sq4jyx5v/gLOc0+AC
=c5c7
-----END PGP SIGNATURE-----

--------------enig61AE04A22070872AC5FF91EA--
