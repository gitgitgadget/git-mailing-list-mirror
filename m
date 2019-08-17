Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5251B1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfHQQTn (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:19:43 -0400
Received: from mout.web.de ([212.227.15.14]:33445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfHQQTn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 12:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566058777;
        bh=avTcxFPej3AsCKvwgIJis5GlYnO0Gjcd/JcGkQpYlaM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=BV4piyFHLHiesUA9E5h5SOMjakgJq6xixhmygZrmlWMOmRCtOhZtS4Xu1KzkWlQT6
         Q3rUbF8M2DKWmeKtLDQrUoMbVJ23msSmisRBu/de8cHZVQtHOQQh3RI6pbVsPjN2Gl
         qpqED+wK/cZFrwkYPsWMBVx5ATXGMtdeRhFRCzmU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2uXO-1iIU5X0ewQ-00siIo; Sat, 17
 Aug 2019 18:19:37 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/4] fix pax extended header length calculation
Message-ID: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Date:   Sat, 17 Aug 2019 18:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4vMk95dI/HB8kyn2PGgNLd4ygY1Y8M3cBRXVl/usj3nN6+QyaeN
 qchIq9LsaUEsNXwS3PjoxSEGKuTCZNAc5TWYZawR0clGWLBFbfnx8Ymy4u1KWMRXRKlHvcA
 rR63A/Wjb8D5Isntb8D3gx8CXvqFs32ExX9zLMEhXUoS3aftiAjNpUa+wVNZ6UfPjhpzW11
 6F5S1MUU9bwXhZUkoF3Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PfXoNaW/B1Q=:IEeTMVP1cge5TaPiY/gUXW
 +HFq/6FFfl4ZaKYIxvNzCSLldynBFKdV+Sb7bY5XUCZ9Gx7qpkXAk6xq2IQ8A1Qd/oXuLN4U3
 +ejSKnTEhbDBIcC3oZnhNd1SNN3zShUDJ9J/QhUyklLAiz71FMPA66CyDi++hAsqUvneGKlLN
 d9kUnvmBRCjNzYX38J3pxe527bj+IR/sjk/2yHrzj6dGPzg7FmexrjmRvFhFqnetulvjtZzBq
 G7UWC+JNaTv7eP5yFQFKCMlbaPxLbvPgDAYQp3+jhuEkxHqgQFti/IBRBO3h0/6jZGk/bIfuC
 9l5v+inTjqtWltkTF+xMg3L2PKT66xIHNPLQqESBZmMEr3pRbcijfyFPIYoFZjdafvnG89pl7
 rWh+QXFNM15Do02tJcOKBA0uUwfrLVJYZZS4GVj3CH9a5gD7oIs9Clll5lK+DgASmQgpJK2YO
 Kb1ADNkRewh25vxTJZvhVmhV8BaCm+HzjDKpyHsgyTX4Jy3wPU1UWxtmZHVOpxk/oPMHJGud6
 nAYoP0n4TBt9sCP5RDI4trV6bQkAfFIa4w8E5LG7i2TswWg0Nlc08WNGRfnFOVerHhVsEbPW+
 C2gk9pJe3VScMLSVjZgQelR6nBfEwAczzkEPsOMDsqSxntxt2eck+tPqYhLn+ADAiq1Kbc9RQ
 EoKAI/268V3dWJX00YEpi7Hr5mLxtPojHNciNKvBlHNfIIZ4wqyAPXkgsCUu3qRsmYdAJoycB
 ZgKRpgM6lTBla+618985QDzsKtOP4JYivblUOsoaG5XEgM3yV3JrX7R9C0UpZFEjZe5KjpQUx
 5t3Hz2WPaGVKC6PCB7Y7SmqC8AogL+V9AZrcAyL3Lu2CFaoww2m49sjfIkuq5CQ/uKaeoosuh
 2a/YjaMNp69y0LpWKqyr4Gi5H7wSVvKs6GGMbP508mPTyOwkAyub1ZBNgqsOuwrX1g7SxBkBm
 6DWKyafaoSLrdh7txpSWtkIl3HM5Z5NbRuZXihfQvuCQMzEb/xASSI92tBkH4vDf67M4PIpGM
 7dypPqjP6HrcZak2aSFi3ziRKG/NsmCEwKqu1ptJbnNCQvt+76FtFD97xYsVzNk3HyWM6gTBT
 vg+hcHJD18W0vbbHYqby66j1Sqm30U8rAMMmon1VzOGFybr66IlDbaOibCLD6tanSyVYGd99o
 ZER5E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code for building pax extended headers has been miscalculating
lengths slightly shorter than powers of 10  since I wrote it in 2006.
That affects entries for paths with a length of 990, 991, 9989, 9990,
9991, 99988 etc. and link targets 4 characters shorter.  Here's a
series for fixing it.

  archive-tar: report wrong pax extended header length
  archive-tar: fix pax extended header length calculation
  archive-tar: use size_t in strbuf_append_ext_header()
  archive-tar: turn length miscalculation warning into BUG

 archive-tar.c                   | 14 ++++++++++----
 t/t5004-archive-corner-cases.sh | 19 +++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

=2D-
2.23.0
