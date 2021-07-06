Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB6C11F69
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2D461C9D
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhGFTZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:25:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:49501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhGFTZq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625599385;
        bh=WLPq1EkPJSq0RQ5DB/e9sUxQjo+HW9dYeNAl+vY/RYw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZtDBNFCN3axoEpIAfYfH8U94aFtCmLoifZ5FqWP5FUbQ7JB3eynSwro+3edBGAwxp
         rgQB24QQqYyO11l3K492llg0KALHTb/E6MniF2UVtuu3/oOaPx/hFDmGDXVi5ca7CA
         Ad2QVyz8xj61s7h/m6b/bUlYpOLuHNkWt06ymn2g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1l03BN1kDE-010xVY; Tue, 06
 Jul 2021 21:09:45 +0200
Date:   Tue, 6 Jul 2021 21:09:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 19/34] fsmonitor-fs-listen-win32: implement FSMonitor
 backend on Windows
In-Reply-To: <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107062102500.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <5bba5eb3d1bd172f09fdf6eb2e9b8ac4dd7f940f.1625150864.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DUIj5A8GAw6oeDFRdWAG7XAvPv4i9jrwe9Pee5RcyZ4sAG/C4WA
 1eH+5HPzX5LC7/uK8TJOAPLMP0aZOl/SE9Ru6i4jAiNmBaTbFnR8vNH17oT+d5FUjGcgU39
 EiLWcA4SNTzuq03EWDqeWIJseJpPbJxM1V11+dw10EHKQ9vSWK5DfJ05cBdHYoEHM+IxZ13
 1lviafiC2GBpq6rc5c80A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:idfoIgsDzH4=:T70+Hxp5w+YVVCCcejUhNf
 rp6cxprp/5qtnxQUTnJ3tI3lue355v8t3FoG3u3bYJ5gSltw0BpplRSpiNDOxYA+/2qvuiRNv
 EMrYIjhO5yNiBWx6+ivmwFTX3b/f3zoIYmR/xmOn6txxpkak80A7fZK8QRJbe8+ovQK+o7TVt
 NIgLNAvzeqHHc5NE8Yyvtx1njKPhLf41YOQcVLVuiahPqSzix73HghxEObDxjqWt0NHoA/dDV
 8Eu0R2C6zOMhIs+QyngMAQPJjuW4D/hAuQqs2QKdY+6K7PBdhhlVK7GZoJ61selBcbr5RKG7M
 BtyR30OBiry02A2LXVBwHW3ZaVaspG/bazF4ZaHrxi/c5CknojThm2wMHETS0rkOC+C6cKMjh
 DHgzpkUy7oYfnYw6gfL7efu1PKqoobrgQXxhIE2dmKn4PPs5iStWPSrPxUX8/1XjjVTHdn/cB
 FUxn1ki9loF0NuHToO3CCe3QYi4t01nRMOCXU55ESoqc0o6Yn0srEvGvVdcXHpn7qydCZONJi
 m3EOd1ZujMVttge0YzVgc1YcyHOF/UMbxgFIqgJFCUEba0nEdws/qlI/tfHvNbu0cr0AW2ePU
 MSsJxlGLhTZcpTdlP7Ikz8xM3CUPsnycoMwDUJ0OF7bGudi0mjKgfwJFWTq+mmQWG1OvqceB3
 RFFF0lyI41vrICnWV/3jGgmoB30EtBaMhAyvyHHsV2bBtgI2bBv3AO9qiCDSJ1ZFZsAckwMHr
 G41RH0rUkLxNoozg6n9acGgDJt+PWML2+0aD8pzmLeNlwN3Ll7FRlQyxr2fp3ET209yCwJlss
 lnJf5A5S/7gaM63QM+evZ4XMZF6cfAuhFq9fvgzMIt34GdaT4T1ZRx5zw8ziIg91L+HQaRTwl
 iXC13EbsYXDfkygdgVb9IcguMt3MKQe3vb32t7O9d4nv1nIIqeu/vJ10a6mLIDsWNgO/tJZrT
 P3kd+sGBZvc0RfTMHMG1OKL9YYEhmwrWVWyM5ikPrPVJLX9kXeers5NUgBl0M3zF8dcKCDPCM
 +CgtqTAUrx25Jblx6oWzXyQgSAZFBS9UznBD3zubFJwNNTiBoi3Z/X9OmGygGqQShdQTQrlfX
 UBqwpOvrZUA6byponkHqiuVvzQMP/yx88KmKQO82ja52XBxAT1X1Tq8vQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,


