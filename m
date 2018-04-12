Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 441321F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeDLXzS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:55:18 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:44924 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeDLXzR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:55:17 -0400
Received: by mail-yb0-f176.google.com with SMTP id m185-v6so3122513ybm.11
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P4BSLKDKKyTDYBFxQKSmTn+RfHkOjPPOE/O1joyHRnM=;
        b=LeejdgM8kehuNPfJRsOR+xfeH2CtHg+tNbryf/JCwLy9ZsJKLTgz9gy1DVVP8vTL92
         HqUleaLlH7LTh594Bi2Wa4VAP/B4LDmI7iWH5WbjJkMFNhC3r1VjYEXKhAHC3xFJAtvt
         XWNfrjlFaJd57asU0hF6rsBMHGInvdF6VdjRe5aP692SigfC0SWz0Vmu0cRveMSJHErF
         lcvxjrkKnlNOFVsTtvtHpmPsW0xISJpPAzXYfJLeddT1N42x9DG/uQl/lTa15tQPzOJP
         Irb8qtOPAeLbmEwLdkuaBaw4al7k5gCJa9kkLaHmYeHUe9uMXVmOLpXxaFKgDdgBjDvx
         9pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P4BSLKDKKyTDYBFxQKSmTn+RfHkOjPPOE/O1joyHRnM=;
        b=iwNjAFsyYUjlGb1k4CXL89BD8KLTyTdPp5tScbsBQ1iJ6z0kb4y6npbLUW2FZyOr11
         9/V4MbDNMPf56Wc8L+e+SiyvJgs729Vyoa2v9rA2jlvuaayCIAq3ZZR2uy4FEZtZyHnH
         VknH+a2lg4sXCkE6EYurgcUgwUMSKZs1BNiElMlp1DAkqs7USZkB+AeZTH+s97OhpNrk
         12+TYlwvprvIArz7p88o49Zo4n7Tyak9YevbhjWrN2AVeinnsd+qWN1DCcwsU/ODENn3
         SfrLzGO6s99YhgoiPfqPU489St1YpQeWyr3vX/DpO/I38bfOJcAPyw6nsbECOqon3Chn
         QmdA==
X-Gm-Message-State: ALQs6tAawkEsa8vQKi4OatMz1sSh7fBtzPyXO0XwsKQJwcPqaf/0Tv0A
        ul9PwaPWYulIaOoWhcupsa4riwhcbp2UgAieLz9mrA==
X-Google-Smtp-Source: AIpwx48zNnUYVTf6X+WKaUHJSqUCazTLp0OTtRFub9xmuxjKBwsq18Q99R3QrvCHSiEKtL8sOtS7rnU1C2IEaAO/zfY=
X-Received: by 2002:a25:ba51:: with SMTP id z17-v6mr2251361ybj.334.1523577316462;
 Thu, 12 Apr 2018 16:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 12 Apr 2018 16:55:15
 -0700 (PDT)
In-Reply-To: <20180412222047.5716-3-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it> <20180412222047.5716-3-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Apr 2018 16:55:15 -0700
Message-ID: <CAGZ79kbnc17PZ9_=8QLkZgUZ0DHJKfWnxrekmgkLGFBU_0ieug@mail.gmail.com>
Subject: Re: [RFC 02/10] submodule: fix getting custom gitmodule file in fetch command
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

the subject line could also be
  fetch: fix custom submodule location
as I was not expecting this patch from the subject line.

On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> Import the default git configuration before accessing the gitmodules
> file.
>
> This is important when a value different from the default one is set via
> the 'core.submodulesfile' config.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  builtin/fetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index dcdfc66f0..d56636f74 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1428,8 +1428,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>         for (i = 1; i < argc; i++)
>                 strbuf_addf(&default_rla, " %s", argv[i]);
>
> -       config_from_gitmodules(gitmodules_fetch_config, NULL);
>         git_config(git_fetch_config, NULL);
> +       config_from_gitmodules(gitmodules_fetch_config, NULL);

Wouldn't this break the overwriting behavior?
e.g. you configure a submodule URL in .gitmodules and then override it
in .git/config,
then we'd currently first load config from the modules file and then override it
in git_config(git_fetch_config,..), whereas swapping them might have
unintended consequences? Do the tests pass with this patch?
