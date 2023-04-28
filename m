Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C27EC77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbjD1WbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbjD1WbM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 18:31:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93046B7
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:31:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f6dd3b329so7972697b3.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682721070; x=1685313070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=diZJo7blTk6ex5D4gc16NhlWzxyMw3EnBt4V/vEUC6E=;
        b=DLwaKTyzNHFe1GQ+JeizggQpkMfqhVOzuOYywCsRGZkzXhRsXXr0tP2khf+DhylopF
         AIC8koLEEx2L4GzH4MwXYPRXfRUJi0trOr7wssCLmefLKVPoZ3e12hUHP2ze9wHqL1ye
         QNg7IvUm5mVJLtzdXLB1pRzGCgn2hIQTX0sbRJBtUyJ6k0SeKfJ6h767WQbs/LQpLmol
         3mlXRqsHSavcPasNr9nhvUyaZPezlIF/tXlyyIKx5EUCtpuIzo3CRRsMsxvpqG4Kwtz+
         ChDT+/k0uBzgShhIaCuqTg0pY1fFgLz3irbBfYBg+n0I3HEaP9htEnbAb7tlmg7J5yRz
         Bb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721070; x=1685313070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=diZJo7blTk6ex5D4gc16NhlWzxyMw3EnBt4V/vEUC6E=;
        b=LGDA99BqFzZS/DprbImUvUe8ovboruD/xLprYeZ3uayHpAnbApd9rX6unvtD/qk0Df
         P1uMhb8SOmoqZUQzqdXof5ISD5cyQRTlldvrWc20vDEuBg4HycLx6OSyrNVftGTAFQw+
         L70gzIww+jeEnUFYRfAaO126zM/VAONNbM9GctqGEmDcEuyQwGXClD7Zot3RWR+5zU3i
         5D3QdHwYaOyKl74CSVEUzqwSDF+OCRMtonYFw2NXEh90WvYaOL48TurJmNIe9KIYUTcG
         9q4DZN2MqT5gPOEC+gfi5WBYe5JxV8PStbYaZOKWNIZR1+1zqzV3s/7CuUsxJ/XcVp99
         I1Gg==
X-Gm-Message-State: AC+VfDzQncv1XaWcVUliwHj0ueWxnjHkrg+ERkHtnckdTFVLsk/ivvCx
        JuEH4izh18BohR1V/wjQ8kG2pYzN/LOJEQ==
X-Google-Smtp-Source: ACHHUZ63h9XWd1IPeqi4EpqnhYQmMWgjN3FVrTvqLfdfVuomsNKEstFxnXFS0eA/1wgVRlaTcq9teUaozh8V8w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:c406:0:b0:552:e74d:318e with SMTP id
 j6-20020a81c406000000b00552e74d318emr4072354ywi.7.1682721070474; Fri, 28 Apr
 2023 15:31:10 -0700 (PDT)
Date:   Fri, 28 Apr 2023 15:31:08 -0700
In-Reply-To: <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im> <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
Message-ID: <kl6l5y9f3ahf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -1894,6 +1902,9 @@ static int fetch_multiple(struct string_list *list, int max_children)
>  		     "--no-write-commit-graph", NULL);
>  	add_options_to_argv(&argv);
>  
> +	if (format != DISPLAY_FORMAT_UNKNOWN)
> +		strvec_pushf(&argv, "--output-format=%s", display_formats[format]);
> +

I think these lines belong inside add_options_to_argv(), since that's
also used to prepare argv for fetch_submodules(), so we'd also get
support for --recurse-submodules. (I wish I had spotted that in v1,
sorry. Thankfully they use the same helper function, so we only have to
do this once.)

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
  diff --git a/builtin/fetch.c b/builtin/fetch.c
  index 422e29a914..7aa385aed5 100644
  --- a/builtin/fetch.c
  +++ b/builtin/fetch.c
  @@ -1796,8 +1796,11 @@ static int add_remote_or_group(const char *name, struct string_list *list)
    return 1;
  }

  -static void add_options_to_argv(struct strvec *argv)
  +static void add_options_to_argv(struct strvec *argv,
  +				enum display_format format)
  {
  /* Maybe this shouldn't be first, idk */
  +	if (format != DISPLAY_FORMAT_UNKNOWN)
  +		strvec_pushf(argv, "--output-format=%s", display_formats[format]);
    if (dry_run)
      strvec_push(argv, "--dry-run");
    if (prune != -1)
  @@ -1908,10 +1911,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
    strvec_pushl(&argv, "-c", "fetch.bundleURI=",
          "fetch", "--append", "--no-auto-gc",
          "--no-write-commit-graph", NULL);
  -	add_options_to_argv(&argv);
  -
  -	if (format != DISPLAY_FORMAT_UNKNOWN)
  -		strvec_pushf(&argv, "--output-format=%s", display_formats[format]);
  +	add_options_to_argv(&argv, format);

    if (max_children != 1 && list->nr != 1) {
      struct parallel_fetch_state state = { argv.v, list, 0, 0 };
  @@ -2403,7 +2403,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
      if (max_children < 0)
        max_children = fetch_parallel_config;

  -		add_options_to_argv(&options);
  +		add_options_to_argv(&options, display_format);
      result = fetch_submodules(the_repository,
              &options,
              submodule_prefix,

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

I tested the result of that locally with --recurse-submodules, and
it works.
