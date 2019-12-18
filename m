Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FDC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D90218AC
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 22:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jsoA5Jdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfLRWQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:16:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65140 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 17:16:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 679181E196;
        Wed, 18 Dec 2019 17:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ILsY7uH/o3a4t2Rik4EZkrYnkIY=; b=jsoA5J
        dolExOW1KR5XYRHQ3u/y6ukyOyurSQTiYmMht5Drw8JRPybRbicLzPaTOqP9XBwv
        LkLxy4aKWBy+Mvxsy4INzc+Quwkdd7aiAg40bModpz739C9+2QPSd3IR5Z/RUIcS
        HYyqRQq2aSWTd35dHhBAvmqg3w8FmgShFqmWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AgSuIeTJ+ua7e1nCXb/ma+6ykS+VVNps
        nNURuNSpz/IBHd9bvabp6uTQ/6QHUI63M0oMBdMJKtqDPp/1HgtcY+j3ZhZUTyEu
        rXPGjlTecdrvLxDcmLFMP87n7vmYj5tkBqbejQit6uWAqqOQ4qcglDMm8GNhsJzG
        wtmMrbB6x18=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1798B1E195;
        Wed, 18 Dec 2019 17:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F19031E191;
        Wed, 18 Dec 2019 17:16:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 04/18] commit: forbid --pathspec-from-file --all
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
        <195a5b2a-994a-5984-8cc7-280a698df2a0@gmail.com>
        <xmqqmubpcmtx.fsf@gitster-ct.c.googlers.com>
        <xmqqimmdcmq4.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 18 Dec 2019 14:16:01 -0800
In-Reply-To: <xmqqimmdcmq4.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 18 Dec 2019 14:06:43 -0800")
Message-ID: <xmqqeex1cmam.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA5F7BC0-21E3-11EA-975F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Hi Alexandr
>>>
>>> This looks good, thanks for the test
>>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>> On 16/12/2019 15:47, Alexandr Miloslavskiy via GitGitGadget wrote:
>>>> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
>>>>
>>>> I forgot this in my previous patch `--pathspec-from-file` for
>>>> `git commit` [1]. When both `--pathspec-from-file` and `--all` were
>>>> ...
>>>> [1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)
>>
>> Thanks, both.  I will take this separately and queue directly on top
>> of am/pathspec-from-file to fast-track it, rather than leaving it as
>> a part of larger topic that would take more time to mature.
>
> Sigh... the test part of this patch is taken hostage to an earlier
> patches in this series that are iffy, so I cannot quite apply this
> fix alone at this moment.
>
> Yuck.

Here is what I'll queue directly on top of am/pathspec-from-file
e440fc58 ("commit: support the --pathspec-from-file option",
2019-11-19), to be fast-tracked.

-- >8 --
Subject: [PATCH] commit: forbid --pathspec-from-file --all

I forgot this in my previous patch `--pathspec-from-file` for
`git commit` [1]. When both `--pathspec-from-file` and `--all` were
specified, `--all` took precedence and `--pathspec-from-file` was
ignored. Before `--pathspec-from-file` was implemented, this case was
prevented by this check in `parse_and_validate_options()` :

    die(_("paths '%s ...' with -a does not make sense"), argv[0]);

It is unfortunate that these two cases are disconnected. This came as
result of how the code was laid out before my patches, where `pathspec`
is parsed outside of `parse_and_validate_options()`. This branch is
already full of refactoring patches and I did not dare to go for another
one.

Fix by mirroring `die()` for `--pathspec-from-file` as well.

[1] Commit e440fc58 ("commit: support the --pathspec-from-file option" 2019-11-19)

Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
[jc: adjusted test not to depend on other patches]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c                | 3 +++
 t/t7526-commit-pathspec-file.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index ed40729355..c040dc92a4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -347,6 +347,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (interactive)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
 
+		if (all)
+			die(_("--pathspec-from-file with -a does not make sense"));
+
 		if (pathspec.nr)
 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
 
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index a06b683534..4b58901ed6 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -127,4 +127,10 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success '--pathspec-from-file and --all cannot be used together' '
+	restore_checkpoint &&
+	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" 2>err &&
+	test_i18ngrep "[-]-pathspec-from-file with -a does not make sense" err
+'
+
 test_done
-- 
2.24.1-722-g0b9e186032

