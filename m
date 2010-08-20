From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 for infinite depth
Date: Sat, 21 Aug 2010 00:11:39 +0200
Message-ID: <201008210011.40236.jnareb@gmail.com>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com> <1282269067-5527-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mikachu@gmail.com, computerdruid@gmail.com,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy" 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 00:40:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmaGG-0006yM-TB
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 00:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab0HTWL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 18:11:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34873 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab0HTWLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 18:11:50 -0400
Received: by bwz11 with SMTP id 11so2434487bwz.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yDV45wGA6dPiYijRUw9+HvmIQhvMtanCF0PifdqO+XE=;
        b=UFgBdJwpuRg6kg5nJix+o72AHVdZn8Gx5Tls2oJGre9rqCG3Mq8AQ2ffRMqsi90JrW
         7yHYfcA6oYQBcOzB7IWENWILoIxE0tLeD/m1sYLUrejcbW4fbn4p9lpxdOLt0haBaRLu
         qOze7GkiJhXMpJ28pR8gHJ6oFTxr4hvwVnKno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FiEtoXsYZqVcw99DIMhD/ja0jyIZ516l+J2jW2mIOzR8/1vpbkjfKScbvj3RNkRgTQ
         5q+5o+8mXlbrY0J4LGT3oycm9g5XGEoc2jH7k234j1Qaka2Xm906OvbRE+/TqMA2DtvH
         KK7m1j1o83qU13BPgYptHjhmoe69ZX12nV0+s=
Received: by 10.204.179.9 with SMTP id bo9mr1336376bkb.80.1282342309237;
        Fri, 20 Aug 2010 15:11:49 -0700 (PDT)
Received: from [192.168.1.13] (abwo112.neoplus.adsl.tpnet.pl [83.8.238.112])
        by mx.google.com with ESMTPS id f10sm2375157bkl.5.2010.08.20.15.11.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 15:11:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1282269067-5527-3-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154084>

On Fri, 20 Aug 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-op=
tions.txt
> index 9333c42..a22d839 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -10,7 +10,8 @@
>  --depth=3D<depth>::
>  	Deepen the history of a 'shallow' repository created by
>  	`git clone` with `--depth=3D<depth>` option (see linkgit:git-clone[=
1])
> -	by the specified number of commits.
> +	by the specified number of commits. Specify "inf" for
> +	infinite depth.

It should probably be 'Specify 0 or "inf" for infinite (unlimited) dept=
h',
which means making repository non-shallow.
 =20
>  ifndef::git-pull[]
>  --dry-run::
> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fet=
ch-pack.txt
> index 4a8487c..75e4669 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -70,6 +70,7 @@ OPTIONS
> =20
>  --depth=3D<n>::
>  	Limit fetching to ancestor-chains not longer than n.
> +	Specify 0 for infinite depth.

Again '0 or "inf"'.
 =20
>  --no-progress::
>  	Do not show the progress.
> diff --git a/Documentation/technical/shallow.txt b/Documentation/tech=
nical/shallow.txt
> index 559263a..405170f 100644
> --- a/Documentation/technical/shallow.txt
> +++ b/Documentation/technical/shallow.txt
> @@ -47,3 +47,5 @@ It also writes an appropriate $GIT_DIR/shallow.
>  You can deepen a shallow repository with "git-fetch --depth 20
>  repo branch", which will fetch branch from repo, but stop at depth
>  20, updating $GIT_DIR/shallow.
> +
> +"--depth 0" (or "--depth inf" for git-fetch) means infinite depth.

???

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 18376d6..47fd87c 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -248,4 +248,12 @@ test_expect_success 'clone shallow object count'=
 '
>  	grep "^count: 52" count.shallow
>  '
> =20
> +test_expect_success 'infinite deepening (full repo)' '
> +	(
> +		cd shallow &&
> +		git fetch --depth=3Dinf &&
> +		! test -f .git/shallow
> +	)
> +'
> +
>  test_done

It's very good that you included test of making repository non-shallow.

--=20
Jakub Narebski
Poland
