From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make setup_git_env() resolve .git file when $GIT_DIR is not specified
Date: Tue, 03 Sep 2013 11:14:32 -0700
Message-ID: <xmqqr4d5srg7.fsf@gitster.dls.corp.google.com>
References: <xmqq38ps775f.fsf@gitster.dls.corp.google.com>
	<1377911054-20086-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ximin Luo <infinity0@gmx.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 20:14:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGv7l-0006yo-8u
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 20:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab3ICSOl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 14:14:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754471Ab3ICSOk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 14:14:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D42793ED1A;
	Tue,  3 Sep 2013 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lfuO1jED8NTm
	AR6sQYWW9xATZWE=; b=E4F2mKez6rsjL5HPzshTYaHzt+6Xq58I6L0D7Y0eLAp6
	B9yax6177DXFtPPE551lUPfLolwJC3vSJW91N7+EGWutPrDwShro5LIMxL2IyGHs
	XjWjAT3ffuqmwsN5AwGd9HsHHzCfYzWsL5YSfloY3mi94imyQw+4hXsIfaSdNaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RdHZbP
	Coh6N9y+BYhOva3qxhbq19bx/D97RdTLEb3MaC004VyYTwsXjYV6n7+ca3GBjH2/
	H5Q9Poi7zJoeWQ+c+RZGHUNOhuLrIpffUrMz0WfNx9NHwLGlC/WlEmr8r3WBfaoQ
	aWpgVCQc3/EXRK3DfN5wqgfPsp4aD/BE5HJhI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF55D3ED09;
	Tue,  3 Sep 2013 18:14:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0CE63ECFC;
	Tue,  3 Sep 2013 18:14:36 +0000 (UTC)
In-Reply-To: <1377911054-20086-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 31
 Aug 2013 08:04:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B138A652-14C4-11E3-8F17-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233755>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This makes reinitializing on a .git file repository work.
>
> This is probably the only case that setup_git_env() (via
> set_git_dir()) is called on a .git file. Other cases in
> setup_git_dir_gently() and enter_repo() both cover .git file case
> explicitly because they need to verify the target repo is valid.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> Reported-by: Ximin Luo <infinity0@gmx.com>
> ---
>  Slight change in the patch to xstrdup(gitfile) because read_gitfile
>  returns a static buffer.

Thanks for fixing it up.  Will queue.

>
>  environment.c   | 9 ++++-----
>  t/t0001-init.sh | 4 ++++
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 5398c36..378254c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -123,14 +123,13 @@ static char *expand_namespace(const char *raw_n=
amespace)
> =20
>  static void setup_git_env(void)
>  {
> +	const char *gitfile;
> +
>  	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
> -	git_dir =3D git_dir ? xstrdup(git_dir) : NULL;
> -	if (!git_dir) {
> -		git_dir =3D read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
> -		git_dir =3D git_dir ? xstrdup(git_dir) : NULL;
> -	}
>  	if (!git_dir)
>  		git_dir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
> +	gitfile =3D read_gitfile(git_dir);
> +	git_dir =3D xstrdup(gitfile ? gitfile : git_dir);
>  	git_object_dir =3D getenv(DB_ENVIRONMENT);
>  	if (!git_object_dir) {
>  		git_object_dir =3D xmalloc(strlen(git_dir) + 9);
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index ad66410..9fb582b 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -379,6 +379,10 @@ test_expect_success 'init with separate gitdir' =
'
>  	test -d realgitdir/refs
>  '
> =20
> +test_expect_success 're-init on .git file' '
> +	( cd newdir && git init )
> +'
> +
>  test_expect_success 're-init to update git link' '
>  	(
>  	cd newdir &&
