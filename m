Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26621202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 06:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdJWGKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 02:10:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751043AbdJWGKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 02:10:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6954AAE375;
        Mon, 23 Oct 2017 02:10:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=x
        U0mg30K3zn3SNlErMAJo9cxwr0=; b=r/SOeMh/RSq0rhBYN9jyWYMsdKQD9Aei+
        KaFSv1MyyS85PbQlGPHkl8eJy84RQblnXiLrIkFFoi9eTKXZOyan6vVSoTM220rm
        iEc2A+ckgn15C5EqsL8VnqddsuBtEbDif/6QmW+PA1hjK7EAgYJNRCWOGdRXFfDm
        kf0GjaajgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=Tc2d/668ge1rY5WveHKyoXuJns01ThLCfoOykmhXcao06q01MB/5j6bx
        S9fU3K6Z297XlH3G5ONveF4M1H4Cah20XRv0fsaxzC8NxSuTRyVHnh7vqkUJDjHS
        xqbTOZNkAOYr/MvpBpDHfom1JtfW+hT0U9hCFQR6PhhSE/IClQA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60D96AE374;
        Mon, 23 Oct 2017 02:10:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AD7BAE373;
        Mon, 23 Oct 2017 02:10:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.14.3
Date:   Mon, 23 Oct 2017 15:10:26 +0900
Message-ID: <xmqqlgk2bdil.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD85A700-B7B8-11E7-B105-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.14.3 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.14.3'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.14.3 Release Notes
=========================

Fixes since v2.14.2
-------------------

 * A helper function to read a single whole line into strbuf
   mistakenly triggered OOM error at EOF under certain conditions,
   which has been fixed.

 * In addition to "cc: <a@dd.re.ss> # cruft", "cc: a@dd.re.ss # cruft"
   was taught to "git send-email" as a valid way to tell it that it
   needs to also send a carbon copy to <a@dd.re.ss> in the trailer
   section.

 * Fix regression to "gitk --bisect" by a recent update.

 * Unlike "git commit-tree < file", "git commit-tree -F file" did not
   pass the contents of the file verbatim and instead completed an
   incomplete line at the end, if exists.  The latter has been updated
   to match the behaviour of the former.

 * "git archive", especially when used with pathspec, stored an empty
   directory in its output, even though Git itself never does so.
   This has been fixed.

 * API error-proofing which happens to also squelch warnings from GCC.

 * "git gc" tries to avoid running two instances at the same time by
   reading and writing pid/host from and to a lock file; it used to
   use an incorrect fscanf() format when reading, which has been
   corrected.

 * The test linter has been taught that we do not like "echo -e".

 * Code cmp.std.c nitpick.

 * "git describe --match" learned to take multiple patterns in v2.13
   series, but the feature ignored the patterns after the first one
   and did not work at all.  This has been fixed.

 * "git cat-file --textconv" started segfaulting recently, which
   has been corrected.

 * The built-in pattern to detect the "function header" for HTML did
   not match <H1>..<H6> elements without any attributes, which has
   been fixed.

 * "git mailinfo" was loose in decoding quoted printable and produced
   garbage when the two letters after the equal sign are not
   hexadecimal.  This has been fixed.

 * The documentation for '-X<option>' for merges was misleadingly
   written to suggest that "-s theirs" exists, which is not the case.

 * Spell the name of our system as "Git" in the output from
   request-pull script.

 * Fixes for a handful memory access issues identified by valgrind.

 * Backports a moral equivalent of 2015 fix to the poll emulation from
   the upstream gnulib to fix occasional breakages on HPE NonStop.

 * In the "--format=..." option of the "git for-each-ref" command (and
   its friends, i.e. the listing mode of "git branch/tag"), "%(atom:)"
   (e.g. "%(refname:)", "%(body:)" used to error out.  Instead, treat
   them as if the colon and an empty string that follows it were not
   there.

 * Users with "color.ui = always" in their configuration were broken
   by a recent change that made plumbing commands to pay attention to
   them as the patch created internally by "git add -p" were colored
   (heh) and made unusable.  This has been fixed.

 * "git branch -M a b" while on a branch that is completely unrelated
   to either branch a or branch b misbehaved when multiple worktree
   was in use.  This has been fixed.

 * "git fast-export" with -M/-C option issued "copy" instruction on a
   path that is simultaneously modified, which was incorrect.

 * The checkpoint command "git fast-import" did not flush updates to
   refs and marks unless at least one object was created since the
   last checkpoint, which has been corrected, as these things can
   happen without any new object getting created.

 * The scripts to drive TravisCI has been reorganized and then an
   optimization to avoid spending cycles on a branch whose tip is
   tagged has been implemented.

 * "git fetch <there> <src>:<dst>" allows an object name on the <src>
   side when the other side accepts such a request since Git v2.5, but
   the documentation was left stale.

 * A regression in 2.11 that made the code to read the list of
   alternate object stores overrun the end of the string has been
   fixed.

Also contains various documentation updates and code clean-ups.
