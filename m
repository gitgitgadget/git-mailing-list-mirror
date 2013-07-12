From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 19:47:17 +0200
Message-ID: <51E04125.5040003@googlemail.com>
References: <51E029B9.20108@googlemail.com> <7vppunllzf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0930EB8A463ABC9EC4CF029"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 19:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxhRC-0008PY-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 19:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073Ab3GLRrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 13:47:18 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:37203 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813Ab3GLRrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 13:47:18 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so8313774wes.17
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type;
        bh=TQ13QnWFm7ZjD6PnU3k86EfXN4D4jWzmCEU2hE7WeTo=;
        b=ilnmmuL45cTkFts/gjY4XQF2EJupnl+TzuE5OLyAcsfj6z3QbncPc0WkvVxs+asYg3
         PfAeX13RSwZGirYWZGX+KLDPiFc//onM7hwWWNi/KvGu5Mtbr8LDNpKWps8rcPy9GMr2
         zKH7aXikRQSWcTk8ntFqcGmz/G1C9QjMrv7OgCUOZQpd4rRgcDk0qrE/mYi4fh6pKaeP
         UdMXTuNJIWFos8BRKgy2RIUvS4NdZRGJ0LiZVgVH++d/iMwyYCpVZwhoToNImhZDss6g
         eIL/eRsQy2SXFrY+2FaTlUQjB2xCY12ZUxcFU2hgRvy9qi+CXB3UfgM+uaB0yMTH4+Nf
         ZiXg==
X-Received: by 10.180.39.236 with SMTP id s12mr2328722wik.14.1373651236602;
        Fri, 12 Jul 2013 10:47:16 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id iz8sm4269914wic.3.2013.07.12.10.47.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 10:47:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vppunllzf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230234>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0930EB8A463ABC9EC4CF029
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The commands are exactly as given in the first mail.
(I run it multiple times, and this exact behavior comes up)

I think there is some problem with the capitalisation
of the first (if not all) characters. (Hence the small 'a')

So either check with these example commands yourself, or take my latest
patch for the mailmap to reproduce on real names, please.

On 07/12/2013 07:35 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> Hello,
>>
>> you may have noticed I am currently trying to bring the=20
>> mailmap file of git itself up to date. I noticed
>> some behavior, which I did not expect. Have a look yourself:
>>
>> ---
>> 	# prepare test environment:
>> 	mkdir testmailmap
>> 	cd testmailmap/
>> 	git init
>>
>> 	# do a commit:
>> 	echo "asdf" > test1=20
>> 	git add test1
>> 	git commit -a --author=3D"A <A@example.org>" -m "add test1"
>>
>> 	# commit with same name, but different email=20
>> 	# (different capitalization does the trick already,=20
>> 	# but here I am going to use a different mail)
>> 	echo "asdf" > test2
>> 	git add test2
>> 	git commit -a --author=3D"A <changed_email@example.org>" -m "add test=
2"
>>
>> 	# how do we know it's the same person?
>> 	git shortlog
>> 	A (2):
>> 		  add test1
>> 		  add test2
>=20
> You don't, and it is a long known behaviour.
>=20
>> 	# reports as expected:
>> 	git shortlog -sne
>> 		  1  A <A@example.org>
>> 		  1  A <changed_email@example.org>
>=20
> Yes.
>=20
>> 	# Adding the line to the mailmap should make life easy, so we know
>> 	# it's the same person
>> 	echo "A <A@example.org> <changed_email@example.org>" > .mailmap
>>
>> 	# Come on, I just wanted to have it reported as one person!
>> 	git shortlog -sne
>> 		 1  A <A@example.org>
>> 		 1  A <a@example.org>
>=20
> Err, where does the lowercase a@ come from in the above?  Are we
> missing some steps before we get here?
>=20
>> 	# So let's try another line in the mailmap file, (small 'a')
>> 	echo "A <a@example.org> <changed_email@example.org>" > .mailmap
>=20
> This is ">", not ">>", I presume?  Otherwise changed_email is mapped
> to two destination, no?
>=20
>> 	# We're not there yet?
>> 	git shortlog -sne
>> 		 1  A <A@example.org>
>> 		 1  A <a@example.org>
>=20
> Expected, as long as some hidden set-up you did not describe that
> caused me to say "Err, where does the lowercase a@ come from" is
> there, i.e. one of the two commits is done by <a@example.org>.
>=20
>> 	# Now let's write it rather explicit:=20
>> 	# (essentially just write 2 lines into the mailmap file)
>> 	cat << EOF > .mailmap
>> 	A <a@example.org> <changed_email@example.org>
>> 	A <a@example.org> <A@example.org>
>> 	EOF
>> 		=20
>> 	# works as expected now
>> 	git shortlog -sne
>> 		 2  A <a@example.org>
>=20
> Makes sense.
>=20
>> 	# works as expected now as well
>> 	git shortlog     =20
>> 	A (2):
>> 		  add test1
>> 		  add test2



--------------enigA0930EB8A463ABC9EC4CF029
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR4EElAAoJEJQCPTzLflhqPxsQAK5zwN9pXwS7cF4isAQd4DQq
BGA0Pjdd/t5isp51AaDyfqH9G6RiK4G0a313JUi3LaKdCTjoOfR67LeR0QQivTzm
Kd61A/Udm1ldbr5wOg/80T/nO+35IXMPw/vO5outwgVDSp68uhQiqB6BzHWQ0pES
IA9iiRrai4uupCZtaQVCOy8SfxZmkkfBxEvepYaxN8V4Qg4B8C5rKzajpmSMJImO
SzvneGAOH46T3qb4+K6AfE1Kl15IGeg68Ctspdr9Ck1Ijmxwu5bkZGF4/6mAU6PE
wjQgcKTS026+SPd2wcIX6Hv+EBSuvRrfIF0VPJb+cEjveHTnGUk98roM8LvL63gJ
eyZib/I7AoDq3uV857dnAeiWS6uTRCaBoQeqsOlj2hnSsxXtivs9Wm+ZzUXsofTK
3uBjfkKkm3nJEAcFcHgTrQxMHWIBS4N3a4xZUDM9eB54svMIpFTwOHdy8cwM49lU
lHdmWcGJJJE/d9NgotSJsV5P7QfXxbg2S+it16GZgv/mryLRYGe6rWudDA+6X4Hq
dnghY3wKjuTvX3YkU09T1B2+7/qpCdjVU4UFXIzQfM7gVxZXEQJ21iT7ORdmA54F
HgMuSXYthn63qNPeKE46Zk8DAKVqhJtbXn3uMm79q5fzWzZbPrj/Ft7AY9DWtR34
d4O3T3O3s3TZ4qaZYq6C
=bxex
-----END PGP SIGNATURE-----

--------------enigA0930EB8A463ABC9EC4CF029--
