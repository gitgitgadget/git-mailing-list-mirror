Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A748A20562
	for <e@80x24.org>; Mon, 30 Oct 2017 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbdJ3RKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:10:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:60770 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932501AbdJ3RKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:10:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt2BW-1dBMyM1AJm-012UqP; Mon, 30
 Oct 2017 18:10:28 +0100
Date:   Mon, 30 Oct 2017 18:10:27 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] mingw: special-case GIT_REDIRECT_STDERR=2>&1
In-Reply-To: <cover.1509382976.git.johannes.schindelin@gmx.de>
Message-ID: <bb3cec73c50a36af31b029ab37949decdfe45857.1509382976.git.johannes.schindelin@gmx.de>
References: <cover.1509382976.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:oNiq0PHrAbr9svEsPgIZM6JJhur2wmFMVHDbbJSE5VCy/fN0fv+
 sm2nckMOXEFpg1r4W5inXbNA/Mo1iPF+TSslgsE7XuRg4BeRTHkrJShX31Ca3lO78+ZhC0N
 quqra9jnKqwkkPV7aFlfOuD6380rtSpIMEATcoH0TY7q/Iem0WIlAuZoc3LFv6o9wbp86o+
 iGyh0MewTo62rwQVPEaIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:khT3m10j4V8=:PwQI6oKapu1pis7CC2PGh/
 b3Q/OKYk/cvykIajSa3T8H44gaoQP5zzjSzLJcMnpvznuIfUjjRe7rJzOtXEyy15/4HO84O9O
 M0HEweQZGGUdbZpEbObu9vLUz/JYaa1bqRhrATAoWvdb+mEdxUS90zmPbupZIZgPUpbTFklNT
 bVJvsMrqg4dybzTpG4XA21R+3RhLW4B7YN6aLuywLYRz4hBwguD9ANjPJTOigXgdzjLYuUm+F
 ttXpCVOlwPw88yYPwUwEouDpTPJFX04jXB/mSRRFGqbTEyQWesXsMNlZfBjDVKFob7jzVGVlc
 +f2ulRUk+jA3kBj+Yt6HpE+/AbjWiQmc7dkIFyXw1mQer8mQx4MBBPw9C+ydi/0FEmhrh96to
 Y9KQnBorAWMAyQJg6mVuNLWP6HzIMAibcQCXN2faCy1FCa1VJW2p63Zos2CCAmB+R+21ZzlrX
 rDsx/q9Dk0Erwbocft8d8LNxsqvBCbELmgkIyvnUzkGlLT7a2kfLdF/7LGF6GQPUWgMRzSS7Z
 CFFQ92doU24MvyiXW3l8Hi7KwS9Xb9KyDKpb/4T6pT+JOX5QK+ZVfS4ubEAZLSpCpZCbRK3uw
 WIW34qN99TtURr9ZLhpPmnWXkzBIfDtRlrZOpztAxaslNSS6itmWfGZNpadZ+OmQZYaBJ0hvt
 L4MvdQD9JtReD5AemSnp0N+w4F1QvNkp70YhKIZU4eJ/1b79CU2VPWfd6vjxz+xeTjfQwd+EI
 nvbzgTcik17O1qA4M0jyxqBXkFZczdxq8mH80YcqgZcf9EeXPUn3wJvp/DFaQnTqONK34oxUc
 sZUHt3qcY/FiT9YMH+5CekSTPB3OI5U9N2SZRBed5yZOeEkDohj3WSYAmAO4nrntgjtAWOu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "2>&1" notation in POSIX shells implies that stderr is redirected to
stdout. Let's special-case this value for the environment variable
GIT_REDIRECT_STDERR to allow writing to the same destination as stdout.

The functionality was suggested by Jeff Hostetler.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c  | 15 +++++++++++++++
 t/t0001-init.sh |  8 +++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6c6c7795a70..2d44d21aca8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2160,6 +2160,21 @@ static void maybe_redirect_std_handle(const wchar_t *key, DWORD std_id, int fd,
 			CloseHandle(handle);
 		return;
 	}
+	if (std_id == STD_ERROR_HANDLE && !wcscmp(buf, L"2>&1")) {
+		handle = GetStdHandle(STD_OUTPUT_HANDLE);
+		if (handle == INVALID_HANDLE_VALUE) {
+			close(fd);
+			handle = GetStdHandle(std_id);
+			if (handle != INVALID_HANDLE_VALUE)
+				CloseHandle(handle);
+		} else {
+			int new_fd = _open_osfhandle((intptr_t)handle, O_BINARY);
+			SetStdHandle(std_id, handle);
+			dup2(new_fd, fd);
+			/* do *not* close the new_fd: that would close stdout */
+		}
+		return;
+	}
 	handle = CreateFileW(buf, desired_access, 0, NULL, create_flag,
 			     flags, NULL);
 	if (handle != INVALID_HANDLE_VALUE) {
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0fd2fc45385..c413bff9cf1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -456,7 +456,13 @@ test_expect_success 're-init from a linked worktree' '
 test_expect_success MINGW 'redirect std handles' '
 	GIT_REDIRECT_STDOUT=output.txt git rev-parse --git-dir &&
 	test .git = "$(cat output.txt)" &&
-	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)"
+	test -z "$(GIT_REDIRECT_STDOUT=off git rev-parse --git-dir)" &&
+	test_must_fail env \
+		GIT_REDIRECT_STDOUT=output.txt \
+		GIT_REDIRECT_STDERR="2>&1" \
+		git rev-parse --git-dir --verify refs/invalid &&
+	printf ".git\nfatal: Needed a single revision\n" >expect &&
+	test_cmp expect output.txt
 '
 
 test_done
-- 
2.15.0.windows.1


