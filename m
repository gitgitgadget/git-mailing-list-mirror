Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3F3C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 19:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344DC2082E
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 19:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XhRwDAKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLGTRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:17:08 -0500
Received: from mout.web.de ([212.227.17.11]:39805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfLGTRH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 14:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575746212;
        bh=NkRyhW3FkwKRstoEEUMCpcCoRRlnc0n4Rod2+LlcHqE=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=XhRwDAKEuYlGNMMvLluXJFIs9co9cl+/M8Cnggx1N3kRpyWrxmh1gAvdwQXHZQ59n
         rp6CmrOd3xdKhaUxQdi3RCoMZz4jfrmeroEIGf3xgs+hCczftb/9ztpvbXcYX+qWHJ
         krKJy1LN+yL8+fbvo/9KrHmcJUCw7g5YeeggfLX4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOL4-1iQw9C3JwM-00Nm1M; Sat, 07
 Dec 2019 20:16:52 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] patch-id: use oid_to_hex() to print multiple object IDs
Message-ID: <bebcac17-f560-bb73-9aee-72f944df7d95@web.de>
Date:   Sat, 7 Dec 2019 20:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+r1zSQy9lrbFkG7fL6dTJXt/hATySDKsJalkDuykvcBPyoVMeRU
 eGiBmlmATyMXbTUqJke/F/dfU3bPIbpZJYYLRcQEYid0oX4LQYu+yTbs34FKvkZ5Psw32dE
 /IHkVxWCdH/Mh+2iuM0xm+dda9HQLYLD4ZZTs3N4X1eJmpdeh0Kmml4n9xZJpBCpxlYW2si
 mPo+xgZ0LchKpTIUHAFbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4YJMV6FtzpE=:CH93AeHENXwnHzWrM6EGoQ
 sxCzevgZT+SDnj1Yth7oyyAS6jeldKAggyivudkaC4LE1/BOKub9S73ettSnHGespwvKRk2gH
 873G9OvmhWYC0XgKBz30EoGf32dF1XGJKM3cQEVSg4qDuXqErbMm9vtR0XVuMDAYvTMLS/335
 h2bSFqq3yr26eEajL6o0kC7YYvVVAsbtnl4vQViiBKyiT6BXQzT/HiWVWY5dFcwfjZOMO8IOO
 QBjTx53yVO0qwRm8j6SSq3TbjMQAa3Jv/nG4ogKFNP7CnLN4DNoKgmRlPkIU/YyExGxJfcxWP
 jqPQCSk4JWe3SitZ/ITDBsxJAayDhnpHfcFkiY4uc/DF6/61RrTcb1FYgLPDkMOSi3bE7NHLM
 ODvDkmlY3yKkhpJ85ba8e2uudG08RDcgvPW04r7gZWhE7OoLZJKrYacyJCFepc6L1B7lnhIV5
 4XtU8m09uQHXzWyQLSurNUXR5pyxRx6GXHGoUWls1wxKxpeYQuMzEGpYHe3FswtjFFxzrtK+5
 /1LwsHToCQOQW1st8XKLjk610Lx/meUh0TDS5WvpAV2NOloWK7KU9j4GY0jlDxlCFy5pZQ1+t
 lIK+fqkL5DU89PivOHzQ0GMJbgxJ6hQxvF0bOKhD2Zj29//VI05GawVdyRmv1Cda7j70co/6E
 5RsjQEFrQIj2AZ1ZjwQuK2iqHbNQ2l48TeJuxId324KDydRmyyFpHl9rgex8df7L6HS6D1tcG
 TtADU/wCAfNCt5MqZ9eFD4/45GTYRlokkTWzpu4yzggj+uVX7vWpZydJCzlCUbmFGO5yfn4hQ
 SL5xuHXebxUdPQbN9Ir8pKs3GqVv+d6E8Y9W0q1zdZRmLPMnXZwBGGpRQ2Son2QGU5ULf2Pmu
 ezx2yS18FwPYHQI/56AEjbI86G/5CgIGgdlOzpC0ZspA3a4nZWNdYpCr/NEywvRl6DXNZLoM2
 a2iVl+qwJbca77HUaczzKLp8rAXfGZ9eTxW6+DhZUqN0pGdfEJ7Nq49Al2pSqdbSnmaF5OTUk
 cbMXFNIebDzdH24PRZToKDF8J/Lc6YJaIW7KWfH5sJo5Np5Tp1QtCPHltsFE01KjSYAvsakCd
 R/3DVvPNFsKORvFa76klsmPAER8BA0MrsrxJPjfS+j5ClW6qKuQapx3L8wh0hT2qOmEIN50u3
 SdrhLeh4Pb8YVzAwm33fl31ck54ZNFvoXFXvZaD91SDEaryF2Es38aWiqeU8iN1zguIDds5pw
 0fdPalarJ9be0DZ37RcF2mZUm16VMtfCGclVfsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

flush_current_id() prints the hexadecimal representation of two object
IDs.  When the code was added in f97672225b (Add "git-patch-id" program
to generate patch ID's., 2005-06-23), sha1_to_hex() had only a single
internal static buffer, so the result of one invocation had to be stored
in a local buffer.

Since dcb3450fd8 (sha1_to_hex() usage cleanup, 2006-05-03) it rotates
through four buffers, which allows to print up to four object IDs at the
same time.  1a876a69af6 (patch-id: convert to use struct object_id,
2015-03-13) replaced sha1_to_hex() with oid_to_hex(), which has the same
feature.  Use it to simplify the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/patch-id.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 3059e525b8..822ffff51f 100644
=2D-- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -5,13 +5,8 @@

 static void flush_current_id(int patchlen, struct object_id *id, struct o=
bject_id *result)
 {
-	char name[GIT_MAX_HEXSZ + 1];
-
-	if (!patchlen)
-		return;
-
-	memcpy(name, oid_to_hex(id), the_hash_algo->hexsz + 1);
-	printf("%s %s\n", oid_to_hex(result), name);
+	if (patchlen)
+		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
 }

 static int remove_space(char *line)
=2D-
2.24.0
