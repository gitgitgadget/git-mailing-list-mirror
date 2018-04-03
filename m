Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4AED1F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeDCQ2R (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:28:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:42991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeDCQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:28:16 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M0gww-1eFHDD3PhO-00uu6f; Tue, 03 Apr 2018 18:28:01 +0200
Date:   Tue, 3 Apr 2018 18:28:00 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 01/15] git_config_set: fix off-by-two
In-Reply-To: <cover.1522772789.git.johannes.schindelin@gmx.de>
Message-ID: <518729d5abdd93980f388821a96a69c8e4cde82e.1522772789.git.johannes.schindelin@gmx.de>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <cover.1522772789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mgKnHyP793ekRyR4bLBpY2WcWaq84g/ABsD4f+5IIn+KMVsjOsG
 B6SeooGxkE6J9kBN2aZK2geSTCGxJ5qGirmdPl+Z+vmr8aYO9iyzFwQMHVWCE33iO3w35Qz
 a47Vo5PuUVnQBxfkM5aORisLWEaywl/RuXjNKdSw772o9navvVl03RlYDpO9YyTyW//kjFm
 r39ZGgOzL5849ySFXygTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AB9eB9WwAJM=:i7sdpy42zRDh+C4A9CO5Ou
 hc9hQbWHqvXiStGmWBxV7uI3wpUSms8FD8TARaa8Rziculm4VEv8hMzchNjtwkiTUx4WOHwTl
 vaQsUGlp756vqGEol2Wq7vTcm1K1r6l6OI5XBdQ9+1QLdUFk0+mjhAwjZaQ8E6oeUJ69/l5y0
 ayKyZEOQ5pf/IhvOtUu+mR31RWwERhQJiPGcWGVD7L/a9LeX5hdMRzAPqlGV898N1AdPmi2XD
 jPauIhQ2gaKBviNHJBBk6PPxgHT5pN5bqGfuyHyHlO2ojp0ik2hA52nUGzfkPBBtG25rq/MRG
 KOOynfMvGXcU2eEceCucVvjkumEnzETGc0ma2ISXEwWYSK7mWbyOySzMAVJeC/iSWipS5bkLx
 aDxisUdfAuBqG7XhBj8aBSX4pyNNDFgJXEQfeb3/FuSDQQc01+o7Y8xBOan5XWH4FxhjdrXLJ
 j3Iae8CpwGTZBifmBlBGn9JoYACJjWBbygD2EMofYRzOiWwe03UY9PBSfxTwVkE3vszfrhp1D
 u9MKMTF1fo10+suEH9gIaH5IvpOZCa/qmSNz4UO45aMHh80J1AEdrFHlSoeRY3TzhdaoclaIE
 5Tpi0gHhnbuR2WSBdUoZ9VNb/8jzdhGX0n6G/KJoITRmb/jqFpuKnpQTF9wHZAPJY+7oiytiT
 gqY4OdmOaWqf7cXpyB6rW6/eLaKqfQFBPGzCYvEwZ5i1psb66PqZdgZacLEOH7UPAk1HriQ/J
 n/7qOOtedyQ8J2TPxG2l2vVAySqgLYJSggWcgBlH5Z1Xeh3MugR2cFrN8lYONO/Cy1p33rmoa
 pMFYKXvxUBe7WSukhEW+0SH+vXPXUebkZl051Vbleacmb3+p/2tTUw+y0AjSqhnI9p1krP/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, we are slightly overzealous When removing an entry from a
config file of this form:

	[abc]a
	[xyz]
		key = value

When calling `git config --unset abc.a` on this file, it leaves this
(invalid) config behind:

	[
	[xyz]
		key = value

The reason is that we try to search for the beginning of the line (or
for the end of the preceding section header on the same line) that
defines abc.a, but as an optimization, we subtract 2 from the offset
pointing just after the definition before we call
find_beginning_of_line(). That function, however, *also* performs that
optimization and promptly fails to find the section header correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index b0c20e6cb8a..5cc049aaef0 100644
--- a/config.c
+++ b/config.c
@@ -2632,7 +2632,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 			} else
 				copy_end = find_beginning_of_line(
 					contents, contents_sz,
-					store.offset[i]-2, &new_line);
+					store.offset[i], &new_line);
 
 			if (copy_end > 0 && contents[copy_end-1] != '\n')
 				new_line = 1;
-- 
2.16.2.windows.1.26.g2cc3565eb4b


