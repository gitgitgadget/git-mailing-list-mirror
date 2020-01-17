Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F3C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E1B2072B
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XSKktfRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgAQVAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:00:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56298 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbgAQVAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:00:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AF549F4F8;
        Fri, 17 Jan 2020 16:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKPcegrHG3WWnDlsaK3yJd7k3mk=; b=XSKktf
        Rg4Wc8JvJB4cfQRAGRxBlNfcYxSz/hslmv9Gr0OrkWaJC3Ds32fBx5qNTh7GfnrU
        XzQ/XjitMd+0NgVZhcWySIku4ShVUVl6FwNrwcnIfM2uWfvuX0JFG8S+n+5haBLX
        eAWq4MLDZV+AHPPxuv0Orwo3b47eXQLZdTdN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=biIXAuQ2K9EeIT9VZ+mbc121xZuwLSj2
        NGdtKBWWpjXAU70v966Vm3Pe/SFCbvRW5qWdVVdbsNqfHSDjDQHC8P9OL0iNCvmx
        UM5uPsE75GXMSAS6/J/+4oCfvmxidsjxD+fwxS/JzcdAsg4m1J/kPmc5ks+CTnYd
        W0hN1VCj8aA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 035739F4F7;
        Fri, 17 Jan 2020 16:00:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 286149F4F2;
        Fri, 17 Jan 2020 16:00:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v3 3/4] config: clarify meaning of command line scoping
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
        <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <97b8a7641d1ae76b9b4766a8f96c77af1aff55f5.1579275102.git.gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 13:00:42 -0800
In-Reply-To: <97b8a7641d1ae76b9b4766a8f96c77af1aff55f5.1579275102.git.gitgitgadget@gmail.com>
        (Matthew Rogers via GitGitGadget's message of "Fri, 17 Jan 2020
        15:31:41 +0000")
Message-ID: <xmqqwo9pdchx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D550B46-396C-11EA-96EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Matthew Rogers <mattr94@gmail.com>
>
> CONFIG_SCOPE_CMDLINE is generally used in the code to refer to config
> values passed in via the -c option.  Options passed in using this
> mechanism share similar scoping characteristics with the --file and
> --blob options of the 'config' command, namely that they are only in use
> for that single invocation of git, and that they supersede the normal
> system/global/local hierarchy.  

All of the above justifies why it makes sense to treat --file,
--blob and "git -c VAR=VAL" as the same scope (i.e. it would have
been a nice part of log message of the commit that introduced
SCOPE_CMDLINE), but that is not something we need to justify
now---we have such a scope for one-shot settings and these three
sources are already treated as the same class.

> This patch introduces
> CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
> CONFIG_SCOPE_CMDLINE redundant.

The change in this commit is to rename CMDLINE to COMMAND.  That is
what the proposed log message for this step must justify.

	We internally use CONFIG_SCOPE_CMDLINE for the scope for the
	configuration variables that come from "git -c VAR=VAL",
	"git config --file=FILE" and "git config --blob=BLOB".  As
	we are going to expose the scope names to end-users in the
	next step, let's rethink the half-cryptic "cmdline" and
	instead use a proper word "command" (the settings from three
	sources in this scope are all in effect only during a single
	invocation of a git command).

or something like that.


> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
>  		return "repo";
>  	case CONFIG_SCOPE_WORKTREE:
>  		return "worktree";
> -	case CONFIG_SCOPE_CMDLINE:
> -		return "cmdline";
> +	case CONFIG_SCOPE_COMMAND:
> +		return "command";

The only externally observable effect of this patch is this output
string from test-tool and we are not breaking end-user experience,
but I am not sure if this churn is worth it.  I dunno.

In any case, the change to t1308 we saw in the previous step belongs
to this step, I think.
