Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1224C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C766113E
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 20:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhIKUh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 16:37:59 -0400
Received: from mout.web.de ([212.227.15.14]:47691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631392601;
        bh=TBENYHRuidEXPW4q60M8UqfnKK4nNXC+h6eQuRplbSE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=DKRJBYsgtYSMWHEF95deEXcf0rY2Vi5GbpbPy/Jm2d6JTfRp6pW2WakrAUEiIU2cr
         kw0WI0gy5OQKLW3HujQayqIzwq4IIbntMkI81SkYCMZl/YpjqAfRcOkDpDRuwpCDyr
         luTlzK6NPTmGyqAu1tZw4jCU/94686EgaifinMgg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MP047-1mJuoB3PNv-006N13; Sat, 11 Sep 2021 22:36:40 +0200
Subject: [PATCH 1/5] oidset: make oidset_size() an inline function
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Message-ID: <3ec3b543-d5a7-5dce-ea5c-243ae8c78fbf@web.de>
Date:   Sat, 11 Sep 2021 22:36:40 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sxA8awsee+hztngUVfqNzQfrR3mb8N0fb8ZRTC/3DEVhfmYjktc
 +6yIXk7yncaZF5aEpjLjTAvAzMUS6CZjaVM7JQ0BusYU6x3oiWFCFBCY3Omb100ilo3c69q
 OhJFwmQjDxLayWXfRd27uMyO+PHvStC+9EbpkKhUCDsACzRuyByTBZLc/TWnbdkeMflHtB/
 HL9YoKD0cMLJ/eCBa/U3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uQ48txMlZqg=:lPsNvk3767mAs/o+OuGRDL
 GpQjuv8oUJqOxP4j+3uS3nVw4xBfgRGY4AvoHq5SiEUTj/+KP1RB/bkEzpQFsBPd4+Q68w6VW
 GxFIRSYF/ww6+APoWtTi09u/FbHDpa4wQxCsPcF6aGw8ErIW487iF8bWHrtzqCx9biHsbUimK
 PnetkNHmL/gFzd6+gyx2D29KEO+xOTaRAiWtpWQ5GqCNUFmj6q7NU92hPZ+bYbxne5YraWRKe
 NukmX1gNuf0pEjdyExvUEQKiVDdmItyIPHlg6R1Ds7oW2/Oe5Hw7zkNUEJZWzh6oCl4BJVxkl
 ppYdwBD9oN3hLpx8PIElkJiUSHuHDtbpx9RKAbe5JVdqCC8vrY2xSg/n1d26BKw1k9gjRV9L7
 9tQweNGlpEGo0MlvoGqCeHcGCoY/95Tcg7YGSS554+LwmmbYnyq2tf/87Yem3jAXOW0aG1pKL
 OV9BSq/L0P1OrAqwcYWBRDldGl7hjkSpvDvF0auadlY+DEnBhLtfQv4iseJcwnvLj7E29x+hz
 k5EZdvtb+mrRT0c/CCnSTifsSptE2NxilvxK3v/1KlJj5lHK2NfOI+Gz/AbvnafXg2EucKaUV
 lG79LTlFg9w9b7q8V28Wh6xPR74mgb1QRyn4hyy3uJSl3PAwkKUups/uVTdaTpWlyo8FVpGQK
 rONHAMVLsmNYObFibyPEXLVaZDK8fafVeu9n5j0UygU5sZXGbYUkLMU84Ei8iyATz3VASyqNj
 RdRXGWGMLQSMJ1OorMasyZRPPcrAUIzhOqfJ8YUWsLTKEQ+6qDFBNd5IbQYBbKdLcIPGzleC/
 Ps2b68wQJzYttobOSLklehElrOwA0QW7tlY1ArCnJ8AKiYpgVe28RY6cLcUUbaB/fnSYnfUvz
 wQLQX9FRhigwjjlMK4JzZ06x24s4JY9ebA1qjihIwIy2AdUAHKnOOkM0glC2gFO2OGiCcWAh9
 D1MkeRKQ7gyyKLk3tWPGMOU/Xl7Uf/ytMoEiPxLwx4k4hEbQH8tYHuO7i65nfopT+IKa28/Yn
 EEUAau0mHHuK/j3JNvfY0FozH645awMZRcTwrAu8iUvScYU5kIffc4zR1qqXmg9X3TL6F3D5Q
 aVKJSKxGAts890=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oidset_size() just reads a single word from memory and returns it.
Avoid the function call overhead for this trivial operation by turning
it into an inline function.

While we're at it, declare its parameter const to allow it to be used
on read-only oidsets.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 oidset.c | 5 -----
 oidset.h | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/oidset.c b/oidset.c
index 5aac633c1f..b36a2bae86 100644
=2D-- a/oidset.c
+++ b/oidset.c
@@ -36,11 +36,6 @@ void oidset_clear(struct oidset *set)
 	oidset_init(set, 0);
 }

-int oidset_size(struct oidset *set)
-{
-	return kh_size(&set->set);
-}
-
 void oidset_parse_file(struct oidset *set, const char *path)
 {
 	oidset_parse_file_carefully(set, path, NULL, NULL);
diff --git a/oidset.h b/oidset.h
index 01f6560283..ba4a5a2cd3 100644
=2D-- a/oidset.h
+++ b/oidset.h
@@ -57,7 +57,10 @@ int oidset_remove(struct oidset *set, const struct obje=
ct_id *oid);
 /**
  * Returns the number of oids in the set.
  */
-int oidset_size(struct oidset *set);
+static inline int oidset_size(const struct oidset *set)
+{
+	return kh_size(&set->set);
+}

 /**
  * Remove all entries from the oidset, freeing any resources associated w=
ith
=2D-
2.33.0
