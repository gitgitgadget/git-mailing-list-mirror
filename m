Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC8C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B2F61176
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhEEOkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:40:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:36501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232919AbhEEOkA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620225524;
        bh=MAv/3c66psQrAcpSQ/JmreNQL+dh7U96g4NdoHjLhqE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jHAh76qcLHxXozHt6uX4opdo+rb3q1UOeRo+EB5csLqAXzcf/rq2C7ohNsbRNPJ8L
         4Xv0uVYtyG6W6kiZf6YNedvNZfKQ1DmJ9UiFqpzla3jIhbzKD/ZXXEMAFhvxaZ2kRX
         +kPWodSg9jA3wiSae2HFueCSOcP1r/fqv+yy0oT8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1l2E1u2Jp4-00gUDR; Wed, 05
 May 2021 16:38:44 +0200
Date:   Wed, 5 May 2021 16:38:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] trace2: refactor to avoid gcc warning under -O3
In-Reply-To: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2105051623230.50@tvgsbejvaqbjf.bet>
References: <20200404142131.GA679473@coredump.intra.peff.net> <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1963401848-1620225524=:50"
X-Provags-ID: V03:K1:/Wajuz2DrnEZbQXu5oeyQcwpYJURF/sxb3XRgdg/I4Ksx76XXun
 FR0YFO0/OO8S3WKln0zgXvPqsiKQHgVrbvmwpCsUhAm9nrQ/loRrT9eoC6ltXr4tDtp5cCC
 2YXS81jqxsnFDH2HHitxtCf+HLM5BE1l36PG8zlI4KZKeaIk+ixBCKpwzxyaOkzQ4MpBzJk
 cLqZkDwuUSzsd0rHFLw1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:givYH3Z0tPA=:Vu5pF5Sj8Heae4CnsnCBre
 TkKTeRjiEZvASl8RyBoQa8w7Esdu4oSOsiolL/3WEkRMAPSk/hCELs6IG4DMgIDI7A5/I99Gi
 QQcHBi/et/rCmsEV92gS3nuRextyPgGDQ9kIuItZeg7jx4kBksXKNbEGl0Y1vmuKaakDpLx5z
 nahgorY9saO4Xdrnr7zvUnWGg23eXv82uO2qKl4MtoD1H10CeiqMN8UqA6FeNgBtxBpH7kqdb
 QEOesorJjTydKYZP/5a6hWt5gxwAXi3/S9w9OSQZmXCN0Rsv//nQTYc0FtrIIBvIFsLqixR9D
 eYQbSBLPATVxRz35+9ABibU224Ut7iofSlmYN+SlNL8JXmsyxoW1Cp2ScK1iBeeCjnfMnqxua
 kxGz5yqTyVj7qL7VvMpWBKWc6eF7S6lL8X1bXEbqUHMeKxyHS07RtdWH1jOsN3WZGKOi5AKeg
 58kSb4Q7jfJ8F9kdvIG3t3HzUEHPBIQ9N85WWg4uxIpen0mgHZvakodrHHegZA0lPlbwAuLJN
 SMiarHKDJcmus492L5c7KAU5zRHhtTzUFbRXZy46X9ihzPn3HG0FJH6EMsFhOx8p91OwpRGZJ
 81MwMoACTxjwZCaSUopKpGV2rtWXnkO6c0ZlX1XgKxAHmI3RFCr6zz5CxD1/5wd/azx2iMJag
 pTAYNY87SGPoF/L5gd+2sS/Ss5eL9Nbi/cvTpZqFXp94QJAtjB2FjlaV3sZYpM+1XKuz7/dy4
 uNJd3ISO7orNe4wfX0nje0t0RY7Me4dKcv0t1smKvcQpgOA6l+Md3kgBCgwa2IotMUnU5M97V
 f95S6+FGOTi97x13F+JZhKo/C4QMV8BILQRjl9kCMSAltDx7I56gsdnojQ3QMzIgaO1FWT+HU
 WyRUZ4kVXyBkIj32SRWIErOAxumwDzLdS7SZc2zljyHkIP6UMCzJg9fEj534THf9YBKXM1QQ9
 7HxZaufDvUgfBoo+Z013JvTAz1+Y+tF7HVYdgYn9ZBCdwHl3XnHoAj7l2fWWG+wcviKpUPZ6Z
 ZTc/MFolZo8h8xp3/cr6pNyMg1THRX0C/v+t9pp8lJ1yB7aoehbpuZ3gwQsuGDzRPUHRG/0ml
 KD4KnfzEu9uhpYi2CQOEGuueKYvv0vwKs3E+K5XgDHuXDNKVq7nIDBq9CxIlqauNOqcjIENjF
 mQ4OqoDLfdgeK3Kcmgv/aAlNmz3oGsDtV6DuhBhJbLYnlLwQ0BpWG3/TXe/L+jSl3tYke4TYC
 SSRAgu4yugED+MAZa
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1963401848-1620225524=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 5 May 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Refactor tr2_dst_try_uds_connect() to avoid a gcc warning[1] that
> appears under -O3 (but not -O2). This makes the build pass under
> DEVELOPER=3D1 without needing a DEVOPTS=3Dno-error.
>
> This can be reproduced with GCC Debian 8.3.0-6, but not e.g. with
> clang 7.0.1-8+deb10u2. We've had this warning since
> ee4512ed481 (trace2: create new combined trace facility, 2019-02-22).
>
> As noted in [2] this warning happens because the compiler doesn't
> assume that errno must be non-zero after a failed syscall. Let's work
> around it as suggested in that analysis. We now return -1 ourselves on
> error, and save away the value of errno in a variable the caller
> passes in.

