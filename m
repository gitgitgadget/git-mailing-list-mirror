Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A81C433EF
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 17:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357937AbiDLRDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357961AbiDLRDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 13:03:47 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD4B606DF
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 10:01:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8518B191BC5;
        Tue, 12 Apr 2022 13:01:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=mqhcnNmvbiavmed0HQ+JoUMz9
        1tXynEc2wCcXEDjYZ0=; b=I3Yut4rCQdHmDqiniA1K2iX8kdrNG6j6IPB0FEY88
        gELdv8cmBUFD39AQtPN6XuJ70c7j/vX91HQ5ZxXDPZJzJgtsiS8yEabnRDQ83p3i
        un3YAjlSODL2krLsHKVB8ebq5hzIN0TtDFiDrmY8hn+HuX3rGHAKZld1kapi6/Mn
        s0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7CE8D191BC4;
        Tue, 12 Apr 2022 13:01:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69962191BC3;
        Tue, 12 Apr 2022 13:01:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.35.2 and below for CVE-2022-24765
Date:   Tue, 12 Apr 2022 10:01:21 -0700
Message-ID: <xmqqv8veb5i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E276376-BA82-11EC-9FE1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.35.2, together with releases
for older maintenance tracks v2.30.3, v2.31.2, v2.32.1, v2.33.2, and
v2.34.2, are now available at the usual places.

These maintenance releases are to address the security issues
described in CVE-2022-24765.  Please update at your earliest
opportunity.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.35.2',
'v2.34.2', 'v2.33.2', 'v2.32.1', 'v2.31.2', and 'v2.30.3' tags.

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D https://github.com/gitster/git

CVE-2022-24765:
   On multi-user machines, Git users might find themselves
   unexpectedly in a Git worktree, e.g. when another user created a
   repository in `C:\.git`, in a mounted network drive or in a
   scratch space. Merely having a Git-aware prompt that runs `git
   status` (or `git diff`) and navigating to a directory which is
   supposedly not a Git worktree, or opening such a directory in an
   editor or IDE such as VS Code or Atom, will potentially run
   commands defined by that other user.

Credit for finding this vulnerability goes to =E4=BF=9E=E6=99=A8=E4=B8=9C=
; the fix was
authored by Johannes Schindelin.
