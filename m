Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE52C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A4561A4A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCZWwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:52:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53826 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCZWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 18:52:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B862119652;
        Fri, 26 Mar 2021 18:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ijbmGX0OT+CFO4jNqk7SDDvtL
        Kw=; b=rNqxQYmsVEK7BGgtxxkHBgelhMyg7M1y0e6BzIiWW1kIFe5usmjas/lx/
        zoEC+aVqDB6OQVC2rU+8LPp8Ty1VdZDY0ZWzb3IBkgz1VZTEkgGtw83+/khbMKbr
        B9JFYwInbhzhQaiIbPI78TdGnEcn/MNOm2MWfRkpopxRuS11Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=lgtsGCdqIcz0n/uD3Og
        O4X8cXJGquxmIs8rz8AeDzEHTVrUcJYPzn0uEeah4R3Rv6eC8ARwMqgW1IsFgicQ
        NYC4jCQiktpY77tG5chkqFkoKlC7nrcsAp6TkklhPSuB/pI19x2o3v14FDnMnCpn
        kZHXHeNka6AaB57kv0IUSwss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85E82119651;
        Fri, 26 Mar 2021 18:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A669C11964F;
        Fri, 26 Mar 2021 18:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.31.1
Date:   Fri, 26 Mar 2021 15:52:20 -0700
Message-ID: <xmqq1rc1sf2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED3D9174-8E85-11EB-B92F-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.31.1 is now available at
the usual places.

Nothing extraordinary.  Just to fix known issues in v2.31 and
backport some clean-ups already made for the next feature release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.31.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.31.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.31
-----------------

 * The fsmonitor interface read from its input without making sure
   there is something to read from.  This bug is new in 2.31
   timeframe.

 * The data structure used by fsmonitor interface was not properly
   duplicated during an in-core merge, leading to use-after-free etc.

 * "git bisect" reimplemented more in C during 2.30 timeframe did not
   take an annotated tag as a good/bad endpoint well.  This regression
   has been corrected.

 * Fix macros that can silently inject unintended null-statements.

 * CALLOC_ARRAY() macro replaces many uses of xcalloc().

 * Update insn in Makefile comments to run fuzz-all target.

 * Fix a corner case bug in "git mv" on case insensitive systems,
   which was introduced in 2.29 timeframe.

Also contains various documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.31.0 are as follows:

Andrzej Hunt (2):
      Makefile: update 'make fuzz-all' docs to reflect modern clang
      fsmonitor: avoid global-buffer-overflow READ when checking trivial =
response

Jeff King (1):
      bisect: peel annotated tags to commits

Johannes Schindelin (2):
      fsmonitor: fix memory corruption in some corner cases
      fsmonitor: do not forget to release the token in `discard_index()`

Jonathan Tan (1):
      t5606: run clone branch name test with protocol v2

Junio C Hamano (3):
      xcalloc: use CALLOC_ARRAY() when applicable
      cocci: allow xcalloc(1, size)
      Git 2.31.1

Kyle Meyer (1):
      config.txt: add missing period

Ren=C3=A9 Scharfe (6):
      fix xcalloc() argument order
      git-compat-util.h: drop trailing semicolon from macro definition
      use CALLOC_ARRAY
      vcs-svn: remove header files as well
      block-sha1: drop trailing semicolon from macro definition
      mem-pool: drop trailing semicolon from macro definition

Torsten B=C3=B6gershausen (1):
      git mv foo FOO ; git mv foo bar gave an assert

