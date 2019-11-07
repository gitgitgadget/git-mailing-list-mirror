Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95481F454
	for <e@80x24.org>; Thu,  7 Nov 2019 18:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfKGStR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 13:49:17 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56237 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfKGStR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 13:49:17 -0500
Received: by mail-wm1-f43.google.com with SMTP id b11so3608715wmb.5
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 10:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgnW4Atwsr+RTGAb+4Dj6sx+yxFXlE46WhOYOw40NPU=;
        b=qKmAibiSwVfw0ZMnlno2zN6OVMNtYD6Bh1WdA51YYH20DCVFXB4h3f4KyqZjV6E5U+
         VjYZSudO0V3SkHo7sEZ4lvO3VYpLA3edZl+XV3JUTTW/H9xi5WMIWKu7onzgiiFHJ0MK
         NgD+JSWn279/xO8I360GEj977ezq7pSisSN0oQ0VyJ9kZfHX8rraYM57YdVgupv2SLbJ
         f5CZfiHjW4i3rjeFnxcN5/nrl2weISiFb05K3oPqlcYdFl17SaNOh7d1hdfw03Kbbl/N
         rZAyr6lXK9VNWq5YjaaphO+pbtTne6653My5WhPOtHzr/fVpDEPZFdKEKjsxIobsrkPa
         kDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgnW4Atwsr+RTGAb+4Dj6sx+yxFXlE46WhOYOw40NPU=;
        b=LIhP352ckypy6+Yg5u/kCtbcq5sYS+zx10tw9iEwm12X/6YwscMwZimp9z3gMmeA0z
         rZDuDocmSNMoudoEQv/rd51Wtx1p2UoX4dKvtuSO5TvKIakxYAivF8RiPdzxKPNIaSx6
         5jF2EtGaS9cyoE01UOvWvCEpvU1XJuUEbZoXrf7RzojOX78zohQQBT4a7NSc73bjaQFD
         PBqIUQc+EN2CByS6syNcXLgy64AWH7ZQrsiUMAgp2++RkyySj5W4PzIdCEcAK0HRRS/5
         75HoKd1lnKzCVZzpgDqporZ8dw8DsfAiZrWiexttoPqWLt36K3QC9HFC8/y7x0snSlLx
         YHTA==
X-Gm-Message-State: APjAAAWW1Hew0M34jg8lAlfncPs6nNfBDQO7q3yWSWW4FRJ3dhabKemE
        w6MsA9CjPVwJb0P4gLv/R5k=
X-Google-Smtp-Source: APXvYqzuqkcWF+4l60n7I4AUP5gMqrbo/Vw+jTxYHReaSIRCg0NQIp3akTHYEbDhMKDvCs7A8OLhIA==
X-Received: by 2002:a05:600c:2911:: with SMTP id i17mr485455wmd.83.1573152554839;
        Thu, 07 Nov 2019 10:49:14 -0800 (PST)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id d11sm4161336wrf.80.2019.11.07.10.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 10:49:13 -0800 (PST)
Date:   Thu, 7 Nov 2019 18:49:12 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Grzegorz Rajchman <rayman17@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] git stash pop --quiet deletes files in git 2.24.0
Message-ID: <20191107184912.GA3115@cat>
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07, Grzegorz Rajchman wrote:
> Hi, this is the first time I report an issue in git so I hope I'm
> doing it right.

Thanks for the report.  You are indeed doing this right, and the
included reproduction is very helpful.

I broke this in 34933d0eff ("stash: make sure to write refreshed
cache", 2019-09-11), which wasn't caught by the tests, nor by me as I
don't use the --quiet flag normally.

Below is a fix for this, but I want to understand the problem a bit
better and write some tests before sending a patch.

index ab30d1e920..2dd9c9bbcd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -473,22 +473,20 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
                if (reset_tree(&c_tree, 0, 1)) {
                        strbuf_release(&out);
                        return -1;
                }
 
                ret = update_index(&out);
                strbuf_release(&out);
                if (ret)
                        return -1;
-
-               discard_cache();
        }
 
        if (quiet) {
                if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
                        warning("could not refresh index");
        } else {
                struct child_process cp = CHILD_PROCESS_INIT;
 
                /*
                 * Status is quite simple and could be replaced with calls to


> I have experienced some unexpected behaviour with git stash pop
> --quiet in git 2.24.0. I use stash in a pre-commit hook script. In it,
> I stash non-staged changes to keep the working directory clean while
> running some linters, then I restore the stash by running pop, but
> after the recent git update I noticed that it stages all previously
> checked files as deleted.
> 
> Steps to reproduce:
> 
>   mkdir test-git-stash
>   cd test-git-stash/
>   git init
>   echo foo > foo.txt
>   git add . && git commit -m 'init'
>   echo bar > foo.txt
>   git stash save --quiet --include-untracked --keep-index
>   git stash pop --quiet
>   git status
> 
> This will unexpectedly output:
> 
>   On branch master
>   Changes to be committed:
>     (use "git restore --staged <file>..." to unstage)
>       deleted:    foo.txt
> 
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>       foo.txt
> 
> Notice that foo.txt was staged as deleted whilst still being present
> on the disk.
> 
> However, if I remove --quiet flag from stash pop:
> 
>   git restore --staged foo.txt
>   git stash save --quiet --include-untracked --keep-index
>   git stash pop
>   git status
> 
> Then it works as expected. It used to work as expected in git prior to 2.24.0
> 
> My OS is Ubuntu 19.04.
