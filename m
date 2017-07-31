Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F44F1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdGaVMa (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 17:12:30 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35771 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdGaVMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 17:12:30 -0400
Received: by mail-lf0-f46.google.com with SMTP id t128so89034581lff.2
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8QjES66ufmrF9l8SYXm1vuDDkeu2EFcjWPp0WMOXoS4=;
        b=vPsF5TFkpU/Nlk5vU9QyB2A9DbF/uh5FShHAzFnVT31Yrrtd05wc0xnBQ6VYfIu8sC
         S9FNj3+7HlRDH3cZN5wggGZPZgaBFICwJ5ctkkAAxSEWBItWyQxJKSh017Czy3JLUbt/
         hb8xupW3KW0X6eT5A6Fl4oH3pacdjjln7nRngd/hVlVH34Re32tigAt3A1URmjBfCTD2
         O16JgQ6dy+zTbmYUIAr2mZ9zAi3j4arx+0r9K4awM6IYkwx+/8G1gCFl8/VlxpFrcIpi
         u/LGLq8b3/B8txKorFRhgNQa2iM119pR1DYLkffr/phxKf8kyxOolws4VwkNS9SJ1iWr
         sE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8QjES66ufmrF9l8SYXm1vuDDkeu2EFcjWPp0WMOXoS4=;
        b=lTgg2JHp72cEsRDaVoWV1VV8z0xpCxUOYZ+Z79Bos5b+n7JpjgDuAzHnXDQVzukVo9
         ULUsLpvI3mt3lqckt50YvYWRakn+9SufEswztmZrVTo828kyGk31Iz7Vjn3qUPHD6lq9
         D4uiZ/pvhWSL5ZsHoKJy7EvkAGUdjStNIXYwoR/345x23qmkgynKB2CfR2WaPMOeLAOS
         exQhXa/G2h4QbfMAw1LGhJajR6TUaCfSdtl4gD9TC3RxYA+gwz485Tr8gbcWuO2uc2Mb
         c0D+hmVgLUHCMFeF7NTvqNtXCWEp12C+XDD2f5W5XBtVjaanwbT55TGVaUCT1vQGV5nP
         5h5A==
X-Gm-Message-State: AIVw111dFLReZy9icCWfMJR5B5ceJtcwT2WTQsNLIFLPkxCDNwmXiB1a
        G0IUyNWy7HZ3QaSGe0AmWLUTiNZSP1jU
X-Received: by 10.25.228.206 with SMTP id x75mr4965269lfi.94.1501535548374;
 Mon, 31 Jul 2017 14:12:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Mon, 31 Jul 2017 14:12:27 -0700 (PDT)
In-Reply-To: <20170731205621.24305-5-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com> <20170731205621.24305-5-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 31 Jul 2017 14:12:27 -0700
Message-ID: <CAGZ79kaL48k=tCL-nnzFJBm4Qx2Q9uON=Cv82RhUr4ArG66rDA@mail.gmail.com>
Subject: Re: [GSoC][PATCH 04/13] submodule: port submodule subcommand 'status'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 31, 2017 at 1:56 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule 'status' a built-in. Hence, the function
> cmd_status() is ported from shell to C. This is done by introducing
> three functions: module_status(), submodule_status() and print_status().
>
> The function module_status() acts as the front-end of the subcommand.
> It parses subcommand's options and then calls the function
> module_list_compute() for computing the list of submodules. Then
> this functions calls for_each_submodule_list() looping through the
> list obtained.
>
> Then for_each_submodule_list() calls submodule_status() for each of the
> submodule in its list. The function submodule_status() is responsible
> for generating the status each submodule it is called for, and
> then calls print_status().
>
> Finally, the function print_status() handles the printing of submodule's
> status.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version, the following changes have been made:
> * parameters passed to the function print_status() have been changed.
>   Instead of passing char *sub_sha1, instead the object_id is being passed.
>
> * Also, since the passed parameter displaypath's value isn't changed
>   by the function, it is passed to the funcition as const char *displaypath
>   instead of char *displaypath.
>
> * the output type of the function handle_submodule_head_ref() is changed
>   from strbuf to object_id, as we will use the object_id instead of the
>   hex of sha1 being stored in a struct strbuf.
>
> * diff_files_args is cleared after using it by passing it as args in the
>   function cmd_diff_files.
>
> * In the function status_submodule(), for checking if a submodule has merge
>   conflicts, the patch currently checks if the value of any of the ce_flags
>   is non-zero. Currently, I think the we aren't interested in a partiular flag,
>   but I'm not sure on this.
>
> * Debugging leftovers and suprious new-lines are removed.
>
> * The confusion with displaypath being passed as te super-prefix in many
>   of the ported subcommands may be a result of the fact that the
>   function generating the displaypath: get_submodule_displaypath()
>   uses the super-prefix as simply a path concatenated with the current
>   submodule name to denote our current location.
>   The function get_super_prefix() is declared in cache.h and defined in
>   environment.c, but is majorly used in the builtin/submodule--helper.c
>   and also in unpack-trees.c
>   Also, for generating any submodule's displaypath, it would be important to
>   have ".." passed to the submodule, and currently it is possible only via the
>   super-prefix.
>   This is also other instaces where the super-prefix contained ".." as well.
>   One of such instance is Test 4 from t7406-submodule-update.sh
>   Hence, maybe documenting the value of displaypath might a solution
>   for the above problem.
>   I'm just stating my views and would like to recieve your opinion on this
>   matter.

Yes, I agree that the display path is not quite easily understood as it can be
ambiguous.  I am confused by this paragraph:
* does test 4 from 7406 fail here, or was it just the starting point
  of the discussion and it all works fine?

I have reviewed the patches up to (and including this) patch and
so far they look good to me.

Thanks,
Stefan
