Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4354C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C38923718
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbhAJGlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 01:41:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64678 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbhAJGlK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 01:41:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A907C116E22;
        Sun, 10 Jan 2021 01:40:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=18jZLswlRGtNNC0jK8hJM/jLOH4=; b=hN0Gsj
        ylbK4gS+fynbSDDNF5UoIkKxOh/jtVGOojnRECz6y+yP3dUyTtNIp1A5/X9uln+j
        5sQbdP/pcjCUAgCHjXmHm4ku/8JmKKQe4HDM8tXPilq3O2GgXaW+UMKPVvT08MGj
        fdrdaTG4WGFvkKjJdj2FOfT0GGL4oqfX0q8Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lm6OyMrznKhCLjcU6eNQR7sznYuefSd7
        T3oK/yU+rRxjLxkWmabUyKEMruo0soMdtbDjUFdEphPeuSLMbKOZs1d8IfdNvr6H
        cfSTRHgR1RvPkk/67b/x9Mxo9YFPLRJdbT0wwHqewivKxgB5Yh6DYJp63LjJsMWo
        /5Zi6h11QfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0691116E21;
        Sun, 10 Jan 2021 01:40:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 11D2B116E20;
        Sun, 10 Jan 2021 01:40:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re* [PATCH v2] fixup! mergetool: add automerge configuration
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <20210109225400.GA156779@ellen>
        <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
Date:   Sat, 09 Jan 2021 22:40:20 -0800
In-Reply-To: <xmqqmtxhd1zx.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 09 Jan 2021 17:17:22 -0800")
Message-ID: <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B70FF41E-530E-11EB-9E18-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Seth House <seth@eseth.com> writes:
>
>> On Sat, Jan 09, 2021 at 02:42:36PM -0800, David Aguilar wrote:
>>> Replace "\r" with a substituted variable that contains "\r".
>>> Replace "\?" with "\{0,1\}".
>>
>> Nice. I was (very slowly) converging on that as the culprit. Thanks for
>> the elegant fix! I'm running the test suite on Windows and OSX (now that
>> they're set up locally) with this included and I'll send a v10 once
>> complete.
>
> Note that the topic fails t7800.5 even with the fix-up (and without
> these fix-up on a platform with sed that do not need the portability
> fix-up).

It seems that 51b27370 (mergetool: break setup_tool out into
separate initialization function, 2020-12-28) is the culprit.

git-difftool--helper is taught to do this:

    diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
    index 46af3e60b7..234dd6944e 100755
    --- a/git-difftool--helper.sh
    +++ b/git-difftool--helper.sh
     ...
    @@ -79,6 +80,7 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
     then
            LOCAL="$1"
            REMOTE="$2"
    +	initialize_merge_tool "$merge_tool" &&
            run_merge_tool "$merge_tool" false
     else
            # Launch the merge tool on each path provided by 'git diff'

But the thing is, t7800.5 gives a name of merge-tool that does not
exist, and expects difftool to notice it and error out.  The callchain
starting from the above "run_merge_tool" should look like

    run_merge_tool () {
        merge_tool_path=$(get_merge_tool_path ...) || exit
	...

which in turn calls

    get_merge_tool_path () {
        # A merge tool has been set, so verify that it's valid.
        merge_tool="$1"
        if ! valid_tool "$merge_tool"
        then
                echo >&2 "Unknown merge tool $merge_tool"
                exit 1
        fi

and "valid_tool bad-tool" would return false, which lets us safely
exit with the error message.

But the call to initialize_merge_tool inserted above, that makes us
to SKIP the call to run_merge_tool, would defeat the error detection.

An ugly workaround patch that caters only to difftool breakage is
attached at the end; I did not look if a similar treatment is
necessary for the mergetool side.

By the way, debugging this was somewhat painful as difftool is partly
rewritten in C.  If it were still pure script, it would have been a
lot easier to diagnose with a single "set -x" somewhere X-<.

----- >8 ---------- >8 ---------- >8 ---------- >8 -----
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 9 Jan 2021 22:35:18 -0800
Subject: [PATCH] fixup! mergetool: break setup_tool out into
    separate initialization function

At least difftool wants to see even a broken tool name in its call
to run_merge_tool and have it diagnose an error.  &&-cascading the
call to initialize_merge_tool and run_merge_tool means that a bogus
tool name that does not please initialize_merge_tool is not even seen
by run_merge_tool and the error goes unnoticed.

I didn't audit the original commit for its use of initialize_merge_tool
on the merge-tool side.  It may share the same issue, or it may not.

This should fix the errors we've been seeing in t7800.5 (and
possibly others) with this topic.
---
 git-difftool--helper.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 234dd6944e..992124cc67 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -61,7 +61,9 @@ launch_merge_tool () {
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		initialize_merge_tool "$merge_tool" &&
+		initialize_merge_tool "$merge_tool"
+		# ignore the error from the above --- run_merge_tool
+		# will diagnose unusable tool by itself
 		run_merge_tool "$merge_tool"
 	fi
 }
@@ -80,7 +82,9 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
 then
 	LOCAL="$1"
 	REMOTE="$2"
-	initialize_merge_tool "$merge_tool" &&
+	initialize_merge_tool "$merge_tool"
+	# ignore the error from the above --- run_merge_tool
+	# will diagnose unusable tool by itself
 	run_merge_tool "$merge_tool" false
 else
 	# Launch the merge tool on each path provided by 'git diff'
-- 
2.30.0-311-g8a3956654a

