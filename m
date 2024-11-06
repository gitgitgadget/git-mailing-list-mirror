Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466720371A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905922; cv=none; b=iTYyTekWmtweIeYeXaxc/BmNEEO3MvxBxmFi4MNFyZA8fAnCKVABIrKPmfAInNY6lw0Xtk+Czl6Ts4VDbVBr5dV65k8gSxHDKWM27r6hlZGyZaMIuG78RVAzGj888eK1eHt9MoTw/yDseF6iP3YS3gE1XrxKJS6ot+A1R5pMpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905922; c=relaxed/simple;
	bh=Vm5//uL8dHmLc16w2vJjjcdXTpzYBQAh5Q/lltk81Rs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPjyeIXTXI427uTMWIvoTfyNY0DR27iuBnzz4EtixpLgJurq8FprIYyQfTO5fpzY+OWVSmZrF2br75D5/ULEpeLx1THcbA3QohytAZ0x3OHCZ1xsJZFJfVwL2+Q+czu7lNj9BM9O1ZyEbY1WxX1IV3F4olxUpKSp0NSGLw9AZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jOJNAEnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ElFIG3sJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jOJNAEnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElFIG3sJ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E88B711401B9
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 06 Nov 2024 10:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730905906;
	 x=1730992306; bh=FbrEFzrLPKJpqAeJMa9nQ6u5J97mBtiBOzHO86KAV/c=; b=
	jOJNAEnkYXq3sdg8btR+xhfQUvCMSL/NELcSPbvCyoh6+bvcVHXWX9eLy/ZyRmvr
	AW9eEZzlEqp9Jgt+9aatmydW3ybLA9UhrJnsb/9gWalgehyFcoZaefww8YeeXPLE
	mL0KFXRm3I1tWS43SYm+h0mel/zoELOf+q+V465m3PEKjP/qQaD67z319GHm7rgD
	CTy3j8c/Rea9W1idBzVTiGHwAja+FdqQ0hCpLrUrRt6IJ2yNzKl0u4v6YWCno0Vz
	UQXHgDgvTIcEl4SFbBkzZ0EjACSIriOpeqtw6KGmEHgiBw7UnGbyg+wp8+crUL1/
	VjplSvaxNfx3yBnyt4hVSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730905906; x=1730992306; bh=F
	brEFzrLPKJpqAeJMa9nQ6u5J97mBtiBOzHO86KAV/c=; b=ElFIG3sJ8yhYvIRcj
	Qh7OK7qb/IkpmIclPDKkqDBgd8TY02v93y4DTrhHQvXJIEKnUKDLQgJdBnnrYFcP
	KAykfu6fUeLQT1ZX6v8l5XguU0hJSDi4K7a54hcTQ659KRWARHFQw8xsoXB1JTz8
	35MkPylGhsXRRuN8pTAH1IuI8MVN8JYq5STCxGO2YQsXZmBPN8hVzAgicFPt1uKc
	gXwRhrfzDnzm0Wjhoul3HqYd+smPLfkhtw9i1xcmryI3CsiB8TQdr9zy6JPJ30ub
	wrYbWRej3xMbiTgvLayJdbCc77RpdpZY9wnKE3eS6BBpFbzqZC/p/LJCvM+LVBOy
	CxSJg==
X-ME-Sender: <xms:MocrZ5mnUlNpyXBmIcTnADImUmFb7eyz7jG968YXnKUl3ZhSeKCNUA>
    <xme:MocrZ03uxjPXwQBqD3Ql4HWTWS50xzvJEiWAlSo6tsYDPlChN9gLFbZmHuXgxJDnF
    K_XUU_8wanS_sqFbg>
X-ME-Received: <xmr:MocrZ_r8KDL2GqQhcArYuYtgieC-d-xkfwcoChpCWFMo3a04JIfXqVvfzTEP7gQ_MW2Ye4RzGNgIjPFZDBMmoPNAJAF8HPr9mzFyKjmOavQChw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgeefuedvffegff
    dtfeehgeekffelffdtvddtvdfghfegvdfhgfdttdeuvdehkeeknecuffhomhgrihhnpehh
    thhtphgurdhshhdphhhtthhpqdhshhgrlhhlohifrdhshhdphhhtthhpqdhpuhhshhdqfi
    gvsggurghvrdhshhdphhhtthhpqdhpuhhshhdqshhmrghrthdrshhhpdhhthhtphdrshhh
    pdhhthhtphdqfhgvthgthhdqughumhgsrdhshhdphhhtthhpqdhfvghttghhqdhsmhgrrh
    htrdhshhdphhhtthhpqdhsmhgrrhhtqdgtohhmmhhonhdrshhhpdhhthhtphdqghgvthdr
    shhhpdhhthhtphdqsggrtghkvghnugdqnhhoshgvrhhvvghrrdhshhdphhhtthhpqdgsrg
    gtkhgvnhgurdhshhdphhhtthhpqdgsrggtkhgvnhguqdgtohhnthgvnhhtqdhlvghnghht
    hhdrshhhpdhhthhtphdqrghuthhhrdhshhdphhhtthhpqdhprhhogiihrdhshhdphhhtth
    hpqdgtuhhrlhdqvhgvrhgsohhsvgdrshhhpdhhthhtphdqshhtrghtuhhsrdhshhdpthgv
    shhtqdhlihgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MocrZ5m-F3Ybh7X54pumwfyKu36o47pmvj5Z1Y8WReSMlfPvl5WOEw>
    <xmx:MocrZ31hqTwLSEvAssdABIku7bgr1gcMmVVlTbCOq3jOqHJNt8JR0g>
    <xmx:MocrZ4ts18fkjWlU6cSJ05BA-J65pevWzCQYrjCIKlJm-Mwfd2tiJA>
    <xmx:MocrZ7Wq_65h-MUew0m7G-qKL4QjuTg5WophRhSc8Cdd9Z6FSdZo8Q>
    <xmx:MocrZw-k5KZXY9nY3HuMF1LiIuSxIYfrnC8Xz4KNzLJhJJnOw2zpU8M0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41331423 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:11:20 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:11:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 26/26] t: remove TEST_PASSES_SANITIZE_LEAK annotations
