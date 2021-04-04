Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5C4C433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B6B61106
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 06:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhDDGSA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 02:18:00 -0400
Received: from mout.web.de ([217.72.192.78]:55045 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhDDGSA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 02:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617517074;
        bh=72XYRbtfCkIzVfNoinxjlGGIGFSaKqxY8DWKZ+wPfRU=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=ORCrVXKhkRSQke/f4op/N+sxkex+tWHtXR8Cz6C+7/9ZHNFnXCvZjH17np+EoyfeE
         0JwY0t4jBEuSAQDtxpNDweOg5e/YHEm88uwPKg8JzAr1zbK73EGMeF4VP2b4dofqKz
         PXBWFIQxdjjNf7Q+ohQWsRS3d0HpewyYr58deZ+Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRzh-1lvPHX0l8D-00p8ry; Sun, 04
 Apr 2021 08:17:54 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, d.torilov@gmail.com
Subject: [PATCH v2 1/2] precompose_utf8: Make precompose_string_if_needed() public
Date:   Sun,  4 Apr 2021 08:17:45 +0200
Message-Id: <20210404061745.19364-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqqtuotfre5.fsf@gitster.g>
References: <xmqqtuotfre5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B6zlOwndNrc6J36y+8o87IwqLjhDNhaTakxaueuOSNGHLRvwHGk
 d4GpH5wSw095oIUVSYUS/chouIiFSJaxuuJTncwZDbDpB1zfXJTXT6okHuG0AEt4XxL5PnS
 WPBx/z2caV+3E/JB5LV6wGbdn7s4FYpCmqpAqzZHgcpPfzwr1ylMQPqEZGmTm1ERODeO0c/
 drF7FewOzQAXIBG2xKV7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fpWOTw15Gu4=:MHgZDQ+S85kBf7zWOQLSIa
 wPVcmxMExW3xE5xkf/KcafdI4t2He1S+j5FzO8WIxJRtBDtvaj1rYgnfKZHv/ALgoCkJfxMLq
 pLZuvIm2KD3uTnLZ2MklbsUwxcswwxORkkskj/B99zejnil8AsKn4J9nC3XIAALkPEFYQVp44
 fZtk5sSyGeYLDjbVwdJEk0/CPu5uJBiP8Pz7TlAFkMsb4j8C4g5W4rPBVycYFsT52dRiPyZR3
 hWYuroKemj9vgOVDbdfwtLYLtX8VvsaEcB18HFjQI7+RvrKwRiD53V3A+FdlGh/Rc3MLwHRsQ
 QYVWiwSyKkGDTkxQPUh09yeBqzayQ01b5W6/FEsIy0GGNcfpBHFXEGUiDEdfW9LmElpZ9NOw4
 uwJeDDkwcPVognWHnjBnahS8HhiLKBnRQf50KBULkLyjTyV7oLqYO6EKfPCe26saA53N9UBm5
 0FwNTu0vA19K/zZEd8UK8ts3ZbNDVfDa1LHHKTtB+Sp1Zhy+fpvITNyfppWbI4rzrjigMVlv9
 FRFFZ9Ja0bydlzLfG+0hFVWeq1HlMh+LE5GmZN0pPXuBiRYamtws38mxZM/IDdMDz3ks8uGNh
 8S3hFrDSzw0bdYQz44+7JE3r9VXgaW0w6cgoZle2faQufzQ7T6NlGlc7MdDz/vmZH9pyiA9/M
 RLKFXNHBnrOfmouPcSRy4mEyPHsO5eayL3GNvkMIeAuuVyN7/G6JJUDWyrjPbbDS9gojx7is+
 gmim/WW014MO4bhT1oMV74vFg27GTd40vbjXHs0ie9RpUzR5lF+QLJM6S7poedAeZtan+bWcN
 DJUQRamW3ZSZszNJAqVfy/plpoPV38proEww9JgfDcuVEohKzq6+AgiJidIyFZpH6wMXW0r5Y
 Dw189oNZsiozvz6Dr+OUGUdHqRNbdV9DmEKJQJfhGNPm0G/GbU23NKRZ06NGPyXRvBipxkgnj
 xtGQerqhGuhXtkBYyV1GooTqBaWz57lXWFMrphAwX99+pbMnsaG5c+ZvEgSpehFgpeSdleUd3
 /uNcKvz2PcPLcW45+j4XLl5+O/NR+Z1M0Oh+Ucn5loUH2Q4OZTgXLGlYEeCwnVOoOBAw657zp
 K9cdCqN9eBdxhvAhHuEanhPRfcpjK8AdInKhufqFP5TQWJn1HhsWnod0wZfjteJFySeTyoFnW
 1Ba7S0uGgIobuL3DlVUY7sSg+KZ5uy4VMRkqXYQ4fvss8QCYoM6al6BgJh1b7y085iBxE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

commit 5c327502,  MacOS: precompose_argv_prefix()
uses the function precompose_string_if_needed() internally.
It is only used from precompose_argv_prefix() and therefore
static in compat/precompose_utf8.c

Expose this function, it will be used in the next commit.

While there, allow passing a NULL pointer, which will return NULL.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

This part 1/2 never made it to the list

 compat/precompose_utf8.c | 9 ++++-----
 compat/precompose_utf8.h | 1 +
 git-compat-util.h        | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index ec560565a8..cce1d57a46 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -60,10 +60,12 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

-static inline const char *precompose_string_if_needed(const char *in)
+const char *precompose_string_if_needed(const char *in)
 {
 	size_t inlen;
 	size_t outlen;
+	if (!in)
+		return NULL;
 	if (has_non_ascii(in, (size_t)-1, &inlen)) {
 		iconv_t ic_prec;
 		char *out;
@@ -96,10 +98,7 @@ const char *precompose_argv_prefix(int argc, const char=
 **argv, const char *pref
 		argv[i] =3D precompose_string_if_needed(argv[i]);
 		i++;
 	}
-	if (prefix) {
-		prefix =3D precompose_string_if_needed(prefix);
-	}
-	return prefix;
+	return precompose_string_if_needed(prefix);
 }


diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index d70b84665c..fea06cf28a 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -29,6 +29,7 @@ typedef struct {
 } PREC_DIR;

 const char *precompose_argv_prefix(int argc, const char **argv, const cha=
r *prefix);
+const char *precompose_string_if_needed(const char *in);
 void probe_utf8_pathname_composition(void);

 PREC_DIR *precompose_utf8_opendir(const char *dirname);
diff --git a/git-compat-util.h b/git-compat-util.h
index 9ddf9d7044..a508dbe5a3 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -256,6 +256,11 @@ static inline const char *precompose_argv_prefix(int =
argc, const char **argv, co
 {
 	return prefix;
 }
+static inline const char *precompose_string_if_needed(const char *in)
+{
+	return in;
+}
+
 #define probe_utf8_pathname_composition()
 #endif

=2D-
2.30.0.155.g66e871b664

