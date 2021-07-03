Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34068C07E98
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDF661456
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhGCKIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:08:40 -0400
Received: from mout.web.de ([212.227.17.11]:41045 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhGCKIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625306747;
        bh=mUAk+Ci4QQb9pbGGjfFXUUw4Jdo1uDFFnIc4FedSW88=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=JZ9oQe550Uyy0SW0n1EDLykd6db1RBucllqMMjlYDWnhiVo2y8t+j5om5JkGpBDSA
         E6CRl21TUeIb27YOB1jGA7FErNA8xn9mLIkOngYIuWqNAdGMMA12F9vO6R/QVYSb2B
         OFoApKWT53wEp9WRVVXXR+lk2Ci3GBkXDO/cKcl8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MsaRt-1lC3we0Lxj-00u3s6; Sat, 03 Jul 2021 12:05:47 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] khash: clarify that allocations never fail
Message-ID: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
Date:   Sat, 3 Jul 2021 12:05:46 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1LIYbOhY1P+31260HKu7VoHSkbkpcCV3DMs0ZV5cf8TQTprpRAi
 5jOZaACP5KJUVMXh3BKrpbMqu4RUcy9TsztmafJKor7nR9Xj7s1qgzNLpw8c15b9XB1dCyz
 7HrkvGdZ9/QhsbL7+v2WoI4zXsP/EOIp4aW55nw2plx5i+M+7Y3wbXUvmGgI5FOPoIA8fKl
 TkmfJ+vx4D9KrH9j6e/7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGrvn9g9B9s=:6Y1AO87bSPzZtaI+w2jzlf
 kM0ppbDvDP5a2OksI8mmtfFGnSD/9gEe5EhmQylWj2N0v8v5PEEDVpJ5kfjkB4curRdCbV0Hx
 +Rw42A6o+oa8ACZqj8i7lUzJpCvW1n1hDbdDr6GkxpCCzc43VBRroHNJBQ9C7izcn/oMl63ZB
 wqHrtpf5NE0HurU2IiHm65F4tylWJuelpQLToDxAvewKiO4Tmgn/SPLLIGupdH6MJMMqbbNDt
 I6K8inCdyVRJCH93ZvOaeYJGHEznfTUNjdRQq/Z9K9UZISkfeaCKhh/bnRS5LPSz5t9YI2jSl
 zj281MrX9ZIg5Sizo8iU9fLjpI0F02kYQUyvv9Sci42I6LAQIQBdOG4QGHTjuriU5Hd+uBi+8
 kuc4uKz7zh2b7vdN3JU08oSEONtU/xNU2+xDTT//X4KasiEqLI/HK/1gS+7ue7CbpgdTDkBxZ
 3ISTB0i+5ySGyF+GD9yX4XkYn7MfmkIXv+65JiZQQWht8ddgq2DwrENnZaF6Oju4Ann4wNm3w
 Ip4LMtLMJCEc/oc9ihh9tMvbwjiNsIgPWt/UkkrumOKJEMgz66sUgt+tU0VJnJ/eYhfx2WHRx
 dzf5ncMFZZLskJYUwuz3yuHGG5O/Kx/Z5nhTx0I3JNIn6jPkp1nmtHPdLFxduL5knzEJ+bbH3
 u8XoYT78bmGoixbVuO4KyP2mHVopZ2JAQWPtGlpEaXTYHPZCzsi2vbZa3s4fajylGDfC/rH+h
 ZmnZ+R+QFrUoReCVZ/OjvxESdvmAlG0H20dVwR9cBEchhM6NmaDoXGyNyuJPoZXT8GXmJ7gf9
 1v5uOFzqVIvgV0BECeQ4Gq9Exb7VOMLu/CaJDGGQRUSPoZnpDW8IRdJOVNrlyK8lIz7DhUGfm
 mhRtQhJcUnvANxcJ6QYW/UgUU5QVrHqFfN3eGdXZ2Q9kGiIcedclcfdKs+ALXrxTZe3CkHXFZ
 HQ3Tvb0Gi/DWpTbBjvqrr5Cbp02Q/nfx9bbKupWRYvSA9CglUGQeyjqJPI3CjWRLr8vlasjpU
 wpJJIirTLLqmVFfIR+04qNS/+HYQi5SM8L7VkcnsAmtgKe1SemyicX4zNRuCpHsA+npF/Swow
 x8GM2AiB0p+imwJOX+AupSQt2Fw3SFoLcda
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use our standard allocation functions and macros (xcalloc,
ALLOC_ARRAY, REALLOC_ARRAY) in our version of khash.h.  They terminate
the program on error, so code that's using them doesn't have to handle
allocation failures.  Make this behavior explicit by replacing the code
that handles allocation errors in kh_resize_ and kh_put_ with BUG calls.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 khash.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/khash.h b/khash.h
index 21c2095216..84ff7230b6 100644
=2D-- a/khash.h
+++ b/khash.h
@@ -126,7 +126,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
 			if (h->size >=3D (khint_t)(new_n_buckets * __ac_HASH_UPPER + 0.5)) j =
=3D 0;	/* requested size is too small */ \
 			else { /* hash table size to be changed (shrink or expand); rehash */ =
\
 				ALLOC_ARRAY(new_flags, __ac_fsize(new_n_buckets)); \
-				if (!new_flags) return -1;								\
+				if (!new_flags) BUG("ALLOC_ARRAY failed");				\
 				memset(new_flags, 0xaa, __ac_fsize(new_n_buckets) * sizeof(khint32_t)=
); \
 				if (h->n_buckets < new_n_buckets) {	/* expand */		\
 					REALLOC_ARRAY(h->keys, new_n_buckets); \
@@ -181,10 +181,10 @@ static const double __ac_HASH_UPPER =3D 0.77;
 		if (h->n_occupied >=3D h->upper_bound) { /* update the hash table */ \
 			if (h->n_buckets > (h->size<<1)) {							\
 				if (kh_resize_##name(h, h->n_buckets - 1) < 0) { /* clear "deleted" e=
lements */ \
-					*ret =3D -1; return h->n_buckets;						\
+					BUG("kh_resize_" #name " failed");					\
 				}														\
 			} else if (kh_resize_##name(h, h->n_buckets + 1) < 0) { /* expand the =
hash table */ \
-				*ret =3D -1; return h->n_buckets;							\
+				BUG("kh_resize_" #name " failed");						\
 			}															\
 		} /* TODO: to implement automatically shrinking; resize() already suppo=
rt shrinking */ \
 		{																\
=2D-
2.32.0
