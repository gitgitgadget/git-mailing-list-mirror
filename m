Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF88C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 12:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiK2M06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiK2M0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 07:26:55 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C95D6B8
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 04:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669724805; bh=CkS7oFS7sn4jN92pWWmKwGr/uuxaRS54kYeqEKNqhLw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=a80gvvYpEvCp/mNLkinhFTKFMbvlGRsnYyDdWGdkQKCjenfgzpqRmp9YCJY0CKQaV
         68ZVwRfWK/dAZoeD0WkQddMz21HmRVG9P4+4OHKMUzPrHAV0iouktFr6TTiUwONXMb
         2En3s/iGe5jAP7//IJRQo1O9CE6UjiXBhnqi0KRw7FHNt9/rml8DcY+72GG3FAu4Vq
         CbFdrDR+U5/WIP8I+X9tiiISzettNhbQfMyqX2JKnPoZ8ugPQbOHeQC//e6kBm9vCm
         qbKYoiGYGhqRXwv68KmaF6yn0Y6R6eHoRsYB+revSUjfy2sProd5GKVRTib50zBRQm
         e/7SP8i43dhpg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVsg-1ob4DS4C6g-00m3zA; Tue, 29
 Nov 2022 13:26:45 +0100
Message-ID: <accc4f29-8e8e-5b8b-9409-6f2ac51c2936@web.de>
Date:   Tue, 29 Nov 2022 13:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v3 5/5] list-objects-filter: remove
 OPT_PARSE_LIST_OBJECTS_FILTER_INIT()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
In-Reply-To: <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XmdGCGliL4y8k3mRdwwQdymTKZWEmRqA5svakbCetoQA4pqWSdS
 tuyenE20EvfacgLymXXX6xgbl642oS8mw46Rg4EFdwx0I9gPOTKmP8JSqfm0V1wSUV1jt7u
 N0tcg57ZPZHz75Eqo/yhcy4VM23wQwgZmiRuXWGaN2F1x1XEvFv8wtaVWWAERvacmmMUh2e
 VdcjAtqgly9QwnyYAezHg==
UI-OutboundReport: notjunk:1;M01:P0:kdSFbljikBU=;2yhnYTjphhvx4y7OBLuObmq+RPf
 jzmH7P8Btpwyu/CQ52zj+NISWdvMrBavM6UErRlXZ8V8pKq9FdSJ5qzWTCqUw3Pco+hhySlxd
 xIaN+GkNvjpve7J+X1iYElrUhTW+dFBW6wtXnYdXVlxWeS9Y0FxMIfVyrS0qYfP6ztXDz2Aik
 92iNUXXtVlVbNSsQTUJRszOiE/nMkJjvjwUwzrxfbRHpzLf1Ai7ey7bZMbE/JBiMGqBiuL/Sa
 MiDdb8nYTXHMgrc5cgMiHlWNF8zeI2O8aRYBupiyYj9Z0/OQ/FvpmD64WnE82l4wiFqukLwux
 3KvPlTFkTdrNM/J7xF/OfUplkRoAwOvMKzdLHUCpZdrfbkefk7bkVaeHnRMvkAVKuyOtVzUjF
 B8cXoS5CIEAB3AFKU0HPzKvhw34L+MWf3mCxWK5j4hWPucGbk6LsaPsBgmzcz7jwnfBmYCDeB
 LFU/xHs8Itqf3HYdHAsi0rHJOPQ7Ni1uamb+H0KHzL98bzRLIETd0gFarCl2BW1ikGxe9Hso/
 Rz9XsNBrWUeMvaNRxPV5S+Wtf/9EGL3cA5PR6ZPkeAGhYcjIXmEa0Bcsv2fG3zPgHdVsViehb
 ia/6hoMLL+51oTFtR3q71ZAfod6yyIU7Yd/MOrqbVXx+HsM3CW+rOHR/w9gSFZ0Why5o91bze
 Ha4IsThadZPGeg87+N2vIK1z1Y6hF2FNyjRcy6VwJVK2jj9YMugV98VY93cBal+ULSB7B/bf6
 AcB2p2YFDQjftxOHXRTAwtMFbsrpLcLM5uQ0fXaBPi+HshsO5ponkHvbMewhRBmTrBu1zvAj5
 iSYugKjaxSJg79fZVa47s4ckgYG+XM7W89kKoouWbtD8QEZIWxXI+p3SOI31XxgioOiVLO29k
 1aet83EYTp5isU91sppEFX9+mB1R3W2qKhr20N1wtsJVLs9gYiwkAby1CVNtBuWPxJvWD+wiK
 NvXepmzhK6EvQpOLxo5ltvuTKG4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OPT_PARSE_LIST_OBJECTS_FILTER_INIT() with a non-NULL second argument
passes a function pointer via an object pointer, which is undefined.  It
may work fine on platforms that implement C99 extension J.5.7 (Function
pointer casts).  Remove the unused macro and avoid the dependency on
that extension.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 list-objects-filter-options.c |  4 ----
 list-objects-filter-options.h | 18 ++----------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 5339660238..ee01bcd2cc 100644
=2D-- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -290,10 +290,6 @@ int opt_parse_list_objects_filter(const struct option=
 *opt,
 				  const char *arg, int unset)
 {
 	struct list_objects_filter_options *filter_options =3D opt->value;
-	opt_lof_init init =3D (opt_lof_init)opt->defval;
-
-	if (init)
-		filter_options =3D init(opt->value);

 	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 7eeadab2dd..1fe393f447 100644
=2D-- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -111,27 +111,13 @@ void parse_list_objects_filter(
  * The opt->value to opt_parse_list_objects_filter() is either a
  * "struct list_objects_filter_option *" when using
  * OPT_PARSE_LIST_OBJECTS_FILTER().
- *
- * Or, if using no "struct option" field is used by the callback,
- * except the "defval" which is expected to be an "opt_lof_init"
- * function, which is called with the "opt->value" and must return a
- * pointer to the ""struct list_objects_filter_option *" to be used.
- *
- * The OPT_PARSE_LIST_OBJECTS_FILTER_INIT() can be used e.g. the
- * "struct list_objects_filter_option" is embedded in a "struct
- * rev_info", which the "defval" could be tasked with lazily
- * initializing. See cmd_pack_objects() for an example.
  */
 int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
-typedef struct list_objects_filter_options *(*opt_lof_init)(void *);
-#define OPT_PARSE_LIST_OBJECTS_FILTER_INIT(fo, init) \
-	{ OPTION_CALLBACK, 0, "filter", (fo), N_("args"), \
-	  N_("object filtering"), 0, opt_parse_list_objects_filter, \
-	  (intptr_t)(init) }

 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	OPT_PARSE_LIST_OBJECTS_FILTER_INIT((fo), NULL)
+	OPT_CALLBACK(0, "filter", (fo), N_("args"), \
+		     N_("object filtering"), opt_parse_list_objects_filter)

 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
=2D-
2.38.1
