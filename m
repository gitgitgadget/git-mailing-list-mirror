Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9ED20248
	for <e@80x24.org>; Thu,  7 Mar 2019 08:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCGIBT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 03:01:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGIBS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 03:01:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so16243570wrg.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 00:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jYgfi24PgFrPGEkgOIFNn58DABXHQX0S92V0ZsHVAto=;
        b=b7I4tJTkPh1NzSfkRIDdHAFbVaIXD3n1RRAWOZeFRxk/VEtolLW5UvSKoju8dhvriJ
         MRvubvrhviGcc8BG7lIfndrRPPb8eVeX8Nl61TvNflTBZ+A5jSyDJ0LmLjgcecup8TCd
         t3TYdX8ObFC6GGaMOPaxWRWZp5pZWd3ZP4ISfnbe+8ZBHB56ncOYHM5dvXE/O2Wc+H3H
         jGSpSa4d3dOwDfGiEmx6PE6/iWFH9fvrvtsLioJodvib+D8cUx3567vpbMpKk5ByxikC
         nfzlthjKjP1OudydTEd7Z23ajyRNLRsGNC0S+XJfhn75pvCvFptbt+2VdqJiEHbMOaf3
         ebRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jYgfi24PgFrPGEkgOIFNn58DABXHQX0S92V0ZsHVAto=;
        b=eCJk5aaUD1mkg9H2i+Df0xtSV7Ef6nZT8X8CMuhImrJgFmWDTYV7OKBK4DukKiER2X
         ywCwDkfXRVPdJVK8FFm0Bu4hRkMqY+ZkW70W6P1wdplKdjX2wzTw35Z1ILdYICZUcr1t
         Wk7ZJ9u8Q9uOYbXbRGtHPLbdM+owUftqC64AtfLaO7D1rBeZPXo3P25vMPXfBC19Ecqd
         nFGfWAusoZYMBic2WjwWRuUQCb9kCAieETHZ5Addm5qPTk231zTulFUdubAlozNEjlM4
         VX0ZHDUUV8/B40LcjOI1eQMD/VjcKj5FLYT5ZaxDwrLBQx60bjHut+tYk/Y6hb7JWGkd
         RVUw==
X-Gm-Message-State: APjAAAUenvFSFwDBTQRziAnrL0OpS4Ni1effp+gU/PvmUMyOGTfFbLHH
        YeOqVPg3hVamNt9nEQ/2AC0=
X-Google-Smtp-Source: APXvYqznA46DgcyiMQjYmAPSRvktnOU5/QjN/P38uEajQxuOu0KBB56bH/n+VoYdBFhmwhdTqEceZw==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr6319431wrq.149.1551945676847;
        Thu, 07 Mar 2019 00:01:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j8sm8015245wro.52.2019.03.07.00.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 00:01:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/3] sequencer.c: don't die on invalid cleanup_arg
References: <cover.1551867827.git.liu.denton@gmail.com>
        <cover.1551940635.git.liu.denton@gmail.com>
        <f3af8000aec51e49f3fe8f90dbfec61606596b2e.1551940635.git.liu.denton@gmail.com>
Date:   Thu, 07 Mar 2019 17:01:15 +0900
In-Reply-To: <f3af8000aec51e49f3fe8f90dbfec61606596b2e.1551940635.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 6 Mar 2019 22:44:28 -0800")
Message-ID: <xmqq5zsvm7uc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When get_cleanup_mode was provided with an invalid cleanup_arg, it used
> to die. Warn user and fallback to default behaviour if an invalid
> cleanup_arg is given.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  sequencer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5c04bae7ac..f9bdfa90ad 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -502,8 +502,11 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
>  	else if (!strcmp(cleanup_arg, "scissors"))
>  		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
>  				    COMMIT_MSG_CLEANUP_SPACE;
> -	else
> -		die(_("Invalid cleanup mode %s"), cleanup_arg);
> +	else {
> +		warning(_("Invalid cleanup mode %s, falling back to default"), cleanup_arg);
> +		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
> +				    COMMIT_MSG_CLEANUP_SPACE;
> +	}
>  }

In what different contexts does this get called, I wonder?

I think

	$ git cherry-pick --cleanup=bogus ...

should error out, instead of falling back to anything else, while
having

	[commit] cleanup = bogus

in .git/config should *not* say anything if you are not running a
command that does not get affected by the commit.cleanup variable,
and with such a bogus configuration, a command that does use the
variable should either also die, or fallback with a warning.

I have a suspicion that the change is breaking the error detection
done for the command line argument parsing, and if that is the case,
then it is a bad idea.  But I may have misread the code.

Thanks.






