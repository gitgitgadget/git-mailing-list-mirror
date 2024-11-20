Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DE1A9B2A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110035; cv=none; b=r9TrxfglSIw/sHzAALuav4L1w5EO/a4+DVucq1snowuAHk3TYBQz6L2t0EhuAPLF4gPRHQJSmfnPbCLg9ggsU3gbZKRoKCy5tkwga/O6DdXOIYf+vVu04lg6y8yKXON+HAYG0x36DZ1wdSLN18H62JVpVt2/spOT5BlelU55VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110035; c=relaxed/simple;
	bh=rF6uqJgwvHHEsAZuM93xg7wxyv4WhyMTEzp7ggejiB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfwpFQUGD0KhppRso2bwx94i1lX1V7FDd6kIMORoXDF2JmsBYYUs+h8u5hoD6lN8RM0BmCttXDtXsPvrzRoLdeKmTNBaDpt8YhwmHwKI7mnQdFy6G3MbKnwZa8DNhg7v4BY/L66nKJCaz+u+AesNJjDY4ob+fJzl5cIWcYcRZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BmdJXoRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2NhMfb5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BmdJXoRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2NhMfb5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1C9511400CF;
	Wed, 20 Nov 2024 08:40:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 20 Nov 2024 08:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110016;
	 x=1732196416; bh=qsgtuieRIJwTEDuxxR+yScD5w4gB7eFz74+DX36egvA=; b=
	BmdJXoRdvmsq1zgAXbFqydrwq/P+qfhBkAbfvZVh6Y6WLIj+AruambZJncaEcZLk
	59aZ7Q/UtjLL2NYKCRKa8D113aQDabMYKLrjZuMn3rxKOfPG4W+oWTFNJ92M0+/h
	y3ws+uKZxVlWzsYv42vtIeb/cPRosQJsdFweigjUYlGc744m8nzWKIISGLpcORN5
	qXMtdaN+IZYg1d2vI+S7r5NE7KbfFTH3LJfVnLG5PZshAUylPL6NA/63wYez2Z8G
	7uwwXBRcdj+Q0MjhUGl/drPMBgqdvGzcQVAD+kOlxw8P0HN1t2BeLO6hctCfVRS2
	dDFwR7Ci6+uyq7bU9HCZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110016; x=
	1732196416; bh=qsgtuieRIJwTEDuxxR+yScD5w4gB7eFz74+DX36egvA=; b=S
	2NhMfb53/C7t5esb02wyMranV81YPRUFXcPdNJNoa4npNE+eb98OKX0JrE24iohR
	8W6NDhc/0lMEd+UWzIPVxzSEie4USmVptOsuyAga0WceUiqg2KjNJPOG75oqspHj
	5Q5Y3Q8vNOT0TADU5+tOHEGc+mCXwDrqSBJxBHe/6r4pNSCLF3qxGi1TWKab3ekY
	XWPvCc55DuS2wiex4UbxHKZ4XG0wNp2qr/+lXt0i91gukXpVacxe4X6wUEXtv/DV
	gViXbvMMkveOeSfrx4L9M4TgEkhLZlrzGU5WcTOKqVvLCB674rfMSS0jGDD4qTFR
	d7ibPXwPV/iRbwRO72I+w==
X-ME-Sender: <xms:wOY9Z1zrNJ3ikgbGLZsvQWJmz9BEsBsyWkVKUUb5wrq8OeThfLi7og>
    <xme:wOY9Z1T6woMuyvha2X6OmET3zB8vVQI-ytPXSsosOUVqxRsWm32uDKe1cqkWFxgz4
    HNMw04R_gzYSVaZCw>
X-ME-Received: <xmr:wOY9Z_VlvNtgiZZd3xrSc23Mrsxih_NKcoPUcWQaSgyRU5YPb_aRLhgNP_6KPPy7Xzcl-ryt7Oic-m2QzYQ_-YDbJ1yrUHRxlyKBtUhPjMfk5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteefteegvedtgfegheejffekiefhhfdtgeetfedtfeef
    ueekgfelvdffveefteejnecuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdhshh
    grlhhlohifrdhshhdphhhtthhpqdhpuhhshhdqfigvsggurghvrdhshhdphhhtthhpqdhp
    uhhshhdqshhmrghrthdrshhhpdhhthhtphdrshhhpdhhthhtphdqfhgvthgthhdqughumh
    gsrdhshhdphhhtthhpqdhfvghttghhqdhsmhgrrhhtrdhshhdphhhtthhpqdhsmhgrrhht
    qdgtohhmmhhonhdrshhhpdhhthhtphdqghgvthdrshhhpdhhthhtphdqsggrtghkvghnug
    dqnhhoshgvrhhvvghrrdhshhdphhhtthhpqdgsrggtkhgvnhgurdhshhdphhhtthhpqdgs
    rggtkhgvnhguqdgtohhnthgvnhhtqdhlvghnghhthhdrshhhpdhhthhtphdqrghuthhhrd
    hshhdphhhtthhpqdhprhhogiihrdhshhdphhhtthhpqdgtuhhrlhdqvhgvrhgsohhsvgdr
    shhhpdhhthhtphdqshhtrghtuhhsrdhshhdpthgvshhtqdhlihgsrdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wOY9Z3jzkIs0xybKxz8qXgvT2SYyjPBsZX5AqOPsFDY7xyrYHlgWbA>
    <xmx:wOY9Z3A-WWY8xaI5cHdZUcs5Xmwx7Li-BOcBv5XvUadnbc8zmOodIw>
    <xmx:wOY9ZwLSPvLo9nFA6tHjS_YGOMR8hXxzypCv4SgAwBt44qm3vZ73DQ>
    <xmx:wOY9Z2DI4l31fh26zjSrPtcfhtvPR-qm_QQG5a2wWol0EXwnnU0kPQ>
    <xmx:wOY9Zy8Dgd9W5MiFUIkOtmrgXGEFfThWqpwd-PNWzrvnSLCJ-kkrK3yw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:40:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de7fc185 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:56 +0100
