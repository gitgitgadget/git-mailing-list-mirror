From: Caleb Thompson <caleb@calebthompson.io>
Subject: Re: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Mon, 16 Jun 2014 14:50:57 -0500
Message-ID: <20140616195057.GB28126@sirius.local>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
 <1402603225-46240-1-git-send-email-caleb@calebthompson.io>
 <xmqqppic3dko.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 21:51:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwcvq-0001Uc-A3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 21:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780AbaFPTvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 15:51:00 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52623 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755298AbaFPTvA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 15:51:00 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DC1B15A7;
	Mon, 16 Jun 2014 15:50:58 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Mon, 16 Jun 2014 15:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=mesmtp; bh=v7rX71ynumMi2B9iXE51CatN
	gsw=; b=OMHnYogoH41GfiQ6yhCg62YtZyNBPq4nFxx7RS6OYsxRgQtgnKx6w+IM
	j92dDngPftUo4Ki2Y+aOfVhj308XoQVZ1BVRVLW/Fq4TLat69uyhXP6x8CsHrLYp
	SbfOEtqq8hGrWKbeeAIxgL+jP2N0gFfLubBErLSJXsLpeilx4VU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=v7rX71ynumMi2B9iXE51CatNgsw=; b=ZFA8FrehRUXtgsGpHPdjpp46mfVd
	WYfnvrXaDs1l6eyYY3xHwwOWU5+EkZsRHhLsfs3kkNo5iiSfURnRHyqeR6epbkxW
	671hku5jqqIfslZOli9UZmVAxVxJ8sUdzLGbeO6YtuYIPakZh7QVwTKr8kOYg3en
	Xmjmr8DT+PA5VXo=
X-Sasl-enc: 9CSLWdHUxHlpfOTVmBTTjehVELAmIEyurQlyw/88r8Nf 1402948258
Received: from localhost (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3893DC00003;
	Mon, 16 Jun 2014 15:50:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqppic3dko.fsf@gitster.dls.corp.google.com>
X-PGP-Key: fp="B432 C068 2FD1 C2D0 6A8B 3951 1621 ADC2 A0AC E70A";
 id="0xA0ACE70A"; get=<http://calebthompson.io/pubkey.asc>;
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251809>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 10:48:55AM -0700, Junio C Hamano wrote:
> Caleb Thompson <caleb@calebthompson.io> writes:
>
> > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> > index 35a4d06..402d6a1 100755
> > --- a/t/t7507-commit-verbose.sh
> > +++ b/t/t7507-commit-verbose.sh
> > @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
> >		exec grep '^diff --git' "$1"
> >  EOF
> >
> > +write_script check-for-no-diff <<-'EOF'
> > +	exec grep -v '^diff --git' "$1"
> > +EOF
>
> This lets grep show all lines that are not "diff --git" in the
> input, and as usual grep exits success if it has any line in the
> output.
>
>     $ grep -v '^diff --git' <<\EOF ; echo $?
>     diff --git
>     a
>     EOF
>     a
>     0
>     $ exit
>
> What are we testing, exactly?

Good catch. It worked when I switched check-for-diff from
check-for-no-diff, but I didn't try to make check-for-no-diff fail
independently, so I apologize.

This version removes the the beginning of a line starting with
"diff --git" from the string, then checks that the result and the
original string are not the same. Switching the != logic to = makes the
tests using check-for-no-diff fail.

	write_script check-for-no-diff <<-'EOF'
		exec test "${1#*^diff --git} != $1
	EOF

Another option is to replace the parameter substitution with a call to
grep:

	write_script check-for-no-diff <<-'EOF'
		exec test "`grep -v '^diff --git' \"$1\"` != "$1
	EOF

I think that the former reads nicer, and requires less escaping, but I'm
open to feedback.


> > @@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> >		check_message message
> >  '
> >
> > +test_expect_success 'commit shows verbose diff with commit.verbose true' '
> > +	echo morecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose true &&
> > +	test_set_editor "$PWD/check-for-diff" &&
> > +	git commit --amend
> > +'
> > +
> > +test_expect_success 'commit --verbose overrides commit.verbose false' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose false  &&
> > +	test_set_editor "$PWD/check-for-diff" &&
> > +	git commit --amend --verbose
> > +'
> > +
> > +test_expect_success 'commit does not show verbose diff with commit.verbose false' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose false &&
> > +	test_set_editor "$PWD/check-for-no-diff" &&
> > +	git commit --amend
> > +'
> > +
> > +test_expect_success 'commit --no-verbose overrides commit.verbose true' '
> > +	echo evenmorecontent >>file &&
> > +	git add file &&
> > +	test_config commit.verbose true &&
> > +	test_set_editor "$PWD/check-for-no-diff" &&
> > +	git commit --amend --no-verbose
> > +'
> > +
> >  cat >diff <<'EOF'
> >  This is an example commit message that contains a diff.
> >
> > --
> > 2.0.0

Caleb Thompson

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJTn0qhAAoJEBYhrcKgrOcKMDMIAIvk7+ltU0mrdxRpW/WCX42K
nOeDL5zkjE+J96PbVIzWdg+NcoOlSefum3FXtG3g1gSAknxYIpX7Q/kynOapfnoB
+LbXjuv0o1rCAyM1myrBVqs7Nm47whYilV6aGzWvCdC4u3PjEihSLpOgpWme/sLr
2OUeWDt9i6byfRI1D15Qws8zf0u90F/r6N0hUXmt4CH1oJIGxB/9nf470v0Q0Nkm
2//0cGxb6KB5jTub/LTxHbiZNpILnFWZzAxqHCoA21x/Hp6fOvMIEtkQjj1D1WN7
smdaC63SCGtkncD+SVxerHHFmbEt8rDJjFFyhY7DXz/H+UAozgtbQnCYGuhx6Ds=
=KfFb
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
