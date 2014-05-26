From: Caleb Thompson <cjaysson@gmail.com>
Subject: Re: [PATCH v3 0/5] commit: support commit.verbose and --no-verbose
Date: Mon, 26 May 2014 17:40:15 -0500
Message-ID: <20140526224015.GA99174@sirius.att.net>
References: <20140525062427.GA94219@sirius.att.net>
 <1401130586-93105-1-git-send-email-caleb@calebthompson.io>
 <20140526223420.GB20637@hudson.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 00:40:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3ZA-00087x-Px
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbaEZWkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:40:20 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:41288 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaEZWkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:40:19 -0400
Received: by mail-ig0-f177.google.com with SMTP id l13so415341iga.10
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RulTktNJSjRT/sNXj48E4x68XT+RQ2C/41GBuI9H6TQ=;
        b=Rrw+w1ljM72qChyf53KOrYGYz0EEuzLI0boSrMh8UqhyPjNU4r1HJhNWxKkKWBte/2
         ZI0u/i/y5MgsP8ZCAWuADnqWqLC5A9RmWnDSmD6swEBw0PE9eNcdYSsFr+OtdNq6CSd/
         ZrUe7rkQh1iz6xMpNK+X4zyrRX5FFSuowL0vZZxN0XEEKInH/udssJKR+9n/Q9j+k/6/
         EPUhhWgChmvbU3dZPPq/CiWlVxSpKKdHRnjsORFM/+WGC9S3eEBcJ+GYzkgtD5/8gPiQ
         JB447fmHz1SiJvadcPbwmsC01fDfel/xDU5SqPDlvY42zr9Cm7H2Sy87Sit55xjaNx3o
         W23w==
X-Received: by 10.50.57.11 with SMTP id e11mr28953853igq.3.1401144018403;
        Mon, 26 May 2014 15:40:18 -0700 (PDT)
Received: from localhost ([2602:306:bd82:c710:189c:3425:edac:f018])
        by mx.google.com with ESMTPSA id j13sm2980903igf.11.2014.05.26.15.40.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140526223420.GB20637@hudson.localdomain>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250132>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Great, thanks Jeremiah!

I made that change, and will send up another patch version in the next day =
or so
while I wait on others who may have input.

I'm really appreciative of everyone's feedback!

Caleb

------------------------------------>8----------------------------------

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b9eb317..88de624 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -53,7 +53,7 @@ test_expect_success 'verbose diff is stripped out (mnemon=
icprefix)' '
        check_message message
 '
=20
-test_expect_success 'commit shows verbose diff with set commit.verbose=3Dt=
rue' '
+test_expect_success 'commit shows verbose diff with commit.verbose true' '
        echo morecontent >>file &&
        git add file &&
        test_config commit.verbose true &&
@@ -61,7 +61,7 @@ test_expect_success 'commit shows verbose diff with set c=
ommit.verbose=3Dtrue' '
        git commit --amend
 '
=20
-test_expect_success 'commit --verbose overrides verbose=3Dfalse' '
+test_expect_success 'commit --verbose overrides commit.verbose false' '
        echo evenmorecontent >>file &&
        git add file &&
        test_config commit.verbose false  &&
@@ -69,7 +69,7 @@ test_expect_success 'commit --verbose overrides verbose=
=3Dfalse' '
        git commit --amend --verbose
 '
=20
-test_expect_success 'commit does not show verbose diff with commit.verbose=
=3Dfalse' '
+test_expect_success 'commit does not show verbose diff with commit.verbose=
 false' '
        echo evenmorecontent >>file &&
        git add file &&
        test_config commit.verbose false &&
@@ -77,7 +77,7 @@ test_expect_success 'commit does not show verbose diff wi=
th commit.verbose=3Dfalse
        git commit --amend
 '
=20
-test_expect_success 'commit --no-verbose overrides commit.verbose=3Dtrue' '
+test_expect_success 'commit --no-verbose overrides commit.verbose true' '
        echo evenmorecontent >>file &&
        git add file &&
        test_config commit.verbose true &&


On Mon, May 26, 2014 at 03:34:20PM -0700, Jeremiah Mahler wrote:
> Caleb,
>=20
> On Mon, May 26, 2014 at 01:56:21PM -0500, Caleb Thompson wrote:
> > This patch allows people to set commit.verbose to implicitly send
> > --verbose to git-commit. It also introduces --no-verbose to
> > override the configuration setting.
> >=20
> > This version incorporates changes suggested by Eric Sunshine, Duy
> > Nguyen, and Jeremiah Mahler.
> >=20
> ...
> >=20
>=20
> Other than the minor style issue I pointed out in another email, it looks
> good, and the patch set works properly on my machine.
>=20
> --=20
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTg8LPAAoJEBYhrcKgrOcKdg8H/2UkkqIOofC8k/9gI5QsicW7
GEAMwtc0U7fqtMBJyNKGygFm8c7SSLQ0YrR85DjoE24KZpPZ9n2I4o1UZnYGPlbs
Z1/qjaMyPG4NZit15Wyx1ufBiQYnbuLfmyKLxz//qFfuLMjZy2NyzBH417nS0VD9
vsytK9Jt9r/ZCS+rmwQMltyMH7wfHp6cAw4nBtVwm6AlDG0Y+EBcYjBIxjZvSH1p
3qs3LZKGfdD2SrH6KK4QBbnulG2ZuvMDIpPqRBJE9gPEEo5G98jnKPwtRHBixvst
vuXlzuk0BXhstqxY35Qa6OrrS46REEyXOWCt7IfV7ad4aexvcANSCBksPTqWNpg=
=fNbQ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
