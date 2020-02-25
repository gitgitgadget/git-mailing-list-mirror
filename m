Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B15C35DF9
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C321D7E
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NFgujSC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgBYK3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:29:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:58113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgBYK3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 05:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582626568;
        bh=GSkNkbf/a7yR+3EUfgmPkKFSvxtSf6cSfdCMFcyXTqk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NFgujSC0uXjO627wn/V6AafL7t239qyE3RcE0MqfPobX0cZHGaV+x1Ye35TZCzAnz
         u/SostcMc1ro1+rmawlkluKMNumv2Qs/Uc5Q5k07/MY6EwZ2vuV/xALKWk3EGJUbPm
         5AvZhWQN3V3L22dbxH18Jm4b24cbqTZm8rHEib+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMfc-1j9mbL3g2e-00ELrC; Tue, 25
 Feb 2020 11:29:27 +0100
Date:   Tue, 25 Feb 2020 11:29:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 18/24] gpg-interface: improve interface for parsing
 tags
In-Reply-To: <20200222201749.937983-19-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2002251127320.46@tvgsbejvaqbjf.bet>
References: <20200222201749.937983-1-sandals@crustytoothpaste.net> <20200222201749.937983-19-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0imQE9cHaqdWAee6b2DAnUigX61aS7o3nXPxArY8tvFLacW3DQ4
 tP4N3IaSOaYDiKttXMCw9YsvQboP6dExwyDTzYEtostq3AWcPlzbRi9VY/AiSptN0rtbGXM
 VWISuehYYFGusvXPsheMP3eEsTAzcz3bCV23hMSoHy2JOhXAwRpa1CqJiaIykrzs4Ojv+a0
 teoSPG8TErYwMgENhHuSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTkcE9RgRvY=:3OwPefzljZ66YS19abdA/y
 yAvH1VSX5Gm2Z3995GCNKqLX1BLcbDLfAkgDVG0yT7xJoUJo7phiuqPh2FBzsEuXPOarl867v
 iEMdK04uAM5zCh7jqEKpCfvGW4Tj2QenHJFn6o41euEjbDWw/egZ0u9fXSyPiAc9VbLxzxQm9
 ODNIK+ktthpCo1C5O3AiXSWRJG7gvYozSsl48Guc1ly/g5VXkib4PGrGNPRmRLh6iQjDo3ATv
 o5LYKLTaDQVr263KrBx4YE62JVP6lCruk5K+827Q3sdO7gunTdHcx5LJg2zKgu+fiFSmidgPa
 FTzBaj4RX5zvNZiadl4VpxN0/ghwmPgS/VapXDZ7qW4RWXZ1FFSgqPLs1Zb8hjHTrvgQRYirH
 Uw1dDoLSv14bnncbf75vU+4WDo8+y/XPSj99wUAyWfuiAlBE5zish4lrCvlsyDVsViOtMHUoA
 VAfmKAqKT6xBU0xp2VfL53jw5SAyglosqkAknwIdnXX6nKdXG5hePta1thfAeo5QGsrM644PH
 0Paz60xflsjoTBka3lnFBGHFufjAdISZg05YfIzv5ukoYEOVMswNHG1pmoBzW/+P7Hq0BVkEv
 RWqvQCZFCRe2az5pbEYcDEG+8ORjqvBB075ChgmQTesiT1qKw4fP5hnNvSpYGy0Ji0esn5gud
 i3iM+8ightjtNopbl0BRbPf/VNQKidci/giNPDJr0DwMrfTzqKwyw91mf/rQAs45fw5mIBPht
 oQxG/ce0iODsTgpBtjVfELvNOaZn5kA3NoDw6+f0b0KK4AsQeJxw+6Qf+RNhRIt+5/jP0fVXj
 tfDyB689NsHoUc9nTNtZ14itLCFGzpdmfBU4SGBgtPqHQq6p3wW8LdXq04qAU+G4fmL8/6Poe
 yLDT9s17wtVRmVhwZivNUn2ZkKWzXEcB369SyuxjcwPPlh6TR77WvDq/FKV6zG9dP7NYxrA01
 ifukDc4Gvl+HNZhIFlq/PmCncXmYmsBXBGHqJPSr5vWmkmXAPIc2VnoQAaSlZuQDYDQwe5eaz
 QcExurM6wgTd177aAkpQQRIbihD1ogl02DKSfcdSJGA5xdRaKyiaknQRky2rGmofXJZCURdu8
 8aH90ISWH3bneJA+YgrKCOvV3TMu3vi2IpCZLpg2LAUzwb18OrLf9mjWSfzjjKoSKNF1EZ7Di
 jyAzZcXolDYiN/G7MTaCXeyfD4+5FPTTmq3UJU5NWMb0jlyhVcujynURmaKU90C+amhgTuabk
 hq2cXv8zgOc9jjDbf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sat, 22 Feb 2020, brian m. carlson wrote:

