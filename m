Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089B720282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbdFNNIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:08:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:63330 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbdFNNIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:08:23 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1dwflk2Ep6-00bbhQ; Wed, 14
 Jun 2017 15:08:12 +0200
Date:   Wed, 14 Jun 2017 15:08:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 09/10] t3415: test fixup with wrapped oneline
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <169d8d252b1d46b3c6ad6c06000b2b9e8f054f24.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UV8kyc8OC7x4DsJ70K/AN/geKYNVAA/KfJrivpt9Fielqq9U9No
 9sNtNxlcEhFjeQ/DGdJzeFPA/ti2wIWum09VEX8sRKr2vcGxqtQBPjwW7yHV+YaP1NvT6Mp
 FXTDE9DatUTob9ii4MHFVHXXr/0NhaJZmcHA4dPLMyifK/JbsJVwgvtg1dTuq9yOcP4GZAk
 ZU3c28GpYECjnbvL7P0UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ryA2VJ3JQAY=:Q4KIgumWwgEAR/S/mOzldb
 +BXHwZebtjJ4VV90sbFgenXrZ1Z/THh0jh2OUSIzFaVSMag3LQquCm0TWEUKGaijaubUnz8iD
 lnuJAgo4yQkmhZJwVD3xNFrGU9rgNHnF+rOBEbuc73OmgpDM6/VMvxIYKgo72SvHr10X6BEnR
 PyDJ/a4GC6z3bnv0y4K7IEzPSDuq/vOmj2bhuRFjeTwg5eFyzI+2FMkG2f6jrqvVashjkkgID
 EghmnWx9k/MlGCTV8l/2pD5JahTqTvn1bbjPJyiMQg2muX5gm0xJDZbkhLpDMpH4jCrzKHXQD
 kCyWKPT4DEtu3PqCZTgQWEg/VUAMebONO5LzcPRs4UCNEd9Ct1XcIN0f1N3cLNrzsdTBYkvl9
 rmWQTjO2HfwYmuG6OG+7NSngtVs/2GGWwt6qwhM3x9EvsX4Pbq2z1jRAnPC9nIPCNuXDkpDrA
 J+s9Ue7q5daPFlrwr/XG+lje3QA0BniZFPq0OYD4acuODDoAey5qa9QgMdjbq1Ve6SgPMODe2
 Av7an/x51nv2F/LmmabK5RtoUrWgvOgSOp+UUowcn9+NlWoiR7EmpuVSkXMYQEmhfK/AdGpYG
 HJwaeHWSlidPUjXVRR17OYHlgf+fRa+EA+wxdp7pRr9CScSPmOEg0/qT3a5WeRE0oJywZSDeY
 25w2R0iDnOy5rm9IZEgTGVWAIaCSWUx4/f3dhdLrogbuUmMXvWrlD/1aEhRt8SdV6m496rUPZ
 Wlet4jW4uz4T8fwyvnQqNfhuLWuiEoKlGwKJ7UpEiXeUMhsubF9hPHqPRbUJZadCwBljeJFau
 mlrwBWX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `git commit --fixup` command unwraps wrapped onelines when
constructing the commit message, without wrapping the result.

We need to make sure that `git rebase --autosquash` keeps handling such
cases correctly, in particular since we are about to move the autosquash
handling into the rebase--helper.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 6d99f624b62..62cb977e4ec 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -316,4 +316,18 @@ test_expect_success 'extra spaces after fixup!' '
 	test $base = $parent
 '
 
+test_expect_success 'wrapped original subject' '
+	if test -d .git/rebase-merge; then git rebase --abort; fi &&
+	base=$(git rev-parse HEAD) &&
+	echo "wrapped subject" >wrapped &&
+	git add wrapped &&
+	test_tick &&
+	git commit --allow-empty -m "$(printf "To\nfixup")" &&
+	test_tick &&
+	git commit --allow-empty -m "fixup! To fixup" &&
+	git rebase -i --autosquash --keep-empty HEAD~2 &&
+	parent=$(git rev-parse HEAD^) &&
+	test $base = $parent
+'
+
 test_done
-- 
2.13.1.windows.1.1.ga36e14b3aaa


