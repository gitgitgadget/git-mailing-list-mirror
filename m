Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F44C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA592067C
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="D5cuqOce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHRWJO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:09:14 -0400
Received: from mout.web.de ([212.227.15.14]:41187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgHRWJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597788547;
        bh=o/OqGfH5IhAddbcOXoLNFmFpGrbsZrZ+5jvkdmVmqok=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=D5cuqOceZbTMey/fCCZqG+Hx8fPRsf4nOUotrEud0fNlyhg8TdM3see1bSb2BMq3C
         BKgItQrcvL/k+sLR2SDu+3623XrzCtdCoZqlxeEPlAfxQdUNEwxH9Qx45oeL7+d+FZ
         dWrSrnMr/nY/XLF10mbAugQPvLdG4e7/s/orL5hw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5jp-1jzfLW1EOX-009CQQ; Wed, 19
 Aug 2020 00:09:07 +0200
Subject: [PATCH] patch-id: ignore newline at end of file in
 diff_flush_patch_id()
To:     Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org
References: <2639321.dTF8K4C05n@alien.lan>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de>
Date:   Wed, 19 Aug 2020 00:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2639321.dTF8K4C05n@alien.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WmS2lYKuCHqH4MtKGc5IQOjyswH3AVFi3Lmjp2TbUb33vT+VH5U
 r2ngCCvTV+lMHEbJzrEvxQGiD0e+l3aa/G7nKQLiHCdnXzQVPoBEr8y9q2NBiBbZwixUKE5
 xGDDFlXV7cyz7uroY0NujNqPHH0bwPODrF6CBkCs3C0k20Lj4isPp2gEVnEcNIGyWYmr5F1
 Su1160e3KwT7cgl0p6Tsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEV1/FVacAE=://tgiijvydwQ0l2byDjTE1
 ZRWnH5PkHX0dV7jDaF7XEq1iRJR962fMbEvbLdON9WgDtGK89zNh/Trbh5pGkSWTZ7qIP+53y
 /OPQchSQmrGIFWal3kvQB1Ve48QTzhHpX6F0nANjrWaUc0kRYsPm77YpSRjoIPfgfJvSTb5MR
 DCnmcmykLF2XBGurQweNRJaMGOu3gqZXqz9cNB/+BwP1lRRbQomggAcCIFGZaDiT7QJW3XLYo
 eDkEcrSwWiWB1BadV7vv6QiJ8eJZt9/MdPTh8AwAJNSMXraBMrl4EjlqStp/YeR7pyJsRpg2P
 4hdNAL3B1pj+EDRzvoYeufhSvhYAX0Hox37urpxxakDqkcoeHQD1B1/Vz6sHsVtOY2Q7+QhH4
 D96+K6h2EuFZEibySmQpBPzXR/3zQq4RtkK0kwSL6d/lxsea4kezKU59bJty192Mi3iEjTApL
 1yNNsKGMv42UqNokkJ79oPthSulQgsJVuIhPWPqxavwbhbgDbuICAYOsV4mQTiG96eQ/tD8mm
 w+JeuoMCxUm1DNzWQpG4O8Y6T2dMOVNSF8N5CKsShyuvL/pZevnjLw0R0EAdSIxDT602LlzrV
 QY2R3JlsZy+JwxHYs0w9j4uUzO2K6JJI9kwsUQPYUdoW2Wmvdu3RchT6fEzAVehH5Ebi21Jlv
 FdibxWriVPxTdQQw+OSs6MIwI8L0Ebo4gj6cayK3vuS4cTZlG+Kzcxsc1jfvaED0ZU+DJTHlt
 iuQyl5L/fo60G/CUEWTSZQKPRA08saPLytR6meBrQnsyWsDWQyF4iycKHfO1cH5gsOv+rMbyf
 ufyv3nT1Kh6IdOYmhzz9c0hJY/0SE/kt/W4RkxJEClZdzDx2rkwXW1Urk551XL/vxjMszTeTx
 s4lI9ePyUu5prTMv84m83U7umFM9OYHkdYhx7ldzmmkzFAgHFb/cwAKL7xrhmv4fhgv3iOu+k
 PznklF10CFkp1C0/McKuEX1dAFza+fvrd0pveyOZyZVuHi7XlvZQ8bhRrXlcHs1VdidP8FujC
 6Nhh4ZDBgEQfUJawpgqANsfS8cEafhzXABNow7ThAyCxi4az0EPxwkTJKRuVuvZZ+v1tzrlld
 lT6jvJU8fXuvHt4aoVLUrQK4BZZgPmDmIIEl+HqU8CI/SztWhinQ3tUX109A7WX3B7jwNW1qL
 YLcpvlR+x2uGgmUo68svHsa/noMIfWcW81L6xUxauwhfzj+gq4uj7z30oXcv1ULkDArUxeG1s
 ZjJUVQW2BMtYXocmH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whitespace is ignored when calculating patch IDs.  This is done by
removing all whitespace from diff lines before hashing them, including
a newline at the end of a file.  If that newline is missing, however,
diff reports that fact in a separate line containing "\ No newline at
end of file\n", and this marker is hashed like a context line.

This goes against our goal of making patch IDs independent of
whitespace.  Use the same heuristic that 2485eab55cc (git-patch-id: do
not trip over "no newline" markers, 2011-02-17) added to git patch-id
instead and skip diff lines that start with a backslash and a space
and are longer than twelve characters.

Reported-by: Tilman Vogel <tilman.vogel@web.de>
Initial-test-by: Tilman Vogel <tilman.vogel@web.de>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c            |  2 ++
 t/t3500-cherry.sh | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/diff.c b/diff.c
index f9709de7b45..f175019eb7a 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -6044,6 +6044,8 @@ static void patch_id_consume(void *priv, char *line,=
 unsigned long len)
 	struct patch_id_t *data =3D priv;
 	int new_len;

+	if (len > 12 && starts_with(line, "\\ "))
+		return;
 	new_len =3D remove_space(line, len);

 	the_hash_algo->update_fn(data->ctx, line, new_len);
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index f038f34b7c0..2b8d9cb38ed 100755
=2D-- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -55,4 +55,27 @@ test_expect_success \
      expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*=
"
 '

+test_expect_success 'cherry ignores whitespace' '
+	git switch --orphan=3Dupstream-with-space &&
+	test_commit initial file &&
+	>expect &&
+	git switch --create=3Dfeature-without-space &&
+
+	# A spaceless file on the feature branch.  Expect a match upstream.
+	printf space >file &&
+	git add file &&
+	git commit -m"file without space" &&
+	git log --format=3D"- %H" -1 >>expect &&
+
+	# A further change.  Should not match upstream.
+	test_commit change file &&
+	git log --format=3D"+ %H" -1 >>expect &&
+
+	git switch upstream-with-space &&
+	# Same as the spaceless file, just with spaces and on upstream.
+	test_commit "file with space" file "s p a c e" file-with-space &&
+	git cherry upstream-with-space feature-without-space >actual &&
+	test_cmp expect actual
+'
+
 test_done
=2D-
2.28.0
