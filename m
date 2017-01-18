Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC08A1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 12:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbdARMOr (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 07:14:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:55227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbdARMOq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 07:14:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LoEPJ-1cwGCS1n3Z-00gDhr; Wed, 18
 Jan 2017 13:14:37 +0100
Date:   Wed, 18 Jan 2017 13:14:35 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] mingw: follow-up to "replace isatty() hack"
Message-ID: <867bafbe582df549b10729a5d688458bb6a98d51.1484741665.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OemMwHzTQ2QuELNQTbs2Lg9l/1NdZfL3aV3W0N4Cz1YRNAZ9W38
 Z/cgTTFQBEghXpJRUn/od++8zGK2IE9I+Vmi+25QdBkSZRjLugRdGldFOHRaz1HvLDOFG+h
 4+8tWpRptPmPDz9BtFnqyex5PkwvjEN91Vh+L4USD0nGn3+4vlX2Er6LEY3meeORVSW9xfJ
 qGUDZ1tZ/0Ejc+rLl5EKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RYqBL4v4CxA=:Af0viiJhZKpfNx3AShJl1k
 au9iplwCdNExzzdoKVhWGrRAy1o35YYQZ4vytvopUi9pqbiCboqJMG/aFssajgv/o5/HmedcZ
 lv/sakEAeKNu6hcuDTxIUF+Ufn773UGnVRTw0a87XoGVqOXnxrkhfjXsv5shmgr73wzsOE+ev
 Zaai7UYidt340mjYIYy4Rd2AnhyzGzsLIxmGLFZkyVnv0sJleipncW+9hdBB51WvTU/+Pebro
 FqWpCWmbckIGFY+e1lDnjbTl5+na+JkZGe1gpJdsoVn97iPXeiGki0uShjK+3YfOq0hKg0d+Q
 3nW9T6finleDNoonuViql8mV/tjCz15D9Yp/0QwYAf8ylFyMHtB9r9RAUSrc1FJUPk3r2dJ/c
 5FaOj167BYC0WiOzzp0KDBKFJDeMs4128YxNF7k53tvj67XEOW0oug4rf22sPa0WfW0WoCsja
 nIZzXkNPIrARxwUEz4udLOyZUfcAvs7Dsd05TpNANfBhDm5frbFn40XJrkkG3IHtrFr6EaYwR
 NV17cj6cYRmM/LdrlGOtKbriB0SMNGlyKkexCc86odre7i0rfrOF2j5UKAOxMjqeQh9WkAA2b
 Hze2HslDmNqDoxvfvarUS+eOUPe/7OM2AUFauqqsAwLBoFcnFpU2sq+NqRPg6zWGSNNfSlfou
 ijR4X5+y5sa6b12Wyu3tvqvOpPa3/yufIFji93Mu732dlmrIK4j5rMDmuColBHEmKRI2u6TLg
 4CDqu/dsPSlu7b/ZZpB/fAdDeZa+rXd3FQ21fuWmrF0KTOCiR6blHrP5jmZvGxEQoWbLJ4Zbq
 GiP2W7K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The version of the "replace isatty() hack" that got applied to the
`maint` branch did not actually reflect the latest iteration of the
patch series: v3 was sent out with these changes, as requested by
the reviewer Johannes Sixt:

- reworded the comment about "recycling handles"

- moved the reassignment of the `console` variable before the dup2()
  call so that it is valid at all times

- removed the "handle = INVALID_HANDLE_VALUE" assignment, as the local
  variable `handle` is not used afterwards anyway

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-fixup-fixup-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-fixup-fixup-v1

 compat/winansi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3c9ed3cfe0..82b89ab137 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -494,19 +494,16 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
 	 * It is because of this implicit close() that we created the
 	 * copy of the original.
 	 *
-	 * Note that the OS can recycle HANDLE (numbers) just like it
-	 * recycles fd (numbers), so we must update the cached value
-	 * of "console".  You can use GetFileType() to see that
-	 * handle and _get_osfhandle(fd) may have the same number
-	 * value, but they refer to different actual files now.
+	 * Note that we need to update the cached console handle to the
+	 * duplicated one because the dup2() call will implicitly close
+	 * the original one.
 	 *
 	 * Note that dup2() when given target := {0,1,2} will also
 	 * call SetStdHandle(), so we don't need to worry about that.
 	 */
-	dup2(new_fd, fd);
 	if (console == handle)
 		console = duplicate;
-	handle = INVALID_HANDLE_VALUE;
+	dup2(new_fd, fd);
 
 	/* Close the temp fd.  This explicitly closes "new_handle"
 	 * (because it has been associated with it).

base-commit: 3313b78c145ba9212272b5318c111cde12bfef4a
-- 
2.11.0.windows.3
