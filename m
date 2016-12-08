Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E271FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbcLHOYi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 09:24:38 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34734 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbcLHOYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 09:24:35 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so54696264wjc.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkvN62mPgB4MY3gmGQKeGneh0KXkpsk7hfZqC4F4dkY=;
        b=mmPjiKxveHihOIMQvEuFyn/Lnu8tKSJ2eTDgBo+xK8D8SupZExoytK4pv8U/Fz0fl4
         qpYuMVQe6c+jsaUJqWDPR+uDrgEU5KeI4sYZN9QWjlADqSuTxyM/OpjpnTUREyDlFRKB
         TgNsk5DGMl5uC5szY9t4n20q+TXmYgqeTJouei8M38stWn0iJ9hM1XB/oUlelBZt1slI
         pY7lllmJSCtbHjBN9M/szVyzIp3KItHMo/adJ/vpwYEGRM2PuT+Gs1Vj+tEfj4GF/St6
         ueDIXPb+K967qt2vHxLSk0791qFiI+5Tp+IxOwNwUV+71Tg/0W+ls5A7ALyGVX54CFfO
         gdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkvN62mPgB4MY3gmGQKeGneh0KXkpsk7hfZqC4F4dkY=;
        b=ZPAvnLztBtWa5iPh7/Y3nHgi5yM84XFbHWhzGUrdMylX88rsOcWeZErJh2fkEwBAR7
         p6KrckZBBfxIATPjwkSj1CbDA/zEChdgHKdD7EvkWpYeWWTjJrgaQs2M89fzf2CpvMNE
         MM4TstnhdfOEsixfid/Hx0gmsFVOl3P/xD6e5xkFvzMhYri4cDSY272Nyuvtjk6Yne5y
         neayZntCQQRuL8IkwoDOBTpM6x1zLsoCDbzHS0/TJZxAVEKEqbwj5uxMS9IagaEoqSv7
         FwfF+bq9tMB1vAKo7g4pLgr+j1lmu+NpX4IgTcWc170DrqBfOgOqfwkCZDF3WWcrkHwW
         L05Q==
X-Gm-Message-State: AKaTC02aIFe0GSxQcusW2xWMqdFqv4qMMVJ+JR75VXqkz9ABvPgMGOSfsD+/sTiszJIDmw==
X-Received: by 10.194.75.227 with SMTP id f3mr60959978wjw.19.1481207073625;
        Thu, 08 Dec 2016 06:24:33 -0800 (PST)
Received: from localhost.localdomain (x590d68ae.dyn.telefonica.de. [89.13.104.174])
        by smtp.gmail.com with ESMTPSA id l67sm15464028wmf.20.2016.12.08.06.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 06:24:33 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Leho Kraav <leho@conversionready.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 7/7] versioncmp: generalize version sort suffix reordering
Date:   Thu,  8 Dec 2016 15:24:01 +0100
Message-Id: <20161208142401.1329-8-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161208142401.1329-1-szeder.dev@gmail.com>
References: <20161005033353.Horde.33pf2naqnF4HgwPWSy9DaHV@webmail.informatik.kit.edu>
 <20161208142401.1329-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'versionsort.prereleaseSuffix' configuration variable, as its name
suggests, is supposed to only deal with tagnames with prerelease
suffixes, and allows sorting those prerelease tags in a user-defined
order before the suffixless main release tag, instead of sorting them
simply lexicographically.

However, the previous changes in this series resulted in an
interesting and useful property of version sort:

  - The empty string as a configured suffix matches all tagnames,
    including tagnames without any suffix, but

  - tagnames containing a "real" configured suffix are still ordered
    according to that real suffix, because any longer suffix takes
    precedence over the empty string.

Exploiting this property we can easily generalize suffix reordering
and specify the order of tags with given suffixes not only before but
even after a main release tag by using the empty suffix to denote the
position of the main release tag, without any algorithm changes:

  $ git -c versionsort.prereleaseSuffix=-alpha \
        -c versionsort.prereleaseSuffix=-beta \
        -c versionsort.prereleaseSuffix="" \
        -c versionsort.prereleaseSuffix=-gamma \
        -c versionsort.prereleaseSuffix=-delta \
        tag -l --sort=version:refname 'v3.0*'
  v3.0-alpha1
  v3.0-beta1
  v3.0
  v3.0-gamma1
  v3.0-delta1

Since 'versionsort.prereleaseSuffix' is not a fitting name for a
configuration variable to control this more general suffix reordering,
introduce the new variable 'versionsort.suffix'.  Still keep the old
configuration variable name as a deprecated alias, though, to avoid
suddenly breaking setups already using it.  Ignore the old variable if
both old and new configuration variables are set, but emit a warning
so users will be aware of it and can fix their configuration.  Extend
the documentation to describe and add a test to check this more
general behavior.

Note: since the empty suffix matches all tagnames, tagnames with
suffixes not included in the configuration are listed together with
the suffixless main release tag, ordered lexicographically right after
that, i.e. before tags with suffixes listed in the configuration
following the empty suffix.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config.txt  | 36 ++++++++++++++++++++++++++----------
 Documentation/git-tag.txt |  4 ++--
 t/t7004-tag.sh            | 35 +++++++++++++++++++++++++++++++++++
 versioncmp.c              |  9 ++++++++-
 4 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 58009c70c..ae85d4b9a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2999,16 +2999,32 @@ user.signingKey::
 	This option is passed unchanged to gpg's --local-user parameter,
 	so you may specify a key using any method that gpg supports.
 
