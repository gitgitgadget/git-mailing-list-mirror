Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428B2C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 22:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiL3WC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 17:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiL3WCY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 17:02:24 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99BFAEE
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1672437740; bh=p5NLklPgxYdEN6F/t75APaVSodm8nwlQZ4jqnZt8NMk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=sKzlrv7a8gggWFb3udJ61aWCFsTi2AekUPZdIsVsn/Gq0jIw/FC6g+xlOeqbjUhN/
         KyCtxo0dCa5lGwuzRZUA5Giaxnfwt6g2w83HVwYxFEDrwiL9glD8muwTxHx86qWIrR
         NdXTL8DZWoyrT9S+3z03EkB+ni5G+TCj+hbDzgJgewRCgDZ1EvO46Prf/1BNPoHq79
         SC+I3LOQ9ACe6adh+hzBtOYLuzHIU7bhFMJC7VY8KFaTTzkvVR8utCXTnO9rPg+nPn
         qfCY+4D6VYUaEolnMsooaA8xdL6lly44UDLsy5JcCa31I+/3zzpy21BIriqtXLMxWj
         zpQMjXBHq1STQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1oTYF949Am-00iLZl; Fri, 30
 Dec 2022 23:02:20 +0100
Message-ID: <4dae3686-1183-0e70-a1c8-378b1cb91d23@web.de>
Date:   Fri, 30 Dec 2022 23:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: [PATCH 2/3] add DUP_ARRAY
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
In-Reply-To: <efe7ec20-201e-a1c1-8e16-2f714a0aee8e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NDG/oacjsFAG8jZaClVp7Z/UiRZBL/jJWmymUeCcv7sTSK7JayI
 IFeQFrWiUffuMmdquYP3cFBwVfez63dsnvitCZHP3qtAGLetpB527tufE9OhTrGL6JMha5E
 /NeppFLAAYukazB7se8c/CeNugPJpzHOonZlXAVVBPdemp5j6jWfOsFdlKJdEuS6arN6ni/
 Q4pLZXICzbeYkPFPNABfA==
UI-OutboundReport: notjunk:1;M01:P0:p02tdqvZYus=;Q3GRbgNFMUFnlhjucyc9mIDSBO+
 R+14Zhr4Ns+aqOeA68+ha0BpTt/XGw41azYcTwMhkU+nmAw0ubCdHqZqrk0gxLwKcgDW3Iyop
 WtSQFPlbAgEwWUS+90g6WxGyv7KAKe1v6RhTWtmVhoYHpgpFHq2VjEfdWRBy1vy6lk5fHixFz
 5oXgSEf0/4J1CbV5TVlm+8PDRsDSXWmBKZUtCSs4IfCL6+r2aHE4blVahzpdl6XbfLjNPeiuc
 pzg4dOo8Vct2YVnbK8AveRWv799+COMmjJR6+yB5PAn8knTKAv1gZUGiDmJdQ2+zOAlhUKSoV
 llhEQrrH521CPFpmXou9h+9ESk8y0LfzJ4nR2au7b0lYl1L4kaLSFsZSuyg1RxWNMQAEqnPaq
 z2Dq25crUgfyljYl5U1UT71xYppkC6Fm2+/ndAPrWxsH8o4zuOK2CTHISR2XTweOjyj4z4pQz
 uXE+WlCSKGadeQfAxaArjG+0zo/Ib0ExlpSPe8VyifNqa9jUwqtitwjMv3teT0n0n7GfThDPC
 lehlj5sdDCiFR2t9N/UfzME9jH41QmNsuNF9APBnF39xZZ6y40VX3FAkYA0ao0j0+4t1/r685
 74DQZfyRvsrt6jv1fjUm5rv/TcbaTHlZc3mQPQ+2NhPWEEMxLIe3tSff20wmSznwnWSeKPmR6
 N5A+TjLMafSr0LUDWP1t9zYmCQqPk3XO1OfN3vBlwC+syo0sAnppd9RGBrJQVBtDhX+ynK/sk
 daJ2VA8OSDOOBA3jkipO8R4N1yQ0+JzETJupM4MqebipiEU8YvezoLbS9laieR4BCY0ZxhffK
 G95Xa+JilMtNragPBIYtOqtkKT/7Am+dH7qWAw8y3CVRs3Vvp91Wbny+LWgmOFA1tX8SHrKe7
 BQevVNnUy4Rb0J+NP2ncy+6BE3wJ07NydCHh0zz53B2yhempiRr7Ekty8C9aojriAEfCui3zK
 EIwukg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a macro for allocating and populating a shallow copy of an array.
It is intended to replace a sequence like this:

   ALLOC_ARRAY(dst, n);
   COPY_ARRAY(dst, src, n);

With the less repetitive:

   DUP_ARRAY(dst, src, n);

It checks whether the types of source and destination are compatible to
ensure the copy can be used safely.

An easier alternative would be to only consider the source and return
a void pointer, that could be used like this:

   dst =3D ARRAY_DUP(src, n);

That would be more versatile, as it could be used in declarations as
well.  Making it type-safe would require the use of typeof from C23,
though, as far as I can see.

So use the first variant, whose safety requires no compiler extensions
or future features.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8d04832988..29f4f699b5 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1111,6 +1111,11 @@ static inline void move_array(void *dst, const void=
 *src, size_t n, size_t size)
 		memmove(dst, src, st_mult(size, n));
 }

+#define DUP_ARRAY(dst, src, n) do { \
+	size_t dup_array_n_ =3D (n); \
+	COPY_ARRAY(ALLOC_ARRAY((dst), dup_array_n_), (src), dup_array_n_); \
+} while (0)
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
=2D-
2.39.0
