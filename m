Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9BDC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C933217BA
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bMyTwZWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBDVQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:16:14 -0500
Received: from mout.web.de ([212.227.15.4]:42711 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgBDVQO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580850970;
        bh=UYSH2Se/6B53RqsOWdElwZF7XCppbE+BnUfGY40/1bY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bMyTwZWtoU9Mdu/qeroUh22MLE6087WMRAwpKOE9EiIwrfL4F7Nd/gUMIGotENu9z
         6rrtg48S6I9kFf12A5NrDdoSbl+bzplUGjeMYbcLwLeR8AOI25egTMsXts6RV5xZOS
         5XqjcwIQvUQdVMeei+fwCygzsj59YK6gam4vRDbo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1jBvT934YT-00MMV1; Tue, 04
 Feb 2020 22:16:10 +0100
Subject: [PATCH 03/10] name-rev: respect const qualifier
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <9993ab3c-41c0-cf0a-fc55-72853a54a49f@web.de>
Date:   Tue, 4 Feb 2020 22:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ea2rWoaXGSj/yVHr6MZg1O9n7tetWVEI8wEKgcNZnXbFWEYEfo
 UOyvBqiHjgz5r9yeXCEmXpnC23vKZE/KpLhV+c5fmnbkdzDw/xpzo4aObgrnnZhd6VM4Zou
 fn9C7hEV6CqZV1l9I35SzLUQ14TghNo16FC+03gRnpNw+KfnmfYSKQ/SUmrqZ4Cb1SHR0nH
 Ul9B6jR4uZzjYqwjlxDog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6It5o5daLM8=:vwqaJmD9gUdRBVwwTbSqK+
 heZ26nsdzf4AYr2TGxW2hC4a+UjnYltqE3cS7MLRMHpYhQwDONEA7h+L4VIUWTFI7ml8H3CXr
 t/e44eepVfgoA4zslPO532oPZqTdGjAmX9iQQVRqvVCb0Kq6UH3ftXRZocHfYoZaK0yJAnxbY
 bDdpXabRnaOl/2+Gyh0NP97W5hkDnKthYObsb4rZcLFu50VKncLDWEA0hMc+ugvyqDDGgfRRJ
 VL0xaYjfrw4z5B7VQl9KmhxbKPwGsGSKPFTw15Jy7WPhATiH+yo7x3i71kn+6rwJNbAtziAVN
 U/D9x9Tm/IxjzQaGaqEupUFGx5OSE5DsT3ezbaVRsuSDfCbbSpow9M3AA+iBVhfg7XKgRPnyA
 QQE2r0k+MYFGyjtJ57VSbuDTOCTFBAs8o9CQ38yqHAomhAsOiAjd8DvTAomD0Shon5FO7HeCo
 LKykxmUnQ1CtZeWqxWR/7CVtAPafkyQxU90QEnj9gGvgjBdMKAnNI9jhX0ceKbRkQKgZESQLQ
 05latk2/HN2ydUds5aDPKXffgaCkEWuYCfqq25IQ2JFqn64n2wyhUDcOBtbyrjJmRdnX+67Mu
 qxcC7+joWIAs+T3iCSUHdaz7KQFIRysacl/a85JwkOpNggKibGieiHwNng4rIER9tQngKscyn
 3Z5T4k3LJ1YsASRGtcND8I8wjeW1KQb0iDOQPSSNAVEFSZgSCxQiZJ5th0c6VcOrG1Df7H61c
 axfakHirNt3OdmFQeyoZ4sSW2S0vPd63qmwBkGtEd59LxwSN0RR+kPhr/Vp26pjRwfWvINsWI
 6BWErrciNJ/+O4Ug4eTlNhcIf7fyf2h6+aOBmcAoKDBbSu+3OjIIePrU0NNyAAhlJB6ft8Q+P
 rWh6rw8XoDAvBusaPzXZ0qkdjw0ha+cSc3MEw1LNsLd60rfRI/Z95LRG4THdV4LYt9RlvalaM
 i3myI1csGlhlMBEhWdXNVCi9QmPqR4l33pt7Wzcu4qSgyDxJKYZ2epZ3bAC6OT0jOuabVGkW4
 VA+4quNYK7iQFJ1oa7WfYk9bSPdtl7VrX1lrX1FCGsmlgZTy9vS3MPHyp4WygQvZ8qHSY7glH
 SWR0pebjsVj7lIQuJVERtyjz43NA8clUtvDAMyZQ9wHfp+r2jsIVlMBL+OpcPQTOwvwO4uMrB
 QkuX5xDVof/CIOfnpjYr3P055Hl61HYX1Hv1+u1RRJZgUgrUfBoIEGM3L2bnsKvS76EqU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the const qualifier of the first parameter of get_rev_name() even
when casting the object pointer to a commit pointer, and further for the
parameter of get_commit_rev_name(), as all these uses are read-only.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index a8de9cc561..2e6820bd5b 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -32,7 +32,7 @@ static struct commit_rev_name rev_names;
 /* How many generations are maximally preferred over _one_ merge traversa=
l? */
 #define MERGE_TRAVERSAL_WEIGHT 65535

-static struct rev_name *get_commit_rev_name(struct commit *commit)
+static struct rev_name *get_commit_rev_name(const struct commit *commit)
 {
 	struct rev_name **slot =3D commit_rev_name_peek(&rev_names, commit);

@@ -357,11 +357,11 @@ static const char *get_exact_ref_match(const struct =
object *o)
 static const char *get_rev_name(const struct object *o, struct strbuf *bu=
f)
 {
 	struct rev_name *n;
-	struct commit *c;
+	const struct commit *c;

 	if (o->type !=3D OBJ_COMMIT)
 		return get_exact_ref_match(o);
-	c =3D (struct commit *) o;
+	c =3D (const struct commit *) o;
 	n =3D get_commit_rev_name(c);
 	if (!n)
 		return NULL;
=2D-
2.25.0
