Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095101F461
	for <e@80x24.org>; Thu, 27 Jun 2019 04:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfF0Eul (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 00:50:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38248 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfF0Euk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 00:50:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so4197556wmj.3
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 21:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3OeQ5s8pOLIUXFBu4OI1v0CnJnTURdrss8rMBsWS0w=;
        b=hcoC+4GhDlMtqJknDl/I2FROiLktl2aKf/ivOv9KQHvOAI5psvPQxZlx1G6uEV56LY
         TOyrCOiVMXcNbBcIJSm4EP6ft/tXKCUsIn0Bs2d1dxTvTXb3E120kLJrIyuS/igCovtn
         9SNWh1S2kl55AkA53/FYECehH25PiAJZBn7M3uyzGUWQ1dvDOOxoPuk38XpN4L6VflcD
         bZbxDzw4L2jPmMZDCNz+8Ode1UzqLmDnKMxqEtBobZZXEo9NtYr6Lilch22nskteVTkB
         7AuYxFH+aIZMMU4dpIFTCgkHVojsXb+VKzQ7lGZiWs1ecegT3GOEXWNf6GFjSo2rUlwe
         A73Q==
X-Gm-Message-State: APjAAAXSDLnzCHL+FgY9Y851QMbut5hswAJXkH0whGvgwDFHcldtw2G5
        +1ZlEt+vTNv1jKdXcvyp570+BJT4ppbQKBgLeXQ=
X-Google-Smtp-Source: APXvYqxDuZgzd9j/bNtrXl9cUkKifzybwFuPT7+q0+VojiocF4U0TgEqJEdljr/Lw6eTWM76SpJG1RbAxZ4rFU9o6Dc=
X-Received: by 2002:a1c:f319:: with SMTP id q25mr1447778wmq.129.1561611038721;
 Wed, 26 Jun 2019 21:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com> <20190626235032.177551-3-emilyshaffer@google.com>
In-Reply-To: <20190626235032.177551-3-emilyshaffer@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 27 Jun 2019 00:50:28 -0400
Message-ID: <CAPig+cTk9=sd7iqwDT=ynRuAvyh3gj3NKQwkv9_tBo1v28Xysw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] walken: add usage to enable -h
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> It's expected that Git commands support '-h' in order to provide a
> consistent user experience (and this expectation is enforced by the
> test suite). '-h' is captured by parse_options() by default; in order to
> support this flag, we add a short usage text to walken.c and invoke
> parse_options().
> [...]
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> diff --git a/builtin/walken.c b/builtin/walken.c
> @@ -5,9 +5,34 @@
>  int cmd_walken(int argc, const char **argv, const char *prefix)
>  {
> +       [...]
> +       /*
> +        * This line is "human-readable" and we are writing a plumbing command,
> +        * so we localize it and use the trace library to print only when
> +        * the GIT_TRACE environment variable is set.
> +        */
>         trace_printf(_("cmd_walken incoming...\n"));

Also, this in-code comment should have been introduced in patch 1/13,
not here in 2/13.