-versionsort.prereleaseSuffix::
-	When version sort is used in linkgit:git-tag[1], prerelease
-	tags (e.g. "1.0-rc1") may appear after the main release
-	"1.0". By specifying the suffix "-rc" in this variable,
-	"1.0-rc1" will appear before "1.0".
-+
-This variable can be specified multiple times, once per suffix. The
-order of suffixes in the config file determines the sorting order
-(e.g. if "-pre" appears before "-rc" in the config file then 1.0-preXX
-is sorted before 1.0-rcXX).
+versionsort.prereleaseSuffix (deprecated)::
+	Deprecated alias for `versionsort.suffix`.  Ignored if
+	`versionsort.suffix` is set.
+
+versionsort.suffix::
+	Even when version sort is used in linkgit:git-tag[1], tagnames
+	with the same base version but different suffixes are still sorted
+	lexicographically, resulting e.g. in prerelease tags appearing
+	after the main release (e.g. "1.0-rc1" after "1.0").  This
+	variable can be specified to determine the sorting order of tags
+	with different suffixes.
++
+By specifying a single suffix in this variable, any tagname containing
+that suffix will appear before the corresponding main release.  E.g. if
+the variable is set to "-rc", then all "1.0-rcX" tags will appear before
+"1.0".  If specified multiple times, once per suffix, then the order of
+suffixes in the configuration will determine the sorting order of tagnames
+with those suffixes.  E.g. if "-pre" appears before "-rc" in the
+configuration, then all "1.0-preX" tags will be listed before any
+"1.0-rcX" tags.  The placement of the main release tag relative to tags
+with various suffixes can be determined by specifying the empty suffix
+among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck" and
+"-bfs" appear in the configuration in this order, then all "v4.8-rcX" tags
+are listed first, followed by "v4.8", then "v4.8-ckX" and finally
+"v4.8-bfsX".
++
 If more than one suffixes match the same tagname, then that tagname will
 be sorted according to the suffix which starts at the earliest position in
 the tagname.  If more than one different matching suffixes start at
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7ecca8e24..19990850d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -101,8 +101,8 @@ OPTIONS
 	multiple times, in which case the last key becomes the primary
 	key. Also supports "version:refname" or "v:refname" (tag
 	names are treated as versions). The "version:refname" sort
-	order can also be affected by the
-	"versionsort.prereleaseSuffix" configuration variable.
+	order can also be affected by the "versionsort.suffix"
+	configuration variable.
 	The keys supported are the same as those in `git for-each-ref`.
 	Sort order defaults to the value configured for the `tag.sort`
 	variable if it exists, or lexicographic order otherwise. See
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e2efe312d..bdd28dad1 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1595,6 +1595,41 @@ test_expect_success 'version sort with prerelease reordering, multiple suffixes
 	test_cmp expect actual
 '
 
+test_expect_success 'version sort with general suffix reordering' '
+	test_config versionsort.suffix -alpha &&
+	git config --add versionsort.suffix -beta &&
+	git config --add versionsort.suffix ""  &&
+	git config --add versionsort.suffix -gamma &&
+	git config --add versionsort.suffix -delta &&
+	git tag foo1.10-alpha &&
+	git tag foo1.10-beta &&
+	git tag foo1.10-gamma &&
+	git tag foo1.10-delta &&
+	git tag foo1.10-unlisted-suffix &&
+	git tag -l --sort=version:refname "foo1.10*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10-alpha
+	foo1.10-beta
+	foo1.10
+	foo1.10-unlisted-suffix
+	foo1.10-gamma
+	foo1.10-delta
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'versionsort.suffix overrides versionsort.prereleaseSuffix' '
+	test_config versionsort.suffix -before &&
+	test_config versionsort.prereleaseSuffix -after &&
+	git tag -l --sort=version:refname "foo1.7*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.7-before1
+	foo1.7
+	foo1.7-after1
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'version sort with very long prerelease suffix' '
 	test_config versionsort.prereleaseSuffix -very-looooooooooooooooooooooooong-prerelease-suffix &&
 	git tag -l --sort=version:refname
diff --git a/versioncmp.c b/versioncmp.c
index ae0a9199b..62c8d69dc 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -145,8 +145,15 @@ int versioncmp(const char *s1, const char *s2)
 	}
 
 	if (!initialized) {
+		const struct string_list *deprecated_prereleases;
 		initialized = 1;
-		prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
+		prereleases = git_config_get_value_multi("versionsort.suffix");
+		deprecated_prereleases = git_config_get_value_multi("versionsort.prereleasesuffix");
+		if (prereleases) {
+			if (deprecated_prereleases)
+				warning("ignoring versionsort.prereleasesuffix because versionsort.suffix is set");
+		} else
+			prereleases = deprecated_prereleases;
 	}
 	if (prereleases && swap_prereleases(s1, s2, (const char *) p1 - s1 - 1,
 					    &diff))
-- 
2.11.0.78.g5a2d011

