Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CCE1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeA2UTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:30 -0500
Received: from mout.web.de ([212.227.15.3]:49203 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbeA2UTW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:22 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTxth-1eFgTA0hiD-00QkxB; Mon, 29
 Jan 2018 21:19:13 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
Date:   Mon, 29 Jan 2018 21:19:11 +0100
Message-Id: <20180129201911.9484-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9q+VQTWDywFYj0ZI3FuxOLTLdSXCf3iKarZ0SB3p5TmSstR7y8I
 941saNEHc1JsE21FLt3Z7tfZPKLK02zzVjiFknEzpX9t+2QisQHotffBpWRvj67Wqw3yqH6
 MGGtOtemlzrWDJQC02ZZEPtVr+5qwDjbHdCxA61yfDAqcJ3t77Q+7UewfTD6mjKkCZ6ztzT
 UDRFkqqXCEgGAMHZdoCSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ApqqDJYI1TQ=:j5WdUPI20aTWyeogJwdXcf
 eDKav7pxMJ8NaTyUPUhJIEyIKxpZisbeu/2puL4d4iZXfX0FOLdHh5LFJuV4Azi9S91kSJva9
 GIFPa5nDk/0qeOf04PaQ0Z1T8acu+iUmaefiRhMtaVO5tgHUaaqswTm3IOYg1SUw6eBaoATMC
 8LyoShwlLLrh0L2xrIehRTXt2dWbfyQoCnkuwwQ2yT2FeBr8cTNFZbxptCz0yWs703xBl99hx
 bXQ+4Q6jEsyv0jDcGD/q4wAjv2LGhBw1wYWzggJJxzF3CO3lAMw/focspyZgpAH3bLSzDR01+
 MXRwvm412D7JZGERovtW+6XIgrYdTRjmgeYmSOmUnNig17Gf10UCl++00KnxHOuiqU8l2sBxm
 zd9EKaZjTJngnXYqPtJZw30e7wsNxOqNzZgx1ArLFIn2qgvGnu4AMVsKDRQokJmOMrnqaeOM0
 3OP7mDeQoGFziurtFDNe5Z1vMgib2mh0SAdaVVFONNHSsttbl+BN6s9Q7HFEaH7jgdUMIP0Ht
 2YyTnZSCH5EftRiesdrEXLnii+DPG9nlzIaPbkkWs7s+1wijUoHLRSLpKY6+O4oSDlhY+WtjO
 gktG8JbjzdNDa/VPBj/riDhL2inDk1G/dTaVh3NwZOFqmHQ4KIVlv1EOWu1pD+kNw9PqiQ4WH
 mtmiltFhOc8RxN0PakzJekzgY/HSlGY67scXi4rWhNzVNLusJwPhulueNAstsVZUyvxfq1VQq
 TeDHZhgU7m0ydWQCATigeQTYSfWpRadm4FqTwFR2KGu95bXISls5WBHxSlBWqt6uMvS4hTbgr
 apQHx7E2JekwV/C4mmMEBvQBiyDF+/oMOhZAf1KLHhM3I741DE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

UTF-16 encoded files are treated as "binary" by Git, and no CRLF
conversion is done.
When the UTF-16 encoded files are converted into UF-8 using the new
"working-tree-encoding", the CRLF are converted if core.autocrlf is true.

This may lead to confusion:
A tool writes an UTF-16 encoded file with CRLF.
The file is commited with core.autocrlf=true, the CLRF are converted into LF.
The repo is pushed somewhere and cloned by a different user, who has
decided to use core.autocrlf=false.
He uses the same tool, and now the CRLF are not there as expected, but LF,
make the file useless for the tool.

Avoid this (possible) confusion by ignoring core.autocrlf for all files
which have "working-tree-encoding" defined.

The user can still use a .gitattributes file and specify the line endings
like "text=auto", "text", or "text eol=crlf" and let that .gitattribute
file travel together with push and clone.

Change convert.c to e more careful, simplify the initialization when
attributes are retrived (and none are specified) and update the documentation.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt |  9 ++++++---
 convert.c                       | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a8dbf4be3..3665c4677 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -308,12 +308,15 @@ Use the `working-tree-encoding` attribute only if you cannot store a file in
 UTF-8 encoding and if you want Git to be able to process the content as
 text.
 
+Note that when `working-tree-encoding` is defined, core.autocrlf is ignored.
+Set the `text` attribute (or `text=auto`) to enable CRLF conversions.
+
 Use the following attributes if your '*.txt' files are UTF-16 encoded
-with byte order mark (BOM) and you want Git to perform automatic line
-ending conversion based on your platform.
+with byte order mark (BOM) and you want Git to perform line
+ending conversion based on core.eol.
 
 ------------------------
-*.txt		text working-tree-encoding=UTF-16
+*.txt		working-tree-encoding=UTF-16 text
 ------------------------
 
 Use the following attributes if your '*.txt' files are UTF-16 little
diff --git a/convert.c b/convert.c
index 13fad490c..e7f11d1db 100644
--- a/convert.c
+++ b/convert.c
@@ -1264,15 +1264,24 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		}
 		ca->checkout_encoding = git_path_check_encoding(ccheck + 5);
 	} else {
-		ca->drv = NULL;
-		ca->crlf_action = CRLF_UNDEFINED;
-		ca->ident = 0;
+		memset(ca, 0, sizeof(*ca));
 	}
 
 	/* Save attr and make a decision for action */
 	ca->attr_action = ca->crlf_action;
 	if (ca->crlf_action == CRLF_TEXT)
 		ca->crlf_action = text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
+	/*
+	 * Often UTF-16 encoded files are read and written by programs which
+	 * really need CRLF, and it is important to keep the CRLF "as is" when
+	 * files are committed with core.autocrlf=true and the repo is pushed.
+	 * The CRLF would be converted into LF when the repo is cloned to
+	 * a machine with core.autocrlf=false.
+	 * Obey the "text" and "eol" attributes and be independent on the
+	 * local core.autocrlf for all "encoded" files.
+	 */
+	if ((ca->crlf_action == CRLF_UNDEFINED) && ca->checkout_encoding)
+		ca->crlf_action = CRLF_BINARY;
 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_FALSE)
 		ca->crlf_action = CRLF_BINARY;
 	if (ca->crlf_action == CRLF_UNDEFINED && auto_crlf == AUTO_CRLF_TRUE)
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

