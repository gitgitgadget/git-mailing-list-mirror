Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645F820193
	for <e@80x24.org>; Thu,  1 Sep 2016 21:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbcIAVAS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:00:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64457 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754675AbcIAVAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:00:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0686F389D5;
        Thu,  1 Sep 2016 16:21:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jahvCsEE1nIVfWHq/yR3BUNP1j8=; b=exhIYX
        6gk00+3WQQdknEHZcUBhsJ4oTdH/1kxvvaqh47O3nP08S7qhzlhxn30XpuaASyqV
        ar0EmoaWvcGNhMt6cnNHKRB5DJ7uJf0LZVwqC+fwtfCo31dYKDgSySG9T68oHXA6
        4v+Qa/CNDfUyYvub24ksO5D20omyth3/gUxmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qAesR+RkvqSb7yhK+0xokbP5rppfrY2/
        4cf5ruEc8xR0szWwh0GPxdT5ChgFcchBTcpJTMGtCUgwJ1XWFTc+06iv8dmeG/n7
        KOhx54xAjeINnRTBwrftlO02h2PXdMlY9ijzabDhV2Rrw4X6+WDbRHIfJMaCiu3Z
        P0eft8JXkRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3490389D4;
        Thu,  1 Sep 2016 16:21:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E119389D1;
        Thu,  1 Sep 2016 16:21:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
        <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
        <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
        <xmqqmvjrwjwm.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZnhNVBy6Oqt=x8m0jZj_tGNkMPPBBr+aL6DToOYtv9vQ@mail.gmail.com>
        <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Sep 2016 13:21:02 -0700
In-Reply-To: <xmqqa8frwhpr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Sep 2016 12:19:44 -0700")
Message-ID: <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B9D9F70-7081-11E6-8144-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>> The final version needs to be accompanied with tests to show the
>>> effect of this change for callers.  A test would set up a top-level
>>> and submodule, deliberately break submodule/.git/ repository and
>>> show what breaks and how without this change.
>>
>> Tests are really good at providing this context as well, or to communicate
>> the actual underlying problem, which is not quite clear to me.
>> That is why I refrained from jumping into the discussion as I think the
>> first few emails were dropped from the mailing list and I am missing context.
>
> I do not know where you started reading, but the gist of it is that
> submodule.c spawns subprocess to run in the submodule's context by
> assuming that chdir'ing into the <path> of the submodule and running
> it (i.e. cp.dir set to <path> to drive start_command(&cp)) is
> sufficient.  When <path>/.git (either it is a directory itself or it
> points at a directory in .git/module/<name> in the superproject) is
> a corrupt repository, running "git -C <path> command" would try to
> auto-detect the repository, because it thinks <path>/.git is not a
> repository and it thinks it is not at the top-level of the working
> tree, and instead finds the repository of the top-level, which is
> almost never what we want.

This is with a test that covers the call in get_next_submodule() for
the parallel fetch callback.  I think many of the codepaths will end
up recursing forever the same way without the fix in a submodule
repository that is broken in a similar way, but I didn't check, so
I do not consider this to be completed.

-- >8 --
Subject: submodule: avoid auto-discovery in prepare_submodule_repo_env()

The function is used to set up the environment variable used in a
subprocess we spawn in a submodule directory.  The callers set up a
child_process structure, find the working tree path of one submodule 
and set .dir field to it, and then use start_command() API to spawn
the subprocess like "status", "fetch", etc.

When this happens, we expect that the ".git" (either a directory or
a gitfile that points at the real location) in the current working
directory of the subprocess MUST be the repository for the submodule.

If this ".git" thing is a corrupt repository, however, because
prepare_submodule_repo_env() unsets GIT_DIR and GIT_WORK_TREE, the
subprocess will see ".git", thinks it is not a repository, and
attempt to find one by going up, likely to end up in finding the
repository of the superproject.  In some codepaths, this will cause
a command run with the "--recurse-submodules" option to recurse
forever.

By exporting GIT_DIR=.git, disable the auto-discovery logic in the
subprocess, which would instead stop it and report an error.

Not-signed-off-yet.
---
 submodule.c                 |  1 +
 t/t5526-fetch-submodules.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/submodule.c b/submodule.c
index 1b5cdfb..e8258f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
 	}
+	argv_array_push(out, "GIT_DIR=.git");
 }
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 954d0e4..b2dee30 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -485,4 +485,33 @@ test_expect_success 'fetching submodules respects parallel settings' '
 	)
 '
 
+test_expect_success 'fetching submodule into a broken repository' '
+	# Prepare src and src/sub nested in it
+	git init src &&
+	(
+		cd src &&
+		git init sub &&
+		git -C sub commit --allow-empty -m "initial in sub" &&
+		git submodule add -- ./sub sub &&
+		git commit -m "initial in top"
+	) &&
+
+	# Clone the old-fashoned way
+	git clone src dst &&
+	git -C dst clone ../src/sub sub &&
+
+	# Make sure that old-fashoned layout is still supported
+	git -C dst status &&
+
+	# Recursive-fetch works fine
+	git -C dst fetch --recurse-submodules &&
+
+	# Break the receiving submodule
+	rm -f dst/sub/.git/HEAD &&
+
+	# Recursive-fetch must terminate
+	# NOTE: without fix this will recurse forever!
+	test_must_fail git -C dst fetch --recurse-submodules
+'
+
 test_done


