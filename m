Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB2FC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A212077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 16:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yKGAhG8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfLDQvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:51:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63202 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfLDQvh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 11:51:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4B0A8D1EF;
        Wed,  4 Dec 2019 11:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jU4+pZq27AZi/ZrES/1+4DBATmY=; b=yKGAhG
        8X1bdMaBFU4ur3U1c9vBvQIYS5vGPzsVZwxqFzxIP8V/gBpPAInvOuS8NacTAVvx
        j1LM5Dym9/5uIb9Vbq/+vctSjRUIuv2ISJiY1MGtndgBjsWeegaLzqqP/ZzO+KQL
        gldBrteHRktZp82f/M2IttsOJ/Ntdc2YPXf5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZMo9BQYuhWOO7ryjTZPFrdlDfQ+JqMvq
        tlNAur2Tcl4DQWx9HZ8QBuTXTELeFjgV4I9CLdz4uF+49tvir5o4CJHB2lMmCtjw
        kn2MkN5u2Ee4yEEthjfdlCzguSuslTWafZqbGTNqJQwWLuhGYphLeePjh35V9tZP
        H7NQpEh20EU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC1128D1EE;
        Wed,  4 Dec 2019 11:51:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A95EB8D1ED;
        Wed,  4 Dec 2019 11:51:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "panzercheg via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, panzercheg <panzercheg@gmail.com>
Subject: Re: [PATCH 1/1] git-p4: use lfs.storage instead of local .git/lfs Use lfs.storage if it defined in git.config. If lfs.storage not define - used local .git/lfs. Original code uses local .git/lfs in sync/clone operations, but if you have external lfs storage better to use it.
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
        <73d0dfc9dd7e6e800297b5084de84b727e28b900.1575466209.git.gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 08:51:23 -0800
In-Reply-To: <73d0dfc9dd7e6e800297b5084de84b727e28b900.1575466209.git.gitgitgadget@gmail.com>
        (panzercheg via GitGitGadget's message of "Wed, 04 Dec 2019 13:30:09
        +0000")
Message-ID: <xmqqh82g5910.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F36B840-16B6-11EA-BFF6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"panzercheg via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: panzercheg <panzercheg@gmail.com>

> Subject: Re: [PATCH 1/1] git-p4: use lfs.storage instead of local .git/lfs Use lfs.storage if it defined in git.config. If lfs.storage not define - used local .git/lfs. Original code uses local .git/lfs in sync/clone operations, but if you have external lfs storage better to use it.

The reason why you ended up with this unreadably long subject line
is because your commit did not follow the recommended

    <area>: summary of the change in 50 or so characters

    description of the issue being tackled,
    where it came from,
    why the current behaviour is considered not ideal, etc.

    what the proposed change does, and why it is the good idea.

format, each clearly separated into their own paragraphs.

Especially the title MUST be in its own, single-line paragraph.

Let's dissect what we see on the single long subject line.


    git-p4: use lfs.storage instead of local .git/lfs

    Use lfs.storage if it defined in git.config.

What is "git.config"?  Is it our own usual configuration file(s), or
is it the Git-LFS customized .lfsconfig file at the root of the
repository, or something else?

Grammo: "Use lfs.storage if it is defined ..."

But do not start your proposed log message with the conclusion.
Before "Use X", we want to see readers convinced why using X is a
good idea; in other words, you need to tell the reason why the
current system that does not use X is not ideal, and explain that
the change makes the world a better place by teaching Git to use X.

    If lfs.storage not define - used local .git/lfs.
    Original code uses local .git/lfs in sync/clone operations,

These are saying pretty much the same thing, that can easily
inferred from the "Use lfs.storage if it is defined.", iow, without
having much original information content.

    but if you have external lfs storage better to use it.

This is probably the sole line that attempts to justify the change.
It should be made stronger, I would think.

Possible rewrite (don't use it literally---I am not an GitLFS user so
I may be writing nonsense here):

    git-p4: prefer lfs.storage over local .git/lfs directory

    "git lfs" allows users to specify the custom storage location by
    configuration variable lfs.storage, but when "git p4" interacts
    with GitLFS pointers, it always used the hardcoded default that
    is the .git/lfs/ directory, without paying attention to the
    configuration.

    Use the value configured in lfs.storage, if exists, as all the
    "git" operations do, for consistency.

    Signed-off-by: ...


>
> Signed-off-by: r.burenkov <panzercheg@gmail.com>
> ---
>  git-p4.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 60c73b6a37..2bd0497c31 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1257,9 +1257,13 @@ def generatePointer(self, contentFile):
>              pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
>  
>          oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
> +        # if someone use external lfs.storage ( not in local repo git )

s/use/uses/; also lose SP after '(' and before ')'.

> +        lfs_path = os.path.join(os.getcwd(), '.git', 'lfs')
> +        if gitConfig('lfs.storage'):
> +            lfs_path = gitConfig('lfs.storage')

Shouldn't the above three lines be more like this?

	lfs_path = gitConfig('lfs.storage');
	if not lfs_path:
		lfs_path = 'lfs'
	if not os.path.isabs(lfs_path):
		lfs_path = os.path.join(os.getcwd(), '.git', lfs_path)

The reason why I suspect so is because [*1*] says that the value of
the lfs.storage that is not an absolute path is relative to ".git".

Thanks.



[Reference]

*1* https://github.com/git-lfs/git-lfs/blob/master/docs/man/git-lfs-config.5.ronn



>          localLargeFile = os.path.join(
> -            os.getcwd(),
> -            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
> +            lfs_path,
> +            'objects', oid[:2], oid[2:4],
>              oid,
>          )
>          # LFS Spec states that pointer files should not have the executable bit set.