Message-ID: <98e59f0f32bfab3233824248b43da6db4da3d7da.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1730901926.git.ps@pks.im>

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
index 0178aa62a41..4890dff4b27 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -2,7 +2,6 @@
 
 test_description='git init'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index bf3bf604abe..dfbcdddbcc1 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -7,7 +7,6 @@ Verify that plumbing commands work when .git is a file
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objpath() {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 66ccb5889d1..3c98b622f25 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -2,7 +2,6 @@
 
 test_description=gitattributes
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 8114fac73b3..3bdafbae0f0 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -2,7 +2,6 @@
 
 test_description='detect unwritable repository and fail correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index eba75a2490c..afba0fc3fc6 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -2,7 +2,6 @@
 
 test_description='signals work as we expect'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<EOF
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index fd373e1b391..53ced36df44 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -2,7 +2,6 @@
 
 test_description='test date parsing and printing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # arbitrary reference time: 2009-08-30 19:20:00
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index 9fc58823873..2b60317758c 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -2,7 +2,6 @@
 
 test_description='basic sanity checks for git var'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset_all_editors () {
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 02a18d4fdbd..c9376dffb58 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -2,7 +2,6 @@
 
 test_description=check-ignore
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 84172a37390..45229f57b82 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -2,7 +2,6 @@
 
 test_description='racy GIT'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test can give false success if your machine is sufficiently
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 9eae0d83563..1d273d91c21 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -2,7 +2,6 @@
 
 test_description='help'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 configure_help () {
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 08814173cb1..ce3d81227a0 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -2,7 +2,6 @@
 
 test_description='test sha1 collision detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 2a6f39ad9c8..854d59ec58c 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -2,7 +2,6 @@
 
 test_description='git command aliasing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'nested aliases - internal execution' '
diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
index f3a16859cc2..32fe8481792 100755
--- a/t/t0017-env-helper.sh
+++ b/t/t0017-env-helper.sh
@@ -2,7 +2,6 @@
 
 test_description='test test-tool env-helper'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index fac52322a7f..9a3db02fded 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -5,7 +5,6 @@ test_description='Test advise_if_enabled functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=trunk
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'advice should be printed when config variable is unset' '
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index 19a730c29ed..3a4e1cc7e38 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -2,7 +2,6 @@
 
 test_description='test json-writer JSON generation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'unit test of json-writer routines' '
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 81946e87ccb..fd1cae09edc 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -5,7 +5,6 @@ test_description='CRLF conversion'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9e6c6ee0d44..3f6433d3045 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -5,7 +5,6 @@ test_description='blob conversion via gitattributes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9fe98912511..9bd863a970d 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='ignore CR in CRLF sequence while computing similiarity'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index 575805513a3..f9bbb91f64e 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -2,7 +2,6 @@
 
 test_description='Test am with auto.crlf'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >patchfile <<\EOF
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index a7f4de4a43f..44958cb2c2d 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -2,7 +2,6 @@
 
 test_description='respect crlf in git archive'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0025-crlf-renormalize.sh b/t/t0025-crlf-renormalize.sh
index f7202c192e7..2e28feb69c9 100755
--- a/t/t0025-crlf-renormalize.sh
+++ b/t/t0025-crlf-renormalize.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF renormalization'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t0026-eol-config.sh b/t/t0026-eol-config.sh
index f426a185bb9..493b01a0e7c 100755
--- a/t/t0026-eol-config.sh
+++ b/t/t0026-eol-config.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF conversion'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 has_cr() {
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2f57c8669cb..49dbf09da77 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -2,7 +2,6 @@
 
 test_description='CRLF conversion all combinations'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 compare_files () {
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 510da4ca12d..50b3b4649b6 100755
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
index 4e8e90dd982..baa1b7e85b1 100755
--- a/t/t0029-core-unsetenvvars.sh
+++ b/t/t0029-core-unsetenvvars.sh
@@ -2,7 +2,6 @@
 
 test_description='test the Windows-only core.unsetenvvars setting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq MINGW
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index f10f42ff1e4..43155f6bd86 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -5,7 +5,6 @@
 
 test_description='git stripspace'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t40='A quick brown fox jumps over the lazy do'
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index e97a84764f7..e103fe71092 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -2,7 +2,6 @@
 
 test_description='verify safe.directory checks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_ASSUME_DIFFERENT_OWNER=1
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index d3cb2a1cb9e..ae7ef092abf 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -2,7 +2,6 @@
 
 test_description='verify safe.bareRepository checks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd="$(pwd)"
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 45a773642fd..2fe3522305f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -5,7 +5,6 @@
 
 test_description='our own option parser'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<\EOF
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 1464294bd1b..a0f6f134c71 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -5,7 +5,6 @@ test_description='Test commands behavior when given invalid argument value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 325eb1c3cd0..5c9dc90d0b0 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -5,7 +5,6 @@ test_description='Various filesystem issues'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 auml=$(printf '\303\244')
diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
index 1a36a535743..ff98be31a51 100755
--- a/t/t0052-simple-ipc.sh
+++ b/t/t0052-simple-ipc.sh
@@ -2,7 +2,6 @@
 
 test_description='simple command server'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
index c3eb1158ef9..d0740038b87 100755
--- a/t/t0055-beyond-symlinks.sh
+++ b/t/t0055-beyond-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index and add refuse to add beyond symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 752aa8c9454..2630e756dab 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -2,7 +2,6 @@
 
 test_description='"-C <path>" option and its effects on other path-related options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '"git -C <path>" runs git from the directory <path>' '
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 0afa3d0d312..dbb2e73bcd9 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -5,7 +5,6 @@
 
 test_description='Test various path utilities'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 norm_path() {
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 20986b693cf..76d4936a879 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -5,7 +5,6 @@
 
 test_description='Test run command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >hello-script <<-EOF
diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
index b9480c81781..8e215867b8c 100755
--- a/t/t0062-revision-walking.sh
+++ b/t/t0062-revision-walking.sh
@@ -5,7 +5,6 @@
 
 test_description='Test revision walking api'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >run_twice_expected <<-EOF
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 1fee6d90102..aac63ba5064 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -5,7 +5,6 @@
 
 test_description='Test string list functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_split () {
diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 7d0a0da8c01..df3e9f5fa5d 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the dir-iterator functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0067-parse_pathspec_file.sh b/t/t0067-parse_pathspec_file.sh
index 0188d0423a0..7bab49f361a 100755
--- a/t/t0067-parse_pathspec_file.sh
+++ b/t/t0067-parse_pathspec_file.sh
@@ -2,7 +2,6 @@
 
 test_description='Test parse_pathspec_file()'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'one item from stdin' '
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 95019e01ed3..f2f3e500312 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='git for-each-repo builtin'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 0ecec2ba711..6b9dcf984bc 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -6,7 +6,6 @@ test_description='check that the most basic functions work
 Verify wrappers and compatibility functions.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mktemp to nonexistent directory prints filename' '
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index ba8ad1d1ca0..2236a7e9563 100755
--- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -2,7 +2,6 @@
 
 test_description='verify sort functions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 3c369c88e2a..3db10f095c2 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the output of the unit test framework'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'TAP output from unit tests' - <<\EOT
diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 67b11216a3e..5a628bf7356 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -2,7 +2,6 @@
 
 test_description='test `test-tool find-pack`'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index d8e2fc42e15..ab80c9ef135 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -6,7 +6,6 @@ Tests whether various commands properly update and/or rewrite the
 cache-tree extension.
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
  . ./test-lib.sh
 
 cmp_cache_tree () {
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index fca39048fe8..e11d819b62a 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -2,7 +2,6 @@
 
 test_description='git bugreport'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a report' '
diff --git a/t/t0092-diagnose.sh b/t/t0092-diagnose.sh
index 133e5747d61..6cabd6e67b9 100755
--- a/t/t0092-diagnose.sh
+++ b/t/t0092-diagnose.sh
@@ -2,7 +2,6 @@
 
 test_description='git diagnose'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success UNZIP 'creates diagnostics zip archive' '
diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
index 08df74cacfc..8f0c3b7325b 100755
--- a/t/t0095-bloom.sh
+++ b/t/t0095-bloom.sh
@@ -2,7 +2,6 @@
 
 test_description='Testing the various Bloom filter computations in bloom.c'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'compute unseeded murmur3 hash for empty string' '
diff --git a/t/t0100-previous.sh b/t/t0100-previous.sh
index 70a3223f219..dd5d9b4e5eb 100755
--- a/t/t0100-previous.sh
+++ b/t/t0100-previous.sh
@@ -5,7 +5,6 @@ test_description='previous branch syntax @{-n}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'branch -d @{-1}' '
diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
index 878aadd64c9..023b4c6f0b3 100755
--- a/t/t0101-at-syntax.sh
+++ b/t/t0101-at-syntax.sh
@@ -2,7 +2,6 @@
 
 test_description='various @{whatever} syntax tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 522fb2ae696..8853d8afb92 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -5,7 +5,6 @@
 
 test_description='Gettext support for Git'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.sh
index 8724ce1052d..6c74df0dc67 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -8,7 +8,6 @@ test_description='Gettext Shell fallbacks'
 GIT_INTERNAL_GETTEXT_TEST_FALLBACKS=YesPlease
 export GIT_INTERNAL_GETTEXT_TEST_FALLBACKS
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success "sanity: \$GIT_INTERNAL_GETTEXT_SH_SCHEME is set (to $GIT_INTERNAL_GETTEXT_SH_SCHEME)" '
diff --git a/t/t0202-gettext-perl.sh b/t/t0202-gettext-perl.sh
index 5a6f28051bd..b15cb65d5d7 100755
--- a/t/t0202-gettext-perl.sh
+++ b/t/t0202-gettext-perl.sh
@@ -5,7 +5,6 @@
 
 test_description='Perl gettext interface (Git::I18N)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 . "$TEST_DIRECTORY"/lib-perl.sh
 skip_all_if_no_Test_More
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 86cff324ff1..0ce1f22eff6 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -5,7 +5,6 @@
 
 test_description="The Git C functions aren't broken by setlocale(3)"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-reencode-sanity.sh
index 310a4500125..28d92bb9b7c 100755
--- a/t/t0204-gettext-reencode-sanity.sh
+++ b/t/t0204-gettext-reencode-sanity.sh
@@ -5,7 +5,6 @@
 
 test_description="Gettext reencoding of our *.po/*.mo files works"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 # The constants used in a tricky observation for undefined behaviour
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index b9adc94aab4..eff9a59dbd0 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 91260ce97e5..bac90465406 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index 147643d5826..1211db9f468 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 6a76b7fdbd4..17952e52d69 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -2,7 +2,6 @@
 
 test_description='basic credential helper tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 5d5b64205ff..dc30289f753 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -2,7 +2,6 @@
 
 test_description='credential-cache tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f83db659e25..c1cd60edd01 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -2,7 +2,6 @@
 
 test_description='credential-store tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index 8aadbe86c45..72ae405c3ed 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -29,7 +29,6 @@ you can set GIT_TEST_CREDENTIAL_HELPER_SETUP to a sequence of shell
 commands.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 818700fbecd..34bdb3ab1f2 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='partial clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 932bf2067da..c98d5018695 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -2,7 +2,6 @@
 
 test_description='check that local clone does not fetch from promisor remotes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create evil repo' '
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index f99a69ae1b7..853101b86ef 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -5,7 +5,6 @@ test_description='assert (unbuilt) Documentation/*.txt and -h output
 Run this with --debug to see a summary of where we still fail to make
 the two versions consistent with one another.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: list of builtins' '
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1eb3a8306ba..d1a498a216f 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -2,7 +2,6 @@
 
 test_description='progress display'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_cr () {
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index bef2b708713..1e62c791d97 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -7,7 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index d8cbd3f202b..aa7f6ecd813 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -15,7 +15,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'enable reflogs' '
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae4..30e0a36242e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=files
 export GIT_TEST_DEFAULT_REF_FORMAT
-TEST_PASSES_SANITIZE_LEAK=true
 
 . ./test-lib.sh
 
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index babec7993e3..67bf3a82f6e 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -10,7 +10,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_DEFAULT_REF_FORMAT=reftable
 export GIT_TEST_DEFAULT_REF_FORMAT
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 INVALID_OID=$(test_oid 001)
diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
index 2805995cc8c..5e05b9c1f2a 100755
--- a/t/t0611-reftable-httpd.sh
+++ b/t/t0611-reftable-httpd.sh
@@ -2,7 +2,6 @@
 
 test_description='reftable HTTPD tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jgit-compatibility.sh
index 84922153ab6..d0d7e80b492 100755
--- a/t/t0612-reftable-jgit-compatibility.sh
+++ b/t/t0612-reftable-jgit-compatibility.sh
@@ -11,7 +11,6 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 GIT_TEST_SPLIT_INDEX=0
 export GIT_TEST_SPLIT_INDEX
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq JGIT
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index b1c6c97524f..e2708e11d5b 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -16,7 +16,6 @@ export GIT_TEST_DEFAULT_HASH
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'default write options' '
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
index 0e8c0dfbbee..b9dd21cfb6b 100755
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -72,7 +72,6 @@ In addition:
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 48a1550371a..4a88bb9ef0c 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -21,7 +21,6 @@ In the test, these paths are used:
 	yomin   - not in H or M
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index a7c2ed0d7c0..df6ef537258 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -9,7 +9,6 @@ This is identical to t1001, but uses -u to update the work tree as well.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1003-read-tree-prefix.sh b/t/t1003-read-tree-prefix.sh
index c860c08ecb4..66e2bf4aec3 100755
--- a/t/t1003-read-tree-prefix.sh
+++ b/t/t1003-read-tree-prefix.sh
@@ -6,7 +6,6 @@
 test_description='git read-tree --prefix test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index 2b9720b0feb..11bf10424f1 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -5,7 +5,6 @@ test_description='read-tree -m -u checks working tree files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 26be4a2b5a0..6b5033d0ce3 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree -u --reset'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d36cd7c0863..ff9bf213aa2 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmdmode_usage () {
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index d73a5cc2370..a0481139de5 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -2,7 +2,6 @@
 
 test_description="git hash-object"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo_without_newline() {
diff --git a/t/t1008-read-tree-overlay.sh b/t/t1008-read-tree-overlay.sh
index ad5936e54d1..4512fb0b6e6 100755
--- a/t/t1008-read-tree-overlay.sh
+++ b/t/t1008-read-tree-overlay.sh
@@ -5,7 +5,6 @@ test_description='test multi-tree read-tree without merging'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1009-read-tree-new-index.sh b/t/t1009-read-tree-new-index.sh
index fc179ac5dd6..2935f68f8d2 100755
--- a/t/t1009-read-tree-new-index.sh
+++ b/t/t1009-read-tree-new-index.sh
@@ -5,7 +5,6 @@ test_description='test read-tree into a fresh index file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 22875ba598c..c291a2b33d7 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -2,7 +2,6 @@
 
 test_description='git mktree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 595b24c0adb..742f0fa909f 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -12,7 +12,6 @@ test_description='sparse checkout tests
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1012-read-tree-df.sh b/t/t1012-read-tree-df.sh
index cde93d22cde..57f0770df14 100755
--- a/t/t1012-read-tree-df.sh
+++ b/t/t1012-read-tree-df.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree D/F conflict corner cases'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index cf8b94ebedb..bfc90d4cf27 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='read-tree can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t1014-read-tree-confusing.sh b/t/t1014-read-tree-confusing.sh
index 8ea8d36818b..0c0e6da5cf5 100755
--- a/t/t1014-read-tree-confusing.sh
+++ b/t/t1014-read-tree-confusing.sh
@@ -2,7 +2,6 @@
 
 test_description='check that read-tree rejects confusing paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create base tree' '
diff --git a/t/t1015-read-index-unmerged.sh b/t/t1015-read-index-unmerged.sh
index da737a32a27..9b965d02943 100755
--- a/t/t1015-read-index-unmerged.sh
+++ b/t/t1015-read-index-unmerged.sh
@@ -2,7 +2,6 @@
 
 test_description='Test various callers of read_index_unmerged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup modify/delete + directory/file conflict' '
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 8341a2fe839..5641271b23a 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -5,7 +5,6 @@
 
 test_description='Test how well compatObjectFormat works'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 45eef9457fe..9fdbb2af80e 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -6,7 +6,6 @@
 test_description='Try various core-level commands in subdirectory.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 69bf9476cbf..0b892894eb9 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -4,7 +4,6 @@ test_description='rerere run in a workdir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success SYMLINKS setup '
diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index cca4380e431..d390d7d5f85 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -3,7 +3,6 @@
 test_description='git read-tree in partial clones'
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read-tree in partial clone prefetches in one batch' '
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index ed638f66447..c71932b0242 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -3,7 +3,6 @@
 
 test_description='adding and checking out large blobs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'core.bigFileThreshold must be non-negative' '
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index f6709c9f569..361afb679b0 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -2,7 +2,6 @@
 
 test_description='test conversion filters on large files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 set_attr() {
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 5e0f0a334f4..502a5ea1c51 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,7 +2,6 @@
 
 test_description='see how we handle various forms of corruption'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index da0e7714d5a..3a14218b245 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 8c5cd651b4b..ab3a105ffff 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_SPLIT_INDEX=false
 export GIT_TEST_SPLIT_INDEX
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 list_files() {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2157f37da36..a4c7c41fc00 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -5,7 +5,6 @@ test_description='compare full workdir to sparse workdir'
 GIT_TEST_SPLIT_INDEX=0
 GIT_TEST_SPARSE_INDEX=
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index 0f37a43fd3c..ae66ba5babf 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -12,7 +12,6 @@ Also make sure that command line parser understands the normal
 "flags first and then non flag arguments" command line.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<EOF
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f13277c8f3e..51a85e83c27 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -8,7 +8,6 @@ test_description='Test git config in different settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for mode in legacy subcommands
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 29cf8a96613..630a47af21e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -9,7 +9,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index 42caa0d2978..69723b88ff8 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -5,7 +5,6 @@
 
 test_description='Test repository version check'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 0506f3d6bba..d971925ed02 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test wacky input to git config'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Leaving off the newline is intentional!
diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 31b89dd9693..c69ae41306c 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -9,7 +9,6 @@ test_description='Test repository with default ACL'
 # => this must come before . ./test-lib.sh
 umask 077
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need an arbitrary other user give permission to using ACLs. root
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 517d6c86937..8ff2b0c232b 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='test config file include directives'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Force setup_explicit_git_dir() to run until the end. This is needed
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 53e5b290b9b..40d3c42618c 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -7,7 +7,6 @@
 
 test_description='Compatibility with $XDG_CONFIG_HOME/git/ files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read config: xdg file exists and ~/.gitconfig doesn'\''t' '
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index b9852fe40e4..5cb546dd00c 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -2,7 +2,6 @@
 
 test_description='support for reading config from a blob'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create config blob' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 3bfec07f1ab..e0e49053f07 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git config-set API in different settings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 'check_config get_* section.key value' verifies that the entry for
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 523aa99a1e2..9710ee0ca45 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test read_early_config()'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'read early config' '
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index 1a90d31201a..69e64c6c868 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git config in different settings (with --default)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'uses --default when entry missing' '
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index ceeb7ac3a47..45a04929170 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the core.hooksPath configuration variable'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index bb057596f1e..e2316f1dd4c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git update-ref and basic ref logging'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 Z=$ZERO_OID
diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 90af3f955c0..a2a7e947164 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -2,7 +2,6 @@
 
 test_description='basic symbolic-ref tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # If the tests munging HEAD fail, they can break detection of
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 5ed9d7318e0..cabc516ae9a 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git check-ref-format'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 valid_ref() {
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 403f6b8f7da..9d698b3cc35 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -4,7 +4,6 @@ test_description='show-ref'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index df90112618c..28e6c380d76 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git update-ref error handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create some references, perhaps run pack-refs --all, then try to
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a6bcd62ab65..6d8f401a2a9 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test main ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store main"
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index c01f0f14a12..9b9e5d0766f 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test submodule ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RUN="test-tool ref-store submodule:sub"
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 48b1c92a414..9d8e1a13432 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -5,7 +5,6 @@ test_description='test worktree ref store api'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 RWT="test-tool ref-store worktree:wt"
diff --git a/t/t1408-packed-refs.sh b/t/t1408-packed-refs.sh
index 9469c79a585..41ba1f1d7fc 100755
--- a/t/t1408-packed-refs.sh
+++ b/t/t1408-packed-refs.sh
@@ -5,7 +5,6 @@ test_description='packed-refs entries are covered by loose refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index 7748973733e..e3c501848a4 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='avoid rewriting packed-refs unnecessarily'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq !REFFILES
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 246a3f46aba..388fdf9ae57 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -7,7 +7,6 @@ test_description='Test prune and reflog expiration'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_have () {
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index da581ec19ac..975c4ea83a8 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -4,7 +4,6 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index ff30874f940..f7d69b66ff3 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -2,7 +2,6 @@
 
 test_description='reflog walk shows repeated commits again'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
index d2a4822d46f..934688a1ee8 100755
--- a/t/t1413-reflog-detach.sh
+++ b/t/t1413-reflog-detach.sh
@@ -4,7 +4,6 @@ test_description='Test reflog interaction with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset_state () {
diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index 49d28166da0..be6c3f472c1 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -4,7 +4,6 @@ test_description='various tests of reflog walk (log -g) behavior'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some reflog entries' '
diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
index eb4eec8becb..51d79bae83b 100755
--- a/t/t1415-worktree-refs.sh
+++ b/t/t1415-worktree-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='per-worktree refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 5a812ca3c0b..dd003a196f7 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -5,7 +5,6 @@ test_description='reference transaction hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1417-reflog-updateref.sh b/t/t1417-reflog-updateref.sh
index 0eb5e674bc1..2f374025367 100755
--- a/t/t1417-reflog-updateref.sh
+++ b/t/t1417-reflog-updateref.sh
@@ -2,7 +2,6 @@
 
 test_description='git reflog --updateref'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
index 2268bca3c11..d51ecd5e925 100755
--- a/t/t1418-reflog-exists.sh
+++ b/t/t1418-reflog-exists.sh
@@ -4,7 +4,6 @@ test_description='Test reflog display routines'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 3256e4462f9..c04eeb72111 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -5,7 +5,6 @@ test_description='test exclude_patterns functionality in main ref store'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for_each_ref__exclude () {
diff --git a/t/t1420-lost-found.sh b/t/t1420-lost-found.sh
index dbe15a0be10..2fb2f44f021 100755
--- a/t/t1420-lost-found.sh
+++ b/t/t1420-lost-found.sh
@@ -5,7 +5,6 @@
 
 test_description='Test fsck --lost-found'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 0c00118c2b3..3ab65f72cde 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -4,7 +4,6 @@ test_description='Test handling of ref names that check-ref-format rejects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 280cbf3e031..8a456b1142d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,7 +6,6 @@ test_description='git fsck random collection of tests
 * (main) A
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t1451-fsck-buffer.sh b/t/t1451-fsck-buffer.sh
index 3413da40e4a..3a3d33f4054 100755
--- a/t/t1451-fsck-buffer.sh
+++ b/t/t1451-fsck-buffer.sh
@@ -15,7 +15,6 @@ These tests _might_ catch such overruns in normal use, but should be run with
 ASan or valgrind for more confidence.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the general idea for tags and commits is to build up the "base" file
diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
index f7c0783d30c..cf57cd66f2d 100755
--- a/t/t1460-refs-migrate.sh
+++ b/t/t1460-refs-migrate.sh
@@ -5,7 +5,6 @@ test_description='migration of ref storage backends'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_migration () {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 30c31918fde..bf2a90df948 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -4,7 +4,6 @@ test_description='test git rev-parse'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_one () {
diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
index ae6528aecea..8c94ac2e70b 100755
--- a/t/t1501-work-tree.sh
+++ b/t/t1501-work-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='test separate work tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 5eaa6428c43..3962f1d2882 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -2,7 +2,6 @@
 
 test_description='test git rev-parse --parseopt'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_invalid_long_option () {
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 79df65ec7f6..75a708f9ba5 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -9,7 +9,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index c1679e31d8a..e04420f4368 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -2,7 +2,6 @@
 
 test_description='test GIT_CEILING_DIRECTORIES'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_prefix() {
diff --git a/t/t1505-rev-parse-last.sh b/t/t1505-rev-parse-last.sh
index 4a5758f08a8..2803ca9489c 100755
--- a/t/t1505-rev-parse-last.sh
+++ b/t/t1505-rev-parse-last.sh
@@ -5,7 +5,6 @@ test_description='test @{-N} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index a3464976e3a..722884e65f4 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -7,7 +7,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_did_you_mean ()
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index b9af6b3ac03..cb9ef7e329e 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -5,7 +5,6 @@ test_description='test <branch>@{upstream} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index e841309d0ea..87a42864145 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -4,7 +4,6 @@ test_description='test various @{X} syntax combinations together'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check() {
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 591505a39c0..bbfe05b8e4a 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -43,7 +43,6 @@ A few rules for repo setup:
 # This test heavily relies on the standard error of nested function calls.
 test_untraceable=UnfortunatelyYes
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 here=$(pwd)
diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e7e78a40281..6ecfed86bc0 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -5,7 +5,6 @@ test_description='tests for ref^{stuff}'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index f9d68ce74ea..70f1e0a998e 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -23,7 +23,6 @@ one tagged as v1.0.0.  They all have one regular file each.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_cmp_failed_rev_parse () {
diff --git a/t/t1513-rev-parse-prefix.sh b/t/t1513-rev-parse-prefix.sh
index ba43387bf16..5f437be8c9e 100755
--- a/t/t1513-rev-parse-prefix.sh
+++ b/t/t1513-rev-parse-prefix.sh
@@ -5,7 +5,6 @@ test_description='Tests for rev-parse --prefix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index a835a196aa8..d868a081105 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -4,7 +4,6 @@ test_description='test <branch>@{push} syntax'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 resolve () {
diff --git a/t/t1515-rev-parse-outside-repo.sh b/t/t1515-rev-parse-outside-repo.sh
index cdb26a30d72..75e89c4b6e2 100755
--- a/t/t1515-rev-parse-outside-repo.sh
+++ b/t/t1515-rev-parse-outside-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='check that certain rev-parse options work outside repo'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up non-repo directory' '
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 342defbb617..dbd8cd69063 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -2,7 +2,6 @@
 
 test_description='check random commands outside repo'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up a non-repo directory and test file' '
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 62e7fd15964..03239e9faa4 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -2,7 +2,6 @@
 
 test_description='index file specific tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t1601-index-bogus.sh b/t/t1601-index-bogus.sh
index 5dcc1018828..a45a8b4eb04 100755
--- a/t/t1601-index-bogus.sh
+++ b/t/t1601-index-bogus.sh
@@ -2,7 +2,6 @@
 
 test_description='test handling of bogus index entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create tree with null sha1' '
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 2625ac44889..ac4a5b2734c 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -5,7 +5,6 @@ test_description='split index mode tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need total control of index splitting here
diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
index d8fa489998a..5dc221ef382 100755
--- a/t/t1701-racy-split-index.sh
+++ b/t/t1701-racy-split-index.sh
@@ -5,7 +5,6 @@
 
 test_description='racy split index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 8b0234cf2d5..4feaf0d7bef 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -2,7 +2,6 @@
 
 test_description='git-hook command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t2000-conflict-when-checking-files-out.sh b/t/t2000-conflict-when-checking-files-out.sh
index 79fc97f1d7e..f18616ad2be 100755
--- a/t/t2000-conflict-when-checking-files-out.sh
+++ b/t/t2000-conflict-when-checking-files-out.sh
@@ -21,7 +21,6 @@ test_description='git conflicts when checking files out test.'
 # path1 is occupied by a non-directory.  With "-f" flag, it should remove
 # the conflicting paths and succeed.
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_files() {
diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index fc95cf90485..70361c806e1 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index -u test.
 With -u flag, git checkout-index internally runs the equivalent of
 git update-index --refresh on the checked out entry.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2003-checkout-cache-mkdir.sh b/t/t2003-checkout-cache-mkdir.sh
index f0fd441d810..ff163cf6750 100755
--- a/t/t2003-checkout-cache-mkdir.sh
+++ b/t/t2003-checkout-cache-mkdir.sh
@@ -10,7 +10,6 @@ also verifies that such leading path may contain symlinks, unlike
 the GIT controlled paths.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 98e818f09f2..b92d96fdc4e 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index --temp test.
 With --temp flag, git checkout-index writes to temporary merge files
 rather than the tracked path.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2005-checkout-index-symlinks.sh b/t/t2005-checkout-index-symlinks.sh
index 67d18cfa104..91b08e03717 100755
--- a/t/t2005-checkout-index-symlinks.sh
+++ b/t/t2005-checkout-index-symlinks.sh
@@ -8,7 +8,6 @@ test_description='git checkout-index on filesystem w/o symlinks test.
 This tests that git checkout-index creates a symbolic link as a plain
 file if core.symlinks is false.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 570ba38580d..bac231b167c 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -3,7 +3,6 @@
 test_description='basic checkout-index tests
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'checkout-index --gobbledegook' '
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index bd9e9e7530d..6f0b90ce127 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -7,7 +7,6 @@ test_description='git checkout to switch between branches with symlink<->dir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 8a518a44ea2..eadb9434ae7 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -4,7 +4,6 @@
 
 test_description='git checkout from subdirectories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2009-checkout-statinfo.sh b/t/t2009-checkout-statinfo.sh
index 71195dd28f2..b0540636ae3 100755
--- a/t/t2009-checkout-statinfo.sh
+++ b/t/t2009-checkout-statinfo.sh
@@ -5,7 +5,6 @@ test_description='checkout should leave clean stat info'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 82c3bfeac1a..3a3d56018e5 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -5,7 +5,6 @@ test_description='checkout and pathspecs/refspecs ambiguities'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 04f53b1ea14..61417c75675 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -5,7 +5,6 @@ test_description='checkout switching away from an invalid branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 4b6372f4c3e..1f6c4ed0428 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -5,7 +5,6 @@ test_description='checkout can switch to last branch and merge base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 3c1d663d948..b2bdd1fcb42 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t2014-checkout-switch.sh b/t/t2014-checkout-switch.sh
index c138bdde4fe..3e757c6e4e3 100755
--- a/t/t2014-checkout-switch.sh
+++ b/t/t2014-checkout-switch.sh
@@ -2,7 +2,6 @@
 
 test_description='Peter MacMillan'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index fb0e13881cd..1820300c62f 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -4,7 +4,6 @@ test_description='checkout from unborn branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index c40b661ac12..c4f9bf09aa4 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git checkout --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index a5c7358eeab..80ac661815d 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -10,7 +10,6 @@ Main Tests for --orphan functionality.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 TEST_FILE=foo
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 43551cc1481..a48ebdbf4d0 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -3,7 +3,6 @@
 test_description='checkout'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Arguments: [!] <branch> <oid> [<checkout options>]
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index c67261e2b68..1fcef4be95c 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout handling of ambiguous (branch/tag) refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ambiguous refs' '
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 8d90d028504..28bbbe6c055 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -4,7 +4,6 @@ test_description='checkout into detached HEAD state'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_detached () {
diff --git a/t/t2021-checkout-overwrite.sh b/t/t2021-checkout-overwrite.sh
index ecfacf0f7f3..a5c03d5d4a2 100755
--- a/t/t2021-checkout-overwrite.sh
+++ b/t/t2021-checkout-overwrite.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout must not overwrite an untracked objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index f1b709d58be..c49ba7f9bd4 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -4,7 +4,6 @@ test_description='checkout $tree -- $paths'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2023-checkout-m.sh b/t/t2023-checkout-m.sh
index 81e772fb4eb..7b327b75449 100755
--- a/t/t2023-checkout-m.sh
+++ b/t/t2023-checkout-m.sh
@@ -7,7 +7,6 @@ Ensures that checkout -m on a resolved file restores the conflicted file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 2caada3d834..a3b1449ef11 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -4,7 +4,6 @@ test_description='checkout <branch>
 
 Ensures that checkout on an unborn branch does what the user expects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Is the current branch "refs/heads/$1"?
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index 246609d54d0..dda169bbc4a 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout --no-overlay <tree-ish> -- <pathspec>'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index acd55217a62..161da054b6d 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='checkout --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 98f16c72399..a397790df59 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -5,7 +5,6 @@ test_description='tests for git branch --track'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index b3f6bc97b53..be3fcdde075 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -5,7 +5,6 @@ test_description='undoing resolution'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_resolve_undo () {
diff --git a/t/t2050-git-dir-relative.sh b/t/t2050-git-dir-relative.sh
index 1f193cde965..21f4659a9d1 100755
--- a/t/t2050-git-dir-relative.sh
+++ b/t/t2050-git-dir-relative.sh
@@ -12,7 +12,6 @@ into the subdir while keeping the worktree location,
 and tries commits from the top and the subdir, checking
 that the commit-hook still gets called.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 COMMIT_FILE="$(pwd)/output"
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 77b2346291b..c91c4db9361 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -5,7 +5,6 @@ test_description='switch basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index ac404945d4c..16d6348b692 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -5,7 +5,6 @@ test_description='restore basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
index 42d55221191..27e85be40ad 100755
--- a/t/t2071-restore-patch.sh
+++ b/t/t2071-restore-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git restore --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index 86c9c887881..8198a1e5789 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='restore --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t2080-parallel-checkout-basics.sh b/t/t2080-parallel-checkout-basics.sh
index 59e5570cb2d..5ffe1a41e2c 100755
--- a/t/t2080-parallel-checkout-basics.sh
+++ b/t/t2080-parallel-checkout-basics.sh
@@ -8,7 +8,6 @@ working tree.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel-checkout-collisions.sh
index 6acdb89d12b..f6fcfc0c1e4 100755
--- a/t/t2081-parallel-checkout-collisions.sh
+++ b/t/t2081-parallel-checkout-collisions.sh
@@ -11,7 +11,6 @@ The tests in this file exercise parallel checkout's collision detection code in
 both these mechanics.
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-parallel-checkout.sh"
 
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index d02d6a55504..79fb11f139a 100755
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
index 7915e7b8211..2df3fdde8bf 100755
--- a/t/t2100-update-cache-badpath.sh
+++ b/t/t2100-update-cache-badpath.sh
@@ -22,7 +22,6 @@ and tries to git update-index --add the following:
 All of the attempts should fail.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mkdir path2 path3
diff --git a/t/t2101-update-index-reupdate.sh b/t/t2101-update-index-reupdate.sh
index e3c7acdbf91..6c32d42c8c6 100755
--- a/t/t2101-update-index-reupdate.sh
+++ b/t/t2101-update-index-reupdate.sh
@@ -6,7 +6,6 @@
 test_description='git update-index --again test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --add' '
diff --git a/t/t2102-update-index-symlinks.sh b/t/t2102-update-index-symlinks.sh
index c49cdfb6e58..9b11130ab93 100755
--- a/t/t2102-update-index-symlinks.sh
+++ b/t/t2102-update-index-symlinks.sh
@@ -8,7 +8,6 @@ test_description='git update-index on filesystem w/o symlinks test.
 This tests that git update-index keeps the symbolic link property
 even if a plain file is in the working tree if core.symlinks is false.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-index-ignore-missing.sh
index e9451cd567c..6938ecca868 100755
--- a/t/t2103-update-index-ignore-missing.sh
+++ b/t/t2103-update-index-ignore-missing.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index with options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success basics '
diff --git a/t/t2104-update-index-skip-worktree.sh b/t/t2104-update-index-skip-worktree.sh
index 7ec7f30b442..7a0778ed983 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -5,7 +5,6 @@
 
 test_description='skip-worktree bit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sane_unset GIT_TEST_SPLIT_INDEX
diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
index 963ebe77eb6..a7f3d47aec2 100755
--- a/t/t2105-update-index-gitfile.sh
+++ b/t/t2105-update-index-gitfile.sh
@@ -6,7 +6,6 @@
 test_description='git update-index for gitlink to .git file.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'submodule with absolute .git file' '
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 95c004dc5c5..6b2ccc21a93 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -3,7 +3,6 @@
 test_description='git update-index --assume-unchanged test.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index f0eab13f96a..cc72ead79f3 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -5,7 +5,6 @@ test_description='basic update-index tests
 Tests for command-line parsing and basic operation.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'update-index --nonsense fails' '
diff --git a/t/t2108-update-index-refresh-racy.sh b/t/t2108-update-index-refresh-racy.sh
index bc5f2886faf..b31dd8ece50 100755
--- a/t/t2108-update-index-refresh-racy.sh
+++ b/t/t2108-update-index-refresh-racy.sh
@@ -2,7 +2,6 @@
 
 test_description='update-index refresh tests related to racy timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset_files () {
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index df235ac306e..06e83d33333 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -14,7 +14,6 @@ only the updates to dir/sub.
 Also tested are "git add -u" without limiting, and "git add -u"
 without contents changes, and other conditions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index dba62d69c6c..687be974d41 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -2,7 +2,6 @@
 
 test_description='more git add -u'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 24c60bfd790..9ee659098c4 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -2,7 +2,6 @@
 
 test_description='git add --all'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 8fa44a92a27..192ad14b5f4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -2,7 +2,6 @@
 
 test_description='Intent to add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'intent to add' '
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index b7cf1e492c1..31eb233df51 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -2,7 +2,6 @@
 
 test_description='giving ignored paths to git add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
index 98265ba1b49..43d950de640 100755
--- a/t/t2205-add-worktree-config.sh
+++ b/t/t2205-add-worktree-config.sh
@@ -17,7 +17,6 @@ outside the repository.  Two instances for which this can occur are tested:
 	   repository can be added to the index.
 	'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '1a: setup--config worktree' '
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index b40eeb263fe..c8de6d8a190 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -2,7 +2,6 @@
 
 test_description='cd_to_toplevel'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 EXEC_PATH="$(git --exec-path)"
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index cfc4aeb1798..ba320dc4171 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 976d048e3ef..aa5b42c0f7b 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -5,7 +5,6 @@ test_description='prune $GIT_DIR/worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 33ea9cb21ba..cb125ec2265 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -5,7 +5,6 @@ test_description='test git worktree list'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 901342ea09b..08531deb5b2 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -2,7 +2,6 @@
 
 test_description='test git worktree move, remove, lock and unlock'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 842937bfb9a..9536d109195 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -2,7 +2,6 @@
 
 test_description="config file in multi worktree"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index 1d7f6056338..11018f37c70 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -5,7 +5,6 @@ test_description='Combination of submodules and multiple worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_path=$(pwd -P)
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 7686e60f6ad..bf340b87726 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -2,7 +2,6 @@
 
 test_description='test git worktree repair'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 7750dc9265a..57c201869f0 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -2,7 +2,6 @@
 
 test_description='test operations trying to overwrite refs at worktree HEAD'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t2408-worktree-relative.sh b/t/t2408-worktree-relative.sh
index a3136db7e28..d51cc8c5ab7 100755
--- a/t/t2408-worktree-relative.sh
+++ b/t/t2408-worktree-relative.sh
@@ -2,7 +2,6 @@
 
 test_description='test worktrees linked with relative paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'links worktrees with relative paths' '
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 714feb83be5..5c0bf4d21fc 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -2,7 +2,6 @@
 
 test_description='Test handling of overwriting untracked files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_setup_reset () {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 8af4e8cfe3c..f6d8d7d03d7 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='Test handling of the current working directory becoming empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index 11af4552f74..13f66fd649d 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -16,7 +16,6 @@ filesystem.
     path4       - an empty directory
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 1ed0aa967ec..4b676462852 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -8,7 +8,6 @@ test_description='git ls-files --others --exclude
 This test runs git ls-files --others and tests --exclude patterns.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 rm -fr one three
diff --git a/t/t3002-ls-files-dashpath.sh b/t/t3002-ls-files-dashpath.sh
index 4dd24550eba..31462cb441e 100755
--- a/t/t3002-ls-files-dashpath.sh
+++ b/t/t3002-ls-files-dashpath.sh
@@ -13,7 +13,6 @@ filesystem.
     --		- another file with a funny name.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3003-ls-files-exclude.sh b/t/t3003-ls-files-exclude.sh
index 7933dff9b38..ac3c811f464 100755
--- a/t/t3003-ls-files-exclude.sh
+++ b/t/t3003-ls-files-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-files --exclude does not affect index files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create repo with file' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 12e41a7b40e..a1078f8701d 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -6,7 +6,6 @@ This test runs git ls-files with various unusual or malformed
 command-line arguments.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'ls-files in empty repository' '
diff --git a/t/t3005-ls-files-relative.sh b/t/t3005-ls-files-relative.sh
index fbfa210a50b..db13aabf625 100755
--- a/t/t3005-ls-files-relative.sh
+++ b/t/t3005-ls-files-relative.sh
@@ -5,7 +5,6 @@ test_description='ls-files tests with relative paths
 This test runs git ls-files with various relative path arguments.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare' '
diff --git a/t/t3006-ls-files-long.sh b/t/t3006-ls-files-long.sh
index 2aaf91ebc8c..22c7256c3ae 100755
--- a/t/t3006-ls-files-long.sh
+++ b/t/t3006-ls-files-long.sh
@@ -2,7 +2,6 @@
 
 test_description='overly long paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index f04bdc8c78b..61771eec830 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -6,7 +6,6 @@ This test verifies the recurse-submodules feature correctly lists files from
 submodules.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup directory structure and submodules' '
diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 51d3dffaa66..85f37049587 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -2,7 +2,6 @@
 
 test_description='Test the lazy init name hash with various folder structures'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test 1 -eq $(test-tool online-cpus)
diff --git a/t/t3009-ls-files-others-nonsubmodule.sh b/t/t3009-ls-files-others-nonsubmodule.sh
index 14218b34243..963f3462b75 100755
--- a/t/t3009-ls-files-others-nonsubmodule.sh
+++ b/t/t3009-ls-files-others-nonsubmodule.sh
@@ -18,7 +18,6 @@ This test runs git ls-files --others with the following working tree:
       git repository with a commit and an untracked file
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: directories' '
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 054178703d7..7af4532cd1d 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -42,7 +42,6 @@ We should report path0, path1, path2/file2, path3/file3, path7 and path8
 modified without reporting path9 and path10.  submod1 is also modified.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git update-index --add to add various paths.' '
diff --git a/t/t3011-common-prefixes-and-directory-traversal.sh b/t/t3011-common-prefixes-and-directory-traversal.sh
index 69e44c387fa..3da5b2b6e79 100755
--- a/t/t3011-common-prefixes-and-directory-traversal.sh
+++ b/t/t3011-common-prefixes-and-directory-traversal.sh
@@ -2,7 +2,6 @@
 
 test_description='directory traversal handling, especially with common prefixes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3012-ls-files-dedup.sh b/t/t3012-ls-files-dedup.sh
index 190e2f6eed7..2682b1f43a6 100755
--- a/t/t3012-ls-files-dedup.sh
+++ b/t/t3012-ls-files-dedup.sh
@@ -2,7 +2,6 @@
 
 test_description='git ls-files --deduplicate test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
index 6e6ea0b6f3c..8bdaacd85ac 100755
--- a/t/t3013-ls-files-format.sh
+++ b/t/t3013-ls-files-format.sh
@@ -2,7 +2,6 @@
 
 test_description='git ls-files --format test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 for flag in -s -o -k -t --resolve-undo --deduplicate --eol
diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error-unmatch.sh
index 133593d23c0..ac82c9cee8a 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -10,7 +10,6 @@ returns an error when a non-existent path is provided on the command
 line.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index bd65dfcffc7..768d702fbbf 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -2,7 +2,6 @@
 
 test_description='Basic subproject functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: create superproject' '
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index 38846941655..f1f09abdd9b 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -2,7 +2,6 @@
 
 test_description='fetching and pushing project with subproject'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
index 5a06732ca73..eb69da61fe7 100755
--- a/t/t3060-ls-files-with-tree.sh
+++ b/t/t3060-ls-files-with-tree.sh
@@ -9,7 +9,6 @@ This test runs git ls-files --with-tree and in particular in
 a scenario known to trigger a crash with some versions of git.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 4dd42df38c2..3da824117c6 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -2,7 +2,6 @@
 
 test_description='wildmatch tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 should_create_test_file() {
diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 436de44971e..8f294d98326 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -17,7 +17,6 @@ The new path restriction code should do the right thing for path2 and
 path2/baz.  Also path0/ should snow nothing.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 5af2dac0e4b..ac44525810f 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -20,7 +20,6 @@ Test the handling of multiple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 3942db22900..1e16c6b8ea6 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree with(out) globs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 81c63439623..e7636f6908f 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -7,7 +7,6 @@ Miscellaneous tests for git ls-tree.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 3adb206a93b..a1b2069a256 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree --format'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
index ce2391e28be..8bdf400682d 100755
--- a/t/t3105-ls-tree-output.sh
+++ b/t/t3105-ls-tree-output.sh
@@ -2,7 +2,6 @@
 
 test_description='ls-tree output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfa6a720d0..2295db3dcb0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -8,7 +8,6 @@ test_description='git branch assorted tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 6e587d27d7a..800fc33165a 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,7 +2,6 @@
 
 test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 3b6dad0c466..a1139f79e2c 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -2,7 +2,6 @@
 
 test_description='test show-branch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'error descriptions on empty repository' '
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index e627f08a179..500c9d0e727 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -2,7 +2,6 @@
 
 test_description='git branch display tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 594e3e43e12..3399344f25d 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -9,7 +9,6 @@ This script aims to check the behavior of those corner cases.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 expect_branch() {
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 0b61da92b37..da1c202fa71 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='basic branch output coloring'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 86010931ab6..d2ca43d6aab 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -5,7 +5,6 @@ test_description='range-diff tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note that because of the range-diff's heuristics, test_commit does more
diff --git a/t/t3207-branch-submodule.sh b/t/t3207-branch-submodule.sh
index 904eea7df59..fe72b247164 100755
--- a/t/t3207-branch-submodule.sh
+++ b/t/t3207-branch-submodule.sh
@@ -5,7 +5,6 @@ test_description='git branch submodule tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index 9cbc34fc583..37b9d26f4b6 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -4,7 +4,6 @@ test_description='tests for the peel_ref optimization of packed-refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create annotated tag in refs/tags' '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index d3ac826283e..f5bf16abcd8 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -9,7 +9,6 @@ This test tries pathnames with funny characters in the working
 tree, index, and tree objects.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT='	'
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 813dfd8db97..d6c50460d08 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -5,7 +5,6 @@
 
 test_description='Test commit notes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script fake_editor <<\EOF
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index d0c4d38b4d4..bb5fea02a03 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -8,7 +8,6 @@ test_description='Test commit notes index (expensive!)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_repo () {
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index bc9b791d1b9..eac193757bf 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -5,7 +5,6 @@ test_description='Test commit notes organized in subtrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 2c3a2452668..03dfcd3954c 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -5,7 +5,6 @@ test_description='Test notes trees that also contain non-notes'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 number_of_commits=100
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index 1ec1fb6715e..fcecdc94ff7 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -2,7 +2,6 @@
 
 test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 path_has_fanout() {
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index b6e9f643e3c..8f4102ff9e4 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git notes prune'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: create a few commits with notes' '
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index ae316502c45..1aa366a410e 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -4,7 +4,6 @@ test_description='Examples from the git-notes man page
 
 Make sure the manual is not full of lies.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index e1d05ff6bc9..202702be1a7 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -5,7 +5,6 @@
 
 test_description='Test merging of notes trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3309-notes-merge-auto-resolve.sh b/t/t3309-notes-merge-auto-resolve.sh
index f55277f499d..9bd5dbf341f 100755
--- a/t/t3309-notes-merge-auto-resolve.sh
+++ b/t/t3309-notes-merge-auto-resolve.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging with auto-resolving strategies'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with all kinds of potential conflicts
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 04866b89bed..597df5ebc0a 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging with manual conflict resolution'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Set up a notes merge scenario with different kinds of conflicts
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index ce4144db0f2..5b675417e9b 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -5,7 +5,6 @@
 
 test_description='Test notes merging at various fanout levels'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 verify_notes () {
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 0fd33280cf9..96243b72222 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -8,7 +8,6 @@ test_description='Test merging of notes trees in multiple worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commit' '
diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index beca3460567..c4a7839540a 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -5,7 +5,6 @@
 
 test_description='Test commit notes with stripspace behavior'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 MULTI_LF="$LF$LF$LF"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 09f230eefb2..bab675938a3 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -11,7 +11,6 @@ among other things.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_NAME=author@name
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 328c1d3a3f4..f18bae94507 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase + directory rename tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 5c67d07ba3e..761de63b6b9 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -8,7 +8,6 @@ test_description='git rebase --merge test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 T="A quick brown fox
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 4f1d6e8ea64..a1911c4a9d6 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -8,7 +8,6 @@ test_description='git rebase --merge --skip tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 77cceda14a0..b11f04eb334 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,7 +26,6 @@ Initial setup:
  touch file "conflict".
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
index 8979bc34073..25243318618 100755
--- a/t/t3405-rebase-malformed.sh
+++ b/t/t3405-rebase-malformed.sh
@@ -5,7 +5,6 @@ test_description='rebase should handle arbitrary git message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 82108b67e67..a1d7fa7f7c6 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,7 +5,6 @@ test_description='messages from rebase operation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2c3f38d45a8..9f49c4228b6 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -5,7 +5,6 @@ test_description='git rebase --abort tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 7b4607d72f2..cde3562e3a6 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -5,7 +5,6 @@ test_description='rebasing a commit with multi-line first paragraph.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
index acaf5558dbe..83ffb39d9ff 100755
--- a/t/t3409-rebase-environ.sh
+++ b/t/t3409-rebase-environ.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase interactive environment'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index e75b3d0e07c..58371d8a547 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -7,7 +7,6 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 log_with_names () {
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 426ff098e1d..b4ff614987e 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -5,7 +5,6 @@ test_description='git rebase with its hook(s)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 22452ff84cb..fcc40d6fe1f 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -5,7 +5,6 @@ test_description='auto squash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index f8c4ed78c9e..ea501f2b42b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -5,7 +5,6 @@ test_description='git rebase --onto A...B'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 
diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespace-fix.sh
index 22ee3a20459..96f2cf22faf 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -5,7 +5,6 @@ test_description='git rebase --whitespace=fix
 This test runs git rebase --whitespace=fix and make sure that it works.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # prepare initial revision of "file" with a blank line at the end
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index c0d29c2154f..127216f7225 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -5,7 +5,6 @@ test_description='git rebase --continue tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 6c61f240cf9..7181f176b81 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -5,7 +5,6 @@ test_description='git rebase - test patch id computation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 scramble () {
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index b43046b3b0d..ad3ba6a9848 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -7,7 +7,6 @@ test_description='git rebase --autostash tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 737af80bb3d..f5b7807abd0 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -2,7 +2,6 @@
 
 test_description='basic rebase topology tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index b40f26250b7..b9408f9ba12 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -2,7 +2,6 @@
 
 test_description='test if rebase detects and aborts on incompatible options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
index 2fab703d615..4859bb8f722 100755
--- a/t/t3423-rebase-reword.sh
+++ b/t/t3423-rebase-reword.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase interactive with rewording'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 515c949ae37..1ee6b00fd57 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase of commits that start or become empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup test repository' '
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index a16428bdf54..675491234a6 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase topology tests with merges'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index 94ea88e384e..ba069dccbdf 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
index 5e9046e3df3..1b3e97c8755 100755
--- a/t/t3427-rebase-subtree.sh
+++ b/t/t3427-rebase-subtree.sh
@@ -7,7 +7,6 @@ This test runs git rebase and tests the subtree strategy.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 365436ebfc3..6f57aed9fac 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,7 +5,6 @@ test_description='git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 8e0d03969a2..abd66f36021 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase should reread the todo file if an exec modifies it'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index cb891eeb5fd..2593711fecd 100755
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
index 7b9c135c6e2..be09fc78c16 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -8,7 +8,6 @@ test_description='git rebase --fork-point test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---E    (main)
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 7f1a5dd3deb..5086e14c022 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -8,7 +8,6 @@ test_description='ensure rebase fast-forwards commits when possible'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3433-rebase-across-mode-change.sh b/t/t3433-rebase-across-mode-change.sh
index c8172b08522..05df964670f 100755
--- a/t/t3433-rebase-across-mode-change.sh
+++ b/t/t3433-rebase-across-mode-change.sh
@@ -2,7 +2,6 @@
 
 test_description='git rebase across mode change'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index 97fc9a23f21..8c94fdffc43 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -17,7 +17,6 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6e329fea7c0..6aa2aeb628d 100755
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
index 4d9744e5fc7..94671d3c465 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -5,7 +5,6 @@
 
 test_description='tests to ensure compatibility between am and interactive backends'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 7929e2e2e3a..6f9307e0e3c 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -14,7 +14,6 @@ to the "fixup" command that works with "fixup!", "fixup -C" works with
 "amend!" upon --autosquash.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index 821f08e5afb..78d42f4c799 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -2,7 +2,6 @@
 
 test_description='rebase behavior when on-disk files are broken'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up conflicting branches' '
diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 61ca87512d5..78c3eac54b5 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -11,7 +11,6 @@ checks that git cherry only returns the second patch in the local branch
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_EMAIL=bogus_email_address
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 411027fb58c..17a99379625 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -5,7 +5,6 @@ test_description='miscellaneous basic tests for cherry-pick and revert'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index 1b2c0d6aca6..5495eacfec1 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -11,7 +11,6 @@ test_description='cherry picking and reverting a merge
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3503-cherry-pick-root.sh b/t/t3503-cherry-pick-root.sh
index 76d393dc8a3..95fe4feaeee 100755
--- a/t/t3503-cherry-pick-root.sh
+++ b/t/t3503-cherry-pick-root.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking (and reverting) a root commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 109016eba92..18aeba161c0 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick should rerere for conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index ead3fb46807..9748443530c 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking an empty commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index b71bad17b85..7e11bd4a4c5 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking with --ff option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 10e9c91dbbd..f3947b400a3 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -13,7 +13,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index afa7727a4af..2d53ce754c5 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -5,7 +5,6 @@ test_description='test cherry-picking many commits'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_head_differs_from() {
diff --git a/t/t3509-cherry-pick-merge-df.sh b/t/t3509-cherry-pick-merge-df.sh
index 171cc6d76b7..f4159246e1e 100755
--- a/t/t3509-cherry-pick-merge-df.sh
+++ b/t/t3509-cherry-pick-merge-df.sh
@@ -4,7 +4,6 @@ test_description='Test cherry-pick with directory/file conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'Initialize repository' '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 93c725bac3c..7eb52b12edc 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -12,7 +12,6 @@ test_description='Test cherry-pick continuation features
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Repeat first match 10 times
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index dd5d92ef302..84a587daf3a 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -2,7 +2,6 @@
 
 test_description='Test cherry-pick -x and -s'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pristine_detach () {
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index 9387a22a9e7..f22d1ddead1 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -5,7 +5,6 @@ test_description='cherry-pick can handle submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index e178968b408..8bfe3ed2467 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='revert can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3514-cherry-pick-revert-gpg.sh b/t/t3514-cherry-pick-revert-gpg.sh
index 133dc072178..5b2e250eaa5 100755
--- a/t/t3514-cherry-pick-revert-gpg.sh
+++ b/t/t3514-cherry-pick-revert-gpg.sh
@@ -5,7 +5,6 @@
 
 test_description='test {cherry-pick,revert} --[no-]gpg-sign'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 31ac31d4bcd..98259e2adaa 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,7 +8,6 @@ test_description='Test of the various options to git rm.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index 7cef12981c4..31bd9960fcd 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='rm --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index fcdefba48cc..08580fd3dcc 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git rm in sparse checked out working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 12bd3db4cb7..389670262e4 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -5,7 +5,6 @@ test_description='basic git replay tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_AUTHOR_NAME=author@name
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 839c904745a..4c543a1a7e8 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -5,7 +5,6 @@
 
 test_description='Test of git add, including the -- option.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-unique-files.sh
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 718438ffc7d..b8a05d95f3f 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,7 +4,6 @@ test_description='add -i basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t3702-add-edit.sh b/t/t3702-add-edit.sh
index 82bfb2fd2ac..8bacacbac68 100755
--- a/t/t3702-add-edit.sh
+++ b/t/t3702-add-edit.sh
@@ -5,7 +5,6 @@
 
 test_description='add -e basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
index d84071038e0..3ef525a559d 100755
--- a/t/t3703-add-magic-pathspec.sh
+++ b/t/t3703-add-magic-pathspec.sh
@@ -2,7 +2,6 @@
 
 test_description='magic pathspec tests using git-add'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 3aa59f6f639..b9c96e273fb 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='add --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 6ae45a788d1..2bade9e804f 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git add in sparse checked out working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SPARSE_ENTRY_BLOB=""
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d3e428ff46e..e3cf0ffbe59 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,7 +4,6 @@
 
 test_description='git mktag: tag object verify test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 9d4b5ab1f95..3c930ec202d 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -5,7 +5,6 @@
 
 test_description='commit and log output encodings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index e0659c92935..f03601b49a9 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -8,7 +8,6 @@ test_description='i18n settings and format-patch | am pipe'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 72a5a565e97..f528008c363 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -5,7 +5,6 @@
 
 test_description='quoted output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 FN='濱野'
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index c87592ee2f3..74666ff3e4b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -8,7 +8,6 @@ test_description='Test git stash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-unique-files.sh
 
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index aa5019fd6c3..ae313e3c705 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='stash -p'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index a1733f45c3a..1289ae3e07c 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git stash --include-untracked'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'stash save --include-untracked some dirty working directory' '
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 0f61f01ef43..0f7348ec21b 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='stash can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t3907-stash-show-config.sh b/t/t3907-stash-show-config.sh
index 7a2eb98b864..10914bba7b3 100755
--- a/t/t3907-stash-show-config.sh
+++ b/t/t3907-stash-show-config.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git stash show configuration.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3908-stash-in-worktree.sh b/t/t3908-stash-in-worktree.sh
index 347a89b030b..2b2b366ef94 100755
--- a/t/t3908-stash-in-worktree.sh
+++ b/t/t3908-stash-in-worktree.sh
@@ -5,7 +5,6 @@
 
 test_description='Test git stash in a worktree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 83269d0eb4c..73f2dbdeb02 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='stash --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 31877f00c77..e2e1251a057 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -2,7 +2,6 @@
 
 test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 LIB_CRLF_BRANCHES=""
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index 8d50331b8c8..a51f881b1c9 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -10,7 +10,6 @@ same command line parser, so testing one should be sufficient; pick
 diff-files as a representative.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index cd1931dd555..4f520d600de 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -5,7 +5,6 @@
 
 test_description='Test rename detection in diff engine.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index cb3307010c1..e44648e6f3d 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -7,7 +7,6 @@ test_description='Test diff raw-output.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index ebe091828c8..fd4faee5d25 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -7,7 +7,6 @@ test_description='More rename detection
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
index 1d70d4d221b..faf3465deb4 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -10,7 +10,6 @@ copy of symbolic links, but should not produce rename/copy followed
 by an edit for them.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 5c756dc2435..92d1141fbe0 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -6,7 +6,6 @@
 test_description='Same rename detection as t4003 but testing diff-raw.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4006-diff-mode.sh b/t/t4006-diff-mode.sh
index dbd4c0da213..2299b91fc4b 100755
--- a/t/t4006-diff-mode.sh
+++ b/t/t4006-diff-mode.sh
@@ -7,7 +7,6 @@ test_description='Test mode change diffs.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 sed_script='s/\(:100644 100755\) \('"$OID_REGEX"'\) \2 /\1 X X /'
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index b86165cbac5..e8faf0dd2ef 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -7,7 +7,6 @@ test_description='Rename interaction with pathspec.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index b0ef0026e08..c187c52dab2 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -22,7 +22,6 @@ With -B, this should be detected as two complete rewrites.
 Further, with -B and -M together, these should turn into two renames.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 3480781dabf..59e71e3acde 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -7,7 +7,6 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index 9d9650eba7e..c84c3fa05b2 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -10,7 +10,6 @@ Prepare:
         path1/file1
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index bc8ba887191..ac837b6c9ec 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -7,7 +7,6 @@ test_description='Test diff of symlinks.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index c64d9d2f405..d1d30ac2a94 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -6,7 +6,6 @@
 test_description='Binary diff and apply
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.binary-numstat <<\EOF
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 87d248d0347..3855d68dbc0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -8,7 +8,6 @@ test_description='Various diff formatting options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 1c46e963e43..884f83fb8a4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -8,7 +8,6 @@ test_description='various format-patch tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 851cfe4f32c..52e3e476ffa 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -7,7 +7,6 @@ test_description='Test special whitespace in diff engine.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quote.sh
index 5a8d8876831..876271d6826 100755
--- a/t/t4016-diff-quote.sh
+++ b/t/t4016-diff-quote.sh
@@ -6,7 +6,6 @@
 test_description='Quoting paths in diff output.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 P0='pathname'
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 1cea73ef5a3..c2863c99b71 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -5,7 +5,6 @@ test_description='Return value of diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 8128c30e7f2..e026fac1f40 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -5,7 +5,6 @@
 
 test_description='Test custom diff function name patterns'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index d2b3109c2d3..4001dacee39 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -2,7 +2,6 @@
 
 test_description='diff whitespace error detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0e5a05894fd..f1efe482a59 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -2,7 +2,6 @@
 
 test_description='external diff interface test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 1219aa226dc..9be65fd4440 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,7 +5,6 @@
 
 test_description='Format-patch numbering options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 77bc36d5d8f..6fed993ea0b 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -2,7 +2,6 @@
 
 test_description='rewrite diff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index e6f4fe441e1..787605ce3fd 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -2,7 +2,6 @@
 
 test_description='typechange rename detection'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4024-diff-optimize-common.sh b/t/t4024-diff-optimize-common.sh
index e2f0eca4af0..b98ac0a0c03 100755
--- a/t/t4024-diff-optimize-common.sh
+++ b/t/t4024-diff-optimize-common.sh
@@ -2,7 +2,6 @@
 
 test_description='common tail optimization'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 z=zzzzzzzz ;# 8
diff --git a/t/t4025-hunk-header.sh b/t/t4025-hunk-header.sh
index 5397cb7d42d..c39bb07a417 100755
--- a/t/t4025-hunk-header.sh
+++ b/t/t4025-hunk-header.sh
@@ -2,7 +2,6 @@
 
 test_description='diff hunk header truncation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 N='日本語'
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index b05f2a9b607..08f6805e1c8 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -5,7 +5,6 @@
 
 test_description='Test diff/status color escape codes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ESC=$(printf '\033')
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 40164ae07d2..295da987cce 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='difference in submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 60cb819c42e..a06a7479260 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -2,7 +2,6 @@
 
 test_description='format-patch mime headers and extra headers do not conflict'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 5f8ffef74b6..32b6e9a4e76 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -4,7 +4,6 @@
 #
 test_description='diff honors config option, diff.suppressBlankEmpty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat <<\EOF >expected ||
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 29f6d610c2e..daebf9796f5 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='diff.*.textconv tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_diff() {
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index 1b8cd3e4c97..c4394a27b56 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -2,7 +2,6 @@
 
 test_description='rewrite diff on binary file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We must be large enough to meet the MINIMUM_BREAK_SIZE
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index 7db92d0d9f4..bada0cbd32f 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -2,7 +2,6 @@
 
 test_description='diff hunk fusing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 f() {
diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index f7be7f5ef01..113304dc596 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -2,7 +2,6 @@
 
 test_description='patience diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 4dcd7e99250..f51d3557f10 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -2,7 +2,6 @@
 
 test_description='word diff colors'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 76f8034c60f..0352bf81a90 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -2,7 +2,6 @@
 
 test_description='Return value of diffs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 48655bcc789..98d9713d8b2 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,7 +2,6 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4037-diff-r-t-dirs.sh b/t/t4037-diff-r-t-dirs.sh
index b5f96fe23bd..f5ce3b29a2a 100755
--- a/t/t4037-diff-r-t-dirs.sh
+++ b/t/t4037-diff-r-t-dirs.sh
@@ -2,7 +2,6 @@
 
 test_description='diff -r -t shows directory additions and deletions'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 00190802d83..2ce26e585c9 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -5,7 +5,6 @@ test_description='combined diff'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4039-diff-assume-unchanged.sh b/t/t4039-diff-assume-unchanged.sh
index 78090e6852d..0eb0314a8b3 100755
--- a/t/t4039-diff-assume-unchanged.sh
+++ b/t/t4039-diff-assume-unchanged.sh
@@ -2,7 +2,6 @@
 
 test_description='diff with assume-unchanged entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # external diff has been tested in t4020-diff-external.sh
diff --git a/t/t4040-whitespace-status.sh b/t/t4040-whitespace-status.sh
index eec3d73dc2b..1b27a0e3813 100755
--- a/t/t4040-whitespace-status.sh
+++ b/t/t4040-whitespace-status.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --exit-code with whitespace'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index aa149e0085e..28f9d83d4c1 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -12,7 +12,6 @@ This test tries to verify the sanity of the --submodule option of git diff.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test non-UTF-8 encoding in case iconv is available.
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index a179205394d..ff0e73531b9 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -2,7 +2,6 @@
 
 test_description='test textconv caching'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t4043-diff-rename-binary.sh b/t/t4043-diff-rename-binary.sh
index e4864939081..2a2cf913520 100755
--- a/t/t4043-diff-rename-binary.sh
+++ b/t/t4043-diff-rename-binary.sh
@@ -5,7 +5,6 @@
 
 test_description='Move a binary file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t4044-diff-index-unique-abbrev.sh b/t/t4044-diff-index-unique-abbrev.sh
index 9f6043dabac..8400bfbd3c7 100755
--- a/t/t4044-diff-index-unique-abbrev.sh
+++ b/t/t4044-diff-index-unique-abbrev.sh
@@ -2,7 +2,6 @@
 
 test_description='test unique sha1 abbreviation on "index from..to" line'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 9b46c4c1bef..2c8493fe66c 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --relative tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index afda629c981..7c27f053663 100755
--- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -2,7 +2,6 @@
 
 test_description='diff with unmerged index entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 7b73462d53d..a7ce8d3161b 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --dirstat tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # set up two commits where the second commit has these files
diff --git a/t/t4048-diff-combined-binary.sh b/t/t4048-diff-combined-binary.sh
index f399484bcef..0260cf64f5d 100755
--- a/t/t4048-diff-combined-binary.sh
+++ b/t/t4048-diff-combined-binary.sh
@@ -4,7 +4,6 @@ test_description='combined and merge diff handle binary files and textconv'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup binary merge conflict' '
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 0a4fc735d44..eceb47c8594 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -3,7 +3,6 @@
 
 test_description='diff --stat-count'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4050-diff-histogram.sh b/t/t4050-diff-histogram.sh
index c61b30f96da..fd3e86a74f3 100755
--- a/t/t4050-diff-histogram.sh
+++ b/t/t4050-diff-histogram.sh
@@ -2,7 +2,6 @@
 
 test_description='histogram diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 725278ad19c..4838a1df8b4 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -2,7 +2,6 @@
 
 test_description='diff function context'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dir="$TEST_DIRECTORY/t4051"
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 7badd72488d..740bb970918 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -8,7 +8,6 @@ test_description='test --stat output of various commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 651ec776606..5e5bad61ca1 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -2,7 +2,6 @@
 
 test_description='diff --no-index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4054-diff-bogus-tree.sh b/t/t4054-diff-bogus-tree.sh
index 05c88f8cdf0..1131431fe0e 100755
--- a/t/t4054-diff-bogus-tree.sh
+++ b/t/t4054-diff-bogus-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='test diff with a bogus tree containing the null sha1'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create bogus tree' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 3ea9ae99e04..f7ff234cf93 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -5,7 +5,6 @@
 
 test_description='diff.context configuration'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 32c5fcb9a27..aec1d9d1b42 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -5,7 +5,6 @@ test_description='diff order & rotate'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_files () {
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index 9a7505cbb8b..04b8a1542a8 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -5,7 +5,6 @@ test_description='combined diff show only paths that are different to all parent
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # verify that diffc.expect matches output of
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 18e5ac88c31..2fce4a98977 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -11,7 +11,6 @@
 
 test_description='test tree diff when trees have duplicate entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # make_tree_entry <mode> <mode> <sha1>
diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
index 28fd3cdb154..0fe81056d5b 100755
--- a/t/t4059-diff-submodule-not-initialized.sh
+++ b/t/t4059-diff-submodule-not-initialized.sh
@@ -9,7 +9,6 @@ This test tries to verify that add_submodule_odb works when the submodule was
 initialized previously but the checkout has since been removed.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 918334fa4c8..76b83101d3b 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -10,7 +10,6 @@ test_description='Support for diff format verbose submodule difference in git di
 This test tries to verify the sanity of --submodule=diff option of git diff.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test non-UTF-8 encoding in case iconv is available.
diff --git a/t/t4061-diff-indent.sh b/t/t4061-diff-indent.sh
index 2942e5d9b93..7750b87ca16 100755
--- a/t/t4061-diff-indent.sh
+++ b/t/t4061-diff-indent.sh
@@ -6,7 +6,6 @@ test_description='Test diff indent heuristic.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index a90b46b678c..8ad3d799579 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -5,7 +5,6 @@
 
 test_description='Pickaxe options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 7e6c9d63843..50fdb5ea529 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -2,7 +2,6 @@
 
 test_description='test direct comparison of blobs via git-diff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 run_diff () {
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 846f285f772..e86bba679e5 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -2,7 +2,6 @@
 
 test_description='test finding specific blobs in the revision walking'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index 647537c12ea..b3f510f040e 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,7 +2,6 @@
 
 test_description='anchored diff algorithm'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '--anchored' '
diff --git a/t/t4066-diff-emit-delay.sh b/t/t4066-diff-emit-delay.sh
index 0ecb3915412..a1de63b77f8 100755
--- a/t/t4066-diff-emit-delay.sh
+++ b/t/t4066-diff-emit-delay.sh
@@ -4,7 +4,6 @@ test_description='test combined/stat/moved interaction'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test covers a weird 3-way interaction between "--cc -p", which will run
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 7af3a08862d..581250dd2d2 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='behavior of diff when reading objects in a partial clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git show batches blobs' '
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index 4d6565e728b..eff63c16b06 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,7 +5,6 @@ test_description='behavior of diff with symmetric-diff setups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # build these situations:
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index df342850a0d..ca8f999caba 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@
 
 test_description='remerge-diff handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index d503547732c..146e73d8f55 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -7,7 +7,6 @@ test_description='git apply --stat --summary test, with --recount
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 UNC='s/^\(@@ -[1-9][0-9]*\),[0-9]* \(+[1-9][0-9]*\),[0-9]* @@/\1,999 \2,999 @@/'
diff --git a/t/t4101-apply-nonl.sh b/t/t4101-apply-nonl.sh
index b1169193ef5..4df74baa249 100755
--- a/t/t4101-apply-nonl.sh
+++ b/t/t4101-apply-nonl.sh
@@ -7,7 +7,6 @@ test_description='git apply should handle files with incomplete lines.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index d1e06fc1ac4..e42a31c9179 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -7,7 +7,6 @@ test_description='git apply handling copy/rename patch.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index 144619ab873..d370ecfe0d9 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -9,7 +9,6 @@ test_description='git apply handling binary patches
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4104-apply-boundary.sh b/t/t4104-apply-boundary.sh
index dc501aac387..71ef4132d15 100755
--- a/t/t4104-apply-boundary.sh
+++ b/t/t4104-apply-boundary.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply boundary tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 L="c d e f g h i j k l m n o p q r s t u v w x"
diff --git a/t/t4105-apply-fuzz.sh b/t/t4105-apply-fuzz.sh
index ed814a839e6..b59785166d4 100755
--- a/t/t4105-apply-fuzz.sh
+++ b/t/t4105-apply-fuzz.sh
@@ -3,7 +3,6 @@
 test_description='apply with fuzz and offset'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dotest () {
diff --git a/t/t4106-apply-stdin.sh b/t/t4106-apply-stdin.sh
index 5c150f3b0b2..aa2fff7afa7 100755
--- a/t/t4106-apply-stdin.sh
+++ b/t/t4106-apply-stdin.sh
@@ -3,7 +3,6 @@
 test_description='git apply --numstat - <patch'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4107-apply-ignore-whitespace.sh b/t/t4107-apply-ignore-whitespace.sh
index 5e6e203aa52..94ba6dd4e00 100755
--- a/t/t4107-apply-ignore-whitespace.sh
+++ b/t/t4107-apply-ignore-whitespace.sh
@@ -5,7 +5,6 @@
 
 test_description='git-apply --ignore-whitespace.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This primes main.c file that indents without using HT at all.
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c6302163d84..f30e85659db 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,7 +5,6 @@ test_description='git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 print_sanitized_conflicted_diff () {
diff --git a/t/t4109-apply-multifrag.sh b/t/t4109-apply-multifrag.sh
index 4dc6d8e7d3c..ac523a5d562 100755
--- a/t/t4109-apply-multifrag.sh
+++ b/t/t4109-apply-multifrag.sh
@@ -7,7 +7,6 @@
 test_description='git apply test patches with multiple fragments.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cp "$TEST_DIRECTORY/t4109/patch1.patch" .
diff --git a/t/t4110-apply-scan.sh b/t/t4110-apply-scan.sh
index 266302a1829..cc17ff2ab9a 100755
--- a/t/t4110-apply-scan.sh
+++ b/t/t4110-apply-scan.sh
@@ -8,7 +8,6 @@ test_description='git apply test for patches which require scanning forwards and
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git apply scan' '
diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
index e9a87d761d1..1618a6dbc7c 100755
--- a/t/t4111-apply-subdir.sh
+++ b/t/t4111-apply-subdir.sh
@@ -2,7 +2,6 @@
 
 test_description='patching from inconvenient places'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4112-apply-renames.sh b/t/t4112-apply-renames.sh
index d53aa4222ea..bb5d529bec1 100755
--- a/t/t4112-apply-renames.sh
+++ b/t/t4112-apply-renames.sh
@@ -8,7 +8,6 @@ test_description='git apply should not get confused with rename/copy.
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 2c65c6a1696..66fa51591eb 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -6,7 +6,6 @@
 test_description='git apply trying to add an ending line.
 
 '
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # setup
diff --git a/t/t4114-apply-typechange.sh b/t/t4114-apply-typechange.sh
index 8ff36407667..da3e64f8110 100755
--- a/t/t4114-apply-typechange.sh
+++ b/t/t4114-apply-typechange.sh
@@ -7,7 +7,6 @@ test_description='git apply should not get confused with type changes.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repository and commits' '
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index cbef0a593fb..769b0e4f9df 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -7,7 +7,6 @@ test_description='git apply symlinks and partial files
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index a9f4ddda6c3..0784ba033a4 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -8,7 +8,6 @@ test_description='git apply in reverse
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index 4d15ccd28ec..c86d05a96fe 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -7,7 +7,6 @@ test_description='git apply with rejects
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty-context.sh
index 69c9c48e72b..c1dcbd7d356 100755
--- a/t/t4118-apply-empty-context.sh
+++ b/t/t4118-apply-empty-context.sh
@@ -8,7 +8,6 @@ test_description='git apply with new style GNU diff with empty context
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4119-apply-config.sh b/t/t4119-apply-config.sh
index 208c961d376..f3b43e22162 100755
--- a/t/t4119-apply-config.sh
+++ b/t/t4119-apply-config.sh
@@ -8,7 +8,6 @@ test_description='git apply --whitespace=strip and configuration file.
 '
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index f7884285400..697e86c0ff4 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply -p handling.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4121-apply-diffs.sh b/t/t4121-apply-diffs.sh
index a80cec9d119..b45454aaf4b 100755
--- a/t/t4121-apply-diffs.sh
+++ b/t/t4121-apply-diffs.sh
@@ -4,7 +4,6 @@ test_description='git apply for contextually independent diffs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 echo '1
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 2089d84f645..3340ab4370c 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,7 +4,6 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 3601c0c5dca..3ef84619f53 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,7 +2,6 @@
 
 test_description='apply a patch that is larger than the preimage'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index cdffee0273c..485c7d2d124 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -2,7 +2,6 @@
 
 test_description='core.whitespace rules and git apply'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_test_file () {
diff --git a/t/t4125-apply-ws-fuzz.sh b/t/t4125-apply-ws-fuzz.sh
index f248cc2a008..090987c89b2 100755
--- a/t/t4125-apply-ws-fuzz.sh
+++ b/t/t4125-apply-ws-fuzz.sh
@@ -2,7 +2,6 @@
 
 test_description='applying patch that has broken whitespaces in context'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 56210b56099..eff783f8d68 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,7 +2,6 @@
 
 test_description='apply empty'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4127-apply-same-fn.sh b/t/t4127-apply-same-fn.sh
index aa5cfae2b68..bd516c4aad7 100755
--- a/t/t4127-apply-same-fn.sh
+++ b/t/t4127-apply-same-fn.sh
@@ -3,7 +3,6 @@
 test_description='apply same filename'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index ed94c90204e..f6db5a79dd9 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -2,7 +2,6 @@
 
 test_description='apply same filename'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index 87ffd2b8e1a..2149ad5da44 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -3,7 +3,6 @@
 test_description='applying patch with mode bits'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index f3ea6327425..211ef1c7e78 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply handling criss-cross rename patch.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_file() {
diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index 40c92115a66..b1361ce5469 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply --build-fake-ancestor handling.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index c1e3049c041..ab1628d27d0 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -5,7 +5,6 @@
 test_description='git-apply notices removal patches generated by GNU diff'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index c21ddb29466..3cab1038cf5 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -6,7 +6,6 @@
 test_description='git apply filename consistency check'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index aceb4c42b0f..8cea75cf7bc 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -6,7 +6,6 @@
 test_description='git apply submodule tests'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4135-apply-weird-filenames.sh b/t/t4135-apply-weird-filenames.sh
index d3502c6fddf..6bc3fb97a75 100755
--- a/t/t4135-apply-weird-filenames.sh
+++ b/t/t4135-apply-weird-filenames.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply with weird postimage filenames'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index dfec1c5f0f6..82f2f2e4753 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -3,7 +3,6 @@
 test_description='git apply should exit non-zero with unrecognized input.'
 
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index ebd0d4ad17c..07d52625375 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply handling submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
index 7981931b4ed..8bbf8260fa6 100755
--- a/t/t4138-apply-ws-expansion.sh
+++ b/t/t4138-apply-ws-expansion.sh
@@ -5,7 +5,6 @@
 
 test_description='git apply test patches with whitespace expansion.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4139-apply-escape.sh b/t/t4139-apply-escape.sh
index e5c7439df13..e07fb9ef089 100755
--- a/t/t4139-apply-escape.sh
+++ b/t/t4139-apply-escape.sh
@@ -2,7 +2,6 @@
 
 test_description='paths written by git-apply cannot escape the working tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # tests will try to write to ../foo, and we do not
diff --git a/t/t4140-apply-ita.sh b/t/t4140-apply-ita.sh
index b375aca0d74..c614eaf04cc 100755
--- a/t/t4140-apply-ita.sh
+++ b/t/t4140-apply-ita.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply of i-t-a file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4141-apply-too-large.sh b/t/t4141-apply-too-large.sh
index 20cc1209f62..eac6f7e151b 100755
--- a/t/t4141-apply-too-large.sh
+++ b/t/t4141-apply-too-large.sh
@@ -2,7 +2,6 @@
 
 test_description='git apply with too-large patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 232e1394e8d..5e2b6c80eae 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -5,7 +5,6 @@ test_description='git am running'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: messages' '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 1825a89d6a9..edb38da7010 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -2,7 +2,6 @@
 
 test_description='am --abort'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 9f2edba1f83..768495b1315 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -2,7 +2,6 @@
 
 test_description='test subject preservation with format-patch | am'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 make_patches() {
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-override-opts.sh
index dd6ad8f7a80..9bec989a0ed 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -2,7 +2,6 @@
 
 test_description='git-am command-line options override saved options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 format_patch () {
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 213b36fb962..b0a3e849841 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,7 +25,6 @@ test_description='git rerere
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7f47f85c7f3..5f23fc147bb 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -9,7 +9,6 @@ test_description='git shortlog
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 35bec4089a3..51f7beb59f8 100755
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
index 2265ff8872d..24214919312 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -5,7 +5,6 @@ test_description='.mailmap configurations'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits and contacts file' '
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index 8e0f283c2b8..605faea0c7b 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,7 +5,6 @@ test_description='git patch-id'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f9a9c2145ed..f81e42a84d5 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -6,7 +6,6 @@
 
 test_description='Test pretty formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index 9167b0351f2..bcab71c8e84 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -7,7 +7,6 @@ test_description='Test --follow should always find copies hard in git log.
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 73ea9e51550..0614511656f 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -8,7 +8,6 @@ test_description='test "git log --decorate" colors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 2a46eb6bedb..806b2809d40 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -5,7 +5,6 @@ test_description='magic pathspec tests using git-log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index b42fdc54fcb..a675ace0819 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -2,7 +2,6 @@
 
 test_description='log --grep/--author/--regexp-ignore-case/-S/-G'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_log () {
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 4a12b2b4979..26dda0db384 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -2,7 +2,6 @@
 
 test_description='test log with i18n features'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1d6dd982a2a..950451cf6a6 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,7 +4,6 @@ test_description='test log -L'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index e6b59123a37..64d818bc70a 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -2,7 +2,6 @@
 
 test_description='git log with invalid commit headers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
index 590fce95e90..53a4af32449 100755
--- a/t/t4213-log-tabexpand.sh
+++ b/t/t4213-log-tabexpand.sh
@@ -2,7 +2,6 @@
 
 test_description='log/show --expand-tabs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HT="	"
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index 79055978690..f70c46bbbfa 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -5,7 +5,6 @@ test_description='git log --graph of skewed left octopus merge.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index b877ac72351..28d0779a8c5 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -2,7 +2,6 @@
 
 test_description='git log --graph of skewed merges'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8d22338f6aa..3f163dc3969 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -4,7 +4,6 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
index 613f0710e90..6e01e2629c1 100755
--- a/t/t4217-log-limit.sh
+++ b/t/t4217-log-limit.sh
@@ -2,7 +2,6 @@
 
 test_description='git log with filter options limiting the output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup test' '
diff --git a/t/t4252-am-options.sh b/t/t4252-am-options.sh
index 5b680dc7559..bda8822b3d1 100755
--- a/t/t4252-am-options.sh
+++ b/t/t4252-am-options.sh
@@ -2,7 +2,6 @@
 
 test_description='git am with options and not losing them'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 tm="$TEST_DIRECTORY/t4252"
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 2bcdd9f34fa..0ee69d2a0c4 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -9,7 +9,6 @@ test_description='git-am mbox with dos line ending.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Three patches which will be added as files with dos line ending.
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index cb03522d021..ae0a56cf5ec 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -2,7 +2,6 @@
 
 test_description='git am with corrupt input'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index 04f3ccfc41c..a7ba08f728c 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git am handling submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 92d8c8b651c..ac9db285f3f 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -2,7 +2,6 @@
 
 test_description='test format=flowed support of git am'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
index f26d7fd2dbd..30a565cbeaf 100755
--- a/t/t4257-am-interactive.sh
+++ b/t/t4257-am-interactive.sh
@@ -2,7 +2,6 @@
 
 test_description='am --interactive tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up patches to apply' '
diff --git a/t/t4258-am-quoted-cr.sh b/t/t4258-am-quoted-cr.sh
index 3573c9147f1..201915b45a8 100755
--- a/t/t4258-am-quoted-cr.sh
+++ b/t/t4258-am-quoted-cr.sh
@@ -2,7 +2,6 @@
 
 test_description='test am --quoted-cr=<action>'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t4258"
diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index 9c197260d5b..27fbe193bca 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -5,7 +5,6 @@
 
 test_description='git merge-tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 37f1cd7364c..eea19907b55 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='git merge-tree --write-tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index b9fda973f7b..5465054f177 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,6 @@ commit id embedding:
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 7310774af5e..e7450764411 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -3,7 +3,6 @@
 test_description='git archive attribute tests'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT='%H (%h)%n'
diff --git a/t/t5002-archive-attr-pattern.sh b/t/t5002-archive-attr-pattern.sh
index 78ab75f1bc2..97c93f6c442 100755
--- a/t/t5002-archive-attr-pattern.sh
+++ b/t/t5002-archive-attr-pattern.sh
@@ -2,7 +2,6 @@
 
 test_description='git archive attribute pattern tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 01f591c99b9..961c6aac256 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -3,7 +3,6 @@
 test_description='git archive --format=zip test'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 SUBSTFORMAT=%H%n
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 9f2c6da80e8..50344e17ca1 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -2,7 +2,6 @@
 
 test_description='test corner cases of git-archive'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # the 10knuls.tar file is used to test for an empty git generated tar
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 23b2f218725..e57e1ae7395 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -5,7 +5,6 @@
 
 test_description='git mailinfo and git mailsplit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 DATA="$TEST_DIRECTORY/t5100"
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 86bee331607..cb67bac1c47 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -5,7 +5,6 @@ test_description='Test workflows involving pull request.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL
diff --git a/t/t5200-update-server-info.sh b/t/t5200-update-server-info.sh
index cc51c73986c..83659070559 100755
--- a/t/t5200-update-server-info.sh
+++ b/t/t5200-update-server-info.sh
@@ -2,7 +2,6 @@
 
 test_description='Test git update-server-info'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' 'test_commit file'
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a5..e13f289dd59 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -5,7 +5,6 @@
 
 test_description='git pack-object'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 226490d60df..ff6b5159a31 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -5,7 +5,6 @@
 
 test_description='mmap sliding window tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index d88e6f16910..413c99274c8 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -5,7 +5,6 @@
 
 test_description='pack index with 64-bit offsets and object CRC'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index b634bfb6651..de58ca654a1 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -5,7 +5,6 @@
 
 test_description='resilience to pack corruptions with redundant objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note: the test objects are created with knowledge of their pack encoding
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e641df0116c..1f1f664871e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -7,7 +7,6 @@ test_description='prune'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 day=$((60*60*24))
diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
index dc8fe55c82d..44bd9ef45fd 100755
--- a/t/t5305-include-tag.sh
+++ b/t/t5305-include-tag.sh
@@ -4,7 +4,6 @@ test_description='git pack-object --include-tag'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 TRASH=$(pwd)
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 0d50c6b4bca..805d60ff317 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -7,7 +7,6 @@ test_description='git-pack-object with missing base
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create A-B chain
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index 1e02c305c4f..fa4bc269fe8 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -2,7 +2,6 @@
 
 test_description='pack should notice missing commit objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5308-pack-detect-duplicates.sh b/t/t5308-pack-detect-duplicates.sh
index 655cafa0541..0f841378677 100755
--- a/t/t5308-pack-detect-duplicates.sh
+++ b/t/t5308-pack-detect-duplicates.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of duplicate objects in incoming packfiles'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 4e910c5b9d2..60fc710bacb 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -2,7 +2,6 @@
 
 test_description='test index-pack handling of delta cycles in packfiles'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 7044c7d7c6d..a6de7c57643 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic bitmap functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow.sh
index 4fe71fe8cd2..012852c156a 100755
--- a/t/t5311-pack-bitmaps-shallow.sh
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -2,7 +2,6 @@
 
 test_description='check bitmap operation with shallow repositories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We want to create a situation where the shallow, grafted
diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index d8d2e304687..c37ef3818d2 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -14,7 +14,6 @@ what currently happens. If that changes, these tests should be revisited.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'disable reflogs' '
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 86fc73f9fba..5be01260d77 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -2,7 +2,6 @@
 
 test_description='bounds-checking of access to mmapped on-disk file formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 clear_base () {
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index 82734b9a3c4..9cd18c1e6be 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -50,7 +50,6 @@ will always find a delta for "file", because its lookup will always come
 immediately after the lookup for "dummy".
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create a pack containing the tree $1 and blob $1:file, with
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index c80ea9e8b71..8bacd96275b 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-object compression configuration'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index eb4ef3dda4d..32cf4227451 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-objects breaks long cross-pack delta chains'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This mirrors a repeated push setup:
diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
index 79552d6ef7f..501d715b9a1 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -5,7 +5,6 @@ test_description='git pack-objects using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test blob:none filter.
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2916c07e3c2..f68f64cd85e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='commit graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index fbbc218d04a..0f215ad2e88 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -2,7 +2,6 @@
 
 test_description='multi-pack-indexes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
diff --git a/t/t5320-delta-islands.sh b/t/t5320-delta-islands.sh
index 406363381f1..2c961c70963 100755
--- a/t/t5320-delta-islands.sh
+++ b/t/t5320-delta-islands.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise delta islands'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # returns true iff $1 is a delta based on $2
diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index 70770fe274d..51aaca1fcf6 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -7,7 +7,6 @@ test_description='git pack-object with "large" deltas
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 770695c9278..d39958c066d 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -4,7 +4,6 @@ test_description='pack-objects object selection using sparse algorithm'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup repo' '
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 4e18f5490a8..8dbbcc5e51c 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -34,7 +34,6 @@ relationship between packs and objects is as follows:
     Px2 |         s s s                           x x x
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 main_repo=main.git
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 1193726daad..a32be3867df 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='split commit graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 431a603ca0e..285c8b4a495 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -2,7 +2,6 @@
 
 test_description='on-disk reverse index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The below tests want control over the 'pack.writeReverseIndex' setting
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 6eaa692f33b..d27557b9b04 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic multi-pack bitmap functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 994a8e6be46..9cac03a94bf 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -2,7 +2,6 @@
 
 test_description='exercise basic multi-pack bitmap functionality (.rev files)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index fc6a242b56d..a766a3e3f84 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -2,7 +2,6 @@
 
 test_description='commit graph with 64-bit timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq TIME_IS_64BIT || ! test_have_prereq TIME_T_IS_64BIT
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 54a4a49997c..b71a0aef408 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -2,7 +2,6 @@
 
 test_description='cruft pack related pack-objects tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
index 5eb28f0512d..2cc7fd7a476 100755
--- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
+++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
@@ -2,7 +2,6 @@
 
 test_description='test for no lazy fetch with the commit-graph'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: prepare a repository with a commit' '
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 2dcf1eeceeb..b48c0cbe8fc 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -4,7 +4,6 @@ test_description='pack-objects --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 packed_objects () {
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769b..a1b547b90c1 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -2,7 +2,6 @@
 
 test_description='pack-objects multi-pack reuse'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index eca4a1eb8c6..1dd62847560 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -4,7 +4,6 @@ test_description='pseudo-merge bitmaps'
 
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_pseudo_merges () {
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 471994c4bc8..26257e5660e 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -2,7 +2,6 @@
 
 test_description='incremental multi-pack-index'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
 
diff --git a/t/t5351-unpack-large-objects.sh b/t/t5351-unpack-large-objects.sh
index 43cbcd5d497..d76eb4be932 100755
--- a/t/t5351-unpack-large-objects.sh
+++ b/t/t5351-unpack-large-objects.sh
@@ -5,7 +5,6 @@
 
 test_description='git unpack-objects with large objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 prepare_dest () {
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 248c74d8ef2..3f81f16e133 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -9,7 +9,6 @@ test_description='See why rewinding head breaks send-pack
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cnt=64
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 3c1ea6086e7..723d1e17ec6 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -5,7 +5,6 @@
 
 test_description='Test the update hook infrastructure.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5402-post-merge-hook.sh b/t/t5402-post-merge-hook.sh
index 46ebdfbeeba..915af2de95e 100755
--- a/t/t5402-post-merge-hook.sh
+++ b/t/t5402-post-merge-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-merge hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index cfaae547398..978f240cdac 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-checkout hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 51737eeafee..cc078896673 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -5,7 +5,6 @@ test_description='tracking branch update checks for git push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index 1686ac13aa6..11f03239a06 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -5,7 +5,6 @@ test_description='forced push to replace commit we do not have'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5406-remote-rejects.sh b/t/t5406-remote-rejects.sh
index d6a99466338..dcbeb420827 100755
--- a/t/t5406-remote-rejects.sh
+++ b/t/t5406-remote-rejects.sh
@@ -2,7 +2,6 @@
 
 test_description='remote push rejects are reported by client'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index e99e728236a..ad7f8c6f002 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -7,7 +7,6 @@ test_description='Test the post-rewrite hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index c3695a4d4e3..526a6750459 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -2,7 +2,6 @@
 
 test_description='send-pack --stdin tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_ref () {
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
index 516b22fd963..fa5de4500a4 100755
--- a/t/t5409-colorize-remote-messages.sh
+++ b/t/t5409-colorize-remote-messages.sh
@@ -2,7 +2,6 @@
 
 test_description='remote messages are colorized on the client'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 7a45d4c311e..0b28e4e452f 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -5,7 +5,6 @@ test_description='git receive-pack with alternate ref filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 13d2d310a9f..92cf52c6d4a 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -8,7 +8,6 @@ test_description='Test proc-receive hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 8da8e7fe423..509133c1f91 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -8,7 +8,6 @@ test_description='Testing multi_ack pack fetching'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test fetch-pack/upload-pack pair.
diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index 0c8668a1b8e..66f19a4ef2b 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -4,7 +4,6 @@ test_description='fetch/push involving alternates'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count_objects () {
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index 7b3ff21b984..b160f8b7fb7 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -5,7 +5,6 @@ test_description='test quickfetch from local'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 5ebbaa48968..195fc64dd44 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -5,7 +5,6 @@ test_description='test automatic tag following'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # End state of the repository:
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 138e6778a47..53dbc8ce3a6 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -4,7 +4,6 @@ test_description='fetch/receive strict mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 532035933f3..08424e878e1 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,7 +2,6 @@
 
 test_description='git remote porcelain-ish'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 0e176175a35..16e9a1bc2f2 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -4,7 +4,6 @@ test_description='git remote group handling'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mark() {
diff --git a/t/t5507-remote-environment.sh b/t/t5507-remote-environment.sh
index c6a6957c500..a41d5b370b8 100755
--- a/t/t5507-remote-environment.sh
+++ b/t/t5507-remote-environment.sh
@@ -2,7 +2,6 @@
 
 test_description='check environment showed to remote side of transports'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up "remote" push situation' '
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index f029ae0d286..095df1a7535 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -4,7 +4,6 @@ test_description='fetch/push involving ref namespaces'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0890b9f61c5..3b3991ab867 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -5,7 +5,6 @@ test_description='Per branch config variables affects "git fetch".
 
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index fc55681a3f2..be025b90f98 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -2,7 +2,6 @@
 
 test_description='refspec parsing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_refspec () {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 64b3491e4ee..3a67992a7dc 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -5,7 +5,6 @@ test_description='git ls-remote'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 generate_references () {
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index c46c4dbaefc..65d1e05bd62 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -2,7 +2,6 @@
 
 test_description='fetch follows remote-tracking branches correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 579872c258d..25772c85c5a 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -5,7 +5,6 @@ test_description='fetch --all works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index c100a809c5e..320d26796d2 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -14,7 +14,6 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 build_script () {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 331778bd42c..9d693eb57f7 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -19,7 +19,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index 6d4944a7282..a448e169bd0 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -5,7 +5,6 @@ test_description='pushing to a mirror repository'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
index c13120088fa..5c4ac2556e7 100755
--- a/t/t5518-fetch-exit-status.sh
+++ b/t/t5518-fetch-exit-status.sh
@@ -8,7 +8,6 @@ test_description='fetch exit status test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 72e97b15fab..20ba604dfde 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -5,7 +5,6 @@ test_description='push to a repository that borrows from elsewhere'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1098cbd0a19..47534f1062d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -5,7 +5,6 @@ test_description='pulling into void'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index db00c4336b1..5e420c208c7 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -5,7 +5,6 @@ test_description='pull options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5522-pull-symlink.sh b/t/t5522-pull-symlink.sh
index cc5496e28fd..9fb73a8c3eb 100755
--- a/t/t5522-pull-symlink.sh
+++ b/t/t5522-pull-symlink.sh
@@ -2,7 +2,6 @@
 
 test_description='pulling from symlinked subdir'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The scenario we are building:
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 4ad36a31e18..22d3e1162cd 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -4,7 +4,6 @@ test_description='push with --set-upstream'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 56716e29ddf..b2be3605f5a 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -2,7 +2,6 @@
 
 test_description='git pull message generation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 dollar='$Dollar'
diff --git a/t/t5525-fetch-tagopt.sh b/t/t5525-fetch-tagopt.sh
index 3a28f1ded5f..45815f73785 100755
--- a/t/t5525-fetch-tagopt.sh
+++ b/t/t5525-fetch-tagopt.sh
@@ -2,7 +2,6 @@
 
 test_description='tagopt variable affects "git fetch" and is overridden by commandline.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_clone () {
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 2cfb5bd6bb1..5e566205ba4 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -6,7 +6,6 @@ test_description='Recursive "git fetch" for submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index 98ece27c6a0..e2770e4541f 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -4,7 +4,6 @@ test_description='test fetching of oddly-named refs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # afterwards we will have:
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 1305b1cc254..2bd8759a683 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -4,7 +4,6 @@ test_description='check various push.default settings'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup bare remotes' '
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index 17d72578926..80b06a0cd28 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -5,7 +5,6 @@ test_description='detect some push errors early (before contacting remote)'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7172780d550..558eedf25a4 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -2,7 +2,6 @@
 
 test_description='errors in upload-pack'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index dcfef67af4e..05debd1134d 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index d664912799b..37558226290 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -2,7 +2,6 @@
 
 test_description='fetching via git:// using core.gitproxy'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup remote repo' '
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 6365d99777e..cba26a872dd 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -5,7 +5,6 @@ test_description='compare & swap push force/delete safety'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_srcdst_basic () {
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index d43aee0c327..c91a62b77af 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -5,7 +5,6 @@ test_description='signed push'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index 7122af7fdb5..e8f6d233ffb 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -2,7 +2,6 @@
 
 test_description='avoiding conflicting update through symref aliasing'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2dcbe790523..23bf6961700 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -2,7 +2,6 @@
 
 test_description='fetch handles conflicting refspecs correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index cae4d400f32..37f7547a4ca 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -5,7 +5,6 @@ test_description='fetch/clone from a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index 6adc3a20a45..e91fcc173e8 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -5,7 +5,6 @@ test_description='push from/to a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 82fe09d0a97..3ea75d34ca0 100755
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
index 27389b09081..37db3dec0c5 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -10,7 +10,6 @@ This test runs various sanity checks on http-push.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 3ad514bbd4e..71428f3d5c7 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -7,7 +7,6 @@ test_description='test smart pushing over http via http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ROOT_PATH="$PWD"
diff --git a/t/t5542-push-http-shallow.sh b/t/t5542-push-http-shallow.sh
index 07624a1d7f6..c2cc83182f9 100755
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
index 479d1034695..04b47ad84a8 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -5,7 +5,6 @@ test_description='pushing to a repository using the atomic push option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 1a9e14bbccd..89147a052e7 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -2,7 +2,6 @@
 
 test_description='test custom script in place of pack-objects'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create some history to fetch' '
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 64ce56d3aa8..fb13549da7f 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 mk_repo_pair () {
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 9fc9ba552f1..f1e61c9f095 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -2,7 +2,6 @@
 
 test_description='check receive input limits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Let's run tests with different unpack limits: 1 and 10000
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 9f899b8c7d7..0798ddab02b 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -2,7 +2,6 @@
 
 test_description='check quarantine of objects during push'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create picky dest repo' '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ecb3877aa4b..6282728eaf3 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,7 +4,6 @@
 #
 test_description='Test git push porcelain output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/t/t5549-fetch-push-http.sh b/t/t5549-fetch-push-http.sh
index 6377fb6d993..2cdebcb7356 100755
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
index 5115b8dc230..21795a19bf5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -4,7 +4,6 @@ test_description='test dumb fetching over http via static file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq !REFFILES
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 2ce88535a60..ceb3336a5c4 100755
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
index 4f2e5ae8dfa..eeddb85b1de 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -2,7 +2,6 @@
 
 test_description='test skipping fetch negotiator'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch.negotiationalgorithm config' '
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 33e919a17e1..70e3376d31b 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -4,7 +4,6 @@ test_description='"git fetch/pull --set-upstream" basic tests.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_config () {
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
index 06991e8e8aa..17e73b606d5 100755
--- a/t/t5554-noop-fetch-negotiator.sh
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -2,7 +2,6 @@
 
 test_description='test noop fetch negotiator'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'noop negotiator does not emit any "have"' '
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index 3dcb3340a36..e47ea1ad106 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -2,7 +2,6 @@
 
 test_description='test functionality common to smart fetch & push'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5557-http-get.sh b/t/t5557-http-get.sh
index 76a4bbd16af..67fcc23f110 100755
--- a/t/t5557-http-get.sh
+++ b/t/t5557-http-get.sh
@@ -2,7 +2,6 @@
 
 test_description='test downloading a file by URL'
 
-TEST_PASSES_SANITIZE_LEAK=true
 
 . ./test-lib.sh
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index b488b505b92..3816ed5058d 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,7 +2,6 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
index f75068de648..d30cf4f5b83 100755
--- a/t/t5560-http-backend-noserver.sh
+++ b/t/t5560-http-backend-noserver.sh
@@ -4,7 +4,6 @@ test_description='test git-http-backend-noserver'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 HTTPD_DOCUMENT_ROOT_PATH="$TRASH_DIRECTORY"
diff --git a/t/t5561-http-backend.sh b/t/t5561-http-backend.sh
index e1d3b8caed0..9c57d843152 100755
--- a/t/t5561-http-backend.sh
+++ b/t/t5561-http-backend.sh
@@ -4,7 +4,6 @@ test_description='test git-http-backend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 7ee9858a78b..f3b158274c4 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -2,7 +2,6 @@
 
 test_description='test git-http-backend respects CONTENT_LENGTH'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_lazy_prereq GZIP 'gzip --version'
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index ba03f6a09fc..317f33af5a7 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -2,7 +2,6 @@
 
 test_description='test http auth header and credential helper interop'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 4aef99bc28a..b27e481f95b 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -2,7 +2,6 @@
 
 test_description="test fetching through http proxy"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index e3df7d86410..8df4001b722 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -4,7 +4,6 @@ test_description='test fetching over git protocol'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 448134c4bf7..a11b20e3782 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -4,7 +4,6 @@ test_description='check pre-push hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 9b6cf8d88b9..f7650e8475e 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,7 +5,6 @@ test_description='pull can handle submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
index ab05f38a998..a76b54d7de0 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -2,7 +2,6 @@
 
 test_description='pull signature verification tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index f7707326ea1..5883839a04e 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -5,7 +5,6 @@ test_description='git fetch output format'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch with invalid output format configuration' '
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index d7537a162b2..65ef1a3628e 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -4,7 +4,6 @@ test_description='various Windows-only path tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CYGWIN
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index 724f6100542..cded79c16b5 100755
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
index 7fa54a4029a..7a80e47c2b7 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -8,7 +8,6 @@ test_description='"git fetch" with negative refspecs.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5583-push-branches.sh b/t/t5583-push-branches.sh
index 320f49c753f..e7e1b6dab66 100755
--- a/t/t5583-push-branches.sh
+++ b/t/t5583-push-branches.sh
@@ -5,7 +5,6 @@ test_description='check the consisitency of behavior of --all and --branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 delete_refs() {
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index c814afa5656..34b3df40275 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -13,7 +13,6 @@ Unless the directory already exists, in which case we clean up only what we
 wrote.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 corrupt_repo () {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 3b5285cfcf3..d0c18660e33 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -5,7 +5,6 @@ test_description=clone
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 X=
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index 56329aa160e..cbcceab9d56 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -2,7 +2,6 @@
 
 test_description=clone
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 8ca1f094237..80eb4e04f8b 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -2,7 +2,6 @@
 
 test_description='check output directory names used by git-clone'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # we use a fake ssh wrapper that ignores the arguments
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 9b32db8478a..fa5ca4f522d 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -7,7 +7,6 @@ test_description='test clone --reference'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index d9a320abd21..339d8c786f6 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -4,7 +4,6 @@ test_description='test local clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 repo_is_hardlinked() {
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index e93e0d0cc39..8a152377368 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -4,7 +4,6 @@ test_description='basic clone options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 7ceaa8194d8..489c6570da5 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -4,7 +4,6 @@ test_description='some bundle related tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5609-clone-branch.sh b/t/t5609-clone-branch.sh
index 252e1f7c20f..f86a674a032 100755
--- a/t/t5609-clone-branch.sh
+++ b/t/t5609-clone-branch.sh
@@ -4,7 +4,6 @@ test_description='clone --branch option'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_HEAD() {
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index 022ed3d87c3..a7ec21eda5a 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -4,7 +4,6 @@ test_description='test cloning a repository with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 head_is_detached() {
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 298d4befab8..4873089a8c9 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -4,7 +4,6 @@ test_description='tests for git clone -c key=value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'clone -c sets config in cloned repo' '
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 72762de9774..3126cfd7e9d 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -4,7 +4,6 @@ test_description='test refspec written by clone-command'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 7708cbafa98..c752804a8e9 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -5,7 +5,6 @@
 
 test_description='test transitive info/alternate entries'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'preparing first repository' '
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index c2a2bb453ee..0c85ef834ab 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -2,7 +2,6 @@
 
 test_description='Test shallow cloning of repos with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 83513e46a35..9d6aa2187f2 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of alternates in environment variables'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_obj () {
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f7..8415884754b 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -5,7 +5,6 @@ test_description='git partial clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # create a normal "src" repo where we can later create new commits.
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 5a4d7936a72..68843382493 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -5,7 +5,6 @@ test_description='Test cloning repos with submodules using remote-tracking branc
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index f905db0a3fd..2fb6d549d39 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -2,7 +2,6 @@
 
 test_description='test handling of --alternate-refs traversal'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Avoid test_commit because we want a specific and known set of refs:
diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index 1d4efe414da..cce62bf78d3 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -2,7 +2,6 @@
 
 test_description='test local clone with ambiguous transport'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-httpd.sh"
 
diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
index 985e04d06e0..a73b4d4ff6a 100755
--- a/t/t5700-protocol-v1.sh
+++ b/t/t5700-protocol-v1.sh
@@ -11,7 +11,6 @@ export GIT_TEST_PROTOCOL_VERSION
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v1 with 'git://' transport
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index c48830de8fe..de904c16550 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -5,7 +5,6 @@ test_description='test protocol v2 server commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'test capability advertisement' '
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e4ce0592368..d3df81e7852 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index f75fae52c83..191097171bc 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -2,7 +2,6 @@
 
 test_description='upload-pack ref-in-want'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_actual_refs () {
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 11be64fc038..2b33fced23f 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -5,7 +5,6 @@ of these cases it will generally be acceptable for one side to break off
 communications if the other side says something unexpected. We are mostly
 making sure that we do not segfault or otherwise behave badly.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'extra delim packet in v2 ls-refs args' '
diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
index b8a722ec27e..ed38c76c290 100755
--- a/t/t5705-session-id-in-capabilities.sh
+++ b/t/t5705-session-id-in-capabilities.sh
@@ -2,7 +2,6 @@
 
 test_description='session ID in capabilities'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 REPO="$(pwd)/repo"
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
index 38396df95b1..37bdb725bca 100755
--- a/t/t5730-protocol-v2-bundle-uri-file.sh
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'file://' transport
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
index c199e955fec..8add1b37abc 100755
--- a/t/t5731-protocol-v2-bundle-uri-git.sh
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
index a9403e94c6d..129daa02269 100755
--- a/t/t5732-protocol-v2-bundle-uri-http.sh
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -7,7 +7,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'http://' transport
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 81bdf58b944..80a3f83ffb7 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -3,7 +3,6 @@
 test_description="Test bundle-uri bundle_uri_parse_line()"
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'bundle_uri_parse_line() just URIs' '
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d4882288a30..d21877150ed 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,7 +8,6 @@ test_description='Test remote-helper import and export commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index dd3e6235cd2..a7be375bceb 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -2,7 +2,6 @@
 
 test_description='ext::cmd remote "connect" helper'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local.sh
index 862610256fb..96a2c46e7a6 100755
--- a/t/t5810-proto-disable-local.sh
+++ b/t/t5810-proto-disable-local.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of local paths in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5811-proto-disable-git.sh b/t/t5811-proto-disable-git.sh
index ed773e74326..b0061e6a373 100755
--- a/t/t5811-proto-disable-git.sh
+++ b/t/t5811-proto-disable-git.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-tcp in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-git-daemon.sh"
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index f69959c64ca..96187efaa82 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-http in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 . "$TEST_DIRECTORY/lib-httpd.sh"
diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index 2e975dc70ec..045e2fe6ce3 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of git-over-ssh in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5814-proto-disable-ext.sh b/t/t5814-proto-disable-ext.sh
index 6fe1a98b2a1..9587a842bc2 100755
--- a/t/t5814-proto-disable-ext.sh
+++ b/t/t5814-proto-disable-ext.sh
@@ -2,7 +2,6 @@
 
 test_description='test disabling of remote-helper paths in clone/fetch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index fe899ee82d7..081a07cbae1 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -2,7 +2,6 @@
 
 test_description='test protocol filtering with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-proto-disable.sh
 
diff --git a/t/t5900-repo-selection.sh b/t/t5900-repo-selection.sh
index a84faac242d..923fc90f877 100755
--- a/t/t5900-repo-selection.sh
+++ b/t/t5900-repo-selection.sh
@@ -2,7 +2,6 @@
 
 test_description='selecting remote repo in ambiguous cases'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 reset() {
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index f6d17ee9025..6289a2e8b03 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -5,7 +5,6 @@ test_description='miscellaneous rev-list tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 3553bbbfe73..73a2465aa0e 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -5,7 +5,6 @@ test_description='Revision traversal vs grafts and path limiter'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 162cf50778d..b95a0212adf 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -4,7 +4,6 @@
 #
 test_description='Tests git rev-list --bisect functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 5cf2cee74db..0d7055d46d4 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests git rev-list --topo-order functionality'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
diff --git a/t/t6004-rev-list-path-optim.sh b/t/t6004-rev-list-path-optim.sh
index 5416241edea..cd4f420e2a1 100755
--- a/t/t6004-rev-list-path-optim.sh
+++ b/t/t6004-rev-list-path-optim.sh
@@ -16,7 +16,6 @@ test_description='git rev-list trivial path optimization test
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
index ee0306aeec0..6cde997e13c 100755
--- a/t/t6005-rev-list-count.sh
+++ b/t/t6005-rev-list-count.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --max-count and --skip test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b0ec2fe865b..eb93d68d7dc 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -8,7 +8,6 @@ test_description='git rev-list --pretty=format test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
index 2d337d7287a..6f3e5439771 100755
--- a/t/t6007-rev-list-cherry-pick-file.sh
+++ b/t/t6007-rev-list-cherry-pick-file.sh
@@ -5,7 +5,6 @@ test_description='test git rev-list --cherry-pick -- file'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # A---B---D---F
diff --git a/t/t6008-rev-list-submodule.sh b/t/t6008-rev-list-submodule.sh
index 2cdef6fdf98..a0a070b4042 100755
--- a/t/t6008-rev-list-submodule.sh
+++ b/t/t6008-rev-list-submodule.sh
@@ -8,7 +8,6 @@ test_description='git rev-list involving submodules that this repo has'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index 91db8fafe83..9c9a8459af9 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -5,7 +5,6 @@ test_description='ancestor culling and limiting by parent number'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_revlist () {
diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f96ea82e786..44c726ea397 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -6,7 +6,6 @@
 test_description='Merge base and parent list computation.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 M=1130000000
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index b2e422cf0f7..bad02cf5b83 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list should notice bad commits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note:
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 8ed1a215da6..de1e87f1621 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -5,7 +5,6 @@ test_description='merge simplification'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 4128269c1d4..39793cbbd66 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -5,7 +5,6 @@ test_description='--reverse combines with --parents'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index 16b8bd1d090..c9bedd29cba 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -2,7 +2,6 @@
 
 test_description='--all includes detached HEADs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
index 2656d6a6bc4..54b0a6f5f8a 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -10,7 +10,6 @@ test_description='--graph and simplified history'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
 
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index a0a40fe55cd..4821b90e747 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -8,7 +8,6 @@ test_description='log family learns --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check () {
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 3b181f771c2..bb55c7e3c3c 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -5,7 +5,6 @@ test_description='rev-list/rev-parse --glob'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit () {
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 1aabab69568..738da23628b 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -29,7 +29,6 @@ test_description='--ancestry-path'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_merge () {
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 34b5cd62c20..5d444bfe201 100755
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
index 51df02105d7..5fe942a2936 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list --exclude-hidden test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 127180e1c9a..7553a9cca20 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of missing objects in rev-list'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We setup the repository with two commits, this way HEAD is always
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 310affadebe..cdc02706404 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -9,7 +9,6 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index acc281c1168..0b719bbae68 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -5,7 +5,6 @@ test_description='remote tracking stats'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 advance () {
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 3946e18089a..82013fc9037 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='bisect can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index deba3ca430a..aa1b5351873 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -7,7 +7,6 @@ test_description='Tests replace refs functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 1a8b64cce18..e6b3e6ec775 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -2,7 +2,6 @@
 
 test_description='basic git merge-index / git-merge-one-file tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup diverging branches' '
diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
index 88ed7bd75a7..e934bc239c5 100755
--- a/t/t6100-rev-list-in-order.sh
+++ b/t/t6100-rev-list-in-order.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list testing in-commit-order'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a commit history with trees, blobs' '
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index d20723d6276..5f55ab98d35 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -8,7 +8,6 @@ test_description='Test git rev-parse with different parent options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 5d28507efc6..22dfd6d978e 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -2,7 +2,6 @@
 
 test_description='git rev-list should handle unexpected object types'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup well-formed objects' '
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index ddefc7f24ee..13c1da53528 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -4,7 +4,6 @@ test_description='operations that cull histories in unusual ways'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
index f63bc8d3da6..90ff1416400 100755
--- a/t/t6111-rev-list-treesame.sh
+++ b/t/t6111-rev-list-treesame.sh
@@ -16,7 +16,6 @@ test_description='TREESAME and limiting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 note () {
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 71e38491fa8..0387f35a326 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -5,7 +5,6 @@ test_description='git rev-list using object filtering'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test the blob:none filter.
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-filters.sh
index a9656a1ec8a..902854cbfaa 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list combining bitmaps and filters'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
diff --git a/t/t6114-keep-packs.sh b/t/t6114-keep-packs.sh
index 44246f8a63e..a584522ef29 100755
--- a/t/t6114-keep-packs.sh
+++ b/t/t6114-keep-packs.sh
@@ -2,7 +2,6 @@
 
 test_description='rev-list with .keep packs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index 21c4a211b15..3385fe9f130 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -2,7 +2,6 @@
 
 test_description='basic tests of rev-list --disk-usage'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # we want a mix of reachable and unreachable, as well as
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 05ed2510d96..79e0f19deba 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -14,7 +14,6 @@ test_description='test describe'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_describe () {
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index 82de25d549a..a7f2603cb4a 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -2,7 +2,6 @@
 
 test_description='test globbing (and noglob) of pathspec limiting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commits with glob characters' '
diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
index 770cce026cb..e64d9380838 100755
--- a/t/t6131-pathspec-icase.sh
+++ b/t/t6131-pathspec-icase.sh
@@ -2,7 +2,6 @@
 
 test_description='test case insensitive pathspec limiting'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index f31c09c056f..9fdafeb1e90 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='test case exclude pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
index 6dd4bbbf9fc..0f722fb340d 100755
--- a/t/t6133-pathspec-rev-dwim.sh
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -2,7 +2,6 @@
 
 test_description='test dwim of revs versus pathspecs in revision parser'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index 16ce4cfcc64..9b62a0a65f1 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='test case exclude pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a submodule' '
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
index 794bc7daf05..67d8c72147c 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -2,7 +2,6 @@
 
 test_description='test labels in pathspecs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a tree' '
diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
index 2db37a65969..1284fe01435 100755
--- a/t/t6136-pathspec-in-bare.sh
+++ b/t/t6136-pathspec-in-bare.sh
@@ -2,7 +2,6 @@
 
 test_description='diagnosing out-of-scope pathspec'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a bare and non-bare repository' '
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 0a4388f3431..011e5df1e6e 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -8,7 +8,6 @@ test_description='fmt-merge-msg test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index c39d4e7e9ce..a5c77943854 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -5,7 +5,6 @@
 
 test_description='for-each-ref test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 83b8a19d941..e06feb06e91 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='for-each-ref errors for broken refs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ZEROS=$ZERO_OID
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index a3e1258a4cb..bb02b86c163 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -2,7 +2,6 @@
 
 test_description='test for-each-refs usage of ref-filter APIs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 27d6efdc9a6..3de4ef6bd9e 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -7,7 +7,6 @@ test_description='Test merge with directory/file conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6401-merge-criss-cross.sh b/t/t6401-merge-criss-cross.sh
index 1962310408b..c8e5ff28e80 100755
--- a/t/t6401-merge-criss-cross.sh
+++ b/t/t6401-merge-criss-cross.sh
@@ -9,7 +9,6 @@
 
 test_description='Test criss-cross merge'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 729aac9842d..2738b50c2a9 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 modify () {
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index fb872c5a113..06ab4d7aede 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -2,7 +2,6 @@
 
 test_description='RCS merge replacement: merge-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 57169ca24b5..ae687f2ce54 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -4,7 +4,6 @@ test_description='Test merge without common ancestors'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This scenario is based on a real-world repository of Shawn Pearce.
diff --git a/t/t6405-merge-symlinks.sh b/t/t6405-merge-symlinks.sh
index 29e2b25ce5d..7435fce71e0 100755
--- a/t/t6405-merge-symlinks.sh
+++ b/t/t6405-merge-symlinks.sh
@@ -11,7 +11,6 @@ if core.symlinks is false.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 2dfc9a873d4..66e01464b5e 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -8,7 +8,6 @@ test_description='per path merge controlled by merge attribute'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 0753fc95f45..e8a28717cec 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6408-merge-up-to-date.sh b/t/t6408-merge-up-to-date.sh
index 8a1ba6d23a7..7763c1ba980 100755
--- a/t/t6408-merge-up-to-date.sh
+++ b/t/t6408-merge-up-to-date.sh
@@ -2,7 +2,6 @@
 
 test_description='merge fast-forward and up to date'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6409-merge-subtree.sh b/t/t6409-merge-subtree.sh
index 528615b981f..e9ba6f1690d 100755
--- a/t/t6409-merge-subtree.sh
+++ b/t/t6409-merge-subtree.sh
@@ -5,7 +5,6 @@ test_description='subtree merge strategy'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6411-merge-filemode.sh b/t/t6411-merge-filemode.sh
index b6182723aae..6ae2489286c 100755
--- a/t/t6411-merge-filemode.sh
+++ b/t/t6411-merge-filemode.sh
@@ -4,7 +4,6 @@ test_description='merge: handle file mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up mode change in one branch' '
diff --git a/t/t6412-merge-large-rename.sh b/t/t6412-merge-large-rename.sh
index d0863a8fb51..ca018d11f54 100755
--- a/t/t6412-merge-large-rename.sh
+++ b/t/t6412-merge-large-rename.sh
@@ -4,7 +4,6 @@ test_description='merging with large rename matrix'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 count() {
diff --git a/t/t6413-merge-crlf.sh b/t/t6413-merge-crlf.sh
index 647ea1e8382..cd6adf6caac 100755
--- a/t/t6413-merge-crlf.sh
+++ b/t/t6413-merge-crlf.sh
@@ -11,7 +11,6 @@ test_description='merge conflict in crlf repo
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6414-merge-rename-nocruft.sh b/t/t6414-merge-rename-nocruft.sh
index 69fc1c9e697..d7e3c1fa6e6 100755
--- a/t/t6414-merge-rename-nocruft.sh
+++ b/t/t6414-merge-rename-nocruft.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-symlink.sh
index ae00492c768..2655e295f5a 100755
--- a/t/t6415-merge-dir-to-symlink.sh
+++ b/t/t6415-merge-dir-to-symlink.sh
@@ -4,7 +4,6 @@ test_description='merging when a directory was replaced with a symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create a commit where dir a/b changed to symlink' '
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 5f414abc892..17b54d625d0 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -5,7 +5,6 @@ test_description='recursive merge corner cases involving criss-cross merges'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6417-merge-ours-theirs.sh b/t/t6417-merge-ours-theirs.sh
index 482b73a998f..62d1406119e 100755
--- a/t/t6417-merge-ours-theirs.sh
+++ b/t/t6417-merge-ours-theirs.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive ours and theirs variants'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 48a62cb8556..41288a60ceb 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -15,7 +15,6 @@ test_description='CRLF merge conflict across text=auto change
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 30349a466e7..b99f29ef9ba 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -26,7 +26,6 @@ test_description="limiting blob downloads when merging with partial clones"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 80d7b5eabaf..62b49c67e22 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -6,7 +6,6 @@ test_description="recursive merge corner cases w/ renames but not criss-crosses"
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4aaaf38be68..88d1cf2cde9 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -25,7 +25,6 @@ test_description="recursive merge with directory renames"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index a7ea8acb845..7677c5f08d0 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -2,7 +2,6 @@
 
 test_description="merges with unrelated index changes"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Testcase for some simple merges
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete.sh
index b95b064311b..c15d031b165 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -4,7 +4,6 @@ test_description='Merge-recursive rename/delete conflict message'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'rename/delete' '
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 62f01803253..b059475ed03 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -22,7 +22,6 @@ test_description="merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index a13271b3490..dd5fe6a4021 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -5,7 +5,6 @@ test_description='recursive merge diff3 style conflict markers'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup:
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 8a79bc2e921..9919c3fa7cd 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -22,7 +22,6 @@ test_description="merge cases"
 #                     underscore notation is to differentiate different
 #                     files that might be renamed into each other's paths.)
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index cb1c4ceef76..0f39ed0d08a 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -2,7 +2,6 @@
 
 test_description="remember regular & dir renames in sequence of merges"
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 555f00f78a1..ca15e6dd6da 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -5,7 +5,6 @@ test_description='merge-recursive backend test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6431-merge-criscross.sh b/t/t6431-merge-criscross.sh
index 3fe14cd73e8..3824756a02e 100755
--- a/t/t6431-merge-criscross.sh
+++ b/t/t6431-merge-criscross.sh
@@ -2,7 +2,6 @@
 
 test_description='merge-recursive backend test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #         A      <- create some files
diff --git a/t/t6432-merge-recursive-space-options.sh b/t/t6432-merge-recursive-space-options.sh
index c93538b0c38..db4b77e63d2 100755
--- a/t/t6432-merge-recursive-space-options.sh
+++ b/t/t6432-merge-recursive-space-options.sh
@@ -14,7 +14,6 @@ test_description='merge-recursive space options
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index ed7866d3e95..0f611c40031 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -5,7 +5,6 @@ test_description='"git merge" top-level frontend'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 t3033_reset () {
diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index df1d0c156c5..a11707835b4 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -29,7 +29,6 @@ mentions this in a different context).
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 get_expected_stages () {
diff --git a/t/t6435-merge-sparse.sh b/t/t6435-merge-sparse.sh
index 78628fb248a..fde4aa3cd1a 100755
--- a/t/t6435-merge-sparse.sh
+++ b/t/t6435-merge-sparse.sh
@@ -3,7 +3,6 @@
 test_description='merge with sparse files'
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # test_file $filename $content
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index ccc620477d4..4f4376421e7 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -7,7 +7,6 @@ Do not overwrite changes.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 7a3f1cb27c1..4815559157b 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
 
diff --git a/t/t6438-submodule-directory-file-conflicts.sh b/t/t6438-submodule-directory-file-conflicts.sh
index 3594190af84..8df67a0ef99 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -2,7 +2,6 @@
 
 test_description='merge can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index a9804ae42f1..55bd744a3f4 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -5,7 +5,6 @@ test_description='unpack-trees error messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ee074b99b70..53784559681 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -3,7 +3,6 @@
 test_description='basic git gc tests
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 4521508b83a..ddef1ca3915 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -28,7 +28,6 @@ test_description='check pruning of dependent objects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We care about reachability, so we do not want to use
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 307deefed2c..2591f8b8b39 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -2,7 +2,6 @@
 
 test_description='basic commit reachability tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Construct a grid-like commit graph with points (x,y)
diff --git a/t/t6700-tree-depth.sh b/t/t6700-tree-depth.sh
index 9e70a7c763a..0f6a2ad9b59 100755
--- a/t/t6700-tree-depth.sh
+++ b/t/t6700-tree-depth.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of deep trees in various commands'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We'll test against two depths here: a small one that will let us check the
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 69c9190772f..25334b50622 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -2,7 +2,6 @@
 
 test_description='git mv in subdirs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 57969ce805a..26582ae4e5f 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -2,7 +2,6 @@
 
 test_description='git mv in sparse working trees'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_sparse_checkout () {
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index bf3e3f0b678..5ab4d41ee7c 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -4,7 +4,6 @@ test_description='git filter-branch'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 42b3327e69b..b1316e62f46 100755
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
index b9822294fed..5fcf281dfbf 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -2,7 +2,6 @@
 
 test_description='GIT_EDITOR, core.editor, and stuff'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 unset EDITOR VISUAL GIT_EDITOR
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a0296d6ca40..932c26cb45b 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -2,7 +2,6 @@
 
 test_description='Test automatic use of a pager.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index f908a4d1abc..d6cc69e0f2c 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -2,7 +2,6 @@
 
 test_description='git show'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7008-filter-branch-null-sha1.sh b/t/t7008-filter-branch-null-sha1.sh
index 0ce8fd2c895..93fbc92b8db 100755
--- a/t/t7008-filter-branch-null-sha1.sh
+++ b/t/t7008-filter-branch-null-sha1.sh
@@ -2,7 +2,6 @@
 
 test_description='filter-branch removal of trees with null sha1'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: base commits' '
diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index d9add2162e9..520f96d09fb 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -2,7 +2,6 @@
 
 test_description='setup taking and sanitizing funny paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index c86abd99bf9..1ff2714cb49 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -5,7 +5,6 @@
 
 test_description='skip-worktree bit test'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect.full <<EOF
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index d984200c173..cd5c20fe51b 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -5,7 +5,6 @@
 
 test_description='test worktree writing operations when skip-worktree is used'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index effa826744b..6f526c37c27 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,7 +4,6 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 0efd17b363b..80359d48f7c 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -4,7 +4,6 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index aaeb4a53344..0f4344c55e6 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -5,7 +5,6 @@ test_description='basic work tree status reporting'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 64145a05b1f..2f9bea9793c 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -2,7 +2,6 @@
 
 test_description='git-status ignored files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expected <<\EOF
diff --git a/t/t7062-wtstatus-ignorecase.sh b/t/t7062-wtstatus-ignorecase.sh
index caf372a3d42..73709dbeee2 100755
--- a/t/t7062-wtstatus-ignorecase.sh
+++ b/t/t7062-wtstatus-ignorecase.sh
@@ -2,7 +2,6 @@
 
 test_description='git-status with core.ignorecase=true'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'status with hash collisions' '
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 13fea7931cd..8929ef481f9 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -5,7 +5,6 @@ test_description='test untracked cache'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 2458e9d0eba..8bbc5ce6d98 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -4,7 +4,6 @@ test_description='git status --porcelain=v2
 
 This test exercises porcelain V2 output for git status.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 89cf98b30c8..33d5d5b76e7 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -5,7 +5,6 @@
 
 test_description='git reset should cull empty subdirs'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e9a6cc72658..0503a64d3f2 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -10,7 +10,6 @@ Documented tests for git reset'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if test_have_prereq ICONV
diff --git a/t/t7103-reset-bare.sh b/t/t7103-reset-bare.sh
index 18bbd9975eb..871e438118a 100755
--- a/t/t7103-reset-bare.sh
+++ b/t/t7103-reset-bare.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset in a bare repository'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup non-bare' '
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index cf9697eba9a..7948ec392b3 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -2,7 +2,6 @@
 
 test_description='reset --hard unmerged'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index f4f3b7a677a..fced8adabd4 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset --patch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 88d1c8adf42..df20c0f0ccd 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -2,7 +2,6 @@
 
 test_description='git reset should work on unborn branch'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 020db201d57..9162f591fb2 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='reset --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 7ee180f81da..61669a2d210 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests for "git reset" with "--merge" and "--keep" options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index 01b7c3503ca..07b919731ae 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -5,7 +5,6 @@
 
 test_description='Tests to check that "reset" options follow a known table'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index b0d3d93b0b4..a3e2413bc33 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='reset can handle submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index 58e55a7c779..c10d94fe3d3 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -5,7 +5,6 @@ test_description='post index change hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 2d984eb4c6a..793da6e64ec 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -23,7 +23,6 @@ Test switching across them.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 54fed91e391..00d40701562 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -5,7 +5,6 @@
 
 test_description='git clean basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 git config clean.requireForce no
diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index 4afe53c66ae..f743e5b8f44 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -2,7 +2,6 @@
 
 test_description='git clean -i basic tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 098d8833b65..981488885fb 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -12,7 +12,6 @@ subcommands of git submodule.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup - enable local submodules' '
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 542b3331a78..9c3cc4cf404 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -17,7 +17,6 @@ This test script tries to verify the sanity of summary subcommand of git submodu
 # various reasons, one of them being that there are lots of commands taking place
 # outside of 'test_expect_success' block, which is no longer in good-style.
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_file () {
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index aa2fdc31d1a..25b33a1e875 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -5,7 +5,6 @@
 
 test_description='Test rebasing, stashing, etc. with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 19b6135d117..bf97d4f8511 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -11,7 +11,6 @@ These tests exercise the "git submodule sync" subcommand.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 0f0c86f9cb2..297c6c3b5cc 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -12,7 +12,6 @@ submodule and "git submodule update --rebase/--merge" does not detach the HEAD.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 9f688932613..8d7b234beb8 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -12,7 +12,6 @@ that are currently checked out.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 7e1afa9ce47..f860e7bbf49 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -5,7 +5,6 @@
 
 test_description='test clone --reference'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 base_dir=$(pwd)
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index 574a6fc526e..374ed481e9c 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -13,7 +13,6 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index af0de496e07..31271f8e0a6 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -10,7 +10,6 @@ from the database and from the worktree works.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index f7783218576..0490499573f 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -6,7 +6,6 @@ This test verifies that `git submodue absorbgitdirs` moves a submodules git
 directory into the superproject.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index b9c89b10198..9509dc18fde 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -9,7 +9,6 @@ This is a unit test of the submodule.c is_submodule_active() function,
 which is also indirectly tested elsewhere.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index 24f30e3bf9c..e2d75c7f16c 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -2,7 +2,6 @@
 
 test_description='handling of common mistakes people may make with submodules'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create embedded repository' '
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 2ab566e7178..0c605fd271a 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -2,7 +2,6 @@
 
 test_description='check handling of disallowed .gitmodule urls'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.sh
index dbbb3853dc0..5e3051da8bb 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -4,7 +4,6 @@ test_description='check handling of .gitmodule path with dash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index e1d9bf2ee30..dde11ecce80 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -15,7 +15,6 @@ also by committing .gitmodules and then just removing it from the filesystem.
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index a5d1bc5c54a..08ed51d34ff 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -9,7 +9,6 @@ This test verifies that the set-branch subcommand of git-submodule is working
 as expected.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 TEST_NO_CREATE_REPO=1
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index d7fe910bbe1..bf7f15ee797 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -10,7 +10,6 @@ as expected.
 '
 
 TEST_NO_CREATE_REPO=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 479c8fdde11..ce64d8b1372 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -10,7 +10,6 @@ while making sure to add submodules using `git submodule add` instead of
 `git add` as done in t7401.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index c1686d6bb5f..f21e9203678 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -2,7 +2,6 @@
 
 test_description='submodule --cached, --quiet etc. output'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t3100.sh
 
diff --git a/t/t7423-submodule-symlinks.sh b/t/t7423-submodule-symlinks.sh
index f45d8062018..3d3c7af3ce5 100755
--- a/t/t7423-submodule-symlinks.sh
+++ b/t/t7423-submodule-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='check that submodule operations do not follow symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare' '
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mixed-ref-formats.sh
index b43ef2ba675..559713b6077 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -2,7 +2,6 @@
 
 test_description='submodules handle mixed ref storage formats'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_ref_format () {
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 4a9c22c9e2b..93677946411 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -13,7 +13,6 @@ Such as:
   - symlinked .gitmodules, etc
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 379d3ed3413..4dca8d97a77 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -7,7 +7,6 @@ test_description='git commit
 
 Tests for template, signoff, squash and -F functions.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 52f5e28154e..cc12f99f115 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -9,7 +9,6 @@ test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-diff.sh"
 
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 84f1ff52b67..b37e2018a74 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -5,7 +5,6 @@ test_description='git commit porcelain-ish'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit_msg_is () {
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index aa004b70a8d..ad1eb64ba0d 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,7 +5,6 @@ test_description='pre-commit and pre-merge-commit hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'root commit' '
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index d1255228d5f..c0f024eb1ef 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -5,7 +5,6 @@ test_description='commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'with no hook' '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index b88383df9e4..2128142a61c 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -5,7 +5,6 @@ test_description='prepare-commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up commits for rebasing' '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 46566d529e8..185fe7e78ef 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -2,7 +2,6 @@
 
 test_description='git status for submodule'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_create_repo_with_commit () {
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 4c7db19ce7e..b53d71c0862 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -2,7 +2,6 @@
 
 test_description='verbose commit template'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 write_script "check-for-diff" <<\EOF &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 773383fefb5..f9a5c98f3f3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -5,7 +5,6 @@
 
 test_description='git status'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index fd8c8f8f0bc..8e373b566b0 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -5,7 +5,6 @@
 
 test_description='commit tests of various authorhip options. '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 author_header () {
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index eb229082e40..0d2dd29fe6a 100755
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
index 4ffa45a7bf3..b5fdc048a54 100755
--- a/t/t7511-status-index.sh
+++ b/t/t7511-status-index.sh
@@ -2,7 +2,6 @@
 
 test_description='git status with certain file name lengths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 files="0 1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z"
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index cdd5f2c6979..802f8f704c6 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -10,7 +10,6 @@ test_description='git status advice'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 502752c0f3c..818a8dafbd2 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -5,7 +5,6 @@
 
 test_description='git interpret-trailers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # When we want one trailing space at the end of each line, let's use sed
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 03ba0c0e734..075db69b429 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -2,7 +2,6 @@
 
 test_description='hunk edit with "commit -p -m"'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (initial)' '
diff --git a/t/t7515-status-symlinks.sh b/t/t7515-status-symlinks.sh
index e3d6bb67bf9..9f989be01b9 100755
--- a/t/t7515-status-symlinks.sh
+++ b/t/t7515-status-symlinks.sh
@@ -2,7 +2,6 @@
 
 test_description='git status and symlinks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index bb95f09810b..de7c4ca7901 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -2,7 +2,6 @@
 
 test_description='git commit races'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'race to create orphan commit' '
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index efc6496e2b2..163ae804685 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -9,7 +9,6 @@ test_description='per-repo forced setting of email address'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a likely user.useConfigOnly use case' '
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index b37de0af49f..d3ea4d603ff 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -2,7 +2,6 @@
 
 test_description='corner cases in ident strings'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # confirm that we do not segfault _and_ that we do not say "(null)", as
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 0f88a58a819..7ee69ecdd4a 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -2,7 +2,6 @@
 
 test_description='git status with file system watcher'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 3b63c34a309..bcfe15d51d0 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -2,7 +2,6 @@
 
 test_description='ignored hook warning'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
index edce10f998e..a88b02b06ed 100755
--- a/t/t7521-ignored-mode.sh
+++ b/t/t7521-ignored-mode.sh
@@ -2,7 +2,6 @@
 
 test_description='git status ignored modes'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup initial commit and ignore file' '
diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
index a8fceb6a47c..82b5e4aa412 100755
--- a/t/t7524-commit-summary.sh
+++ b/t/t7524-commit-summary.sh
@@ -2,7 +2,6 @@
 
 test_description='git commit summary'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index a9210d3a3a9..d409de1a33f 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git status rename detection options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index c97c550021e..3aabbf35a1c 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -2,7 +2,6 @@
 
 test_description='commit --pathspec-from-file'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 68e18856b66..065f7806362 100755
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
index 65fd3d8552b..ef54cff4faa 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -29,7 +29,6 @@ Testing basic merge operations/option parsing.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index c83298ba683..199a1d5db31 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing pull.* configuration parsing and other things.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 3669d33bd5a..ff085b086cc 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing octopus merge with more than 25 refs.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
index 0e85b21ec82..4887ca705b3 100755
--- a/t/t7603-merge-reduce-heads.sh
+++ b/t/t7603-merge-reduce-heads.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing octopus merge when reducing parents to independent branches.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # 0 - 1
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index eca75551016..cd4f9607dc1 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing merge when using a custom message for the merge commit.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 create_merge_msgs() {
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 62d935d31c2..5d56c385464 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -4,7 +4,6 @@ test_description='git merge
 
 Testing the resolve strategy.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 135cb230856..81fb7c474c1 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -14,7 +14,6 @@ Testing a custom strategy.
 * (tag: c0) c0
 "
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'set up custom strategy' '
diff --git a/t/t7607-merge-state.sh b/t/t7607-merge-state.sh
index 9001674f2ea..89a62ac53b3 100755
--- a/t/t7607-merge-state.sh
+++ b/t/t7607-merge-state.sh
@@ -4,7 +4,6 @@ test_description="Test that merge state is as expected after failed merge"
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'Ensure we restore original state if no merge strategy handles it' '
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 2179938c437..0b908ab2e71 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -4,7 +4,6 @@ test_description='test auto-generated merge messages'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 check_oneline() {
diff --git a/t/t7609-mergetool--lib.sh b/t/t7609-mergetool--lib.sh
index 8b1c3bd39f2..330d6d603d7 100755
--- a/t/t7609-mergetool--lib.sh
+++ b/t/t7609-mergetool--lib.sh
@@ -4,7 +4,6 @@ test_description='git mergetool
 
 Testing basic merge tools options'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'mergetool --tool=vimdiff creates the expected layout' '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 5c5e79e9905..22b3a85b3e9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,7 +10,6 @@ Testing basic merge tool invocation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 992a8f98749..d6975ca48df 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -25,7 +25,6 @@ Next, test git merge --abort with the following variables:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index 84ddb568517..337fac0d844 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -4,7 +4,6 @@ test_description='merge signature verification tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index cf96a35e8e7..fee258d4f0c 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -8,7 +8,6 @@ This test runs git merge --signoff and makes sure that it works.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Setup test files
diff --git a/t/t7615-diff-algo-with-mergy-operations.sh b/t/t7615-diff-algo-with-mergy-operations.sh
index 9a83be518cb..3b1aad0167a 100755
--- a/t/t7615-diff-algo-with-mergy-operations.sh
+++ b/t/t7615-diff-algo-with-mergy-operations.sh
@@ -4,7 +4,6 @@ test_description='git merge and other operations that rely on merge
 
 Testing the influence of the diff algorithm on the merge output.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index c4c3d1a15d9..be1188e7365 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 . "${TEST_DIRECTORY}/lib-midx.sh"
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index fe6c3e77a3c..5715f4d69a4 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -5,7 +5,6 @@ test_description='git repack works correctly'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 fsha1=
diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
index d151d4f6036..cd91766e78a 100755
--- a/t/t7702-repack-cyclic-alternate.sh
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -5,7 +5,6 @@
 
 test_description='repack involving cyclic alternate'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 8877aea98ba..9fc1626fbfd 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack --geometric works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 5db9f4e10f7..959e6e26488 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -2,7 +2,6 @@
 
 test_description='git repack works correctly'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index f67b9345b8a..cc917b257e3 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -11,7 +11,6 @@ Testing basic diff tool invocation
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 difftool_test_setup ()
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1bdb8e5a999..64ac4f04ee9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -9,7 +9,6 @@ test_description='git grep various.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_invalid_grep_expression() {
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index fe38d88a1a6..3160be59fd2 100755
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
index 31c66b63c2c..ac7be547145 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -2,7 +2,6 @@
 
 test_description='grep icase on non-English locales'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 doalarm () {
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
index 1227885737b..701e08a8e59 100755
--- a/t/t7813-grep-icase-iso.sh
+++ b/t/t7813-grep-icase-iso.sh
@@ -2,7 +2,6 @@
 
 test_description='grep icase on non-English locales'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success GETTEXT_ISO_LOCALE 'setup' '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 55ed630e77e..167fe661504 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -7,7 +7,6 @@ submodules.
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index ac871287c03..90ebb64f46e 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -2,7 +2,6 @@
 
 test_description='git grep in binary files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' "
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 4353be5adb7..0088eaa0c91 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -2,7 +2,6 @@
 
 test_description='git grep with a binary pattern files'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 nul_match_internal () {
diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
index 0ba7817fb76..eb595645657 100755
--- a/t/t7817-grep-sparse-checkout.sh
+++ b/t/t7817-grep-sparse-checkout.sh
@@ -33,7 +33,6 @@ should leave the following structure in the working tree:
 But note that sub2 should have the SKIP_WORKTREE bit set.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c224c8450c8..57d64b5b40b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -2,7 +2,6 @@
 
 test_description='git maintenance builtin'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_COMMIT_GRAPH=0
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index d4346989195..d7167f55397 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git annotate'
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 35966340397..0147de304b4 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 6288352f577..731265541ac 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -4,7 +4,6 @@ test_description='git blame corner cases'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 2c2a0b33f9b..35414a53363 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -6,7 +6,6 @@ test_description='git blame on conflicted files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup first case' '
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index fa765aff99a..81847ffb9a8 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame encoding conversion'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq ICONV
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 42f8be25a3f..07a287ffd3e 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame textconv support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_blame() {
diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
index c8266f17f14..c3735fb50de 100755
--- a/t/t8007-cat-file-textconv.sh
+++ b/t/t8007-cat-file-textconv.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file textconv support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >helper <<'EOF'
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index fb5d225a671..c12a4196d66 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -2,7 +2,6 @@
 
 test_description='blame output in various formats on a simple case'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
index cc511084648..c808b819621 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -2,7 +2,6 @@
 
 test_description='blaming through history with topic branches'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Creates the history shown below. '*'s mark the first parent in the merges.
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index eb64b766bdf..b3be2aa387f 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -2,7 +2,6 @@
 
 test_description='git cat-file filters support'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index da1801f4d23..c66494f5ba7 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -11,7 +11,6 @@ not bother testing that the non-C case fails to find it. That is how blame
 behaves now, but it is not a property we want to make sure is retained.
 '
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # help avoid typing and reading long strings of similar lines
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 9a79c109f2e..c3a5f6d01ff 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -5,7 +5,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 PROG='git blame -c'
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index d33788d8677..370b7681492 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -2,7 +2,6 @@
 
 test_description='ignore revisions when blaming'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Creates:
diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
index 933222cea15..f5dcbd9e824 100755
--- a/t/t8014-blame-ignore-fuzzy.sh
+++ b/t/t8014-blame-ignore-fuzzy.sh
@@ -2,7 +2,6 @@
 
 test_description='git blame ignore fuzzy heuristic'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pick_author='s/^[0-9a-f^]* *(\([^ ]*\) .*/\1/'
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e2430f7bfab..0c1af43f6fb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,7 +4,6 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
diff --git a/t/t9002-column.sh b/t/t9002-column.sh
index d5b98e615bc..7353815c11b 100755
--- a/t/t9002-column.sh
+++ b/t/t9002-column.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 
 test_description='git column'
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 3be063afab5..85a5074b5e2 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -2,7 +2,6 @@
 
 test_description='help.autocorrect finding a match'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 3d4842164c8..a44eabf0d80 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -4,7 +4,6 @@
 #
 test_description='Test export of commits to CVS'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index a30b2c9f705..027235d61aa 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -2,7 +2,6 @@
 
 test_description='test the `scalar` command'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index c16ea67c1dc..7869f45ee64 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -2,7 +2,6 @@
 
 test_description='test the `scalar clone` subcommand'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-terminal.sh"
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6224f54d4d2..9bd66ecf2e0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,7 +7,6 @@ test_description='test git fast-import utility'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 58413221e6a..1ae4d7c0d37 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -7,7 +7,6 @@ test_description='test git fast-import of notes objects'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index d8b1f9442e8..ec8c8652c6c 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -1,7 +1,6 @@
 #!/bin/sh
 test_description='test git fast-import unpack limit'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create loose objects on import' '
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
index 4f5bf40587c..f15c8c0213e 100755
--- a/t/t9303-fast-import-compression.sh
+++ b/t/t9303-fast-import-compression.sh
@@ -2,7 +2,6 @@
 
 test_description='compression setting of fast-import utility'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 import_large () {
diff --git a/t/t9304-fast-import-marks.sh b/t/t9304-fast-import-marks.sh
index 1f776a80f3b..6c50adca009 100755
--- a/t/t9304-fast-import-marks.sh
+++ b/t/t9304-fast-import-marks.sh
@@ -2,7 +2,6 @@
 
 test_description='test exotic situations with marks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup dump of basic history' '
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 9595dfef2ee..aa33791b77b 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -7,7 +7,6 @@ test_description='git fast-export'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
index c0d9d7be754..156a6474847 100755
--- a/t/t9351-fast-export-anonymize.sh
+++ b/t/t9351-fast-export-anonymize.sh
@@ -4,7 +4,6 @@ test_description='basic tests for fast-export --anonymize'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup simple repo' '
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6da7440e73c..e499c7f9551 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -11,7 +11,6 @@ cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 if ! test_have_prereq PERL; then
diff --git a/t/t9401-git-cvsserver-crlf.sh b/t/t9401-git-cvsserver-crlf.sh
index a67e6abd49d..a34805acdc2 100755
--- a/t/t9401-git-cvsserver-crlf.sh
+++ b/t/t9401-git-cvsserver-crlf.sh
@@ -12,7 +12,6 @@ repository using cvs CLI client via git-cvsserver server'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 marked_as () {
diff --git a/t/t9402-git-cvsserver-refs.sh b/t/t9402-git-cvsserver-refs.sh
index c847120d52d..2ee41f9443e 100755
--- a/t/t9402-git-cvsserver-refs.sh
+++ b/t/t9402-git-cvsserver-refs.sh
@@ -8,7 +8,6 @@ tags, branches and other git refspecs'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 #########
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ccfa4153840..7679780fb87 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -13,7 +13,6 @@ or warnings to log.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index c900231079c..32814e75df5 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -13,7 +13,6 @@ code and message.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 #
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
index b41ea193314..81d56255579 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -13,7 +13,6 @@ in the HTTP header or the actual script output.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gitweb.sh
 
 # ----------------------------------------------------------------------
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 41fcf3606b3..56808492189 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -4,7 +4,6 @@ test_description='git cvsimport basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 if ! test_have_prereq NOT_ROOT; then
diff --git a/t/t9601-cvsimport-vendor-branch.sh b/t/t9601-cvsimport-vendor-branch.sh
index e0076694957..116cddba3a5 100755
--- a/t/t9601-cvsimport-vendor-branch.sh
+++ b/t/t9601-cvsimport-vendor-branch.sh
@@ -35,7 +35,6 @@ test_description='git cvsimport handling of vendor branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9601
diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-branches-tags.sh
index 3768e3bd8cc..e5266c9a872 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -7,7 +7,6 @@ test_description='git cvsimport handling of branches and tags'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9602
diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 2a387fdbaae..1ee966c256a 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -13,7 +13,6 @@
 
 test_description='git cvsimport testing for correct patchset estimation'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 setup_cvs_test_repository t9603
diff --git a/t/t9604-cvsimport-timestamps.sh b/t/t9604-cvsimport-timestamps.sh
index 9cf0685d56f..57a3bef2ece 100755
--- a/t/t9604-cvsimport-timestamps.sh
+++ b/t/t9604-cvsimport-timestamps.sh
@@ -2,7 +2,6 @@
 
 test_description='git cvsimport timestamps'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-cvs.sh
 
 test_lazy_prereq POSIX_TIMEZONE '
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 44316971224..9c9e3b5eb11 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -5,7 +5,6 @@
 
 test_description='perl interface (Git.pm)'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-perl.sh
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 3e6dfce2483..0816763e466 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -5,7 +5,6 @@ test_description='git p4 tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index cdbfacc727a..c598011635a 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -5,7 +5,6 @@ test_description='git p4 tests for p4 branches'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 1bc48305b01..df01a5d3389 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 filetype tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
index ab7fe162668..2913277013d 100755
--- a/t/t9803-git-p4-shell-metachars.sh
+++ b/t/t9803-git-p4-shell-metachars.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 transparency to shell metachars in filenames'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9804-git-p4-label.sh b/t/t9804-git-p4-label.sh
index c8963fd3980..32364571063 100755
--- a/t/t9804-git-p4-label.sh
+++ b/t/t9804-git-p4-label.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 label tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
index 72dce3d2b46..90ef647db7e 100755
--- a/t/t9805-git-p4-skip-submit-edit.sh
+++ b/t/t9805-git-p4-skip-submit-edit.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 skipSubmitEdit config variables'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index e4ce44ebf37..c26d2974330 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -5,7 +5,6 @@ test_description='git p4 options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9808-git-p4-chdir.sh b/t/t9808-git-p4-chdir.sh
index 342f7f3d4a0..58a9b3b71e6 100755
--- a/t/t9808-git-p4-chdir.sh
+++ b/t/t9808-git-p4-chdir.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 relative chdir'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index f33fdea889e..9c9710d8c7b 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 client view'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 15e32c9f353..5fe83315ecd 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 rcs keywords'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 CP1252="\223\224"
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 52a4b0af811..5ac5383fb71 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -5,7 +5,6 @@ test_description='git p4 label tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index 46aa5fd56c7..254a7c24469 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 wildcards'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9813-git-p4-preserve-users.sh b/t/t9813-git-p4-preserve-users.sh
index 0efea28da2c..fd018c87a80 100755
--- a/t/t9813-git-p4-preserve-users.sh
+++ b/t/t9813-git-p4-preserve-users.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 preserve users'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 00df6ebd3bd..2a9838f37fe 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 rename'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 92ef9d8c242..c766fd159f1 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 submit failure handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index e687fbc25f6..5e904ac80d8 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 locked file behavior'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9817-git-p4-exclude.sh b/t/t9817-git-p4-exclude.sh
index 3deb334fed1..ec3d937c6a7 100755
--- a/t/t9817-git-p4-exclude.sh
+++ b/t/t9817-git-p4-exclude.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 tests for excluded paths during clone and sync'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 091bb72bdb6..de591d875c2 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 fetching changes in multiple blocks'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
index 985be203571..b4d93f0c17c 100755
--- a/t/t9819-git-p4-case-folding.sh
+++ b/t/t9819-git-p4-case-folding.sh
@@ -2,7 +2,6 @@
 
 test_description='interaction with P4 case-folding'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 if test_have_prereq CASE_INSENSITIVE_FS
diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
index 48e4dfb95c0..fa1bba1dd93 100755
--- a/t/t9820-git-p4-editor-handling.sh
+++ b/t/t9820-git-p4-editor-handling.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 handling of EDITOR'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
index 49691c53dad..ef80f1690bc 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories with path case variations'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d with case folding enabled' '
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index e62ed49f51e..572d395498e 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories with non ASCII paths'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
diff --git a/t/t9823-git-p4-mock-lfs.sh b/t/t9823-git-p4-mock-lfs.sh
index 98a40d8af37..88b76dc4d6c 100755
--- a/t/t9823-git-p4-mock-lfs.sh
+++ b/t/t9823-git-p4-mock-lfs.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and store files in Mock LFS'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_file_is_not_in_mock_lfs () {
diff --git a/t/t9825-git-p4-handle-utf16-without-bom.sh b/t/t9825-git-p4-handle-utf16-without-bom.sh
index d0b86537dd9..6a60b323493 100755
--- a/t/t9825-git-p4-handle-utf16-without-bom.sh
+++ b/t/t9825-git-p4-handle-utf16-without-bom.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 handling of UTF-16 files without BOM'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 UTF16="\227\000\227\000"
diff --git a/t/t9826-git-p4-keep-empty-commits.sh b/t/t9826-git-p4-keep-empty-commits.sh
index 54083f842e9..fd64afe064e 100755
--- a/t/t9826-git-p4-keep-empty-commits.sh
+++ b/t/t9826-git-p4-keep-empty-commits.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and keep empty commits'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9827-git-p4-change-filetype.sh b/t/t9827-git-p4-change-filetype.sh
index 3476ea2fd3b..d3670bd7a24 100755
--- a/t/t9827-git-p4-change-filetype.sh
+++ b/t/t9827-git-p4-change-filetype.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 support for file type change'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
index 7c8f9e39304..ca6c2942bdf 100755
--- a/t/t9828-git-p4-map-user.sh
+++ b/t/t9828-git-p4-map-user.sh
@@ -2,7 +2,6 @@
 
 test_description='Clone repositories and map users'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9829-git-p4-jobs.sh b/t/t9829-git-p4-jobs.sh
index 3fc0948d9cf..88cfb1fcd3f 100755
--- a/t/t9829-git-p4-jobs.sh
+++ b/t/t9829-git-p4-jobs.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 retrieve job info'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 02561a7f0e6..3fb6960c18f 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 symlinked directories'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index f287f41e374..ff6c0352e68 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 with server triggers'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index a2667754086..6b3cb0414aa 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -6,7 +6,6 @@ last_shelved_change () {
 
 test_description='git p4 unshelve'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9833-errors.sh b/t/t9833-errors.sh
index da1d30c142c..e22369ccdf5 100755
--- a/t/t9833-errors.sh
+++ b/t/t9833-errors.sh
@@ -2,7 +2,6 @@
 
 test_description='git p4 errors'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index 565870fc740..dac67e89d7d 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -6,7 +6,6 @@ This test creates files and directories with the same name in perforce and
 checks that git-p4 recovers from the error at the same time as the perforce
 repository.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 test_expect_success 'start p4d' '
diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
index ad20ffdeded..036bf79c667 100755
--- a/t/t9835-git-p4-metadata-encoding-python2.sh
+++ b/t/t9835-git-p4-metadata-encoding-python2.sh
@@ -6,7 +6,6 @@ This test checks that the import process handles inconsistent text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 python_target_version='2'
diff --git a/t/t9836-git-p4-metadata-encoding-python3.sh b/t/t9836-git-p4-metadata-encoding-python3.sh
index 71ae763399c..63350dc4b5c 100755
--- a/t/t9836-git-p4-metadata-encoding-python3.sh
+++ b/t/t9836-git-p4-metadata-encoding-python3.sh
@@ -6,7 +6,6 @@ This test checks that the import process handles inconsistent text
 encoding in p4 metadata (author names, commit messages, etc) without
 failing, and produces maximally sane output in git.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-git-p4.sh
 
 python_target_version='3'
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index f503f16d1b6..36566ace21b 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -2,7 +2,6 @@
 
 test_description='git shell tests'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'shell allows upload-pack' '
diff --git a/t/t9901-git-web--browse.sh b/t/t9901-git-web--browse.sh
index 19f56e5680f..de7152f8271 100755
--- a/t/t9901-git-web--browse.sh
+++ b/t/t9901-git-web--browse.sh
@@ -5,7 +5,6 @@ test_description='git web--browse basic tests
 
 This test checks that git web--browse can handle various valid URLs.'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_web_browse () {
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cc6aa9f0cd3..932d5ad7591 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -16,7 +16,6 @@ test_untraceable=UnfortunatelyYes
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-bash.sh
 
 complete ()
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 95e9955bca1..d667dda654e 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -8,7 +8,6 @@ test_description='test git-specific bash prompt functions'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-bash.sh
 
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
-- 
2.47.0.229.g8f8d6eee53.dirty

