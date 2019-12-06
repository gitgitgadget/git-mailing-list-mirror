Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E33C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDDB20706
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 11:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jcP1rsIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFLXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:23:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:39811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLFLXD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 06:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575631376;
        bh=1VFzx9pa8HQl/DClVn/CrTsh4HlQ2wbsQaBEgG1rkQY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jcP1rsIZgys+evG/yHQAF09DY2EZwoNqzW0pb6C1uczDWhEPlFXzmfjWdJ2gBeWK2
         HwJR4P6hZtXc47n+eST/kQ2ewmjNg4KWM6SVuoJtM0hC2JEOqBO2XbXri3IMoUEann
         KHC9U4Vj8NNF81FEPkQOgi/GWuGnWmKoKS99L3A4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1iYSc847LX-00E9b3; Fri, 06
 Dec 2019 12:22:56 +0100
Date:   Fri, 6 Dec 2019 12:22:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] grep: support the --pathspec-from-file option
In-Reply-To: <20191204203911.237056-1-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912061220400.31080@tvgsbejvaqbjf.bet>
References: <20191204203911.237056-1-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:stiS8WBoDieTuPnwJGv++ID3cNx3whDZ+klxCa70Q+6bPis5FKe
 B2jzvenf5JQRQDlbXoqCLaqP6mH//qjg/ufAn6STDJyR7Up/m7q9rGIzN4LviQRwbQ624Kn
 nzmk/PoiRSQvJlBwuSnqUfwyA51LGro3M9tFHvImPQ9N2aZiMbmsj89E/0KNZ2sArj2uKEA
 Ufr3D0ORhGsLATmuSCZKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ncdqbH0bpm0=:3WS4PLqwUib1PXd9l1q/8u
 CJr9Wlk9zUNeK6h9i6cFRWd/1m1k/bQj81vIIBFISkUaLcND+K5mSqiSZwWXgJAaueFyTahv9
 D6U135PbA0gmfJHLDs47t692ad2lzNdUKTrCc3rg5KYfDHsG/3IK/QSEXvAswonAT73fIqxfA
 AU7Qm+S+IvytK09cQJNeCLDxkeSE7GydP1AtFx1XZc62GnxSvx/1ixALxXb+trFmcQw6kT4xt
 gmKf6W5Z1LJIO5jSpK8pz+mtEeQ0RwyzbV6ZPLM2w7sTfLw05by61B9n92g+lE2HDxox71Qd6
 31icctv+QufcipAgAgSObATav5qYb2tTqA+FcoX7hVoLke7BcX/3AI/F2ITXUwT+hdjVl+om3
 A5t9OGQG0t83NCQc2KdgACJHaPPQPm+V33JfaAL2gPaXUba9l5cmDaJ7bWLJWrHXqEjb9Ieni
 olxa6Nt/LrrwjjWNQOFqiAE6xJAZ+2gi/wp43r/h33UwyBVguEJUT+QRupEARAiHSnEdaLcO2
 +5aR03IgLT+oBw5wVnkhZQcV83ZRUCM4WX4HHLy2XSCCtmlYcJvYM2FYRnrhCbqwYCPtiG20G
 PuifIHlA2UgqEfCZ1khatpHZW7QOWufXaIdlvCA1u6APUgeRf1P2h5SiqaNy9Jko5QlR61GvA
 R4/6yVQB6UjlbE17uff0pMqvu88/omVvdHnCMRnlrjUXWvOxmF6YF7+W5yPN0SXhjK2qCnFx/
 FjuL1FVQ9tdBM28QkhELxyWLrxnK63qmVrzX5ZiFYwkyG0jvM1Sh6u6z373D1Ukg01s8fqY5F
 7IR8QlJoglvFj6yKc4qY0AgEqTh0J3KzOk27aohg8Qx0fEfRYXUmLGoG9TV3E6FjgivBMdCaK
 cEBHTCjjvcjMzx5PQunX1329ubZ22FHeK3lQjvbevuPTJ71lHfnVphV/NqjhzqCF3tgq7Gs5q
 uRQa658V0vCbtuaSJQl2EILTeBPLA6kE3sckYSGj9G5kpD5wsNrvz00emhAlLQV2AZ/CN/xG5
 FfvUHMS45WBs8CX3eU5X6BCVuuqOGQFvNlss0aEcj61HFkWVXZkpBXxDVEAQw8Qtkg/24Lij3
 +c932tkFrCgIhiCOJkaTAvKgzuQqaDkrE7J+sbG/bYQ213oj207WzgR3/2iqdE3BTqDr0UMH4
 SxshjbtOy6IZ4aMIfZ36Zj4eWccQ7Pbbs/6HywebLnORfjxjG6r92s7IIky1mTdbwucbUq98l
 3shCfP5Qkb80/QGrke1QNhdZUKn7yEBfiqDr4U+X3Th+Ebt0xiF2c56Tpr8M=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 4 Dec 2019, Emily Shaffer wrote:

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 50ce8d9461..54ba991c42 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -809,6 +813,8 @@ int cmd_grep(int argc, const char **argv, const char=
 *prefix)
>  	int use_index =3D 1;
>  	int pattern_type_arg =3D GREP_PATTERN_TYPE_UNSPECIFIED;
>  	int allow_revs;
> +	char *pathspec_from_file;
> +	int pathspec_file_nul;
>
>  	struct option options[] =3D {

I need this on top to make it work without problems (I have not yet
triggered the CI build, but I will in a moment):

=2D- snipsnap --
Subject: [PATCH] fixup??? grep: support the --pathspec-from-file option

We must not use those variables uninitialized, this causes CI build
failures left and right (see e.g.
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D22821)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 54ba991c425..c2aa1aeebd6 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -813,8 +813,8 @@ int cmd_grep(int argc, const char **argv, const char *=
prefix)
 	int use_index =3D 1;
 	int pattern_type_arg =3D GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
-	char *pathspec_from_file;
-	int pathspec_file_nul;
+	char *pathspec_from_file =3D NULL;
+	int pathspec_file_nul =3D 0;

 	struct option options[] =3D {
 		OPT_BOOL(0, "cached", &cached,
=2D-
2.24.0.windows.2.611.ge9aced84530

