Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D71C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462A861369
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 04:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhFPEpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 00:45:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52372 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhFPEpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 00:45:43 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D478D0E74;
        Wed, 16 Jun 2021 00:43:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=02HYajneBge1b4DjZV0mVdsbjJ5JFvrI9rL0BG
        Nni9k=; b=DLacsCw57X4GQyb829Sbuaz+HdvW8uBImTVyc693POmpMS8D7QXxbz
        13dq4B8qF2r2Rcomm98ZA1vQaIV5elFGsh/Jr5rbXJS4C0+WGZj079nDM/16y6Qk
        9v91rp56JFg6J7v2X4fLDBCTIvmmIzJ1L8nJefBwqJvzSFXI85H40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04C4DD0E72;
        Wed, 16 Jun 2021 00:43:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7473BD0E71;
        Wed, 16 Jun 2021 00:43:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
References: <20210616004508.87186-1-emilyshaffer@google.com>
        <20210616004508.87186-3-emilyshaffer@google.com>
        <xmqqsg1iqv5n.fsf@gitster.g>
Date:   Wed, 16 Jun 2021 13:43:36 +0900
In-Reply-To: <xmqqsg1iqv5n.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        16 Jun 2021 13:40:36 +0900")
Message-ID: <xmqqk0muqv0n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A425B16-CE5D-11EB-943E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As I said, I think it is OK for now to stop at declaring that you
> cannot simply do it without hinting something that may not fully
> work.

I'll add the following to the tip of the topic for now.


 Documentation/config/submodule.txt | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git c/Documentation/config/submodule.txt w/Documentation/config/submodule.txt
index 7c459cc19e..58ba63a75e 100644
--- c/Documentation/config/submodule.txt
+++ w/Documentation/config/submodule.txt
@@ -97,8 +97,5 @@ submodule.superprojectGitDir::
 	submodules, but is not guaranteed to be present in every submodule. It
 	is set automatically during submodule creation.
 +
-	In situations where more than one superproject references the same
-	submodule worktree, the value of this config and the behavior of
-	operations which use it are undefined. To reference a single project
-	from multiple superprojects, it is better to create a worktree of the
-	submodule for each superproject.
+Because of this configuration variable, it is forbidden to use the
+same submodule worktree shared by multiple superprojects.
