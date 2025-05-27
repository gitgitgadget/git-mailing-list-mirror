Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC925F980
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354581; cv=none; b=JtMThw5VBHONRYALyN96X9e7GX8kjCXiltXAGIm+17d6nJYy4POlUQtKP/SxGM7lL5YRJ6N8j/6cxvZ83og63x8LGFIW5CaP47nO0pww+yZdm0lzaynf2THg+6JWfEM9M1yIEbH0SxU/GcQG/aI8nRaEsKXzL8BkCcuIxlWVS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354581; c=relaxed/simple;
	bh=pro7Qbphyhnz+MNrh9yDaGu4mmHHiUU+PoQCQEEjHZc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HKK/VbIOCM88o/acFtC5dQVZbht+3dXrN477yr3bNQxv8CUNL0ZciRSbspRUvk7CD4oYw++jskgNJvJ8HmAoX+HbVQjoQ3YXeiDNG1JZ9wM7+4nAKmqQdAWOTfksqYHCS7VOLuPRpMVXi+Ubu/v1tpDns791Yrtk6EzDSeG33Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ab1HCgYd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lEiWfzG5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ab1HCgYd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lEiWfzG5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 01F511383AA9;
	Tue, 27 May 2025 10:02:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 27 May 2025 10:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354577;
	 x=1748440977; bh=k/wYljjvD1JLA65ReIWUoCBQpb6e/i4fYrJ4msiPkmY=; b=
	ab1HCgYdYkdddxoqJkaVUP+aVjoXU8IXsh/DgcSTIWkJHEelyxZh8NQEcPap8o8x
	8sd4d6AvKu+RvKebOxCLKjLxziz/7BBjCotnrlE+HLdWy5Uyk2ci8+hxJSX28vFG
	BBCMLLCCxBg97KoE1zP1uZ37GUoOoeWpzjAA/MHlOZpucmPp7d7yqqgBh+BJbkBh
	2Eyp5ZZlGKpX3gsFbttkM/iFKxKZ7SThJ2opkJV+XKbngsAlHe5VTjU9bWHG8FDq
	LJSlOjlkaFpWkOhIOEBHyTEcwZIMef775jJnerjqqZ9O3Dt99U54zudGvcItmkgV
	yhZFAzKFNACKSupyNSCf/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354577; x=
	1748440977; bh=k/wYljjvD1JLA65ReIWUoCBQpb6e/i4fYrJ4msiPkmY=; b=l
	EiWfzG5/hcp5JFWVkIVk57pk9nIoUVNqPdDVdZC9aKrFTFX/E7LvuAiLZT/k6Ti0
	k+AZtOuVIHe78PGPXa8B3BCX9LIRO5vHkWZwjBKC5DSGTlrIyhxadRxqlQwFtwJM
	nXJt5JAgT5mMZ/MSjiIGB00wRZcziJ1qDlIVfKPoX2ahQFnYFSnn+UOaPseDn8Zz
	vdQQND3miVIApsqZolKURaeVxxuPnKIScdfeLAM2zM9hZrqse6O4MESP93i2JhQF
	9oR2U7ZivIBmd0p7yDbd5ztNyHD7SeAw/tFJJxp7ngG55wl0yOUULdeXvVYI6a/T
	Tn2g9B17e8jAYRnukiMxA==
X-ME-Sender: <xms:EcY1aKBdZET9BOreJkqILFaHbMY1XBmIu_UmVHPBpd6t21U0vnUysw>
    <xme:EcY1aEi5T6KVe3aZ-X4NbkLnCFV5i5scK6qWmnw3nlcjOmxspMY7qmbUck2NvW02C
    60bCGYZSyNcxa_9Bg>
X-ME-Received: <xmr:EcY1aNnrKPJMIQ3DFw2vAfgpS3Y1oWYTbZe-psLQEuP_t1SEoBoUqIF9lD6D7A0uRnXeYj6L7YzTSTrFLnH7QNuEszcArF2oXnaR5c7D_AS5-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdeivdekjeekkeeu
    ffdttdehudeutddtjeehffdvfedtleffgefftdejteegfefhnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosghogidrtgho
    mhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhord
    horhhg