It would probably be a lot nicer if you lead with this insight. I could
imagine, for example, that a oneline like this would be much more helpful
to any reader:

	trace2: do not assume errno !=3D 0 after a failed syscall

The first two paragraphs are less interesting than the third paragraph,
too, therefore I would recommend

About the patch...

>
> 1.
>
>     trace2/tr2_dst.c: In function =E2=80=98tr2_dst_get_trace_fd.part.5=
=E2=80=99:
>     trace2/tr2_dst.c:296:10: warning: =E2=80=98fd=E2=80=99 may be used u=
ninitialized in this function [-Wmaybe-uninitialized]
>       dst->fd =3D fd;
>       ~~~~~~~~^~~~
>     trace2/tr2_dst.c:229:6: note: =E2=80=98fd=E2=80=99 was declared here
>       int fd;
>           ^~
> 2. https://lore.kernel.org/git/20200404142131.GA679473@coredump.intra.pe=
ff.net/
> ---
>  trace2/tr2_dst.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index ae052a07fe2..c2aba71041b 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -197,22 +197,25 @@ static int tr2_dst_try_path(struct tr2_dst *dst, c=
onst char *tgt_value)
>  #define PREFIX_AF_UNIX_STREAM "af_unix:stream:"
>  #define PREFIX_AF_UNIX_DGRAM "af_unix:dgram:"
>
> -static int tr2_dst_try_uds_connect(const char *path, int sock_type, int=
 *out_fd)
> +static int tr2_dst_try_uds_connect(const char *path, int sock_type,
> +				   int *out_fd, int *saved_errno)
>  {
>  	int fd;
>  	struct sockaddr_un sa;
>
>  	fd =3D socket(AF_UNIX, sock_type, 0);
> -	if (fd =3D=3D -1)
> -		return errno;
> +	if (fd =3D=3D -1) {
> +		*saved_errno =3D errno;
> +		return -1;
> +	}

I don't think this is necessary. My manual page for socket(2) says this:

	RETURN VALUE
		If the connection or binding succeeds, zero is returned.
		On error, -1 is returned, and errno is set appropriately.

>  	sa.sun_family =3D AF_UNIX;
>  	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
>
>  	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) =3D=3D -1) {
> -		int e =3D errno;
> +		*saved_errno =3D errno;
>  		close(fd);
> -		return e;
> +		return -1;

Likewise, my manual page for connect(2) says the same as for socket(2):
upon return value -1, errno is set appropriately (i.e. non-zero).

Therefore, I would say this patch is actually only papering over an
overzealous (and incorrect) compiler warning.

If you _must_ shut up GCC, a better idea would be a much less intrusive,
easier to read

		/* GCC thinks socket()/connect() might fail to set errno */
		return errno ? errno : EIO;

Ciao,
Dscho

>  	}
>
>  	*out_fd =3D fd;
> @@ -227,7 +230,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2=
_dst *dst,
>  {
>  	unsigned int uds_try =3D 0;
>  	int fd;
> -	int e;
> +	int saved_errno;
>  	const char *path =3D NULL;
>
>  	/*
> @@ -271,15 +274,15 @@ static int tr2_dst_try_unix_domain_socket(struct t=
r2_dst *dst,
>  	}
>
>  	if (uds_try & TR2_DST_UDS_TRY_STREAM) {
> -		e =3D tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_STREAM, &fd,
> +					     &saved_errno))
>  			goto connected;
> -		if (e !=3D EPROTOTYPE)
> +		if (saved_errno !=3D EPROTOTYPE)
>  			goto error;
>  	}
>  	if (uds_try & TR2_DST_UDS_TRY_DGRAM) {
> -		e =3D tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd);
> -		if (!e)
> +		if (!tr2_dst_try_uds_connect(path, SOCK_DGRAM, &fd,
> +					     &saved_errno))
>  			goto connected;
>  	}
>
> @@ -287,7 +290,7 @@ static int tr2_dst_try_unix_domain_socket(struct tr2=
_dst *dst,
>  	if (tr2_dst_want_warning())
>  		warning("trace2: could not connect to socket '%s' for '%s' tracing: %=
s",
>  			path, tr2_sysenv_display_name(dst->sysenv_var),
> -			strerror(e));
> +			strerror(saved_errno));
>
>  	tr2_dst_trace_disable(dst);
>  	return 0;
> --
> 2.31.1.745.g2af7c6593ce
>
>

--8323328-1963401848-1620225524=:50--
