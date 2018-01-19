Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9023C1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbeASRGH (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:06:07 -0500
Received: from mout.web.de ([212.227.17.11]:53321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755878AbeASRGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:06:06 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lpezi-1fGsk318Uw-00fQJw; Fri, 19
 Jan 2018 18:06:01 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] cocci: use format keyword instead of a literal string
Message-ID: <1955155b-3853-300a-869f-5d59356c1a94@web.de>
Date:   Fri, 19 Jan 2018 18:05:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KIFVMlNqMTboHhQGYJt+ZFr/QOQcoUnWfn/hGTNLgBhuZEP8pUc
 mnT+YDvszKcBowKmyFw2p7YL3z7Sr1nKqjm9fs9MdhlOriK++ZH+zdN+bZGWHvrHd7DsXHA
 VtKvFNJh72qzS0IISaAl57bJbV/cQApjozTsaC+oSd1vboSUow1mFVf5lNtYwG5zJrEENGH
 PdPQs3LAf7hWpO/as8XNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sNcqI4tTFEY=:owTTt8tVHlykeYuhZ22vNA
 NhSQ23sE7Wg0NtjWWebKR2buZ9ARkFLOlbfhhOFBVqA54GfIATg15R/F/xtBIZ9QWoPPPuw1W
 juByRtgROR0XEOVN3NbZpoBxAPH41ZZltBu81ph77GgRUURdoz8oVaizM2QeK+dDA0o4yjaID
 mvBhhl2L4SAyfCwmtyikg8MqP2UcbjgzRuycjWFrUUk9pF+WWROKHG8fkvfd1ekBLfRdwsSYc
 HoFVAH2l7+eS2LBQJfLWkOrnGxxrdvbMAoQAGc1hXUBq6zItaW3+Z4SnoWpT8Z0JSz7OdxJZx
 B1g+V1zhExzbnVF9vz47ffzqe4ptrR55DFHlov5xOtzN8RQIEs5lUOHqjNkIbZcQIuSZpLoZU
 CrL0YozalrBrbJ97GM7uoA9nSw7MsUFaP56TueLnu2J0373TZAUtRdARu+1LTWoK5yVzEj8fZ
 Gc82KERsocyBgfDpn7fS+COJ0OxbY47IHvqsmxrNoRZ4j77B1fOMcFH3hO/3xJz++dU+Js9Es
 w7QFtdea5GDk7IAy9MiWx+38myTWs2k69PtztkJKicLa6NMp7/Z+r4JflOgijaV6gWOis8jCP
 rZsBGGp/5yZhgaToUfLOhxMIlJgNSk9GzNuBqK/41AQFF1Igqg190WYyb6Pht+lxF5QsjLXxI
 TpULmNqCbwfTNu2HgKy154dfB5sgk1mYl12E3OQyr2xBLXHelGt4eTJa1fI5LjvThSNsGfoUd
 yZWL6IKw7LFLgSGitmhjzs+V3vX0VdBoNs4Sret8puDLeJ1fbMQ+qJEvjwRWGrnYPaj00Xxyj
 YV3PrUzbVBRx0KLw6kD9sVaoit5Y0PHfCwm0HzXCyJNXAObqPE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a rule in strbuf.cocci for converting trivial uses of
strbuf_addf() to strbuf_addstr() in order to simplify the code and
improve performance a bit.  Coccinelle 1.0.0~rc19.deb-3 on Travis CI
lets the "%s" in that rule match format strings like "%d" as well for
some reason, though, leading to invalid proposed patches.

Use the "format" keyword to let Coccinelle parse the format string and
match the conversion specifier with a trivial regular expression
instead.  This works fine with both Coccinelle 1.0.0~rc19.deb-3 and
1.0.4.deb-3+b3 (the current version on Debian testing).

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Tested-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/strbuf.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 1d580e49b0..6fe8727421 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -29,8 +29,9 @@ cocci.include_match("%" not in fmt)
 
 @@
 expression E1, E2;
+format F =~ "s";
 @@
-- strbuf_addf(E1, "%s", E2);
+- strbuf_addf(E1, "%@F@", E2);
 + strbuf_addstr(E1, E2);
 
 @@
-- 
2.16.0
