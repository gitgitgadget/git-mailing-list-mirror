Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADB8C43217
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A061881
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 05:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhJCFxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 01:53:53 -0400
Received: from mout.web.de ([212.227.15.3]:38271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhJCFxv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 01:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633240302;
        bh=f6++xVSSXhIl/aQPORwrEf3NEMtU6REOuJRmfp+Fnmo=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=k6OOBCfpymj0DFqEvThOwVDznVxY4J81sWvqnLHaQoezEirWjVqan2AXDqpfGZ52O
         uWi5BhIUFF50u4VLziDTOWlk9x5W37CfqiHRH3KF1POF+fhbG3JslgyUqGyVbLRadH
         I9BCYaKXMqckxO0jBNeFTimYjj0rYaulsV0ILi+s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N5UkQ-1mrO681kx0-016sgW; Sun, 03 Oct 2021 07:51:42 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] hash: reduce size of algo member of object ID
Message-ID: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
Date:   Sun, 3 Oct 2021 07:51:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Jtu7HhOJ1A+op4z1yI3rbKvPPSB3l3O4la/hbbMBk/IBZuQKVY
 faXICr9HN6soc2rzMPCPkhIgcGrFIMeLMnnsclKpGFecAWjjrlFaajtZ2VoonPdo4YTi0Rs
 T41kzpk0LYCQoOMQYIvBsozw2dffQnXGidevVBIKH24aYgyXQ0YSdKN9ogsyz0uG9P1VIKe
 9E9myfLnD16N3YJGeoL7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:icP63CY81Ws=:dgIPdm9JvDaklTy+tQq4US
 zQ05PqEBbAtKwKTwM7YJwgYyfJ1ns5I0atnRh2gxvcB1OcOL0JN+vRki0D1/ZaoMcYyP10HNG
 u07GLLwtmPJT/Trnz+UcgkulMOFt8mpn8mpuZc0hx3KLE00vwQbjhw30RsHI+yJxSwNSLehXd
 egAjPwo9vB3c7Mfi04djPyzZCBmzCynWyiUTNfEX32lTzQ9CBcR8rBaaNLe/R8NlnANf6fp5f
 Vz66O7w2HaRtnQPTnvb3C8bgNVV9+pBE4nEf75I/p+KAxIpPUDDE49oL9SZMUM/XWG2G03ZO8
 7RPhMbyQZmY6aZZ/jHFFChR1iqGLKOyzT18CCR3fUOJlVZVSfVB74qPeDgagzKfszTWrZN/Eg
 Mt4A0fPVJLmegdtP8MLRjEH796r2tNvaNUuKipTe0K1WttG5jBsz7VY5AW0++2ruwDxtyIwfU
 swVYu1JFOz4WsT2pwhzF70VganKcy3RshY9nqP/oJ+T/Iezc8CANJq3JELDshhhk4wYuJ3FyN
 a11FgwpGeyQ6lEhRs1u5httAMitCRCLPVhMg1M96p8cIJrp5OzeS3B44M2F4BNTdHXpA9X7Ob
 YXln/LlgArotjBo9GU4BA4xLmmg+TEOJLNUT/GTgSXQPgJxw9RtCQfAfnw2xpImg9uB1Ijrdv
 CbkDVcL3phOvZc2OqBNWuiB9FJB2PurYdSQApLUNIB51YdFbDQidepKEFoGG2Fdi0kMqpksFU
 HeBWYDBiYfNz3Blm+5VKsc0avjfXAD+SFNd32TzrN35fMyccNtJBg7CEdPoobZMCWI7eqcZEY
 ym1i6hxY8b6aFT+VIcVn+Zwe5Nf7RX4KBJUgBswWi+Jwm5tYXBvH43Z3UXqwNw3ttuvBv/asd
 I04rkpFT7U/Uw410n5VSk+u7iI0frXLOei37d15l/AcsQ6yTGoPuBK18zKfuJoEpFZI85/07T
 KLDr112Pju++f2lfoJlGEOmAqwuOlcLJYg6m8AcF0fqkd1C870+O073Mb33NBeBUPzECAuRf7
 jXdtB3JPlGzIJaUKFCo7cCgaqM60+0/D4s2kwus3+rK5oMt53QjWIkq2JzSDbTtPTuKbh4pJ0
 WNa7dsSIgdsK4I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cf0983213c (hash: add an algo member to struct object_id, 2021-04-26)
introduced the algo member as an int.  This increased the size of struct
object_id by 4 bytes (12.5%) and imposed a 4-byte alignment.  Currently
we only need to stored the values 0, 1 and 2 in it.  Let's use an
unsigned char instead to reduce the size overhead and lift the alignment
requirement.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Not sure how to measure the performance impact of this change.  The perf
tests mentioned by cf0983213c don't show much of a difference with
GIT_PERF_REPEAT_COUNT=3D10 for me:

Test                                             origin/master       HEAD
=2D-----------------------------------------------------------------------=
--------------------
0001.1: rev-list --all                           0.11(0.08+0.02)     0.11(=
0.08+0.02) +0.0%
0001.2: rev-list --all --objects                 3.04(2.98+0.05)     3.04(=
2.98+0.05) +0.0%
0001.3: rev-list --parents                       0.05(0.04+0.01)     0.05(=
0.03+0.01) +0.0%
0001.5: rev-list -- dummy                        0.21(0.20+0.01)     0.21(=
0.19+0.01) +0.0%
0001.6: rev-list --parents -- dummy              0.22(0.20+0.01)     0.22(=
0.20+0.01) +0.0%
0001.8: rev-list $commit --not --all             0.06(0.05+0.00)     0.06(=
0.05+0.00) +0.0%
0001.9: rev-list --objects $commit --not --all   0.06(0.05+0.00)     0.06(=
0.05+0.00) +0.0%
1450.1: fsck                                     20.20(19.71+0.47)   20.18=
(19.70+0.48) -0.1%

 hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hash.h b/hash.h
index 9e25c40e9a..24d8f7cd21 100644
=2D-- a/hash.h
+++ b/hash.h
@@ -115,7 +115,7 @@ static inline void git_SHA256_Clone(git_SHA256_CTX *ds=
t, const git_SHA256_CTX *s

 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-	int algo;	/* XXX requires 4-byte alignment */
+	unsigned char algo;
 };

 /* A suitably aligned type for stack allocations of hash contexts. */
=2D-
2.33.0
