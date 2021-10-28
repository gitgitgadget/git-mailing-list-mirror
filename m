Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C76C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7482C60D07
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhJ1R1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:27:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51742 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhJ1R1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E4D9161C9C;
        Thu, 28 Oct 2021 13:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kwDrU5RlG+x6kZcPzt1421S4LcgQYMAPTm/X+V
        okBxA=; b=pASGb3/A2LW/JdinAvqS+MtrPB3XT2J7NHz8OxMr8ix+j1jmVvOTPz
        qRwWoYDVbLTEO+tJUAuTjYebM0E8SOk4ZpBONK0/cpcZfG6ltBaECCd2gcckS0sc
        xRkIRf/bg9VmKCGTo8YlET+j8uzFwvOIlcPvNilKr2VhyXIiCLXVM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86988161C9B;
        Thu, 28 Oct 2021 13:25:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E037C161C9A;
        Thu, 28 Oct 2021 13:25:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 9/9] doc: git-init: clarify file modes in octal.
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <7eef3538f3c3015c4f446961ddca78e2868fe644.1635438124.git.gitgitgadget@gmail.com>
        <xmqqilxhrrva.fsf@gitster.g>
Date:   Thu, 28 Oct 2021 10:25:07 -0700
In-Reply-To: <xmqqilxhrrva.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        28 Oct 2021 10:17:29 -0700")
Message-ID: <xmqqcznprrik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFD58DA4-3813-11EC-9383-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> How about calling it <perm> (or <perm-bits>)?

I think it is better to queue your original as-is, as a part of the
topic whose theme is to correct the formatting and phrasing without
changing the spirit of the existing text.

Fixing the "umask confusion" should be left to a separate patch on
top.

----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: init doc: --shared=0xxx does not give umask but perm bits

The description that 0640 makes sure that the group members can read
the repository is correct, but calling that octal number a <umask>
is wrong.  Let's call it <perm>, as the value is used to set the
permission bits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-init.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-init.txt w/Documentation/git-init.txt
index af0d2ee182..42268ada22 100644
--- c/Documentation/git-init.txt
+++ w/Documentation/git-init.txt
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|<umask>)]::
+--shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -110,15 +110,16 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'<umask>'::
+'<perm>'::
 
-'<umask>' is an 3-digit octal number prefixed with `0` and each file
-will have mode '<umask>'. '<umask>' will override users' umask(2)
+'<perm>' is an 3-digit octal number prefixed with `0` and each file
+will have mode '<perm>'. '<perm>' will override users' umask(2)
 value (and not only loosen permissions as 'group' and 'all'
 does). '0640' will create a repository which is group-readable, but
 not group-writable or accessible to others. '0660' will create a repo
 that is readable and writable to the current user and group, but
-inaccessible to others.
+inaccessible to others (directories and executable files get their
+`x` bit from the `r` bit for corresponding classes of uses).
 --
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
