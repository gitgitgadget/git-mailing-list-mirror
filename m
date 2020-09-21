Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE124C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585852145D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtuU1DDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIUKkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIUKkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D3C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so12207497wrm.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xzhaOsaVkhcROsEBfYHJeZy2RGvDP5XRoZj+m9/oxE=;
        b=JtuU1DDCJ98O9b+dX9pH7vBp6Q+ASdk3Aw3LEK/53H192/nDT22iMPUkTiOrJgFS84
         ksOASOtppUU1PacVhFY3ifkvj+EkM7St4DKrqgUU51wjX0qoi/AUsMXZcXX0vG6LvsGd
         r4sHnPdR5qRyFkeyamKPMP7vUaVI3i25+Hyz7UXZ7YSUuuAioiVJCjlW+dvrsrjXXbq1
         P6WDPCeQG6Y18WfvCwUB++UnN6PAT90fpeIoXegOv7FzeIWNQVWIFyKsxJOz+uDIc95M
         /Y2Xiubn3ktxSmvaTPhWGuDd1LO6MfZnwpoLrzqfvjt9nas6fXra2rngdRM18+baWjVq
         7gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xzhaOsaVkhcROsEBfYHJeZy2RGvDP5XRoZj+m9/oxE=;
        b=S0KzTidh4wtuPm1GuqA/S01sfNZYlHObg9QXsLUXFs5oGKgIjzykaQPRgGINt7cQGT
         vY2J6vjlyQKHxmOwg7vUkrbgchgDEmPQGQz8dvXw6yLUwPBjCcw299Uq8LwPLjIbwNKE
         /h5PpHl8FtyT84yG6KOrddhqXVvFXndqH+mURvh6gtLpoMdL+lSM/db7RUqSAsJI1jRj
         Rd3JYsB3VpVXE57FxOhHhs2g9qU5qSXGgfl+xUhTCtaB8TfK/7vq0aW3bYI6DvOzDCiu
         Bs/Kgub0ecOa32cv+oZaMKRoFXJtB5joHA2u7hhN5PtYfY08rVmauENBvGqWlTe/Ds6V
         oYUg==
X-Gm-Message-State: AOAM531GyFxeVnEZ7Bk3K1Ed+/CAosfEJVorKlpDFhxm049sChOOgdd2
        Ccoyv+X6yFLZpedrArft+0KeS+MQJW5skw==
X-Google-Smtp-Source: ABdhPJxkk4DPwH6p1XLiiH7wgEU6FZWaNeLmtar/gobvKdlB9oDPj6uArsxIfmCUE6ecZ6nP3GladA==
X-Received: by 2002:adf:e690:: with SMTP id r16mr51274660wrm.15.1600684813407;
        Mon, 21 Sep 2020 03:40:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/18] remote-mediawiki: fix RCE issue, and the tests
Date:   Mon, 21 Sep 2020 12:39:42 +0200
Message-Id: <20200921104000.2304-1-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series now has a fix for a remote code execution which previously
was only being discussed on the closed git-security list. Per
discussion there the issue is being made public.

Basically, we expect that almost nobody is using this code in the
first place so there wasn't any interest in a point release, and there
wasn't any downstream interest in an embargo either.

This v2 addresses (hopefully) all the public & git-security commends
on the v1s of this series.

Simon Legner (1):
  remote-mediawiki: fix duplicate revisions being imported

Ævar Arnfjörð Bjarmason (17):
  remote-mediawiki doc: correct link to GitHub project
  remote-mediawiki doc: link to MediaWiki's current version
  remote-mediawiki doc: don't hardcode Debian PHP versions
  remote-mediawiki tests: use the login/password variables
  remote-mediawiki tests: use a 10 character password
  remote-mediawiki tests: use test_cmp in tests
  remote-mediawiki tests: change `[]` to `test`
  remote-mediawiki tests: use "$dir/" instead of "$dir."
  remote-mediawiki tests: use a more idiomatic dispatch table
  remote-mediawiki tests: replace deprecated Perl construct
  remote-mediawiki tests: use inline PerlIO for readability
  remote-mediawiki tests: use CLI installer
  remote-mediawiki tests: annotate failing tests
  remote-mediawiki: provide a list form of run_git()
  remote-mediawiki: convert to quoted run_git() invocation
  remote-mediawiki: annotate unquoted uses of run_git()
  remote-mediawiki: use "sh" to eliminate unquoted commands

 contrib/mw-to-git/git-mw.perl                 |   2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl   |  80 +++++----
 contrib/mw-to-git/git-remote-mediawiki.txt    |   2 +-
 contrib/mw-to-git/t/.gitignore                |   2 +-
 contrib/mw-to-git/t/README                    |  10 +-
 contrib/mw-to-git/t/install-wiki/.gitignore   |   1 -
 .../t/install-wiki/LocalSettings.php          | 129 --------------
 .../mw-to-git/t/install-wiki/db_install.php   | 120 -------------
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh  |   8 +-
 .../t/t9363-mw-to-git-export-import.sh        |   9 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh         | 162 +++++++++---------
 contrib/mw-to-git/t/test-gitmw.pl             |  22 ++-
 contrib/mw-to-git/t/test.config               |  23 +--
 13 files changed, 169 insertions(+), 401 deletions(-)
 delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php

