Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9887C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 22:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4AA64E02
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 22:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhBJWUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:20:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhBJWUC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 17:20:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B4939A423;
        Wed, 10 Feb 2021 17:19:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g62auKJkqJ0c2cEKcl/l8eKK1HA=; b=r/WTIJ
        UHHYv/ASNxzMG9bPwmtH5N/CA72rnX7FSJyIJQFix4u4s933LnwoAMiAzhbtWu1k
        Ovoeh8pLhXBrWJrIb/cd7f/30k3wYQlkX7bKq+ME93Riu+hPVcyEMbVRXd3cu5Vj
        9e8VWUBaQ4JUt8T7FpWHhOkiUBu6ox6QDiBa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A7zJ22i/Zr6n7rDMLv5WVXMI6y3gQbHh
        85uxajfbealrRy8cHLqnNjEt/JDU/fxjRIS66uTXB/NBP4BImEXHdWKW6kkBhOFa
        +L75Xxq0LmCbxpV8eY58cYn23Ow0gCJrAhUQ9GjwwCcwQBapxAhn38ymOH3Ei046
        ZR0PqNldTPE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EADA9A422;
        Wed, 10 Feb 2021 17:19:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B1B89A421;
        Wed, 10 Feb 2021 17:19:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Walther <cwalther@gmx.ch>
Cc:     Christian Walther via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: mention bigFileThreshold for packing
References: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
        <xmqqim70zzaf.fsf@gitster.c.googlers.com>
        <F63929A8-7BC9-43A7-9E7B-118433F62588@gmx.ch>
Date:   Wed, 10 Feb 2021 14:19:16 -0800
In-Reply-To: <F63929A8-7BC9-43A7-9E7B-118433F62588@gmx.ch> (Christian
        Walther's message of "Wed, 10 Feb 2021 22:43:14 +0100")
Message-ID: <xmqq5z2z1s7v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03D901DA-6BEE-11EB-99AE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Walther <cwalther@gmx.ch> writes:

> Junio C Hamano wrote:
>
>> I doubt that the description of --window/--depth command line
>> options, for both repack and pack-objects, is the best place to add
>> this "Note".  Even if we were to add it as an appendix to these
>> places, please do not break the flow of explanation by inserting it
>> before the description of the default values of these options.
>
> OK. That was where I would have looked for it, because it explains
> why --window wasn't effective in my attempts to get better
> compression, but I don't insist on it - any place would have
> worked, as I read both manpages back and forth several times.

The "pack-objects" command (and to some degree "repack", too) is
about packing throughout, and --depth/--window is not necessarily
the central piece of the puzzle, and that, together with disruption
of the flow of the original explanation, was the reason why I found
the initial location a bit odd.

> In git-repack.txt, there is a "Configuration" section at the
> bottom, I guess it would fit there? There is none in
> git-pack-objects.txt, but I could add it. What do you think?

You're right---if there is an existing CONFIGURATION section, that
may be a much better place.  There are configuration variables that
affect how the packing works other than the core.bigFileThreshold,
and attributes like "delta" would also affect the outcome.

Describing all in one CONFIGURATION section would be valuable.

What I queued is with the following ready to be squashed in,
primarily because I was lazy and didn't have time/inclination to
look for a better place myself ;-)

Thanks.

---- >8 ----
Subject: [PATCH] fixup! doc: mention bigFileThreshold for packing

---
 Documentation/git-pack-objects.txt | 7 +++----
 Documentation/git-repack.txt       | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 59150ded4b..be0f953c35 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -97,12 +97,11 @@ base-name::
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
 +
-Note that delta compression is never used on objects larger than the
-`core.bigFileThreshold` configuration variable (see
-linkgit:git-config[1]).
-+
 The default value for --window is 10 and --depth is 50. The maximum
 depth is 4095.
++
+Note that delta compression is never used on objects larger than the
+`core.bigFileThreshold` configuration variable (see linkgit:git-config[1]).
 
 --window-memory=<n>::
 	This option provides an additional limit on top of `--window`;
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 0a7038ec4a..145fff6e01 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -96,12 +96,11 @@ to the new separate pack will be written.
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
 +
-Note that delta compression is never used on objects larger than the
-`core.bigFileThreshold` configuration variable (see
-linkgit:git-config[1]).
-+
 The default value for --window is 10 and --depth is 50. The maximum
 depth is 4095.
++
+Note that delta compression is never used on objects larger than the
+`core.bigFileThreshold` configuration variable (see linkgit:git-config[1]).
 
 --threads=<n>::
 	This option is passed through to `git pack-objects`.
-- 
2.30.1-597-g82b686dd6a

