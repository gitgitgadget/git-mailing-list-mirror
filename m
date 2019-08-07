Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632461F731
	for <e@80x24.org>; Wed,  7 Aug 2019 11:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfHGLPd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 07:15:33 -0400
Received: from mout.web.de ([212.227.15.14]:50491 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbfHGLPd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 07:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565176526;
        bh=dXV+paqZ+QfH+I6T5Xlt30l8a5tch/S0hDZpgFaO2hI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Ae/qkRyaa5+TMfybUu+iISQPiRVVWDE6ZX653tMbmQwttZbSni3F8zB33/0WJOgxB
         BleHYIT5lcifUpLc5jM19igE5NTJG5iKgMFe/au8PaO30/tkQK/HbK34C3TQyhyl8/
         nKpHj1DpYacZGGW2jgd920hKWuA/9WNQZgImw8bY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3Rz-1i606H2XJj-00GHeT; Wed, 07
 Aug 2019 13:15:26 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1-file: release strbuf after use
Message-ID: <fa6ccb9f-11cd-7eec-fdbb-2de6a0bfcecf@web.de>
Date:   Wed, 7 Aug 2019 13:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R+oTuYDfzUACAKjfFlT7xn+f2ExmXSUlA5y4LCaRqCXuGJX2zwq
 tqqXK1hrcibHtoaYGm0RBsXU/HUJ6GnfB+Pds1vadDla/0RwhgYv6CwlkuVspKjTyO5GKLb
 mA575OrAH42SviWNBi08IOinwbrxEZnjwtXWtOEx1gqJbMlNxsox84G8jv84ZvN0HjgWliR
 04NYN7yhZ4qfu/NkGszZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i7v68bRU0Vo=:ru7s4dURSvYiXebzS7rEn+
 5Y3/m30Tkhb/jMw7FywqKe2JYQM7TRpHJ9O/MgOSGoDvCx+wKPIzKbeg8Lcgx1ZKhVHRw4fYu
 kohYw475J+ayHUe0B2M76XyRvKxfGKTJ4RE+bwDG6PWsESMNIb1XKiaq5Yn/YGrSUUFxvWnUI
 6XcRQvoiIhmO3I5wa0IBDS7fn8rVAz0L+uvfKyNe1VLPf7TFIIB9HAGMLNfSv2MzQkPJaOBJ0
 BlzdjFnNmxBldwhd5i6me4vxPmZcTv5biLEwx4BXoCsFylVCDzeTzh5K3+TeVkYaT+o5klJ/O
 CvfDjlFgiYPBqpjmAowy75ywbzskS22A1i6pJhDN0XIeKH4fXetuH4xBtAORYS/RlP6nCFDBX
 4X8TcunFDLW/uU0y93wsYUYvwrYlnfU/emmutIOA64r07p3nrKDgr2DF1RZ+fRL1NBF8vuzkV
 nhezYmmylQ71tDjBMjVwf7mAh/FsRtza2j/XTfEdLsinuBO7s+eMLqYY+kOViq4ixutqtlz/o
 QTsHplOPsRpmgvxBKCWD/UOmbn9ry7xCYYCVsp/mDiT7Fw2Bdv7nHnPTJCHCXpcjzTanMfT4P
 7HV1F+i6pAND/KWXubaMdcR0kviKE7n205d0pBjaHGyn5pGjS8RvvicLCnFsd3LDonCuwm+ym
 KA+RqEGz0QyGS5GIrUMgp+xRhzkqAkZW9Pef3zUWoqoaWWu63xfsdBMzEqQ/WrtnNIxavirWa
 jj+H0tgXD2y8/bRH/gHPmjsoQmBy6CU+hOX+7n9gE80rj70jQM8YtI5Ss7dIvnC6i82AXETAP
 ZLomw5lwGaKnb/SeAc/0giNZC6a8fkoBdDAkSfrmC9AglQghcu1Bd/MgxK3xCNioOeInmvb3l
 5OP1dCRgORhKmZgysvU4XgM6pFneBj0V9KdDmqiEALoL1frhVsyo8J86mIrQItvQhVB5O6KaT
 5HzpcqSIlE1yhyo7DKOaJsplMbdda034SztsNoIn3qjgbDGlNth57ZQ034KcWxr9phAzJauK4
 Ams1Wc48Bjj78tPsqb/LKDCZlAkVTrel/x1FuR/f/lKGwR/iyCo30ORWso/4pxGjJwseiU98L
 clMMEBqR3JragK0ygx6tM4esQ/8FPJMAADz+7nEG8h8KQESums2POMXMbpEZPGB8ZFIg33+8r
 fIfeU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review.

The plugged leak was added by a10a17877b (for_each_alternate_ref:
replace transport code with for-each-ref, 2017-02-08) and showed up in
709dfa6990 (object-store.h: move for_each_alternate_ref() from
transport.h, 2019-07-01), where it caught my eye, belatedly.

 sha1-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1-file.c b/sha1-file.c
index 84fd02f107..487ea35d2d 100644
=2D-- a/sha1-file.c
+++ b/sha1-file.c
@@ -773,32 +773,33 @@ static void fill_alternate_refs_command(struct child=
_process *cmd,
 static void read_alternate_refs(const char *path,
 				alternate_ref_fn *cb,
 				void *data)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct strbuf line =3D STRBUF_INIT;
 	FILE *fh;

 	fill_alternate_refs_command(&cmd, path);

 	if (start_command(&cmd))
 		return;

 	fh =3D xfdopen(cmd.out, "r");
 	while (strbuf_getline_lf(&line, fh) !=3D EOF) {
 		struct object_id oid;
 		const char *p;

 		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
 			warning(_("invalid line while parsing alternate refs: %s"),
 				line.buf);
 			break;
 		}

 		cb(&oid, data);
 	}

 	fclose(fh);
 	finish_command(&cmd);
+	strbuf_release(&line);
 }

 struct alternate_refs_data {
=2D-
2.22.0
