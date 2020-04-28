Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C5DC83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A987C206D8
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SPqxl98c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgD1QY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:24:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51753 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgD1QY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:24:59 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D0BF9BF6AF;
        Tue, 28 Apr 2020 12:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3kgvlTz4b9DT2vg0sS2+uxBiSI=; b=SPqxl9
        8c0ra9n8UfxRx/RHy+/WSBii/0mfyty1UBUay0Ww0wJa49zwU8NCbk6SVTi11gRv
        smMZDMYYXt9xLUjcEATj2KyrvXj2qeoA1wOWZjr4x2Z7pBQRYhNtF2/U4K7VJ5zS
        51Tjt+wBBOeLsOV2VEYzfBxpY+BT29uaF1lFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yk2496BFrqtGq+9DwaOdz4YTtwn02vaj
        9HpBwfH5bhI7WSKIT119eTpUcbt42k9HUAxWGT2/iq5p41H8Pq5a2eJTDFK+TtP3
        9KGzBVXOLdzZtRkDWBroS9+vdKbIgIVYrH8LeaC50VjeC4eqgEE9fM/VrW9hkPvJ
        jjoDQ3skJFM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8672BF6AD;
        Tue, 28 Apr 2020 12:24:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B231EBF6AC;
        Tue, 28 Apr 2020 12:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for git switch --orphan
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
        <20200425022045.1089291-6-jacob.e.keller@intel.com>
        <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
        <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
Date:   Tue, 28 Apr 2020 09:24:52 -0700
In-Reply-To: <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
        (Jacob Keller's message of "Mon, 27 Apr 2020 19:20:44 -0700")
Message-ID: <xmqqo8rb4lyj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAA47034-896C-11EA-941C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> The proposed SQUASH you have in gitster/jk/complete-git-switch is
> correct. The commit message body is correct, but the title could be
> reworded to
>
> "completion: stop completing refs for git switch --orphan"
>
> I can send a v2 if that would be helpful, and I've got it fixed up
> locally if other review increases the need for a new spin.

Thnaks.  In the meantime, what I have is attached (the test title,
in addition to the commit title, has been updated).

The same logic would apply to "git checkout -b <TAB>" (or "git
switch -c <TAB>") as this change: these are meant to create a new
branch so you do not want to offer an existing branch name.

I have a mixed feelings about that reasoning, though.  I understand
that not offering any existing branch name would avoid offering a
branch name that would cause an error message from the command,
which at a first glance feels like a nice help to the user, but I am
not sure if it is really helping.

When you are on jk/complete-switch branch to work on this topic, you
may want to keep the current state of the branch and use a "v2"
branch to play around (running "rebase -i" etc.), for which the way
I would hope to work would be:

	git checkout -b jk/comp<TAB>

that would complete to an existing branch

	git checkout -b jk/complete-switch

and then I can just type "-v2<Enter>" (or "<BackSpace>-v2<Enter>" to
remove the inter-word space completion adds?)  after that.  After
all, "git checkout -b jk/complete-switch" in that scenario would
error out by saying that you already use that name, which is a good
enough protection.

And that same "is this really helping?" reasoning applies equally to
the "--orphan" option.

I dunno.

-- >8 --
From: Jacob Keller <jacob.keller@gmail.com>
Date: Fri, 24 Apr 2020 19:20:38 -0700
Subject: [PATCH] completion: stop completing refs for git switch --orphan

git switch with the --orphan option is used to create a new branch that
is not connected to any history and is instead based on the empty tree.

It does not make sense for completion to return anything in this case,
because there is nothing to complete. Check for --orphan, and if it's
found, immediately return from _git_switch() without completing
anything.

Add a test case which documents this expected behavior.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 11 ++++++++++-
 t/t9902-completion.sh                  |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21786f2fd..08d3406cf3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2223,9 +2223,18 @@ _git_switch ()
 		__gitcomp_builtin switch
 		;;
 	*)
+		local track_opt="--track" only_local_ref=n
+
+		# --orphan is used to create a branch disconnected from the
+		# current history, based on the empty tree. Since the only
+		# option required is the branch name, it doesn't make sense to
+		# complete anything here.
+		if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
+			return
+		fi
+
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
-		local track_opt="--track" only_local_ref=n
 		if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
 		   [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
 			track_opt=''
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a134a87910..7e4dd8e722 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1351,6 +1351,12 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
 	EOF
 '
 
+test_expect_success 'git switch --orphan completes no references' '
+	test_completion "git switch --orphan " <<-\EOF
+
+	EOF
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.26.2-266-ge870325ee8

