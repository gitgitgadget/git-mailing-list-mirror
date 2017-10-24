Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69661FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbdJXQ2u (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 12:28:50 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45614 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbdJXQ2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 12:28:32 -0400
Received: by mail-qk0-f196.google.com with SMTP id f199so27008452qke.2
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7t5k7wmYEgJy0CcJz1WUhiED2knAUn1sW2BdXAoiJnY=;
        b=ZRmInsamNv2IHX7GRxPIcD9lkZeOtf2CFj4h7mk/hr3h9Ca7ab34v8Mto01pN7qgQ1
         BrMj4Xdr1aE0EOq9A00je+gUUfBp4xXZ3ecyxXWtpaEFygK5MALYnJqUhLzNr74gGEcA
         jogbbL/QlOZiflPWU1I7aZ6WZPvRIyrnOUp41jDl6sw44eTmisGNYLzhdCVfS+IA1D4s
         nAAaK8gd7yVjVp+SNGl69V+fq0i61WskhJixy8eTUL35pDF5jh0TVOLxlMAI34d3julJ
         q71tWDFDAaSOHy7649hO09FIv1gGHgJQXJ/w76nUcYWNqeSSW3HJ38uwFD2K+A7JGzJe
         +GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7t5k7wmYEgJy0CcJz1WUhiED2knAUn1sW2BdXAoiJnY=;
        b=R9oidBfY9PbxwoRag+vWlTUnPmjwqgOpx5YT5YWIx5y5kGl3+GByVRC8mSvPVgOTnZ
         Vi5zo66vbbdE2NrIY/kup38I/5lLdxJrW5X9laJeqkEA8RnKmLH96b/O/iTjmSmOu6Z/
         jubbjdszmoundvu30ON3dh3E6PAYIfCc0jWtd7xY/4swF6XLn4DP0HXF7HMBrKovkHRk
         DWJnsFxYrOtpgM+P9D1HssSlTnYjCfyQTflWK17FBl9qo2c2/s3IXsJCO03SeuvwyuiG
         4lbfr6svaJeYlsb++KGUC3+/X28wrtpozV2EZXVCdwnpWuuUR3blRkiNOlVzUrO7ELPa
         VFRg==
X-Gm-Message-State: AMCzsaUuF+Kv84MzsgjwQYmKISag4W40W3L0Q17D/gqRx+u6y2KwVxRB
        MaMpHvWeXHHTNHsoTGMNzG9lLAP2/YnXl72j++LXpg==
X-Google-Smtp-Source: ABhQp+SigK1ZWbzz1yJDzZvnJCHaNHpe+E4ovou3pDi/e9ZEnA1omUvdxsoCwsPK7+So7P8Grxh1H99ZCn8P321dFRY=
X-Received: by 10.55.129.70 with SMTP id c67mr25677583qkd.230.1508862511732;
 Tue, 24 Oct 2017 09:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 24 Oct 2017 09:28:31 -0700 (PDT)
In-Reply-To: <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Oct 2017 09:28:31 -0700
Message-ID: <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        vmiklos@frugalware.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 8:27 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
> Add check of 'GIT_MERGE_VERBOSITY' environment variable only once in
> init_merge_options().
> Consequential call of getenv() may return NULL pointer and strtol() crashes.
> However the stored pointer to the obtained getenv() result may be invalidated
> by some other getenv() call from another thread as getenv() is not thread-safe.

But do we have other threads running at the time?
Inspecting the four callsites:
* sequencer.c:
  The prior lines to hold the index lock suggests we're not in a threaded
  environment
* builtin/merge-recursive.c:
  In cmd_merge_recursive and we're fiddling with argv/argc, which
  suggests we in a main function, not having threads around
* builtin/am.c: fall_back_threeway called by am_run.
  (am is not threaded)
* builtin/merge:
  In try_merge_strategy called from the main function, also index locking
* builtin/checkout.c:
  merge_working_tree also locks the index.

So I think this function is never called from within a threaded environment
in git.

>
> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> ---
>  merge-recursive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb8..eaac98145 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>
>  void init_merge_options(struct merge_options *o)
>  {
> +       const char *merge_verbosity = getenv("GIT_MERGE_VERBOSITY");

Despite not being in a threaded environment, I wonder if we want to
minimize the time between  calling getenv and the use of the result,
i.e. declare merge_verbosity here, but assign it later, just before the
condition?

(The compiler may shuffle stuff around anyway, so this is a
moot suggestion; It gears mostly towards making the code more
readable/maintainable when presenting this part of the code
to the user.)

With or without this change:
Reviewed-by: Stefan Beller <sbeller@google.com>


>         memset(o, 0, sizeof(struct merge_options));
>         o->verbosity = 2;
>         o->buffer_output = 1;
> @@ -2171,9 +2172,8 @@ void init_merge_options(struct merge_options *o)
>         o->renormalize = 0;
>         o->detect_rename = 1;
>         merge_recursive_config(o);
> -       if (getenv("GIT_MERGE_VERBOSITY"))
> -               o->verbosity =
> -                       strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
> +       if (merge_verbosity)
> +               o->verbosity = strtol(merge_verbosity, NULL, 10);
>         if (o->verbosity >= 5)
>                 o->buffer_output = 0;
>         strbuf_init(&o->obuf, 0);
> --
> 2.14.3