X-ME-Proxy: <xmx:EcY1aIzNQL5U-48mhUa6DAM6uPzHrQl1ffXFbUW9Kce0XQwbi_crOw>
    <xmx:EcY1aPQQl1uqKKoyqbUYf2P0GXP8WYw1rRbzGEvZd9aYDDzIh0OuyQ>
    <xmx:EcY1aDYMZHIoZnN-fdAvHmGpoM_lJqWjmfZfhmgKwQy-E_9B21ZVfQ>
    <xmx:EcY1aIRI9x95mkkfLzkQ1w35FbG9aZ00VEW3DeSoeWvS9rE-XXLWYw>
    <xmx:EcY1aEWmkW0oFqNxMXpvRm9cTJSYa21xEWdw4XhsXROx9KfWKh7yX0Vj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:02:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bd5bf4a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:02:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] meson: parse TAP output generated by our tests
Date: Tue, 27 May 2025 16:02:48 +0200
Message-Id: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAjGNWgC/13MQQ6CQAyF4auQrq0Z6kCCK+9hWFSo0hiYyZQQD
 eHujrhz+bd53womScXgXKyQZFHTMOWgQwHdwNNDUPvcQI4q56nB+DQcxcKEM0csRfraeXbEJ8i
 bmOSur927trkHtTmk984v5ff6kypX/0lLiQ4rZr5R44l9d8n/o47Qbtv2ASmVHC2nAAAA
