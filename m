Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1277C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFADC217F4
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 23:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PzilG1pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAUXFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:05:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54069 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 18:05:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 598A219448;
        Tue, 21 Jan 2020 18:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uqbRlrgsQpnhvkHypdtipOd2kbY=; b=PzilG1
        pT2sxPq3iFAK8hsMBq3dEfxbS05GZ7ibusQwa3ngWYB/K9OoFFSMhSbuUJ48Wsnp
        jCpNOnlFknfC2N/emG9yXE8v9PJkWWhxus1RXQQTNt2pxa7eeQHILVygnKk96VQG
        G45lhEc87xtQzXq1so5sCUjqJmvhkGBIpFsso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yG1+CHQcjSz7zrWTCvXYmiqlr8FbQxEN
        IZZTt1GSHGMohHFLl6Eai5vHRVEJ6vX00uEwYOHVSlV+PECpkqep2qDL5pYLHK27
        i9ybvpho2uYlRnHbiTmb/S0lq3fJIYfuGRUvaD8MGwPOqfTRgRuwe9K0UZEMGe+2
        loE1zw2Hgnw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50B8D19447;
        Tue, 21 Jan 2020 18:05:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A12A219443;
        Tue, 21 Jan 2020 18:05:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>, Andrey Mazo <ahippo@yandex.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 15:05:40 -0800
In-Reply-To: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com> (Ben
        Keene via GitGitGadget's message of "Mon, 20 Jan 2020 21:17:16 +0000")
Message-ID: <xmqqzheg76m3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BD7F496-3CA2-11EA-B917-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[jc] asking for help from those who made non-trivial changes to "git
p4" in the past 18 months or so for reviewing.

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
> Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist

"git shortlog --no-merges" would show that the convention is to
downcase "Add".

With two consecutive non-words (i.e. 'pre' and "pedit'), it really
feels an unpronounceable mouthful to a non-perforce person like me.

On the core Git side, "git commit", which is the primary command
that is used to create a new commit, has two hooks that helps to
enforce consistency to the commit log messages:

 - The "prepare-commit-msg" hook prepares the message to be further
   edited by the end-user in the editor

 - The "commit-msg" hook takes what the end-user edited in the
   editor, and can audit and/or tweaks it.

Having a matching pair of hooks and making sure the new hooks have
similar names to these existing ones may help experienced Git users
adopt the new hooks "git p4" learns here.

What makes "p4-pre-pedit-changelist" a good name for this hook?  "In
pure Perforce without Git, there is 'pre-pedit-changelist' hook that
Perforce users are already familiar with" would be a good answer but
not being P4 user myself, I do not know if that is true.

Also, "git commit" has a mechanism (i.e. "--no-verify") to suppress
the "auditing" hook, and it serves as an escape hatch.  The new hook
"git p4" learns may want to have a similar mechanism, to keep its
users productive even when they have broken/stale/bogus hook rejects
their legitimate log message, by allowing them to bypass the
offending hook(s).


> Add an additional hook to the git-p4 command to allow a hook to modify
> the text of the changelist prior to displaying the p4editor command.
>
> This hook will be called prior to checking for the flag
> "--prepare-p4-only".
>
> The hook is optional, if it does not exist, it will be skipped.
>
> The hook takes a single parameter, the filename of the temporary file
> that contains the P4 submit text.
>
> The hook should return a zero exit code on success or a non-zero exit
> code on failure.  If the hook returns a non-zero exit code, git-p4
> will revert the P4 edits by calling p4_revert(f) on each file that was
> flagged as edited and then it will return False so the calling method
> may continue as it does in existing failure cases.

The githooks(5) page should talk about some of these, I would think.

>  git-p4.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 40d9e7c594..1f8c7383df 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
>          tmpFile.write(submitTemplate)
>          tmpFile.close()
>  
> +        # Run the pre-edit hook to allow programmatic update to the changelist
> +        hooks_path = gitConfig("core.hooksPath")
> +        if len(hooks_path) <= 0:
> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> +
> +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")
> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
> +            for f in editedFiles:
> +                p4_revert(f)
> +            return False
> +
>          if self.prepare_p4_only:
>              #
>              # Leave the p4 tree prepared, and the submit template around
>
> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
