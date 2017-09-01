Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B201F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 17:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbdIARLI (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 13:11:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33504 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbdIARLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 13:11:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id s62so3963375ywg.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gf20QdR9QIZZ5XPZ8bQgkciwS7D/9DYukxJJTzzOV/8=;
        b=lPW44A/lTq9J/IkQJBi5KAEneqQA3zGSf9+puppWnuwDTbd5mhu/aL/QiK2WSNhCQy
         gVRdCceCtHj2AumfOygPVVqfeAkN/ra0S1AKRY1geBzMI380MSscyKL7RoOd1ic+ynQV
         Hsg1bkKJCVBiawy9z+9uMnC4Qzx8pUU5xaJLVaSU+6Sm4zCY2VjmRMwKUlXw4M0AEr+g
         oYCvgHwK/0iRZH2v8GFbik5eaelwkP86ijKkokvwwYagBHRv05PnY+zqPgq0WLtNYH3v
         Sm+ZSUbOd2g+5qKuFWkCHuViJlh2R75g6gL/mpCKB13zLMzeKKY8/XWhkmDdtvNIoyOL
         7R5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gf20QdR9QIZZ5XPZ8bQgkciwS7D/9DYukxJJTzzOV/8=;
        b=DQZkM2y6LDYQusSPKYanXgNjXOdnDyaCAL/aBh92Rlo9Zoi+GVDTwP9+zIbQ3AG+JX
         mDEPBPVgNBZNF9ap/+yXuNGPoSGulBfL7NIcnDCqKslBElfx2AGkCLD7OqC9vLQQK1BZ
         0ii6bEJQH7DYE2sS2i+e+iTbM7znwf2hk4E322XnZCTmieaxR28BtCuwmwDZGF9oBUz6
         /irJhyI8wqvGD8MrWbLGyjZcOJ3CmIrKfkYsukU+5Z8Ke9ay8PfEFGktDGPrt150SXwg
         lY+/Y5hRTxZboWRfw76y3ewxNNl8FU1bgOeqnamR9Y71Ep5UrerQrc+InLsdTIxoo0A+
         f3QA==
X-Gm-Message-State: AHPjjUggbVXfq73dHhOuv3TkzBTyIT0b7f13oElIEb0BKc1Q/2Wotxg/
        1vFkcFWiLiZKahPx5E0q19KUUfl7q5EiwUk=
X-Google-Smtp-Source: ADKCNb4r6FXCkM9SA0GS/y1j/VQjCmwi/fpkAg6KtotrLhjt97YKJpCo+gf70TWAjtu65xzSQhrEkksDfiZQ+udbHvU=
X-Received: by 10.37.72.196 with SMTP id v187mr2182864yba.145.1504285866216;
 Fri, 01 Sep 2017 10:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.21 with HTTP; Fri, 1 Sep 2017 10:11:05 -0700 (PDT)
In-Reply-To: <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
References: <eba8e727-25ef-b34b-cd2b-e92602709c9b@homann.se> <cc70ea38-9980-120f-afaa-af7a6e3a8c36@morey-chaisemartin.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Sep 2017 10:11:05 -0700
Message-ID: <CAGZ79kaxSARkh9+PrYB05+Ln=hngu-9_y+UYi=P+M0OzNdedNw@mail.gmail.com>
Subject: Re: [PATCH] pull: honor submodule.recurse config option
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, magnus@homann.se
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 1, 2017 at 12:29 AM, Nicolas Morey-Chaisemartin
<nicolas@morey-chaisemartin.com> wrote:
> git pull used to not parse the submodule.recurse config option and simply
> consider the --recurse-submodules CLI option.
> When using the config option, submodules would only be fetched recursively
> while the CLi option would tigger both fetch and update/merge.
>
> Reported-by: Magnus Homann <magnus@homann.se>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>

Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan


> ---
>  builtin/pull.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7fe281414..e4edf23c5 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -326,6 +326,11 @@ static int git_pull_config(const char *var, const char *value, void *cb)
>                 config_autostash = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "submodule.recurse")) {
> +               int r = git_config_bool(var, value) ?
> +                       RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
> +               recurse_submodules = r;
> +       }
>         return git_default_config(var, value, cb);
>  }
>
> --
> 2.14.1.460.g196d2604f
>
