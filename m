Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A164C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DC361002
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 20:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbhHYUPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 16:15:01 -0400
Received: from mout.web.de ([212.227.17.12]:58987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232315AbhHYUPA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 16:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1629922450;
        bh=IZFZsdHdClmch1MxbVcAlwqAe5wkGPWmvn1vfNCyfvY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=S6gW0L40gY+LBVzqVFrEyuOn8KzmXQ4f4nu2Hpfy5EHG3JmpZhPy7BElBeKnbAe9p
         FeUZr8XINBIHbiwXbBNm1MzqjBd+nlvv8heY871ElkCCRwPKgLgvhdxD3FDH6/zi8D
         yGCMSokk17+psxCtYh1BBk+rKUz77j2oadvtdxIw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LxfGh-1n7Ed72I39-017DgW; Wed, 25 Aug 2021 22:14:10 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] xopen: explicitly report creation failures
Message-ID: <6a5c3e8e-0216-8b63-38fa-b7b19331d752@web.de>
Date:   Wed, 25 Aug 2021 22:14:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xHj4aZqPmtZuso53TPPofiLK3769ImoDYz+YmblDvu18U9MZbGn
 Nexju//cT32b6aZPx6S00B06AGgISvBT1rpnvoC7M/Tr/3KhIwGH3wXCV2cQaXWFP/PYTfA
 Cpnf6t936DMsOgSEIr5LvG9vNgNn6symaVtusbBH7xODC3i/TP1YvbKRAfsLuhJZQy90mSG
 lq/XJQy2a+k/tBt4Ysmig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+hdLdLKHNzo=:3WGA0Qgmmw3HxWRpFQ4tyj
 uklmSbGOxVy7ZIvFmkoCSehXWHNvfYi3z09xX8AbTS0vJvLqsvjvTEuDfuAaVKOTuSROj3wt6
 5U/ZdyS1IA197q2PGYcdc+6SQzHWutcPi+/gvUXSPkJvBuIUjY1ZIh60sgw9fsDalnyokQ++D
 GssMkwMKOzcC9rNnWWJYlBnfTXFcA4vLGB3hsxcP71K6Txft1T19mtNf7cu8+u/bD9DoQkSWS
 icGWtwwoJisQG+wLDY4LLlJ56eEudG/xKn0kglIWsBLQZ0gR6rxk//e1pqNVlX4MVmh+OIO23
 eKMiStRAaWesaFVmggM3MZQ1GmYL94tS6yl90uErYy5HIXuY8Z6TO4Viz3Q25ZAfWVtQLfxXA
 Ra9PBJq3+ScBihZPkc1Lb8G3etRNYWU9jXF9w0y355APeZ7LVhHEZIkT3Jt8Bswxn+XiQx9wq
 0WD72IrZyXM1ilkXi5utEnR6VuYlqnp36Mu6K3+5252Ey3nitbtB4bbQyx01bbtHldqWxRQoX
 F8Z/pivGHEYhb8kix64MMNQ5CSuljYJGjYfcdypBGxR7CtkCww5otipzLsl6GYTgzUtjW6d/q
 y1VHlROvGp2CzcL+ecwbYNDFVA0i76Wks9hUqa4zkCWBnnWbz+VcxRiXY0Dky980YjF24egyk
 gLnPwSI0VY7aoBSIz+5zX2Zde6mRhdl6RdoMcf5CljQ7gLTs0C5QjeqpZUeyVnrRY4GzHFRkY
 Fi2xts2PVFV5RAtqT0MlvRIi0ghjjFDbpUYRA/Gc8Hx6dAyzS8IslAC1rAaY1FcTmRoRVS4Em
 Vq/IKQ+6IUD+lmNVFeCOu/dUtRPCt4GWWiGGBHVShhNSZcnDOEpMBXmoJGKLAmzkX5861frbI
 v6uH9pHFtfs91wpC8gUsUBdVP39g2MhxwQipITT7b5Ckjm2kS/QwCA7fzl7bEfouQsuq0l3DM
 3OpdF1zIrhnbdI8YSjpFHX9Tid+YrnoEHvbo3W3nt4flr2v/ZuOZwxbv8vFhBUEBwvNMVeETl
 GRCxFHs43Ag8NAyutwz4RzKAYv0hjWZ2nDOOS8jI5KPEUcYmH8660ZBkFk9G5VSrFFBuHU3SN
 /j2CoCl7ApmkC9XAfRh7JwLkV2m6IpcGnwa
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the flags O_CREAT and O_EXCL are both given then open(2) is supposed
to create the file and error out if it already exists.  The error
message in that case looks like this:

	fatal: could not open 'foo' for writing: File exists

Without further context this is confusing: Why should the existence of
the file pose a problem?  Isn't that a requirement for writing to it?

Add a more specific error message for that case to tell the user that we
actually don't expect the file to preexist, so the example becomes:

	fatal: unable to create 'foo': File exists

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 wrapper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index 563ad590df..7c6586af32 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -193,7 +193,9 @@ int xopen(const char *path, int oflag, ...)
 		if (errno =3D=3D EINTR)
 			continue;

-		if ((oflag & O_RDWR) =3D=3D O_RDWR)
+		if ((oflag & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | O_EXCL))
+			die_errno(_("unable to create '%s'"), path);
+		else if ((oflag & O_RDWR) =3D=3D O_RDWR)
 			die_errno(_("could not open '%s' for reading and writing"), path);
 		else if ((oflag & O_WRONLY) =3D=3D O_WRONLY)
 			die_errno(_("could not open '%s' for writing"), path);
=2D-
2.33.0
