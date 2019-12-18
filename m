Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A150EC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B45206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="k7UabW4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfLRSGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:06:14 -0500
Received: from mout.web.de ([217.72.192.78]:33271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfLRSGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576692362;
        bh=nQFdqD1h2KOBtxQsLOoiGE4X7mBO2UmD/feTWkQ0ZE4=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=k7UabW4mMiNKVEnUoKuM5I3MK836C/GAfLx962EJ9P/tjFR5KWXaJpUAOajOdZET5
         BafaU84fDDDSp1ikfYhoG20ah4PJHQoO6oGtDB3Zig6dgr3YLHzde8QVOHoCZwAwDJ
         7tPl4P4iSDP41U9NSh1H29MB9YgAvSXqAfPQJns0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.27.9]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Mg75d-1iMyCN2fa9-00NUOS; Wed, 18
 Dec 2019 19:06:02 +0100
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH RESEND] t4015: improve coverage of function context test
Message-ID: <fedd48bd-28e8-ccc8-ae50-42d9b2ea1c16@web.de>
Date:   Wed, 18 Dec 2019 19:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5bROHo3nBr/VnVNjAPX9xgpcd6nKmIe1jL67eex8WGO4ZmsWDN9
 PLjSe6t9ovURU8jeV2AC8K9QDI57eK4R9A4C6YvhTp09pBG9gOiWINaROrRI+o6XaxO29ta
 RTcR0lBgvYRL7z2BvMlFjA86SyJD/IzwFx3MITccqsPGXI6C5Hcwad6iN8RNVFMysg98cL7
 HzMYPiqyMIt+0IUYSRQsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixNCUV/Se3o=:HTaiBSO4c2tebJC2EaALap
 KDM8bm6WyxzP4SCIDK0m9ARpdwDocdDtIEL3JXZDQVJtnqqXgISmNlmdKH5w4vnKoJZiqC/vx
 FSIjhJV2qQe+sJ1H7pDT5b9wVC4gyUYinsO79FrGBDFey6k1UN0ZVfkNXNzUmgJOACJnTOQ4H
 msH4dMuuR8j3mSwmOrKSAJfSp7LEHBZ1wrYV9/osOgQVtymPADJGFiKB/g4Z262uetsJsOXVd
 ctct5LcQUdC4rt+5MwHH7CbVYFAXpzPLPvCTwFcPwAXS+j06mou/tGuOnGJCpnklB1fKCI8WM
 S38U0wURleayk3N5Ps9lmy48EZiTh9hVz0Ja7isnQtjZLR2mkGoTu9/j/waLVn505nW7xwqok
 OBNqC9AnyQmmLVG8Cc6jyItig1aYnbD8BATP6jST+3bq9ZxsVWKmu9zrmTyxD8mDuNkCiNWsM
 Iu3+eZIyVO+ESF6B3xHx4FwfP/IorAK1LeyOGBv8HmyBCoEyS4bmZuuICyXkd22MObzsZeefU
 LQq6FgLpZ7+8hY5uXy1WFSoNHxjBai8uG8QayldNA27NWIiowYUnqJWGgsbW3bAGEeoGunxCv
 HjTG6V6R6erNE7LTbxXkTeFXpePbmmhlqGZ+UGZRN8PtjP/BNJNxGRQK78ltIx7j/ioa9YS3h
 pX6MOMd5YpMLvxH1bgcTCcFKJ1E4ly5NR1SkKaf4IPna6BhDuVvVm8Qx2XEY70GWKQH6YFITw
 JLfVRQo9sMNEVTCfioQi55fhJbC5+n5M4PqqPYrEsiQLkY9qJUyvqcYpXdArrMRwrFCneQ7Im
 eqF6pUU8DnYLLa35bMQmuqnKOMhrtxir7sW8ioKuQH7fpZafUeIL7/Q9wfaYVnsIX7xybger3
 Zzjn5T1oZbo5mcgzN3xApbIfQ5Nt2hXY2NqZMEpGKR114I7/UO68656A3RVf9PtluwC2Il+SP
 eudF5W96sP0a+5qOWRitb5DAMeNSTK+qr2VNaqCyJEPIeshb+TruHQe337FuNBYPpUePRUMYt
 lbDBHezVG8ccGN9R9qHvk9ISdGCVTjl8ddkXFc6s/K0LfP0DRZN2ecOjvhEzn0Ni9n955p7x9
 iaa+DuQZSRRLetApaYLanMIKQGYRLnCRGnmsMPYN9bXKCMCZQWX5HsBrbDhtaTmG7fr50voPi
 +74/dXFaQAp21i+RNY17DNFWGA3Z2LhVCsfzWpU9poQC+sUbvCQrkiVN9Rt7LQ+lJwiFkdKjZ
 AfYqsHbNAfDG98ipnHwy1b3R2Ei7takgslrKOHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include an actual function line in the test files to check if context is
expanded to include the whole function, and add an ignored change before
function context to check if that one stays hidden, while the originally
ignored change within function context is shown.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission:
https://lore.kernel.org/git/e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de/

 t/t4015-diff-whitespace.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 65615e2fa9..59b2412c22 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2051,19 +2051,24 @@ test_expect_success 'compare mixed whitespace delt=
a across moved blocks' '
 '

 test_expect_success 'combine --ignore-blank-lines with --function-context=
' '
-	test_write_lines 1 "" 2 3 4 5 >a &&
-	test_write_lines 1    2 3 4   >b &&
+	test_write_lines    1 2 3 "" function 1 2 3 4 5 "" 6 7 8 9 >a &&
+	test_write_lines "" 1 2 3 "" function 1 2 3 4 5    6 7 8   >b &&
 	test_must_fail git diff --no-index \
 		--ignore-blank-lines --function-context a b >actual.raw &&
 	sed -n "/@@/,\$p" <actual.raw >actual &&
 	cat <<-\EOF >expect &&
-	@@ -1,6 +1,4 @@
+	@@ -5,11 +6,9 @@
+	 function
 	 1
-	-
 	 2
 	 3
 	 4
-	-5
+	 5
+	-
+	 6
+	 7
+	 8
+	-9
 	EOF
 	test_cmp expect actual
 '
=2D-
2.24.1
