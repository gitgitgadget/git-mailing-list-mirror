From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 0/2] git diff -q option removal
Date: Wed, 17 Jul 2013 22:05:07 +0200
Message-ID: <51E6F8F3.6020404@googlemail.com>
References: <20130714220739.GC13444@google.com> <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com> <7vvc496ruf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9C9DADB8A40B00D2DBEB6BA4"
Cc: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 22:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzXyc-0002ch-G1
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 22:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933379Ab3GQUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 16:05:10 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:35672 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab3GQUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 16:05:09 -0400
Received: by mail-we0-f169.google.com with SMTP id n57so2229189wev.14
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=LabMr8q+gifqODxxEyIJ4gzBbXcGFBB1DlLyztent5c=;
        b=lc2tF4k+dlfCtUa5KxDZAy8PYp6FWTHXwehJDyfK96kRELBb5YUZAU++nls6ky66Vg
         lyf0htVSU5ZGm/RTYwew2liSaw8c2afYGHuiu13nLu/9EnINVWA2ksPYc6dNtC+p4Wb4
         l9p3Gx8/en8TFCrcxG4fgv20lny/ES6uYq9nr7TaJhnq6MKEMTDf/+00Wl1z3hZw0u2B
         L2Qd+fFtzU8iQLQNeLqqU/lo/GceCoLa6+bYewyDJYzQ1r1EbadPwuQaB0uTpPBYAgrj
         al/AeHnS7KwfRtKdCYUqNCv4uGRs3D4pRg32Zz1sRodtpYMH1H3v/Pf9gFfLvq2wHuTy
         ghSQ==
X-Received: by 10.180.182.200 with SMTP id eg8mr10278580wic.23.1374091507738;
        Wed, 17 Jul 2013 13:05:07 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id ev19sm12055848wid.2.2013.07.17.13.05.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 13:05:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230646>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C9DADB8A40B00D2DBEB6BA4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/17/2013 07:04 PM, Junio C Hamano wrote:

> Builtins link all sorts of stuff from outside, e.g. diff.c and
> diffcore-*.c at the toplevel.  I do not see diff_no_index.c is any
> different, so I am probably not understanding your question.

Thanks for the explanation. I am not yet very used to gits code structure=
=2E So I sometimes think of 'how would I structure things', so I
was confused of things in builtin using some parts outside of it.
Maybe that folder raised to much expectations for me to be 'the real'
core, whereas the files outside, i.e. those files in the top level
directory, are just there for other things or scripts.
This understanding of the structure seems obviously wrong now.

Thanks for clarification.

>=20
> Hmm, do you really get that error message?  I think you would get
>=20
>     fatal: ambiguous argument 'no_file': unknown revision or path not i=
n the working tree.
>=20
>> 	echo $?
>> 	1

Ok here we go (using current origin/master 9c3c367):

	cd $(mktemp -d)
	echo "test" > actual_file
	git diff actual_file no_file
	# error: Could not access 'no_file'
	echo $?
	1
=09
	## I get the same message as well, if I'm using -- or not.
	## also the -q doesn't make a change

	git init=20
	git diff -q -- actual_file no_file
	echo $?
	# 0
	git diff  -- actual_file no_file
	echo $?
	# 0
	git diff  actual_file no_file
	# fatal: no_file: no such path in the working tree.
	# Use 'git <command> -- <path>...' to specify paths that do not exist lo=
cally.
	echo $?
	# 128
	git diff -q  actual_file no_file
	# fatal: no_file: no such path in the working tree.
	# Use 'git <command> -- <path>...' to specify paths that do not exist lo=
cally.
	echo $?
	128

So apparently git diff behaves differently if not in a repo, which is wha=
t I tested.

>=20
> The command line parsing infrastructure has changed vastly since
> "show-diff" days (see below for a history lesson);

A very interesting read, much appreciated. :)

>=20
> If we wanted to make "-q" follow the spirit of its original addition
> to "show-diff" again, we could internally add a diff-filter when the
> "-q" option is parsed.
>=20

I'm rather new to the project, so my opinion may not have much weight,
I'll state it anyway:
Keeping backwards compatibility is really hard, because you need the=20
knowledge of such history lessons as read above, to understand what shoul=
d
happen, like having an intuitive feeling about such parameters. Hence
maintaining/evolving the project will become harder and harder=20
(specially for newcomers). So having one and only one way to achieve the =
desired
output, which fits into the greater structure as it's the case with --dif=
f-filter
is easier to remember for both the user and developers.

Hence I think keeping the -q option would only make sense for the plumber=
=20
layer, because there the explicit promise was given to not change stuff
every other release.=20

Stefan




--------------enig9C9DADB8A40B00D2DBEB6BA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR5vjzAAoJEJQCPTzLflhq5hEQAMsgm4MBBgr2RW4In1+632lt
qnIUT3qamSg+l9TwIQ6xuQUoXjSGBfZ8gB/BmhhrwH5bIbIjrumUYfCz82lWVYJ4
OQ2vkkJE5rIgSKxuL+ZAaH2UWA2pqwAFe8oXWoFfS71ZwMTNVKXVXLQvbTLu1wTi
4RNIoaXrHATbX8jdVrjVyPZj4EcHeTyEMe6qFrqOVl1Bi12Iqcc2/jJTQcF5vX07
2S/FPmCzpXOmwXbJwyb3XQ0F37DiVciOFWzKvd2RcxcN+uQ+utXWjLLGdxit23/L
1W97uPKp+5xb50vumN5xkvnN6e5PapWisg+gNuM3er7gzfzsv7dWkCW1BCKOdM2K
mRfOcrYtcbhocbP/bmdj2hxbFUOcDjIowpLGJsPuSGEskJH9RyAAgGwJ/GVZiiRR
WDQiGp0LtlF/dp4rGsJPgUr+G/E9C0bxp01Qwy5a/lExwQUpaU0lzYOyKQRQ6qfU
O2TFbAAdOMWEwIR65c+/L7GDkokNjv+pnUmS/wsmj8AeCMwFs0Y3K9N4sNJUS8Mq
k4N3uzSVqFSbIgFizFbsi7bZVBWZ/0ysdiTh0GExkUtg2aVcEHsqLYubMbODS1Ye
wQB0estygYXoRhrhT3839AFdq4xmRqoHgyT1l/0ej8uFyDHPuF5Y/RHoUj49Ga51
XmhWK0HRzqS6FICvwLD1
=9xv+
-----END PGP SIGNATURE-----

--------------enig9C9DADB8A40B00D2DBEB6BA4--
