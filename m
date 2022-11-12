Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC6C433FE
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 10:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiKLKqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 05:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiKLKqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 05:46:43 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F315704
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 02:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668249997; bh=CkS7oFS7sn4jN92pWWmKwGr/uuxaRS54kYeqEKNqhLw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=D4JgU0GjN1YLHqO15k4Ji0w7MNYhjeRAI/xMcDj/w5Tdf5YGMfWjbJIq1jGQbYMPN
         bx0Ywh1Sx9rvpL8OHxe4sb8DUEStVGfAx93OW0nmu9qPf/W06kbomSUhgg/O9QCh0t
         +m41O3ncNdNwcWVmbFAt+87EhP8U8hw2hNMB5G10Vlgfz0ewOFhpYsXzv5oQmaP1v8
         dWlbDXS309LZUqQ3zUSqhUsbIOn65Lm/8FZwcEQrsXW84pbH1jhKNsPtzFyZa9x42n
         jXzzCZeu5Kq2iE7SzK02ApzdC4pTIBn8v+5jPxtarwFuKQVssD2Bre7TAg5aMVZXKq
         jOdikiZpwTVsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1ooo6J13D8-00Dv9r; Sat, 12
 Nov 2022 11:46:37 +0100
Message-ID: <550dd5c9-f174-5494-70eb-5e217b011dd6@web.de>
Date:   Sat, 12 Nov 2022 11:46:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: [PATCH 3/3] list-objects-filter: remove
 OPT_PARSE_LIST_OBJECTS_FILTER_INIT()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
In-Reply-To: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X5jr6TmPXtlRCiNm2YNCIDXyByYf8zMb5+6nmnu1RRsw15fi4xp
 KOdG/nE1zaUKprEvLQ01lQ2ETZfOiWpDo6c7B9enpaao+w/nVIcVsk/5qB8dheECV8/W3a0
 Iao8E7IdNYISjKBbpEMpARGwgQUp8mJWbCUaLbmBssL6H97m96n44eu4MyGwArWNlIFGS2V
 SdiUjoEpY/ng1fMbWgSGQ==
UI-OutboundReport: notjunk:1;M01:P0:eKpiAN8h5pU=;FJFWDasC5JfV+mDImRHRu0YinIs
 y0Hq3OJH4Oswfd1iJI0DvOLzBNK2UnARhKf3nXgwpavfIAzvzMNH6joxqTcUfJ6ZK+OjRw8rL
 kA4lLl6U7K74AL99UeWRLqt5RlUW9/5FBzPwBFfWN28DT+RYDCwF7uH5/+N9DL4AZ7OmIQ84i
 rl05M8yrhW8KEBn41lrPp31F6zB72mK6BqAFoidxupyMLdimmo0aZ0TC9vsPbttN0jcifiWLj
 uNQk4mCfAtLqa0GGKD6BI3mhSAs7UxeiRWWPFFLmAcwisBkKnLJ07YNH0znN3QxH6k3u3jSZ7
 XSQ2SukyueIJWHD5QE2q7sEeLZHQal8ToMoKowDCYF41FIfks/nEl3acKtbUWGb8h5WC6l7Bf
 9rn2mEZvvfui3i7sADvDpBX371wN/MilSdyTxIWJFaXaQAgpu2dvqK1lcGj4mLSkeWeahEtxc
 QZ6CFT4w6eatXeNHgnvy23fHgNA6GGmYX6qIgs6NDU6aD4hMHXF/IPNOJGaQm+BhYqyjon+nB
 ieqXymO25ordiTL+sRfgQ80ppgcau0aMMJm7OSB7d0PIob3qu2nb0T90XWNp4UyQHn97wDyhK
 NTl2w2tjHvl+99WGjy97m6UlINfPCZUxpmoEgtZD9PGYdDfghjV/YHUt4U2plFG+zllLBd0T2
 AqcMCcFos1MCNa0swbAh6UjFy05F032LZh9d8tuobqirY47zYzPY/CEx6dC7TGdjKIc3IfJLp
 MjfCFW3p9vsjbt7jw57gsB2z16XVLPzUi9k2o711SZJNHxaRfmCM/dRmffupv27RjPpKWoDXo
 l048uMEKmPMs+L6z1cnGjR0I7x1z95A+CaRXN0ppTeVqNYX6i+EjBPD8BEv3k8PTTIIfcEc9m
 nknUGXPhV0VohAh5NmvDWXxWBUo/bX3BHS9tyl0TjLlFtJ602ggRa4yhxjHHaQNInKzABzNIi
 Ta7JfuG2skNflsAq47VJwEGObaA=
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