> diff --git a/ref-filter.c b/ref-filter.c
> index 6867e33648..212f1165bb 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1161,7 +1161,13 @@ static void find_subpos(const char *buf,
>  			unsigned long *nonsiglen,
>  			const char **sig, unsigned long *siglen)
>  {
> +	struct strbuf payload =3D STRBUF_INIT;
> +	struct strbuf signature =3D STRBUF_INIT;
>  	const char *eol;
> +	const char *end =3D buf + strlen(buf);
> +	const char *sigstart;
> +
> +
>  	/* skip past header until we hit empty line */
>  	while (*buf && *buf !=3D '\n') {
>  		eol =3D strchrnul(buf, '\n');
> @@ -1174,13 +1180,14 @@ static void find_subpos(const char *buf,
>  		buf++;
>
>  	/* parse signature first; we might not even have a subject line */
> -	*sig =3D buf + parse_signature(buf, strlen(buf));
> -	*siglen =3D strlen(*sig);
> +	parse_signature(buf, end - buf, &payload, &signature);
> +	*sig =3D strbuf_detach(&signature, siglen);

While I like the spirit of this patch, it makes the Windows build fail. I
put this on top of Git for Windows' `shears/pu` branch to fix it (maybe
you could adopt a variation of it?):

=2D- snipsnap --
Subject: [PATCH] fixup??? gpg-interface: improve interface for parsing tag=
s

In 3f69139fa39 (gpg-interface: improve interface for parsing tags,
2020-02-22), we introduce a call to `strbuf_detach()`. The second
parameter of that function takes a pointer to the variable where the
length of the string should be stored.

However, `strbuf_detach()` uses the 21st century data type `size_t`,
while the existing code in `find_subpos()` uses the `unsigned long` data
type that the 1980/1980 so desperately want back.

Unsurprisingly, this causes problems with the Windows build, where
`sizeof(unsigned long) =3D=3D 4` even in 64-bit builds (which, I feel the
need to add, is totally legitimate).

We should probably change the data type to the correct one in a
preparatory patch, before improving the interface for parsing tags.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 ref-filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 164ab62d15e..bab34b9ef74 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -1156,10 +1156,10 @@ static void grab_person(const char *who, struct at=
om_value *val, int deref, void
 }

 static void find_subpos(const char *buf,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	struct strbuf payload =3D STRBUF_INIT;
 	struct strbuf signature =3D STRBUF_INIT;
@@ -1234,7 +1234,7 @@ static void grab_sub_body_contents(struct atom_value=
 *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
-	unsigned long sublen =3D 0, bodylen =3D 0, nonsiglen =3D 0, siglen =3D 0=
;
+	size_t sublen =3D 0, bodylen =3D 0, nonsiglen =3D 0, siglen =3D 0;

 	for (i =3D 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom =3D &used_atom[i];
=2D-
2.25.1.windows.1

