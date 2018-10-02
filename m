Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2C51F453
	for <e@80x24.org>; Tue,  2 Oct 2018 20:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJCDDd (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 23:03:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43151 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJCDDd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 23:03:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id a4-v6so3255788eds.10
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 13:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93JaG0Ta8e9d5BgdLLpf80Wj+c8RFT95vlNiCxdmVoI=;
        b=Tcs53y7wqvlHaR9ss/d71nBZniZHrbI0NL4pkU8EFnToODjvNQE+JXGxj47nKpGtQw
         pij/9WB1iu6zJ3ll/yYiWKD1FMPDdwI9hiQxzXveilpM/oepDszVXIbH7V7mOohl4fGF
         VsJX8Kjc8+0PndGbQ1t4LXynHGIjOdhrE4X/dg9Dd72LeawKt8vYghNYp48AqY8pBeL9
         TodNmjq+RNKTAs/shoAmCL7NlbW+5MHpuxWdwaAwt+Y0GnJXJwHh1t95b59UCPPpbtnP
         BBoBkm5tVfHy4YzHdTd8aJ43gHlFa1GBTbX3jqLB/nCcjmMv/rzks9PTTBdjuenE3vSf
         Icog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93JaG0Ta8e9d5BgdLLpf80Wj+c8RFT95vlNiCxdmVoI=;
        b=jYuaalcf7KaPw3szqRN8FQV/suBGgfxOngR4mtvytp59WcXrQ84ouA74STwtA+4I3c
         1Y71vurn+iINMx3G1+AKW0pETBZGySX5FPso/zxFJFw3zl9RJdMp1VZZ6r7zIFvJ5W/6
         pXi7TN6ZKXo7sGXCnAYCg8PFXctO06sKZXqoi1IFKSRprrZLgyxO8mJjVAXNC0qecYuN
         bPpkOkij/Dx42gH+QN5Ulh0FkQqBfDyQHIJIpGrgGM/XScJFebFMY3V6RY/C7AjmSwLP
         dzaTZS5mHQBvDwXDhBULBWMgSTJav7G7Va/FISFlGmFimeyFvl2dYQt1mxfZ9Nm8IiGW
         GByw==
X-Gm-Message-State: ABuFfohf7xEg11mzAcfGYZVBiK3ZuouOnMPiqHzNa4cr6PxSlNcttJs/
        NGOiZrUTysKz4FIi/UoEDQcsHMBF9Ix2tdT0luY=
X-Google-Smtp-Source: ACcGV60XmdJw5+jhGul+0glLCPj3oTO6ANsjNM7veqTu6al9AEzpLcm6E6PPp8rAbM4PaRQZNQVp9aGNJwKgCVmgTCE=
X-Received: by 2002:a50:93c5:: with SMTP id o63-v6mr25998669eda.154.1538511506287;
 Tue, 02 Oct 2018 13:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
In-Reply-To: <20181002200710.15721-1-jacob.e.keller@intel.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Oct 2018 13:18:14 -0700
Message-ID: <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 1:07 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> From: Jacob Keller <jacob.keller@gmail.com>
>
> make coccicheck is used in order to apply coccinelle semantic patches,
> and see if any of the transformations found within contrib/coccinelle/
> can be applied to the current code base.
>
> Pass every file to a single invocation of spatch, instead of running
> spatch once per source file.
>
> This reduces the time required to run make coccicheck by a significant
> amount of time:
>
> Prior timing of make coccicheck
>   real    6m14.090s
>   user    25m2.606s
>   sys     1m22.919s
>
> New timing of make coccicheck
>   real    1m36.580s
>   user    7m55.933s
>   sys     0m18.219s
>
> This is nearly a 4x decrease in the time required to run make
> coccicheck. This is due to the overhead of restarting spatch for every
> file. By processing all files at once, we can amortize this startup cost
> across the total number of files, rather than paying it once per file.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Forgot to add what changed. I dropped the subshell and "||" bit around
invoking spatch.

Thanks,
Jake


>  Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index df1df9db78da..da692ece9e12 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2715,10 +2715,8 @@ endif
>  %.cocci.patch: %.cocci $(COCCI_SOURCES)
>         @echo '    ' SPATCH $<; \
>         ret=0; \
> -       for f in $(COCCI_SOURCES); do \
> -               $(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> -                       { ret=$$?; break; }; \
> -       done >$@+ 2>$@.log; \
> +       $(SPATCH) --sp-file $< $(COCCI_SOURCES) $(SPATCH_FLAGS) >$@+ 2>$@.log; \
> +       ret=$$?; \
>         if test $$ret != 0; \
>         then \
>                 cat $@.log; \
> --
> 2.18.0.219.gaf81d287a9da
>
