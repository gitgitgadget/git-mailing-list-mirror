Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68734C83F16
	for <git@archiver.kernel.org>; Sat, 26 Aug 2023 08:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjHZIGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Aug 2023 04:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjHZIGI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2023 04:06:08 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3724E1A5
        for <git@vger.kernel.org>; Sat, 26 Aug 2023 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693037161; x=1693641961; i=l.s.r@web.de;
 bh=tDIlduMAUsyhXyOyOD/ItpANNZnqWoxLX7rngpEMSF0=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=izDeVhnE8S5RhnN6GuHePALZvyo84BnbpzMK7r/06MfS1S0m3v2bKvsXiskcI++qOBSD8CW
 fVkwipxTqnSQjC9Tu+lXHrHOnQEkYDBxZPJVtJ4zzXmbpAEIW6gD+TeIg6oop3RKkSipvkIqO
 n+AGOoybasGzy8sjDRLqM0CG+gs6QQZahu2nr4iX6AzacIwbo4UKfPQ8LZHR2woupV7FQuwjx
 iRTJCu3c5GyNobaBIILHFDcnf9b3wxgL3fX4IHZ9VCfN961MZ8TWxJgeTtJWIi1CFjJh667n+
 8SD8dS5Nk8/QQAGZiec/dErxitf38Hv1X4s5eq1FjvinRpx34PKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1qfIUP1dUy-005qo3 for
 <git@vger.kernel.org>; Sat, 26 Aug 2023 10:06:01 +0200
Message-ID: <2b08dc43-621d-2170-c4a6-c2aac33a9a19@web.de>
Date:   Sat, 26 Aug 2023 10:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: PATCH] parse-options: allow omitting option help text
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HrMxicecajGJ/R5mdL34EdB5iDLlCHB3R8Vcv5rCuXCsJ7Pggvp
 F1B5G2SOBoxvM9ELveGbsTmQMC80i3vPDMBCLScGaogsvwypArbLB0p3yZMzpCD10U4pc1O
 2ZZO/qdjmy+bkpTJusTmo+fHR/jwNpe6lpQAq9VlkZMuBjRknIAdv2iMtfgceLQVtAzHiWM
 R0E5Ag4EWWKBLsvAtZceA==
UI-OutboundReport: notjunk:1;M01:P0:+t64txgksNE=;Hn8o1puQv2c1wY1+Ffc5G7d5A38
 z8+J+1EXchoXjedZ3ut9n6qGecWoNJKhiYdDhgQbzolRWnJ1QdHc7xZcyc8niTpOHLMYsWVSE
 g/uw+rt2I8ykP5IwLfSUes3rj0UIDiAVRXjFenscCOUsSvDAcaS6dkOC1zAqnMQ6A7GZ105JW
 nRqndV1k2z/op7KPrgB2AbZT6i8u+GlTtdy4rUQ/SJPE4m0KSea1TVB4GziPk7dRYuGvk7Okc
 R59X8HO+VhLz4vNtQAh9T6tjq4p7KzzhxzSfBEzB7pbH6huqFV7MCFr0eIbF3JDS1TtMyfwI7
 EZq/rbnQRNKmIzk+vGcKa1v47JDJFpacK9VAAYKatPYjGV+hQxKRQjByHRXPVQ9W3NQGkU5KC
 A/+Qy8t4DHjwFBcC9Ep4JxVS1W4eJRlE6Y2hsDxJE3nbC13nw+A4m2KBMY2uw4R7u6zKVwzr5
 u8+328tTGWSgxKx7gXOTYGAHpglQ3zSgAS+Sx9CufIeS/P2kFuYKCo/KRJfDxTVUhSGtOW4+j
 goa8dUxQmHRkhzoRTmOEupsg5XixLukk3rdgA4ZiFqGGCABAKGiD9SVQf5kngwGCQsp3EYZyb
 VImzbhxupigrgyjtgcgWJotnzTefJfqgO8dP89nbUJNvKUSCAPe+42g2Bp9zPm8I2ITH+fg6g
 YH8UgqwU3hJv1b4N52ex0YrcKeX9eoLugvdfsIpFjL6FDHgoQdpwqSCPhGqmuYs5Z2WAfm0y/
 6M9lIOQe5m+/AygtA4Lz7EgE2LChxNZdPxIrib0Ym1Tc7fkOLfaw8n90g+w5uCRImZNVYxop4
 Rf1EMMlmDBQ0FiwdPHU8cBvuFqjuDFI6ZewbPCM05HhucxEHUPctm7Px+JPjNstqeRP+CNMeH
 fe8BBAuUM82qD0Gbu0QdGC7WbPdMfoqu4y47MZpmZOVoL9RjGFeXq7uPTAmql5e/eO4u/A7v5
 Mmj/uw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1b68387e02 (builtin/receive-pack.c: use parse_options API, 2016-03-02)
added the options --stateless-rpc, --advertise-refs and
=2D-reject-thin-pack-for-testing with a NULL `help` string; 03831ef7b5
(difftool: implement the functionality in the builtin, 2017-01-19)
similarly added the "helpless" option --prompt.  Presumably this was
done because all four options are hidden and self-explanatory.

They cause a NULL pointer dereference when using the option --help-all
with their respective tool, though.  Handle such options gracefully
instead by turning the NULL pointer into an empty string at the top of
the loop, always printing a newline at the end and passing through the
separating newlines from the help text.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 parse-options.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 76d2e76b49..e8e076c3a6 100644
=2D-- a/parse-options.c
+++ b/parse-options.c
@@ -1186,14 +1186,15 @@ static enum parse_opt_result usage_with_options_in=
ternal(struct parse_opt_ctx_t
 			continue;
 		}

-		for (cp =3D _(opts->help); *cp; cp =3D np) {
+		for (cp =3D opts->help ? _(opts->help) : ""; *cp; cp =3D np) {
 			np =3D strchrnul(cp, '\n');
-			usage_padding(outfile, pos);
-			fprintf(outfile, "%.*s\n", (int)(np - cp), cp);
 			if (*np)
 				np++;
+			usage_padding(outfile, pos);
+			fwrite(cp, 1, np - cp, outfile);
 			pos =3D 0;
 		}
+		fputc('\n', outfile);

 		if (positive_name) {
 			if (find_option_by_long_name(all_opts, positive_name))
=2D-
2.42.0
