From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3703, t4208: add test cases for magic pathspec
Date: Sun, 08 May 2011 10:59:18 -0700
Message-ID: <7v7ha1t6o9.fsf@alter.siamese.dyndns.org>
References: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
 <1304852906-29272-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 19:59:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ8GW-0007mR-Ku
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 19:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab1EHR7b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 13:59:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab1EHR7b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 13:59:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 569924FE3;
	Sun,  8 May 2011 14:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P3VyGqi04xOQ
	kdiLncAjvx2l/3E=; b=h4bO4lZQK6L+F1SuxbNPg5PybCQJktU/fBO/9vnRBDcC
	Bnq/oiTc3a8+bQgwaRUcSAJ98aY8K7fkKF1RPKmJ9W9Mjz8+t8pbRtywhtd7ioyo
	s0v3NgSXoTrlHhEPyERO/3a4U4v4UuTT3n1jV1HNywkgCYpw6YHBg1wwOcgePjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zsg4U5
	kjF6hC070h5NwJHp5hwlOGxQxRZx8c8I8fwslb9lEbaw/udV565cI899buH3u1dw
	1AGgpyuld+EfjIZ0+kdRbUfK0Y2CcMd99i4Na10L8S4vCLMDJDtTGGUrS3EGTdhC
	rK/DcnfnY7uOreyJ/9whUN26Qi2iUPQwJIlxY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 114044FE2;
	Sun,  8 May 2011 14:01:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7AEE94FDD; Sun,  8 May 2011
 14:01:25 -0400 (EDT)
In-Reply-To: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 May
 2011 18:08:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33F75BF8-799D-11E0-9F62-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173167>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathsp=
ec.sh
> new file mode 100755
> index 0000000..3d8c6b8
> --- /dev/null
> +++ b/t/t3703-add-magic-pathspec.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +
> +test_description=3D'magic pathspec tests using git-add'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	mkdir sub anothersub &&
> +	: >sub/foo &&
> +	: >anothersub/foo
> +'
> +
> +test_expect_failure 'colon alone magic can only used alone' '
> +	test_must_fail git add -n sub/foo : &&
> +	test_must_fail git add -n : sub/foo
> +'

I don't care too much about this case (it is a user error), but if you
promise you will turn this expect-failure to expect-success in a follow=
-up
patch, why not ;-)?

> +cat >expected <<EOF
> +add 'anothersub/foo'
> +add 'expected'
> +add 'sub/actual'
> +add 'sub/foo'
> +EOF
> +
> +test_expect_success 'add :' '
> +	(cd sub && git add -n : >actual) &&
> +	test_cmp expected sub/actual
> +'

Shouldn't

	$ git anycmd :

be equivalent to

	$ (cd $(git rev-parse --show-cdup)/. && git anycmd)

for any command?  I doubt this test is expecting the right outcome.
Shouldn't it result in "Nothing specified, nothing added."?

> +test_expect_success 'add :/' '
> +	(cd sub && git add -n :/ >actual) &&
> +	test_cmp expected sub/actual
> +'

This one is expecting the right thing.

> +test_expect_success 'add :/non-existent' '
> +	(cd sub && test_must_fail git add -n :/non-existent)
> +'

Just being curious. What should the error message say?  Can we make it =
to
say "fatal: pathspec 'non-ex' from root did not match any files"?

> +cat >expected <<EOF
> +fatal: pathspec ':(icase)ha' did not match any files
> +EOF

When writing a literal, make it a habit to quote EOF to reduce mental l=
oad
on the reader, like this:

	cat >expected <<\EOF
        ...
        EOF

so that the reader does not have to scan for $var in the text to make
sure.

> +test_expect_failure 'show pathspecs exactly what are typed in' '
> +	test_cmp expected error
> +'

Will this break under gettext-poison?

> diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathsp=
ec.sh
> new file mode 100755
> index 0000000..b296a74
> --- /dev/null
> +++ b/t/t4208-log-magic-pathspec.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +
> +test_description=3D'magic pathspec tests using git-log'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	test_commit initial &&
> +	test_tick &&
> +	git commit --allow-empty -m empty &&
> +	mkdir sub
> +'
> +
> +test_expect_failure 'git log :/ ambiguous with [ref]:/path' '
> +	test_must_fail git log :/ 2>error &&
> +	grep ambiguous error
> +'
> +test_expect_failure 'git log :' '
> +	git log :
> +'

These two should expect exactly the same error, I think. ':', ':/' or
anything magic will not satisify verify_filename(), and needs a
double-dash before it.

We could improve the disambiguation heuristics so that when we do not h=
ave
a '--' on the command line:

 - make sure all the earlier ones are refs and they cannot be a path on
   the filesystem (otherwise we need a disambiguator "--").

 - the first non-ref argument and everything that follows must be eithe=
r a
   ':' magic, a string with globbing character, or a path on the
   filesystem, and none of them can be a ref.

Do you want to take a stab at it?


   =20
