Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FE3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966534AbdDZT0d (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:26:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:51719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966528AbdDZT0b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:26:31 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSMr9-1dWn8j0m2l-00TRoz; Wed, 26
 Apr 2017 21:26:19 +0200
Date:   Wed, 26 Apr 2017 21:26:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v6 1/8] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1493234408.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1704262123080.3480@virtualbox>
References: <cover.1493042239.git.johannes.schindelin@gmx.de> <cover.1493234408.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qIv0Mzo1L8hhRMRXT5BP8y+Et1nEZZ5vtaZFT/NSvReVuAJLXo0
 r3lgjC8l6rH4q3iBXUSZS4Wiuk+2nHMWUVQXFVaa8/IN5DZIE1BTvxVQQWKI+JjgtbDzH8b
 a24rsGTagb8iUQRsLOtMMI3iZyf7vrwhXIPxOCM404GMReFsYmDRW8g49WOILJMuhvw5Lnl
 OwIky7npZB1KOfg7Z3z2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c2RwLqYpHXw=:qmiUFH2o7/dZfUmoI4DgHR
 /8c2nKy+GYSvFAW523G76V/N1Luug+Vu+Ep8nBrevJaHllwZuHe90ULUMPXsSs6Ha/4JWS0zk
 m9T/5FXYXd33XXLxKqloGBixQU4pz2k9LNEvS/sIO9AeYA/Qpjm9xIx4SVbpoktf84FVsAOY+
 M1CgLnGO1TYnsqgwyNVh4BpbgSQf2NhwMIQq73CSmeUbkbVo3XgrjREv/UyHP9dNSSsuJugM6
 GTbcSyRgpercs8jG6nD9k91kQZEPMNiwiVf82jfFio6PPHjBYZ9TtdEeeU8A+eImRxsgXPsGI
 oQgVfCiBmlwm+lZISx2xuG/TMI5Me4VZqOGcb1c3Zob+XLzmQtRarQxYm6SR0WD2KSfxiuGuo
 9anHi2FyzfUqPBtHtrznyVJ8ybTfde43LrowoKf/RuC8e0V5BVshOUTRNMoXOuHDKV0DPKrve
 NDISIri1kC6ypcJYcFRYUzgtL3VT3Y1X8yiFRRHhE8qJ7NfrTNZoDjUwXbZDK1txMRXleW2kV
 qrmweWstkOBcDGGJAvrAgiM14fZeYApfJj/8TnXHFSgWEX3u2Ufgn0r3d1KSRGJmTzfc1uVu8
 1FNr5zGWDNfWJ1kP8McAVdXm/wnhOxJzSfU0Wy/z5+H94dj/su64wSLpZrkTyw3mQg7bMYEgH
 1vJCfurwyT9XrNXBE1i5ObcSCcn2PwNBZQeJg1EgUae9e5ybqWy9AAqdxwyAx1tbD1WqE3kyy
 xnG7f/kW4CsHuJqPQ9GLSAwVnfdzr9CP+IVU9ei9nlR5YH3IpMW2jIgczO7CUh7CN0tG9x319
 w0de0nX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In its `atom_value` struct, the ref-filter source code wants to store
different values in a field called `ul` (for `unsigned long`), e.g.
timestamps.

However, as we are about to switch the data type of timestamps away from
`unsigned long` (because it may be 32-bit even when `time_t` is 64-bit),
that data type is not large enough.

Simply change that field to use `uintmax_t` instead.

This patch is a bit larger than the mere change of the data type
because the field's name was tied to its data type, which has been fixed
at the same time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ref-filter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3a640448fd8..92871266001 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -351,7 +351,7 @@ struct ref_formatting_state {
 struct atom_value {
 	const char *s;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
-	unsigned long ul; /* used for sorting when not FIELD_STR */
+	uintmax_t value; /* used for sorting when not FIELD_STR */
 	struct used_atom *atom;
 };
 
@@ -723,7 +723,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (!strcmp(name, "objecttype"))
 			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
-			v->ul = sz;
+			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
@@ -770,8 +770,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
-			v->ul = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", v->ul);
+			v->value = commit_list_count(commit->parents);
+			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
 		else if (!strcmp(name, "parent")) {
 			struct commit_list *parents;
@@ -875,11 +875,11 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
 	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
-	v->ul = timestamp;
+	v->value = timestamp;
 	return;
  bad:
 	v->s = "";
-	v->ul = 0;
+	v->value = 0;
 }
 
 /* See grab_values */
@@ -1941,9 +1941,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	else if (cmp_type == FIELD_STR)
 		cmp = cmp_fn(va->s, vb->s);
 	else {
-		if (va->ul < vb->ul)
+		if (va->value < vb->value)
 			cmp = -1;
-		else if (va->ul == vb->ul)
+		else if (va->value == vb->value)
 			cmp = cmp_fn(a->refname, b->refname);
 		else
 			cmp = 1;
-- 
2.12.2.windows.2.406.gd14a8f8640f