Subject: [PATCH v3 27/27] t: remove TEST_PASSES_SANITIZE_LEAK annotations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-27-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Now that the default value for TEST_PASSES_SANITIZE_LEAK is `true` there
is no longer a need to have that variable declared in all of our tests.
Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh                                    | 1 -
 t/t0002-gitfile.sh                                 | 1 -
 t/t0003-attributes.sh                              | 1 -
 t/t0004-unwritable.sh                              | 1 -
 t/t0005-signals.sh                                 | 1 -
 t/t0006-date.sh                                    | 1 -
 t/t0007-git-var.sh                                 | 1 -
 t/t0008-ignores.sh                                 | 1 -
 t/t0010-racy-git.sh                                | 1 -
 t/t0012-help.sh                                    | 1 -
 t/t0013-sha1dc.sh                                  | 1 -
 t/t0014-alias.sh                                   | 1 -
 t/t0017-env-helper.sh                              | 1 -
 t/t0018-advice.sh                                  | 1 -
 t/t0019-json-writer.sh                             | 1 -
 t/t0020-crlf.sh                                    | 1 -
 t/t0021-conversion.sh                              | 1 -
 t/t0022-crlf-rename.sh                             | 1 -
 t/t0023-crlf-am.sh                                 | 1 -
 t/t0024-crlf-archive.sh                            | 1 -
 t/t0025-crlf-renormalize.sh                        | 1 -
 t/t0026-eol-config.sh                              | 1 -
 t/t0027-auto-crlf.sh                               | 1 -
 t/t0028-working-tree-encoding.sh                   | 1 -
 t/t0029-core-unsetenvvars.sh                       | 1 -
 t/t0030-stripspace.sh                              | 1 -
 t/t0033-safe-directory.sh                          | 1 -
 t/t0035-safe-bare-repository.sh                    | 1 -
 t/t0040-parse-options.sh                           | 1 -
 t/t0041-usage.sh                                   | 1 -
 t/t0050-filesystem.sh                              | 1 -
 t/t0052-simple-ipc.sh                              | 1 -
 t/t0055-beyond-symlinks.sh                         | 1 -
 t/t0056-git-C.sh                                   | 1 -
 t/t0060-path-utils.sh                              | 1 -
 t/t0061-run-command.sh                             | 1 -
 t/t0062-revision-walking.sh                        | 1 -
 t/t0063-string-list.sh                             | 1 -
 t/t0066-dir-iterator.sh                            | 1 -
 t/t0067-parse_pathspec_file.sh                     | 1 -
 t/t0068-for-each-repo.sh                           | 1 -
 t/t0070-fundamental.sh                             | 1 -
 t/t0071-sort.sh                                    | 1 -
 t/t0080-unit-test-output.sh                        | 1 -
 t/t0081-find-pack.sh                               | 1 -
 t/t0090-cache-tree.sh                              | 1 -
 t/t0091-bugreport.sh                               | 1 -
 t/t0092-diagnose.sh                                | 1 -
 t/t0095-bloom.sh                                   | 1 -
 t/t0100-previous.sh                                | 1 -
 t/t0101-at-syntax.sh                               | 1 -
 t/t0200-gettext-basic.sh                           | 1 -
 t/t0201-gettext-fallbacks.sh                       | 1 -
 t/t0202-gettext-perl.sh                            | 1 -
 t/t0203-gettext-setlocale-sanity.sh                | 1 -
 t/t0204-gettext-reencode-sanity.sh                 | 1 -
 t/t0210-trace2-normal.sh                           | 1 -
 t/t0211-trace2-perf.sh                             | 1 -
 t/t0212-trace2-event.sh                            | 1 -
 t/t0300-credentials.sh                             | 1 -
 t/t0301-credential-cache.sh                        | 1 -
 t/t0302-credential-store.sh                        | 1 -
 t/t0303-credential-external.sh                     | 1 -
 t/t0410-partial-clone.sh                           | 1 -
 t/t0411-clone-from-partial.sh                      | 1 -
 t/t0450-txt-doc-vs-help.sh                         | 1 -
 t/t0500-progress-display.sh                        | 1 -
 t/t0600-reffiles-backend.sh                        | 1 -
 t/t0601-reffiles-pack-refs.sh                      | 1 -
 t/t0602-reffiles-fsck.sh                           | 1 -
 t/t0610-reftable-basics.sh                         | 1 -
 t/t0611-reftable-httpd.sh                          | 1 -
 t/t0612-reftable-jgit-compatibility.sh             | 1 -
 t/t0613-reftable-write-options.sh                  | 1 -
 t/t1000-read-tree-m-3way.sh                        | 1 -
 t/t1001-read-tree-m-2way.sh                        | 1 -
 t/t1002-read-tree-m-u-2way.sh                      | 1 -
 t/t1003-read-tree-prefix.sh                        | 1 -
 t/t1004-read-tree-m-u-wf.sh                        | 1 -
 t/t1005-read-tree-reset.sh                         | 1 -
 t/t1006-cat-file.sh                                | 1 -
 t/t1007-hash-object.sh                             | 1 -
 t/t1008-read-tree-overlay.sh                       | 1 -
 t/t1009-read-tree-new-index.sh                     | 1 -
 t/t1010-mktree.sh                                  | 1 -
 t/t1011-read-tree-sparse-checkout.sh               | 1 -
 t/t1012-read-tree-df.sh                            | 1 -
 t/t1013-read-tree-submodule.sh                     | 1 -
 t/t1014-read-tree-confusing.sh                     | 1 -
 t/t1015-read-index-unmerged.sh                     | 1 -
 t/t1016-compatObjectFormat.sh                      | 1 -
 t/t1020-subdirectory.sh                            | 1 -
 t/t1021-rerere-in-workdir.sh                       | 1 -
 t/t1022-read-tree-partial-clone.sh                 | 1 -
 t/t1050-large.sh                                   | 1 -
 t/t1051-large-conversion.sh                        | 1 -
 t/t1060-object-corruption.sh                       | 1 -
 t/t1090-sparse-checkout-scope.sh                   | 1 -
 t/t1091-sparse-checkout-builtin.sh                 | 1 -
 t/t1092-sparse-checkout-compatibility.sh           | 1 -
 t/t1100-commit-tree-options.sh                     | 1 -
 t/t1300-config.sh                                  | 1 -
 t/t1301-shared-repo.sh                             | 1 -
 t/t1302-repo-version.sh                            | 1 -
 t/t1303-wacky-config.sh                            | 1 -
 t/t1304-default-acl.sh                             | 1 -
 t/t1305-config-include.sh                          | 1 -
 t/t1306-xdg-files.sh                               | 1 -
 t/t1307-config-blob.sh                             | 1 -
 t/t1308-config-set.sh                              | 1 -
 t/t1309-early-config.sh                            | 1 -
 t/t1310-config-default.sh                          | 1 -
 t/t1350-config-hooks-path.sh                       | 1 -
 t/t1400-update-ref.sh                              | 1 -
 t/t1401-symbolic-ref.sh                            | 1 -
 t/t1402-check-ref-format.sh                        | 1 -
 t/t1403-show-ref.sh                                | 1 -
 t/t1404-update-ref-errors.sh                       | 1 -
 t/t1405-main-ref-store.sh                          | 1 -
 t/t1406-submodule-ref-store.sh                     | 1 -
 t/t1407-worktree-ref-store.sh                      | 1 -
 t/t1408-packed-refs.sh                             | 1 -
 t/t1409-avoid-packing-refs.sh                      | 1 -
 t/t1410-reflog.sh                                  | 1 -
 t/t1411-reflog-show.sh                             | 1 -
 t/t1412-reflog-loop.sh                             | 1 -
 t/t1413-reflog-detach.sh                           | 1 -
 t/t1414-reflog-walk.sh                             | 1 -
 t/t1415-worktree-refs.sh                           | 1 -
 t/t1416-ref-transaction-hooks.sh                   | 1 -
 t/t1417-reflog-updateref.sh                        | 1 -
 t/t1418-reflog-exists.sh                           | 1 -
 t/t1419-exclude-refs.sh                            | 1 -
 t/t1420-lost-found.sh                              | 1 -
 t/t1430-bad-ref-name.sh                            | 1 -
 t/t1450-fsck.sh                                    | 1 -
 t/t1451-fsck-buffer.sh                             | 1 -
 t/t1460-refs-migrate.sh                            | 1 -
 t/t1500-rev-parse.sh                               | 1 -
 t/t1501-work-tree.sh                               | 1 -
 t/t1502-rev-parse-parseopt.sh                      | 1 -
 t/t1503-rev-parse-verify.sh                        | 1 -
 t/t1504-ceiling-dirs.sh                            | 1 -
 t/t1505-rev-parse-last.sh                          | 1 -
 t/t1506-rev-parse-diagnosis.sh                     | 1 -
 t/t1507-rev-parse-upstream.sh                      | 1 -
 t/t1508-at-combinations.sh                         | 1 -
 t/t1510-repo-setup.sh                              | 1 -
 t/t1511-rev-parse-caret.sh                         | 1 -
 t/t1512-rev-parse-disambiguation.sh                | 1 -
 t/t1513-rev-parse-prefix.sh                        | 1 -
 t/t1514-rev-parse-push.sh                          | 1 -
 t/t1515-rev-parse-outside-repo.sh                  | 1 -
 t/t1517-outside-repo.sh                            | 1 -
 t/t1600-index.sh                                   | 1 -
 t/t1601-index-bogus.sh                             | 1 -
 t/t1700-split-index.sh                             | 1 -
 t/t1701-racy-split-index.sh                        | 1 -
 t/t1800-hook.sh                                    | 1 -
 t/t2000-conflict-when-checking-files-out.sh        | 1 -
 t/t2002-checkout-cache-u.sh                        | 1 -
 t/t2003-checkout-cache-mkdir.sh                    | 1 -
 t/t2004-checkout-cache-temp.sh                     | 1 -
 t/t2005-checkout-index-symlinks.sh                 | 1 -
 t/t2006-checkout-index-basic.sh                    | 1 -
 t/t2007-checkout-symlink.sh                        | 1 -
 t/t2008-checkout-subdir.sh                         | 1 -
 t/t2009-checkout-statinfo.sh                       | 1 -
 t/t2010-checkout-ambiguous.sh                      | 1 -
 t/t2011-checkout-invalid-head.sh                   | 1 -
 t/t2012-checkout-last.sh                           | 1 -
 t/t2013-checkout-submodule.sh                      | 1 -
 t/t2014-checkout-switch.sh                         | 1 -
 t/t2015-checkout-unborn.sh                         | 1 -
 t/t2016-checkout-patch.sh                          | 1 -
 t/t2017-checkout-orphan.sh                         | 1 -
 t/t2018-checkout-branch.sh                         | 1 -
 t/t2019-checkout-ambiguous-ref.sh                  | 1 -
 t/t2020-checkout-detach.sh                         | 1 -
 t/t2021-checkout-overwrite.sh                      | 1 -
 t/t2022-checkout-paths.sh                          | 1 -
 t/t2023-checkout-m.sh                              | 1 -
 t/t2024-checkout-dwim.sh                           | 1 -
 t/t2025-checkout-no-overlay.sh                     | 1 -
 t/t2026-checkout-pathspec-file.sh                  | 1 -
 t/t2027-checkout-track.sh                          | 1 -
 t/t2030-unresolve-info.sh                          | 1 -
 t/t2050-git-dir-relative.sh                        | 1 -
 t/t2060-switch.sh                                  | 1 -
 t/t2070-restore.sh                                 | 1 -
 t/t2071-restore-patch.sh                           | 1 -
 t/t2072-restore-pathspec-file.sh                   | 1 -
 t/t2080-parallel-checkout-basics.sh                | 1 -
 t/t2081-parallel-checkout-collisions.sh            | 1 -
 t/t2082-parallel-checkout-attributes.sh            | 1 -
 t/t2100-update-cache-badpath.sh                    | 1 -
 t/t2101-update-index-reupdate.sh                   | 1 -
 t/t2102-update-index-symlinks.sh                   | 1 -
 t/t2103-update-index-ignore-missing.sh             | 1 -
 t/t2104-update-index-skip-worktree.sh              | 1 -
 t/t2105-update-index-gitfile.sh                    | 1 -
 t/t2106-update-index-assume-unchanged.sh           | 1 -
 t/t2107-update-index-basic.sh                      | 1 -
 t/t2108-update-index-refresh-racy.sh               | 1 -
 t/t2200-add-update.sh                              | 1 -
 t/t2201-add-update-typechange.sh                   | 1 -
 t/t2202-add-addremove.sh                           | 1 -
 t/t2203-add-intent.sh                              | 1 -
 t/t2204-add-ignored.sh                             | 1 -
 t/t2205-add-worktree-config.sh                     | 1 -
 t/t2300-cd-to-toplevel.sh                          | 1 -
 t/t2400-worktree-add.sh                            | 1 -
 t/t2401-worktree-prune.sh                          | 1 -
 t/t2402-worktree-list.sh                           | 1 -
 t/t2403-worktree-move.sh                           | 1 -
 t/t2404-worktree-config.sh                         | 1 -
 t/t2405-worktree-submodule.sh                      | 1 -
 t/t2406-worktree-repair.sh                         | 1 -
 t/t2407-worktree-heads.sh                          | 1 -
 t/t2408-worktree-relative.sh                       | 1 -
 t/t2500-untracked-overwriting.sh                   | 1 -
 t/t2501-cwd-empty.sh                               | 1 -
 t/t3000-ls-files-others.sh                         | 1 -
 t/t3001-ls-files-others-exclude.sh                 | 1 -
 t/t3002-ls-files-dashpath.sh                       | 1 -
 t/t3003-ls-files-exclude.sh                        | 1 -
 t/t3004-ls-files-basic.sh                          | 1 -
 t/t3005-ls-files-relative.sh                       | 1 -
 t/t3006-ls-files-long.sh                           | 1 -
 t/t3007-ls-files-recurse-submodules.sh             | 1 -
 t/t3008-ls-files-lazy-init-name-hash.sh            | 1 -
 t/t3009-ls-files-others-nonsubmodule.sh            | 1 -
 t/t3010-ls-files-killed-modified.sh                | 1 -
 t/t3011-common-prefixes-and-directory-traversal.sh | 1 -
 t/t3012-ls-files-dedup.sh                          | 1 -
 t/t3013-ls-files-format.sh                         | 1 -
 t/t3020-ls-files-error-unmatch.sh                  | 1 -
 t/t3040-subprojects-basic.sh                       | 1 -
 t/t3050-subprojects-fetch.sh                       | 1 -
 t/t3060-ls-files-with-tree.sh                      | 1 -
 t/t3070-wildmatch.sh                               | 1 -
 t/t3100-ls-tree-restrict.sh                        | 1 -
 t/t3101-ls-tree-dirname.sh                         | 1 -
 t/t3102-ls-tree-wildcards.sh                       | 1 -
 t/t3103-ls-tree-misc.sh                            | 1 -
 t/t3104-ls-tree-format.sh                          | 1 -
 t/t3105-ls-tree-output.sh                          | 1 -
 t/t3200-branch.sh                                  | 1 -
 t/t3201-branch-contains.sh                         | 1 -
 t/t3202-show-branch.sh                             | 1 -
 t/t3203-branch-output.sh                           | 1 -
 t/t3204-branch-name-interpretation.sh              | 1 -
 t/t3205-branch-color.sh                            | 1 -
 t/t3206-range-diff.sh                              | 1 -
 t/t3207-branch-submodule.sh                        | 1 -
 t/t3211-peel-ref.sh                                | 1 -
 t/t3300-funny-names.sh                             | 1 -
 t/t3301-notes.sh                                   | 1 -
 t/t3302-notes-index-expensive.sh                   | 1 -
 t/t3303-notes-subtrees.sh                          | 1 -
 t/t3304-notes-mixed.sh                             | 1 -
 t/t3305-notes-fanout.sh                            | 1 -
 t/t3306-notes-prune.sh                             | 1 -
 t/t3307-notes-man.sh                               | 1 -
 t/t3308-notes-merge.sh                             | 1 -
 t/t3309-notes-merge-auto-resolve.sh                | 1 -
 t/t3310-notes-merge-manual-resolve.sh              | 1 -
 t/t3311-notes-merge-fanout.sh                      | 1 -
 t/t3320-notes-merge-worktrees.sh                   | 1 -
 t/t3321-notes-stripspace.sh                        | 1 -
 t/t3400-rebase.sh                                  | 1 -
 t/t3401-rebase-and-am-rename.sh                    | 1 -
 t/t3402-rebase-merge.sh                            | 1 -
 t/t3403-rebase-skip.sh                             | 1 -
 t/t3404-rebase-interactive.sh                      | 1 -
 t/t3405-rebase-malformed.sh                        | 1 -
 t/t3406-rebase-message.sh                          | 1 -
 t/t3407-rebase-abort.sh                            | 1 -
 t/t3408-rebase-multi-line.sh                       | 1 -
 t/t3409-rebase-environ.sh                          | 1 -
 t/t3412-rebase-root.sh                             | 1 -
 t/t3413-rebase-hook.sh                             | 1 -
 t/t3415-rebase-autosquash.sh                       | 1 -
 t/t3416-rebase-onto-threedots.sh                   | 1 -
 t/t3417-rebase-whitespace-fix.sh                   | 1 -
 t/t3418-rebase-continue.sh                         | 1 -
 t/t3419-rebase-patch-id.sh                         | 1 -
 t/t3420-rebase-autostash.sh                        | 1 -
 t/t3421-rebase-topology-linear.sh                  | 1 -
 t/t3422-rebase-incompatible-options.sh             | 1 -
 t/t3423-rebase-reword.sh                           | 1 -
 t/t3424-rebase-empty.sh                            | 1 -
 t/t3425-rebase-topology-merges.sh                  | 1 -
 t/t3426-rebase-submodule.sh                        | 1 -
 t/t3427-rebase-subtree.sh                          | 1 -
 t/t3428-rebase-signoff.sh                          | 1 -
 t/t3429-rebase-edit-todo.sh                        | 1 -
 t/t3430-rebase-merges.sh                           | 1 -
 t/t3431-rebase-fork-point.sh                       | 1 -
 t/t3432-rebase-fast-forward.sh                     | 1 -
 t/t3433-rebase-across-mode-change.sh               | 1 -
 t/t3434-rebase-i18n.sh                             | 1 -
 t/t3435-rebase-gpg-sign.sh                         | 1 -
 t/t3436-rebase-more-options.sh                     | 1 -
 t/t3437-rebase-fixup-options.sh                    | 1 -
 t/t3438-rebase-broken-files.sh                     | 1 -
 t/t3500-cherry.sh                                  | 1 -
 t/t3501-revert-cherry-pick.sh                      | 1 -
 t/t3502-cherry-pick-merge.sh                       | 1 -
 t/t3503-cherry-pick-root.sh                        | 1 -
 t/t3504-cherry-pick-rerere.sh                      | 1 -
 t/t3505-cherry-pick-empty.sh                       | 1 -
 t/t3506-cherry-pick-ff.sh                          | 1 -
 t/t3507-cherry-pick-conflict.sh                    | 1 -
 t/t3508-cherry-pick-many-commits.sh                | 1 -
 t/t3509-cherry-pick-merge-df.sh                    | 1 -
 t/t3510-cherry-pick-sequence.sh                    | 1 -
 t/t3511-cherry-pick-x.sh                           | 1 -
 t/t3512-cherry-pick-submodule.sh                   | 1 -
 t/t3513-revert-submodule.sh                        | 1 -
 t/t3514-cherry-pick-revert-gpg.sh                  | 1 -
 t/t3600-rm.sh                                      | 1 -
 t/t3601-rm-pathspec-file.sh                        | 1 -
 t/t3602-rm-sparse-checkout.sh                      | 1 -
 t/t3650-replay-basics.sh                           | 1 -
 t/t3700-add.sh                                     | 1 -
 t/t3701-add-interactive.sh                         | 1 -
 t/t3702-add-edit.sh                                | 1 -
 t/t3703-add-magic-pathspec.sh                      | 1 -
 t/t3704-add-pathspec-file.sh                       | 1 -
 t/t3705-add-sparse-checkout.sh                     | 1 -
 t/t3800-mktag.sh                                   | 1 -
 t/t3900-i18n-commit.sh                             | 1 -
 t/t3901-i18n-patch.sh                              | 1 -
 t/t3902-quoted.sh                                  | 1 -
 t/t3903-stash.sh                                   | 1 -
 t/t3904-stash-patch.sh                             | 1 -
 t/t3905-stash-include-untracked.sh                 | 1 -
 t/t3906-stash-submodule.sh                         | 1 -
 t/t3907-stash-show-config.sh                       | 1 -
 t/t3908-stash-in-worktree.sh                       | 1 -
 t/t3909-stash-pathspec-file.sh                     | 1 -
 t/t3920-crlf-messages.sh                           | 1 -
 t/t4000-diff-format.sh                             | 1 -
 t/t4001-diff-rename.sh                             | 1 -
 t/t4002-diff-basic.sh                              | 1 -
 t/t4003-diff-rename-1.sh                           | 1 -
 t/t4004-diff-rename-symlink.sh                     | 1 -
 t/t4005-diff-rename-2.sh                           | 1 -
 t/t4006-diff-mode.sh                               | 1 -
 t/t4007-rename-3.sh                                | 1 -
 t/t4008-diff-break-rewrite.sh                      | 1 -
 t/t4009-diff-rename-4.sh                           | 1 -
 t/t4010-diff-pathspec.sh                           | 1 -
 t/t4011-diff-symlink.sh                            | 1 -
 t/t4012-diff-binary.sh                             | 1 -
 t/t4013-diff-various.sh                            | 1 -
 t/t4014-format-patch.sh                            | 1 -
 t/t4015-diff-whitespace.sh                         | 1 -
 t/t4016-diff-quote.sh                              | 1 -
 t/t4017-diff-retval.sh                             | 1 -
 t/t4018-diff-funcname.sh                           | 1 -
 t/t4019-diff-wserror.sh                            | 1 -
 t/t4020-diff-external.sh                           | 1 -
 t/t4021-format-patch-numbered.sh                   | 1 -
 t/t4022-diff-rewrite.sh                            | 1 -
 t/t4023-diff-rename-typechange.sh                  | 1 -
 t/t4024-diff-optimize-common.sh                    | 1 -
 t/t4025-hunk-header.sh                             | 1 -
 t/t4026-color.sh                                   | 1 -
 t/t4027-diff-submodule.sh                          | 1 -
 t/t4028-format-patch-mime-headers.sh               | 1 -
 t/t4029-diff-trailing-space.sh                     | 1 -
 t/t4030-diff-textconv.sh                           | 1 -
 t/t4031-diff-rewrite-binary.sh                     | 1 -
 t/t4032-diff-inter-hunk-context.sh                 | 1 -
 t/t4033-diff-patience.sh                           | 1 -
 t/t4034-diff-words.sh                              | 1 -
 t/t4035-diff-quiet.sh                              | 1 -
 t/t4036-format-patch-signer-mime.sh                | 1 -
 t/t4037-diff-r-t-dirs.sh                           | 1 -
 t/t4038-diff-combined.sh                           | 1 -
 t/t4039-diff-assume-unchanged.sh                   | 1 -
 t/t4040-whitespace-status.sh                       | 1 -
 t/t4041-diff-submodule-option.sh                   | 1 -
 t/t4042-diff-textconv-caching.sh                   | 1 -
 t/t4043-diff-rename-binary.sh                      | 1 -
 t/t4044-diff-index-unique-abbrev.sh                | 1 -
 t/t4045-diff-relative.sh                           | 1 -
 t/t4046-diff-unmerged.sh                           | 1 -
 t/t4047-diff-dirstat.sh                            | 1 -
 t/t4048-diff-combined-binary.sh                    | 1 -
 t/t4049-diff-stat-count.sh                         | 1 -
 t/t4050-diff-histogram.sh                          | 1 -
 t/t4051-diff-function-context.sh                   | 1 -
 t/t4052-stat-output.sh                             | 1 -
 t/t4053-diff-no-index.sh                           | 1 -
 t/t4054-diff-bogus-tree.sh                         | 1 -
 t/t4055-diff-context.sh                            | 1 -
 t/t4056-diff-order.sh                              | 1 -
 t/t4057-diff-combined-paths.sh                     | 1 -
 t/t4058-diff-duplicates.sh                         | 1 -
 t/t4059-diff-submodule-not-initialized.sh          | 1 -
 t/t4060-diff-submodule-option-diff-format.sh       | 1 -
 t/t4061-diff-indent.sh                             | 1 -
 t/t4062-diff-pickaxe.sh                            | 1 -
 t/t4063-diff-blobs.sh                              | 1 -
 t/t4064-diff-oidfind.sh                            | 1 -
 t/t4065-diff-anchored.sh                           | 1 -
 t/t4066-diff-emit-delay.sh                         | 1 -
 t/t4067-diff-partial-clone.sh                      | 1 -
 t/t4068-diff-symmetric-merge-base.sh               | 1 -
 t/t4069-remerge-diff.sh                            | 1 -
 t/t4100-apply-stat.sh                              | 1 -
 t/t4101-apply-nonl.sh                              | 1 -
 t/t4102-apply-rename.sh                            | 1 -
 t/t4103-apply-binary.sh                            | 1 -
 t/t4104-apply-boundary.sh                          | 1 -
 t/t4105-apply-fuzz.sh                              | 1 -
 t/t4106-apply-stdin.sh                             | 1 -
 t/t4107-apply-ignore-whitespace.sh                 | 1 -
 t/t4108-apply-threeway.sh                          | 1 -
 t/t4109-apply-multifrag.sh                         | 1 -
 t/t4110-apply-scan.sh                              | 1 -
 t/t4111-apply-subdir.sh                            | 1 -
 t/t4112-apply-renames.sh                           | 1 -
 t/t4113-apply-ending.sh                            | 1 -
 t/t4114-apply-typechange.sh                        | 1 -
 t/t4115-apply-symlink.sh                           | 1 -
 t/t4116-apply-reverse.sh                           | 1 -
 t/t4117-apply-reject.sh                            | 1 -
 t/t4118-apply-empty-context.sh                     | 1 -
 t/t4119-apply-config.sh                            | 1 -
 t/t4120-apply-popt.sh                              | 1 -
 t/t4121-apply-diffs.sh                             | 1 -
 t/t4122-apply-symlink-inside.sh                    | 1 -
 t/t4123-apply-shrink.sh                            | 1 -
 t/t4124-apply-ws-rule.sh                           | 1 -
 t/t4125-apply-ws-fuzz.sh                           | 1 -
 t/t4126-apply-empty.sh                             | 1 -
 t/t4127-apply-same-fn.sh                           | 1 -
 t/t4128-apply-root.sh                              | 1 -
 t/t4129-apply-samemode.sh                          | 1 -
 t/t4130-apply-criss-cross-rename.sh                | 1 -
 t/t4131-apply-fake-ancestor.sh                     | 1 -
 t/t4132-apply-removal.sh                           | 1 -
 t/t4133-apply-filenames.sh                         | 1 -
 t/t4134-apply-submodule.sh                         | 1 -
 t/t4135-apply-weird-filenames.sh                   | 1 -
 t/t4136-apply-check.sh                             | 1 -
 t/t4137-apply-submodule.sh                         | 1 -
 t/t4138-apply-ws-expansion.sh                      | 1 -
 t/t4139-apply-escape.sh                            | 1 -
 t/t4140-apply-ita.sh                               | 1 -
 t/t4141-apply-too-large.sh                         | 1 -
 t/t4150-am.sh                                      | 1 -
 t/t4151-am-abort.sh                                | 1 -
 t/t4152-am-subjects.sh                             | 1 -
 t/t4153-am-resume-override-opts.sh                 | 1 -
 t/t4200-rerere.sh                                  | 1 -
 t/t4201-shortlog.sh                                | 1 -
 t/t4202-log.sh                                     | 1 -
 t/t4203-mailmap.sh                                 | 1 -
 t/t4204-patch-id.sh                                | 1 -
 t/t4205-log-pretty-formats.sh                      | 1 -
 t/t4206-log-follow-harder-copies.sh                | 1 -
 t/t4207-log-decoration-colors.sh                   | 1 -
 t/t4208-log-magic-pathspec.sh                      | 1 -
 t/t4209-log-pickaxe.sh                             | 1 -
 t/t4210-log-i18n.sh                                | 1 -
 t/t4211-line-log.sh                                | 1 -
 t/t4212-log-corrupt.sh                             | 1 -
 t/t4213-log-tabexpand.sh                           | 1 -
 t/t4214-log-graph-octopus.sh                       | 1 -
 t/t4215-log-skewed-merges.sh                       | 1 -
 t/t4216-log-bloom.sh                               | 1 -
 t/t4217-log-limit.sh                               | 1 -
 t/t4252-am-options.sh                              | 1 -
 t/t4253-am-keep-cr-dos.sh                          | 1 -
 t/t4254-am-corrupt.sh                              | 1 -
 t/t4255-am-submodule.sh                            | 1 -
 t/t4256-am-format-flowed.sh                        | 1 -
 t/t4257-am-interactive.sh                          | 1 -
 t/t4258-am-quoted-cr.sh                            | 1 -
 t/t4300-merge-tree.sh                              | 1 -
 t/t4301-merge-tree-write-tree.sh                   | 1 -
 t/t5000-tar-tree.sh                                | 1 -
 t/t5001-archive-attr.sh                            | 1 -
 t/t5002-archive-attr-pattern.sh                    | 1 -
 t/t5003-archive-zip.sh                             | 1 -
 t/t5004-archive-corner-cases.sh                    | 1 -
 t/t5100-mailinfo.sh                                | 1 -
 t/t5150-request-pull.sh                            | 1 -
 t/t5200-update-server-info.sh                      | 1 -
 t/t5300-pack-object.sh                             | 1 -
 t/t5301-sliding-window.sh                          | 1 -
 t/t5302-pack-index.sh                              | 1 -
 t/t5303-pack-corruption-resilience.sh              | 1 -
 t/t5304-prune.sh                                   | 1 -
 t/t5305-include-tag.sh                             | 1 -
 t/t5306-pack-nobase.sh                             | 1 -
 t/t5307-pack-missing-commit.sh                     | 1 -
 t/t5308-pack-detect-duplicates.sh                  | 1 -
 t/t5309-pack-delta-cycles.sh                       | 1 -
 t/t5310-pack-bitmaps.sh                            | 1 -
 t/t5311-pack-bitmaps-shallow.sh                    | 1 -
 t/t5312-prune-corruption.sh                        | 1 -
 t/t5313-pack-bounds-checks.sh                      | 1 -
 t/t5314-pack-cycle-detection.sh                    | 1 -
 t/t5315-pack-objects-compression.sh                | 1 -
 t/t5316-pack-delta-depth.sh                        | 1 -
 t/t5317-pack-objects-filter-objects.sh             | 1 -
 t/t5318-commit-graph.sh                            | 1 -
 t/t5319-multi-pack-index.sh                        | 1 -
 t/t5320-delta-islands.sh                           | 1 -
 t/t5321-pack-large-objects.sh                      | 1 -
 t/t5322-pack-objects-sparse.sh                     | 1 -
 t/t5323-pack-redundant.sh                          | 1 -
 t/t5324-split-commit-graph.sh                      | 1 -
 t/t5325-reverse-index.sh                           | 1 -
 t/t5326-multi-pack-bitmaps.sh                      | 1 -
 t/t5327-multi-pack-bitmaps-rev.sh                  | 1 -
 t/t5328-commit-graph-64bit-time.sh                 | 1 -
 t/t5329-pack-objects-cruft.sh                      | 1 -
 t/t5330-no-lazy-fetch-with-commit-graph.sh         | 1 -
 t/t5331-pack-objects-stdin.sh                      | 1 -
 t/t5332-multi-pack-reuse.sh                        | 1 -
 t/t5333-pseudo-merge-bitmaps.sh                    | 1 -
 t/t5334-incremental-multi-pack-index.sh            | 1 -
 t/t5351-unpack-large-objects.sh                    | 1 -
 t/t5400-send-pack.sh                               | 1 -
 t/t5401-update-hooks.sh                            | 1 -
 t/t5402-post-merge-hook.sh                         | 1 -
 t/t5403-post-checkout-hook.sh                      | 1 -
 t/t5404-tracking-branches.sh                       | 1 -
 t/t5405-send-pack-rewind.sh                        | 1 -
 t/t5406-remote-rejects.sh                          | 1 -
 t/t5407-post-rewrite-hook.sh                       | 1 -
 t/t5408-send-pack-stdin.sh                         | 1 -
 t/t5409-colorize-remote-messages.sh                | 1 -
 t/t5410-receive-pack-alternates.sh                 | 1 -
 t/t5411-proc-receive-hook.sh                       | 1 -
 t/t5500-fetch-pack.sh                              | 1 -
 t/t5501-fetch-push-alternates.sh                   | 1 -
 t/t5502-quickfetch.sh                              | 1 -
 t/t5503-tagfollow.sh                               | 1 -
 t/t5504-fetch-receive-strict.sh                    | 1 -
 t/t5505-remote.sh                                  | 1 -
 t/t5506-remote-groups.sh                           | 1 -
 t/t5507-remote-environment.sh                      | 1 -
 t/t5509-fetch-push-namespaces.sh                   | 1 -
 t/t5510-fetch.sh                                   | 1 -
 t/t5511-refspec.sh                                 | 1 -
 t/t5512-ls-remote.sh                               | 1 -
 t/t5513-fetch-track.sh                             | 1 -
 t/t5514-fetch-multiple.sh                          | 1 -
 t/t5515-fetch-merge-logic.sh                       | 1 -
 t/t5516-fetch-push.sh                              | 1 -
 t/t5517-push-mirror.sh                             | 1 -
 t/t5518-fetch-exit-status.sh                       | 1 -
 t/t5519-push-alternates.sh                         | 1 -
 t/t5520-pull.sh                                    | 1 -
 t/t5521-pull-options.sh                            | 1 -
 t/t5522-pull-symlink.sh                            | 1 -
 t/t5523-push-upstream.sh                           | 1 -
 t/t5524-pull-msg.sh                                | 1 -
 t/t5525-fetch-tagopt.sh                            | 1 -
 t/t5526-fetch-submodules.sh                        | 1 -
 t/t5527-fetch-odd-refs.sh                          | 1 -
 t/t5528-push-default.sh                            | 1 -
 t/t5529-push-errors.sh                             | 1 -
 t/t5530-upload-pack-error.sh                       | 1 -
 t/t5531-deep-submodule-push.sh                     | 1 -
 t/t5532-fetch-proxy.sh                             | 1 -
 t/t5533-push-cas.sh                                | 1 -
 t/t5534-push-signed.sh                             | 1 -
 t/t5535-fetch-push-symref.sh                       | 1 -
 t/t5536-fetch-conflicts.sh                         | 1 -
 t/t5537-fetch-shallow.sh                           | 1 -
 t/t5538-push-shallow.sh                            | 1 -
 t/t5539-fetch-http-shallow.sh                      | 1 -
 t/t5540-http-push-webdav.sh                        | 1 -
 t/t5541-http-push-smart.sh                         | 1 -
 t/t5542-push-http-shallow.sh                       | 1 -
 t/t5543-atomic-push.sh                             | 1 -
 t/t5544-pack-objects-hook.sh                       | 1 -
 t/t5545-push-options.sh                            | 1 -
 t/t5546-receive-limits.sh                          | 1 -
 t/t5547-push-quarantine.sh                         | 1 -
 t/t5548-push-porcelain.sh                          | 1 -
 t/t5549-fetch-push-http.sh                         | 1 -
 t/t5550-http-fetch-dumb.sh                         | 1 -
 t/t5551-http-fetch-smart.sh                        | 1 -
 t/t5552-skipping-fetch-negotiator.sh               | 1 -
 t/t5553-set-upstream.sh                            | 1 -
 t/t5554-noop-fetch-negotiator.sh                   | 1 -
 t/t5555-http-smart-common.sh                       | 1 -
 t/t5557-http-get.sh                                | 1 -
 t/t5558-clone-bundle-uri.sh                        | 1 -
 t/t5560-http-backend-noserver.sh                   | 1 -
 t/t5561-http-backend.sh                            | 1 -
 t/t5562-http-backend-content-length.sh             | 1 -
 t/t5563-simple-http-auth.sh                        | 1 -
 t/t5564-http-proxy.sh                              | 1 -
 t/t5570-git-daemon.sh                              | 1 -
 t/t5571-pre-push-hook.sh                           | 1 -
 t/t5572-pull-submodule.sh                          | 1 -
 t/t5573-pull-verify-signatures.sh                  | 1 -
 t/t5574-fetch-output.sh                            | 1 -
 t/t5580-unc-paths.sh                               | 1 -
 t/t5581-http-curl-verbose.sh                       | 1 -
 t/t5582-fetch-negative-refspec.sh                  | 1 -
 t/t5583-push-branches.sh                           | 1 -
 t/t5600-clone-fail-cleanup.sh                      | 1 -
 t/t5601-clone.sh                                   | 1 -
 t/t5602-clone-remote-exec.sh                       | 1 -
 t/t5603-clone-dirname.sh                           | 1 -
 t/t5604-clone-reference.sh                         | 1 -
 t/t5605-clone-local.sh                             | 1 -
 t/t5606-clone-options.sh                           | 1 -
 t/t5607-clone-bundle.sh                            | 1 -
 t/t5609-clone-branch.sh                            | 1 -
 t/t5610-clone-detached.sh                          | 1 -
 t/t5611-clone-config.sh                            | 1 -
 t/t5612-clone-refspec.sh                           | 1 -
 t/t5613-info-alternate.sh                          | 1 -
 t/t5614-clone-submodules-shallow.sh                | 1 -
 t/t5615-alternate-env.sh                           | 1 -
 t/t5616-partial-clone.sh                           | 1 -
 t/t5617-clone-submodules-remote.sh                 | 1 -
 t/t5618-alternate-refs.sh                          | 1 -
 t/t5619-clone-local-ambiguous-transport.sh         | 1 -
 t/t5700-protocol-v1.sh                             | 1 -
 t/t5701-git-serve.sh                               | 1 -
 t/t5702-protocol-v2.sh                             | 1 -
 t/t5703-upload-pack-ref-in-want.sh                 | 1 -
 t/t5704-protocol-violations.sh                     | 1 -
 t/t5705-session-id-in-capabilities.sh              | 1 -
 t/t5730-protocol-v2-bundle-uri-file.sh             | 1 -
 t/t5731-protocol-v2-bundle-uri-git.sh              | 1 -
 t/t5732-protocol-v2-bundle-uri-http.sh             | 1 -
 t/t5750-bundle-uri-parse.sh                        | 1 -
 t/t5801-remote-helpers.sh                          | 1 -
 t/t5802-connect-helper.sh                          | 1 -
 t/t5810-proto-disable-local.sh                     | 1 -
 t/t5811-proto-disable-git.sh                       | 1 -
 t/t5812-proto-disable-http.sh                      | 1 -
 t/t5813-proto-disable-ssh.sh                       | 1 -
 t/t5814-proto-disable-ext.sh                       | 1 -
 t/t5815-submodule-protos.sh                        | 1 -
 t/t5900-repo-selection.sh                          | 1 -
 t/t6000-rev-list-misc.sh                           | 1 -
 t/t6001-rev-list-graft.sh                          | 1 -
 t/t6002-rev-list-bisect.sh                         | 1 -
 t/t6003-rev-list-topo-order.sh                     | 1 -
 t/t6004-rev-list-path-optim.sh                     | 1 -
 t/t6005-rev-list-count.sh                          | 1 -
 t/t6006-rev-list-format.sh                         | 1 -
 t/t6007-rev-list-cherry-pick-file.sh               | 1 -
 t/t6008-rev-list-submodule.sh                      | 1 -
 t/t6009-rev-list-parent.sh                         | 1 -
 t/t6010-merge-base.sh                              | 1 -
 t/t6011-rev-list-with-bad-commit.sh                | 1 -
 t/t6012-rev-list-simplify.sh                       | 1 -
 t/t6013-rev-list-reverse-parents.sh                | 1 -
 t/t6014-rev-list-all.sh                            | 1 -
 t/t6016-rev-list-graph-simplify-history.sh         | 1 -
 t/t6017-rev-list-stdin.sh                          | 1 -
 t/t6018-rev-list-glob.sh                           | 1 -
 t/t6019-rev-list-ancestry-path.sh                  | 1 -
 t/t6020-bundle-misc.sh                             | 1 -
 t/t6021-rev-list-exclude-hidden.sh                 | 1 -
 t/t6022-rev-list-missing.sh                        | 1 -
 t/t6030-bisect-porcelain.sh                        | 1 -
 t/t6040-tracking-info.sh                           | 1 -
 t/t6041-bisect-submodule.sh                        | 1 -
 t/t6050-replace.sh                                 | 1 -
 t/t6060-merge-index.sh                             | 1 -
 t/t6100-rev-list-in-order.sh                       | 1 -
 t/t6101-rev-parse-parents.sh                       | 1 -
 t/t6102-rev-list-unexpected-objects.sh             | 1 -
 t/t6110-rev-list-sparse.sh                         | 1 -
 t/t6111-rev-list-treesame.sh                       | 1 -
 t/t6112-rev-list-filters-objects.sh                | 1 -
 t/t6113-rev-list-bitmap-filters.sh                 | 1 -
 t/t6114-keep-packs.sh                              | 1 -
 t/t6115-rev-list-du.sh                             | 1 -
 t/t6120-describe.sh                                | 1 -
 t/t6130-pathspec-noglob.sh                         | 1 -
 t/t6131-pathspec-icase.sh                          | 1 -
 t/t6132-pathspec-exclude.sh                        | 1 -
 t/t6133-pathspec-rev-dwim.sh                       | 1 -
 t/t6134-pathspec-in-submodule.sh                   | 1 -
 t/t6135-pathspec-with-attrs.sh                     | 1 -
 t/t6136-pathspec-in-bare.sh                        | 1 -
 t/t6200-fmt-merge-msg.sh                           | 1 -
 t/t6300-for-each-ref.sh                            | 1 -
 t/t6301-for-each-ref-errors.sh                     | 1 -
 t/t6302-for-each-ref-filter.sh                     | 1 -
 t/t6400-merge-df.sh                                | 1 -
 t/t6401-merge-criss-cross.sh                       | 1 -
 t/t6402-merge-rename.sh                            | 1 -
 t/t6403-merge-file.sh                              | 1 -
 t/t6404-recursive-merge.sh                         | 1 -
 t/t6405-merge-symlinks.sh                          | 1 -
 t/t6406-merge-attr.sh                              | 1 -
 t/t6407-merge-binary.sh                            | 1 -
 t/t6408-merge-up-to-date.sh                        | 1 -
 t/t6409-merge-subtree.sh                           | 1 -
 t/t6411-merge-filemode.sh                          | 1 -
 t/t6412-merge-large-rename.sh                      | 1 -
 t/t6413-merge-crlf.sh                              | 1 -
 t/t6414-merge-rename-nocruft.sh                    | 1 -
 t/t6415-merge-dir-to-symlink.sh                    | 1 -
 t/t6416-recursive-corner-cases.sh                  | 1 -
 t/t6417-merge-ours-theirs.sh                       | 1 -
 t/t6418-merge-text-auto.sh                         | 1 -
 t/t6421-merge-partial-clone.sh                     | 1 -
 t/t6422-merge-rename-corner-cases.sh               | 1 -
 t/t6423-merge-rename-directories.sh                | 1 -
 t/t6424-merge-unrelated-index-changes.sh           | 1 -
 t/t6425-merge-rename-delete.sh                     | 1 -
 t/t6426-merge-skip-unneeded-updates.sh             | 1 -
 t/t6427-diff3-conflict-markers.sh                  | 1 -
 t/t6428-merge-conflicts-sparse.sh                  | 1 -
 t/t6429-merge-sequence-rename-caching.sh           | 1 -
 t/t6430-merge-recursive.sh                         | 1 -
 t/t6431-merge-criscross.sh                         | 1 -
 t/t6432-merge-recursive-space-options.sh           | 1 -
 t/t6433-merge-toplevel.sh                          | 1 -
 t/t6434-merge-recursive-rename-options.sh          | 1 -
 t/t6435-merge-sparse.sh                            | 1 -
 t/t6436-merge-overwrite.sh                         | 1 -
 t/t6437-submodule-merge.sh                         | 1 -
 t/t6438-submodule-directory-file-conflicts.sh      | 1 -
 t/t6439-merge-co-error-msgs.sh                     | 1 -
 t/t6500-gc.sh                                      | 1 -
 t/t6501-freshen-objects.sh                         | 1 -
 t/t6600-test-reach.sh                              | 1 -
 t/t6700-tree-depth.sh                              | 1 -
 t/t7001-mv.sh                                      | 1 -
 t/t7002-mv-sparse-checkout.sh                      | 1 -
 t/t7003-filter-branch.sh                           | 1 -
 t/t7004-tag.sh                                     | 1 -
 t/t7005-editor.sh                                  | 1 -
 t/t7006-pager.sh                                   | 1 -
 t/t7007-show.sh                                    | 1 -
 t/t7008-filter-branch-null-sha1.sh                 | 1 -
 t/t7010-setup.sh                                   | 1 -
 t/t7011-skip-worktree-reading.sh                   | 1 -
 t/t7012-skip-worktree-writing.sh                   | 1 -
 t/t7030-verify-tag.sh                              | 1 -
 t/t7031-verify-tag-signed-ssh.sh                   | 1 -
 t/t7060-wtstatus.sh                                | 1 -
 t/t7061-wtstatus-ignore.sh                         | 1 -
 t/t7062-wtstatus-ignorecase.sh                     | 1 -
 t/t7063-status-untracked-cache.sh                  | 1 -
 t/t7064-wtstatus-pv2.sh                            | 1 -
 t/t7101-reset-empty-subdirs.sh                     | 1 -
 t/t7102-reset.sh                                   | 1 -
 t/t7103-reset-bare.sh                              | 1 -
 t/t7104-reset-hard.sh                              | 1 -
 t/t7105-reset-patch.sh                             | 1 -
 t/t7106-reset-unborn-branch.sh                     | 1 -
 t/t7107-reset-pathspec-file.sh                     | 1 -
 t/t7110-reset-merge.sh                             | 1 -
 t/t7111-reset-table.sh                             | 1 -
 t/t7112-reset-submodule.sh                         | 1 -
 t/t7113-post-index-change-hook.sh                  | 1 -
 t/t7201-co.sh                                      | 1 -
 t/t7300-clean.sh                                   | 1 -
 t/t7301-clean-interactive.sh                       | 1 -
 t/t7400-submodule-basic.sh                         | 1 -
 t/t7401-submodule-summary.sh                       | 1 -
 t/t7402-submodule-rebase.sh                        | 1 -
 t/t7403-submodule-sync.sh                          | 1 -
 t/t7406-submodule-update.sh                        | 1 -
 t/t7407-submodule-foreach.sh                       | 1 -
 t/t7408-submodule-reference.sh                     | 1 -
 t/t7409-submodule-detached-work-tree.sh            | 1 -
 t/t7411-submodule-config.sh                        | 1 -
 t/t7412-submodule-absorbgitdirs.sh                 | 1 -
 t/t7413-submodule-is-active.sh                     | 1 -
 t/t7414-submodule-mistakes.sh                      | 1 -
 t/t7416-submodule-dash-url.sh                      | 1 -
 t/t7417-submodule-path-url.sh                      | 1 -
 t/t7418-submodule-sparse-gitmodules.sh             | 1 -
 t/t7419-submodule-set-branch.sh                    | 1 -
 t/t7420-submodule-set-url.sh                       | 1 -
 t/t7421-submodule-summary-add.sh                   | 1 -
 t/t7422-submodule-output.sh                        | 1 -
 t/t7423-submodule-symlinks.sh                      | 1 -
 t/t7424-submodule-mixed-ref-formats.sh             | 1 -
 t/t7450-bad-git-dotfiles.sh                        | 1 -
 t/t7500-commit-template-squash-signoff.sh          | 1 -
 t/t7501-commit-basic-functionality.sh              | 1 -
 t/t7502-commit-porcelain.sh                        | 1 -
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh   | 1 -
 t/t7504-commit-msg-hook.sh                         | 1 -
 t/t7505-prepare-commit-msg-hook.sh                 | 1 -
 t/t7506-status-submodule.sh                        | 1 -
 t/t7507-commit-verbose.sh                          | 1 -
 t/t7508-status.sh                                  | 1 -
 t/t7509-commit-authorship.sh                       | 1 -
 t/t7510-signed-commit.sh                           | 1 -
 t/t7511-status-index.sh                            | 1 -
 t/t7512-status-help.sh                             | 1 -
 t/t7513-interpret-trailers.sh                      | 1 -
 t/t7514-commit-patch.sh                            | 1 -
 t/t7515-status-symlinks.sh                         | 1 -
 t/t7516-commit-races.sh                            | 1 -
 t/t7517-per-repo-email.sh                          | 1 -
 t/t7518-ident-corner-cases.sh                      | 1 -
 t/t7519-status-fsmonitor.sh                        | 1 -
 t/t7520-ignored-hook-warning.sh                    | 1 -
 t/t7521-ignored-mode.sh                            | 1 -
 t/t7524-commit-summary.sh                          | 1 -
 t/t7525-status-rename.sh                           | 1 -
 t/t7526-commit-pathspec-file.sh                    | 1 -
 t/t7528-signed-commit-ssh.sh                       | 1 -
 t/t7600-merge.sh                                   | 1 -
 t/t7601-merge-pull-config.sh                       | 1 -
 t/t7602-merge-octopus-many.sh                      | 1 -
 t/t7603-merge-reduce-heads.sh                      | 1 -
 t/t7604-merge-custom-message.sh                    | 1 -
 t/t7605-merge-resolve.sh                           | 1 -
 t/t7606-merge-custom.sh                            | 1 -
 t/t7607-merge-state.sh                             | 1 -
 t/t7608-merge-messages.sh                          | 1 -
 t/t7609-mergetool--lib.sh                          | 1 -
 t/t7610-mergetool.sh                               | 1 -
 t/t7611-merge-abort.sh                             | 1 -
 t/t7612-merge-verify-signatures.sh                 | 1 -
 t/t7614-merge-signoff.sh                           | 1 -
 t/t7615-diff-algo-with-mergy-operations.sh         | 1 -
 t/t7700-repack.sh                                  | 1 -
 t/t7701-repack-unpack-unreachable.sh               | 1 -
 t/t7702-repack-cyclic-alternate.sh                 | 1 -
 t/t7703-repack-geometric.sh                        | 1 -
 t/t7704-repack-cruft.sh                            | 1 -
 t/t7800-difftool.sh                                | 1 -
 t/t7810-grep.sh                                    | 1 -
 t/t7811-grep-open.sh                               | 1 -
 t/t7812-grep-icase-non-ascii.sh                    | 1 -
 t/t7813-grep-icase-iso.sh                          | 1 -
 t/t7814-grep-recurse-submodules.sh                 | 1 -
 t/t7815-grep-binary.sh                             | 1 -
 t/t7816-grep-binary-pattern.sh                     | 1 -
 t/t7817-grep-sparse-checkout.sh                    | 1 -
 t/t7900-maintenance.sh                             | 1 -
 t/t8001-annotate.sh                                | 1 -
 t/t8002-blame.sh                                   | 1 -
 t/t8003-blame-corner-cases.sh                      | 1 -
 t/t8004-blame-with-conflicts.sh                    | 1 -
 t/t8005-blame-i18n.sh                              | 1 -
 t/t8006-blame-textconv.sh                          | 1 -
 t/t8007-cat-file-textconv.sh                       | 1 -
 t/t8008-blame-formats.sh                           | 1 -
 t/t8009-blame-vs-topicbranches.sh                  | 1 -
 t/t8010-cat-file-filters.sh                        | 1 -
 t/t8011-blame-split-file.sh                        | 1 -
 t/t8012-blame-colors.sh                            | 1 -
 t/t8013-blame-ignore-revs.sh                       | 1 -
 t/t8014-blame-ignore-fuzzy.sh                      | 1 -
 t/t9001-send-email.sh                              | 1 -
 t/t9002-column.sh                                  | 1 -
 t/t9003-help-autocorrect.sh                        | 1 -
 t/t9200-git-cvsexportcommit.sh                     | 1 -
 t/t9210-scalar.sh                                  | 1 -
 t/t9211-scalar-clone.sh                            | 1 -
 t/t9300-fast-import.sh                             | 1 -
 t/t9301-fast-import-notes.sh                       | 1 -
 t/t9302-fast-import-unpack-limit.sh                | 1 -
 t/t9303-fast-import-compression.sh                 | 1 -
 t/t9304-fast-import-marks.sh                       | 1 -
 t/t9350-fast-export.sh                             | 1 -
 t/t9351-fast-export-anonymize.sh                   | 1 -
 t/t9400-git-cvsserver-server.sh                    | 1 -
 t/t9401-git-cvsserver-crlf.sh                      | 1 -
 t/t9402-git-cvsserver-refs.sh                      | 1 -
 t/t9500-gitweb-standalone-no-errors.sh             | 1 -
 t/t9501-gitweb-standalone-http-status.sh           | 1 -
 t/t9502-gitweb-standalone-parse-output.sh          | 1 -
 t/t9600-cvsimport.sh                               | 1 -
 t/t9601-cvsimport-vendor-branch.sh                 | 1 -
 t/t9602-cvsimport-branches-tags.sh                 | 1 -
 t/t9603-cvsimport-patchsets.sh                     | 1 -
 t/t9604-cvsimport-timestamps.sh                    | 1 -
 t/t9700-perl-git.sh                                | 1 -
 t/t9800-git-p4-basic.sh                            | 1 -
 t/t9801-git-p4-branch.sh                           | 1 -
 t/t9802-git-p4-filetype.sh                         | 1 -
 t/t9803-git-p4-shell-metachars.sh                  | 1 -
 t/t9804-git-p4-label.sh                            | 1 -
 t/t9805-git-p4-skip-submit-edit.sh                 | 1 -
 t/t9806-git-p4-options.sh                          | 1 -
 t/t9808-git-p4-chdir.sh                            | 1 -
 t/t9809-git-p4-client-view.sh                      | 1 -
 t/t9810-git-p4-rcs.sh                              | 1 -
 t/t9811-git-p4-label-import.sh                     | 1 -
 t/t9812-git-p4-wildcards.sh                        | 1 -
 t/t9813-git-p4-preserve-users.sh                   | 1 -
 t/t9814-git-p4-rename.sh                           | 1 -
 t/t9815-git-p4-submit-fail.sh                      | 1 -
 t/t9816-git-p4-locked.sh                           | 1 -
 t/t9817-git-p4-exclude.sh                          | 1 -
 t/t9818-git-p4-block.sh                            | 1 -
 t/t9819-git-p4-case-folding.sh                     | 1 -
 t/t9820-git-p4-editor-handling.sh                  | 1 -
 t/t9821-git-p4-path-variations.sh                  | 1 -
 t/t9822-git-p4-path-encoding.sh                    | 1 -
 t/t9823-git-p4-mock-lfs.sh                         | 1 -
 t/t9825-git-p4-handle-utf16-without-bom.sh         | 1 -
 t/t9826-git-p4-keep-empty-commits.sh               | 1 -
 t/t9827-git-p4-change-filetype.sh                  | 1 -
 t/t9828-git-p4-map-user.sh                         | 1 -
 t/t9829-git-p4-jobs.sh                             | 1 -
 t/t9830-git-p4-symlink-dir.sh                      | 1 -
 t/t9831-git-p4-triggers.sh                         | 1 -
 t/t9832-unshelve.sh                                | 1 -
 t/t9833-errors.sh                                  | 1 -
 t/t9834-git-p4-file-dir-bug.sh                     | 1 -
 t/t9835-git-p4-metadata-encoding-python2.sh        | 1 -
 t/t9836-git-p4-metadata-encoding-python3.sh        | 1 -
 t/t9850-shell.sh                                   | 1 -
 t/t9901-git-web--browse.sh                         | 1 -
 t/t9902-completion.sh                              | 1 -
 t/t9903-bash-prompt.sh                             | 1 -
 928 files changed, 928 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..4890dff4b27311f0b187c72da61d9f1542257b16 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,7 +2,6 @@
 
 test_description='git init'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index bf3bf604abe3470f19cc5a10e5c88c905cb28329..dfbcdddbcc1f0fd5cf632524b3dfa5a8337a7f02 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -7,7 +7,6 @@ Verify that plumbing commands work when .git is a file
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objpath() {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 66ccb5889d1e026e22862f7f09bb9b29f0722f6b..3c98b622f25b760138ed8a938c104ea017d0f408 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -2,7 +2,6 @@
 
 test_description=gitattributes
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 8114fac73b320b85949d8d7ce1422c35e1eb8158..3bdafbae0f003863b09d01c6ded07c8c1be14e03 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -2,7 +2,6 @@
 
 test_description='detect unwritable repository and fail correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index eba75a2490ce7e0918e6a981d42ec8f5d9fd9b2d..afba0fc3fc673e5d7d4d55b2031607905853f737 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -2,7 +2,6 @@
 
 test_description='signals work as we expect'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<EOF
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index fd373e1b39185488bf7e5861b3457b151711be5c..53ced36df448f1b572eb39fd76b8de291c529d69 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -2,7 +2,6 @@
 
 test_description='test date parsing and printing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # arbitrary reference time: 2009-08-30 19:20:00
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 9fc5882387390aa8b30477c2037d28cefeea64fc..2b60317758c415acc9b054d7668a88fc085be97b 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -2,7 +2,6 @@
 
 test_description='basic sanity checks for git var'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset_all_editors () {
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 02a18d4fdbd244dcc99290a28695ce7a89107d3a..c9376dffb58872787abc22a8654327d95ba256fb 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -2,7 +2,6 @@
 
 test_description=check-ignore
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 84172a3739094adc6cdf6496b016fe68e0b2a771..45229f57b821d73c4a1690e727eb9280d4ae631b 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -2,7 +2,6 @@
 
 test_description='racy GIT'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test can give false success if your machine is sufficiently
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 9eae0d835637885dfc2c236544b4d828020e502e..1d273d91c2125ae2c16ae1a14c628cf23fcecc06 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -2,7 +2,6 @@
 
 test_description='help'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 configure_help () {
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 08814173cb111c941c59e2fa764ac271fcbe9dab..ce3d81227a0f0c9fece708f883d14cd6c1e2c3d3 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -2,7 +2,6 @@
 
 test_description='test sha1 collision detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2a6f39ad9c81958d5152139995feab57c4371363..854d59ec58c25ab2cfb58113bf5ea8d670829fe0 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -2,7 +2,6 @@
 
 test_description='git command aliasing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'nested aliases - internal execution' '
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index f3a16859cc20f1a3b80334d36113e757645c6c9b..32fe8481792325f05e6fdf9a83dee43871dce9ad 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -2,7 +2,6 @@
 
 test_description='test test-tool env-helper'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index fac52322a7f6739ce95feea6b527edce00941361..9a3db02fdedd076870d5fdb63953bdb235951b6e 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -5,7 +5,6 @@ test_description='Test advise_if_enabled functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'advice should be printed when config variable is unset' '
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index 19a730c29ed8f791d7885c31ff2a908cb1b5dfb3..3a4e1cc7e388ab0d0c24bca0ccaa7f07cf0a901e 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -2,7 +2,6 @@
 
 test_description='test json-writer JSON generation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'unit test of json-writer routines' '
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 81946e87ccb9b478789164a6db54d9a80278288d..fd1cae09edcc2609c69df8b1e934eb428793face 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,7 +5,6 @@ test_description='CRLF conversion'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9e6c6ee0d44c0353dbf7dc10fe9c24a4421693a3..3f6433d3045826f776fe932c30a4aa5bef358d48 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,7 +5,6 @@ test_description='blob conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9fe98912511d3b6cb050aa51e33906caf7fb51c5..9bd863a970d2b16ff5d9d44b3a23d6c39f310217 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='ignore CR in CRLF sequence while computing similiarity'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index 575805513a3d7f6d27fee7ceefcb75e71753f1f9..f9bbb91f64e35d284a4ac79a6b2ecaa1d2913455 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -2,7 +2,6 @@
 
 test_description='Test am with auto.crlf'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >patchfile <<\EOF
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index a7f4de4a43ffa022ae56ebf14999cbe81900a4a9..44958cb2c2d946656bae5289ee418bf3a295cec5 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -2,7 +2,6 @@
 
 test_description='respect crlf in git archive'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index f7202c192e7b63e07c904fe9dcf1b76252d8808d..2e28feb69c9fea23b4a8481925280eb333f1e91f 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF renormalization'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index f426a185bb9b32e732c0404d65237f8278435f0e..493b01a0e7c6a01d2c3016f41bc218d1a3c56e96 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF conversion'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2f57c8669cb5af3dd6fc79bfca4b486f50fa4d19..49dbf09da7738646e2614eba1fb0a6169482eae4 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF conversion all combinations'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 compare_files () {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 510da4ca12dfbabe6e093baa14c9a1873cacbde3..50b3b4649b614fe39a9e7e0202bd55593d666690 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -5,7 +5,6 @@ test_description='working-tree-encoding conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-encoding.sh"
diff --git a/t/t0029-core-unsetenvvars.sh b/t/t0029-core-unsetenvvars.sh
index 4e8e90dd9824b33bd4420423a447decea46e848e..baa1b7e85b10b4a4973f570f5dccf87711bc682d 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -2,7 +2,6 @@
 
 test_description='test the Windows-only core.unsetenvvars setting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq MINGW
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index f10f42ff1e4a8716609a1e8dd86e1441e020db3d..43155f6bd86bf4c290d066b80b39af2523bfb581 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -5,7 +5,6 @@
 
 test_description='git stripspace'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t40='A quick brown fox jumps over the lazy do'
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index e97a84764f786769614fd096aa0ef67a12e14a90..e103fe710927ceaa9e04a75dd70f141a86c0a6dc 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -2,7 +2,6 @@
 
 test_description='verify safe.directory checks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_ASSUME_DIFFERENT_OWNER=1
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index d3cb2a1cb9edb8f9ad7480be6ec3e02b464046bd..ae7ef092abf6d9abec6aa99cb5bb362cafd091b2 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -2,7 +2,6 @@
 
 test_description='verify safe.bareRepository checks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd="$(pwd)"
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 45a773642fd167e9190b9b693a08001bb5939883..2fe3522305f64d0f8366d160d4c03de81c4a210a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -5,7 +5,6 @@
 
 test_description='our own option parser'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<\EOF
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 1464294bd1bfc36d48f06a3ead7826daeb9a745c..a0f6f134c718220e41d9eab8f70158b1c5fb1643 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -5,7 +5,6 @@ test_description='Test commands behavior when given invalid argument value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd0add75bcaf3b629c2692420c279f8a..5c9dc90d0b096d9f104caedeb035b50b919b6811 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -5,7 +5,6 @@ test_description='Various filesystem issues'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 auml=$(printf '\303\244')
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index 1a36a535743c14c29b993d77ed9bf6482c0b16a7..ff98be31a51b360ef917aba97dbda0e53719b58a 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -2,7 +2,6 @@
 
 test_description='simple command server'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index c3eb1158ef9ae2eb10f3f7a6d5c882e41f3c576a..d0740038b8778e6ccb6e10c435cd23a6180ab6db 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index and add refuse to add beyond symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 752aa8c945431b909e580f557ef738a455fa8132..2630e756dab7322a5360a67766a648a80a5a7222 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -2,7 +2,6 @@
 
 test_description='"-C <path>" option and its effects on other path-related options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '"git -C <path>" runs git from the directory <path>' '
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0afa3d0d312ca6d1788b76d3b0dfcba04f8397e7..dbb2e73bcd912ae6a804603ff54e4c609966fa5d 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -5,7 +5,6 @@
 
 test_description='Test various path utilities'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 norm_path() {
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 20986b693cfbe8de91552f43daa11be630842f34..76d4936a879afdfcc8961117084174d88da96c26 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -5,7 +5,6 @@
 
 test_description='Test run command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >hello-script <<-EOF
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index b9480c8178193e4eba46dd2d581e1aa4eaa5dae6..8e215867b8c197dedef32c569e1d1f632d22b631 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -5,7 +5,6 @@
 
 test_description='Test revision walking api'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >run_twice_expected <<-EOF
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 1fee6d90102cc6f9b90786a6324f56e7086b91bf..aac63ba5064b786a29f1390554106eab271013ec 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -5,7 +5,6 @@
 
 test_description='Test string list functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_split () {
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 7d0a0da8c01b8b69a9d9ca607c55145d96e59ad1..df3e9f5fa5d4b52deb5ecdb25daedc8ed0dc2ec5 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the dir-iterator functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
index 0188d0423a0aa246d40b0735a31470f1bb97e8a6..7bab49f361a9bfea7cf72042d60e65b25698e5a9 100755
--- a/t/t0067-parse_pathspec_file.sh
+++ b/t/t0067-parse_pathspec_file.sh
@@ -2,7 +2,6 @@
 
 test_description='Test parse_pathspec_file()'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'one item from stdin' '
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 95019e01ed33289aa025ec729d6b120f4c29f3c7..f2f3e50031291620dde9feef2aa0e2db9acf3c0a 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='git for-each-repo builtin'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 0ecec2ba71116959fd2efceac7fc46683d1a3e91..6b9dcf984bcb546a2a2dae276ae56c3c3d81f0c8 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -6,7 +6,6 @@ test_description='check that the most basic functions work
 Verify wrappers and compatibility functions.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index ba8ad1d1ca0adeee8f001450951ec782e1fc3d74..2236a7e9563ab117876e52e6a6ca9b2d365cc525 100755
--- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -2,7 +2,6 @@
 
 test_description='verify sort functions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 3c369c88e2a416fa53c8ea8e8af135a26316251a..3db10f095c2edc63e7064e582884dc2553bd9365 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the output of the unit test framework'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'TAP output from unit tests' - <<\EOT
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 67b11216a3e54185882d176bb59899411ae6666a..5a628bf7356445384ff97f5e55a8d233379bdecb 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -2,7 +2,6 @@
 
 test_description='test `test-tool find-pack`'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index d8e2fc42e15c73dfffebba57071b8d3e4bfd1ed1..ab80c9ef1358f0c29d7cdb877c1dd41e0a98e7aa 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -6,7 +6,6 @@ Tests whether various commands properly update and/or rewrite the
 cache-tree extension.
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
  . ./test-lib.sh
 
 cmp_cache_tree () {
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index fca39048fe8840099c2d7a393e91dfd3a6683029..e11d819b62a15087575d639b28be3c64fcd06386 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -2,7 +2,6 @@
 
 test_description='git bugreport'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a report' '
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index 133e5747d613e5ade6ab8bfe67ab46a31021d64e..6cabd6e67b9a141a4ac7839d296189d7e21d35f3 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -2,7 +2,6 @@
 
 test_description='git diagnose'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success UNZIP 'creates diagnostics zip archive' '
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 08df74cacfc6910c51568705855dffa90b79d5be..8f0c3b7325b8bd917934f31e51fc9325be29736b 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -2,7 +2,6 @@
 
 test_description='Testing the various Bloom filter computations in bloom.c'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'compute unseeded murmur3 hash for empty string' '
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 70a3223f2199b06833166863e58489ba0f632e59..dd5d9b4e5ebdf26839e091f446f93df8e0c95d8e 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -5,7 +5,6 @@ test_description='previous branch syntax @{-n}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'branch -d @{-1}' '
diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
index 878aadd64c9517dc1891031bd8bee0b298cfccb6..023b4c6f0b3a0c0007eec8f9673a2645d6029d2f 100755
--- a/t/t0101-at-syntax.sh
+++ b/t/t0101-at-syntax.sh
@@ -2,7 +2,6 @@
 
 test_description='various @{whatever} syntax tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 522fb2ae696da93e0b8bb8d430f0a4dad6cbd7b3..8853d8afb923e62e5a60d6a52ddcc9a4c6e45aac 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -5,7 +5,6 @@
 
 test_description='Gettext support for Git'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 8724ce1052ddbf23ce421e15562c2416b2ea0ceb..6c74df0dc67e575d171c8ad4a4ab57465b1e622c 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -8,7 +8,6 @@ test_description='Gettext Shell fallbacks'
 GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=YesPlease
 export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index 5a6f28051bd275577110ddbba5618f756ca0937e..b15cb65d5d790007aa1a18365f69d873f913b353 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -5,7 +5,6 @@
 
 test_description='Perl gettext interface (Git::I18N)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 . "$TEST_DIRECTORY"/lib-perl.sh
 skip_all_if_no_Test_More
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 86cff324ff181110cf1ef8a44af6c4295b7f5d40..0ce1f22eff66285ee0da9b1830de961555fbad2b 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -5,7 +5,6 @@
 
 test_description="The Git C functions aren't broken by setlocale(3)"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reencode-sanity.sh
index 310a4500125f4a0d18f6c68a10cf1e8fe7d3beff..28d92bb9b7cade291d2dacbce893afdd6543c94e 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -5,7 +5,6 @@
 
 test_description="Gettext reencoding of our *.po/*.mo files works"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 # The constants used in a tricky observation for undefined behaviour
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index b9adc94aab41650da73e5541bc4666102e4baad5..eff9a59dbd0d5d865dff434fd7860cb1070100af 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 91260ce97e5bdb39550a9e1e4abbc4d5fea48a21..bac90465406d94743236024c20dbfdaf78782471 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 147643d582643efebf794000fa48e3d460c76173..1211db9f4687176810395d6fb28416612d7bc927 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 6a76b7fdbd4557b2df8e34f9683323cf8073ea38..17952e52d69bfcad54faf3feafec324e0ac0825b 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -2,7 +2,6 @@
 
 test_description='basic credential helper tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 5d5b64205ffe35dfd74750b3188946200aab916e..dc30289f7539ee7ec8dac98be814f09472c23822 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -2,7 +2,6 @@
 
 test_description='credential-cache tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f83db659e2581444b9a9740df8cefd7fb530c359..c1cd60edd019a07128b130336f53d1a46d44baf6 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -2,7 +2,6 @@
 
 test_description='credential-store tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 8aadbe86c458560f1e23811db10679c806c5a324..72ae405c3ed979edee54cbe83e73ec566d23f6d1 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -29,7 +29,6 @@ you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequence of shell
 commands.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 818700fbecd457a9fbb7cc3bb91984c1224631d5..34bdb3ab1f23b70115a47bb7b5bb01fb57beae8f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='partial clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 932bf2067daaeb88de744762f2cdbc0b59c8b565..c98d5018695a137b57cc9634312f220cff897cce 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -2,7 +2,6 @@
 
 test_description='check that local clone does not fetch from promisor remotes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create evil repo' '
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index f99a69ae1b74a91defa88ed74062fd13d29c2bad..853101b86ef53d8a1f6e31c45906496ca09d9cbb 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -5,7 +5,6 @@ test_description='assert (unbuilt) Documentation/*.txt and -h output
 Run this with --debug to see a summary of where we still fail to make
 the two versions consistent with one another.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: list of builtins' '
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1eb3a8306ba15b3e782b940f605afa8ec551ec8c..d1a498a216fb522eefa57ac7cb2c63d0ebc21f47 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -2,7 +2,6 @@
 
 test_description='progress display'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_cr () {
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index bef2b70871364931ab8b3ead950f59d11b6fe216..1e62c791d97250f081842c86316985bee0f7a940 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -7,7 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index d8cbd3f202b5f00c9a94c5a2ea2dced6606b6f4d..aa7f6ecd813c44d4db8f9f6dc41f297742b2377e 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -15,7 +15,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'enable reflogs' '
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae4bab3dcca3a8ecc1060cb2f360ab30..30e0a36242e2f280b9384438e52199d327028639 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
-TEST_PASSES_SANITIZE_LEAK=true
 
 . ./test-lib.sh
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index babec7993e3f3ec1dc2a72b13fce797766765cfe..67bf3a82f6eb531b6791a294baf0194f139bdf47 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -10,7 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=reftable
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 INVALID_OID=$(test_oid 001)
diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
index 2805995cc8c6980b6e8477c21e21987254e5e3e0..5e05b9c1f2ac73deac78ce6fa91e60cb377a3c68 100755
--- a/t/t0611-reftable-httpd.sh
+++ b/t/t0611-reftable-httpd.sh
@@ -2,7 +2,6 @@
 
 test_description='reftable HTTPD tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index 84922153ab6a6d1aca3ce79d42a290a3899b372a..d0d7e80b492091d1949467f9835c35f622ae0bb4 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -11,7 +11,6 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 GIT_TEST_SPLIT_INDEX=0
 export GIT_TEST_SPLIT_INDEX
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq JGIT
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index b1c6c97524f16cb5ba15cf814ff8f959e4cb0c80..e2708e11d5b941cf707d3c22466e4cc6957d0302 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -16,7 +16,6 @@ export GIT_TEST_DEFAULT_HASH
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'default write options' '
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 0e8c0dfbbee643c80d2164b6dc8e80fe6522f2e0..b9dd21cfb6b1d51d1862ef3c6ad80f3496b04694 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -72,7 +72,6 @@ In addition:
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 48a1550371a14b8f92d72ac59efd463b229afb88..4a88bb9ef0c4012fc829c1d537c53747f67c05bb 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,7 +21,6 @@ In the test, these paths are used:
 	yomin   - not in H or M
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index a7c2ed0d7c0a31180e6af1abe9dcc6366e62e2c5..df6ef53725878015850c5ac55caf38829a55b242 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,7 +9,6 @@ This is identical to t1001, but uses -u to update the work tree as well.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index c860c08ecb46a37a6f20bf403963afd7576fed9f..66e2bf4aec3d7a24bfd846e1125ae94bfdce5c74 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -6,7 +6,6 @@
 test_description='git read-tree --prefix test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 2b9720b0feb465bb9c4651626c43829ec27cd7b8..11bf10424f16208cda726c612cb64bfc89d9c803 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -5,7 +5,6 @@ test_description='read-tree -m -u checks working tree files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 26be4a2b5a007afa7ef1a9bd4438d16173c6aad5..6b5033d0ce3b3489598f0f1fba5b047bd3e5b43a 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree -u --reset'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d36cd7c0863591d197cfc3ef340972943ff40e6f..ff9bf213aa2c73e42ab82d9b227fbbb7049c1e43 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmdmode_usage () {
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index d73a5cc23705e2b697d56f961b27a6815725f8c4..a0481139de5519bf65a3320f21dfd72e97a4f6f5 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -2,7 +2,6 @@
 
 test_description="git hash-object"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo_without_newline() {
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index ad5936e54d1f73ed46c1066600f273f0847ca673..4512fb0b6e68b4ac12e54610441fe1f2de89ea0c 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -5,7 +5,6 @@ test_description='test multi-tree read-tree without merging'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index fc179ac5dd604a085c9a19a491f0abb7ac4c066f..2935f68f8d215203ee1d2a9813de0039a89cb58f 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -5,7 +5,6 @@ test_description='test read-tree into a fresh index file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 22875ba598c2a82bba6c7504c420c690441f7167..c291a2b33d79b7af79b4039cf41a0d9dd1e2bc17 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -2,7 +2,6 @@
 
 test_description='git mktree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 595b24c0adb3081230fe65884fd436e1f12896d4..742f0fa909fd6e8a7fe2b376b3e5083a30d71c73 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -12,7 +12,6 @@ test_description='sparse checkout tests
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index cde93d22cde4ab09fe9fa594a58813f1d3f276af..57f0770df1410ea2005d8637323ff0eeeb82d880 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree D/F conflict corner cases'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index cf8b94ebedbdd2ce780550d6217e7223bcf20d8b..bfc90d4cf272e8a8d6b6d517787bed0f074f4e82 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t1014-read-tree-confusing.sh b/t/t1014-read-tree-confusing.sh
index 8ea8d36818bea10b227640b4974cc57f2157fa2e..0c0e6da5cf5b20d7e0b5bb5267d4d08f655055ba 100755
--- a/t/t1014-read-tree-confusing.sh
+++ b/t/t1014-read-tree-confusing.sh
@@ -2,7 +2,6 @@
 
 test_description='check that read-tree rejects confusing paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create base tree' '
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index da737a32a271185882b6f1fb6b190e7e82d90a48..9b965d0294309f947339111a91a67e885972a6c3 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -2,7 +2,6 @@
 
 test_description='Test various callers of read_index_unmerged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 8341a2fe8395a0ed41d46e442ddf3b2df465bd1e..5641271b23a445c12292de5242a499c2f178ded9 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -5,7 +5,6 @@
 
 test_description='Test how well compatObjectFormat works'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 45eef9457fe13d9eef6e463405190ca84c67bda5..9fdbb2af80e0a82429289d06b24d4dcfac3f263d 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -6,7 +6,6 @@
 test_description='Try various core-level commands in subdirectory.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 69bf9476cbf65dc39ac6460774938773424b61cf..0b892894eb9031d88aa26cf43fc09235a2aa07bc 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -4,7 +4,6 @@ test_description='rerere run in a workdir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index cca4380e4319a024416c4bbe2e097f63e409af48..d390d7d5f857bb3c755d0c0d385e9045a754887c 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -3,7 +3,6 @@
 test_description='git read-tree in partial clones'
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read-tree in partial clone prefetches in one batch' '
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index ed638f664479bd1abfca19b985aeaaff66452f18..c71932b02423734908428a9b2be776fec229ce9e 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,7 +3,6 @@
 
 test_description='adding and checking out large blobs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'core.bigFileThreshold must be non-negative' '
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index f6709c9f569ec7170d24694b369abf0d6f8518ec..361afb679b0af752d1be91d29b9b42a7c6a6992d 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -2,7 +2,6 @@
 
 test_description='test conversion filters on large files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 set_attr() {
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 5e0f0a334f4d43dd76199a50037c5900da2cb63b..502a5ea1c51e3ac808297148e1e2c27ec9784549 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,7 +2,6 @@
 
 test_description='see how we handle various forms of corruption'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index da0e7714d5ac5c94a04e7aa100288ef85f42a860..3a14218b245d4cf67f9bdde4c18a7eee8ac6524a 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 8c5cd651b4b80ba05ab9fab572e384806a8404dd..ab3a105ffff2532b35074611de9e65d60b8db082 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_SPLIT_INDEX=false
 export GIT_TEST_SPLIT_INDEX
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 list_files() {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2157f37da36fd61b6cfac3d09d3e01643bd1e6e4..a4c7c41fc00aa3043c3f18fdc4c5d7785d17f7de 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -5,7 +5,6 @@ test_description='compare full workdir to sparse workdir'
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index 0f37a43fd3c5b2638fe41408a3860ce2facd6401..ae66ba5babf347f12f2c4cb213b0de72ea980da2 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -12,7 +12,6 @@ Also make sure that command line parser understands the normal
 "flags first and then non flag arguments" command line.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<EOF
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f13277c8f3e3c410aecd3aea9141323c0398058e..51a85e83c27b1300f29354b35a13726687b23997 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -8,7 +8,6 @@ test_description='Test git config in different settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for mode in legacy subcommands
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 29cf8a966133a7851722c8cdf828fe3c524a12ec..630a47af21e6558f1d3c9985411a603aaaab5ec0 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -9,7 +9,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 42caa0d2978b58755d43b3361589c6e7691c34db..69723b88ff896130832c5081721c2393702f61ed 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -5,7 +5,6 @@
 
 test_description='Test repository version check'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 0506f3d6bba6cb64255a1b7685481b8ccdb7784d..d971925ed021ccd38db89843bff19727fe823367 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test wacky input to git config'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Leaving off the newline is intentional!
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 31b89dd9693afc95f30e0bb9e11dc704fda24b41..c69ae41306c90d33b2ac253a25961ae76fec81e7 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -9,7 +9,6 @@ test_description='Test repository with default ACL'
 # => this must come before . ./test-lib.sh
 umask 077
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need an arbitrary other user give permission to using ACLs. root
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 517d6c869379bfdeef61a4c346d1e05fb7f55d99..8ff2b0c232b485a2d5225c30a9f75170c5bea952 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='test config file include directives'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Force setup_explicit_git_dir() to run until the end. This is needed
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 53e5b290b9bcab0d8809e34f4343f191af4ed9dc..40d3c42618c04f8b0e656af83fb2e303601dd7ff 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -7,7 +7,6 @@
 
 test_description='Compatibility with $XDG_CONFIG_HOME/git/ files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read config: xdg file exists and ~/.gitconfig doesn'\''t' '
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index b9852fe40e4a045ae4a355a85aa6e2d14d758479..5cb546dd00c665b015f4002b21d50b8a7104ab79 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -2,7 +2,6 @@
 
 test_description='support for reading config from a blob'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create config blob' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3bfec07f1abcc1d997f428e84acf6cc3490b1b6a..e0e49053f07fbcdad817cf084fcd1328793302cb 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git config-set API in different settings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 'check_config get_* section.key value' verifies that the entry for
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 523aa99a1e264661c9af03e450ff14c345831617..9710ee0ca4571dd578575ee1a08ede9afec6819e 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test read_early_config()'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read early config' '
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index 1a90d31201a612b69944bffba27b347eeb0ab580..69e64c6c8686fb17fb24616bd7cb6fc2992cc9fa 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git config in different settings (with --default)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'uses --default when entry missing' '
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index ceeb7ac3a4745fd817dc601da93b836260fcf51a..45a04929170640b1fa673f88614728b449c43887 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the core.hooksPath configuration variable'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bb057596f1e05abe4e0fa561a7eb1c1d087b91a1..e2316f1dd4c200df790ac639540d196df5c70c7b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git update-ref and basic ref logging'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 Z=$ZERO_OID
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 90af3f955c018bd86807c2756f142968242e8ca5..a2a7e947164c2a304ce588a4433cca07a98e9469 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -2,7 +2,6 @@
 
 test_description='basic symbolic-ref tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # If the tests munging HEAD fail, they can break detection of
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 5ed9d7318e0cc97435952039c7e8c1af842a24a9..cabc516ae9a4fa1c404c245f4b3b9efd7e93200e 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git check-ref-format'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 valid_ref() {
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 403f6b8f7daf00353cf741450c3390331ae40647..9d698b3cc35a7f13f30c36a0d8fe7b5ed1430b07 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -4,7 +4,6 @@ test_description='show-ref'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index df90112618c10681f887222ef9890c28c6c27bc8..28e6c380d76db10d313868b140eae6c4c1597c7e 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git update-ref error handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create some references, perhaps run pack-refs --all, then try to
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a6bcd62ab658eefcd11ae1778692ad6d7f4c3008..6d8f401a2a98271e2cbd9c6a515c10044b53ce22 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test main ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store main"
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index c01f0f14a1266f93f9066c738693d7c8a9a526dc..9b9e5d0766f38da19e4b532a003b7559efb28676 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test submodule ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store submodule:sub"
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 48b1c92a41450b25645d6cd782aa86c8e630164b..9d8e1a13432b8344088cb3282b22aa2e9240ec89 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test worktree ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RWT="test-tool ref-store worktree:wt"
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 9469c79a585f051177a4c9223c0e0f9fd37124dd..41ba1f1d7fca94e9504e0c198b2e1f7885c41185 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -5,7 +5,6 @@ test_description='packed-refs entries are covered by loose refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index 7748973733e6adab07117192accabf7698189681..e3c501848a494c6ff11caaa6044cefae08e1dbc0 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='avoid rewriting packed-refs unnecessarily'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq !REFFILES
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 246a3f46abafdf0e24528be59b33a4987ff791c1..388fdf9ae57dac4ed7d568e8043e090a445632cc 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -7,7 +7,6 @@ test_description='Test prune and reflog expiration'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_have () {
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index da581ec19ac619cef717a4a3b4dc34f55c0142b8..975c4ea83a877b2dfaf6059c320c71c0282fee0c 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -4,7 +4,6 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index ff30874f940439fe979e3857400c54b944194dcb..f7d69b66ff33e8c23b858d58d0473e6f672f5c9f 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -2,7 +2,6 @@
 
 test_description='reflog walk shows repeated commits again'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index d2a4822d46fd05c45273f48b0caf48cadb2a07f1..934688a1ee82e29f2552bb2444eb06626fe254f8 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -4,7 +4,6 @@ test_description='Test reflog interaction with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset_state () {
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 49d28166da0d93095988c959ad87842e17cc9860..be6c3f472c176525b64383b726ad7b05b664accd 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -4,7 +4,6 @@ test_description='various tests of reflog walk (log -g) behavior'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some reflog entries' '
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index eb4eec8becbfa64efcde4e866334363a866c01a2..51d79bae83b429378db2ebabc628719053d831e0 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='per-worktree refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 5a812ca3c0b5d3f7de60dc999de6aafaf1f384a6..dd003a196f718b7c5ee5f85be41f74ef7d538c32 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -5,7 +5,6 @@ test_description='reference transaction hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1417-reflog-updateref.sh b/t/t1417-reflog-updateref.sh
index 0eb5e674bc1f0dbc688523dd3f94a5e5bb32b6d7..2f37402536743e164f6cc452afeec58a307e87cb 100755
--- a/t/t1417-reflog-updateref.sh
+++ b/t/t1417-reflog-updateref.sh
@@ -2,7 +2,6 @@
 
 test_description='git reflog --updateref'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
index 2268bca3c11ac8e2d73e3a399b8debc44fc712cb..d51ecd5e9250f004e0b0c894b308172237e5666c 100755
--- a/t/t1418-reflog-exists.sh
+++ b/t/t1418-reflog-exists.sh
@@ -4,7 +4,6 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 3256e4462f96db6f45f953ddc4473a6ba05213df..c04eeb72111662a607479f78f496ce36e75e9f51 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -5,7 +5,6 @@ test_description='test exclude_patterns functionality in main ref store'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for_each_ref__exclude () {
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index dbe15a0be1051608c4dc6dd727e1589e9422b7b5..2fb2f44f021ea36eb2f1601ba07974a041f19661 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -5,7 +5,6 @@
 
 test_description='Test fsck --lost-found'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 0c00118c2b3f798777bad27a7082e5c0a2f29ea4..3ab65f72cdec882c8fab9079599e4fd55c1d1774 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,7 +4,6 @@ test_description='Test handling of ref names that check-ref-format rejects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 280cbf3e031e1ab67ed28aa2af4c3b105b7d254e..8a456b1142d1cc463f97c5e8809bcfc83ffa1e96 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,7 +6,6 @@ test_description='git fsck random collection of tests
 * (main) A
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1451-fsck-buffer.sh b/t/t1451-fsck-buffer.sh
index 3413da40e4ae0c197b42cb92e9a75983a27bdeb3..3a3d33f40548954313b8d3e58351ea8ceed6b469 100755
--- a/t/t1451-fsck-buffer.sh
+++ b/t/t1451-fsck-buffer.sh
@@ -15,7 +15,6 @@ These tests _might_ catch such overruns in normal use, but should be run with
 ASan or valgrind for more confidence.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the general idea for tags and commits is to build up the "base" file
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f7c0783d30ccd61b0fee67c115193b42bb0e2c77..cf57cd66f2db2d6b42e66a8a4349706be002d940 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -5,7 +5,6 @@ test_description='migration of ref storage backends'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_migration () {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30c31918fde6539d52800e18dfbb3423b5b73491..bf2a90df9484662a13294ab3a0ffecdc44996c05 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -4,7 +4,6 @@ test_description='test git rev-parse'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_one () {
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index ae6528aecea7d3b36cfe51c5f19c7098f05429e3..8c94ac2e70bdc6835a6f79705fe34e0744ddcc42 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='test separate work tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 5eaa6428c43917515f95baed1c1cf4ad2cb6110b..3962f1d2882a1f4331e0ca8c83c0ac27fecf2019 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -2,7 +2,6 @@
 
 test_description='test git rev-parse --parseopt'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_invalid_long_option () {
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 79df65ec7f619baa053b2aa50d5ec08557cb820a..75a708f9ba5f22d0eb007cc68871da5a62571905 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -9,7 +9,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index c1679e31d8afca409323484d588bf63b264f45f2..e04420f4368b9305162f1fd7b0be7926a113e057 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -2,7 +2,6 @@
 
 test_description='test GIT_CEILING_DIRECTORIES'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_prefix() {
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4a5758f08a8b2f38bc98e6ac4e26cfa36713780d..2803ca9489c7c6bc2accd85c62ec52805ce2bce3 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -5,7 +5,6 @@ test_description='test @{-N} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index a3464976e3a934ca1dc0b17703b6476339a07fcb..722884e65f45871e281954f814154cfe976d35c1 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -7,7 +7,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_did_you_mean ()
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index b9af6b3ac035a04858ae0c7e0963166af665bd81..cb9ef7e329eb06a693ead9ab747f9efd37021c94 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -5,7 +5,6 @@ test_description='test <branch>@{upstream} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index e841309d0eab1022f3442c23795f884ad98a8280..87a42864145f85ed539b9d1cbb9a3dd5f71fc708 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -4,7 +4,6 @@ test_description='test various @{X} syntax combinations together'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check() {
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 591505a39c02786962a02161d533f28dca16951e..bbfe05b8e4a5c4c13e531647bfa460c0a552de2e 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -43,7 +43,6 @@ A few rules for repo setup:
 # This test heavily relies on the standard error of nested function calls.
 test_untraceable=UnfortunatelyYes
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 here=$(pwd)
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e7e78a402813368396632bdbc32793f4919a2f95..6ecfed86bc0d6aa6390f09dd3a06976208d3f8cb 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -5,7 +5,6 @@ test_description='tests for ref^{stuff}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index f9d68ce74ea0950455300c761b5345e9db300a09..70f1e0a998e103704373e2cc4ffd21e09c7c64b0 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -23,7 +23,6 @@ one tagged as v1.0.0.  They all have one regular file each.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmp_failed_rev_parse () {
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
index ba43387bf167b598de91bea497251d270214f545..5f437be8c9e8c932f5d355e3f8636e5cbcd69791 100755
--- a/t/t1513-rev-parse-prefix.sh
+++ b/t/t1513-rev-parse-prefix.sh
@@ -5,7 +5,6 @@ test_description='Tests for rev-parse --prefix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index a835a196aa81be9e7aa79f38c3977a03b71b5336..d868a0811056c83810bdd468d85e6f3a90622da7 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -4,7 +4,6 @@ test_description='test <branch>@{push} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 resolve () {
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index cdb26a30d726bb0088230c251a58ece0d160c72d..75e89c4b6e23c2659006615ba58e44526fc9e373 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='check that certain rev-parse options work outside repo'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up non-repo directory' '
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 342defbb61762892744c3f4dfa96336c6a19d36a..dbd8cd6906338dff358c5fa5a9b8ce1524903110 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='check random commands outside repo'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up a non-repo directory and test file' '
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 62e7fd15964bba7cbc8904471879027219368951..03239e9faa4b7e834b8b8420d8dc5cc17e8a7d4f 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -2,7 +2,6 @@
 
 test_description='index file specific tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 5dcc10188280b2c0ff4b6b9465c87651de47c5a8..a45a8b4eb046f637aa196412c4da7ddf14694546 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -2,7 +2,6 @@
 
 test_description='test handling of bogus index entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 2625ac44889a5c9219e9575a9bbc5265d3c419d5..ac4a5b2734c0784c2cb8878112a5ead9593860de 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -5,7 +5,6 @@ test_description='split index mode tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need total control of index splitting here
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index d8fa489998acc5984da7e21a8a2adf43cfe88cee..5dc221ef382df13089b84dcb03002c2a8f19a9ba 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -5,7 +5,6 @@
 
 test_description='racy split index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 8b0234cf2d5d96980403d65b844639715acfe91b..4feaf0d7bef71fc558e640f5fae37ae1fb95c95c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -2,7 +2,6 @@
 
 test_description='git-hook command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index 79fc97f1d7eb42675c85ef29b8cb36a75d7e7669..f18616ad2be3eaaf6dc72ab9131c88a0c9bdf2fc 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -21,7 +21,6 @@ test_description='git conflicts when checking files out test.'
 # path1 is occupied by a non-directory.  With "-f" flag, it should remove
 # the conflicting paths and succeed.
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_files() {
diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index fc95cf90485366314dcebb7fe77f18b1d8d4ef1b..70361c806e1baf1b26810983374c53eb49ea2f2d 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index -u test.
 With -u flag, git checkout-index internally runs the equivalent of
 git update-index --refresh on the checked out entry.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index f0fd441d810d52c909476a76107098d16ecc9f35..ff163cf6750f6d82c36964eb694efbcfae06135f 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -10,7 +10,6 @@ also verifies that such leading path may contain symlinks, unlike
 the GIT controlled paths.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 98e818f09f21fe6ea374dba692c3f4ed619af735..b92d96fdc4ed5fe1a4b577596133cc59becbd327 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index --temp test.
 With --temp flag, git checkout-index writes to temporary merge files
 rather than the tracked path.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 67d18cfa104b867bfdd2004df0bc8c9e305cfdc9..91b08e03717a619807e0687be6d538bbb6036824 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index on filesystem w/o symlinks test.
 This tests that git checkout-index creates a symbolic link as a plain
 file if core.symlinks is false.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 570ba38580d99513fe12a2c6ed1e1a4c6951e0e2..bac231b167c2c66522b067f027ae4b7801709f11 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -3,7 +3,6 @@
 test_description='basic checkout-index tests
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'checkout-index --gobbledegook' '
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index bd9e9e7530da06da9eb3fc6ce103b82196625d23..6f0b90ce1271ec49f6fd78016c5f3cb082053674 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -7,7 +7,6 @@ test_description='git checkout to switch between branches with symlink<->dir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 8a518a44ea2d2a65f6ee2d9d88c5a8233476c902..eadb9434ae764cc0ca57085a6ce28dd5bee4bb77 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -4,7 +4,6 @@
 
 test_description='git checkout from subdirectories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index 71195dd28f2258d3286cc478967b0319ae58b143..b0540636ae387104edae67cd7baa74949f7f5ffd 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -5,7 +5,6 @@ test_description='checkout should leave clean stat info'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 82c3bfeac1ad9b96eb2adb9ae835fb2032222bd5..3a3d56018e525e9c2e0620fd3e06e0b916ca4782 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -5,7 +5,6 @@ test_description='checkout and pathspecs/refspecs ambiguities'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 04f53b1ea14cb5046ee3cf3ad70804812c6fce8a..61417c756750bbd49c1da3cb7457cca481529207 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -5,7 +5,6 @@ test_description='checkout switching away from an invalid branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 4b6372f4c3e946c26a490698335a821cff5701f2..1f6c4ed0428a5c966c76359c1f4fa2e536f37fcf 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -5,7 +5,6 @@ test_description='checkout can switch to last branch and merge base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 3c1d663d948490901fb3de330b35ae0227730158..b2bdd1fcb425a14a12df9fe896269e5f9c349434 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t2014-checkout-switch.sh b/t/t2014-checkout-switch.sh
index c138bdde4fea1536a06137c68ab100b6b0d1f49b..3e757c6e4e3250577d8327ad3d33651788d43561 100755
--- a/t/t2014-checkout-switch.sh
+++ b/t/t2014-checkout-switch.sh
@@ -2,7 +2,6 @@
 
 test_description='Peter MacMillan'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index fb0e13881cd8a290dd272c6dc16c3f097f49cb39..1820300c62fb3421b3ac3544f746d93207583c52 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -4,7 +4,6 @@ test_description='checkout from unborn branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index c40b661ac12d57209199ea397748409860345d8f..c4f9bf09aa4fd8d541a858d55cfbff34e78de1c0 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git checkout --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index a5c7358eeabefb3dacc94ae94e2c61d200381ac5..80ac661815d0a750ef2291ae3d10798cf96afea0 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -10,7 +10,6 @@ Main Tests for --orphan functionality.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 TEST_FILE=foo
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 43551cc1481c3813c3aae0b291bac2b1a17b63d7..a48ebdbf4d0957181a881228ede5ccda29039f02 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -3,7 +3,6 @@
 test_description='checkout'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Arguments: [!] <branch> <oid> [<checkout options>]
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index c67261e2b68a9d330dc14c92783a485b0f605601..1fcef4be95ce14be0635fa44660a59996e8ed53b 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout handling of ambiguous (branch/tag) refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ambiguous refs' '
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8d90d0285045294b3f39233957ea4487bc7929e0..28bbbe6c05547a4ef8eae1cd671abd298013b68a 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -4,7 +4,6 @@ test_description='checkout into detached HEAD state'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_detached () {
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index ecfacf0f7f3a5fa7c03fa837891c745dec10dda6..a5c03d5d4a2c5a31a8e921fc81344d9470dd79bb 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout must not overwrite an untracked objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index f1b709d58bef0080c1e8067b4b6e725b8141d027..c49ba7f9bd4fe0c6f8f88fbe5a0722b2d6337ac7 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -4,7 +4,6 @@ test_description='checkout $tree -- $paths'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 81e772fb4ebbf1d6c4d156560aa10dfdb02a0852..7b327b754494a8ebb27bb11c7f70649063ccd8d2 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -7,7 +7,6 @@ Ensures that checkout -m on a resolved file restores the conflicted file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 2caada3d834ffc139c0af2e3f1b0b52f9eee9718..a3b1449ef1166756e5bd029a2f94ac6e1c50b03b 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -4,7 +4,6 @@ test_description='checkout <branch>
 
 Ensures that checkout on an unborn branch does what the user expects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Is the current branch "refs/heads/$1"?
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index 246609d54d050e5fce76730318123b30f322b75a..dda169bbc4a649989a519ff5b74ad34fc5791c1f 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout --no-overlay <tree-ish> -- <pathspec>'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index acd55217a6231c35d17f4fbefe2ea27e30d05501..161da054b6dbb534bd70e4150be3e41166d7c27a 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 98f16c72399806d2e0a5cdc0580072dcc8c65dae..a397790df59d0bc015e2b1f244cbbbca27525b7a 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -5,7 +5,6 @@ test_description='tests for git branch --track'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index b3f6bc97b53d87a4442739d4d62cccd923b55bcd..be3fcdde07562c27da31e7dfe549058f3ced0ea9 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -5,7 +5,6 @@ test_description='undoing resolution'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_resolve_undo () {
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 1f193cde965303a8f2362e824e0a86e99f746548..21f4659a9d1c22fcc8c9eb3261315d67988dad2f 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -12,7 +12,6 @@ into the subdir while keeping the worktree location,
 and tries commits from the top and the subdir, checking
 that the commit-hook still gets called.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 COMMIT_FILE="$(pwd)/output"
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 77b2346291b39cfe16c614e8018a20195e7f1118..c91c4db9361133e4e790f2c0201c5f41c14eaff1 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -5,7 +5,6 @@ test_description='switch basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index ac404945d4c4e28b608f664f64c4b422557b2684..16d6348b692806ab25faf89d77a73cd62fab4d93 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -5,7 +5,6 @@ test_description='restore basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 42d552211915754e14ddb79d869fc9ba8f517fce..27e85be40ad6957f9070a609d83ae334776ed855 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git restore --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index 86c9c887881b94a586dc96b3f495a72c022fd827..8198a1e5789cc963c32ecb028209a7a773144fd5 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='restore --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 59e5570cb2d52298ba1c1045d2baef025fd86baf..5ffe1a41e2cd726e00b242a9f289c28c183ef5f0 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -8,7 +8,6 @@ working tree.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index 6acdb89d12bd046674c27aba12119a231dbb0f08..f6fcfc0c1e403930a602e694fe3bf7632b81192a 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -11,7 +11,6 @@ The tests in this file exercise parallel checkout's collision detection code in
 both these mechanics.
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index d02d6a555040c8fde2eb13ba1a990f1d6ce93fca..79fb11f139a2c105f4b86ba0147306166b9ddae9 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -10,7 +10,6 @@ properly (without access to the index or attribute stack).
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 . "$TEST_DIRECTORY/lib-encoding.sh"
diff --git a/t/t2100-update-cache-badpath.sh b/t/t2100-update-cache-badpath.sh
index 7915e7b8211dbb16f49c9f1e5f0433c6f3230e58..2df3fdde8bf665a2b531dd367b70a7a767ee3dbc 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -22,7 +22,6 @@ and tries to git update-index --add the following:
 All of the attempts should fail.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mkdir path2 path3
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index e3c7acdbf9125d68d72d983ed692ce6851f785bd..6c32d42c8c688845682d578141dbef760a663215 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -6,7 +6,6 @@
 test_description='git update-index --again test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --add' '
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index c49cdfb6e582f41ea4010df7f4556f7aad5f1cc4..9b11130ab93a327f9c5e57cbe37062e3e095dbee 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -8,7 +8,6 @@ test_description='git update-index on filesystem w/o symlinks test.
 This tests that git update-index keeps the symbolic link property
 even if a plain file is in the working tree if core.symlinks is false.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index e9451cd567cd61ffb678ee33d3c01e646b4cbe3a..6938ecca86836660ea3f4e7d74a7ba2ca2913606 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index with options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success basics '
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 7ec7f30b442b3bc04be5ac64cbf1898c0b5268b6..7a0778ed983a509a8fc65f06901b4c37ba4db0ee 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -5,7 +5,6 @@
 
 test_description='skip-worktree bit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
index 963ebe77eb6b49b733f249b4ee93020b35ca4097..a7f3d47aec2591f9da19ce24b2796005ddf87096 100755
--- a/t/t2105-update-index-gitfile.sh
+++ b/t/t2105-update-index-gitfile.sh
@@ -6,7 +6,6 @@
 test_description='git update-index for gitlink to .git file.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'submodule with absolute .git file' '
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 95c004dc5c5462b8b18cf348e5b1c44115a73042..6b2ccc21a937dff83c7f408f06d4fe8355c81f4a 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -3,7 +3,6 @@
 test_description='git update-index --assume-unchanged test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index f0eab13f96a6b946f982db2543112cc7467d857d..cc72ead79f397873b5005196a99baad6b0ba2450 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,7 +5,6 @@ test_description='basic update-index tests
 Tests for command-line parsing and basic operation.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --nonsense fails' '
diff --git a/t/t2108-update-index-refresh-racy.sh b/t/t2108-update-index-refresh-racy.sh
index bc5f2886faf8877fc13adecd607b41f46d69b6d1..b31dd8ece5023ee7bcb122739997b07315c1f5d7 100755
--- a/t/t2108-update-index-refresh-racy.sh
+++ b/t/t2108-update-index-refresh-racy.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index refresh tests related to racy timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset_files () {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index df235ac306e7126f7090bc62c451e906b174c387..06e83d33333dc8e11c48fdf33bd255ea66a41ec8 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,7 +14,6 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index dba62d69c6c5c18172bdbc62c5138643cf284b00..687be974d413a1f50e0f25377d9ff3f30af47ec2 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -2,7 +2,6 @@
 
 test_description='more git add -u'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 24c60bfd7905ba136ad59f090b40fe23a37d0a1e..9ee659098c45fbc18dfb5ccc2292f978320c1ebb 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -2,7 +2,6 @@
 
 test_description='git add --all'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8fa44a92a277f414018d3f71731f791ec4b4f490..192ad14b5f474f7718ff57b4f6700d0f7d93649a 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -2,7 +2,6 @@
 
 test_description='Intent to add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index b7cf1e492c1073ee3fb4705bf8755d8b49c3d6d0..31eb233df51f5e7f145764a3aa8c5b1fd7142f80 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -2,7 +2,6 @@
 
 test_description='giving ignored paths to git add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
index 98265ba1b495eb91df0fa60467ebf0ac932cf1b5..43d950de6400fca709286c5316e71e037791f04f 100755
--- a/t/t2205-add-worktree-config.sh
+++ b/t/t2205-add-worktree-config.sh
@@ -17,7 +17,6 @@ outside the repository.  Two instances for which this can occur are tested:
 	   repository can be added to the index.
 	'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '1a: setup--config worktree' '
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index b40eeb263fe896a9553ef93f82e8a78b1dc2fb60..c8de6d8a1902209ef98ec0832296ed9060310429 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -2,7 +2,6 @@
 
 test_description='cd_to_toplevel'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 EXEC_PATH="$(git --exec-path)"
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798c6d023909cec771e5b74e983af5ea..ba320dc4171aa7884591067c00853a955d84f4e8 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 976d048e3efc74be9cd909ce76d552b3944d2e10..aa5b42c0f7b9384641f7cb2b85728bd1a79c26c4 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -5,7 +5,6 @@ test_description='prune $GIT_DIR/worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 33ea9cb21ba07c9563530b54da06753eaa993fe2..cb125ec2265b1dc378908079d859a7eac3dfc833 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -5,7 +5,6 @@ test_description='test git worktree list'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 901342ea09b51a8e832f1109fbb737df84283aa2..08531deb5b203751489722802590d18b120d2015 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -2,7 +2,6 @@
 
 test_description='test git worktree move, remove, lock and unlock'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 842937bfb9a8a660bf0696df324ec71f6693ae5b..9536d1091954b48a87b74eead0c382ce70355c4e 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -2,7 +2,6 @@
 
 test_description="config file in multi worktree"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 1d7f60563387f9c2f53dfc3a79ac0289afe57611..11018f37c70c02e9052b36be9edb8b05211bcf8d 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -5,7 +5,6 @@ test_description='Combination of submodules and multiple worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_path=$(pwd -P)
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 7686e60f6ad186519b275f11a5e14064c905b207..bf340b877261b0201d321499da4d18cc6cf379d2 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -2,7 +2,6 @@
 
 test_description='test git worktree repair'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 7750dc9265a90bdd8b0e3781accb13f00a23bb09..57c201869f02e6d9b763e004175d29d5769149b1 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -2,7 +2,6 @@
 
 test_description='test operations trying to overwrite refs at worktree HEAD'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
index a3136db7e28cb20926ff44211e246ce625a6e51a..d51cc8c5ab7e4f51048afdb8ee8fbfcac3695042 100755
--- a/t/t2408-worktree-relative.sh
+++ b/t/t2408-worktree-relative.sh
@@ -2,7 +2,6 @@
 
 test_description='test worktrees linked with relative paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'links worktrees with relative paths' '
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 714feb83be5b36640008a96921b4b091e798df88..5c0bf4d21fcbb2a55e2c41c184ccb4c188c88ca4 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -2,7 +2,6 @@
 
 test_description='Test handling of overwriting untracked files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_setup_reset () {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 8af4e8cfe3c8414d2c8d676b5fec7f6bfcb6909a..f6d8d7d03d7ca42b566c2b177ee57345e09b7107 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='Test handling of the current working directory becoming empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 11af4552f7461e1091e71407517504a6497867e5..13f66fd649d81d9e7c620cf0693a82e041a2711a 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -16,7 +16,6 @@ filesystem.
     path4       - an empty directory
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 1ed0aa967ece5a38cf49bc43178e4fba187d4cd4..4b676462852ab8436e1c72eb4ca759cfea2b8d34 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -8,7 +8,6 @@ test_description='git ls-files --others --exclude
 This test runs git ls-files --others and tests --exclude patterns.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 rm -fr one three
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 4dd24550eba00ef005abea327ba1c1862768f3a1..31462cb441ef2fc4e2bab6e12a4e1aca9425ef4d 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -13,7 +13,6 @@ filesystem.
     --		- another file with a funny name.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index 7933dff9b3849181b4c168096d166f1054a2a374..ac3c811f464c289f87536ea4dcbc2faf7b30f634 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-files --exclude does not affect index files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create repo with file' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 12e41a7b40e0ab73efa1fc30354e80996c3a91a4..a1078f8701dbfbc6a05237216f82eb334fb0b931 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -6,7 +6,6 @@ This test runs git ls-files with various unusual or malformed
 command-line arguments.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'ls-files in empty repository' '
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index fbfa210a50b2906e57853095a2830f3bc6e18136..db13aabf625b3aa26f4b5ca3dc2cf86f623c4e51 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -5,7 +5,6 @@ test_description='ls-files tests with relative paths
 This test runs git ls-files with various relative path arguments.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare' '
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index 2aaf91ebc8c323a5ce4475bb8a7e03543dc319ad..22c7256c3aec853cc67aca7feca5600d656d7c3b 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -2,7 +2,6 @@
 
 test_description='overly long paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index f04bdc8c78b6e852d04ab4b93446248e40459f13..61771eec830c0688587588ee0a334282effdb1bb 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -6,7 +6,6 @@ This test verifies the recurse-submodules feature correctly lists files from
 submodules.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup directory structure and submodules' '
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 51d3dffaa66528ff36ebe7b6660f823a2fe56371..85f370495876f51691322f3556b944a023ad8388 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the lazy init name hash with various folder structures'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test 1 -eq $(test-tool online-cpus)
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-others-nonsubmodule.sh
index 14218b342437788fef40c539c45fb41575ef0071..963f3462b750b2a4fc7d009df6cf1fa1949090d6 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -18,7 +18,6 @@ This test runs git ls-files --others with the following working tree:
       git repository with a commit and an untracked file
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: directories' '
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 054178703d732403ce32eda9871d8d85c47dddaa..7af4532cd1dfd063f554f3b049052d27006db483 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -42,7 +42,6 @@ We should report path0, path1, path2/file2, path3/file3, path7 and path8
 modified without reporting path9 and path10.  submod1 is also modified.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git update-index --add to add various paths.' '
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 69e44c387fa83c576e80854424da694c8afa299c..3da5b2b6e795ec4587608ead8bc10abf0c6d9039 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -2,7 +2,6 @@
 
 test_description='directory traversal handling, especially with common prefixes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
index 190e2f6eed758229579a85118106e80d05c8d7d8..2682b1f43a666564a6f74bd20deca547f721ac34 100755
--- a/t/t3012-ls-files-dedup.sh
+++ b/t/t3012-ls-files-dedup.sh
@@ -2,7 +2,6 @@
 
 test_description='git ls-files --deduplicate test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index 6e6ea0b6f3ca256eb3903b08ca7025e3508ecb0b..8bdaacd85ace3d871b4e8f188f77f5a889f252ea 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -2,7 +2,6 @@
 
 test_description='git ls-files --format test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for flag in -s -o -k -t --resolve-undo --deduplicate --eol
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 133593d23c0e898b41f697831d4f41dcbbf54d6c..ac82c9cee8a0f3267b7258c10857a4b46f485a98 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -10,7 +10,6 @@ returns an error when a non-existent path is provided on the command
 line.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index bd65dfcffc7b80e6dceb1603a189d07ab0d4b0b3..768d702fbbfb4a4684904db59d3a664f07b5a452 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -2,7 +2,6 @@
 
 test_description='Basic subproject functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: create superproject' '
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 3884694165525b9e4a3d8527785f40758817be53..f1f09abdd9b254eed1efa6b0d06369f3c8606cf8 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -2,7 +2,6 @@
 
 test_description='fetching and pushing project with subproject'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 5a06732ca730f4a4becff478cc96f20b8931f6fc..eb69da61fe7cd17dd4cc875181935e45d15931a8 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -9,7 +9,6 @@ This test runs git ls-files --with-tree and in particular in
 a scenario known to trigger a crash with some versions of git.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4dd42df38c25615e0833b754d1a2c3132ef0bf1d..3da824117c61fd6d390f84ae56d631fe5d0d9071 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -2,7 +2,6 @@
 
 test_description='wildmatch tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 should_create_test_file() {
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 436de44971eca5d7cbbe79d45ff2a59cf51329eb..8f294d983267f394891340962dce944bb07bed71 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -17,7 +17,6 @@ The new path restriction code should do the right thing for path2 and
 path2/baz.  Also path0/ should snow nothing.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 5af2dac0e4b8d5fde4d6a11dae240086473e0571..ac44525810f977fca606034bc1eb8adb58219a7e 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -20,7 +20,6 @@ Test the handling of multiple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 3942db229000e0c367a93b200f30c57bba95e7ee..1e16c6b8ea610c4582e63950b8939205fc228b25 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree with(out) globs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 81c6343962381fc17b1bff4d3ca8958951bde70d..e7636f6908f19fe041246a644616b35cc99b5e13 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -7,7 +7,6 @@ Miscellaneous tests for git ls-tree.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 3adb206a93bc58aac509a1f093f9dd86cb98e5be..a1b2069a256aab83a8f6ad0469d4c23eccc3ecc9 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree --format'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
index ce2391e28be6f213aead49ec1315e6f5f08fa25d..8bdf400682dae54a8f22e1ef6fbb84c28981b7fa 100755
--- a/t/t3105-ls-tree-output.sh
+++ b/t/t3105-ls-tree-output.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfa6a720d090c2f7f2a085f60065bdcfaf8d1d9..2295db3dcb018cb1dcf2ad461e9f29b9ccb98a6d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -8,7 +8,6 @@ test_description='git branch assorted tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 6e587d27d7a5e3867d27d05d300f7e8149e77587..800fc33165a9eff0abe1f6edc27acb2b4978e317 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,7 +2,6 @@
 
 test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 3b6dad0c4661505b6c26ee111eb351efd3d0caca..a1139f79e2ccfdff2b562571bdd8bdf8aa974883 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -2,7 +2,6 @@
 
 test_description='test show-branch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'error descriptions on empty repository' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index e627f08a1790b39ea6d21d29cb769a8d58ceb580..500c9d0e727a2989ef0c37c71890d057f0d90819 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -2,7 +2,6 @@
 
 test_description='git branch display tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 594e3e43e129a8848b5f2e65538087ca978743d6..3399344f25dc859ad743b3914a3f5c37e92bffbb 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -9,7 +9,6 @@ This script aims to check the behavior of those corner cases.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 expect_branch() {
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 0b61da92b37763213e4cee3744f127971cb6fcb1..da1c202fa7134500a317f03f7baa5de1dc1d6da2 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='basic branch output coloring'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 86010931ab6243e0e617b14cae0eb63975edee7d..d2ca43d6aab504a4802535e07cb9808f33cdcdca 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -5,7 +5,6 @@ test_description='range-diff tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note that because of the range-diff's heuristics, test_commit does more
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index 904eea7df598f7d4b6c03ce000c0db2a44556324..fe72b247164e56fc9a7af134583e2b9f8cc9bbdc 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -5,7 +5,6 @@ test_description='git branch submodule tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 9cbc34fc5838b4d4a886135352e92d613ca8146a..37b9d26f4b6ba88396a2aaaecd4675470cfaa581 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -4,7 +4,6 @@ test_description='tests for the peel_ref optimization of packed-refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index d3ac826283e1a16315bb158754224067d5b0afe4..f5bf16abcd8ce2aae5929129913cbb8927b06539 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,7 +9,6 @@ This test tries pathnames with funny characters in the working
 tree, index, and tree objects.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT='	'
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 813dfd8db9759e90fed510734848e9dd28582549..d6c50460d08648622c519cca690ef21e32a23179 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -5,7 +5,6 @@
 
 test_description='Test commit notes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script fake_editor <<\EOF
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index d0c4d38b4d485d0b3faef4cdc7acbeb42b3c929c..bb5fea02a03a563a23e806d80dbb88a673c40802 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,7 +8,6 @@ test_description='Test commit notes index (expensive!)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_repo () {
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index bc9b791d1b9ed2a780de4544232f769e093072b1..eac193757bf1a5cd27ed4d54249a41de7b302bde 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -5,7 +5,6 @@ test_description='Test commit notes organized in subtrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 2c3a2452668c514ce40c107537cc4e0c1abe5312..03dfcd3954cee5402dde186c6edd17b47db211dd 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -5,7 +5,6 @@ test_description='Test notes trees that also contain non-notes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 1ec1fb6715efda8a0ec546956a0deece76efefff..fcecdc94ff74c21f69435237ebc504d4328faaa0 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -2,7 +2,6 @@
 
 test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 path_has_fanout() {
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index b6e9f643e3cd8d4a81d63e721c5a16390b879e05..8f4102ff9e446bce66436b5e7046c84d739c226f 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git notes prune'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: create a few commits with notes' '
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index ae316502c4531b7cdadfddff12e2f95ea7c9797c..1aa366a410e9a3e2ad4c2fa84431198fbb553a5f 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -4,7 +4,6 @@ test_description='Examples from the git-notes man page
 
 Make sure the manual is not full of lies.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index e1d05ff6bc986a05bc42f02e2e86d78ddedd7aed..202702be1a78b7bb631952dc36af9a1cb69c2ecf 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -5,7 +5,6 @@
 
 test_description='Test merging of notes trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index f55277f499dd57661e166bf3487c792df1cb1bf3..9bd5dbf341fd81a80dbebf0e1fafe623defecfa4 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging with auto-resolving strategies'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with all kinds of potential conflicts
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 04866b89bed3146fe9506c748c0b824ef70b12b3..597df5ebc0a582018d30c018e734d1154c364ed6 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging with manual conflict resolution'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with different kinds of conflicts
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index ce4144db0f24c7bd9ccbbe30575118b565bb4486..5b675417e9bbf9d21cac561473c90622b08def5a 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging at various fanout levels'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 verify_notes () {
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 0fd33280cf91f7fe9384205df8b7570363a37076..96243b722224209e33fcc88fea10bd600852b377 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -8,7 +8,6 @@ test_description='Test merging of notes trees in multiple worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commit' '
diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index beca34605672d407244b26ebcffb1f70527f5915..c4a7839540a99e047a99908d776d1aecd641146c 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -5,7 +5,6 @@
 
 test_description='Test commit notes with stripspace behavior'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 MULTI_LF="$LF$LF$LF"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09f230eefb2cbc03a6b8f85e0f5c39cfcb2467d5..bab675938a3e06dc632bb7a9dcd1dac65f0c21e9 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -11,7 +11,6 @@ among other things.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_NAME=author@name
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 328c1d3a3f45bcf2a2c153c94556d0b56fb5bbce..f18bae94507587a4dc9118cc3d508902e02c6bc1 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase + directory rename tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 5c67d07ba3ecf6333d1967c341d9bfb75fc33769..761de63b6b982286c3ecb0c821d38920d0be7bf6 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -8,7 +8,6 @@ test_description='git rebase --merge test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 T="A quick brown fox
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 4f1d6e8ea642e1a2f6b624ad333385e11036dcba..a1911c4a9d60e71f99d66ef6d7f30728ab8732df 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -8,7 +8,6 @@ test_description='git rebase --merge --skip tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 77cceda14a024b5144b426b66c41961beef935e7..b11f04eb3349b7fe489ef99996d972902ef45711 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,7 +26,6 @@ Initial setup:
  touch file "conflict".
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 8979bc340734f860f56c49a4380366dca1d46ee8..2524331861869d6b9ee9f80082c09d2ed089e8fe 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -5,7 +5,6 @@ test_description='rebase should handle arbitrary git message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 82108b67e67c18230c385dfef03f7bdee37f9eb2..a1d7fa7f7c6965f49cc017303aca52a658211b10 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,7 +5,6 @@ test_description='messages from rebase operation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2c3f38d45a848260995967cfce91a38cacfe82ee..9f49c4228b629589d7bfcf3435fda8e7c4b308be 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -5,7 +5,6 @@ test_description='git rebase --abort tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 7b4607d72f2748df9d0800a5e471e4af1d6ae32a..cde3562e3a64f756544763107d9c607eaa4f38ca 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -5,7 +5,6 @@ test_description='rebasing a commit with multi-line first paragraph.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
index acaf5558dbe2e445efe2989e137b2f9ef5140aaf..83ffb39d9ffdfd869ecb24e5adbbe11944a73c53 100755
--- a/t/t3409-rebase-environ.sh
+++ b/t/t3409-rebase-environ.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase interactive environment'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index e75b3d0e07cb13b5d8b4fd3b83b07c35eeddce49..58371d8a5477f47d53384a84ad0dae14457128d9 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -7,7 +7,6 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 log_with_names () {
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 426ff098e1dc738a57299a6499bf89174979db37..b4ff614987ed6270dc836f34a6e921bc8bb9b1d3 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -5,7 +5,6 @@ test_description='git rebase with its hook(s)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 22452ff84cb339936cf2efcb1b4147655943eeff..fcc40d6fe1fd5b2a9c4f2a5e4ede15e73c247790 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -5,7 +5,6 @@ test_description='auto squash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index f8c4ed78c9ef7ffd0fa970525bf3cab47842b55a..ea501f2b42b8cc43394192d11051992605bfb619 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -5,7 +5,6 @@ test_description='git rebase --onto A...B'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index 22ee3a204598cfed88dead7f00f7de548c94cb85..96f2cf22fafd4795e54928b14b5c2b4b2333e8f3 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -5,7 +5,6 @@ test_description='git rebase --whitespace=fix
 This test runs git rebase --whitespace=fix and make sure that it works.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # prepare initial revision of "file" with a blank line at the end
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index c0d29c2154f0b4eff481352fd1acb0bb1f3c2331..127216f7225aa412022bb0f296f716c42ce15f56 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -5,7 +5,6 @@ test_description='git rebase --continue tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 6c61f240cf9874bbdb0190739b66a1c0ed99289f..7181f176b8136504b4a9bc5e962cf358b00ffbba 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -5,7 +5,6 @@ test_description='git rebase - test patch id computation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 scramble () {
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b43046b3b0dfb89740692a16f0e365d091590657..ad3ba6a9848f8a940a71cba1e11579d0e831a209 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -7,7 +7,6 @@ test_description='git rebase --autostash tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 737af80bb3dbb205346a3b6ccedf6cbb34fbfab2..f5b7807abd089d05a009aea8e67c2a04b1d4f736 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -2,7 +2,6 @@
 
 test_description='basic rebase topology tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index b40f26250b7e3d8ce95b149589822bd57d84dbbe..b9408f9ba1285f404f148e7f9cade54affed2f0a 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -2,7 +2,6 @@
 
 test_description='test if rebase detects and aborts on incompatible options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
index 2fab703d615485020f0692bdc2d39748ba0f72d4..4859bb8f722314df2fdb67aa51a4419009ce22ec 100755
--- a/t/t3423-rebase-reword.sh
+++ b/t/t3423-rebase-reword.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase interactive with rewording'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 515c949ae37269d056e9bf5b0fb88f409eba5c02..1ee6b00fd57726e055b95903e09f97c1e24ebcd2 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase of commits that start or become empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup test repository' '
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index a16428bdf54ab9157dfefb7cc9797e4c5dd86e1e..675491234a6155f6a3b09701d96ac048d648648c 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase topology tests with merges'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 94ea88e384e6219c7d47c6c9fb8409640623680d..ba069dccbdf56197b0e93831fdb1316853d54ef4 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 5e9046e3df3d5262c2845d190476b9d9bc56873e..1b3e97c8755f3d8b41549e70cf67529298118182 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -7,7 +7,6 @@ This test runs git rebase and tests the subtree strategy.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 365436ebfc36415333d01bd231f7f89e5223477d..6f57aed9fac68f1b5d670b2e3c35bcc84690a525 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,7 +5,6 @@ test_description='git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 8e0d03969a2fec13fba015158b3380ec2ee37c42..abd66f360213e18ad80b1c7bb2396b06d3e77b28 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase should reread the todo file if an exec modifies it'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index cb891eeb5fd112bf94e31a2158a5dce7990e36e2..2593711fecdc9f18c1b83b8d921ae06fbd2495ac 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -21,7 +21,6 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 7b9c135c6e2766ceff9d99e188ab92ab6a7cdc62..be09fc78c16aab1fe525daeaa1348a9db5cec9a6 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -8,7 +8,6 @@ test_description='git rebase --fork-point test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---E    (main)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 7f1a5dd3deb10bef921654ef767a7cd53347bfd8..5086e14c02207184bd7c048ee2bc2419ad4d1b34 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -8,7 +8,6 @@ test_description='ensure rebase fast-forwards commits when possible'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
index c8172b0852233b6f370eab47c6cc4877db54d8f7..05df964670f49d011bf35b414177a35f812a4c4e 100755
--- a/t/t3433-rebase-across-mode-change.sh
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase across mode change'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 97fc9a23f21f9b02b0b6e0e132dd56dbe82eafcb..8c94fdffc43044b18f15605bc43c8014c021bb3b 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -17,7 +17,6 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6e329fea7c0fac0482e363a3d297134c942e256a..6aa2aeb628d0eda991ee16760985f9017dceebb1 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -8,7 +8,6 @@ test_description='test rebase --[no-]gpg-sign'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 4d9744e5fc7ade70fc4cf2b7a594d1b0513e0f58..94671d3c4650463525006090702210eda76594e0 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -5,7 +5,6 @@
 
 test_description='tests to ensure compatibility between am and interactive backends'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 7929e2e2e3a8fc1240af3991f85172c16dcbd2cf..6f9307e0e3cdfe8903b5a77229b2439d375b51b2 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -14,7 +14,6 @@ to the "fixup" command that works with "fixup!", "fixup -C" works with
 "amend!" upon --autosquash.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index 821f08e5afb6983cf8f69abc525a54b6274885e6..78d42f4c799f144caabcc2b0e5f04e82122beb02 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase behavior when on-disk files are broken'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up conflicting branches' '
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 61ca87512d59dcc37a831619cb6691af97fa7d25..78c3eac54b599ef9cded9a042f4346621798b645 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -11,7 +11,6 @@ checks that git cherry only returns the second patch in the local branch
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_EMAIL=bogus_email_address
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 411027fb58c7dfb657409980970e71005f2c79c5..17a993796254501a2dd3d35a08c1bd00594a61c9 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -5,7 +5,6 @@ test_description='miscellaneous basic tests for cherry-pick and revert'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 1b2c0d6aca64e05a85ffd6568be17bb5897a297e..5495eacfec11a904ba24d69439cb1b98b5a353ec 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -11,7 +11,6 @@ test_description='cherry picking and reverting a merge
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 76d393dc8a307ebef13dfab5e4eb3d88a7a7cd69..95fe4feaeee98f6432b39ee3a4817f05da5d649b 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking (and reverting) a root commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 109016eba92ac8d296edfbaf28ecf9b1a4fc32f7..18aeba161c0ae4821e0496269ed251763c245e6b 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick should rerere for conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index ead3fb46807ef33427172dde75a45f5cfa01bfb0..9748443530cd713c8c9d06e6eaa67552a69e978b 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking an empty commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index b71bad17b853c566caac5828c19453da9c862647..7e11bd4a4c5c41c9e326244f598bdc9bb4e4e3ba 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking with --ff option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 10e9c91dbbd0f0f2655a5f35c769ba2fa5a10444..f3947b400a3a89970e400d3c3f5dc5d690292d83 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -13,7 +13,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index afa7727a4af8e489b8b3f36213a15ed83dc9e561..2d53ce754c5fb75ceeaa43dc1ba2f748fd58f43e 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking many commits'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_head_differs_from() {
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 171cc6d76b797c99638bda0d63083aecfd7a5a2d..f4159246e1e35d615bca2191393ea19427088dc0 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -4,7 +4,6 @@ test_description='Test cherry-pick with directory/file conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'Initialize repository' '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 93c725bac3cb3edd9fdaab7f0ecf9985fd7f848e..7eb52b12edc55702f48812725bfddc282297f9a5 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,7 +12,6 @@ test_description='Test cherry-pick continuation features
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Repeat first match 10 times
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index dd5d92ef302124aeb9d6fe02642489875a9e1b22..84a587daf3af0356244c58c6472e202875679200 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -2,7 +2,6 @@
 
 test_description='Test cherry-pick -x and -s'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 9387a22a9e7100335208713fcb069b31c69f7e80..f22d1ddead1ac94de714f61fc10b87cc4bae3aec 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick can handle submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index e178968b408f4b9068bcc07055ffacf781154181..8bfe3ed2467fa17d9f1910cd76c721c73776d4ab 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='revert can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3514-cherry-pick-revert-gpg.sh b/t/t3514-cherry-pick-revert-gpg.sh
index 133dc072178a161a33b05ca02f8872b5286a943a..5b2e250eaa509458d89d13f4a3728276525fa746 100755
--- a/t/t3514-cherry-pick-revert-gpg.sh
+++ b/t/t3514-cherry-pick-revert-gpg.sh
@@ -5,7 +5,6 @@
 
 test_description='test {cherry-pick,revert} --[no-]gpg-sign'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 31ac31d4bcd3bbef54f10234cb5c437d3f97fc35..98259e2adaa9dba9fa6bbcb79e50948e69a6b9e6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,7 +8,6 @@ test_description='Test of the various options to git rm.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index 7cef12981c4be0b611f70fe021d5960f1ad4e5a8..31bd9960fcde39a6d30095f05320a4e3d1fb1c9c 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='rm --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index fcdefba48cc76b9a86c8136342c828e30cd9e811..08580fd3dccb73bea98c787271ba49c362a55b6b 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git rm in sparse checked out working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 12bd3db4cb74635ff1a939c80897e9fb98a208a7..389670262e458eadb7029251aa44b52be8ae5350 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -5,7 +5,6 @@ test_description='basic git replay tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_NAME=author@name
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 839c904745a2861487e04363060a951aaeb902c9..4c543a1a7e8f416acf58ac32ddf2b7394f159abd 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -5,7 +5,6 @@
 
 test_description='Test of git add, including the -- option.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-unique-files.sh
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 718438ffc7d2a8d3482544378749b0d4dfe6313b..b8a05d95f3f1304ac82618d8847cad026c6c44f4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,7 +4,6 @@ test_description='add -i basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 82bfb2fd2aca9eae78af33fa67620e76458b3ac6..8bacacbac6807c1ddab20aeca87ac34dbdd05bfb 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -5,7 +5,6 @@
 
 test_description='add -e basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index d84071038e051552f5676c5c687e4e5e2646a39a..3ef525a559d91b115a3dbe4a1373c8c51fb1fc98 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -2,7 +2,6 @@
 
 test_description='magic pathspec tests using git-add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 3aa59f6f639b5bfc79ab048f594cb2512755be73..b9c96e273fb71af8b4ee3cf376a53433d3fea5d7 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='add --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6ae45a788d1a97e04bf504a25efbd98a6ab5e41a..2bade9e804fcfc74df7d5629bbd409fda1c4a302 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git add in sparse checked out working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SPARSE_ENTRY_BLOB=""
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d3e428ff46eb5c99d98a8fe27b54cf98d6d2a936..e3cf0ffbe59c449b218cafedd74bd3cf07e82ff1 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,7 +4,6 @@
 
 test_description='git mktag: tag object verify test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 9d4b5ab1f9520f3892a32e17239ae6cb34184269..3c930ec202d682d26b76a90b3ba80e3574331e19 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,7 +5,6 @@
 
 test_description='commit and log output encodings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index e0659c92935e7f7582e03fd1121df7488e0e2b4a..f03601b49a93970eeb0d0393f9979fc71dbe9ce1 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,7 +8,6 @@ test_description='i18n settings and format-patch | am pipe'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 72a5a565e973ad634ecfa4418d8934d3c7b85ae1..f528008c363c68f40da3b88a34ae8ec931d0c1ac 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -5,7 +5,6 @@
 
 test_description='quoted output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 FN='濱野'
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index c87592ee2f39fe3568fe98955d0df24bd2180f68..74666ff3e4b2b8fa5aa9651e85dc7c82621bd304 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -8,7 +8,6 @@ test_description='Test git stash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-unique-files.sh
 
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index aa5019fd6c3d59cc4f3ad870607c7e6e531e628b..ae313e3c705e460f2f905e4cbdd25b694f0417a0 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='stash -p'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index a1733f45c3aa13e642fe7aeb808391dbd10e6fab..1289ae3e07c635d30930067022969247b2b63f1f 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git stash --include-untracked'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'stash save --include-untracked some dirty working directory' '
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 0f61f01ef43b2c889bd2850fbd41c4a42f52c6e6..0f7348ec21b8821cb6b7594919bbc637ec0a7236 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='stash can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
index 7a2eb98b86426ea7657fdce73cb8c0cb3a6d2848..10914bba7b3737ea89af320f93371e44b4694a11 100755
--- a/t/t3907-stash-show-config.sh
+++ b/t/t3907-stash-show-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git stash show configuration.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
index 347a89b030b68dc87ecea8f40dfe9d1b0ca8db16..2b2b366ef94b7ca429416d81cc4858201658d3cb 100755
--- a/t/t3908-stash-in-worktree.sh
+++ b/t/t3908-stash-in-worktree.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git stash in a worktree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 83269d0eb4cc42f21f58cb77043aae97f8644f94..73f2dbdeb022ee71d04e9961da959f60d6eabd5c 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='stash --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 31877f00c77d81da8847164228a9ac58573a850d..e2e1251a057f245eebcfd0fecebec712aef48694 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -2,7 +2,6 @@
 
 test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 LIB_CRLF_BRANCHES=""
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 8d50331b8c8e431853bbdf377813ed288007961b..a51f881b1c9ee0751c845510049fafac35dc00b1 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -10,7 +10,6 @@ same command line parser, so testing one should be sufficient; pick
 diff-files as a representative.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index cd1931dd555702f68078fc62a91887a374bd3572..4f520d600de49555787a0c6a42917d364ede3170 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -5,7 +5,6 @@
 
 test_description='Test rename detection in diff engine.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index cb3307010c1ed97f1b7bdb91b366f3e6d17a2ac9..e44648e6f3d9ff28344da18cba3a81388fa8ecbf 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -7,7 +7,6 @@ test_description='Test diff raw-output.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index ebe091828c878eb2d3ea3ab6f0f2e371e4d34329..fd4faee5d252c524c2cd233860e7537f704c6946 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -7,7 +7,6 @@ test_description='More rename detection
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 1d70d4d221b7536c430852e9014c9372743a4a2a..faf3465deb48a170a93b5e7fb6f2940cee60e453 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -10,7 +10,6 @@ copy of symbolic links, but should not produce rename/copy followed
 by an edit for them.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 5c756dc24358cfe28219d2097b96f3655a9e13f0..92d1141fbe08e15a0aadba6aa30546ff57dbc1ff 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -6,7 +6,6 @@
 test_description='Same rename detection as t4003 but testing diff-raw.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index dbd4c0da213eb441bdd0ffb6d87748ce1e0de17c..2299b91fc4b3cda943561b717bdb081d9fa807aa 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -7,7 +7,6 @@ test_description='Test mode change diffs.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sed_script='s/\(:100644 100755\) \('"$OID_REGEX"'\) \2 /\1 X X /'
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index b86165cbac5970fda7b169f80edea8deea5ccf12..e8faf0dd2ef1c5e0dc3aebe19276843d62a658e5 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -7,7 +7,6 @@ test_description='Rename interaction with pathspec.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index b0ef0026e089ca0b410d0eab1fd45508ddfbe515..c187c52dab20e2fc632352f98f03e807bca3f07c 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -22,7 +22,6 @@ With -B, this should be detected as two complete rewrites.
 Further, with -B and -M together, these should turn into two renames.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 3480781dabf30aca2a01c40a1ab34eb1e075eccc..59e71e3acdea54852fd1661d9e09e831f01b0cdf 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -7,7 +7,6 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 9d9650eba7e9774963b941fe8ebf82925af14ec9..c84c3fa05b218eac69a325f529c759f71312aa76 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -10,7 +10,6 @@ Prepare:
         path1/file1
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index bc8ba887191fac4fd602fe5c2406f3e66a4becfa..ac837b6c9ecd7b533930d0e4311f3d4c9eef31f6 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -7,7 +7,6 @@ test_description='Test diff of symlinks.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index c64d9d2f405e1e43a2247d91ca0a1a35af7fbad4..d1d30ac2a9474eb6310f3249f20bd2cc56c562dc 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -6,7 +6,6 @@
 test_description='Binary diff and apply
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.binary-numstat <<\EOF
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87d248d0347ae0b8e37bac315a9bb84aa4e225ec..3855d68dbc0a64797ddbd665e675aa3d1549defc 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,7 +8,6 @@ test_description='Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1c46e963e4326b281e7e5912d70d04c564774dde..884f83fb8a45fe927f6763342a3e1b8a8a04c624 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -8,7 +8,6 @@ test_description='various format-patch tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 851cfe4f32cd8d906a91b848443c9c27db1b6e69..52e3e476ffa5a956e01eb2eb606130d54cd098ab 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -7,7 +7,6 @@ test_description='Test special whitespace in diff engine.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 5a8d8876831657d93837fe3ccfad141f15119ec9..876271d6826cca4fea73e8cdb459e6983db5b209 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -6,7 +6,6 @@
 test_description='Quoting paths in diff output.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 P0='pathname'
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 1cea73ef5a31a5c6d316f8bb51fd87e478a7a87d..c2863c99b71face2542e773df110e4c09a0e3837 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -5,7 +5,6 @@ test_description='Return value of diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 8128c30e7f2c6517a5ca0cf03cd22c1693978a5d..e026fac1f4090330f81b5b417e1b9e930795fd96 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -5,7 +5,6 @@
 
 test_description='Test custom diff function name patterns'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index d2b3109c2d37445f2f3cf9b892df67f7519191ff..4001dacee39193142d7a8d66c752ccec67be1224 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -2,7 +2,6 @@
 
 test_description='diff whitespace error detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0e5a05894fd1a1be1098b6895283452ca877137c..f1efe482a5942752f514869e953ddc5280ea8f62 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -2,7 +2,6 @@
 
 test_description='external diff interface test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 1219aa226dc7259172dba38da3f7354870e0929b..9be65fd4440a68af70e6630c8ded872d7be41f5d 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,7 +5,6 @@
 
 test_description='Format-patch numbering options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 77bc36d5d8fd983dcbe82577593e2fdaeb946925..6fed993ea0b34dddae94356354c889ada9f16497 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -2,7 +2,6 @@
 
 test_description='rewrite diff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index e6f4fe441e1b0dc8516d930250cba1121fc46251..787605ce3fd076b101d1c825fca174020ae7ff46 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -2,7 +2,6 @@
 
 test_description='typechange rename detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index e2f0eca4af065071a3ea5096e259212557aa4491..b98ac0a0c039c048a3f6413c4389617396b8fe26 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -2,7 +2,6 @@
 
 test_description='common tail optimization'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 z=zzzzzzzz ;# 8
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 5397cb7d42d748054eb5a244415c2f5062e3eca2..c39bb07a417a5d91decdded8c82471282bd1899d 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -2,7 +2,6 @@
 
 test_description='diff hunk header truncation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 N='日本語'
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index b05f2a9b6075d0de8235919a30c0e9066f562542..08f6805e1c87c953097a681e082f312c9d37a008 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -5,7 +5,6 @@
 
 test_description='Test diff/status color escape codes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ESC=$(printf '\033')
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 40164ae07d2c06d9ef5fc67b16e5ad8421b2875e..295da987cce5c8141b96d35944b73fb3f86f7e64 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='difference in submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 60cb819c42e4bc3b5fcc2a771b1b4bb876674cff..a06a7479260fa951919c18682a25079beb1f031c 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -2,7 +2,6 @@
 
 test_description='format-patch mime headers and extra headers do not conflict'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 5f8ffef74b6474c9fb97e18cd6c48d449fa26734..32b6e9a4e76217d8de771b405dd3ce57c73643ad 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -4,7 +4,6 @@
 #
 test_description='diff honors config option, diff.suppressBlankEmpty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat <<\EOF >expected ||
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 29f6d610c2e61bc80a7b9fa64f8212d6f2a9384d..daebf9796f595bdf49159668ccc44b46d59172cd 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='diff.*.textconv tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_diff() {
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 1b8cd3e4c97dd8bd91be46f6141e4f87c5b01689..c4394a27b56236aeda3c92df03aa19f9d8720190 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -2,7 +2,6 @@
 
 test_description='rewrite diff on binary file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We must be large enough to meet the MINIMUM_BREAK_SIZE
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index 7db92d0d9f461aca48fb4ebf014cd03cb1401a1c..bada0cbd32f76418a76702fbbd5143004876d074 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -2,7 +2,6 @@
 
 test_description='diff hunk fusing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 f() {
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index f7be7f5ef0139b8384746518c676d80cb88dd5dd..113304dc596034ff9bfaac65b2ff896b6a181dca 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -2,7 +2,6 @@
 
 test_description='patience diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 4dcd7e99250ed1d3a34fa5f9176128a6cce68e66..f51d3557f101cf515f620d58e9284f0f06890022 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -2,7 +2,6 @@
 
 test_description='word diff colors'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 76f8034c60fabe2cbd1ea45610e1ce3137755b0d..0352bf81a90a38adf14fb7a980c98600e1f650b2 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -2,7 +2,6 @@
 
 test_description='Return value of diffs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 48655bcc789eef6f08896b064440ea25a36c6e47..98d9713d8b2454eb1dfc4f137133a7cb0174bd0d 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,7 +2,6 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
index b5f96fe23bd214f15ac66c1cac0291cfb1b73e58..f5ce3b29a2ac753470b51bb494ca3836ffc21b11 100755
--- a/t/t4037-diff-r-t-dirs.sh
+++ b/t/t4037-diff-r-t-dirs.sh
@@ -2,7 +2,6 @@
 
 test_description='diff -r -t shows directory additions and deletions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 00190802d831f032fd936b3fe11ad5661dfb6ca5..2ce26e585c98c1a3045dee4545763f160f59aa82 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -5,7 +5,6 @@ test_description='combined diff'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 78090e6852d5a8362e53414a1b4fc3302a24d874..0eb0314a8b35daecd3a442592bac4de1c480ffe0 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -2,7 +2,6 @@
 
 test_description='diff with assume-unchanged entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # external diff has been tested in t4020-diff-external.sh
diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index eec3d73dc2b475be7185d9d1dc8733bf391a868b..1b27a0e3813cc86f0cad436ad2540b15feb9daa9 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --exit-code with whitespace'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index aa149e0085ec991046b1a56e21444fbc89a69de0..28f9d83d4c1c34bd9d968a18cb4ab48d6a13c1f6 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -12,7 +12,6 @@ This test tries to verify the sanity of the --submodule option of git diff.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test non-UTF-8 encoding in case iconv is available.
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index a179205394d8a33b4ab7be0d7e700739448a5597..ff0e73531b90ed857e729382b41a60401302e34d 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -2,7 +2,6 @@
 
 test_description='test textconv caching'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary.sh
index e4864939081a8c7da1f4e9b6d8e0a3a72ba0a657..2a2cf91352037b6f2c238237474aa1d78928f5ad 100755
--- a/t/t4043-diff-rename-binary.sh
+++ b/t/t4043-diff-rename-binary.sh
@@ -5,7 +5,6 @@
 
 test_description='Move a binary file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index 9f6043dabaccdcbbaecccf2b2f0248ca132c946e..8400bfbd3c7e0e6b0706ce278f753170895c84f6 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -2,7 +2,6 @@
 
 test_description='test unique sha1 abbreviation on "index from..to" line'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 9b46c4c1befece1f3e231b9672291b7a538c3f6f..2c8493fe66c441b23d11c8ed1048d3a92e3937e8 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --relative tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index afda629c98137f236371dc100410996632f7a52b..7c27f053663fb751f00be5cd2e34936d3fc068b0 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -2,7 +2,6 @@
 
 test_description='diff with unmerged index entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 7b73462d53d2c12def254e80a9d7c90e19f68794..a7ce8d3161bb13e8e00524446f2af047c6e19542 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --dirstat tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # set up two commits where the second commit has these files
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index f399484bcef623204d44e3915b99f2de48ff95ae..0260cf64f5d5507eb53fde74fba88d9d3a9ab3b4 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -4,7 +4,6 @@ test_description='combined and merge diff handle binary files and textconv'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup binary merge conflict' '
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 0a4fc735d44ad525f0924b86e355d4a257650a62..eceb47c8594416457e4dc757ecd9ded71589c935 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -3,7 +3,6 @@
 
 test_description='diff --stat-count'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4050-diff-histogram.sh b/t/t4050-diff-histogram.sh
index c61b30f96daf57a9c7f3185bdd8ea3c4aeb9dbe3..fd3e86a74f3d92d837e2557236776400687f7a5d 100755
--- a/t/t4050-diff-histogram.sh
+++ b/t/t4050-diff-histogram.sh
@@ -2,7 +2,6 @@
 
 test_description='histogram diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 725278ad19c720468113659dbcc63aa013ac7de0..4838a1df8b4369dc5024cdd7929d851b76482805 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -2,7 +2,6 @@
 
 test_description='diff function context'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dir="$TEST_DIRECTORY/t4051"
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 7badd72488d664ff776e1004f620df1fbc774cdc..740bb9709181abc1db25e7020953e42046d1e2bd 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -8,7 +8,6 @@ test_description='test --stat output of various commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 651ec776606bb0990edc40bebf13ccc4937bb0ce..5e5bad61ca1ed8098dacd3e5573f192adc44ef06 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --no-index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 05c88f8cdf01d98b61eacff08b32cb57320e7d3b..1131431fe0e3ceb9ed99d1001af287d41a999670 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='test diff with a bogus tree containing the null sha1'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create bogus tree' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 3ea9ae99e04b9304e4dd8014eed9b01795317a31..f7ff234cf9366eb04225a64093db27f5cb0e8c1e 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -5,7 +5,6 @@
 
 test_description='diff.context configuration'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 32c5fcb9a27c2e0156ec5db3adadc038468f2ee4..aec1d9d1b42f65f1080f7e054bca70bbffcefcc6 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -5,7 +5,6 @@ test_description='diff order & rotate'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_files () {
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 9a7505cbb8bf900510e8be4fc1a636124deec366..04b8a1542a8ec3ad2ffc28964f21940d034c2ed6 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -5,7 +5,6 @@ test_description='combined diff show only paths that are different to all parent
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # verify that diffc.expect matches output of
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 18e5ac88c31174969c1762c5e93c46b618f7d1db..2fce4a98977b71de88448f07ea8dbcd8e110c649 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -11,7 +11,6 @@
 
 test_description='test tree diff when trees have duplicate entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # make_tree_entry <mode> <mode> <sha1>
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 28fd3cdb154e28d3183dcc13e8eec047c51bbecc..0fe81056d5be685a53f3c218d733765678e1264c 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -9,7 +9,6 @@ This test tries to verify that add_submodule_odb works when the submodule was
 initialized previously but the checkout has since been removed.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 918334fa4c84bb572b82f709612feabca9005dbe..76b83101d3b7b6b7942c30c8b1f204f201027666 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -10,7 +10,6 @@ test_description='Support for diff format verbose submodule difference in git di
 This test tries to verify the sanity of --submodule=diff option of git diff.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test non-UTF-8 encoding in case iconv is available.
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2942e5d9b93899bf7bc517e95c94788dbca1d18f..7750b87ca16ab39aa965caa4fe71b462d899adc7 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -6,7 +6,6 @@ test_description='Test diff indent heuristic.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index a90b46b678ca35a6af71769149bcfa7cc2317a39..8ad3d7995792301d56d37eba5f78fe576cb4856d 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -5,7 +5,6 @@
 
 test_description='Pickaxe options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 7e6c9d638433caca632d0d6d6dbdbc8c1bd98ec8..50fdb5ea52923489fd96b95565cb322b56e3c205 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -2,7 +2,6 @@
 
 test_description='test direct comparison of blobs via git-diff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 run_diff () {
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 846f285f772e53abd13adce7add205d0a59c8d1f..e86bba679e516daa3db2ff387115782b10ffff4e 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -2,7 +2,6 @@
 
 test_description='test finding specific blobs in the revision walking'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index 647537c12ea99db2594b1e29aa2c68027055d611..b3f510f040ec3b955ff53c3de81ffc5a60ad3862 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,7 +2,6 @@
 
 test_description='anchored diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '--anchored' '
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index 0ecb3915412fcd70a62dc9acfba3054240767177..a1de63b77f8b41ba0513f626d196129cf3ea4f09 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -4,7 +4,6 @@ test_description='test combined/stat/moved interaction'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test covers a weird 3-way interaction between "--cc -p", which will run
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 7af3a08862dec8a17b113191a3dbea56b0995cd3..581250dd2d227adfdc323bdc6211c3073665b259 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='behavior of diff when reading objects in a partial clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git show batches blobs' '
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 4d6565e728bccd1bb284769cef2a1b05e6f2b622..eff63c16b064d124b59a2e4b310e3ce5e190c532 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,7 +5,6 @@ test_description='behavior of diff with symmetric-diff setups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # build these situations:
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index df342850a0d4209bfb8c7f4c6272f609d3d65069..ca8f999caba54db646a81f99b7df519ee676197e 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@
 
 test_description='remerge-diff handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index d503547732c54d8f952027580dc21a6b65729cdb..146e73d8f55418d308ad9c5dff23ae9b4a8c299d 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -7,7 +7,6 @@ test_description='git apply --stat --summary test, with --recount
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 UNC='s/^\(@@ -[1-9][0-9]*\),[0-9]* \(+[1-9][0-9]*\),[0-9]* @@/\1,999 \2,999 @@/'
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index b1169193ef5d53e06302b01b9a54ad7ed165232c..4df74baa24955a95262abb874b4f4a49fdcc3335 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -7,7 +7,6 @@ test_description='git apply should handle files with incomplete lines.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index d1e06fc1ac41354d9a50d6db76663f0b9ff3e698..e42a31c9179dfefadc2130bede541c4df874f7d8 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -7,7 +7,6 @@ test_description='git apply handling copy/rename patch.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 144619ab873f5d55ff52e5324d15ab9921941856..d370ecfe0d9eea752d81d02f50f5739bfc923b04 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -9,7 +9,6 @@ test_description='git apply handling binary patches
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index dc501aac387b26aa344564dfb38f179f4601546c..71ef4132d153b7be4b4f3d4ebfb1a85ee4bfa9ab 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply boundary tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 L="c d e f g h i j k l m n o p q r s t u v w x"
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
index ed814a839e679d4b394cd88729da8921e0a19b14..b59785166d49a3432588d5abc2e4e9cbfe0a619b 100755
--- a/t/t4105-apply-fuzz.sh
+++ b/t/t4105-apply-fuzz.sh
@@ -3,7 +3,6 @@
 test_description='apply with fuzz and offset'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dotest () {
diff --git a/t/t4106-apply-stdin.sh b/t/t4106-apply-stdin.sh
index 5c150f3b0b23913ac9b515820431a5651a1b8726..aa2fff7afa72a5af9feb102736656258ebb1861c 100755
--- a/t/t4106-apply-stdin.sh
+++ b/t/t4106-apply-stdin.sh
@@ -3,7 +3,6 @@
 test_description='git apply --numstat - <patch'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index 5e6e203aa521ea63c7deb3da98d4d3bce37dd736..94ba6dd4e00966a49db0e4fc476cfa0d233f0640 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -5,7 +5,6 @@
 
 test_description='git-apply --ignore-whitespace.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This primes main.c file that indents without using HT at all.
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c6302163d848a7add7e1f8f1d3d060bce515f738..f30e85659dbb87950b9ab9c005cd8d35e15f4ad2 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,7 +5,6 @@ test_description='git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 print_sanitized_conflicted_diff () {
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index 4dc6d8e7d3c8bb834fda0e777e3083283df00033..ac523a5d5622eab429023d5ef35edac2ad2fdf12 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -7,7 +7,6 @@
 test_description='git apply test patches with multiple fragments.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cp "$TEST_DIRECTORY/t4109/patch1.patch" .
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index 266302a1829da4a0e289987c7d572a0fb9cdbc73..cc17ff2ab9ac09e1480feb60a98e8e7e1c024630 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -8,7 +8,6 @@ test_description='git apply test for patches which require scanning forwards and
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git apply scan' '
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index e9a87d761d168323ada1e58ecd9df719cc7511b3..1618a6dbc7c718677cf669b5f6fc96f2682992fb 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -2,7 +2,6 @@
 
 test_description='patching from inconvenient places'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4112-apply-renames.sh b/t/t4112-apply-renames.sh
index d53aa4222ea3c1405247e07d62fc8efed83daa5d..bb5d529bec1ab2fc2f7c3ff52a1d575a4d2a5ed6 100755
--- a/t/t4112-apply-renames.sh
+++ b/t/t4112-apply-renames.sh
@@ -8,7 +8,6 @@ test_description='git apply should not get confused with rename/copy.
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 2c65c6a16960a0429764ac628aab001fd14ed2f3..66fa51591eb7ee8f102fd86e30e54af2da3ea310 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -6,7 +6,6 @@
 test_description='git apply trying to add an ending line.
 
 '
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 8ff364076673747adaaa74aec3f0a966caf033e5..da3e64f8110d54d7243c017a9a614baa7098142f 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -7,7 +7,6 @@ test_description='git apply should not get confused with type changes.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repository and commits' '
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index cbef0a593fb7ccfded7b9e97735c41dda0ce1cbd..769b0e4f9df06b2d2d1c10555eb5d89f237de0ef 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -7,7 +7,6 @@ test_description='git apply symlinks and partial files
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index a9f4ddda6c3bd650634219968ecec92e5247cff7..0784ba033a4e5a5a6d8d8eaabb0736401aaaf730 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -8,7 +8,6 @@ test_description='git apply in reverse
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index 4d15ccd28ecb27b47041cbaab412f1f1b93a91bf..c86d05a96fe8d5c7a561028c8dad452f89eb6876 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -7,7 +7,6 @@ test_description='git apply with rejects
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 69c9c48e72b4930b3ee21887c33122468f43be4a..c1dcbd7d356449bf1858c100756961cd3a9cee72 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -8,7 +8,6 @@ test_description='git apply with new style GNU diff with empty context
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 208c961d376b28035e3e7c9563199f9c5867cf11..f3b43e221627a7e26871e66486f6054be319719e 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -8,7 +8,6 @@ test_description='git apply --whitespace=strip and configuration file.
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index f7884285400f505082c2a92fe80854c9f2768730..697e86c0ff456028948a769f2b6ccfa66bee2dc2 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply -p handling.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d1193be70416eb46257d5ba6fcea30952..b45454aaf4bfe684ad3099db20b36ad57be2421b 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -4,7 +4,6 @@ test_description='git apply for contextually independent diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo '1
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 2089d84f64577b2b0ac6fdd762cfec8bd259c96c..3340ab4370c77a001083779ce069a93c26595494 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,7 +4,6 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 3601c0c5dca5aa4ac364d19ce1a96f50748cc723..3ef84619f53e27ddc164d74c07c0a38721dedfdf 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,7 +2,6 @@
 
 test_description='apply a patch that is larger than the preimage'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index cdffee0273c9ffa7e1302497777cf9bee6651a22..485c7d2d124ade54d00f8752399be91f43eefbc8 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -2,7 +2,6 @@
 
 test_description='core.whitespace rules and git apply'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_test_file () {
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index f248cc2a0084d546285961d12871f78dbe7efd63..090987c89b24b4795bcb80c0461e5c90f3fe5b3b 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -2,7 +2,6 @@
 
 test_description='applying patch that has broken whitespaces in context'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 56210b5609919dbd625cfe12c49ab7e858534896..eff783f8d683a693e8dfcea0908d0d5363ec9d0d 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='apply empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index aa5cfae2b681c0a73d9e09493c8cdcbb6a273f87..bd516c4aad757b00ab006804c2802131256bc9fe 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -3,7 +3,6 @@
 test_description='apply same filename'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index ed94c90204e9c2eab135a1c2dcdeb15cf33e214c..f6db5a79dd9d356c93a935374c4c27520ecf6593 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -2,7 +2,6 @@
 
 test_description='apply same filename'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 87ffd2b8e1a3d3b3f69c8849e8a153362f77ad1a..2149ad5da44cdeb544ec0bc7642e1c3147870f38 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -3,7 +3,6 @@
 test_description='applying patch with mode bits'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index f3ea63274258c664fd612dc314e205b9804cc13c..211ef1c7e78e8fa37fba5c0a1fda5d2ba67244c9 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply handling criss-cross rename patch.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_file() {
diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index 40c92115a66e83593ef4f9dcb879a0eabe1e625a..b1361ce54693a07486f5837b0fe477f828b80a4e 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply --build-fake-ancestor handling.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index c1e3049c041b849f4b8c1d1322a44ea77fd96845..ab1628d27d0a3158c50d266a9eee1ed8ed2c73b6 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -5,7 +5,6 @@
 test_description='git-apply notices removal patches generated by GNU diff'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index c21ddb29466ec46b3441313ada2c36b3173067b7..3cab1038cf56480bb6e92d35992b2627244e7369 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -6,7 +6,6 @@
 test_description='git apply filename consistency check'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index aceb4c42b0ffc7e20a0a9cc07843a953e703b269..8cea75cf7bc23051f0ddd3f3a1a3d5091f6fb3c4 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -6,7 +6,6 @@
 test_description='git apply submodule tests'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index d3502c6fddf5a6a69bde769b1f808c9431d1e38e..6bc3fb97a754bf242f8baf1ba867aa9f7fa93d0d 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply with weird postimage filenames'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index dfec1c5f0f63fca3b0f0f47d2296be93c0e4f1ed..82f2f2e475345500b599d6ab419be440ece01bf2 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -3,7 +3,6 @@
 test_description='git apply should exit non-zero with unrecognized input.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index ebd0d4ad17c1bfbb1dcc231a32dbcb295496c7f7..07d52625375d4bec97db0a14d74a4fd154681b5e 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply handling submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 7981931b4ed76a510ea3870ca0febbeba4fec16e..8bbf8260fa6b982e82f3ecb1e41d81f08adb9f4b 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply test patches with whitespace expansion.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
index e5c7439df13389a3caa9f3f76f70e31fea96c90b..e07fb9ef089ab423fd888145ba826136920506ae 100755
--- a/t/t4139-apply-escape.sh
+++ b/t/t4139-apply-escape.sh
@@ -2,7 +2,6 @@
 
 test_description='paths written by git-apply cannot escape the working tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # tests will try to write to ../foo, and we do not
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index b375aca0d74ea3a23e6eae69077e9b286b5c144f..c614eaf04cca93a22157d08e9fc464639468eb3a 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply of i-t-a file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index 20cc1209f6259c703fc3ed3e9c193be24b429a3f..eac6f7e151b562b9dc71e5cca3a895476aeb0219 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply with too-large patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 232e1394e8d9259dae68b80e619597d5176ff11b..5e2b6c80eaedfcbc1600a24c425dd4127233ff32 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -5,7 +5,6 @@ test_description='git am running'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: messages' '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 1825a89d6a98cbeb2e7e0ee9489c36bc57aaac03..edb38da7010d33315f02a345a076ef803d460a32 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -2,7 +2,6 @@
 
 test_description='am --abort'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 9f2edba1f833a7127589f9c4883b91bf99bc00b1..768495b131547d20653b3aa3b2ca7bc3839a7930 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -2,7 +2,6 @@
 
 test_description='test subject preservation with format-patch | am'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_patches() {
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index dd6ad8f7a80d9627ee9a6dde5534a0db2f01c64a..9bec989a0ed71caf768c6e3e19bdbda814c23e1e 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -2,7 +2,6 @@
 
 test_description='git-am command-line options override saved options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 format_patch () {
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 213b36fb96242b4e0ed1a59457a94b4fda5ed7a5..b0a3e84984185d3e88756bbdb98cb9a56a2233eb 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,7 +25,6 @@ test_description='git rerere
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7f47f85c7f37209030a66f2b9c76e8bf1e64d802..5f23fc147bb88d1cc3f9485cafa4da832d035ca4 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -9,7 +9,6 @@ test_description='git shortlog
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 35bec4089a33d76941c2dc1dca62dc643f4ef210..51f7beb59f88c8fba384acf7c4772e255b612dbf 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,7 +5,6 @@ test_description='git log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 2265ff8872df9c2a595784c618ffba71acec44ae..24214919312777b76e4d3b2b784bcb953583750a 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -5,7 +5,6 @@ test_description='.mailmap configurations'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits and contacts file' '
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 8e0f283c2b8f4d8c648914cd0051e5d53d56c669..605faea0c7baae7bafd6e3cd81e1a8ce7654b1f8 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,7 +5,6 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f9a9c2145ed57488d0a1b2c4dbffd79023fff5b0..f81e42a84d5adc32dd38dfffbe950a43523bd877 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -6,7 +6,6 @@
 
 test_description='Test pretty formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index 9167b0351f221205cf2700a318b8041513e34248..bcab71c8e8450345bb81ba980080202fee73b23f 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -7,7 +7,6 @@ test_description='Test --follow should always find copies hard in git log.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 73ea9e515503baf7776aaba04a4b6d9de7e20c92..0614511656f03dfb627aceec50376112be7e8a4d 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -8,7 +8,6 @@ test_description='test "git log --decorate" colors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 2a46eb6bedbe283a08fd77917b7fb17da155b027..806b2809d405f854f1d1f8b0d7156ce2c167e38a 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -5,7 +5,6 @@ test_description='magic pathspec tests using git-log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index b42fdc54fcb544349dd2fdb7fd8f48b0bf241442..a675ace0819f2de892f30abfbae2137721bf07b5 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -2,7 +2,6 @@
 
 test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_log () {
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 4a12b2b4979e5855584f189512ab84a563638a7e..26dda0db38481a9636f26fa20919ce9f64491437 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -2,7 +2,6 @@
 
 test_description='test log with i18n features'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1d6dd982a2a858e9ca03635eb83b1463c9c9caed..950451cf6a66e6c099aa5303ce19230c34cd1fc4 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,7 +4,6 @@ test_description='test log -L'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index e6b59123a3725115ff2ad5eae495d114dc7df801..64d818bc70a5c88774a9d77af6387163dd8e0888 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -2,7 +2,6 @@
 
 test_description='git log with invalid commit headers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
index 590fce95e90a8bd751daf13c0696d0a39b8f7d1b..53a4af324495dda3738388af31dcecf31f8ee1ee 100755
--- a/t/t4213-log-tabexpand.sh
+++ b/t/t4213-log-tabexpand.sh
@@ -2,7 +2,6 @@
 
 test_description='log/show --expand-tabs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT="	"
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 79055978690962fc3b58cd754a9383a88148f0f9..f70c46bbbfa2c8fc9cc5ca1b620c9a80f29e382e 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -5,7 +5,6 @@ test_description='git log --graph of skewed left octopus merge.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index b877ac723516dc710fd42c17b65877d795d874ff..28d0779a8c599ee9eab9b0b31afe1a57bb558c28 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -2,7 +2,6 @@
 
 test_description='git log --graph of skewed merges'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8d22338f6aafe7f117643fd35f032403bdcf5a32..3f163dc396980f4dacce34b5209f50b870d5092f 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -4,7 +4,6 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
index 613f0710e90511c6419e843eec3cb4d11aafc437..6e01e2629c1b158464ab29e4086fb4eeea16bbaa 100755
--- a/t/t4217-log-limit.sh
+++ b/t/t4217-log-limit.sh
@@ -2,7 +2,6 @@
 
 test_description='git log with filter options limiting the output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup test' '
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index 5b680dc755916ea0c165fb5de8a613679426378f..bda8822b3d1eb6d94712701787f9545ee1a6c877 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -2,7 +2,6 @@
 
 test_description='git am with options and not losing them'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 tm="$TEST_DIRECTORY/t4252"
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 2bcdd9f34fad676af2d0287c16964d2159cbbd5f..0ee69d2a0c4e0d21c14290f166eebd563f81be7c 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -9,7 +9,6 @@ test_description='git-am mbox with dos line ending.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Three patches which will be added as files with dos line ending.
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index cb03522d02176fd601cecf25890458e79e25237c..ae0a56cf5ec2d787432b7e97ac40bbfcb270225f 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -2,7 +2,6 @@
 
 test_description='git am with corrupt input'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 04f3ccfc41cc6646027a57eaa1808c9ff76c0c3b..a7ba08f728c0b870bf899ee82220a1708699dcb0 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git am handling submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 92d8c8b651cbe6714d95bdaf9bf91f62fd3bbf91..ac9db285f3fd704b7ee7d0a854d50dae0fee9f4b 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -2,7 +2,6 @@
 
 test_description='test format=flowed support of git am'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
index f26d7fd2dbd35ce40534a5d76f9903361f4b7904..30a565cbeaf185c06364b4dc37ed519aed3993e0 100755
--- a/t/t4257-am-interactive.sh
+++ b/t/t4257-am-interactive.sh
@@ -2,7 +2,6 @@
 
 test_description='am --interactive tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up patches to apply' '
diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
index 3573c9147f17c58d822cd52904349f548d68cd63..201915b45a8bd67c2fc744c259b5a2ee24138796 100755
--- a/t/t4258-am-quoted-cr.sh
+++ b/t/t4258-am-quoted-cr.sh
@@ -2,7 +2,6 @@
 
 test_description='test am --quoted-cr=<action>'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t4258"
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 9c197260d5bbf54d3ad578c27f54e278d88ab97b..27fbe193bca95e776ac15fe4f791643fbc683b63 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -5,7 +5,6 @@
 
 test_description='git merge-tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 37f1cd7364ce0d4eab374b6a40bb6125dd76f7af..eea19907b550c4a97a7ca7760f1be30bea7d8db0 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='git merge-tree --write-tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b9fda973f7bfbfcfc5e6395ffaca1c3857f84e01..5465054f1779f06e94998a7f342f27b9993af8d4 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,6 @@ commit id embedding:
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 7310774af5efeada84891df9c25d7363b3d15ab4..e7450764411093c71b8d75948d8b51a04970098c 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -3,7 +3,6 @@
 test_description='git archive attribute tests'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT='%H (%h)%n'
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 78ab75f1bc2442144670a2df06de790ee43d82b7..97c93f6c44260d00034c4454b261dbb07d7a5dca 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -2,7 +2,6 @@
 
 test_description='git archive attribute pattern tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 01f591c99b962fced8c5b6e0b1538ad847f814d7..961c6aac2561354f6ad57270c1362fe73c850924 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -3,7 +3,6 @@
 test_description='git archive --format=zip test'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 9f2c6da80e8cd97c12eb5452e940a9022b2e3a84..50344e17ca175db7d64ed384f78543134f68ff9e 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -2,7 +2,6 @@
 
 test_description='test corner cases of git-archive'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the 10knuls.tar file is used to test for an empty git generated tar
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 23b2f218725e0fa7caacb3c84f5fc5264b476d14..e57e1ae7395b13b2d8c8b0e87869bd5c4f1e89ba 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git mailinfo and git mailsplit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t5100"
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 86bee3316070373a1e93fc9f1dac2599483ca114..cb67bac1c47487f451c2113c6b6fca60cb438bfd 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -5,7 +5,6 @@ test_description='Test workflows involving pull request.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index cc51c73986c11272ca4b50a8dd32f55b66235a14..836590705599520304dd8255eaeb87318c0a1d30 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git update-server-info'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' 'test_commit file'
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a5ea9dc0bed8a2ee64d5350341dcd06..e13f289dd5901b00c1d9d841fc923bab78a40cc2 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -5,7 +5,6 @@
 
 test_description='git pack-object'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 226490d60df3a61b6b9831118562c4a88bae1cc9..ff6b5159a312bb307f0c2afbcfa707a414e16f9c 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -5,7 +5,6 @@
 
 test_description='mmap sliding window tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index d88e6f16910151009e9700dd7d20d0d12f333ddf..413c99274c8f3029cf259ca60c70c31348da12b8 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -5,7 +5,6 @@
 
 test_description='pack index with 64-bit offsets and object CRC'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index b634bfb66516fbd5dbdbe220e8469aa61d1c8d8e..de58ca654a12158dfe6a81c30d6d14976ce2b137 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -5,7 +5,6 @@
 
 test_description='resilience to pack corruptions with redundant objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note: the test objects are created with knowledge of their pack encoding
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e641df0116c24404e4892a0e30af4ef4bf8db493..1f1f664871ece6dba57e6bb601ba3771f490e2eb 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -7,7 +7,6 @@ test_description='prune'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 day=$((60*60*24))
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index dc8fe55c82d5ee146014f4b3d5f478d13fdc75f1..44bd9ef45fd6d320e50f00fb0f86505fac2d7955 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -4,7 +4,6 @@ test_description='git pack-object --include-tag'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 TRASH=$(pwd)
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 0d50c6b4bca4c0a005ad05f262e4dfc91eb73d53..805d60ff3179ce522219b8ba46e13f8bbf1c80ab 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -7,7 +7,6 @@ test_description='git-pack-object with missing base
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create A-B chain
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index 1e02c305c4fe5f910935463bbbb6724a3bde212d..fa4bc269fe86f47244c861ea49d2996355c2f1aa 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -2,7 +2,6 @@
 
 test_description='pack should notice missing commit objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 655cafa054121130945056643f2fb05a165f3ef1..0f841378677165686581dedefc11a0f018f3a9b5 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of duplicate objects in incoming packfiles'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 4e910c5b9d2a9ddba8c2d808248189fe993873c3..60fc710bacb20e558a6c445969352e4aac08fd90 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -2,7 +2,6 @@
 
 test_description='test index-pack handling of delta cycles in packfiles'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6d0bc804fb8baff48c8d3718945c018..a6de7c5764307817cce2d4ecf9140d84aa70d448 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic bitmap functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow.sh
index 4fe71fe8cd21ddfb0f44821c672585219278bbda..012852c156ac79eaba89d19b6f090c902b73ca9f 100755
--- a/t/t5311-pack-bitmaps-shallow.sh
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -2,7 +2,6 @@
 
 test_description='check bitmap operation with shallow repositories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We want to create a situation where the shallow, grafted
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index d8d2e304687b2a9e6d9313d0daa8a77848410f41..c37ef3818d264b87f227b4f198f87d935383632d 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -14,7 +14,6 @@ what currently happens. If that changes, these tests should be revisited.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'disable reflogs' '
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 86fc73f9fbac4dd5ed2b0c130daa035fa0efe4a3..5be01260d7760f3dedb6227ad4d96ef56f6fa506 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -2,7 +2,6 @@
 
 test_description='bounds-checking of access to mmapped on-disk file formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 clear_base () {
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index 82734b9a3c4420a63b91901d165ae06f4b823ea7..9cd18c1e6be94f7b0c5b7c7ccc46caa54910f662 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -50,7 +50,6 @@ will always find a delta for "file", because its lookup will always come
 immediately after the lookup for "dummy".
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create a pack containing the tree $1 and blob $1:file, with
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index c80ea9e8b71ee8707c8c1cc4020fb83a1b90029f..8bacd96275b0ac881b9202ecaff83394ca562dd2 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-object compression configuration'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index eb4ef3dda4d6e501b9be6c7b85d90a0fd55e5c7f..32cf4227451ff762414f53f415560399275ee8a3 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-objects breaks long cross-pack delta chains'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This mirrors a repeated push setup:
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 79552d6ef7f69751b8cfa1bd71edfda47973257b..501d715b9a16b7ccb35f7ea67846492087fa0a14 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -5,7 +5,6 @@ test_description='git pack-objects using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test blob:none filter.
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2916c07e3c2490e7af5eb05cfe62f90e4c7c359a..f68f64cd85e32cc4c2f0da562482eb852d534fde 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='commit graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index fbbc218d04af4a56fcb66cb43a8ff12eeb55c6ce..0f215ad2e88837bbff00a071668247d42af93fef 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -2,7 +2,6 @@
 
 test_description='multi-pack-indexes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index 406363381f10bcc6ee4f8040afadcc362d85fc29..2c961c70963051c964adb8861cc32f1b7e27fdb1 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise delta islands'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # returns true iff $1 is a delta based on $2
diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index 70770fe274d84fca1d988c1d4dfd7457943363ee..51aaca1fcf6229e0e2d4d8ff7137493833e17298 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -7,7 +7,6 @@ test_description='git pack-object with "large" deltas
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 770695c9278292285f7c5ed2fd65a80d7169d92f..d39958c066de5e3739b48a4a3a64cb46f21f6700 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -4,7 +4,6 @@ test_description='pack-objects object selection using sparse algorithm'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repo' '
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 4e18f5490a8e4a0c5e9914a368e2aa10c67eef69..8dbbcc5e51c06d7c5f56fcb3107860fcb66a5106 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -34,7 +34,6 @@ relationship between packs and objects is as follows:
     Px2 |         s s s                           x x x
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 main_repo=main.git
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 1193726daad77f55df1f8247120a44fcb2ffa84a..a32be3867df36ff785ce67f857bb732342101685 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='split commit graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 431a603ca0e61d7085f28333c6a28c120ea45828..285c8b4a49555b3cf0ec60270170435390840c71 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -2,7 +2,6 @@
 
 test_description='on-disk reverse index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 6eaa692f33b5c42bf24459377bd31309f7b03f00..d27557b9b042a125359d255d9845872cda656914 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic multi-pack bitmap functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 994a8e6be464ac08982e806874fdc865ec3ab078..9cac03a94bf4b4014d0ecd9fd7fc6320949b3e9f 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic multi-pack bitmap functionality (.rev files)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index fc6a242b56d88686036ff019003352ee806ef8ce..a766a3e3f84ff58ce2ba28fa370a51968f27743d 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -2,7 +2,6 @@
 
 test_description='commit graph with 64-bit timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 54a4a49997cb08191ae120b59dfe609e6fde0e39..b71a0aef408ec5757aa4eba24923f5e4b86279c7 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -2,7 +2,6 @@
 
 test_description='cruft pack related pack-objects tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index 5eb28f0512d447dcea6a16fe27b0a3272514de42..2cc7fd7a4765b2ba8057591df7588150d453a44a 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='test for no lazy fetch with the commit-graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: prepare a repository with a commit' '
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 2dcf1eeceeb65c4c034cb769f4b1d5fae3b79423..b48c0cbe8fcfabc4fbc0074e10c52c5daffdc4c6 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -4,7 +4,6 @@ test_description='pack-objects --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 packed_objects () {
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769bc0e0ce7194223e9b3004e0878461a..a1b547b90c1839b721e96dc0a7a9a211e11dc175 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-objects multi-pack reuse'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index eca4a1eb8c6e56a935bb336a9cdb3272d216d4ca..1dd62847560dc02815e0bd1964bfb68c47ff40b1 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -4,7 +4,6 @@ test_description='pseudo-merge bitmaps'
 
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_pseudo_merges () {
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 471994c4bc89d8faa5bb39e8614439573f388ba3..26257e5660e766bdced4015aaa2350e1d26eee73 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -2,7 +2,6 @@
 
 test_description='incremental multi-pack-index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
 
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 43cbcd5d497ecaef33c97032e7c5a8729fb4c01c..d76eb4be932eebe4afda151248d0f0acec76803e 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -5,7 +5,6 @@
 
 test_description='git unpack-objects with large objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_dest () {
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 248c74d8ef2e1be8f882d7692dea81c417d829d6..3f81f16e1335ce6e7f3c8e8d164e140e26049e6f 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -9,7 +9,6 @@ test_description='See why rewinding head breaks send-pack
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cnt=64
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 3c1ea6086e7d2817bc14d59c28153fe215a08c18..723d1e17ec67535a6c8a4e320ba08234fb0295e9 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -5,7 +5,6 @@
 
 test_description='Test the update hook infrastructure.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 46ebdfbeebaf522281e8e4aa4c68e9fb33ca8513..915af2de95e162a9581ca23a6efb229737e665a6 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-merge hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index cfaae547398e0e54cfc5b8f6403d2502ac826782..978f240cdaceb4e7593adcf89136e9de9b558aa1 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-checkout hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 51737eeafeeefa0c1b1f075081f4c5c4b95de64e..cc078896673ae221754a5b65102b559b872dcfd9 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -5,7 +5,6 @@ test_description='tracking branch update checks for git push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 1686ac13aa628584297fcfd961356ae5291c57e7..11f03239a0628c4a50ef13758647f6c85e35e552 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -5,7 +5,6 @@ test_description='forced push to replace commit we do not have'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index d6a994663383c32da26d1654527f938873589e2b..dcbeb42082791ba0bb2683e9f78b545250d380fc 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -2,7 +2,6 @@
 
 test_description='remote push rejects are reported by client'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index e99e728236ad07ed011d127fbfbb13126e7ea82c..ad7f8c6f00202c5ec844108b14a2c1301c185223 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-rewrite hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index c3695a4d4e3bbf43b815206f9334327868b7d149..526a6750459514df0cadbb9120250ba825fca573 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -2,7 +2,6 @@
 
 test_description='send-pack --stdin tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_ref () {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 516b22fd9637ea6d7563100167088e8109180c9d..fa5de4500a4f50d48067ef6b1c05491b360a11f4 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -2,7 +2,6 @@
 
 test_description='remote messages are colorized on the client'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 7a45d4c311ed345fc0126355642e9e1e4e68d292..0b28e4e452fe7e6da3269ff55e6e3b4f0fb91cea 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -5,7 +5,6 @@ test_description='git receive-pack with alternate ref filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 13d2d310a9f11e4a54c9484e7d2f78b24ee82cd3..92cf52c6d4a32c401680a068f9d892950e13d99a 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -8,7 +8,6 @@ test_description='Test proc-receive hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8da8e7fe4230af6cdd05e472a6e61c2c9030d094..509133c1f917c59ec57d4bbddb0f2b10a5517e54 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -8,7 +8,6 @@ test_description='Testing multi_ack pack fetching'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test fetch-pack/upload-pack pair.
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 0c8668a1b8e3e39d6b263b2b87888b3503eeb5c2..66f19a4ef2b6ed2ac6dc2e133e1df7010cdcd98d 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -4,7 +4,6 @@ test_description='fetch/push involving alternates'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count_objects () {
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 7b3ff21b984ff4fcfbd4a64a3eecceabf694e27b..b160f8b7fb7e1f9973361cf3ed86d769d5610206 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -5,7 +5,6 @@ test_description='test quickfetch from local'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 5ebbaa489689dce28d1b47e16b73e19e25183c5f..195fc64dd44ae74c1546698e111f1a19c07dbb04 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -5,7 +5,6 @@ test_description='test automatic tag following'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # End state of the repository:
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 138e6778a477650ecbe2dc3e480c5fe83d4bb485..53dbc8ce3a66e48a8fd138c48b620750c538b509 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -4,7 +4,6 @@ test_description='fetch/receive strict mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f3326798741189300a1a6ef3b481c3f..08424e878e104cc19a43960b987cf868f542cad2 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,7 +2,6 @@
 
 test_description='git remote porcelain-ish'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 0e176175a353571428bcf2ca505fa116564f80a3..16e9a1bc2f2c956f655b327e783f9c0db596a78a 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -4,7 +4,6 @@ test_description='git remote group handling'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mark() {
diff --git a/t/t5507-remote-environment.sh b/t/t5507-remote-environment.sh
index c6a6957c5001e9480cbd26ccba5fd26c54126ece..a41d5b370b8f26f116e7d543d7d75dc43bdf4bd0 100755
--- a/t/t5507-remote-environment.sh
+++ b/t/t5507-remote-environment.sh
@@ -2,7 +2,6 @@
 
 test_description='check environment showed to remote side of transports'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up "remote" push situation' '
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index f029ae0d28604348de3635148f9ad45b1d65cefd..095df1a7535d5793c7500e87f54b8ffc93a901d4 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -4,7 +4,6 @@ test_description='fetch/push involving ref namespaces'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c56cc4b936fe1206c0378a8d5b15585..3b3991ab8678a57fce3ad371e37900fb3c6c426a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,7 +5,6 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index fc55681a3f2cb5f1b27e6b939142e4c7693e043b..be025b90f989f68d2b60b96ee7e29b134b557f6f 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -2,7 +2,6 @@
 
 test_description='refspec parsing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_refspec () {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 64b3491e4ee6f6272a0657e8a19ee67b97340c97..3a67992a7dc0860ce8edfac84f46a3ba11debde4 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -5,7 +5,6 @@ test_description='git ls-remote'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 generate_references () {
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index c46c4dbaefc729d8f26a65d6c797682f03d4d130..65d1e05bd62af9c2b6dfa6cdd841d03622bf94ac 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -2,7 +2,6 @@
 
 test_description='fetch follows remote-tracking branches correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 579872c258db40acd35acd9db027eeb123702e00..25772c85c5a9a89bf247cfa41cf9d8b127572cd8 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -5,7 +5,6 @@ test_description='fetch --all works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index c100a809c5e59f0b48d8b616883c1397de027ff3..320d26796d24d8a2281d37220a7bdf73cafaa503 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -14,7 +14,6 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 build_script () {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 331778bd42cac3fbe94fdc62614e30ac2e623045..9d693eb57f7790ddb81cee0b905a101719069562 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -19,7 +19,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index 6d4944a72826401d3e698ad4c1b6982c4a233eae..a448e169bd029f21ec77cd89dc087c8e637578f8 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -5,7 +5,6 @@ test_description='pushing to a mirror repository'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index c13120088fa684b59cc2f598d8ebfe05cae7b42c..5c4ac2556e7820f41285b5f653a5f61cc5f75846 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -8,7 +8,6 @@ test_description='fetch exit status test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 72e97b15fabbb821eaf5d88a24fee0ae4c8de6f8..20ba604dfde1629b5ab75226f41ef2e4b3814d07 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -5,7 +5,6 @@ test_description='push to a repository that borrows from elsewhere'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1098cbd0a19218f58296960293b88a375a4cb4eb..47534f1062d203a9b823d545740004e2002162ff 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,6 @@ test_description='pulling into void'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db00c4336b1671158f69b9711e247d9300b5cac8..5e420c208c779810c3ff1a9234a25d787376d890 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -5,7 +5,6 @@ test_description='pull options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index cc5496e28fd0bcbf32badb583272c464ec88fae8..9fb73a8c3eb84b98fa7a9420b6aaa499b9cbee6c 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -2,7 +2,6 @@
 
 test_description='pulling from symlinked subdir'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The scenario we are building:
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 4ad36a31e185085c487fd13ea3effd0b01bb51b4..22d3e1162cde4ebaf16bebed8db04d53d3695e7a 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -4,7 +4,6 @@ test_description='push with --set-upstream'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 56716e29ddf1c3ded4cfae0443ee60ffe4eb0945..b2be3605f5a3f0649879a31803b5fc7cfe40d8a1 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -2,7 +2,6 @@
 
 test_description='git pull message generation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dollar='$Dollar'
diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
index 3a28f1ded5fdcce6b2a55aa6122e27489d942265..45815f737850b61684f648af9d984ac16ea0944e 100755
--- a/t/t5525-fetch-tagopt.sh
+++ b/t/t5525-fetch-tagopt.sh
@@ -2,7 +2,6 @@
 
 test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_clone () {
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 2cfb5bd6bb1e8698e53d56d35b8b759cecb58c49..5e566205ba4b95830bd97c97b0092cb4a3356304 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -6,7 +6,6 @@ test_description='Recursive "git fetch" for submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 98ece27c6a0819093cd54ce19916456ce2136dae..e2770e4541f94d60dba1ae8698abf3496a6a50e9 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -4,7 +4,6 @@ test_description='test fetching of oddly-named refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # afterwards we will have:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 1305b1cc25418d509a19ba809aa39eb19660bb63..2bd8759a683ba0e1e08a2c02b49c4df431003782 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -4,7 +4,6 @@ test_description='check various push.default settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup bare remotes' '
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 17d72578926acc0eb3823712deb79fa72aa470bd..80b06a0cd2886d235fc59d67177b43985472fd4b 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -5,7 +5,6 @@ test_description='detect some push errors early (before contacting remote)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7172780d5502a9768e00ed84c65f13d618ad0dc8..558eedf25a4c9b9f2bac8dca0d69b1b7eaebf381 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -2,7 +2,6 @@
 
 test_description='errors in upload-pack'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index dcfef67af4e8a16bddcb5f3aae663caedc0e9f90..05debd1134db49a5ba0e86b9f8b51f5019039db4 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index d664912799b43aef1b0a35d4d4a87ac95de36f4a..37558226290f43a1c3bd053ef76a4e73ef8811fc 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -2,7 +2,6 @@
 
 test_description='fetching via git:// using core.gitproxy'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup remote repo' '
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 6365d99777ead268ccd589d6990b07fd9c4ec33c..cba26a872dde465c01cd99782029811cf2da9acf 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -5,7 +5,6 @@ test_description='compare & swap push force/delete safety'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_srcdst_basic () {
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index d43aee0c327c0ba4680db01a06070b5688a1dd72..c91a62b77afcfba1bf1228c33717db77c7e45318 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -5,7 +5,6 @@ test_description='signed push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index 7122af7fdb50acbd8279617f5741532280135ad8..e8f6d233ffb80ba1a449d47df022f7765b12f6af 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -2,7 +2,6 @@
 
 test_description='avoiding conflicting update through symref aliasing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2dcbe790523cc3e53ad6ad100242d52f92fabf51..23bf69617007d7e97ff3641d3a5783a7ffe0352a 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -2,7 +2,6 @@
 
 test_description='fetch handles conflicting refspecs correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index cae4d400f32e8becf40c51bc074dbe972ba27c95..37f7547a4cadb22929d7f88d9d8e11e5059b9d32 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -5,7 +5,6 @@ test_description='fetch/clone from a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 6adc3a20a45b77aea252d7073025f57060c1797e..e91fcc173e811664a2ca7fb504f551e79dfb89e5 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -5,7 +5,6 @@ test_description='push from/to a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 82fe09d0a9755499cbbf67726fa25f8ca00c45a7..3ea75d34ca0e7ae82b6c1c5e88fdd1f8594c036e 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -5,7 +5,6 @@ test_description='fetch/clone from a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 27389b09081fbe46fe700bfcf117188303ed1753..37db3dec0c5b3939c9cb6f2e6f6e383c80045c87 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -10,7 +10,6 @@ This test runs various sanity checks on http-push.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 3ad514bbd4e303e9c09a311c42847c6baebe3e2d..71428f3d5c760a9bdca7524e15cb9747e92cfd17 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -7,7 +7,6 @@ test_description='test smart pushing over http via http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index 07624a1d7f6a8d1b2acb2a32adb31cc1b46b980c..c2cc83182f9a6b8ae3aa0b2cee1b5b28fd12c7f3 100755
--- a/t/t5542-push-http-shallow.sh
+++ b/t/t5542-push-http-shallow.sh
@@ -5,7 +5,6 @@ test_description='push from/to a shallow clone over http'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 479d103469527e6b923877cd480825b59e7094d4..04b47ad84a86ab3407ba26f069d934ed7dcb5dec 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -5,7 +5,6 @@ test_description='pushing to a repository using the atomic push option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 1a9e14bbccd3c572d86f5cb15afef37abd8d3d67..89147a052e72cd0e3fc4b6b8478c491b52e59901 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -2,7 +2,6 @@
 
 test_description='test custom script in place of pack-objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create some history to fetch' '
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 64ce56d3aa8395be41f2e6040b19b42ed38f2da3..fb13549da7f305b88da0f0bdcf3d791907e96a08 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 9fc9ba552f1db320a595dcf7b5b23c31b5c855b1..f1e61c9f09572eeea6a29f395d025ba1058e0e1e 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -2,7 +2,6 @@
 
 test_description='check receive input limits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Let's run tests with different unpack limits: 1 and 10000
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 9f899b8c7d7bcc63ba5fe97c513748eeba436edb..0798ddab02bc8bcfeba9ad41861c578934d21cc0 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -2,7 +2,6 @@
 
 test_description='check quarantine of objects during push'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create picky dest repo' '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ecb3877aa4bf1b25942598ef5f1628d91c9bfbd5..6282728eaf3e7871d99fea48357298f6b14c9fd2 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,7 +4,6 @@
 #
 test_description='Test git push porcelain output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/t/t5549-fetch-push-http.sh b/t/t5549-fetch-push-http.sh
index 6377fb6d99367820c9469bf73b98c4a5fb221569..2cdebcb735633209e0bbdfa07bc4765657b77ffa 100755
--- a/t/t5549-fetch-push-http.sh
+++ b/t/t5549-fetch-push-http.sh
@@ -5,7 +5,6 @@ test_description='fetch/push functionality using the HTTP protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 5115b8dc230e9741882a609be5f41d4596a5512e..21795a19bf55d8ebdcac82caaf10798f879c4cbb 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -4,7 +4,6 @@ test_description='test dumb fetching over http via static file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq !REFFILES
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2ce88535a60e698e5f1ccfcaffd6d2ad640c3a0f..ceb3336a5c494f6d1e6ce0d918ccdf091f346f71 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -5,7 +5,6 @@ test_description="test smart fetching over http via http-backend ($HTTP_PROTO)"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 4f2e5ae8dfa5af1b825547a9e3701b19b8e2eaa5..eeddb85b1deaeae3ce77b9ad8aea8c071b3ac5af 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -2,7 +2,6 @@
 
 test_description='test skipping fetch negotiator'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch.negotiationalgorithm config' '
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 33e919a17e1670a40d6d55cd57e0d5f0469dd779..70e3376d31b4311764be51360acd86447e885a31 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -4,7 +4,6 @@ test_description='"git fetch/pull --set-upstream" basic tests.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
index 06991e8e8aabc28c1a4e522324e5c3eb505cc37e..17e73b606d53242161ad05762b2b7b8de6040ab9 100755
--- a/t/t5554-noop-fetch-negotiator.sh
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -2,7 +2,6 @@
 
 test_description='test noop fetch negotiator'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'noop negotiator does not emit any "have"' '
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 3dcb3340a36bb0e0efca1c1dfad6373dd5aeedc5..e47ea1ad106048fc5a7a0b1fc10a30a6de42471a 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -2,7 +2,6 @@
 
 test_description='test functionality common to smart fetch & push'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
index 76a4bbd16afb0871fb996bbb14d79a40e861321c..67fcc23f1105c12798c16ca01522f507b54b4b73 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -2,7 +2,6 @@
 
 test_description='test downloading a file by URL'
 
-TEST_PASSES_SANITIZE_LEAK=true
 
 . ./test-lib.sh
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index b488b505b928ab6e58258360364ba53bec704eca..3816ed5058d90118b4cbc700d65e97aa9c9987c0 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,7 +2,6 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index f75068de64851faf86d7ae270c1b88bb9d08df16..d30cf4f5b8398e1cf98c86221dd42208d64fd014 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -4,7 +4,6 @@ test_description='test git-http-backend-noserver'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index e1d3b8caed07394fcdf02db4d31d4f038d3474b2..9c57d843152dd5861603316650a0f7f440711c52 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -4,7 +4,6 @@ test_description='test git-http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 7ee9858a78b6fb9a473d777f280a9d450fd49830..f3b158274c4cc7c48004f5dead8315a65ed3b20f 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -2,7 +2,6 @@
 
 test_description='test git-http-backend respects CONTENT_LENGTH'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_lazy_prereq GZIP 'gzip --version'
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index ba03f6a09fcf3df4045e9de8b9d35421f5233a63..317f33af5a7e6044092253814eb501f7e106cd0a 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -2,7 +2,6 @@
 
 test_description='test http auth header and credential helper interop'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 4aef99bc28a46e729e153526f7b6fa34b3bf9da3..b27e481f95bc4d8948dd2f404f0972106c53a295 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -2,7 +2,6 @@
 
 test_description="test fetching through http proxy"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index e3df7d864109a0e0e64cc0b30fba7c9737a1fb9d..8df4001b7221e416faf005f8c2f5a07e22a7d4f3 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -4,7 +4,6 @@ test_description='test fetching over git protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 448134c4bf72bd5f3a4c2287e59f6f2a1f3f074b..a11b20e378223ea30242e70d5befcfeed889a2ed 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -4,7 +4,6 @@ test_description='check pre-push hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 9b6cf8d88b9fbc32ebdfeb7f89e1bfa7e27e200a..f7650e8475e81523ea84751aec4a5b1cb2c2e1e6 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,7 +5,6 @@ test_description='pull can handle submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index ab05f38a99823968a6657ac2579c404560118044..a76b54d7de05cfbf2b4d0f96abb5082d0b91a6cf 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -2,7 +2,6 @@
 
 test_description='pull signature verification tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index f7707326ea158904e86657fe96a99b05c847c535..5883839a04e991d6ab93a965698662ced064fe3d 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -5,7 +5,6 @@ test_description='git fetch output format'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch with invalid output format configuration' '
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index d7537a162b21fe09ac48cab3ac3d937c188ec081..65ef1a3628ee94f79178cc18f76277d599f396b0 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -4,7 +4,6 @@ test_description='various Windows-only path tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CYGWIN
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index 724f61005427b3b10c7f495691e50b27b633ea8d..cded79c16b5d602dfac50305e0d5325dfa151daf 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -4,7 +4,6 @@ test_description='test GIT_CURL_VERBOSE'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 7fa54a4029ad4443ee78ff9de44068c637feeec8..7a80e47c2b70a8cf64c71fa00289b5abfc158151 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -8,7 +8,6 @@ test_description='"git fetch" with negative refspecs.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
index 320f49c753f41376ad757aedf134a76bd6206a68..e7e1b6dab66fb31d065c4dc7611c824a7bc1bf5b 100755
--- a/t/t5583-push-branches.sh
+++ b/t/t5583-push-branches.sh
@@ -5,7 +5,6 @@ test_description='check the consisitency of behavior of --all and --branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 delete_refs() {
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index c814afa5656cca57469d0bff5711bc25229d037a..34b3df4027593b58582b4742d36a211aec57a526 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -13,7 +13,6 @@ Unless the directory already exists, in which case we clean up only what we
 wrote.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 corrupt_repo () {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 3b5285cfcf326fa02015d7a808b4312c62283487..d0c18660e33113e64a293c695239a1c1a7975add 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -5,7 +5,6 @@ test_description=clone
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 X=
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 56329aa160e7529eb2709be333919c9d172fabf3..cbcceab9d56b591ee851374c9030a23a4c65a462 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -2,7 +2,6 @@
 
 test_description=clone
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 8ca1f0942378d27e509e248fc1ea3346b26ef9db..80eb4e04f8b89a8aab04692bdfe81a025a439445 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -2,7 +2,6 @@
 
 test_description='check output directory names used by git-clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # we use a fake ssh wrapper that ignores the arguments
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 9b32db8478ab77ff118a1df382a97d1f4064c2a8..fa5ca4f522d52d44ed5ef3e45d85df5d1a8a2980 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -7,7 +7,6 @@ test_description='test clone --reference'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index d9a320abd216579362dac3f4d82288b570eceb93..339d8c786f66a2254fa79393ace54e2078823b38 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -4,7 +4,6 @@ test_description='test local clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 repo_is_hardlinked() {
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e93e0d0cc397a323bae99e9f92ee5d02cb026f2b..8a1523773684bc2babca086f38eebbe088362b7e 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -4,7 +4,6 @@ test_description='basic clone options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 7ceaa8194d83f4c11fd80b89498969450c34a979..489c6570da5537f52d7edfd498502cb7884d5f47 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -4,7 +4,6 @@ test_description='some bundle related tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 252e1f7c20f2b86b3a276a6bfd7adc9ca14d4909..f86a674a0321e7e39f4df16461d5da0eab84969b 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -4,7 +4,6 @@ test_description='clone --branch option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_HEAD() {
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 022ed3d87c37159f758b349f6604b781a29b9327..a7ec21eda5aabf16144f79a7f348e6f6be9b7507 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -4,7 +4,6 @@ test_description='test cloning a repository with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 head_is_detached() {
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 298d4befab84f2c4476c46562167a0e0a09b3981..4873089a8c95c752548e0ccb936d82fc65caed93 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -4,7 +4,6 @@ test_description='tests for git clone -c key=value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'clone -c sets config in cloned repo' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 72762de9774caa7a3d02b6a3539cd3372b24c3ad..3126cfd7e9d6bdcd41f2c65811b8a2ff8fe0f16e 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -4,7 +4,6 @@ test_description='test refspec written by clone-command'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 7708cbafa982ef3a5579f8bde075fcad40e29e40..c752804a8e90cc72e4eba09d01a9ed81f94cc222 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -5,7 +5,6 @@
 
 test_description='test transitive info/alternate entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'preparing first repository' '
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index c2a2bb453eeabcc8725bffae2c537ec99b8a7d87..0c85ef834ab90e6fddec2ec510929df1d62acb1d 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -2,7 +2,6 @@
 
 test_description='Test shallow cloning of repos with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 83513e46a3556baa014c76f613a4da5504b8b548..9d6aa2187f2aaaa372823679246b29be1e8bbb1f 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of alternates in environment variables'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_obj () {
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f7779ce460a1b848d675f78411c16aa..8415884754b44ccbf4711f35435e9a42c4c7a7fd 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -5,7 +5,6 @@ test_description='git partial clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # create a normal "src" repo where we can later create new commits.
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 5a4d7936a72aac48fde876076393956bb83d42e9..688433824934d89354669d920acd1fb06a5da725 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -5,7 +5,6 @@ test_description='Test cloning repos with submodules using remote-tracking branc
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index f905db0a3fdf406dd564114713cb0236fda42ce6..2fb6d549d394ee5cde5b154bc35da72c269fa9ed 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='test handling of --alternate-refs traversal'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Avoid test_commit because we want a specific and known set of refs:
diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index 1d4efe414daac1f52b7ed2ad1d5b94e6fb3514dd..cce62bf78d335134903b996c7363c4230ae5ded3 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -2,7 +2,6 @@
 
 test_description='test local clone with ambiguous transport'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-httpd.sh"
 
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 985e04d06e0e7cbb805b4d2d1c7da76d48f53a73..a73b4d4ff6a0d26e925ae7f6a0e8e34a1e138836 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -11,7 +11,6 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index c48830de8fe20448116f7988b450fe2d52d786e3..de904c165501c93faa05b24906ac69f2c07686de 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,7 +5,6 @@ test_description='test protocol v2 server commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e4ce059236851aaf79cc23e023096dee2f939e83..d3df81e7852d7db2399ddfd7a1e85612f3353087 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index f75fae52c83d8b2fb300a1a323b11806fc7c3ecc..191097171bcbd4d16f107430af4ee4bb4c14493a 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,7 +2,6 @@
 
 test_description='upload-pack ref-in-want'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_actual_refs () {
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 11be64fc0381134ffe30aa83480d4557c89f6660..2b33fced23ff8f2d4bc03d4842984edf2042dd2d 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -5,7 +5,6 @@ of these cases it will generally be acceptable for one side to break off
 communications if the other side says something unexpected. We are mostly
 making sure that we do not segfault or otherwise behave badly.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'extra delim packet in v2 ls-refs args' '
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index b8a722ec27e73aeeb259e938417017607f64b5ee..ed38c76c29059d3f5363116db1b8231c31b0dc5a 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -2,7 +2,6 @@
 
 test_description='session ID in capabilities'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 REPO="$(pwd)/repo"
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
index 38396df95b1fa487f1b3d642eda4c31347461043..37bdb725bcac2a8e3f8d00cd816bbec456f6ee26 100755
--- a/t/t5730-protocol-v2-bundle-uri-file.sh
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'file://' transport
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
index c199e955fecd9cf7c93e7bfc2751b6b759d5526e..8add1b37abc9850c667737a7588987ea752c13dd 100755
--- a/t/t5731-protocol-v2-bundle-uri-git.sh
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
index a9403e94c6d35039ea0243dc8a492b1b32035395..129daa02269ed409f26fd15fe416ef06cd114541 100755
--- a/t/t5732-protocol-v2-bundle-uri-http.sh
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'http://' transport
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 81bdf58b94443415083cd1dca427e08564f9af53..80a3f83ffb7e601db2799d3290e115551e11aa32 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -3,7 +3,6 @@
 test_description="Test bundle-uri bundle_uri_parse_line()"
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'bundle_uri_parse_line() just URIs' '
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d4882288a30ca056c83201b3f1ce9d29fbd07014..d21877150ed82e20a7984d83ec685cfd3e2f571d 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,7 +8,6 @@ test_description='Test remote-helper import and export commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index dd3e6235cd2a4489d9bfbb9bc61ede980ef51ae7..a7be375bceb8d32a99777404809674dad6817ca5 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -2,7 +2,6 @@
 
 test_description='ext::cmd remote "connect" helper'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local.sh
index 862610256fb082a9ed62547cc51dc0a3cb754c48..96a2c46e7a6bd53475d7d85546535912c93e8e54 100755
--- a/t/t5810-proto-disable-local.sh
+++ b/t/t5810-proto-disable-local.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of local paths in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5811-proto-disable-git.sh b/t/t5811-proto-disable-git.sh
index ed773e7432694b7ccc05a4d09084f238c9ff4b42..b0061e6a373f4d9a2c53676455e789443862f910 100755
--- a/t/t5811-proto-disable-git.sh
+++ b/t/t5811-proto-disable-git.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-tcp in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-git-daemon.sh"
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index f69959c64ca708f1cb8a141eb60c37567b736629..96187efaa82ac694af1cc42c7129b3e034f85387 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-http in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-httpd.sh"
diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index 2e975dc70ec2c8cdb8b92cada469439a99c1d544..045e2fe6ce376ad630b26388820659f8a2c40d20 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-ssh in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5814-proto-disable-ext.sh b/t/t5814-proto-disable-ext.sh
index 6fe1a98b2a14f84109083b929e9c5a6d47c3ecd3..9587a842bc2408e7f3417cbc0b782b0b996502a8 100755
--- a/t/t5814-proto-disable-ext.sh
+++ b/t/t5814-proto-disable-ext.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of remote-helper paths in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index fe899ee82d74a20be4d230289bbb3e8ae619f07e..081a07cbae13ddbb2633714b2ec99371236d359a 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -2,7 +2,6 @@
 
 test_description='test protocol filtering with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
 
diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
index a84faac242d0406f523a78bd201ddcb59ae3acd8..923fc90f877bd0653d21d7466453819c6c114092 100755
--- a/t/t5900-repo-selection.sh
+++ b/t/t5900-repo-selection.sh
@@ -2,7 +2,6 @@
 
 test_description='selecting remote repo in ambiguous cases'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset() {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index f6d17ee9025100ba565da16c1ef97c1f8068e25a..6289a2e8b03890ded5863f3472e469c28cb3034a 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -5,7 +5,6 @@ test_description='miscellaneous rev-list tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 3553bbbfe73bd085eed955939ed7b721aa1a4892..73a2465aa0eca662e69f1efd49f285786f5bd9c1 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -5,7 +5,6 @@ test_description='Revision traversal vs grafts and path limiter'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 162cf50778d6191f71941b0f6c9ef600c6a10684..b95a0212adff71632d0b91cf96432b276c86a44c 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -4,7 +4,6 @@
 #
 test_description='Tests git rev-list --bisect functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 5cf2cee74dbcf3250491642983942905618eca92..0d7055d46d46906af535032071c33ac353b54e90 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests git rev-list --topo-order functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 5416241edea0a024e4566a2f61441a54eae07e66..cd4f420e2a1e3919985a29d174055fab0f50c85f 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -16,7 +16,6 @@ test_description='git rev-list trivial path optimization test
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index ee0306aeec0b6e60fc9b62e7efbc5b659fbc1c72..6cde997e13cbab8efd8f48634b56f1fa2fced92d 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --max-count and --skip test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b0ec2fe865b5301f8c5fdc1aa5a040ef97f2417f..eb93d68d7dc31992ffe64c3b18afb3f2ea1e6ecf 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -8,7 +8,6 @@ test_description='git rev-list --pretty=format test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 2d337d7287a3c2b003e61c85494ef4da4d28bcd1..6f3e5439771fa62f3b3e308ae878fa2e08a08107 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -5,7 +5,6 @@ test_description='test git rev-list --cherry-pick -- file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---F
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index 2cdef6fdf985c1ec3836ed1a642da783f902a63e..a0a070b404293a0c28400f73d8e7da5c7bb9cc48 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -8,7 +8,6 @@ test_description='git rev-list involving submodules that this repo has'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 91db8fafe83e3883923b71e36bbd8bc11bfde1f6..9c9a8459af91304fff966f7bcadd56af1e362c55 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -5,7 +5,6 @@ test_description='ancestor culling and limiting by parent number'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_revlist () {
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f96ea82e78636fd410b30f0b7846552dccd1cd86..44c726ea397cf10a2c522690653ecb696f96cc8b 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -6,7 +6,6 @@
 test_description='Merge base and parent list computation.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 M=1130000000
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index b2e422cf0f7eaa43411fdb6f2bb769ee7294a322..bad02cf5b83dbc014c23cc8ac66135e0cf095138 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list should notice bad commits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note:
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 8ed1a215da68ffa042ca44dfd4a4521bee153e47..de1e87f1621d5db8c3730662731fdd67e1dffba7 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -5,7 +5,6 @@ test_description='merge simplification'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 4128269c1d481bf4837e62fdbce0982196e16d33..39793cbbd661afe7fe9b9bab2302b023e4ef1d0a 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -5,7 +5,6 @@ test_description='--reverse combines with --parents'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index 16b8bd1d090eae0449e409cd8313ffd45f769208..c9bedd29cba4aac6b7db1aa8f1698fc5eac11b15 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -2,7 +2,6 @@
 
 test_description='--all includes detached HEADs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 2656d6a6bc43876e8bced67343e9ec04dd8450cd..54b0a6f5f8a4b2996bd49ab3251837967f8fd57a 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -10,7 +10,6 @@ test_description='--graph and simplified history'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index a0a40fe55cd8f78eaf2182c73754088fb38d4388..4821b90e7479ad8f4878ab4432ce0e9d2ce47de5 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -8,7 +8,6 @@ test_description='log family learns --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check () {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 3b181f771c25a3d8a074f7d0472bf1f0422f582b..bb55c7e3c3c30ddc2b156d0ad601fd12311ba57e 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -5,7 +5,6 @@ test_description='rev-list/rev-parse --glob'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit () {
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 1aabab69568a18d103db308f53a8b2e05cfe643d..738da23628b12b4660105195e2bbcedf68416f33 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -29,7 +29,6 @@ test_description='--ancestry-path'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c201d98bddbce451b707da2734f07bb2..5d444bfe201a330527e86dde7229721fc386fc93 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -8,7 +8,6 @@ test_description='Test git-bundle'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-hidden.sh
index 51df02105d7b83c3b0b1c85f95d419ac9a4bbfe1..5fe942a29368304a748219b3b96e43032965e231 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --exclude-hidden test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 127180e1c9a246769fb5bb7ede57f814abb4fc79..7553a9cca203f13979800d172d6c74ae52b7f15b 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of missing objects in rev-list'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We setup the repository with two commits, this way HEAD is always
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 310affadebed321fcc93ee5bd785abf4ca013cc1..cdc02706404b34b17b29692d72d97fab7eba58b1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -9,7 +9,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index acc281c116815e2fbec71ca6c78fc90ed6280f73..0b719bbae68ed580d79a12920273b0575d615bc4 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -5,7 +5,6 @@ test_description='remote tracking stats'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 advance () {
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 3946e18089a2a50a2a7a6433d462a7c97546a384..82013fc9037c1dd67cfda1a0206f6b73a2869677 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='bisect can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index deba3ca430a255decf80934d09a586f651b60668..aa1b5351873ee5d03f5fd88abf720a35457e6a50 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,7 +7,6 @@ test_description='Tests replace refs functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 1a8b64cce18239284a28260734a0348f95a2d7b6..e6b3e6ec7759934059058da7a1b5c2556f3f8353 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -2,7 +2,6 @@
 
 test_description='basic git merge-index / git-merge-one-file tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup diverging branches' '
diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index 88ed7bd75a75f0d8eb730d2f3db7dc59afe7807f..e934bc239c534d5da532c28d520732475859b665 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list testing in-commit-order'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a commit history with trees, blobs' '
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index d20723d627629f5379f35c33c74ff22d1082152e..5f55ab98d352fcb24df355e0976586ed848347c1 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -8,7 +8,6 @@ test_description='Test git rev-parse with different parent options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 5d28507efc687b12af0de9762668ec87fd03a0fc..22dfd6d978ef53553c871f0acf47e09106f382eb 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list should handle unexpected object types'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup well-formed objects' '
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index ddefc7f24ee9cacc6cb7f5ca84c8ca3010e60ca5..13c1da5352836758cb0806d0f969f2aac4c8f7c9 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -4,7 +4,6 @@ test_description='operations that cull histories in unusual ways'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index f63bc8d3da62af61e0292991bbf0439dcd7f2d5d..90ff14164009d0e3dcdfeaf0a41763c39d2eab23 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -16,7 +16,6 @@ test_description='TREESAME and limiting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 71e38491fa8befb4f5cba8f31c01a6a54fb519ec..0387f35a326d741b26eb4795199bb42e3c4b8b7e 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -5,7 +5,6 @@ test_description='git rev-list using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the blob:none filter.
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index a9656a1ec8a6d71814a5f17157eb0e2acbd4bf98..902854cbfaacce750de71907739617f95c7c7feb 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list combining bitmaps and filters'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t6114-keep-packs.sh b/t/t6114-keep-packs.sh
index 44246f8a63e55f275b3b6f32ac289f2c1adb85e7..a584522ef29fa3ef437f14bec4364394a1f1b426 100755
--- a/t/t6114-keep-packs.sh
+++ b/t/t6114-keep-packs.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list with .keep packs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index 21c4a211b15a833efcfa2da67a29e072f6bf24fa..3385fe9f130762a79fe1c15e3d60b6fbc699b425 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -2,7 +2,6 @@
 
 test_description='basic tests of rev-list --disk-usage'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # we want a mix of reachable and unreachable, as well as
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 05ed2510d96868d1586d6699a1d3d35c0791612e..79e0f19deba0efbdaff2c3ffdf8b43a0dcbf4d84 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -14,7 +14,6 @@ test_description='test describe'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_describe () {
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 82de25d549a07e0ada1ee858b6ccb6bf43107ce1..a7f2603cb4a9b5fbd045fdf8b62a7ab5127aaf89 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -2,7 +2,6 @@
 
 test_description='test globbing (and noglob) of pathspec limiting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commits with glob characters' '
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 770cce026cb158ab9a77eda336ff263c862fb0f8..e64d9380838232b68133cc8bc45be884e7513ee6 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -2,7 +2,6 @@
 
 test_description='test case insensitive pathspec limiting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index f31c09c056fc6c7010be2d5c219ceaa2249f50b0..9fdafeb1e907f4381f2b1e74c6c00771d188d136 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='test case exclude pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
index 6dd4bbbf9fc9bab61e3027fbb4b7ca84397b5147..0f722fb340da552a29754d401a75d4b7be3f7702 100755
--- a/t/t6133-pathspec-rev-dwim.sh
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -2,7 +2,6 @@
 
 test_description='test dwim of revs versus pathspecs in revision parser'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index 16ce4cfcc6420477b2c86718f2e68834b843de61..9b62a0a65f16af548bf70b8192de6ecaefd3b254 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='test case exclude pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a submodule' '
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 794bc7daf050472229622781044a87140946a046..67d8c72147c8b877541cd14d5693437762f0f06f 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -2,7 +2,6 @@
 
 test_description='test labels in pathspecs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
index 2db37a6596953532423b6c1518fee199a1f5c3de..1284fe014358e19d46305525d6f1ed92c2cec3f2 100755
--- a/t/t6136-pathspec-in-bare.sh
+++ b/t/t6136-pathspec-in-bare.sh
@@ -2,7 +2,6 @@
 
 test_description='diagnosing out-of-scope pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a bare and non-bare repository' '
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 0a4388f343166b3b12d6614ed04cf6839e23da31..011e5df1e6e9f1a09faf4c719b942300b2d68d1b 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -8,7 +8,6 @@ test_description='fmt-merge-msg test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c39d4e7e9ce4540661fe0d45e0c507640da788c5..a5c779438547382a8c263b3d5e35bfd2d93c217c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,7 +5,6 @@
 
 test_description='for-each-ref test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 83b8a19d94176dcf66d2aca1d8a4b9519ee020fe..e06feb06e91956bd61df6db6161eb1eae4911b9e 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='for-each-ref errors for broken refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index a3e1258a4cbe0f5fc6f288575e41d0f028aa0557..bb02b86c1635598a16a2c4ad95dc50005140b09d 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -2,7 +2,6 @@
 
 test_description='test for-each-refs usage of ref-filter APIs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 27d6efdc9a6d377a3eab526b6c4aac46319c33d5..3de4ef6bd9e640d2f82deb111dd307e9a000db91 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -7,7 +7,6 @@ test_description='Test merge with directory/file conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6401-merge-criss-cross.sh b/t/t6401-merge-criss-cross.sh
index 1962310408b12209aef235b9d6e09b8049de5f60..c8e5ff28e80833dccdd933316f99055f5a7b28ee 100755
--- a/t/t6401-merge-criss-cross.sh
+++ b/t/t6401-merge-criss-cross.sh
@@ -9,7 +9,6 @@
 
 test_description='Test criss-cross merge'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 729aac9842d1f7679da2c187bbb857f85ec3a131..2738b50c2a9e01aab9e3248e666ddb91be9c3bcf 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index fb872c5a1136fc523dacdf6f9778b37441905980..06ab4d7aede08139165bfa27c1bbddb97cc06aad 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -2,7 +2,6 @@
 
 test_description='RCS merge replacement: merge-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 57169ca24b593d22b4ff42c540dcf1f20198f5a2..ae687f2ce541b9542f9a954cc65ce6941d99b549 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -4,7 +4,6 @@ test_description='Test merge without common ancestors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This scenario is based on a real-world repository of Shawn Pearce.
diff --git a/t/t6405-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
index 29e2b25ce5de25f6f97aa6ac967332e7603eb91e..7435fce71e004095c3a9fe181b038ae77a800192 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -11,7 +11,6 @@ if core.symlinks is false.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 2dfc9a873d41c0fc010576eeda14ea6588d8de39..66e01464b5ebb956ecf5ca63f363b60ccc71487c 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -8,7 +8,6 @@ test_description='per path merge controlled by merge attribute'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 0753fc95f45efb642543f9f23191d3430d4d6cde..e8a28717cece3248c2d9996e797dcfdb9af128eb 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6408-merge-up-to-date.sh b/t/t6408-merge-up-to-date.sh
index 8a1ba6d23a7dc4a7ca7a56988f3d945d9af38619..7763c1ba98080d5d1d68e1009fb70f6c80cf479a 100755
--- a/t/t6408-merge-up-to-date.sh
+++ b/t/t6408-merge-up-to-date.sh
@@ -2,7 +2,6 @@
 
 test_description='merge fast-forward and up to date'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index 528615b981f899f1b02c3ab96bc6c794724700be..e9ba6f1690d015d06e13c69db2c1190ef8436443 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -5,7 +5,6 @@ test_description='subtree merge strategy'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index b6182723aae158acb4e56ab9018c9b30f4f86cd6..6ae2489286c278f978c3a87f1015f16fe2bb005f 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -4,7 +4,6 @@ test_description='merge: handle file mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up mode change in one branch' '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index d0863a8fb5101615df4f8ff27db46a882c0a470e..ca018d11f547978bf66a41804c16bf24a0b614f8 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -4,7 +4,6 @@ test_description='merging with large rename matrix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count() {
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index 647ea1e8382913887e292977502181b223136b46..cd6adf6caacfcbf74ab335763426c52e4b376041 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -11,7 +11,6 @@ test_description='merge conflict in crlf repo
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index 69fc1c9e697a9d86a5d29b2fa99aafbc78a79a6f..d7e3c1fa6e634878e24edf0cf9a71e4f07c4733e 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index ae00492c768217a46d73fde7cfbc330dcc502616..2655e295f5ae4536eaf86dcf95e8062f61cc2948 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -4,7 +4,6 @@ test_description='merging when a directory was replaced with a symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 5f414abc89267d3f3729366d67f8b7d6aec52c37..17b54d625d0e468047377c378faae25c50633c9b 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -5,7 +5,6 @@ test_description='recursive merge corner cases involving criss-cross merges'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 482b73a998ff2aa6651fc3fc7bd845fffd2c80c3..62d1406119e8c2b08a1a93e3d8fb95167ad16e7d 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive ours and theirs variants'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 48a62cb85568bfb7f77a8c597096617dfa5fcf4c..41288a60ceb549295699f2efd9cb8e187d3e297b 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -15,7 +15,6 @@ test_description='CRLF merge conflict across text=auto change
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 30349a466e7aad899cc7f889a7175f5853c8c56b..b99f29ef9baded74a5380169c3161621e1732448 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -26,7 +26,6 @@ test_description="limiting blob downloads when merging with partial clones"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 80d7b5eabaf02e555cab3c4e37342a9eb2788f5f..62b49c67e22e8c91e24f0cfce3e770a894897997 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -6,7 +6,6 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4aaaf38be684fdf566234cde82840dee35ea724a..88d1cf2cde9dabbba74daf6debdc82b11ba12ec1 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -25,7 +25,6 @@ test_description="recursive merge with directory renames"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index a7ea8acb8451cde95fe462f6e63912ec849737a2..7677c5f08d0e8fb66dd243c05e9a9b892b6114df 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -2,7 +2,6 @@
 
 test_description="merges with unrelated index changes"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Testcase for some simple merges
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index b95b064311b6762da86c6239a93651edd9dede78..c15d031b165b23eed0a9644df21d93ed59c4a68d 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive rename/delete conflict message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'rename/delete' '
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 62f0180325352b627ea25fc71ec0ffdb4e8e5bb7..b059475ed033440bad42a059341b63176314e642 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -22,7 +22,6 @@ test_description="merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index a13271b34902bcca25cb78e273233d1300ee0a27..dd5fe6a402196270fba03fadff55d1e39fa64f02 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -5,7 +5,6 @@ test_description='recursive merge diff3 style conflict markers'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup:
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 8a79bc2e921d433bb9db401c2f9c0f25a9908333..9919c3fa7cd4359ebe36e3b4b1cbbe99da227905 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -22,7 +22,6 @@ test_description="merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index cb1c4ceef763416011e68053adc26b0a9c0da1c3..0f39ed0d08a34230c7c42f307992c20cc8b06d02 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -2,7 +2,6 @@
 
 test_description="remember regular & dir renames in sequence of merges"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 555f00f78a19053c49b9c625471461621e4f103a..ca15e6dd6da94bc1bac8286e9e36a196cde7a797 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -5,7 +5,6 @@ test_description='merge-recursive backend test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6431-merge-criscross.sh b/t/t6431-merge-criscross.sh
index 3fe14cd73e895fde51b4f711865553e7a142a2ea..3824756a02ec31c228e2eeda92fc13a33b1e4b75 100755
--- a/t/t6431-merge-criscross.sh
+++ b/t/t6431-merge-criscross.sh
@@ -2,7 +2,6 @@
 
 test_description='merge-recursive backend test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #         A      <- create some files
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index c93538b0c38462f18613a493c364fdff531be862..db4b77e63d23c469d8d7a012bb83df99d1600400 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -14,7 +14,6 @@ test_description='merge-recursive space options
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index ed7866d3e955a3d093b6428b750f4d8d7ec1ae63..0f611c40031cd6209ddd7f9180537eb9f166013e 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -5,7 +5,6 @@ test_description='"git merge" top-level frontend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t3033_reset () {
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index df1d0c156c54a3ce0f96557e882435136862b4d8..a11707835b4abe69b200b50f01af797733cc4bdc 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -29,7 +29,6 @@ mentions this in a different context).
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_expected_stages () {
diff --git a/t/t6435-merge-sparse.sh b/t/t6435-merge-sparse.sh
index 78628fb248ab6143ef83d11e819f15c30b52f278..fde4aa3cd1ab66a13c61234155da0c2bacb851a9 100755
--- a/t/t6435-merge-sparse.sh
+++ b/t/t6435-merge-sparse.sh
@@ -3,7 +3,6 @@
 test_description='merge with sparse files'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # test_file $filename $content
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index ccc620477d494b20588ba87bf83e9fb73a90539d..4f4376421e7da28e22f58258061bf58f3a8bc0c8 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -7,7 +7,6 @@ Do not overwrite changes.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 7a3f1cb27c12b468cb8a97e80c75a86070c7c4a8..4815559157b2fce8ac8a305a78a5c01ffa438da9 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6438-submodule-directory-file-conflicts.sh b/t/t6438-submodule-directory-file-conflicts.sh
index 3594190af84c1ba2b65a3c69768147bd975dc155..8df67a0ef99d26357404579ef3dbc102317fc5c6 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -2,7 +2,6 @@
 
 test_description='merge can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index a9804ae42f1d3c5735e245c524fe686008b65d6b..55bd744a3f47385a82c6a58c21be1459b7909bb8 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -5,7 +5,6 @@ test_description='unpack-trees error messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ee074b99b708c337e5fe713456375c5b8c00248a..53784559681cab582ea51dd6c475972001ac01e5 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -3,7 +3,6 @@
 test_description='basic git gc tests
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 4521508b83a6560e6d025dca1750838f083fdc89..ddef1ca3915c35434ace202d6fd8f840ed3dde29 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -28,7 +28,6 @@ test_description='check pruning of dependent objects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We care about reachability, so we do not want to use
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 307deefed2c1a7b39de1eeb35821e6e1afc2c712..2591f8b8b39bf4008d3ddb7a8b8aa8c429e34856 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -2,7 +2,6 @@
 
 test_description='basic commit reachability tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Construct a grid-like commit graph with points (x,y)
diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index 9e70a7c763a210c6b1d855e2cc5dbb2ca403394a..0f6a2ad9b593f4c3c6f4f9b9eb25e29acdc45495 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of deep trees in various commands'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We'll test against two depths here: a small one that will let us check the
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 69c9190772fcea6f20b2bf36a3c61e9bcea2c742..25334b506228f0f9d613e43d3c5be7c1caf2138b 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -2,7 +2,6 @@
 
 test_description='git mv in subdirs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 57969ce805a54839fe18bfb3bea63faacb1dd85a..26582ae4e5fb5ebb6aebb6239ecd3ab711b119ed 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git mv in sparse working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_sparse_checkout () {
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index bf3e3f0b6780703e2788d672ca1fce62f175c5a8..5ab4d41ee7c6b122b8601bf8059eecafdf081c39 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,7 +4,6 @@ test_description='git filter-branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 42b3327e69bed34ce2c5acafc249fc69360ca022..b1316e62f46ded39a3c65a78ef465dc5ba8cae0d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,7 +10,6 @@ Tests for operations with tags.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b9822294fedb7cf3d16d253853d92d274657916d..5fcf281dfbf8d601fc934d890db79f7284b19402 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -2,7 +2,6 @@
 
 test_description='GIT_EDITOR, core.editor, and stuff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 unset EDITOR VISUAL GIT_EDITOR
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a0296d6ca4019e08e7e8473ee22eabee513f5879..932c26cb45b6e3702063baec6fca02078813c4cd 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -2,7 +2,6 @@
 
 test_description='Test automatic use of a pager.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index f908a4d1abc5dc6608b4473937a614267013f3a2..d6cc69e0f2cbd576ff6ff81720de63f1e9cf86bf 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -2,7 +2,6 @@
 
 test_description='git show'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 0ce8fd2c895ddae895d6fd0bb7c531d1d712241c..93fbc92b8dbc297512050846c4f00ec803dea4a9 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -2,7 +2,6 @@
 
 test_description='filter-branch removal of trees with null sha1'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index d9add2162e9c64d8fd5341cf83f123c7c57b7324..520f96d09fb71778704119929012a40aa7c0072a 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -2,7 +2,6 @@
 
 test_description='setup taking and sanitizing funny paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index c86abd99bf99cd6063f574ec5fa9e81b4593271f..1ff2714cb4990822fc4fe85370f57a311874fed5 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -5,7 +5,6 @@
 
 test_description='skip-worktree bit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.full <<EOF
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index d984200c1733b50ff346e01910e4e3b5a3db331b..cd5c20fe51b3727035d56245c17568030f87d455 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -5,7 +5,6 @@
 
 test_description='test worktree writing operations when skip-worktree is used'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index effa826744bf5834c7579c6aa62a6aa52b63d0ab..6f526c37c2776e6288a1abe5860b6a9efed25183 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,7 +4,6 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 0efd17b363b887790b72d12e640c329c56921130..80359d48f7ca196f18afe74239ae61664e81e975 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -4,7 +4,6 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index aaeb4a533440df495d99e3b123f1640afe4374e7..0f4344c55e6421d605ab7364bc2fedfe9165b02b 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -5,7 +5,6 @@ test_description='basic work tree status reporting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 64145a05b1fd4ea1b75844a7e3690b790753c30c..2f9bea9793cec8b2900c35b3add315b67192a882 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -2,7 +2,6 @@
 
 test_description='git-status ignored files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<\EOF
diff --git a/t/t7062-wtstatus-ignorecase.sh b/t/t7062-wtstatus-ignorecase.sh
index caf372a3d42ac362c96bbbdf340f27688a565130..73709dbeee287932b3d925aad78f5c2d3f216a52 100755
--- a/t/t7062-wtstatus-ignorecase.sh
+++ b/t/t7062-wtstatus-ignorecase.sh
@@ -2,7 +2,6 @@
 
 test_description='git-status with core.ignorecase=true'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'status with hash collisions' '
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 13fea7931cddef581cf4a6460aaca4c770e1d287..8929ef481f926ce8eee1414b852c3e14538afa9c 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -5,7 +5,6 @@ test_description='test untracked cache'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 2458e9d0ebaa1546575874f7f83df9aadf990803..8bbc5ce6d9886cb1fbe2506df2259e284ca5598e 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -4,7 +4,6 @@ test_description='git status --porcelain=v2
 
 This test exercises porcelain V2 output for git status.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 89cf98b30c8f96335180bccfe7fe07b7156febc9..33d5d5b76e7d17b2efa1b2cb426a9f67f513c9b9 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -5,7 +5,6 @@
 
 test_description='git reset should cull empty subdirs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e9a6cc72658c53090077aa9d37a88f5c3826b047..0503a64d3f23cbb5065a1fd83e4051bd34f4bff8 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -10,7 +10,6 @@ Documented tests for git reset'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq ICONV
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 18bbd9975ebfda330d0727c600bd0cec4b8b5181..871e438118a4bcf6134630823d55d920ccae3af5 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset in a bare repository'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup non-bare' '
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a6aeb9579abe5b7b97b400aca8c7d0..7948ec392b3599a3884d97ae21f5deece84e638c 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -2,7 +2,6 @@
 
 test_description='reset --hard unmerged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index f4f3b7a677aa16539f8277ce3d4132ade0b17168..fced8adabd47952c1f22bc8795b2e1582400576b 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 88d1c8adf42eec1c219f50b9765d5b3c10d706fa..df20c0f0ccd21019237ab4ef235dca4b0a7431de 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset should work on unborn branch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 020db201d57c3c38e75a0e2b9a38c2b3455a9309..9162f591fb2b86586926ecf64efe3438836c7c0c 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='reset --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 7ee180f81da4f9e0ae312f73a87ab9775ef18e1d..61669a2d2102b80f886a7b95f87a6d866fdc36bd 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests for "git reset" with "--merge" and "--keep" options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index 01b7c3503ca882cd292f2eef252a977ac5dcc183..07b919731ae87a2f87e5e00459561c88c403a80b 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests to check that "reset" options follow a known table'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index b0d3d93b0b48b15d2ad70d2ea833837a27702b9a..a3e2413bc339533ef09a9092b2918b7265645e68 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='reset can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index 58e55a7c7791616fa22efec12c79350c308fcaf9..c10d94fe3d3b01dd401b1597eaa32a7044219f0f 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -5,7 +5,6 @@ test_description='post index change hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 2d984eb4c6a167c3c0f1e072a66aa90fe7b15660..793da6e64ec5dfdd860d0921d5438e819f14a77d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -23,7 +23,6 @@ Test switching across them.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 54fed91e391d7514a46bda158b35a79de1b5324d..00d4070156243b95b39013c0c7e8c54c2e368dd9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -5,7 +5,6 @@
 
 test_description='git clean basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 git config clean.requireForce no
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 4afe53c66ae57acdadc7177b98fd0aacefdd576c..f743e5b8f44e79b7763dffabfeac005a26ceaf86 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -2,7 +2,6 @@
 
 test_description='git clean -i basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 098d8833b6599d935e095453b3b3a865f20b6bc2..981488885fba49c57176b8d5054b06ac6bb8f4bc 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -12,7 +12,6 @@ subcommands of git submodule.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup - enable local submodules' '
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 542b3331a78f4db27dc5d99d3364f780f4db4548..9c3cc4cf4046befd76e0239c831d61b33196ee86 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -17,7 +17,6 @@ This test script tries to verify the sanity of summary subcommand of git submodu
 # various reasons, one of them being that there are lots of commands taking place
 # outside of 'test_expect_success' block, which is no longer in good-style.
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_file () {
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index aa2fdc31d1a672cb229457b05adcce90bd204aa6..25b33a1e8753b432225daf4d9766802b48eba6ac 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -5,7 +5,6 @@
 
 test_description='Test rebasing, stashing, etc. with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 19b6135d11744031c8777c3bd66c752d6ab9ba75..bf97d4f851134af8f86f7479ae6d247c21780d8c 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -11,7 +11,6 @@ These tests exercise the "git submodule sync" subcommand.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0f0c86f9cb20cefb4c33ff01750a5d30790fbaf9..297c6c3b5cc4b8889941f81422c5544db0ac2243 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -12,7 +12,6 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9f688932613598bc558e1dddf0401217c985134b..8d7b234beb8b09b2f6dbe459aad56315612925b8 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -12,7 +12,6 @@ that are currently checked out.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 7e1afa9ce470b14dc050eed0b23610b38b6a61bc..f860e7bbf49f46659ef71e5c4178e2885b4c0912 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -5,7 +5,6 @@
 
 test_description='test clone --reference'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index 574a6fc526ea0c22ed2ca9df925854235632bb42..374ed481e9c64b9813a11b57c80f7b6f22c791e1 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -13,7 +13,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index af0de496e07470df03e9dada0247daf8d53850f0..31271f8e0a61f7b071c770f9efad0e235920f37f 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -10,7 +10,6 @@ from the database and from the worktree works.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index f77832185765585e2bda1677f8cbbe13841127f7..0490499573fd39d2729a9b3b0d2a417d803eea77 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -6,7 +6,6 @@ This test verifies that `git submodue absorbgitdirs` moves a submodules git
 directory into the superproject.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index b9c89b10198140deaaae467d016714bfbbd2d871..9509dc18fde90919fa316fe7aba5d7a5a6a851a9 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -9,7 +9,6 @@ This is a unit test of the submodule.c is_submodule_active() function,
 which is also indirectly tested elsewhere.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index 24f30e3bf9c6440eca92838b42ae330a856f3fb6..e2d75c7f16c6aba1a9b9eb3c05060ca52a4736d1 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of common mistakes people may make with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create embedded repository' '
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 2ab566e71787ab6f1f77eb97b6b476c5f3fbacbc..0c605fd271a696a4ef77adadbfaaa8b17582070f 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -2,7 +2,6 @@
 
 test_description='check handling of disallowed .gitmodule urls'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index dbbb3853dc08537abdd482eb3f92e2bd44cceb45..5e3051da8bb362fe01b80f5bc20ef0d736886a22 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -4,7 +4,6 @@ test_description='check handling of .gitmodule path with dash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index e1d9bf2ee30d0ce840a1b213f54e84401bb7c809..dde11ecce806c43272bdc59c6eb73a7c6ce241ad 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -15,7 +15,6 @@ also by committing .gitmodules and then just removing it from the filesystem.
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index a5d1bc5c54ae095f79bf9b3ee420ba004bb18a88..08ed51d34ff5436550df026a82aec73113f9097f 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -9,7 +9,6 @@ This test verifies that the set-branch subcommand of git-submodule is working
 as expected.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_NO_CREATE_REPO=1
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index d7fe910bbe1fe638818e52bb0191cd79b8dfd66c..bf7f15ee7973958970dfe0d1b34cea9d25e635a9 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -10,7 +10,6 @@ as expected.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 479c8fdde1180bf9d0486a2141ada4aca155d37a..ce64d8b13721732a30d8739c72dfdba670060454 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -10,7 +10,6 @@ while making sure to add submodules using `git submodule add` instead of
 `git add` as done in t7401.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index c1686d6bb5f6f01a30dd277e79833375781148bb..f21e9203678b94701281d5339ae8bfe53d5de0ed 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -2,7 +2,6 @@
 
 test_description='submodule --cached, --quiet etc. output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t7423-submodule-symlinks.sh b/t/t7423-submodule-symlinks.sh
index f45d80620185b2d791e095179f22b6a967ab097e..3d3c7af3ce520acad252d08c6506798b0f486fc6 100755
--- a/t/t7423-submodule-symlinks.sh
+++ b/t/t7423-submodule-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='check that submodule operations do not follow symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare' '
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index b43ef2ba675b8d340ceed10ea12862817aeb1120..559713b60773a41373c4cb14114d6c9d50624616 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -2,7 +2,6 @@
 
 test_description='submodules handle mixed ref storage formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_ref_format () {
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 4a9c22c9e2b627dbb666a9b52052aea215869297..93677946411baca6590a67d624453265e440ab0d 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -13,7 +13,6 @@ Such as:
   - symlinked .gitmodules, etc
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 379d3ed3413d82374ce098ce7549a4c0adca059d..4dca8d97a772d63566a9ea19121d8019cafb766c 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -7,7 +7,6 @@ test_description='git commit
 
 Tests for template, signoff, squash and -F functions.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 52f5e28154e2ff797bf352ea916e92599912ac19..cc12f99f11534b898d11a0fc7bbb5d339730ccc8 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -9,7 +9,6 @@ test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-diff.sh"
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 84f1ff52b6738d3123de4d66f1d10d744bfd9e4b..b37e2018a74a7b28725fa277a95cca516daf5cbe 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -5,7 +5,6 @@ test_description='git commit porcelain-ish'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit_msg_is () {
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index aa004b70a8d1f1ab093b962a232524eaf4e851a1..ad1eb64ba0db16d4f1452961c0a226fdf2e5cce0 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,7 +5,6 @@ test_description='pre-commit and pre-merge-commit hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'root commit' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index d1255228d5ffaa2b7b7333000e3e39468ee94bb1..c0f024eb1ef4e9e60edef15ea8c7edcf8d98f661 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -5,7 +5,6 @@ test_description='commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'with no hook' '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index b88383df9e48e19f76d2f494151a3bd0e7c0fa61..2128142a61c60da918381f6b6f74ca612ac9227b 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -5,7 +5,6 @@ test_description='prepare-commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up commits for rebasing' '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 46566d529e8725fb3b26e7664f2f8d44c2458a1c..185fe7e78efc32c21ce11d683d744cd67673f8da 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git status for submodule'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_create_repo_with_commit () {
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 4c7db19ce7eff05cb660018f8b8db3182e244efe..b53d71c0862396cc9a6eabaaad2041e476173a46 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -2,7 +2,6 @@
 
 test_description='verbose commit template'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script "check-for-diff" <<\EOF &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 773383fefb50a9ac673b84d89ebd63ba92792d3b..f9a5c98f3f3ba9eea75178d0ebfeb0887ec0597d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -5,7 +5,6 @@
 
 test_description='git status'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index fd8c8f8f0bccf81eed7711e178912753ac200d72..8e373b566b091d02e51d0894f5fdc605b4863acc 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -5,7 +5,6 @@
 
 test_description='commit tests of various authorhip options. '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 author_header () {
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index eb229082e407bf76525efe5484ed6eeda007e7de..0d2dd29fe6a12c20ffbbe169afabd4c31bc6545c 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -4,7 +4,6 @@ test_description='signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7511-status-index.sh b/t/t7511-status-index.sh
index 4ffa45a7bf3599b78624fbdaa39b828f4d7a0643..b5fdc048a54a151f78b10e9d379383a421cf3726 100755
--- a/t/t7511-status-index.sh
+++ b/t/t7511-status-index.sh
@@ -2,7 +2,6 @@
 
 test_description='git status with certain file name lengths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 files="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z"
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index cdd5f2c697938839f0d15987a12edb656ee0a462..802f8f704c62eb11192bcc82ecd35f0ae53b5a6a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -10,7 +10,6 @@ test_description='git status advice'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 502752c0f3ca0b42b25bf0d89730974d575ebc0a..818a8dafbd29e57abb1f2475c8b3f2951b87a412 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -5,7 +5,6 @@
 
 test_description='git interpret-trailers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # When we want one trailing space at the end of each line, let's use sed
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 03ba0c0e734e9b7ecc3ba4ac944af8fa83cd925a..075db69b429f5ef0985fd5cd37e7d9e34ebb78c9 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='hunk edit with "commit -p -m"'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (initial)' '
diff --git a/t/t7515-status-symlinks.sh b/t/t7515-status-symlinks.sh
index e3d6bb67bf95a666f2268e412db4301513746b2f..9f989be01b9f107e145519fd7a7fd8ee31800a47 100755
--- a/t/t7515-status-symlinks.sh
+++ b/t/t7515-status-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='git status and symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index bb95f09810b704b552352d90b6ec2a046c7d0fc1..de7c4ca790148403ddefd94ae9c9fbefb8c9cf40 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -2,7 +2,6 @@
 
 test_description='git commit races'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'race to create orphan commit' '
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index efc6496e2b27f3ec74431d625e64e52c384e0383..163ae8046850e729ef5e329f6589faf5381e9cdc 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -9,7 +9,6 @@ test_description='per-repo forced setting of email address'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a likely user.useConfigOnly use case' '
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index b37de0af49ff400e89b86271dd9b63b894dad56e..d3ea4d603ff871cc9e0ac8c5eed1170d107c9fb1 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -2,7 +2,6 @@
 
 test_description='corner cases in ident strings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # confirm that we do not segfault _and_ that we do not say "(null)", as
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 0f88a58a8192e816669b1a8231157aeac87522f8..7ee69ecdd4aa2c15dbde3ba0a976d986bff17fb3 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -2,7 +2,6 @@
 
 test_description='git status with file system watcher'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 3b63c34a309de5e13a0c52c365d02289c6aa87f3..bcfe15d51d07060b46eda2c03250178e2734790a 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -2,7 +2,6 @@
 
 test_description='ignored hook warning'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index edce10f998eecb9154f6188f3a6f3747fcfe56ed..a88b02b06ed34234abfb3aa3131dd31a7d364141 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -2,7 +2,6 @@
 
 test_description='git status ignored modes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup initial commit and ignore file' '
diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
index a8fceb6a47c3487099b8df3378e7fb3ac085c54c..82b5e4aa41291562d5e960422d9f2b7c38c0266d 100755
--- a/t/t7524-commit-summary.sh
+++ b/t/t7524-commit-summary.sh
@@ -2,7 +2,6 @@
 
 test_description='git commit summary'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index a9210d3a3a92213728a32599defe664e1def0ffe..d409de1a33fd79ffe72e466a82047d9418c9d1a9 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git status rename detection options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index c97c550021e837a6fd6e59f260352673d92e85da..3aabbf35a1c172cb8c3f419090a2b2ea4ab8b8bf 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='commit --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 68e18856b66ab77c5639c3cdc7a1798c0fcd9625..065f78063629cbfad15e9360836544da34a16484 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -4,7 +4,6 @@ test_description='ssh signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 65fd3d8552b0fbcf95bc1cc1332015a1ece2d3fd..ef54cff4faa8d3916111a47fae48aee847323d46 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -29,7 +29,6 @@ Testing basic merge operations/option parsing.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c83298ba6830e0f067eb2061284321bdf7d5daa6..199a1d5db313514111fbd3f98b7a4d132f132937 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing pull.* configuration parsing and other things.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 3669d33bd5a15fc19fbfd2cbea14507c8e273642..ff085b086cc38f36a180e22ab02bbea12a29cc0c 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing octopus merge with more than 25 refs.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 0e85b21ec82cc64e7d1e519c269a9bdcb189e01b..4887ca705b330e8cbf6f25595cbcadfdfd67f9f2 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing octopus merge when reducing parents to independent branches.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 0 - 1
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index eca755510160be797ff1b08b67f4e18fa10dddb9..cd4f9607dc13ce7acfebc62d67bb4dbf1ef46135 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing merge when using a custom message for the merge commit.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_merge_msgs() {
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 62d935d31c2e1dc9cbca3779407b6b86bc5ce4c5..5d56c3854647b2f2bc2fdf4221b1f76f5d0b0629 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing the resolve strategy.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 135cb2308565337afb25fbef9730972b7bac09f0..81fb7c474c14c1d615be9de76e2bd2a032fefac8 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -14,7 +14,6 @@ Testing a custom strategy.
 * (tag: c0) c0
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up custom strategy' '
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
index 9001674f2ea2201836613e4909d9442062f609f4..89a62ac53b3d6012d13b3b1ce0dfa97d494060f2 100755
--- a/t/t7607-merge-state.sh
+++ b/t/t7607-merge-state.sh
@@ -4,7 +4,6 @@ test_description="Test that merge state is as expected after failed merge"
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'Ensure we restore original state if no merge strategy handles it' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 2179938c437e47552eccb7af85fa3e4669ccc1bf..0b908ab2e7128052a0513e740b54ba308b9feadc 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -4,7 +4,6 @@ test_description='test auto-generated merge messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_oneline() {
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index 8b1c3bd39f2249417099ea2f24218268925909af..330d6d603d77236788ee932cdcc288731a7aa388 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -4,7 +4,6 @@ test_description='git mergetool
 
 Testing basic merge tools options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 5c5e79e99052c324fcf47556174045e6d7af3c91..22b3a85b3e960e4d40024179b1fbaef3355d304d 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,7 +10,6 @@ Testing basic merge tool invocation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 992a8f98749baecbe109f8b839d270aecfb77fe8..d6975ca48df3d4710940a4b5a040c0598b0d0628 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -25,7 +25,6 @@ Next, test git merge --abort with the following variables:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 84ddb568517cee76f519f6faaac3e3a89e3e68ad..337fac0d8446f064c3eb5105ae41f138657a899a 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -4,7 +4,6 @@ test_description='merge signature verification tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index cf96a35e8e7b20975628cce6a5882c18c32fbeaa..fee258d4f0c2c0d4b230891eeb93d522d27a4979 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -8,7 +8,6 @@ This test runs git merge --signoff and makes sure that it works.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup test files
diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
index 9a83be518cb73b81d379c1e941c4ca55b1e67914..3b1aad0167a402e8e0dbecad4c525fa3db49ede8 100755
--- a/t/t7615-diff-algo-with-mergy-operations.sh
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -4,7 +4,6 @@ test_description='git merge and other operations that rely on merge
 
 Testing the influence of the diff algorithm on the merge output.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c4c3d1a15d9abc44f682480803226b18c97c1fb8..be1188e7365b19cdf7fb96115ae83efc23038a11 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index fe6c3e77a3c9add78dadc421be9b0b00b0f6bcd9..5715f4d69a47632c76e6b31c0719b24264c636e0 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -5,7 +5,6 @@ test_description='git repack works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 fsha1=
diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
index d151d4f6036e92906ca887fa17d9ffcd8f89cc22..cd91766e78a77be47bf964173c9c3cd3ae38461d 100755
--- a/t/t7702-repack-cyclic-alternate.sh
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -5,7 +5,6 @@
 
 test_description='repack involving cyclic alternate'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 8877aea98ba863dd7bf2f6123aabb6aa48995296..9fc1626fbfde8989348537903a266eb6cae8600d 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack --geometric works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 5db9f4e10f75e92094c9a58a61728dc868e80479..959e6e2648897e05d8a1993338ea63e109e3b923 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index f67b9345b8a0130c48fec0add93526a9aee10190..cc917b257e3bb82451d027d05dce9dd91825ec63 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -11,7 +11,6 @@ Testing basic diff tool invocation
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 difftool_test_setup ()
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1bdb8e5a999b1bf9598bb89ab30dd939dc850de1..64ac4f04ee97ad5ec51a17f240ad3fccb17c559f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -9,7 +9,6 @@ test_description='git grep various.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_invalid_grep_expression() {
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index fe38d88a1a6ab151cb318429ec64c1c49ff24fb3..3160be59fd2e26629fd128ad031f5fb457ba0736 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -3,7 +3,6 @@
 test_description='git grep --open-files-in-pager
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 unset PAGER GIT_PAGER
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 31c66b63c2cb008979cc64c3f9df203ce5ed1aeb..ac7be5471452a0a8b2123dc39be80caf3520e9db 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -2,7 +2,6 @@
 
 test_description='grep icase on non-English locales'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 doalarm () {
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
index 1227885737b859fd4937f1f78a0a9250f103703c..701e08a8e5941d711ffbef52da972acb7ab9a41e 100755
--- a/t/t7813-grep-icase-iso.sh
+++ b/t/t7813-grep-icase-iso.sh
@@ -2,7 +2,6 @@
 
 test_description='grep icase on non-English locales'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success GETTEXT_ISO_LOCALE 'setup' '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 55ed630e77ed0dada71e3a092433a7e69eb9f537..167fe661504a2b609583750884bb40a902408e04 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -7,7 +7,6 @@ submodules.
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index ac871287c03a9facc3b6530ce82b3c40ed8d9cad..90ebb64f46ebfaeed11c0a0d36cf015e415423b9 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -2,7 +2,6 @@
 
 test_description='git grep in binary files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 4353be5adb7b0605e5bc3db9b1b29ecf0251fbf2..0088eaa0c918aa4afd91d590f19f840e9a58661d 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -2,7 +2,6 @@
 
 test_description='git grep with a binary pattern files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 nul_match_internal () {
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index 0ba7817fb76bc12abce00ddaaa2109a53a77ac84..eb595645657fad7f1dce4cf5fca6ac57eeb6bfce 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -33,7 +33,6 @@ should leave the following structure in the working tree:
 But note that sub2 should have the SKIP_WORKTREE bit set.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c224c8450c85f567bc29258e18b4a59fe6682f0a..57d64b5b40ba12c9f3553120156f2342bd9c3ef8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -2,7 +2,6 @@
 
 test_description='git maintenance builtin'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index d4346989195d53f10c30b1dadc815ffed1800c02..d7167f55397f57f35a75eccff662c13b4f712ec8 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git annotate'
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 35966340397591eee54a0f82d00eed70b3814e98..0147de304b4d104cc7f05ea1f8d68f1a07ceb80d 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 6288352f5777b3eed84b891c79ded307502f8ed6..731265541acf9fb0ed4dcc216b662daa897f814d 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -4,7 +4,6 @@ test_description='git blame corner cases'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 2c2a0b33f9bad5838ea14ebb908a0c1d066f2b4a..35414a53363424190e57a553302c6384e3664e2c 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -6,7 +6,6 @@ test_description='git blame on conflicted files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup first case' '
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index fa765aff99aa7fbfc4737cc91aab2a6a1bce30bb..81847ffb9a88bd951807a7d4e2e0a945d567d1d5 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame encoding conversion'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 42f8be25a3fdf98c0e1fc221fe8a43b8c103b69c..07a287ffd3e5c1d05e8e2513d14359022a6da2a3 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame textconv support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_blame() {
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index c8266f17f14af3c1af34661ccf9c039d04cfbe31..c3735fb50de4cbb7a5ba68449c7f3809ff9b5494 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file textconv support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index fb5d225a671447cee24906dc51a5a1587e052564..c12a4196d66cab72d158661a5f92cd18ce20cf28 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -2,7 +2,6 @@
 
 test_description='blame output in various formats on a simple case'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
index cc511084648abd5406cf53b067531c485544a41d..c808b81962185831b3e3f4b41fbc719152bcd2d6 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -2,7 +2,6 @@
 
 test_description='blaming through history with topic branches'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Creates the history shown below. '*'s mark the first parent in the merges.
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index eb64b766bdfa24ee6fa3e8578188844b10e1ef66..b3be2aa387f1055f1b34fcd2c71be29456bd9038 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file filters support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index da1801f4d23edaf15b156d72ab8c98b40fdc3cea..c66494f5ba73357f11644c710e0906da9b40c36a 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -11,7 +11,6 @@ not bother testing that the non-C case fails to find it. That is how blame
 behaves now, but it is not a property we want to make sure is retained.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # help avoid typing and reading long strings of similar lines
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 9a79c109f2e9853158f2efaa64880c4f93b53d88..c3a5f6d01ffe5cff12b868e7cbe5a09dacbef011 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index d33788d86772936a4e1ad0a1acbca9b2d9b57662..370b76814927f3ec460272f983daacb4d303979e 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -2,7 +2,6 @@
 
 test_description='ignore revisions when blaming'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Creates:
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 933222cea15073411977b47fa343e2e221870c07..f5dcbd9e8243fb791b4bceb29eaa1e12a6eba7e0 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame ignore fuzzy heuristic'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e2430f7bfabbc1050fdcf84db05cdc1e2beeb0b4..0c1af43f6fbb41b7482776d9f03e7e28166d3bcb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,7 +4,6 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index d5b98e615bca6647761e0e6f046d474ea8275015..7353815c11b2bb3355e385786c1528a50aa5c6cd 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='git column'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 3be063afab590673013295c26a92efba192955e3..85a5074b5e2cb74bebdfcfc1f7d95c2a881eef78 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -2,7 +2,6 @@
 
 test_description='help.autocorrect finding a match'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 3d4842164c8915fa28514028b1f1fb3e4da78db4..a44eabf0d80fa8db991d77af4da49f58750cf43a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -4,7 +4,6 @@
 #
 test_description='Test export of commits to CVS'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a30b2c9f7055eb85d70c896faa5d78b5c0dd8f16..027235d61aa35e9ff3110b72d50ce012e72327dd 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -2,7 +2,6 @@
 
 test_description='test the `scalar` command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index c16ea67c1dc36631b222db6c45dbbd62d0014c0a..7869f45ee646dd511b16e404a8b165200f9c8608 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='test the `scalar clone` subcommand'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-terminal.sh"
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d26ce9d481cf34d87ce1a470580270b..9bd66ecf2e023cc33ee0f4052bccd79da391632b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,7 +7,6 @@ test_description='test git fast-import utility'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 58413221e6a73dcb464f0f226616b0bba4ea30dd..1ae4d7c0d37db2d10cbc08ce90505b291e70171b 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -7,7 +7,6 @@ test_description='test git fast-import of notes objects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index d8b1f9442e8f6e020d2e3ff736cf4853f3b47036..ec8c8652c6ce0720cb4ae0c7e2e238eb0719f31a 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 test_description='test git fast-import unpack limit'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create loose objects on import' '
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
index 4f5bf40587cb03aeed5b564c21780010431008ba..f15c8c0213ea2125f20fc31c38cf642a2832baf4 100755
--- a/t/t9303-fast-import-compression.sh
+++ b/t/t9303-fast-import-compression.sh
@@ -2,7 +2,6 @@
 
 test_description='compression setting of fast-import utility'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 import_large () {
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 1f776a80f3b4b9c12b16914069f5717950ae7ac8..6c50adca009c6d5afdaa45e816ce818975193067 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -2,7 +2,6 @@
 
 test_description='test exotic situations with marks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup dump of basic history' '
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 9595dfef2ee660ca79789021326fb6b9c85adcb5..aa33791b77bb754cd7774cfc2627a85ebfaf7689 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -7,7 +7,6 @@ test_description='git fast-export'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index c0d9d7be754d5758f25d0f629a7c98fd37d5cdaa..156a6474847cf6e5bc86df2212ce98211986e6d6 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -4,7 +4,6 @@ test_description='basic tests for fast-export --anonymize'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup simple repo' '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6da7440e73c5fa7f9b17a67f0655f0b4d8520510..e499c7f955125eb25ce0dfdcd78012adf8cf4d7a 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -11,7 +11,6 @@ cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index a67e6abd49db3da5acd0ee9fb1b4333da063fe4b..a34805acdc25cca244b5d10e1bae68f5937a279a 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -12,7 +12,6 @@ repository using cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 marked_as () {
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index c847120d52dd8ca4c5f7dfb8e0ccefb9a6377c7e..2ee41f9443eefb234dd48786f8c57d109f7dbbe3 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -8,7 +8,6 @@ tags, branches and other git refspecs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #########
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ccfa4153840acfdcf9e2002baa1bcf90a7ccd0a5..7679780fb87b4f14e9c0f5a22708b1e8925a4d53 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -13,7 +13,6 @@ or warnings to log.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index c900231079cf750f0f1111ca74ddca7803becf6c..32814e75df5b0d796b292c2ac39d370c636e5e67 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -13,7 +13,6 @@ code and message.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 #
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index b41ea1933143814d895be93053382052637c34b4..81d562555799bebe80b5cf36b1063e28d377ea8c 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -13,7 +13,6 @@ in the HTTP header or the actual script output.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 41fcf3606b39b793cb38e41c9bdd90a4d9fe3e4b..568084921896cfc59c04d68814467d6f7443a75e 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -4,7 +4,6 @@ test_description='git cvsimport basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 if ! test_have_prereq NOT_ROOT; then
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index e00766949573cf2f3e11b8b0e62378a14733aef2..116cddba3a5da871d078a50f3559d40fbb208102 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -35,7 +35,6 @@ test_description='git cvsimport handling of vendor branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9601
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index 3768e3bd8cc8e3a5d1a9cb0e51416411ed4303c6..e5266c9a872f15a9649d4f0532d823b86e50aeb6 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -7,7 +7,6 @@ test_description='git cvsimport handling of branches and tags'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9602
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 2a387fdbaaefe0cf8ac424cd7939514904239cb5..1ee966c256afbada83f23608c4768dccf334b3c8 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -13,7 +13,6 @@
 
 test_description='git cvsimport testing for correct patchset estimation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9603
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 9cf0685d56fe51311caabcabf9d26f09d631f5ce..57a3bef2ecedfba0f7de3fb7bef42876af7d18b2 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -2,7 +2,6 @@
 
 test_description='git cvsimport timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 test_lazy_prereq POSIX_TIMEZONE '
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 44316971224bc4cd6d510cd2cc31bb934e799ea8..9c9e3b5eb11a0f90be157e31e17bc50122fa1820 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -5,7 +5,6 @@
 
 test_description='perl interface (Git.pm)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-perl.sh
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 3e6dfce24833a061acff8babe5135885708aab41..0816763e46639cc19bb5e15598303638c992a2c7 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -5,7 +5,6 @@ test_description='git p4 tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index cdbfacc727a7c676cb9a31f3a14019461feea4f4..c598011635ac2f44d0764acaf1ba7c53f569514c 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -5,7 +5,6 @@ test_description='git p4 tests for p4 branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 1bc48305b017897a143f3d3b660c506e8f1f423e..df01a5d3389861faf2110520678778e48f3ec970 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 filetype tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index ab7fe16266872c83235e4cd083ea2e44b0083567..2913277013da56e98b9ad8b6ec3ea47ccbace103 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 transparency to shell metachars in filenames'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index c8963fd3980e0eedff9530d0e9a9d32862b9b05e..32364571063d4c6001105d0929ca81fe50e2a87c 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 label tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 72dce3d2b46f4dd103baefb7a833917e60b151b0..90ef647db7e610b825cc92d51ee2a5379dcf05b3 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 skipSubmitEdit config variables'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index e4ce44ebf3783be3a373557cdcacec6fb20416c2..c26d29743307b5546d80e9c6d0cd16442a43a421 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -5,7 +5,6 @@ test_description='git p4 options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 342f7f3d4a09d20af8e9f00727f91fb5523e9e96..58a9b3b71e6d88dfc9e3086fb515362e7c31e34a 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 relative chdir'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index f33fdea889edc339267ff4bb7bf7d94809897952..9c9710d8c7b8713f4dfb0cfacd0c07ce71a71226 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 client view'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 15e32c9f353a73b47b7e2aab0be3636b3e5bfe5b..5fe83315ecd57a81055bdcf2d055122ec53fd3b8 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 rcs keywords'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 CP1252="\223\224"
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 52a4b0af811294406b8478df161abe37c32ff0cb..5ac5383fb717153b893302eba7952b6962de70a2 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -5,7 +5,6 @@ test_description='git p4 label tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 46aa5fd56c7706ab23651112c40919cbdad2b354..254a7c244698a0140d6f5605d3013f72d9775310 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 wildcards'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 0efea28da2cb9d6f09a024e174fc0ff50a303872..fd018c87a80636d7bb286fe596f299bbbbe6828b 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 preserve users'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 00df6ebd3bdc03f3ebef6cd20af66325e6ee713a..2a9838f37fe293738a75e626041531456c274f72 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 rename'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 92ef9d8c242559b9d7b90b975d9d9905922ef24a..c766fd159f14b69eb46f9dc9bfb4357fdd7a5e34 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 submit failure handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index e687fbc25f60f5f4e8d4e540f99e072370d9d209..5e904ac80d85226a74296774ef4279369da15d4a 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 locked file behavior'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index 3deb334fed1c6aa068861e4e1c196e9c0edf39f1..ec3d937c6a73bb8d89de51839af4bba4c3a73910 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 tests for excluded paths during clone and sync'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 091bb72bdb62bde767de2ae346dc361de9e2f9be..de591d875c2bbc94fd1c9b093867d23f3ce1b00c 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 fetching changes in multiple blocks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index 985be2035716207a38cae6c632de647b29606c24..b4d93f0c17c35722184d09d354556e59fef8a2b4 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -2,7 +2,6 @@
 
 test_description='interaction with P4 case-folding'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 if test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index 48e4dfb95c03c3cc5a1592944cc1c4d03d056118..fa1bba1dd93614c8ad5c7f4a37c5b612440fd0eb 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 handling of EDITOR'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
index 49691c53dadddb85c7dbaf0e0a52336d2b91d349..ef80f1690bcb9ad153df900e277ef48ce8e4e62e 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories with path case variations'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d with case folding enabled' '
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index e62ed49f51e02263c4a1c5615f6fe825939f8a6c..572d395498e30a3743b77c577d7c4b91d714b392 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories with non ASCII paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
index 98a40d8af3793b61df8718c832f7f19705bf6f67..88b76dc4d6c26fc99e32c91a11b2eb5bb7118e2c 100755
--- a/t/t9823-git-p4-mock-lfs.sh
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and store files in Mock LFS'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_file_is_not_in_mock_lfs () {
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index d0b86537dd975a5c905a318e1df1a4672ed68e73..6a60b32349391304ad4bb3ef85122e27885ccf4d 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 handling of UTF-16 files without BOM'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 UTF16="\227\000\227\000"
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index 54083f842e9259ca21f0e6e5f1fe8a20bb74092e..fd64afe064e5a937b4a15d18f70e87cd524067c8 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and keep empty commits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
index 3476ea2fd3b5773421f989b974e5eb88663a7845..d3670bd7a24dbf3cdc350939d6d130bd662f3e73 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 support for file type change'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
index 7c8f9e3930406de82e80817a25a0bd9eb9324fbf..ca6c2942bdf200942cc4122e6172a120e0f1d1c1 100755
--- a/t/t9828-git-p4-map-user.sh
+++ b/t/t9828-git-p4-map-user.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and map users'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
index 3fc0948d9cff2060381eab9bb8178419d656a157..88cfb1fcd3f0a1401fd1cdb10f1fe697a5c4aaa3 100755
--- a/t/t9829-git-p4-jobs.sh
+++ b/t/t9829-git-p4-jobs.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 retrieve job info'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 02561a7f0e62f7919ac897d733c4edd3c7e9b695..3fb6960c18fc0c2eb549f09c66d92b3f39822653 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 symlinked directories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index f287f41e3741e10b2576a9d554a8be20d1778fe2..ff6c0352e688246e9b97e063679889c2583c459e 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 with server triggers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index a2667754086a5c64addc6c079fd017d313809883..6b3cb0414aa08cb62817ba9f0710e6db4d282787 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -6,7 +6,6 @@ last_shelved_change () {
 
 test_description='git p4 unshelve'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index da1d30c142c4fae651953537ef11512b387e9851..e22369ccdf5f15840546269d0cdef9e8a54ce698 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 errors'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index 565870fc740cb228d9b614920e13a53da118641d..dac67e89d7d720a916eec8a533d9b1f05101525a 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -6,7 +6,6 @@ This test creates files and directories with the same name in perforce and
 checks that git-p4 recovers from the error at the same time as the perforce
 repository.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index ad20ffdededdc9bc3099818a7ad5747b0470c864..036bf79c6674f6f1f0d667c7270674168428ffee 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -6,7 +6,6 @@ This test checks that the import process handles inconsistent text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 python_target_version='2'
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index 71ae763399c084129b3c17b00eb73cbee233b1f8..63350dc4b5c6262480cd0be8fd88fba714c55428 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -6,7 +6,6 @@ This test checks that the import process handles inconsistent text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 python_target_version='3'
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index f503f16d1b6a417bc7c7d160cc69433efa082b34..36566ace21b07ce4f2a74dc8e828863205a3843b 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -2,7 +2,6 @@
 
 test_description='git shell tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'shell allows upload-pack' '
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index 19f56e5680f678c22fc80a63907c804448c4b445..de7152f82713bf797aecd3f53bce6ef006524b7b 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -5,7 +5,6 @@ test_description='git web--browse basic tests
 
 This test checks that git web--browse can handle various valid URLs.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_web_browse () {
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cc6aa9f0cd36e3c39fa3ba93a450407fb89ce658..932d5ad75916980ad9fbbe62906ce540f99603d4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -16,7 +16,6 @@ test_untraceable=UnfortunatelyYes
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-bash.sh
 
 complete ()
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 95e9955bca1bed2f5f51127d1793ac71bebb23c5..d667dda654e2de7f32d5f7d065f6eac59ca9fdbf 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -8,7 +8,6 @@ test_description='test git-specific bash prompt functions'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-bash.sh
 
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"

-- 
2.47.0.274.g962d0b743d.dirty

