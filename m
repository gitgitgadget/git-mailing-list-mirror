From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [patch 06/16] diff-test_cmp.patch
Date: Tue, 27 Apr 2010 12:15:52 -0500
Message-ID: <20100427171531.GA15553@progeny.tock>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135833.403548000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 19:15:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6oN9-0001Yk-HZ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 19:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054Ab0D0ROu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 13:14:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53035 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab0D0ROt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 13:14:49 -0400
Received: by pwj9 with SMTP id 9so9581501pwj.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gz6i9gDSxijJRm1oDhYgHbYaCpp68ZGbQn3dRFXACn4=;
        b=mcTr7SKThMubEkoCgctk1X/fTZ94mAzUckH+aaq/Ke6EzrL/nCIZU/oQhEapM+3zlc
         oRmWbbtXEPXZFDIpqwpEseuSAIJXyx3rU6sPenO7eMlqHYSOZEICwq33L0OavPdefB91
         IXE0dGToiyeFSUWZYPcfw00tSdUXwfmnxLVbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DdmDZzajPOgHYA2YJG9IlY/8C/U5XDhSYCiM4AgJzL4KUb9QCRoi6a/MsOj/QHvj0s
         lbIvHUqPo3kopSe9sDChYvqVwr8IoxhTMqw0mgWI456kbp23DxytyvLxyqncQmY9LQqJ
         jrFWOA/VXWfLtwmZA5JDIY2qiQQTcMcehMasc=
Received: by 10.142.247.16 with SMTP id u16mr3419293wfh.217.1272388488747;
        Tue, 27 Apr 2010 10:14:48 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4126441iwn.12.2010.04.27.10.14.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 10:14:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100427135833.403548000@mlists.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145932>

Hi,

Gary V. Vaughan wrote:

> Subject: diff-test_cmp.patch
>
> In tests, call test_cmp rather than raw diff where possible (i.e. if
> the output does not go to a pipe), to allow the use of, say, 'cmp'
> when the default 'diff -u' is not compatible with a vendor diff.
>=20
> When that is not possible, use $DIFF, as set in GIT-BUILD-OPTIONS.

Sign-off?  (See SubmittingPatches for what I am asking about here.)  An=
d
is it possible to change your mailing script to use more meaningful
subject lines?

This patch makes a good change, but I do not think your description
captures it.  Most of the changes are from =E2=80=98diff=E2=80=99, not =
from =E2=80=98diff -u=E2=80=99.
Is your bare =E2=80=98diff=E2=80=99 really incapable of distinguishing =
between
identical and differing files?

But using test_cmp consistently would make debugging test scripts
with -v much easier, since the output is more readable.

> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -280,7 +280,7 @@ $expectfilter >expected <<\EOF
>  EOF
>  test_expect_success \
>      'validate git diff-files output for a know cache/work tree state=
=2E' \
> -    'git diff-files >current && diff >/dev/null -b current expected'
> +    'git diff-files >current && test_cmp current expected >/dev/null=
'

The original ignores whitespace changes; this version does not.  It
turns out that=E2=80=99s okay, but it=E2=80=99s worth mentioning in the=
 commit
message.  (I think we do guarantee that diff-files will not change the
whitespace it produces without good reason.)

The original suppressed its output, without any good reason to.  Could
you remove the >/dev/null while at it, to make it easier to debug?

> --- a/t/t4124-apply-ws-rule.sh
> +++ b/t/t4124-apply-ws-rule.sh
> @@ -44,7 +44,7 @@ test_fix () {
>  	apply_patch --whitespace=3Dfix || return 1
> =20
>  	# find touched lines
> -	diff file target | sed -n -e "s/^> //p" >fixed
> +	$DIFF file target | sed -n -e "s/^> //p" >fixed
> =20
>  	# the changed lines are all expeced to change
>  	fixed_cnt=3D$(wc -l <fixed)

Is this needed?  I don=E2=80=99t mind it, just curious.

I hope some earlier patch takes care of setting DIFF in test-lib.sh.
Tests need to be usable without running them through the makefile.

> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -6,10 +6,14 @@
>  -include ../config.mak
> =20
>  #GIT_TEST_OPTS=3D--verbose --debug
> +GIT_TEST_CMP ?=3D $(DIFF)
>  SHELL_PATH ?=3D $(SHELL)
>  TAR ?=3D $(TAR)
>  RM ?=3D rm -f
> =20
> +# Make sure test-lib.sh uses make's value of GIT_TEST_CMP
> +export GIT_TEST_CMP
> +
>  # Shell quote;
>  SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))

If neither DIFF nor GIT_TEST_CMP is already set, this will export
GIT_TEST_CMP as the empty string.  Will t/test-lib.sh treat that as
asking for the default?  Yes --- phew.

Except for as commented above,

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
