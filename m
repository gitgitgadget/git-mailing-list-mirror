Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4221F461
	for <e@80x24.org>; Sun, 25 Aug 2019 17:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfHYRoU (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 13:44:20 -0400
Received: from mout.web.de ([212.227.15.14]:49279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfHYRoU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 13:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566755053;
        bh=kc+AuxhGtnxTQf6GS+siJzFM/SF0Uqp/xovJrGvK42c=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=TcmIX9rWbLpq0l5uGNFoDg/xE503H4hSOOdeQuiJaEBDIspwvJS4A92B1R+571A36
         YHp9cSljaPsXwoMd9vu9JuoJSAlrjpe9aYy7ICYr/f2s7JHosb7/PVE5XYowKGVvU2
         WdGm0dZLlxsXA4v9GNLTIW15pEWatT4iMmU1f3os=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQ8vL-1i65Z020sF-005M56; Sun, 25
 Aug 2019 19:44:13 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] trace2: use warning() directly in tr2_dst_malformed_warning()
Message-ID: <2492824a-6aff-8b82-801a-808ee944a99e@web.de>
Date:   Sun, 25 Aug 2019 19:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a//eyYVJ4ERynp18caHSyBki0gZ5Lhjz6ZAINacvk0IntTB1GX+
 CZila9EvrEJo4KftD/DcH/KIy808tR4Go8mh9DSP9QC3p1cN0mpk3HDJ+FNIYPOeguMX8i7
 8W92BPot2wZMWSlinUkUS5g8KT8kJxBP282VvKHvEjiVzi9Xoawli4OUNm9/PB59xCCnLvg
 HBoJ97GP0IctqoSh9vCcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VuZS8G9GZbM=:uPNDJzvlWgGuFGSjk2uyMU
 UMguv+iRE8HKGdfAuoMF/rbQ9VYC8VJl0f9ER8WzKlep5sI0/m+ueuKozVuFusBNjDg5I4cAk
 wNTVA8DP3YUsf0fM4wnV28/+tGFRPOf6Mml0I19bgFsuyqFZZ+mhETHBkRaiUZJSC3FSqXrsQ
 +LW98bizQnv40iVdjqDJr/CdMzTqT1QXSfs0jogd75AKJuihmNBLk9dpuYyXj5ppkL4Q9+3VT
 rlM2H3dp7TEcP/y3NboffmNDpJStfqzveKaXg5f9bk5GbTDBCCafvnMnxgCsGAScb4ntR0S3H
 f/W1TdpHHCM9+lV9WU3YVQgDakCh8DQsy5Ve7WwKPVqVCDjzXFxPshFkv4kNto5ac+DeAFELl
 4wKSkMj02u65EVLjtPihuH10/UnqoLoTABueA3lS11ueNwNdvpIEnlaCBsPmTWIjh7ILXYNlD
 qIsCMCDEzKG5xXIpj7SyU96U8WV0xQ8eJnlmYNGZoCI2Jvv5PDPxg4MFfJGKXrzI6mEOggGBf
 M0JV8TMLvdlk3230OuMIPCnHVtr8arwUlTdOCoLk4+/H9tZfFshcGkuboryUQmUycGfGv2pIZ
 jzi7Z/HGpaQkci7qbwXBkbcvmlzTnPoSx1EWjCLaRA2b67PdeZAxtegYGM0ydjthf4Ayt5e9s
 ASdmtKMmGKTdDiyStbIqbUmK9GaZLgry7UmYRUTdJmvakBPea4byYXFUwE1672gfGpUFKeMMU
 QL73MnzIymgWcs7AENXxlgCKYinNYTAR92QIgtE2gM0lDac+50zcjCmyTRmxzrCiFd+nE1myh
 20LKdw9xbo8NynfeiYyR5Cat4gcaPzY1joObzNniCfUNS2afL/Mpqyi2BlAPvMfOQoBaBXQBf
 92nqUrZMBJbbvjW3jG9HQYXXKHJNcQSb27+ThQ5mGyXlgkr+6FKx3LXDcB5z70PbVIyR48m09
 yYyT2uq/dwhRp/9D9qgyEfk9oqLseKu8Tr8h1g4wDvPaxhOekr2duR8UAkPDWunWQRqS1mbr4
 kq1xPvG0XPtdiIlhdkXGp0gt66A/gTDZPRr79ySgsuPGjWIjyoLCIgcEzdpFFvUF0rFIr5z4y
 Y+9mkHWlWLjos9Qh2xpTpj5FvECx37Hw/fL4SNepAIP3BZpZgsAVL4LFhd+tvrlRyBqPBYSbz
 pHZ60=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let warning() format the message instead of using an intermediate strbuf
for that.  This is shorter, easier to read and avoids an allocation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 trace2/tr2_dst.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5dda0ca1cd..c69857515f 100644
=2D-- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -215,13 +215,8 @@ static int tr2_dst_try_unix_domain_socket(struct tr2_=
dst *dst,
 static void tr2_dst_malformed_warning(struct tr2_dst *dst,
 				      const char *tgt_value)
 {
-	struct strbuf buf =3D STRBUF_INIT;
-
-	strbuf_addf(&buf, "trace2: unknown value for '%s': '%s'",
-		    tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
-	warning("%s", buf.buf);
-
-	strbuf_release(&buf);
+	warning("trace2: unknown value for '%s': '%s'",
+		tr2_sysenv_display_name(dst->sysenv_var), tgt_value);
 }

 int tr2_dst_get_trace_fd(struct tr2_dst *dst)
=2D-
2.23.0