On Thu, 1 Jul 2021, Jeff Hostetler via GitGitGadget wrote:

Jeff Hostetler <jeffhost@microsoft.com>

the win32 backend to register a watch on the working tree
irectory (recursively).  Also watch the <gitdir> if it is
side the working tree.  And to collect path change notifications
atches and publish.

-off-by: Jeff Hostetler <jeffhost@microsoft.com>

t/fsmonitor/fsmonitor-fs-listen-win32.c | 530 +++++++++++++++++++
e changed, 530 insertions(+)

> diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmon=
itor/fsmonitor-fs-listen-win32.c
> index 880446b49e3..d707d47a0d7 100644
> --- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> +++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
> @@ -2,20 +2,550 @@
> + [...]
> +
> +static struct one_watch *create_watch(struct fsmonitor_daemon_state *st=
ate,
> +				      const char *path)
> +{
> +	struct one_watch *watch =3D NULL;
> +	DWORD desired_access =3D FILE_LIST_DIRECTORY;
> +	DWORD share_mode =3D
> +		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
> +	HANDLE hDir;
> +
> +	hDir =3D CreateFileA(path,
> +			   desired_access, share_mode, NULL, OPEN_EXISTING,
> +			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
> +			   NULL);

The `*A()` family of Win32 API functions disagree with Git in one very
interesting aspect: Git always assumes UTF-8, while e.g. `CreateFileA()`
will use the current Win32 locale to internally transform to wide
characters and then call `CreateFileW()`.

This poses no problem when your locale is US American and your paths
contain no non-ASCII characters.

In the Git for Windows bug tracker, it was reported that it _does_ cause
problems when venturing outside such a cozy scenario (for full details,
see https://github.com/git-for-windows/git/issues/3262)

I need this (and merged it before starting the process to release Git for
Windows v2.32.0(2)) to fix that (could I ask you to integrate this in case
a re-roll will become necessary?):

=2D- snipsnap --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 5 Jul 2021 13:51:05 +0200
Subject: [PATCH] fixup! fsmonitor-fs-listen-win32: implement FSMonitor bac=
kend
 on Windows

Let's keep avoiding the `*A()` family of Win32 API functions because
they are susceptible to incoherent encoding problems. In Git for
Windows, we always assume paths to be UTF-8 encoded. Let's use the
dedicated helper to convert such a path to the wide character version,
and then use the `*W()` function instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 compat/fsmonitor/fsmonitor-fs-listen-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsmonitor-fs-listen-win32.c b/compat/fsmonit=
or/fsmonitor-fs-listen-win32.c
index ba087b292df..3b42ab311d9 100644
=2D-- a/compat/fsmonitor/fsmonitor-fs-listen-win32.c
+++ b/compat/fsmonitor/fsmonitor-fs-listen-win32.c
@@ -111,8 +111,14 @@ static struct one_watch *create_watch(struct fsmonito=
r_daemon_state *state,
 	DWORD share_mode =3D
 		FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE;
 	HANDLE hDir;
+	wchar_t wpath[MAX_PATH];

-	hDir =3D CreateFileA(path,
+	if (xutftowcs_path(wpath, path) < 0) {
+		error(_("could not convert to wide characters: '%s'"), path);
+		return NULL;
+	}
+
+	hDir =3D CreateFileW(wpath,
 			   desired_access, share_mode, NULL, OPEN_EXISTING,
 			   FILE_FLAG_BACKUP_SEMANTICS | FILE_FLAG_OVERLAPPED,
 			   NULL);
=2D-
2.32.0.windows.1.15.gf1590a75e2d

