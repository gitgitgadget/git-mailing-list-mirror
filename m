Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9DC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 14:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6E322525
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aaO47cba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfLEOFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:05:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61734 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLEOFB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 09:05:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7C783AD1E;
        Thu,  5 Dec 2019 09:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/w6FJS7UGsXE+D1Pw0Kb9zICVs=; b=aaO47c
        baRAvJZYWqtk9s7LsiU7uh/4fjWUv7HSkgfmOu7Ff2vTF4GTSjvbtfveJXK/Kjeu
        J1fEXzm9R8AGEGrWIJOVjQgFoN4q6gmEnkTxWK50LA1d/92mqAwlMlEak1Su2jkl
        oCX7Jc1XlUCbG34fTRvnOhM8+nnsrCOFijji0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dI9R2MZ3R1EBFd27bOH7BEw04AaIebBE
        1XYnRzTOUhTqkYOlLloUE+NWGTW5YtZJX84gzo9mXlphqn/ouFC2m14izWgZ6lNK
        asYVSzsB6LVAHvxJX1RwdFDA0D11Uj+3X/2uka6hhGkxrFMVlCAhVt3Y8LxRxWgx
        NsQW+LykEAE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF2D43AD1D;
        Thu,  5 Dec 2019 09:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C62C3AD1C;
        Thu,  5 Dec 2019 09:04:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v4 09/11] git-p4: Add usability enhancements
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <4fc49313f0d68a913ad19085ddb337ac4c18d0fe.1575498578.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 06:04:57 -0800
In-Reply-To: <4fc49313f0d68a913ad19085ddb337ac4c18d0fe.1575498578.git.gitgitgadget@gmail.com>
        (Ben Keene via GitGitGadget's message of "Wed, 04 Dec 2019 22:29:35
        +0000")
Message-ID: <xmqqfthy27hy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 389BC190-1768-11EA-AFC7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ben Keene <seraphire@gmail.com>
>
> Issue: when prompting the user with raw_input, the tests are not forgiving of user input.  For example, on the first query asks for a yes/no response. If the user enters the full word "yes" or "no" the test will fail. Additionally, offer the suggestion of setting git-p4.attemptRCSCleanup when applying a commit fails because of RCS keywords. Both of these changes are usability enhancement suggestions.

Drop "Issue: " and upcase "when" that follows.  The rest of the
paragraph reads a lot better without it as a human friendly
description.

"are usability enhancement suggestions"???  Leaves readers wonder
who suggested them, or you are suggesting but are willing the change
to be dropped, or what.  Be a bit more assertive if you want to say
that you believe these two would improve usability.

> Change the code prompting the user for input to sanitize the user input before checking the response by asking the response as a lower case string, trimming leading/trailing spaces, and returning the first character.
>
> Change the applyCommit() method that when applying a commit fails becasue of the P4 RCS Keywords, the user should consider setting git-p4.attemptRCSCleanup.

s/becasue/because/;

I have a feeling that these two may be worth doing but are totally
separate issues, deserving two separate commits.  Is there a good
reason why these two must go hand-in-hand?


> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit 1fab571664f5b6ad4ef321199f52615a32a9f8c7)
> ---
>  git-p4.py | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index f7c0ef0c53..f13e4645a3 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1909,7 +1909,8 @@ def edit_template(self, template_file):
>              return True
>  
>          while True:
> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> +            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ").lower() \
> +                .strip()[0]

You could have saved the patch by doing

	+	.lower().strip()[0]

instead, no?

I wonder if it would be better to write a thin wrapper around raw_input()
that does the "downcase and take the first meaningful letter" thing
for you and call it prompt() or something like that.

> @@ -4327,7 +4343,12 @@ def main():
>                                     description = cmd.description,
>                                     formatter = HelpFormatter())
>  
> -    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
> +    try:
> +        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
> +    except:
> +        parser.print_help()
> +        raise
> +

This change may be a good idea to give help text when the command
line parsing fails, but a good change deserves to be explained.  I
do not think I saw any mention of it in the proposed log message,
though.

>      global verbose
>      verbose = cmd.verbose
>      if cmd.needsGit:
