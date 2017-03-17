Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1FD20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdCQRrY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:47:24 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34839 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdCQRrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:47:22 -0400
Received: by mail-pf0-f177.google.com with SMTP id x63so35054174pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=575oc9nBNbsP2GeO1IlDEHCXWwDckDHUat5arxUEJJI=;
        b=A6XvPyuaZQNeubSRBROK+qqvVaX7B+vJ7D5Wu6pHdo3pLiWRWmw2/p2fPPAx8CHYKC
         EAofKeyYLSqLstgKnbq/EfuUbDDU4JaSHshZm7Kts100z7+Y2oUSgCcRur9goBijf78S
         gSb2pZ6JRBJSkQ54vnizqRipo9SdrfSQqB52KefAuFXbUuvOwqiEc+STdK4lZ/xwD7aD
         gVHOkMVRiJ354r3cm9ilNIp6BjBG6Qq3dHu1iqXCIGkYKbHynJjnni1T9Gpg3qVvz/oU
         r9aX4XfFK/wibFScCSIO34GH9/eQa+eBkliFotfqEYwSmOs3mmp9WCglLtrSmaVCV6uX
         vZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=575oc9nBNbsP2GeO1IlDEHCXWwDckDHUat5arxUEJJI=;
        b=EFs0WNCFkANXZO+8aXHeo1VUSSziqyolUEoykpwjh1Nbw4vRqqLxuuz6hZUaqUFaHb
         YYDMJzsEb693XQ5iJe8Vz0LtSlLbJnYdkGCSXGGZbwjTLN87hqqTb67uUy3lgy91Xkla
         nJ2UveM1+p67EXXvjMqf5o4jKM2vLn6VCaWbU5nQ4dSdR6B3mMpCfz+64shPLPMF2axS
         0AUZD1kh6qHxIw9PNwF7VtOvrxwy5/SpNLc6Kg4YVj+e1RMfN9rBtLrVMBnlIskJhUH3
         b6rLkxzo7RME7y8SyIMCUJfWD4RQUABBHQj2mmKarFS6S4bCyCZRJEixJ9yZeY/puJd6
         BD8A==
X-Gm-Message-State: AFeK/H2rcLyNzRx6eepsbAsPXyu3boWLzor1UnKUoQRTWq75obFp5yNOQrEtDGgz7MvFk8jaPIaWpaT/JbXPhAdr
X-Received: by 10.84.172.193 with SMTP id n59mr21363943plb.63.1489772259416;
 Fri, 17 Mar 2017 10:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 10:37:38 -0700 (PDT)
In-Reply-To: <20170316222952.53801-9-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com> <20170316222952.53801-1-bmwill@google.com>
 <20170316222952.53801-9-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 10:37:38 -0700
Message-ID: <CAGZ79kbvxpAEzVnNYRQ7VqzY30_oH4FGw3cH0TCwzCwCfy3HZw@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] clone: teach --recurse-submodules to optionally
 take a pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 3:29 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach clone --recurse-submodules to optionally take a pathspec argument
> which describes which submodules should be recursively initialized and
> cloned.  If no pathspec is provided, --recurse-submodules will
> recursively initialize and clone all submodules by using a default
> pathspec of ".".  In order to construct more complex pathspecs,
> --recurse-submodules can be given multiple times.
>
> Additionally this configures the 'submodule.active' configuration option
> to be the given pathspec, such that any future invocation of `git
> submodule update` will keep up with the pathspec.

  Additionally the switch '--recurse' is removed from the Documentation
  as well as marked hidden in the options array, to streamline the options
  for submodules.  A simple '--recurse' doesn't convey what is being
  recursed, e.g. it could mean directories or trees (c.f. ls-tree)
  In a lot of other commands we already have '--recurse-submodules'
  to mean recursing into submodules, so advertise this spelling here
  as the genuine option.

would also be worth mentioning?


>  static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
> -static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
> +static int option_local = -1, option_no_hardlinks, option_shared;
>  static int option_shallow_submodules;
>  static int deepen;
>  static char *option_template, *option_depth, *option_since;
> @@ -56,6 +56,22 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
>  static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
>  static int option_dissociate;
>  static int max_jobs = -1;
> +static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
> +
> +static int recurse_submodules_cb(const struct option *opt,
> +                                const char *arg, int unset)
> +{
> +       if (unset)
> +               return -1;
> +
> +       if (arg)
> +               string_list_append((struct string_list *)opt->value, arg);
> +       else

in this case I'd rather set the removed (int) option_recursive, because, then
we would not need to sort and remove duplicates later on.
Instead we can pass the string list literally to the config setter.
(and in case option_recursive is set, we add an additional single
"." then)

> +               string_list_append((struct string_list *)opt->value,
> +                                  (const char *)opt->defval);
> +
> +       return 0;
> +}
>

>
> -       if (!err && option_recursive) {
> +       if (!err && (option_recurse_submodules.nr > 0)) {

Well, checks like these would become more tangled.
So maybe we could set option_recursive unconditionally
in the callback (unless unset was given, then we reset it to 0)
and later have a check if we need to add "." (when the string list
is empty).

Speaking of unset, this seems like a regression here, as the callback
would error out to "git clone --no-recurse", which is a valid use case
currently? (Searching for "git clone --no-recurse" yields no results
via Google, so maybe this use case is not so valid)

To get the behavior as is for unset we could just clear the string
list instead of returning -1.

Thanks,
Stefan
