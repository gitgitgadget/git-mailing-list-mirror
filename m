Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F315E1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeDTIEi (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:04:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:36935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754253AbeDTIEc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:04:32 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3NEK-1eIZQa0eo4-00r3O5; Fri, 20
 Apr 2018 10:04:28 +0200
Date:   Fri, 20 Apr 2018 10:04:12 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: [PATCH 3/3] Avoid multiple PREFIX definitions
In-Reply-To: <cover.1524211375.git.johannes.schindelin@gmx.de>
Message-ID: <d134afdd22c9cdfd763213b37efac4ef0399a374.1524211375.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wun/HQn3NpBHdSTe6X7dD/zJg0uGuuxU7Z0742gUhn9eodiKVYH
 HmK/L5u2wYsvjNoeAzGxaffVDpIx3uIOhUCU/jl1mVN0kXvqZYJlbwtSZtWqtubzfwe/lCf
 UNs25fdVFfLSOSEVIz9Ixu3inEuupXjh+dxUF+gb878EexbS+rHRdEunfCj7NU5L9ALSyjb
 JNBPtrdSnB+lsyisM/nPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kgu6zU4x00o=:JyE/zXLKFvkXKM+5+C9XX4
 4nwdZQM/SPhuGklqOcZ6Wuf+ZTAnWNOnR1lClnO6wmb2u1r9JlLR8CM2cdcoFhdfR5VDc0Ecf
 RddFOcBR7P7r3EdtvwlRHSGTE0VeHqfLF0H2yWEuS+ZbrL/FxOzqJyQFN10ZntavFlWvnb+HC
 JU9PYXlVn6sIMd3QBiXdarKOBtrgA/nx/ub17m9k7eTe3HIAcBlLWVFPhLKquBJs2+fw2xzKB
 OWoMPs8TuYxxWR6NcKG9lg5wjje54/+/ZNAYkxPzGQIy9jRZ2+fRcT8iznOrHhK/MTM7aBs7p
 RzXlv1hBMIrwxcS9/ilYYawnEIJKQbegxBHmsTNmFxmqO0QluqugnxL79rECUNgS1ascgnsyE
 pgmf8wCZCkArMAr/TxpAsBquJwmjhdJlOVaHaEumjmZlTjjThEfUI2iXzKy614A+15h6o6gWy
 xIYoktFBjMDb69yRioLarT9qV4XxOaCmesPS91qYG8H58xu8iW5VCGJ8xPL8uKcWc838rROk8
 yeYl5xIQTyYuED+olw/cTUWLj298SELhSyRNB5X7luRENnQn2dFldTxVC1CgcvpULH0XfSP1U
 dXdBWDSO/tGGFEKGd60E7CMpO/CWx9YqweAoAt7pSzkwTnAuk6nhGDKUFZ8zeXKLqHYklc9BU
 ZN3kr2myz/a7e1Q/clm7qbLzEl83omXpec8Bn/UnMB2++osp5UBicwfZ6t8/+7mHOQcjznRGr
 4dxWGA1a858KQnFRs5VVW/JTR8qaDrNbX7ujHGQsAMkDm9DbCpx8vMDuWknk/X7gofiwyoZ9Z
 aYrDPLzMjw8iyHenpTE7fhjkjwJzhutvJw4qheHTLSYpzD7mj4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

The short and sweet PREFIX can be confused when used in many places.

Rename both usages to better describe their purpose. EXEC_CMD_PREFIX is
used in full to disambiguate it from the nearby GIT_EXEC_PATH.

The PREFIX in sideband.c, while nominally independant of the exec_cmd
PREFIX, does reside within libgit[1], so the definitions would clash
when taken together with a PREFIX given on the command line for use by
exec_cmd.c.

Noticed when compiling Git for Windows using MSVC/Visual Studio [1] which
reports the conflict beteeen the command line definition and the
definition in sideband.c within the libgit project.

[1] the libgit functions are brought into a single sub-project
within the Visual Studio construction script provided in contrib,
and hence uses a single command for both exec_cmd.c and sideband.c.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile   |  2 +-
 exec-cmd.c |  4 ++--
 sideband.c | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 111e93d3bea..49cec672242 100644
--- a/Makefile
+++ b/Makefile
@@ -2271,7 +2271,7 @@ exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
-	'-DPREFIX="$(prefix_SQ)"'
+	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: GIT-PREFIX
 builtin/init-db.sp builtin/init-db.s builtin/init-db.o: EXTRA_CPPFLAGS = \
diff --git a/exec-cmd.c b/exec-cmd.c
index 3b0a039083a..02d31ee8971 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -48,7 +48,7 @@ static const char *system_prefix(void)
 	    !(prefix = strip_path_suffix(executable_dirname, GIT_EXEC_PATH)) &&
 	    !(prefix = strip_path_suffix(executable_dirname, BINDIR)) &&
 	    !(prefix = strip_path_suffix(executable_dirname, "git"))) {
-		prefix = PREFIX;
+		prefix = FALLBACK_RUNTIME_PREFIX;
 		trace_printf("RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
@@ -243,7 +243,7 @@ void git_resolve_executable_dir(const char *argv0)
  */
 static const char *system_prefix(void)
 {
-	return PREFIX;
+	return FALLBACK_RUNTIME_PREFIX;
 }
 
 /*
diff --git a/sideband.c b/sideband.c
index 6d7f943e438..325bf0e974a 100644
--- a/sideband.c
+++ b/sideband.c
@@ -13,7 +13,7 @@
  * the remote died unexpectedly.  A flush() concludes the stream.
  */
 
-#define PREFIX "remote: "
+#define DISPLAY_PREFIX "remote: "
 
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
@@ -49,7 +49,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 		switch (band) {
 		case 3:
 			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    PREFIX, buf + 1);
+				    DISPLAY_PREFIX, buf + 1);
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -67,7 +67,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 				int linelen = brk - b;
 
 				if (!outbuf.len)
-					strbuf_addstr(&outbuf, PREFIX);
+					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
 					strbuf_addf(&outbuf, "%.*s%s%c",
 						    linelen, b, suffix, *brk);
@@ -81,8 +81,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 			}
 
 			if (*b)
-				strbuf_addf(&outbuf, "%s%s",
-					    outbuf.len ? "" : PREFIX, b);
+				strbuf_addf(&outbuf, "%s%s", outbuf.len ?
+					    "" : DISPLAY_PREFIX, b);
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
-- 
2.17.0.windows.1.15.gaa56ade3205
