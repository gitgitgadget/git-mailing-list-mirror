Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9904F1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755845AbcIAVCg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 17:02:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60335 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752344AbcIAVCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 17:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5FDE3905F;
        Thu,  1 Sep 2016 17:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xCLX8m8YGLvlhRmKFMaXDj/brU=; b=j38RIc
        3Ofi4tjinSaosz6PdiVycq/cc99cNWuNRjv3NSOIstgVKTM3hL5g9Fw1yckxDb3m
        6fh+PUiVI/BJ5GBFhBSAMXKBmAgoyYiGYOp7mCEj9JLIKGkqzcJgzZ+lmNSVmkXg
        GzePNzMT/FHyKTskjr4PNyatruIBDDE1ZJkM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wqdS9Caz2N6Af3PFR5GD6NUrdFmoS3q/
        GCOfoqAdbUmaBYM65VrMz3ZZW/DILBuw1GmoaTgcN+2e0rWh2IAgDYCLj+KhNbUi
        Jc4U7yRQKuZQAg8eMSrsIBdXnZPisX9C0MSMa2Yja6RCRFtzx+gvLz/wuOj4Bblk
        H6zG0dkdsyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC5A03905D;
        Thu,  1 Sep 2016 17:02:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4518B3905C;
        Thu,  1 Sep 2016 17:02:30 -0400 (EDT)
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
        <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 01 Sep 2016 14:02:28 -0700
In-Reply-To: <xmqq4m5zwevl.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Sep 2016 13:21:02 -0700")
Message-ID: <xmqqtwdzuye3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65409904-7087-11E6-9409-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

If we add

	# "git diff" should terminate with an error.
	# NOTE: without fix this will recurse forever!
	test_must_fail git -C dst diff &&

after breaking the repository, we can also see "git diff" recurse
forever, because it wants to know if "sub" submodule is modified,
attempts to run "git status" in there, and ends up running that
command in the context of the parent repository.

I am tempted to cheat and commit this, even though this test is no
longer about fetching submodules.

-- >8 --
[PATCH] submodule: avoid auto-discovery in prepare_submodule_repo_env()

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

The test illustrates existing problems in a few callsites of this
function.  Without this fix, "git fetch --recurse-submodules", "git
status" and "git diff" keep recursing forever.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c                 |  1 +
 t/t5526-fetch-submodules.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/submodule.c b/submodule.c
index 4532b11..2801fbb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
 	}
+	argv_array_push(out, "GIT_DIR=.git");
 }
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 954d0e4..f3b0a8d 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -485,4 +485,39 @@ test_expect_success 'fetching submodules respects parallel settings' '
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
+	# "diff" would find no change
+	git -C dst diff --exit-code &&
+
+	# Recursive-fetch works fine
+	git -C dst fetch --recurse-submodules &&
+
+	# Break the receiving submodule
+	rm -f dst/sub/.git/HEAD &&
+
+	# NOTE: without the fix the following tests will recurse forever!
+	# They should terminate with an error.
+
+	test_must_fail git -C dst status &&
+	test_must_fail git -C dst diff &&
+	test_must_fail git -C dst fetch --recurse-submodules
+'
+
 test_done
-- 
2.10.0-rc2-314-g775ea9a



