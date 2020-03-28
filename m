Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B594C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F07206F2
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="s5BQXPDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgC1Osr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 10:48:47 -0400
Received: from mout.web.de ([212.227.15.14]:37757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1Osr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585406922;
        bh=OO9Qm0PEmhIBiaX12aitCqKUFgJseodn//RKIQd/QwU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=s5BQXPDp2uezPrCJ0KbWJYba++jUiq6BuGb5iqurQBTVQCaKmCgzuz9tLS7SUYMYn
         CJl1zO9yyU3S6x2kahYZUXSI98AZIDZDTsZ5X1lrkwgehArbnNXRLtnKRKqnMFj9Bb
         C5Td1/hs+4z/VtheRw58kcL/jiG/5+yRmsXM8EAI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvSQV-1jQD4T0ZcZ-010df4; Sat, 28
 Mar 2020 15:48:42 +0100
Subject: [PATCH 3/1] pull: pass documented fetch options on
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?5aSp5Yeg?= <muzimuzhi@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAEg0tHTMHD1+3QaSe3Z+ymRKvOkbHnVqv-Xp2xhOT56SoHTmwA@mail.gmail.com>
 <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
Message-ID: <631d4c1b-b3f8-bb55-129e-7285ca19fe09@web.de>
Date:   Sat, 28 Mar 2020 15:48:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a406c273-9a2c-72ed-c5e3-4c19848f0f94@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KrV+wsL6k/Q0jMh0vVDuHh4Sw/HXc/rHmFx8NCf59xQZSjQzG9y
 B/Iuys4zcbZfQQwLQkdRWBv6F+ixRQ2wMsOokO9qP+8OLW1Veekq8ILQCNzTD243yGNgGaY
 G1rpq2Nk2A/OobjqKU2nXnODwviIAJGGrRXxp7m5vaY4FuY8iB8ql/xVt+qGM9V+cwkrlIP
 6D3GWqmO4L1q1CG+SJRBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BPHZzbfK1dA=:q49GH9X22mI1RP8aQrgfRT
 QjFHFSAU5Woc/OqyroJGfwlXwVDqa2jySPqliQFVYMzZUcZMWsATu+PNy783vGCfgMMLbvkQ8
 r9SA4Dt0OUFk6KEMDF9/6y3XM3IA8qBexbLCjEqa/wSWyGhMz6SEj4dVHpiImtTECyZmCSlXe
 OWx0EIUzPxpIMn17hYW2wYs1BXuwVmoLfwrV1kV4vhLsWBP+aZFPcosX6Kxx60XE2/H5a1/23
 dVAsxWrbvHd4uyq3U7pmzNy7cXIMLAbJlHz2NHgo4jJ7Sv5IVMV+EabR+pbxyIN6hTZ1caSPP
 /gh1VycNLaC7A/rJ3dhJYt1qIeZOfiGXwYw/CkYbllfUVqxvObTIO5v5E7sAoN2C9WPvaGVyR
 IE5m71lB1vHGUak02xqb0v85nBPGf9WOd7r7aR4Bp+mgTFejWFKT7dnnShgp7nrLBFF8SM549
 BjrLUbtf44ePyEXcCstCZzwQxYLi0QzoPysHk1KdPnqfwAhibINZAlxZFF5+IPD5GvEAYgMvq
 zA+myXPkkvIaCeLd/nWDJe1c4lHm+0eN8EwqroK0xLU7I/v7Lrk8NQDAk0intRiy/od6seyjH
 CV/C2AvuTd0BR9KSBrneI9vV2mRWx5ZxLaE5D3er4xNWt7lyGy25jRSgVR8SR4fXcdJqEiWuB
 CdWWsRMiKKeAqn5h7ktSejW/F50D36mUstkIsDzFpu5G2UsAMVfXhV463NG8baeZDYhmLyV+4
 hiEcfYNvllLazDyA2jap5h7XQAWuqArkSxHyEbzSWIs7WSquzCCMcEuk22BlUdAqNjIRmQx9j
 BtzkzIAhUYYG4AEMtbqEJXVSj5+Mjrmm5j/u5IwdbQfzR7N9f6O0YexUrl8A2xG6pm7tqJRlb
 ECTOgbHQzt6j0uyGQ7uzDpGkroOmw8a0HqVuQrw2aTM8Kabh8MbsbYjMq5hFdmenO6uvOLlmI
 IOWsB5SJr6D7RcS5+8/QIOuyHzNXEVwNhq2SVDrQrN5A3LqT4jfpSrd5EnBbMkG3rmdAzGk1Q
 7OGT5xgirY/x5Qk7FF7XCpfRm5AfjMWT/6zj3TBf87dyOFMT692NW6Ae/4v9jK/rS4PisphCe
 Aw85LcoL6wnnvm9BOFwBQ1rhp/dGNlTuQE1XIRbdtCxpYER2sxCvTlV8se4OoCdf6jTxJDrF+
 zq/DW77YE4YkzL9+6f9KryAKqOsUx/IhNUabR8flqWj+KFLxhBQ2AwUiKs/+aptJCbGy5ZWOk
 xTS1JDWjvyMjme/6r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fetch options --deepen, --negotiation-tip, --server-option,
=2D-shallow-exclude, and --shallow-since are documented for git pull as
well, but are not actually accepted by that command.  Pass them on to
make the code match its documentation.

Reported-by: =E5=A4=A9=E5=87=A0 <muzimuzhi@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/pull.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index e42665b681..880eb29852 100644
=2D-- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -110,6 +110,7 @@ static char *opt_ipv4;
 static char *opt_ipv6;
 static int opt_show_forced_updates =3D -1;
 static char *set_upstream;
+static struct argv_array opt_fetch =3D ARGV_ARRAY_INIT;

 static struct option pull_options[] =3D {
 	/* Shared options */
@@ -207,6 +208,15 @@ static struct option pull_options[] =3D {
 	OPT_PASSTHRU(0, "depth", &opt_depth, N_("depth"),
 		N_("deepen history of shallow clone"),
 		0),
+	OPT_PASSTHRU_ARGV(0, "shallow-since", &opt_fetch, N_("time"),
+		N_("deepen history of shallow repository based on time"),
+		0),
+	OPT_PASSTHRU_ARGV(0, "shallow-exclude", &opt_fetch, N_("revision"),
+		N_("deepen history of shallow clone, excluding rev"),
+		0),
+	OPT_PASSTHRU_ARGV(0, "deepen", &opt_fetch, N_("n"),
+		N_("deepen history of shallow clone"),
+		0),
 	OPT_PASSTHRU(0, "unshallow", &opt_unshallow, NULL,
 		N_("convert to a complete repository"),
 		PARSE_OPT_NONEG | PARSE_OPT_NOARG),
@@ -216,12 +226,19 @@ static struct option pull_options[] =3D {
 	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
 		N_("specify fetch refmap"),
 		PARSE_OPT_NONEG),
+	OPT_PASSTHRU_ARGV('o', "server-option", &opt_fetch,
+		N_("server-specific"),
+		N_("option to transmit"),
+		0),
 	OPT_PASSTHRU('4',  "ipv4", &opt_ipv4, NULL,
 		N_("use IPv4 addresses only"),
 		PARSE_OPT_NOARG),
 	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
 		N_("use IPv6 addresses only"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
+		N_("report that we have only objects reachable from this object"),
+		0),
 	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 		 N_("check for forced-updates on all updated branches")),
 	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
@@ -567,6 +584,7 @@ static int run_fetch(const char *repo, const char **re=
fspecs)
 		argv_array_push(&args, "--no-show-forced-updates");
 	if (set_upstream)
 		argv_array_push(&args, set_upstream);
+	argv_array_pushv(&args, opt_fetch.argv);

 	if (repo) {
 		argv_array_push(&args, repo);
=2D-
2.26.0
