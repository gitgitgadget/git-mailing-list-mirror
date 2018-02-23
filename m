Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C8E1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBWMgW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 07:36:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:33227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750805AbeBWMgW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 07:36:22 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1dc-1fCQQ42Xzw-00VyMT; Fri, 23
 Feb 2018 13:36:12 +0100
Date:   Fri, 23 Feb 2018 13:35:56 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 01/12] sequencer: avoid using errno clobbered by
 rollback_lock_file()
In-Reply-To: <cover.1519389319.git.johannes.schindelin@gmx.de>
Message-ID: <8ec3a73dfdc76c503d50e34e5fc8b8a3d5ea7dd8.1519389319.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519389319.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WcX7Bw3E39UESmcJVmIuXdMNrKRWSsk8WdW7Qi9DB0ym/l0ym1e
 rGUD5eDjUVxyFciRnAu64wTRXNSzOW9PYe+3ZfTm1dEgKfuZ5ef7swZMhK51TCabTed5KA2
 TD3IVRhmxaJEvLE92yhj9C5JsEMwMv0voJT9jZCTs5J4zDogT+5+0P5JBkpClqiExEbA+vW
 Do0rJx+UTaBUl2zLIFc5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gF3qqx0q/O0=:3W2H0bt/Zgw1gVO3AOfzp9
 9MY5mlzFGgAjj82LLiUY/9f4FiAb80IbRuSzBVQC5bGmAFXdavbbvO7hx2+/PnUcr4X0LfcK3
 8UkIO1f4d7NWBH6OGgEy3K0VsM/23acFgA6CK7rnZmqlywlrbDMOBIDCCwGbnt9gB3RlZ1Ikd
 TabZpQhp3KRcXoTS+eaII9YvmkyqVQU9Bg4reIxmPdr2UPVB5+E/ZKxW15b+lQsKGyqKuu39y
 CfrveLPVQH635B1E323agL/e0Zj7F2mQP9bv3a7ydxYIrrhVpH+m7Mv72qs76axieUSX2uWmK
 Vsx10eXcg3sqRAzZXt2q5yEdoNlYK+J+XRs0TkphknuFuTJVrAtRbgFG6WOu4SaMYvf06RxsY
 BsWZqc2f8a1rXO5oySxDRM0V7Kh9+xpuhi5v4CSPygLZu6zl/aovLqo/UjPQqpW7i8dUtf1/+
 5Pz5DC5WFOdNk9UcW+eoa99e+3zXMdjQoSiEO+KvTzVrehmZfsvK8pxF52zEeEW90f5mAPXme
 hm+TO4KsKtaVgmvBphY9w9GVj22oyDTIi2e1Ko/b+hlR/hjiAdAQGnofFPYtRhCqFA+tCzjuS
 qd2KMLbcYHFZAZ8GSMaVtJtNC3MRaZjHDbaAc3+Olu2Ev8qA3AWy8Hg8dspdQLsgn0qOLJwgY
 LgyIk6894frgcVhff/Z3p99aY6/HH6x7kz37g/9aKGbT6hCCa7X190V2FHthx0lYkYYGQ/F46
 DxDVo9wiDat2mTHqytMvmBK6Em0ib0R9muu2it++oUOTe1DvLU+j3ubRuOY29xIAXoAlByPNA
 4ADvebUShp/CdKdod30fHttgdmZTBc/WmFyUab0yQfUaaXzyx8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As pointed out in a review of the `--recreate-merges` patch series,
`rollback_lock_file()` clobbers errno. Therefore, we have to report the
error message that uses errno before calling said function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e9baaf59bd9..5aa3dc3c95c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -345,12 +345,14 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	if (msg_fd < 0)
 		return error_errno(_("could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, buf, len) < 0) {
+		error_errno(_("could not write to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write to '%s'"), filename);
+		return -1;
 	}
 	if (append_eol && write(msg_fd, "\n", 1) < 0) {
+		error_errno(_("could not write eol to '%s'"), filename);
 		rollback_lock_file(&msg_file);
-		return error_errno(_("could not write eol to '%s'"), filename);
+		return -1;
 	}
 	if (commit_lock_file(&msg_file) < 0) {
 		rollback_lock_file(&msg_file);
@@ -2106,16 +2108,17 @@ static int save_head(const char *head)
 
 	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
 	if (fd < 0) {
+		error_errno(_("could not lock HEAD"));
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not lock HEAD"));
+		return -1;
 	}
 	strbuf_addf(&buf, "%s\n", head);
 	written = write_in_full(fd, buf.buf, buf.len);
 	strbuf_release(&buf);
 	if (written < 0) {
+		error_errno(_("could not write to '%s'"), git_path_head_file());
 		rollback_lock_file(&head_lock);
-		return error_errno(_("could not write to '%s'"),
-				   git_path_head_file());
+		return -1;
 	}
 	if (commit_lock_file(&head_lock) < 0) {
 		rollback_lock_file(&head_lock);
-- 
2.16.1.windows.4


