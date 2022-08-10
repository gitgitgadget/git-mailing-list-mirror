Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D081C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiHJOqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiHJOqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 10:46:11 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 Aug 2022 07:46:02 PDT
Received: from smtp-out-5.talktalk.net (smtp-out-5.talktalk.net [62.24.135.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8D4B4BA
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 07:46:02 -0700 (PDT)
Received: from localhost.localdomain ([92.1.139.136])
        by smtp.talktalk.net with SMTP
        id Lmx9oEuXdj0TFLmx9o4fR2; Wed, 10 Aug 2022 15:44:59 +0100
X-Originating-IP: [92.1.139.136]
X-Spam: 0
X-OAuthority: v=2.3 cv=BuDjPrf5 c=1 sm=1 tr=0 a=9CHfLf6Jh88OdhEtU6o92g==:117
 a=9CHfLf6Jh88OdhEtU6o92g==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=DTdKPcmYlzdxeDCskLgA:9 a=QEXdDO2ut3YA:10
 a=ezPG0ZpnnpEA:10 a=hliCg4TZyPQA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        philipoakley@iee.email, tboegi@web.de
Subject: [PATCH v2 1/1] doc add: renormalize is not idempotent for CRCRLF
Date:   Wed, 10 Aug 2022 15:44:50 +0100
Message-Id: <20220810144450.470-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20220810144450.470-1-philipoakley@iee.email>
References: <xmqq5yj6z5rx.fsf@gitster.g>
 <20220810144450.470-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfN4KYvI2ZC9hOSk68IdMMI75Vjt+WQK1Z5uDnt90yCyXkHjiE9AYwXLwamZSRC0Nn8vH36/DA4nTcBBpnVeOxnOnoPjImxNxOIY4b6+nXDQe3jmEKsdF
 3u0TqeEQo4/g/dS3NzvZpfdRNPbZG4cWcwlJ6bDPmBHU4OME62wkeW2NL6FSaMlbGvkEwXyY26k7f0dWzoIgKxvRxhUtgrr5vfQ5KcuklW15nOhdDYl1Oxlv
 DVNaREkE2RuI+NrS9MKEvXkuTzrmtA/f8rJMVwHjZTlqWIvlMX1dqYooNMRce3JZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bug report
 https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0PR02MB5635.eurprd02.prod.outlook.com/
noted that a file containing /r/r/n needed renormalising twice.

This is by design. Lone CR characters, not paired with an LF, are left
unchanged. Note this limitation of the "clean" filter in the documentation.

Renormalize was introduced at 9472935d81e (add: introduce "--renormalize",
Torsten Bögershausen, 2017-11-16)

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
This is V2 of po/doc-add-renormalize, based on commit dc8c8deaa6
(Prepare for 2.36.2, 2022-06-07).
It was [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF.

git send-email \
    --in-reply-to=xmqq5yj6z5rx.fsf@gitster.g \
    --to=gitster@pobox.com \
    --cc=git@vger.kernel.org \
    --cc=gitgitgadget@gmail.com \
    --cc=philipoakley@iee.email \
    --cc=tboegi@web.de \
    v2-00*
---
 Documentation/git-add.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 11eb70f16c..9b37f35654 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -188,7 +188,9 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	forcibly add them again to the index.  This is useful after
 	changing `core.autocrlf` configuration or the `text` attribute
 	in order to correct files added with wrong CRLF/LF line endings.
-	This option implies `-u`.
+	This option implies `-u`. Lone CR characters are untouched, thus
+	while a CRLF cleans to LF, a CRCRLF sequence is only partially
+	cleaned to CRLF.
 
 --chmod=(+|-)x::
 	Override the executable bit of the added files.  The executable
-- 
2.37.1.windows.1