X-Change-ID: 20250429-pks-meson-tap-1eed604a02a3
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series starts to parse TAP output generated by our tests when
executing them via Meson. This has the benefit that Meson starts to
understand skipped tests and reports how many subtests have been
executed:

    ```
    $ meson test t002*
    ninja: Entering directory `/home/pks/Development/git/build'
     1/10 t0024-crlf-archive                  OK              0.17s   2 subtests passed
     2/10 t0022-crlf-rename                   OK              0.18s   2 subtests passed
     3/10 t0029-core-unsetenvvars             SKIP            0.15s
     4/10 t0023-crlf-am                       OK              0.18s   2 subtests passed
     5/10 t0025-crlf-renormalize              OK              0.21s   3 subtests passed
     6/10 t0026-eol-config                    OK              0.25s   5 subtests passed
     7/10 t0020-crlf                          OK              0.81s   36 subtests passed
     8/10 t0028-working-tree-encoding         OK              0.85s   22 subtests passed
     9/10 t0021-conversion                    OK              3.45s   38 subtests passed
    10/10 t0027-auto-crlf                     OK             26.35s   2600 subtests passed
    
    Ok:                9
    Fail:              0
    Skipped:           1
    ```

This new feature is only enabled with Meson 1.8 and newer, which
contains a bugfix that we have upstreamed [1] to make the TAP parser
work in `meson test --interactive` mode.

Despite the changes to Meson itself, this patch series also contains a
couple of fixes for our test suite that caused us to not generate proper
TAP output.

Changes in v2:
  - Add a patch to fix an unexpectedly passing test on macOS.
  - A couple more fixes for broken TAP output.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im

Note that I've rebased the series on top of 845c48a16a7 (The seventeenth
batch, 2025-05-23), mostly so that I get hold of the recent CI changes
for GitLab that make the MSVC+Meson run unconditionally. There was no
conflicts though, so it should be fine to retain the old merge base.

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/pull/13980

---
Patrick Steinhardt (6):
      t: fix cases where output breaks TAP format
      t/test-lib: don't print shell traces to stdout
      t/test-lib: fix TAP format for BASH_XTRACEFD warning
      t7815: fix unexpectedly passing test on macOS
      meson: introduce kwargs variable for tests
      meson: parse TAP output generated by our tests

 contrib/credential/netrc/meson.build         |  2 +-
 contrib/subtree/meson.build                  |  2 +-
 meson.build                                  | 12 ++++++++++
 t/meson.build                                |  6 ++---
 t/t0000-basic.sh                             | 35 +++++++++++++++-------------
 t/t0050-filesystem.sh                        |  5 ----
 t/t1007-hash-object.sh                       |  2 +-
 t/t3600-rm.sh                                |  5 ----
 t/t4000-diff-format.sh                       |  2 +-
 t/t4041-diff-submodule-option.sh             |  4 ++--
 t/t4060-diff-submodule-option-diff-format.sh |  2 +-
 t/t7401-submodule-summary.sh                 |  4 ++--
 t/t7815-grep-binary.sh                       |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh       | 14 +++++------
 t/t9822-git-p4-path-encoding.sh              | 13 +++++++----
 t/t9835-git-p4-metadata-encoding-python2.sh  |  4 ++--
 t/t9836-git-p4-metadata-encoding-python3.sh  |  4 ++--
 t/t9903-bash-prompt.sh                       |  4 ----
 t/test-lib.sh                                |  9 ++++---
 19 files changed, 70 insertions(+), 61 deletions(-)

Range-diff versus v1:

1:  8ffeaa53d63 ! 1:  022430e0434 t: fix cases where output breaks TAP format
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## t/t0050-filesystem.sh ##
    +@@ t/t0050-filesystem.sh: aumlcdiar=$(printf '\141\314\210')
    + 
    + if test_have_prereq CASE_INSENSITIVE_FS
    + then
    +-	say "will test on a case insensitive filesystem"
    + 	test_case=test_expect_failure
    + else
    + 	test_case=test_expect_success
    +@@ t/t0050-filesystem.sh: fi
    + 
    + if test_have_prereq UTF8_NFD_TO_NFC
    + then
    +-	say "will test on a unicode corrupting filesystem"
    + 	test_unicode=test_expect_failure
    + else
    + 	test_unicode=test_expect_success
    + fi
    + 
    +-test_have_prereq SYMLINKS ||
    +-	say "will test on a filesystem lacking symbolic links"
    +-
    + if test_have_prereq CASE_INSENSITIVE_FS
    + then
    + test_expect_success "detection of case insensitive filesystem during repo init" '
    +
      ## t/t1007-hash-object.sh ##
     @@ t/t1007-hash-object.sh: setup_repo() {
      
    @@ t/t1007-hash-object.sh: setup_repo() {
      
      	setup_repo
     
    + ## t/t3600-rm.sh ##
    +@@ t/t3600-rm.sh: test_expect_success 'Initialize test directory' '
    + 	git commit -m "add normal files"
    + '
    + 
    +-if test_have_prereq !FUNNYNAMES
    +-then
    +-	say 'Your filesystem does not allow tabs in filenames.'
    +-fi
    +-
    + test_expect_success FUNNYNAMES 'add files with funny names' '
    + 	touch -- "tab	embedded" "newline${LF}embedded" &&
    + 	git add -- "tab	embedded" "newline${LF}embedded" &&
    +
    + ## t/t4000-diff-format.sh ##
    +@@ t/t4000-diff-format.sh: test_expect_success 'git diff-files -p after editing work tree.' '
    + # that's as far as it comes
    + if [ "$(git config --get core.filemode)" = false ]
    + then
    +-	say 'filemode disabled on the filesystem'
    ++	skip_all='filemode disabled on the filesystem'
    + 	test_done
    + fi
    + 
    +
      ## t/t4041-diff-submodule-option.sh ##
     @@ t/t4041-diff-submodule-option.sh: commit_file () {
      	git commit "$@" -m "Commit $*" >/dev/null
    @@ t/t9500-gitweb-standalone-no-errors.sh: test_expect_success \
      	cat >>gitweb_config.perl <<-\EOF
      	our $highlight_bin = "highlight";
      	$feature{'highlight'}{'override'} = 1;
    +
    + ## t/t9822-git-p4-path-encoding.sh ##
    +@@ t/t9822-git-p4-path-encoding.sh: test_description='Clone repositories with non ASCII paths'
    + UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
    + ISO8859_ESCAPED="a-\344_o-\366_u-\374.txt"
    + 
    +-ISO8859="$(printf "$ISO8859_ESCAPED")" &&
    +-echo content123 >"$ISO8859" &&
    +-rm "$ISO8859" || {
    ++test_lazy_prereq FS_ACCEPTS_ISO_8859_1 '
    ++	ISO8859="$(printf "$ISO8859_ESCAPED")" &&
    ++	echo content123 >"$ISO8859" 2>/dev/null &&
    ++	rm "$ISO8859"
    ++'
    ++
    ++if ! test_have_prereq FS_ACCEPTS_ISO_8859_1
    ++then
    + 	skip_all="fs does not accept ISO-8859-1 filenames"
    + 	test_done
    +-}
    ++fi
    + 
    + test_expect_success 'start p4d' '
    + 	start_p4d
    +
    + ## t/t9835-git-p4-metadata-encoding-python2.sh ##
    +@@ t/t9835-git-p4-metadata-encoding-python2.sh: failing, and produces maximally sane output in git.'
    + # These tests are specific to Python 2. Write a custom script that executes
    + # git-p4 directly with the Python 2 interpreter to ensure that we use that
    + # version even if Git was compiled with Python 3.
    +-python_target_binary=$(which python2)
    ++python_target_binary=$(which python2 2>/dev/null)
    + if test -n "$python_target_binary"
    + then
    + 	mkdir temp_python
    +@@ t/t9835-git-p4-metadata-encoding-python2.sh: then
    + fi
    + 
    + git p4-python2 >err
    +-if ! grep 'valid commands' err
    ++if ! grep -q 'valid commands' err
    + then
    + 	skip_all="skipping python2 git p4 tests; python2 not available"
    + 	test_done
    +
    + ## t/t9836-git-p4-metadata-encoding-python3.sh ##
    +@@ t/t9836-git-p4-metadata-encoding-python3.sh: failing, and produces maximally sane output in git.'
    + # These tests are specific to Python 3. Write a custom script that executes
    + # git-p4 directly with the Python 3 interpreter to ensure that we use that
    + # version even if Git was compiled with Python 2.
    +-python_target_binary=$(which python3)
    ++python_target_binary=$(which python3 2>/dev/null)
    + if test -n "$python_target_binary"
    + then
    + 	mkdir temp_python
    +@@ t/t9836-git-p4-metadata-encoding-python3.sh: then
    + fi
    + 
    + git p4-python3 >err
    +-if ! grep 'valid commands' err
    ++if ! grep -q 'valid commands' err
    + then
    + 	skip_all="skipping python3 git p4 tests; python3 not available"
    + 	test_done
    +
    + ## t/t9903-bash-prompt.sh ##
    +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - unborn branch' '
    + 	test_cmp expected "$actual"
    + '
    + 
    +-if test_have_prereq !FUNNYNAMES; then
    +-	say 'Your filesystem does not allow newlines in filenames.'
    +-fi
    +-
    + test_expect_success FUNNYNAMES 'prompt - with newline in path' '
    +     repo_with_newline="repo
    + with
2:  2d6afea4853 = 2:  35e2b7f3a08 t/test-lib: don't print shell traces to stdout
-:  ----------- > 3:  996920aa372 t/test-lib: fix TAP format for BASH_XTRACEFD warning
-:  ----------- > 4:  ae584ae3400 t7815: fix unexpectedly passing test on macOS
3:  d2ba541c2f6 = 5:  5cfbf9dde27 meson: introduce kwargs variable for tests
4:  73649d77893 ! 6:  d242cde7831 meson: parse TAP output generated by our tests
    @@ Commit message
             Skipped:           1
             ```
     
    +    Note that when running `meson test --interactive` the test results will
    +    now be marked as "ignored". This is because in interactive mode the file
    +    descriptors will remain connected to the user's terminal, and it is
    +    expected that the user interacts with the tests (e.g., spawn a debugger
    +    or use `test_pause`). As such, the TAP output cannot be parsed reliably
    +    by Meson in that case, so the tests are marked as ignored accordingly.
    +
         [1]: https://github.com/mesonbuild/meson/pull/13980
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250429-pks-meson-tap-1eed604a02a3

