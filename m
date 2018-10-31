Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A391F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeJaNvA (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:51:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbeJaNvA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:51:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so14979651wrn.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ph2D9U69boZ/Om3oobtFljdrmrwt20Z6j222QpMbQyk=;
        b=laVSMtMwntNw4pvjhuzimqxvJRnEa87Bqswep3RLx8RFRS6G+y/CsbdMukfp1pG2bN
         jxxvWkqZ+9c8KGHUoS4BIRJ79gy1x7U+imE1JXDnMqGmbvHcDHhwSli2ylvcGV8xuxP6
         gdCau7vM/jEW4y9pXs2zUIQNl02y8oCDgecrnuIDo930tBifz1Aoo+w7QBIHV+zE4vp2
         D3sCgRN8zthF4N6Vh2SjgFm9gAdlzZPWUvuDLb7M9BSGA7HmTCzT26ErvZfCHHbgcL4z
         DbCj0T2cHfb8lMCsyWczxENQCvygZZ7FothZJyZm+Zz5klTXxh9J4iFU6NdG7cBg8VZV
         L/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ph2D9U69boZ/Om3oobtFljdrmrwt20Z6j222QpMbQyk=;
        b=JrLHNfLs+88+PrDtLD2MIM8rj9Tq52XhyFNkqkkWmp69kelI3QiqItdtEKjzIlNNSg
         qdo14gk8HGZd5/fdOiIPZrfx03wt8U1vtSzIc4sPgv60hivBDNWFpyaDxSBYc6T8rYw9
         mhAv/Jh5Tmbp93aAKwrChN2q6WMMW8d0j2JmROPo48gosp51GifwTVKPkA6fCMUYC/nM
         a6Fr2Xr2+ECFXa41VvKUmY9GOcG/8hSWR76Gj1i5Q9zOMEvdq0QwdF0x9Q78fJ8nPHKS
         /TRe2EAHzxV3ib69x8BuIrcNO6Wkq9Pghc7fmnipaZjZkQkiubPAyzqRSvFfsgO/V9p0
         bUhQ==
X-Gm-Message-State: AGRZ1gI61OQxELD0ZQEvURXj+Ty4uOa79SMX3dDp/5YA34f+LynEpHyj
        f9N9kj92oR8IIS3yxWMvYjE=
X-Google-Smtp-Source: AJdET5d3a9oV1bVbpOryYko/6zVkjXb2oFbaH0uKEHREllXTfE99L4fNZltAXQHXnFU5gAc3CEu6GA==
X-Received: by 2002:a5d:4907:: with SMTP id x7-v6mr518750wrq.272.1540961671684;
        Tue, 30 Oct 2018 21:54:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2375211wrd.61.2018.10.30.21.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:54:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "chris via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chris <chris@webstech.net>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Oct 2018 13:54:30 +0900
In-Reply-To: <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
        (chris via GitGitGadget's message of "Tue, 30 Oct 2018 11:26:36 -0700
        (PDT)")
Message-ID: <xmqqsh0mwwah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"chris via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: chris <chris@webstech.net>
>
> Use File::Spec->devnull() for output redirection to avoid messages
> when Windows version of Perl is first in path.  The message 'The

Dscho, "Windows version of Perl is first in path" somehow feels
contradicting with what one of the topics I saw from you were trying
to enforce (or, at least, "set as the supported configuration").

I am guessing that the Perl you are building and shipping with Git
for Windows would yield what the shell that ends up running the
scriptlet `git config --get-color $key` prefers when asked for
File::Spec->devnull(), and nothing will break with this patch even
if that is "/dev/null", but I thought I'd double check.

Thanks.

> system cannot find the path specified.' is displayed each time git is
> run to get colors.
>
> Signed-off-by: Chris. Webster <chris@webstech.net>
> ---
>  contrib/diff-highlight/DiffHighlight.pm | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
> index 536754583..7440aa1c4 100644
> --- a/contrib/diff-highlight/DiffHighlight.pm
> +++ b/contrib/diff-highlight/DiffHighlight.pm
> @@ -4,6 +4,11 @@ use 5.008;
>  use warnings FATAL => 'all';
>  use strict;
>  
> +# Use the correct value for both UNIX and Windows (/dev/null vs nul)
> +use File::Spec;
> +
> +my $NULL = File::Spec->devnull();
> +
>  # Highlight by reversing foreground and background. You could do
>  # other things like bold or underline if you prefer.
>  my @OLD_HIGHLIGHT = (
> @@ -134,7 +139,7 @@ sub highlight_stdin {
>  # fallback, which means we will work even if git can't be run.
>  sub color_config {
>  	my ($key, $default) = @_;
> -	my $s = `git config --get-color $key 2>/dev/null`;
> +	my $s = `git config --get-color $key 2>$NULL`;
>  	return length($s) ? $s : $default;
>  }
