Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2E82018E
	for <e@80x24.org>; Thu, 11 Aug 2016 00:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbcHKALO (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 20:11:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751428AbcHKALM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 20:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0969134E24;
	Wed, 10 Aug 2016 20:11:11 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	Pv3itpJRv/mf+Pog7esZ1NaPFc=; b=HhEfj2NtJnmA+iiwnDQHnFdnpe4/ezxBx
	jRvs89gja9iqAVeLPMr7z+wJotWCaSdM2hyNJQp5vzSYBVDHy+oUqFwI63tQ4md2
	NXbuJ1nertr7PSvYjdLxxIzMJtM5RZ57om/ZgqO7/ZYcaRlH5omedMHL8yoeuO3o
	yM3X/az6kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WJU
	ixdcgiD/wnCyjGAdHg9MhMsFg6AeqYvR96pQCTzwBHH0ysvmcREgvFDDbUICMd/0
	ILrT86AlNomDHXWbZlLjrdYDiSTauEoh9U/ZKrm93WRVaAvbwruih8YOAE8+TWkJ
	8o9/D4cSbAPVMfFsYo5XOym+SMAK0sHD9WDSuERw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0255234E23;
	Wed, 10 Aug 2016 20:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 920CC34E22;
	Wed, 10 Aug 2016 20:11:10 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: What's cooking (preview)
Date:	Wed, 10 Aug 2016 17:11:08 -0700
Message-ID: <xmqqr39w2mhv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B97C6F0-5F58-11E6-815B-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just the highlights for today, as we had one on just a few days ago.
I also plan to tag 2.9.3 out of the tonight's tip of 'maint'.

Thanks.

[Graduated to "master"]

* cc/mailmap-tuxfamily (2016-08-08) 1 commit
  (merged to 'next' on 2016-08-10 at 5905fbf)
 + .mailmap: use Christian Couder's Tuxfamily address


* jk/completion-diff-submodule (2016-08-09) 1 commit
  (merged to 'next' on 2016-08-10 at 146ca11)
 + completion: add completion for --submodule=* diff option


* jk/push-force-with-lease-creation (2016-08-04) 4 commits
  (merged to 'next' on 2016-08-04 at e42ce85)
 + t5533: make it pass on case-sensitive filesystems
  (merged to 'next' on 2016-08-03 at 475c080)
 + push: allow pushing new branches with --force-with-lease
 + push: add shorthand for --force-with-lease branch creation
 + Documentation/git-push: fix placeholder formatting

 "git push --force-with-lease" already had enough logic to allow
 ensuring that such a push results in creation of a ref (i.e. the
 receiving end did not have another push from sideways that would be
 discarded by our force-pushing), but didn't expose this possibility
 to the users.  It does so now.


* jk/reset-ident-time-per-commit (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-03 at 76d569c)
 + am: reset cached ident date for each patch

 Not-so-recent rewrite of "git am" that started making internal
 calls into the commit machinery had an unintended regression, in
 that no matter how many seconds it took to apply many patches, the
 resulting committer timestamp for the resulting commits were all
 the same.


* js/am-3-merge-recursive-direct (2016-08-01) 16 commits
  (merged to 'next' on 2016-08-05 at dc1c9bb)
 + merge-recursive: flush output buffer even when erroring out
 + merge_trees(): ensure that the callers release output buffer
 + merge-recursive: offer an option to retain the output in 'obuf'
 + merge-recursive: write the commit title in one go
 + merge-recursive: flush output buffer before printing error messages
 + am -3: use merge_recursive() directly again
 + merge-recursive: switch to returning errors instead of dying
 + merge-recursive: handle return values indicating errors
 + merge-recursive: allow write_tree_from_memory() to error out
 + merge-recursive: avoid returning a wholesale struct
 + merge_recursive: abort properly upon errors
 + prepare the builtins for a libified merge_recursive()
 + merge-recursive: clarify code in was_tracked()
 + die(_("BUG")): avoid translating bug messages
 + die("bug"): report bugs consistently
 + t5520: verify that `pull --rebase` shows the helpful advice when failing

 "git am -3" calls "git merge-recursive" when it needs to fall back
 to a three-way merge; this call has been turned into an internal
 subroutine call instead of spawning a separate subprocess.


* js/commit-slab-decl-fix (2016-08-09) 2 commits
  (merged to 'next' on 2016-08-10 at 6675402)
 + commit-slab.h: avoid duplicated global static variables
 + config.c: avoid duplicated global static variables


* jt/format-patch-from-config (2016-08-01) 1 commit
  (merged to 'next' on 2016-08-05 at 897e986)
 + format-patch: format.from gives the default for --from

 "git format-patch" learned format.from configuration variable to
 specify the default settings for its "--from" option.


* sb/submodule-update-dot-branch (2016-08-10) 8 commits
  (merged to 'next' on 2016-08-10 at 40ba945)
 + t7406: fix breakage on OSX
  (merged to 'next' on 2016-08-04 at 47bff41)
 + submodule update: allow '.' for branch value
 + submodule--helper: add remote-branch helper
 + submodule-config: keep configured branch around
 + submodule--helper: fix usage string for relative-path
 + submodule update: narrow scope of local variable
 + submodule update: respect depth in subsequent fetches
 + t7406: future proof tests with hard coded depth

 A few updates to "git submodule update".
