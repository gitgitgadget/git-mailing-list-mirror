Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD59C43334
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 06:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiFLGEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiFLGEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 02:04:11 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA112AD6
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 23:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655013839;
        bh=l25bGK4F8qm1yqKuZ/f4WA2c4yj52roMCXYwFXn623Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=PkQupart+mL7F+X7pTzJ/jQS0Gry/Tngi16bKyeXonIJZWTs7/IDKkR9ahmw3OlU4
         3VUnbfIFe6fmGuysrHF0Ej6S7tFlfXu8O1xSX0Hy/UKK8G1aNAqJSd+E7W7tx0eyEX
         AnPKRjssAmA87zKHvFJmoqooCqLlKYQe06LPXzA8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXVX-1nrmOL429D-009cD6; Sun, 12
 Jun 2022 08:03:59 +0200
Message-ID: <35db4457-1f86-ce05-baeb-51be57393bb4@web.de>
Date:   Sun, 12 Jun 2022 08:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: [PATCH v3 1/5] archive: rename archiver data field to filter_command
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
In-Reply-To: <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cbNCXD7s8jsih4SsPQj1mkN8gdecZeKryXYe5JbH+3yGr6LTVqm
 m45RZoHgFBRHNI9OHNxqR0BZelD+GLHSVO3f9a2q0AxU1vjk6dLWQVLCyRnCzWSqpa0Pia7
 C5WBmAPBbrYCd5vJey18ohSdqZbb6v8SYJvDLo3ko6O7irNPFYxWMuxd+sHZdM9ntjSA2h4
 +wqE6Dskmrf1AbHJPd06g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5l/qbfeSPws=:9/SMlwn0mZz8EC5qIl8ZLr
 A38cbh9n53fKui/J9dx0pYRJeipk8KXWBVJk/6Sa3Yvd1/icMr34v638cnlmpZYSCyeDMzuFm
 4MEv4tn4TrUrFw7+Eg82tK1X9xIv5O3520m/9ByScjnKGMNw5RhBIUmG19e8mMJtEdr2n2MA0
 66JAIqs4Tcc44oa9GYQmR/SbXYXpJZ1qEmGHwq4cp2BQyYW6bNioZwcJcsnoY93EnPrtoTz85
 7ddvHcLcG9vkqX97X4lyvxeQbAtdvxx/5JWCgTeOmkSz4SdQk+trsBzjDov9zSqWYUxoPLS4O
 TM1fRPZIgY0yezVbvwAHxdSYC8xjWSKFbiAIWALrvMfhmVQe8aXDxrJ3eyzICVCAcpZfW2aKi
 cv2Z+l67W6kwG3VfhigllRZurmz7AhJwF3NxdRkal+aJ/xsiJhF27RyediWRKaJLnTC/7lTsW
 s/vteHjkuTv4bSLEx8SNh+dtRZvuX0/OfJSDm6UsttDflxup0naru/p6+BDfa6wD5QLsu9DLS
 Vz6szYe25XxSogBj/pU2suBD9yGoHX0PcCtRWwfK6b5OCjtcHu1YUQ83t+w6bG+Odwnpa2frs
 IS/AdlpcBOJjypUJd4B8ZxD4u7Au+Ch1AHMq/sLTkJsRG6cFrwPCWTk/niodU+KhWZk9Vgbhh
 zVq7SCjMPti0Oa4Jmuy2OGrr+cNVUr2pX1+OeRHZ92Z2k8am+7NtSg48O8SRRgbFwz5j9wX/4
 Vlbb+P7YgQmfd7pgzgScnyaJBrjbMMc4xvTPPyPwrtwLuF8tYDpizOtCYLiq1RwKG2uh05JNt
 wotdaEt3Ly4FO0IBGRK4zzES84PNILpTLRiLHhuYtIqZ0pU7fcpuOrPqORNVnwvMWQo7UwAcO
 z/wn3iwqqYDLVqOFO3/ai4L0LjdyNQF0q+sU2EXNsR3VilYYt4xhEx/19RuFtskBfxb+ppw2/
 c0h/WGwS/L3U/PpxYQfctZm8QbaoLLw428C2zrdjBYyimo48rMz3KIkYZrjeYdu8Hjlf+OYbs
 jFSuE/j8ydaX3rIHl+3hvgrfEznyfpNWSAomj4PuMzrocNPTH18xTZsthnzlYnNy7wb6CQkuH
 /N+JlLq9EcdFhSfEwNLMb7by5rKXUHwMdGJ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The void pointer "data" in struct archiver is only used to store filter
commands to pass tar archives to, like gzip.  Rename it accordingly and
also turn it into a char pointer to document the fact that it's a string
reference.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c | 10 +++++-----
 archive.h     |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 042feb66d2..2717e34a1d 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -383,8 +383,8 @@ static int tar_filter_config(const char *var, const ch=
ar *value, void *data)
 	if (!strcmp(type, "command")) {
 		if (!value)
 			return config_error_nonbool(var);
-		free(ar->data);
-		ar->data =3D xstrdup(value);
+		free(ar->filter_command);
+		ar->filter_command =3D xstrdup(value);
 		return 0;
 	}
 	if (!strcmp(type, "remote")) {
@@ -432,10 +432,10 @@ static int write_tar_filter_archive(const struct arc=
hiver *ar,
 	struct child_process filter =3D CHILD_PROCESS_INIT;
 	int r;

-	if (!ar->data)
+	if (!ar->filter_command)
 		BUG("tar-filter archiver called with no filter defined");

-	strbuf_addstr(&cmd, ar->data);
+	strbuf_addstr(&cmd, ar->filter_command);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);

@@ -478,7 +478,7 @@ void init_tar_archiver(void)
 	git_config(git_tar_config, NULL);
 	for (i =3D 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
-		if (tar_filters[i]->data)
+		if (tar_filters[i]->filter_command)
 			register_archiver(tar_filters[i]);
 	}
 }
diff --git a/archive.h b/archive.h
index 49fab71aaf..08bed3ed3a 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -43,7 +43,7 @@ struct archiver {
 	const char *name;
 	int (*write_archive)(const struct archiver *, struct archiver_args *);
 	unsigned flags;
-	void *data;
+	char *filter_command;
 };
 void register_archiver(struct archiver *);

=2D-
2.36.1
