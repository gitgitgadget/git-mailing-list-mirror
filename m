Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA8220370
	for <e@80x24.org>; Thu,  5 Oct 2017 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdJETlh (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:41:37 -0400
Received: from mout.web.de ([217.72.192.78]:63879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbdJETlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:41:35 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MUi-1d8EOM3gTk-00s4tz; Thu, 05
 Oct 2017 21:41:30 +0200
Subject: [PATCH v2] fsck: handle NULL return of lookup_blob() and
 lookup_tree()
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin Koegler <martin.koegler@chello.at>
References: <20171003102215.9952-1-szeder.dev@gmail.com>
 <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
 <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6bbe21c0-024e-ceed-6076-25f2330e598d@web.de>
Date:   Thu, 5 Oct 2017 21:41:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HvJc+EPYlZfkjvMFzRUTOvAxTkVg2HuCtMkCiLlWL266Iar/57M
 qQLjS9Ch1pJkyY1ElRr3nnxHiRx6Fq87gean8N1lwnvDaHHUbq0RK8OdXK9Gpu8g3yVz6G3
 RjMxUGPY0d2THZVV1hNxeUadp+SObP/V/NGLY2ZS7qc59Hco+YzzOnr3kI6JGYnNGbCZ0lV
 lodjY3rQrwCe+0gV73ffA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o9dBGKwXEZU=:tFKoksrLu94emAPcKtUQ67
 41vhpvQZvtQzAneW3U2SsOCk9JtvwLgc9ctFuqgaUg1uDDieklc2e9c0VAclEoM2XuXl+mXMP
 uf3Az+btXUpZ0CKhYDBfcswtjMUFhUEhr6D1KgXPGB1Lar8WDMJL5U0W6wtizqiJRB/R+5K5Q
 b54csCBQWnUg9Ykb/9gFVh9rzHOuKZCrLVeAycyX4husmz2vV6Af3jp3JVvRxlkD/C7xiDysE
 WSrjZAm8VwMW1lp27ePf3apjQS5kCGXO5BAc3uF7NS4sUDkLQdQV4fAPYDWMk886XnbpNpzTy
 oLZ2KXDTa6rO3/fqYgJdCOV/c8k7kc3LyoO73EB2z0F+IV4SzCozKgTYQEume1Ja05tL5GvSM
 CUZKyOpEnKGk87Mo9opYsC/7XXQQ50jDOVU1vuLRQZwH8AWLchDbW4591wGNBAqMBo636Sl8F
 XgWSd7mvmSd2k83vdIy53nbyqbbsLpMh+v2gnzqi56hoVcaGQFNuCiADqtQzmUR5EQj3oo5KD
 GR7YISwJmkusFYDSqjl5N1wRoArqN1IuqIByO13eUxCgr+dGDiP7/MCrJfHondNXFLGzNDnnf
 QOSwGowH60KJQJNIK0NghkW5NCv3bVwyw5aGZ0So8ujtKBvnh7ZQwkZJn4bGM97LSWjjXd8X0
 tIoiCe5gzz3GRcWLR2mQSUaQ/QOuRtraqGbYeRFVXx5B7NGIeMZePuBKXtF5insJzFdK1Prs4
 T5HpIF2dfCHGEU3tglcEe37kxO0h7nCitsRKbpxuaSt+UkoUzL/kJwhlQUGemm/NaB5J6dH/o
 FCdcjoM/uH+zmyYt5kWZGfNnWGFUMHPkHCzS0ZAICQ2HBSxAhI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lookup_blob() and lookup_tree() can return NULL if they find an object
of an unexpected type.  Accessing the object member is undefined in that
case.  Cast the result to a struct object pointer instead; we can do
that because object is the first member of all object types.  This trick
is already used in other places in the code.

An error message is already shown by object_as_type(), which is called
by the lookup functions.  The walk callback functions are expected to
handle NULL object pointers passed to them, but put_object_name() needs
a valid object, so avoid calling it without one.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Changes from v1:
- Don't abort on encountering an object with a mismatched type.
- Added a test for showing the problem with SANITIZE=address,undefined.

 fsck.c          |  8 ++++----
 t/t1450-fsck.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2ad00fc4d0..032699e9ac 100644
--- a/fsck.c
+++ b/fsck.c
@@ -358,15 +358,15 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
 			continue;
 
 		if (S_ISDIR(entry.mode)) {
-			obj = &lookup_tree(entry.oid)->object;
-			if (name)
+			obj = (struct object *)lookup_tree(entry.oid);
+			if (name && obj)
 				put_object_name(options, obj, "%s%s/", name,
 					entry.path);
 			result = options->walk(obj, OBJ_TREE, data, options);
 		}
 		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
-			obj = &lookup_blob(entry.oid)->object;
-			if (name)
+			obj = (struct object *)lookup_blob(entry.oid);
+			if (name && obj)
 				put_object_name(options, obj, "%s%s", name,
 					entry.path);
 			result = options->walk(obj, OBJ_BLOB, data, options);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 4087150db1..cb4b66e29d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -222,6 +222,28 @@ test_expect_success 'unparseable tree object' '
 	test_i18ngrep ! "fatal: empty filename in tree entry" out
 '
 
+hex2oct() {
+	perl -ne 'printf "\\%03o", hex for /../g'
+}
+
+test_expect_success 'tree entry with type mismatch' '
+	test_when_finished "remove_object \$blob" &&
+	test_when_finished "remove_object \$tree" &&
+	test_when_finished "remove_object \$commit" &&
+	test_when_finished "git update-ref -d refs/heads/type_mismatch" &&
+	blob=$(echo blob | git hash-object -w --stdin) &&
+	blob_bin=$(echo $blob | hex2oct) &&
+	tree=$(
+		printf "40000 dir\0${blob_bin}100644 file\0${blob_bin}" |
+		git hash-object -t tree --stdin -w --literally
+	) &&
+	commit=$(git commit-tree $tree) &&
+	git update-ref refs/heads/type_mismatch $commit &&
+	test_must_fail git fsck >out 2>&1 &&
+	test_i18ngrep "is a blob, not a tree" out &&
+	test_i18ngrep ! "dangling blob" out
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	cat >invalid-tag <<-\EOF &&
 	object ffffffffffffffffffffffffffffffffffffffff
-- 
2.14.2
