Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E95C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5ED64F6D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 21:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhBCVpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 16:45:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64248 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBCVpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 16:45:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73FD011B167;
        Wed,  3 Feb 2021 16:44:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tWevw5FDEvo89blQnWHWH69Cfl4=; b=yZT6Yg
        bESfmV2+UFcSSTfdy5I11MKr1vMzmW1Mn7FPXBdIPpkdKg28O6s4LeF0O68DYWch
        ZOswdQBIXTHRzI/9kz7mB/8XaqQF73f0km6gn34GziNmVvqVFRPNLW7xqkNe43cS
        qkCAqrlh+brCkNUG6ZwZF019L/QhjFWz736J0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JDz6bSbna5pvfor0QDtfORvw4Bybl1TC
        rEuUobiLqhO2yw8md7xdkZjFf1wgBlGxkr7SeT9ZdCja/7+Vw+3okKuqdBsFx6nA
        GvhOfmTFRldKKxBjXsTX5fCPZFlAZY+6LaCfUXRnYeCf8nRdHPKevpdsSrLedxen
        ADgHWVPjNlE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C12811B166;
        Wed,  3 Feb 2021 16:44:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC82411B164;
        Wed,  3 Feb 2021 16:44:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Feiyang via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Feiyang <github@feiyangxue.com>,
        Feiynag Xue <fxue@roku.com>, Ben Keene <seraphire@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: handle non-unicode characters in p4 cl
References: <pull.864.git.1612371600332.gitgitgadget@gmail.com>
Date:   Wed, 03 Feb 2021 13:44:10 -0800
In-Reply-To: <pull.864.git.1612371600332.gitgitgadget@gmail.com> (Feiyang via
        GitGitGadget's message of "Wed, 03 Feb 2021 16:59:59 +0000")
Message-ID: <xmqqpn1gbzdh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F45B45C2-6668-11EB-B941-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Feiyang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Feiynag Xue <fxue@roku.com>
>
> P4 allows non-unicode characters in changelist description body,
> so git-p4 needs to be character encoding aware when reading p4 cl
>
> This change adds 2 config options, one specifies encoding,
> the other specifies erro handling upon unrecognized character.
> Those configs  apply when it reads p4 description text, mostly
> from commands "p4 describe" and "p4 changes".
>
> Signed-off-by: Feiynag Xue <fxue@roku.com>
> ---

Adding a few people who had meaningful (read: needs some Perforce
knowledge) changes to this part of the codebase to Cc: to ask for
their reviews.

>     git-p4: handle non-unicode characters in p4 changelist description
>     
>     P4 allows non-unicode characters in changelist description body, so
>     git-p4 needs to be character encoding aware when reading p4 cl.
>     
>     This change adds 2 config options: one specifies encoding, the other
>     specifies erro handling upon unrecognized character. Those configs apply
>     when it reads p4 description text, mostly from commands "p4 describe"
>     and "p4 changes".
>     
>     ------------------------------------------------------------------------
>     
>     I have an open question in mind: what might be the best default config
>     to use?
>     
>     Currently the python's bytes.decode() is called with default utf-8 and
>     strict error handling, so git-p4 pukes on non-unicode characters. I
>     encountered it when git p4 sync attempts to ingest a certain CL.
>     
>     It seems to make sense to default to replace so that it gets rid of
>     non-unicode chars while trying to retain information. However, i am
>     uncertain on if we have use cases where it relies on the
>     stop-on-non-unicode behavior. (Hypothetically say an automation that's
>     expected to return error on non-unicode char in order to stop them from
>     propagating further?)
>     
>     ------------------------------------------------------------------------
>     
>     I tested it with git p4 sync to a P4 CL that somehow has non-unicode
>     control character in description. With
>     git-p4.cldescencodingerrhandling=ignore, it proceeded without error.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-864%2Ffeiyeung%2Fdescription-text-encoding-handling-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-864/feiyeung/description-text-encoding-handling-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/864
>
>  Documentation/git-p4.txt | 13 +++++++++++++
>  git-p4.py                | 12 +++++++++++-
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b424c..01a0e0b1067 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -638,6 +638,19 @@ git-p4.pathEncoding::
>  	to transcode the paths to UTF-8. As an example, Perforce on Windows
>  	often uses "cp1252" to encode path names.
>  
> +git-p4.clDescEncoding::
> +	Perforce allows non-unicode characters in changelist description. 
> +	Use this config to tell git-p4 what encoding Perforce had used for 
> +	description text. This encoding is used to transcode the text to
> +	UTF-8. Defaults to "utf_8".

Would it still work if you replaced "utf_8" here with "UTF-8"?  If
we can use "UTF-8", this description (and the code that does so)
would read much less awkward, I would think.

> +git-p4.clDescNonUnicodeHandling::
> +	Perforce allows non-unicode characters in changelist description. 
> +	Use this config to tell git-p4 what to do when it does not recognize 
> +	the character encoding in description body. Defaults to "strict" for 
> +	stopping upon encounter. "ignore" for skipping unrecognized
> +	characters; "replace" for attempting to convert into UTF-8. 
> +
>  git-p4.largeFileSystem::
>  	Specify the system that is used for large (binary) files. Please note
>  	that large file systems do not support the 'git p4 submit' command.
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93ac40..abbeb9156bd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -206,6 +206,13 @@ def decode_path(path):
>                  print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
>          return path
>  
> +def decode_changlist_description(text):
> +    """Decode bytes or bytearray using configured changelist description encoding options
> +    """
> +    encoding = gitConfig('git-p4.clDescEncoding') or 'utf_8'
> +    err_handling = gitConfig('git-p4.clDescEncodingErrHandling') or 'strict'
> +    return text.decode(encoding, err_handling)
> +
>  def run_git_hook(cmd, param=[]):
>      """Execute a hook if the hook exists."""
>      if verbose:
> @@ -771,7 +778,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
>                  for key, value in entry.items():
>                      key = key.decode()
>                      if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> -                        value = value.decode()
> +                        if key == 'desc':
> +                            value = decode_changlist_description(value)
> +                        else:
> +                            value = value.decode()
>                      decoded_entry[key] = value
>                  # Parse out data if it's an error response
>                  if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
>
> base-commit: e6362826a0409539642a5738db61827e5978e2e4
