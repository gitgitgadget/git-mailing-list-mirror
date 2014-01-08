From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: Re: [PATCH] merge: make merge state available to prepare-commit-msg hook
Date: Wed, 8 Jan 2014 20:21:25 +0000
Message-ID: <B19C65C1-C2D9-486F-AEA7-1497A3B5C5B4@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com> <DA9E6645-82DC-4714-845F-423726F96A40@yaauie.com> <vpqr48ip7bm.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_63C9C168-F4EE-4239-AD21-F0B554312929"; protocol="application/pgp-signature"; micalg=pgp-sha512
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 08 21:27:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ziY-0006DE-3g
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 21:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbaAHU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 15:27:06 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:57963 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbaAHU1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 15:27:04 -0500
Received: by mail-ig0-f174.google.com with SMTP id hk11so14140500igb.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 12:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:message-id:references:to;
        bh=SW58QTz947RD2clrijZrgGopIRt7k0UF5lJTZGAlPIg=;
        b=hcDE2ZV3xUT0kKZ92YK5lWr8kGp+nz6/QaRH9OZya6TSBdxPQkVg2UDVgZbRVHqA6H
         nVrrwQKV6qLtBodXLdRkKV3m3seqN9eLfgl5o2k/hjXSzdtzP6j9xia/Liyl+i74j09Y
         Zgv0F+k2CgsBfNWVunMmatE7kWt2Uqw1XIP8LnKRdPGN3z6femQTKj1kJF0qprBXOyMx
         e0I4EL8DY+2YGQpZOzFGy4aTWD/odT5JFaLuwgFzzNSbkKZWZEllKR8JSwSIgDjXhwxy
         n+wfmzocF2ZO360b6wfeJHtXJMoTBXsv962n6DUfwFJJ62y88e/QgJpb7ayxoCTN/3OA
         jTag==
X-Gm-Message-State: ALoCoQkG0ZARada2BUi5f6h+vRMXTgRrsZMQ/mRsr7uzv1Q6orecy/7lcivm5vs/19yp0N9lJZzG
X-Received: by 10.43.19.66 with SMTP id qj2mr62962675icb.31.1389212489992;
        Wed, 08 Jan 2014 12:21:29 -0800 (PST)
Received: from [10.40.8.139] ([69.164.175.238])
        by mx.google.com with ESMTPSA id kt2sm10637562igb.1.2014.01.08.12.21.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 12:21:27 -0800 (PST)
In-Reply-To: <vpqr48ip7bm.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240225>


--Apple-Mail=_63C9C168-F4EE-4239-AD21-F0B554312929
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 2014-01-08, at 20:06Z, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> =
wrote:

> Ryan Biesemeyer <ryan@yaauie.com> writes:
>=20
>> index 3573751..89cdfe8 100755
>> --- a/t/t7505-prepare-commit-msg-hook.sh
>> +++ b/t/t7505-prepare-commit-msg-hook.sh
>> @@ -181,5 +181,27 @@ test_expect_success 'with failing hook (merge)' =
'
>> 	test_must_fail git merge other
>>=20
>> '
>> +git merge --abort # cleanup, since the merge failed.
>=20
> Please, avoid having code outside a test_expect_* (see t/README, " - =
Put
> all code inside test_expect_success and other assertions.").

In this case it was not immediately clear to me how to add cleanup to an =
existing
test that dirtied the state of the test repository by leaving behind an =
in-progress
merge. I see `test_cleanup` defined in the test lib & related functions, =
but see no
examples of its use in the test suites. Could you advise?=20

>=20
>> +test_expect_success 'should have MERGE_HEAD (merge)' '
>> +
>> +	git checkout -B other HEAD@{1} &&
>> +	echo "more" >> file &&
>> +	git add file &&
>> +	rm -f "$HOOK" &&
>> +	git commit -m other &&
>> +	git checkout - &&
>> +	write_script "$HOOK" <<-EOF
>> +	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
>> +		exit 0
>> +	else
>> +		exit 1
>> +	fi
>> +	EOF
>=20
> I think you lack one && for the write_script line.

Good catch.

> There's another instance in the same file (probably where you got it
> from), you should add this to your patch series:

I'm new to the mailing-list patch submission process; how would I go =
about adding it?
Submit the cover-letter & patches again? Squash your commit into the =
relevant one of
mine?

> =46rom c3d754a2a16d98b31d43a7e45973821ae8adc043 Mon Sep 17 00:00:00 =
2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Wed, 8 Jan 2014 21:03:27 +0100
> Subject: [PATCH] t7505: add missing &&
>=20
> ---
> t/t7505-prepare-commit-msg-hook.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t7505-prepare-commit-msg-hook.sh =
b/t/t7505-prepare-commit-msg-hook.sh
> index 3573751..1c95652 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -174,7 +174,7 @@ test_expect_success 'with failing hook (merge)' '
> 	git add file &&
> 	rm -f "$HOOK" &&
> 	git commit -m other &&
> -	write_script "$HOOK" <<-EOF
> +	write_script "$HOOK" <<-EOF &&
> 	exit 1
> 	EOF
> 	git checkout - &&
> --=20
> 1.8.5.rc3.4.g8bd3721
>=20
> (a quick "git grep write_script" seems to show a lot of other =
instances,
> but no time to dig this now sorry)
>=20
> --=20
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

Thanks for the review.

--
Ryan Biesemeyer (@yaauie)


--Apple-Mail=_63C9C168-F4EE-4239-AD21-F0B554312929
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJSzbNFAAoJENsKO4td9bkLBfIP/30GtdlVf2hCgeQeuCBIS80A
66bjRmvpbpRzHxDtoNlwrZOt0JMX4z5nQJo5DKtc4n2nsTW3Xw89XT1CT0nS8W3c
VROiIzv2JGbeR5z9sJjmDqzw07H/yZrkpcyksxmv5LmvgGP6GZrNCSL1uadKgsJ3
Q2buoHc4RzbKRb7z4NQBOtLc45qQsPt0wWHRo/imnUoExVwT2iFVxp8XU4t4CciI
wlLrz+9frlk/EJqL2iVgsz19bg0Sk/PBBcwprnjtx5hcL8LwJtxRJ/SEp6D0/y6D
JCgX6u608zm44D5r8UaavEsTUpQPjhmNn+yeYjUTyEK/YSPZAcRd5XN7C6zamX3z
CX8a1WXohnlrD9cpnmXU1T64GsSxSdsXefz7xohBru1buG4DZ9BcW27HfYRFJXlR
hSCxALyhgsTjPxFtEX0bXS9komsbcxtxDYviYE7kDx8CP5gAMn9iOOBgEXy3VhSQ
gZyxxx/T2gB7ZIdSOK0WqPpV4MHFJ25iDEi3VHZwDaAIKxOJ/IiWx7arhA26+1oM
EgKHHEPlT0UPg7yYtwtZSOrzfZO/OinbyfIeEwNPAd1ULfwgzoAzQ2lOxF1BrCFX
+R0IdOaB4oZdMFuC2Bxqee3DVjUXShy+BkOps0lqNSNZNf6zHYgKGd+vH3Ec1mgH
VGLQnG9ZWR1dwuy0UHhZ
=k8t2
-----END PGP SIGNATURE-----

--Apple-Mail=_63C9C168-F4EE-4239-AD21-F0B554312929--