Range-diff:
 1:  846fcf6e6a !  1:  9279eed8ea remote-mediawiki doc: bump recommended PHP version to 7.3
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    remote-mediawiki doc: bump recommended PHP version to 7.3
    +    remote-mediawiki doc: don't hardcode Debian PHP versions
     
    -    Change the version in the documentation to what's currently in Debian
    -    stable. Ideally we wouldn't have to keep changing this version, but if
    -    it's going to be hardcoded let's use something that works on a modern
    -    installation.
    +    Change the hardcoded version 5 PHP versions to the version-agnostic
    +    packages. Currently Debian stable's version is 7.3, and there's a
    +    php7.3, php7.3-cli etc. package available (but no php5-*).
    +
    +    The corresponding version-less package is a dependency package which
    +    depends on whatever the current stable version is. By not hardcoding
    +    the version these instructions won't be out of date when the next
    +    Debian/Ubuntu release happens.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ contrib/mw-to-git/t/README: install the following packages (Debian/Ubuntu names,
     -* php5-cli
     -* php5-curl
     -* php5-sqlite
    -+* php7.3
    -+* php7.3-cgi
    -+* php7.3-cli
    -+* php7.3-curl
    -+* php7.3-sqlite
    ++* php
    ++* php-cgi
    ++* php-cli
    ++* php-curl
    ++* php-sqlite
      
      Principles and Technical Choices
      --------------------------------
 2:  83910fbfde =  2:  5aca7b2fb4 remote-mediawiki tests: use the login/password variables
 3:  6e93ab0e28 !  3:  66cdbc967e remote-mediawiki tests: use a 10 character password
    @@ Metadata
      ## Commit message ##
         remote-mediawiki tests: use a 10 character password
     
    -    In more recent versions of MediaWiki this is a requirement, e.g. the current stable version of 1.32.2.
    +    In more recent versions of MediaWiki this is a requirement, e.g. the
    +    current stable version of 1.32.2.
     
         The web installer now refuses our old 9 character password, the
         command-line one (will be used in a subsequent change) will accept it,
 4:  8f89eb334c !  4:  10f7542bc3 remote-mediawiki tests: use test_cmp in tests
    @@ Metadata
      ## Commit message ##
         remote-mediawiki tests: use test_cmp in tests
     
    -    Change code that used an ad-hoc diff invocation to use our test_cmp
    -    helper instead. I'm also changing the order of arguments to be the
    -    standard "test_cmp <expected> <actual>".
    +    Change code that used an ad-hoc "diff -b" invocation to use our
    +    test_cmp helper instead. I'm also changing the order of arguments to
    +    be the standard "test_cmp <expected> <actual>".
    +
    +    Using test_cmp has different semantics since the "-b" option to diff
    +    causes it to ignore whitespace, but in these cases the use of "-b" was
    +    just meaningless boilerplate. The desired semantics here are to
    +    compare "git log" lines with know-good data, so we don't want to
    +    ignore whitespace.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 5:  b748cab648 <  -:  ---------- remote-mediawiki tests: guard test_cmp with test_path_is_file
 6:  5fdfdf02bb =  5:  4e2fb4b445 remote-mediawiki tests: change `[]` to `test`
 7:  706ca0e23d !  6:  5a1362d003 remote-mediawiki tests: use "$dir/" instead of "$dir."
    @@ Commit message
         remote-mediawiki tests: use "$dir/" instead of "$dir."
     
         Change UI messages to use "$dir/" instead of "$dir.". I think this is
    -    less confusing.
    +    less confusing when referring to an absolute directory path.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ contrib/mw-to-git/t/test-gitmw-lib.sh: wiki_install () {
      			"$MW_FILENAME. "\
      			"Please fix your connection and launch the script again."
     -		echo "$MW_FILENAME downloaded in $(pwd). "\
    -+		echo "$MW_FILENAME downloaded in $(pwd)/ "\
    - 			"You can delete it later if you want."
    +-			"You can delete it later if you want."
    ++		echo "$MW_FILENAME downloaded in $(pwd)/;" \
    ++		     "you can delete it later if you want."
      	else
     -		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)."
     +		echo "Reusing existing $MW_FILENAME downloaded in $(pwd)/"
 8:  34dde50515 =  7:  b79b0053ae remote-mediawiki tests: use a more idiomatic dispatch table
 9:  d45c8f3412 !  8:  05a9701841 remote-mediawiki tests: replace deprecated Perl construct
    @@ Metadata
      ## Commit message ##
         remote-mediawiki tests: replace deprecated Perl construct
     
    -    The use of the encoding pragma has been a hard error since Perl 5.18,
    -    which was released in 2013. What this script really wanted to do was
    -    to decode @ARGV and write out some files with the UTF-8 PerlIO
    -    layer. Let's just do that explicitly instead.
    +    The use of the encoding pragma has been a hard error since Perl
    +    5.18 (released in 2013).
    +
    +    What this script really wanted to do was to decode @ARGV and write out
    +    some files with the UTF-8 PerlIO layer. Let's just do that explicitly
    +    instead.
    +
    +    This explicitly does not retain the previous UTF-8 semantics of the
    +    script. The "encoding" pragma had all sorts of global effects (program
    +    text being UTF-8, stdin/stdout etc.). But the only thing that was
    +    required was decoding @ARGV and writing out UTF-8 data, which is
    +    currently facilitated with the "open" pragma.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
10:  75dbb1f772 =  9:  ceecab2bf0 remote-mediawiki tests: use inline PerlIO for readability
11:  6d3b1e9b60 ! 10:  cc00c528cb remote-mediawiki tests: use CLI installer
    @@ contrib/mw-to-git/t/test-gitmw-lib.sh: wiki_install () {
      	fi
      
     -	# Fetch MediaWiki's archive if not already present in the TMP directory
    -+	# Fetch MediaWiki's archive if not already present in download directory
    ++	# Fetch MediaWiki's archive if not already present in the
    ++	# download directory
     +	mkdir -p "$FILES_FOLDER_DOWNLOAD"
      	MW_FILENAME="mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
     -	cd "$TMP"
12:  3c29add4d2 = 11:  d7fb81d8a2 remote-mediawiki: fix duplicate revisions being imported
13:  2c3580c8db ! 12:  b9b10aed72 remote-mediawiki tests: annotate failing tests
    @@ Commit message
         intermittent test failures. Let's mark these as failing so we can have
         an otherwise passing test suite.
     
    +    We need to add an extra test_path_is_file() here because since
    +    d572f52a64 ("test_cmp: diagnose incorrect arguments", 2020-08-09)
    +    test_cmp has errored out with a BUG if one of the test arguments
    +    doesn't exist, without that the test would still fail even without
    +    test_expect_failure().
    +
         1. https://github.com/Git-Mediawiki/Git-Mediawiki/issues/56
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh: test_expect_success 'git p
      	test_when_finished "rm -rf mw_dir mw_dir_clone" &&
      	git clone -c remote.origin.mediaimport=true \
      		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
    + 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
    + 	(cd mw_dir_clone && git checkout HEAD^) &&
    + 	(cd mw_dir && git checkout HEAD^) &&
    ++	test_path_is_file mw_dir_clone/Foo.txt &&
    + 	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
    + '
    + 
 -:  ---------- > 13:  7bea20a373 remote-mediawiki: provide a list form of run_git()
 -:  ---------- > 14:  46189e2e58 remote-mediawiki: convert to quoted run_git() invocation
 -:  ---------- > 15:  2ad06f7334 remote-mediawiki: annotate unquoted uses of run_git()
 -:  ---------- > 16:  41cfcab3af remote-mediawiki: use "sh" to eliminate unquoted commands
-- 
2.28.0.297.g1956fa8f8d

