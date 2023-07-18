Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBECEB64DA
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 15:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjGRPoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjGRPoR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 11:44:17 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA901AC
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689695054; x=1690299854; i=l.s.r@web.de;
 bh=psIEBfI+Fxpio+ydSAxJYEFvqVZm72ls/xbkHpQjIfk=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=Sj8vvJIIO1NJBceUvbsuID9F9JGRXybx1JPHOhkpxrTRy1YP22Rqx4FiH5aBBgGa9cHGNx8
 FznFvD29xbb0U6h52weKUbk+s+HT/f70ULDFh/9jYJi2dRq7ukfJDjcoDwM0Ym4E7XS4gvHJ/
 FulXvlLxj3vde5Qc8hatu4dDgz8I6VPgEvRLQdQsb5tZBwhfJhjig1FOUqKnacOtOSKBjPrre
 P5DRuPup3zJD+G2oJZH3d4T8bqcfcy87KoBGJ4mgsvcXJcAnbGzrpQhynFQTK7WjOZN2ZefRE
 uAm9AVrqFbsgeSRKju/HEH56Iaa1XLdVoYRmc9EiVScAcX3wZwMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.224]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKbd-1q4OTc3szx-00r7mE for
 <git@vger.kernel.org>; Tue, 18 Jul 2023 17:44:13 +0200
Message-ID: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
Date:   Tue, 18 Jul 2023 17:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] ls-tree: fix --no-full-name
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:poJIiM/5ULuOZxc8GEkAUCsBFCPRY6uuSVaBC+ZfA3yJogfAcIn
 Dl5HiBG160aLanzjtzmL4SCWB4dZiNtKwL/75OWyFuUQiVTcmC8oY/A94ZLTV6n5xMmngIt
 iRN0+3U6zgrZCxT5Y4fUg2cBN3niBaZiyQv/zzZ9wFRVfD13n/g9clOTmV9I+XaCSloN1Ug
 YVG2wIa85/7rNqBk0AiMQ==
UI-OutboundReport: notjunk:1;M01:P0:0BDhlXXZ4IA=;1C+rWUdgpl9hK5mBbGrcOXoipz8
 ECqmU7+ILcV4a9QTO1VRiGS9J77+f3UK0vZKv/w8DrV8p14un75ann4By3+m9sjNcSBR1CTTv
 YMjQ32fx5ff6WJSPQlFn1orsepPQ6YxfAszApetv9hwUJzFu4Z5HEgJv5JCMJwPJ2c35Bweja
 kcu8yvmtiR0KzButeYA8SaQHGQ7Ba65irP4IyspHP+7tShbYzLAtpENQWTSX3iEFK2TiB8oJy
 ehkV/ZNVjDNCPZUNzAATDZrjMmzjgaTP7q+t0UnBJh7HVo4XbZ6T4cYv+L+BsgCPRci/LwkyV
 u1Ipa0BSOhYnM7TII9GuHJgp7IqIv1l568BYzE+jpLArwDW2UJlWaHuR5Qq0c+uTLFg96h3BK
 R5dF08o021ZyCZ4io3WWGODC56g17c9NSVukNWCAScPKE8KDqsFhy3+VufMwDHr2ns+EWFWbt
 FmSyBiZ5BGh/3xuUXXKCDWRBB99I+oioCtJAT32B7gpIbabyjfNDchPojPgvW16rpXtBMH9PU
 CO22gC/OsCa6g26cEY9fbyL0ekWlqSK0dx0Sr1xETlYHHWepOAFQ3j8/HVOsSEYvw7I5k36re
 kY0qv+E5L0qjQyDosCNvjkbqOAYZnfBN8WUoWzo00md+XklSFYfniKKm1FUwrITyjGJy7eqOb
 jpxyrYcr2RoiCaYU/12Kb1vE6MERvQ+fGE6BCpKDiGoBPrk8Ki6MA+BpHL9DO0p5aDRRaco4M
 DDTyV2cNKuK1z/a+FTg+9viXSE8GCcpxQWHA5EUrLSmqCOMDDYowOD4v5n5TznmiCYryywmuy
 XiqH4svsJNIwUukaQZSLqIdo8tLmwz1Z42XsoNzsvW5caCyXLzPBk6fHcgnLtwUsW2Rr4cF88
 tsq0RN5216GQ6029wSJUTbwfDyk+fQsgU21mLJ5aXbkgEmUm+AMWDofm6fOosnQUV3VY5sQma
 nVdK2qTesKzko3qb5EeKAc65oQs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 61fdbcf98b (ls-tree: migrate to parse-options, 2009-11-13) git
ls-tree has accepted the option --no-full-name, but it does the same
as --full-name, contrary to convention.  That's because it's defined
using OPT_SET_INT with a value of 0, where the negative variant sets
0 as well.

Turn --no-full-name into the opposite of --full-name by using OPT_BOOL
instead and storing the option's status directly in a variable named
"full_name" instead of in negated form in "chomp_prefix".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/ls-tree.c          | 7 +++----
 t/t3101-ls-tree-dirname.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 53073d64cb..f558db5f3b 100644
=2D-- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -343,7 +343,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 	struct object_id oid;
 	struct tree *tree;
 	int i, full_tree =3D 0;
-	int chomp_prefix =3D prefix && *prefix;
+	int full_name =3D !prefix || !*prefix;
 	read_tree_fn_t fn =3D NULL;
 	enum ls_tree_cmdmode cmdmode =3D MODE_DEFAULT;
 	int null_termination =3D 0;
@@ -365,8 +365,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)
 			    MODE_NAME_STATUS),
 		OPT_CMDMODE(0, "object-only", &cmdmode, N_("list only objects"),
 			    MODE_OBJECT_ONLY),
-		OPT_SET_INT(0, "full-name", &chomp_prefix,
-			    N_("use full path names"), 0),
+		OPT_BOOL(0, "full-name", &full_name, N_("use full path names")),
 		OPT_BOOL(0, "full-tree", &full_tree,
 			 N_("list entire tree; not just current directory "
 			    "(implies --full-name)")),
@@ -387,7 +386,7 @@ int cmd_ls_tree(int argc, const char **argv, const cha=
r *prefix)

 	if (full_tree)
 		prefix =3D NULL;
-	options.prefix =3D chomp_prefix ? prefix : NULL;
+	options.prefix =3D full_name ? NULL : prefix;

 	/*
 	 * We wanted to detect conflicts between --name-only and
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 217006d1bf..5af2dac0e4 100755
=2D-- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -154,6 +154,14 @@ EOF
 	test_output
 '

+test_expect_success 'ls-tree --no-full-name' '
+	git -C path0 ls-tree --no-full-name $tree a >current &&
+	cat >expected <<-EOF &&
+	040000 tree X	a
+	EOF
+	test_output
+'
+
 test_expect_success 'ls-tree --full-tree' '
 	(
 		cd path1/b/c &&
=2D-
2.41.0
