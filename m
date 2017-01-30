Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0737A1FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 12:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753104AbdA3M3L (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 07:29:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:59070 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752888AbdA3M3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 07:29:03 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LaFmY-1c432t3ozu-00m0dy; Mon, 30
 Jan 2017 13:28:34 +0100
Date:   Mon, 30 Jan 2017 13:28:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3] mingw: allow hooks to be .exe files
In-Reply-To: <9a27b90e771d4c97dc580d344e161d7cf8d632ce.1485433248.git.johannes.schindelin@gmx.de>
Message-ID: <78a73c9d0a8e38fcc61302d0495533dcc4fab076.1485779272.git.johannes.schindelin@gmx.de>
References: <9a27b90e771d4c97dc580d344e161d7cf8d632ce.1485433248.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VmBOOtLZxkOAoKWFHMBmcT4rJDd6JR27bu3r+EU6r/Uo6U7K2ae
 70fzEF61pU7ZyTLJtOhbqYz8MOvv8xKMJCLNAc7I2X0dWEXlsg/EEcxwTEpdPM7lFlCQt1K
 ClXcU5ntmYB277/jDL1FlnRdsqQclkDGi0eug003fgxc9+I67yHeN0ekO75ucWv4DJ+TEc6
 RhBcp8V4N68MI/BziebnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W5fTvFqsIsI=:PO91EHxdO2a32IVrYSFBAX
 QQN/1Wiu25C8JEEE18rvm4vQqDYJzldlDuuV8fEgAcrIy7rTLVevdJupNqK9eybsQulwknOxN
 4pfmI5Sh1aJXxiwq0dc2jroZKIRBWGUMlVL2HHvFxKoIuEyygUEjfoTqHjlgrZCwevXU7pGjt
 gesfVN5y9fl4m44tK81nj+pJpD4oE3wIN69/w8Cwzh8R/QWPsDGe6Wt2UaPcIoZq2RKQAKW9g
 AgH76kYkBMh/W1En5iJjTDIWjfqezFAlZn0CFHrLpJcsoCaBV+ZHJlrbq+PlSU/khUjy414Ll
 PKYJQJnRdhNwaeSHc45V5EWQYJl2PaOHmYHuCsD+0Ty9iMFd9N9UiAaOzxCPQQEw5efYmu3OD
 KK05SF3gF7Gc2RJr0naBUHnzDEQpbaYGeujlYPduJU8pZw5HaAhItWT3ya0dXiEk8IMMxdI5W
 NiygMa6l6rr87aXPDtOhff1CAfh1VWVkSdzwne5JguZmCwKY7Yxl4wuIj6lrIipKVY5+DQiib
 QSRKF6eAHClrdxVP7zXZaMzs+Ul4hbw4oo8XGM9SyVaEnj4B6arBtZJ1NL1aICGvOle1Qoyta
 XHKW4AFaNz+aIBJ7GBKCKONU17PltbomVPzNYEFetKOBNS0jqNiXX1Nv87mrZrCfT2xBFkNW4
 qKYX6RMu+Gw3/6wcvyIFFV5V8TOI985gWE/44fgs8YIIVZppkbZV4PAl8XaR/BGZOMFSL78oY
 GCfUyMlugPAnqqzqXt4p5o1Xs7tDHfbTN7o3Ez5hV+bVeryW0BiC5bsYhPBbRvRAXV5ZzH//Q
 3keipygaQlRhldSJZNjZyA5HirV9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Executable files in Windows need to have the extension '.exe', otherwise
they do not work. Extend the hooks to not just look at the hard coded
names, but also at the names extended by the custom STRIP_EXTENSION,
which is defined as '.exe' in Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/exe-as-hook-v3
Fetch-It-Via: git fetch https://github.com/dscho/git exe-as-hook-v3

 run-command.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 73bfba7ef9..5227f78aea 100644
--- a/run-command.c
+++ b/run-command.c
@@ -871,8 +871,14 @@ const char *find_hook(const char *name)
 
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
-	if (access(path.buf, X_OK) < 0)
+	if (access(path.buf, X_OK) < 0) {
+#ifdef STRIP_EXTENSION
+		strbuf_addstr(&path, STRIP_EXTENSION);
+		if (access(path.buf, X_OK) >= 0)
+			return path.buf;
+#endif
 		return NULL;
+	}
 	return path.buf;
 }
 

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
