Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F54C64E7B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C5D2222F
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 13:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgLBNLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 08:11:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:43735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgLBNL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 08:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606914591;
        bh=HNDl3xxel1X5exTISYWC8fVAiMBnsIdYEtyp+FNpjPo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h0tmDCW7I+JfdNyz9d2JI7BNfCHPQjbR/I/CCgW0vu8Mit1NYYwKh+EOFYQ67cYaJ
         JZtB0PSn4oO+pLh79U1+OFFh6KZx0/Z53FNBi+iDNsCy4okCE68TKK+nYKe0zaoImw
         c0FIYMIu2oSuMN0EMMiUqk3Kl890CaMzqk2Iy0fQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1kMxdy2dfx-00nxYg; Wed, 02
 Dec 2020 14:09:51 +0100
Date:   Wed, 2 Dec 2020 14:09:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/2] abspath: add a function to resolve paths with
 missing components
In-Reply-To: <20201127231916.609852-2-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2012021406020.25979@tvgsbejvaqbjf.bet>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net> <20201127231916.609852-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qxCn/xQvEY1Z8ltiqfCkA0/FjgGXxBTZYYtNRzmYhWGFRlajcBm
 zS2XXoSGB/wFUsHb0EGQ7Zox4HPcbFct5h3RzAljMdApKJ6Yq2RY9WqVacmLS/oicpa4r2o
 dVCpNzhzXJkt4QOx5vck6Mdh2z8cD7zaJR8R7Y7Jms9lfJEhb+lL13gFYlXWpVZKntif/sk
 YdbByFbyMuAizLPfJYbng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H94QdMRxGAc=:LU2hNSca6H5SDroy2GfA1c
 AcOLYh4VAsnLf7hs7AmltvDxcDZ3l99uHk8drCb3dzNbAJeHVlC4FmXfNbOByCgf6YztR3ftT
 dum4JzLtUTYyoFSVk3j7UtlAWfonyBbx8YIuZvkgPqgHt/VrGTcMC8McGDShQCmzkSXxno/7P
 Fb3cotj4+sLImetazp7a/v9Vgb5ni09BHIwCKYHLhRvPTcTY/gs3Ny/jTqBnmxD2AypHkcx7+
 F1vKR4sqfz31E39Ctw4m6fP6YA6b3Lt8Fv4F0f9lPUUbUk7QWyNWwi6nR2nnPwpGf0s/+OUjA
 0Yyw7Mv90kUQgPGs8pLsrAnb9JrdyGGzKsiXUgcqaPzL3semmqzUybqcw7LdoZw/WrKo7hD88
 5zNXomxXquMq5/y5eUWgbIJwX/Qyn5PeQ7cqBdqu0Ea3UN1pyhS07okjfEaSPDdT2DfRVMpwB
 xo4vYLAeterPi6zjAFc+Zx3oOIA/+gikP4k+wtZACbEPtjfEM901QuHAKY4vWTZy+zEmGjCP+
 2DWvRJ+TRe0O5Clt/HR/bWj2f5+DFym0vjLabTTEMV6Gf1UwGWTQ8vL0yF+OxBtUyY9l3TQAO
 zTCpEDf+1nv8Qnr57aHykYkEsbpc2bbal+UEAf9j4LZ3OuoJDN8bBULwbcgOf9HAk8RLrCxWu
 quqx5op5l49XQWTjrc4saUyXe3cpVVA79npSK0lQycf+Cep8JcJ2Ojw9Fe+b08pkeAXEge8x9
 OVEDdoixHzRC049xkCwLfZ3YeEl3e808yycAn0rvWucZ8k/2Z2o0anHGhLAP+UKmxOBNqOibB
 daS6R/IjdgOgm4psh/P6j5Zc2skLJChBb4kbgyuhlDsw8MJKeCPNDaaAIDgOOobVcRI8u0cPK
 2UaHA9cFqAcgi2pYJu9ybo6bhgrrRW9kei9p1RnSs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 27 Nov 2020, brian m. carlson wrote:

> @@ -80,6 +97,16 @@ static void get_root_part(struct strbuf *resolved, st=
ruct strbuf *remaining)
>   */
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error)
> +{
> +	return strbuf_realpath_missing(resolved, path, 1, die_on_error);
> +}
> +
> +/*
> + * Just like strbuf_realpath, but allows specifying how many missing co=
mponents
> + * are permitted.  -1 may be specified to allow an unlimited number.
> + */
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int missing_components, int die_on_error)

I am having a hard time with the name `missing_components`. Taking a step
back, I think that we are interested in essentially two modes: allow one
missing component, or an arbitrary amount of missing components.

If this assumption is correct, we may not even need to count components at
all. We only need a flag indicating whether we allow only the last
component to be missing, or any number of components. Maybe something like
`error_on_missing_parent_directory` or some such?

Ciao,
Dscho

>  {
>  	struct strbuf remaining =3D STRBUF_INIT;
>  	struct strbuf next =3D STRBUF_INIT;
> @@ -128,8 +155,12 @@ char *strbuf_realpath(struct strbuf *resolved, cons=
t char *path,
>  		strbuf_addbuf(resolved, &next);
>
>  		if (lstat(resolved->buf, &st)) {
> +			int trailing_components =3D count_dir_separators(remaining.buf) +
> +						  (remaining.len !=3D 0);
>  			/* error out unless this was the last component */
> -			if (errno !=3D ENOENT || remaining.len) {
> +			if (errno !=3D ENOENT ||
> +			    !(missing_components =3D=3D -1 ||
> +			      trailing_components < missing_components)) {
>  				if (die_on_error)
>  					die_errno("Invalid path '%s'",
>  						  resolved->buf);
> diff --git a/cache.h b/cache.h
> index c0072d43b1..ee4bc5ec04 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1320,6 +1320,8 @@ static inline int is_absolute_path(const char *pat=
h)
>  int is_directory(const char *);
>  char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  		      int die_on_error);
> +char *strbuf_realpath_missing(struct strbuf *resolved, const char *path=
,
> +			      int missing_components, int die_on_error);
>  char *real_pathdup(const char *path, int die_on_error);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>
