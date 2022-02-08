Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43B1C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350666AbiBHIkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348463AbiBHIkD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:03 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE9EC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z20-20020aa791d4000000b004bd024eaf19so9247487pfa.16
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=sPmqUnovKFAKLuQYhu1Sg3pAOs7Z4qVb4uilqbLBvJ8=;
        b=VoFoCBBKW7qgLZWsFGwsQoeVckorp1iB1bXPJe1ntKq08gUisEM05M3rP64h1ndCqo
         pXXk5Xs+7WWy2FWorQqitQUFwuGEQ7//QqJJBRlLdSRLOwAUBzRa6uSLCl3QaOSscUAo
         cuFu4dGvAyU0EftvOpzIhHnPB27MmvQM4pvBd9BI5QzwENNQHeRyGRMrCcUJr2IEVKdY
         7qyIOOsm6Pglep8JLfvBDS87HLDQbD4vsureD1QYFpoZVXjblt6RPa73NoQKQUrxCvKo
         QlulrF3BGN1i3HBl9dpflcT0WT7zBL2xCiKHMUZN/Zg/nfFXJIGRi/Zfd+oOzWOdiEKm
         MX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=sPmqUnovKFAKLuQYhu1Sg3pAOs7Z4qVb4uilqbLBvJ8=;
        b=o8dGF7SNfMnmazEGavVnFvpa60agR1mvhB1HX0kNnWIiIPM6t4j3DerifXmJWvgQNY
         1V5oldtRLjTk6oyZaRLCQYHwtYMNlgGIMZVD8taesG+1PKrLcr3vQQVxa9k35dHE6PKD
         HEJA6toic9YKb4oaRV23c22tyP88W4oFPB9bB7yugSyC1NwIuXrdNExqHF7cCrNIU6q+
         sWQRdRrC40WMtKtJm+9S026RK6dek2I/whHvdbBnxUl1OWwl8GJDGVvLI3AhtzTw9kGP
         +3yfum7CA2zbZ1z4lo/cbc1fV702t2rf8Sgm55o4fSTrbhcRpFA3v5q/zrjjGAkiP8kw
         XUyg==
X-Gm-Message-State: AOAM532w55QgitYKK3gU0RpE28Olr9/0iy8/wr+Yj1fQx37Z2az5VUaz
        hTfaZtq87oEuY9q1EOc5NrnNylJ1EPs7hcSRqJCJ9nYr5xR5Ltelthoy3EUZ7v2lNXTRzVtLhgj
        yfoY/yC3Dr+5MwkxcPBYF0jwlpJJcPmh0kt3J2b9Fmk6Lzx3v5FF48tQTKzKosu8=
X-Google-Smtp-Source: ABdhPJxLCbDdEPwuYxFWjlLCBjl5Bcdui3n4Y+pof/lp2+iaXcS3WfNIhlnxnhX16LM1yyz6pU0HN0fP045rfQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c192:: with SMTP id
 d18mr3334281pld.149.1644309601988; Tue, 08 Feb 2022 00:40:01 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:38 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-3-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 02/16] submodule--helper: refactor get_submodule_displaypath()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c7c1e1432..5efceb9d46 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -261,11 +261,8 @@ static int resolve_relative_url_test(int argc, const c=
har **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path, const char *pr=
efix, const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -281,6 +278,13 @@ static char *get_submodule_displaypath(const char *pat=
h, const char *prefix)
 	}
 }
=20
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+{
+	const char *super_prefix =3D get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
--=20
2.33.GIT

