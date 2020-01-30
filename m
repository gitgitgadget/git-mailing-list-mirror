Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB75C33CB2
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CFD2070E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UxTsNBWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgA3BiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:38:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58446 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgA3Bh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:37:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 090F7442A7;
        Wed, 29 Jan 2020 20:37:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cvLGWRICGxpMMr24XZAKl5V0K3I=; b=UxTsNB
        WbSShQe3LPUX03NNHPAAjjcwRWq1ddcqMoAvtQy5JwUfyZOk4bLdtLEh6t9iPaTn
        dK/nTmSvwyMIie1cTiX6JnNkDcGn4jWzqdPuI6u9SVF3v/pa7ZwT7BzoTPFMVa6m
        KSNMOX9DMA6le7nnmM0dHDvbzSRwwH7AzxjxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wsPkIWV1ph9lPfQrVt3R13hbrwCaTaDR
        ufMBv/ki0wigNkQ7NI6nE5nxcdXqSaTltTnBcyc3v5turlgori2OOVRppuYeHUHX
        kbzA/k25GfTJVdnBqCldOwkx18Q7eQc0zHOecK/ETm2KMEU7WtTyyjua6EdTxd1F
        KM5wR62zL4A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F390B442A6;
        Wed, 29 Jan 2020 20:37:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 663ED442A5;
        Wed, 29 Jan 2020 20:37:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Andrey Mazo <ahippo@yandex.com>, Git Users <git@vger.kernel.org>,
        Ben Keene <seraphire@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
        <CAE5ih79a4SeiAnC_c+XHXAiibeNBg-h1ZjMsv2pHMNtHGmqX1w@mail.gmail.com>
        <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 29 Jan 2020 17:37:54 -0800
In-Reply-To: <xmqqtv4edqx9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Jan 2020 11:05:22 -0800")
Message-ID: <xmqqeevhenbh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 234A9FA4-4301-11EA-93BA-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, but it wasn't very helpful to see an Ack (i.e. "an expert
> says this is good") without seeing any of my "why is this good?"
> answered by either the original author or the expert X-<.

More specifically, to summarize the issues I raised:

 * Is the proposed name of the hook a reasonable one?  If so, the
   log message should explain why it is a reasonable one.  If not,
   it should be given a more reasonable name and the log message
   should justify the new name.

 * Given that "git commit" has a pair of hooks for log message, is
   adding one new hook a reasonable thing?  If so, the log mesasge
   should explain why (e.g. perhaps the other one already is there,
   or perhaps the other one is not applicable in the context of
   interacting with P4 with such and such reasons).)

 * Is it reasonable not to have a mechanism to disable/skip the
   hook, like "git commit" does?  If not, the log message should
   explain why such an escape hatch, which is needed for "git
   commit", is not needed.

 * githooks(5) manual page is supposed to list all hooks, so a patch
   that adds a new one should add a description for it in there.

Thanks.

>>> "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>> > From: Ben Keene <seraphire@gmail.com>
>>> > Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
>>>
>>> "git shortlog --no-merges" would show that the convention is to
>>> downcase "Add".
>>>
>>> With two consecutive non-words (i.e. 'pre' and "pedit'), it really
>>> feels an unpronounceable mouthful to a non-perforce person like me.
>>>
>>> On the core Git side, "git commit", which is the primary command
>>> that is used to create a new commit, has two hooks that helps to
>>> enforce consistency to the commit log messages:
>>>
>>>  - The "prepare-commit-msg" hook prepares the message to be further
>>>    edited by the end-user in the editor
>>>
>>>  - The "commit-msg" hook takes what the end-user edited in the
>>>    editor, and can audit and/or tweaks it.
>>>
>>> Having a matching pair of hooks and making sure the new hooks have
>>> similar names to these existing ones may help experienced Git users
>>> adopt the new hooks "git p4" learns here.
>>>
>>> What makes "p4-pre-pedit-changelist" a good name for this hook?  "In
>>> pure Perforce without Git, there is 'pre-pedit-changelist' hook that
>>> Perforce users are already familiar with" would be a good answer but
>>> not being P4 user myself, I do not know if that is true.
>>>
>>> Also, "git commit" has a mechanism (i.e. "--no-verify") to suppress
>>> the "auditing" hook, and it serves as an escape hatch.  The new hook
>>> "git p4" learns may want to have a similar mechanism, to keep its
>>> users productive even when they have broken/stale/bogus hook rejects
>>> their legitimate log message, by allowing them to bypass the
>>> offending hook(s).
>>>
>>>
>>> > Add an additional hook to the git-p4 command to allow a hook to modify
>>> > the text of the changelist prior to displaying the p4editor command.
>>> >
>>> > This hook will be called prior to checking for the flag
>>> > "--prepare-p4-only".
>>> >
>>> > The hook is optional, if it does not exist, it will be skipped.
>>> >
>>> > The hook takes a single parameter, the filename of the temporary file
>>> > that contains the P4 submit text.
>>> >
>>> > The hook should return a zero exit code on success or a non-zero exit
>>> > code on failure.  If the hook returns a non-zero exit code, git-p4
>>> > will revert the P4 edits by calling p4_revert(f) on each file that was
>>> > flagged as edited and then it will return False so the calling method
>>> > may continue as it does in existing failure cases.
>>>
>>> The githooks(5) page should talk about some of these, I would think.
>>>
>>> >  git-p4.py | 11 +++++++++++
>>> >  1 file changed, 11 insertions(+)
>>> >
>>> > diff --git a/git-p4.py b/git-p4.py
>>> > index 40d9e7c594..1f8c7383df 100755
>>> > --- a/git-p4.py
>>> > +++ b/git-p4.py
>>> > @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
>>> >          tmpFile.write(submitTemplate)
>>> >          tmpFile.close()
>>> >
>>> > +        # Run the pre-edit hook to allow programmatic update to the changelist
>>> > +        hooks_path = gitConfig("core.hooksPath")
>>> > +        if len(hooks_path) <= 0:
>>> > +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>>> > +
>>> > +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
>>> > +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
>>> > +            for f in editedFiles:
>>> > +                p4_revert(f)
>>> > +            return False
>>> > +
>>> >          if self.prepare_p4_only:
>>> >              #
>>> >              # Leave the p4 tree prepared, and the submit template around
>>> >
>>> > base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
