Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA7ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 18:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiIASbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 14:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiIASbm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 14:31:42 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D87DF42
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 11:31:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s22so11469178qkj.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GfwQeSXT47TsFZzMIn0noRQRdqT+vJOj4F27C/353vw=;
        b=htV85B/LRQxsntp6WR/Ecdef5bI5b+RAFv9WViRhdvBt9RjwtLQXBomG4kIh3Pk0YL
         k/AtNCQyzpLf/A8uGvy5q5HoItVT1sjDRy/VkIRtjLWDIHBnaAJ+Hu+8UGU0I7X2WW7E
         BH3kszCoLu0tKZ10YKSBDjHPjCLzKsi5h6GJW23thB98Tjb8dTV6O5I3/WvBt3CUMSK4
         sEyCxj2VVgzgskpLEHm20wdP3Dqioiby+vckYwSjOL8I1DcBoYlR3YGmxKLXhc9VAGTO
         nPzZksIjBmgGkCjJ3O3nk709doY0pa5M/iji16OLVxgs9EehW7qpfO7Ze8DzzBLDgNex
         1wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GfwQeSXT47TsFZzMIn0noRQRdqT+vJOj4F27C/353vw=;
        b=LDlniUyiZOEb4oSdMxM5lWcUzIsCMZQy79xj7vzAvG6koZnARv60DaBTAS3Pq1ypps
         lnP8PgYSOe3vC0xUbdNDqoHlq0S/i0cEGn29dvM5CisRUNdEZ7tezP31czn3YgHE0lKo
         hUlO9XR9kgGWYu0fvu82nQ7d0hkYcpSrLKZWUt7Qd+LtL9ZdGF5aEVRmw4mDoBmanVjd
         IfBMrSe3JV6/nPxyUCaikf/DL29sdvsj8pToIxINrz51hbczTHIOaie/LMRRJM1uTMQt
         GW89OKJCtEE6zbH9Q1nUdZPu11v2vAKZRSNBdd2gLi7S3dkLKxLQkB9BlHEgzYI9ibdf
         e8QQ==
X-Gm-Message-State: ACgBeo3PR15skvtiyWF+MJtDjGkSl8D3kFtC3zhuCjBQCpZIjCa5DiNR
        ibf/pGKAp6J/E/LogKrC4MQ=
X-Google-Smtp-Source: AA6agR6Mp2GgoRjWytdo1HpikTRWfu/H+iN3+ELq6hMGggrq87SwexhEZh4gZlli/qNMIwO2HPhSWQ==
X-Received: by 2002:a05:620a:271f:b0:6b9:3b62:c67e with SMTP id b31-20020a05620a271f00b006b93b62c67emr20683261qkp.164.1662057098892;
        Thu, 01 Sep 2022 11:31:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:19b:a8b4:73c:2e5? ([2600:1700:5a60:7720:19b:a8b4:73c:2e5])
        by smtp.gmail.com with ESMTPSA id q3-20020a37f703000000b006b5cc25535fsm11949676qkj.99.2022.09.01.11.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:31:38 -0700 (PDT)
Message-ID: <7391347a-b3ee-d756-c2a7-49b9c44994e4@gmail.com>
Date:   Thu, 1 Sep 2022 11:31:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
 <e74b326d-ce4a-31c3-5424-e35858cdb569@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <e74b326d-ce4a-31c3-5424-e35858cdb569@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 10:03 AM, Derrick Stolee wrote:
 > On 9/1/2022 12:57 AM, Shaoxuan Yuan wrote:
 >> Test HEAD~   HEAD
 >> 
---------------------------------------------------------------------------------------------------
 >> 2000.78: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* 
(full-v3)     0.11    0.09 (≈)
 >> 2000.79: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* 
(full-v4)     0.08    0.09 (≈)
 >> 2000.80: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* 
(sparse-v3)   0.44    0.04 (-90.9%)
 >> 2000.81: git grep --cached --sparse bogus -- f2/f1/f1/builtin/* 
(sparse-v4)   0.46    0.04 (-91.3%)
 >>
 >> - Command used for testing:
 >>
 >>     git grep --cached --sparse bogus -- f2/f1/f1/builtin/*
 >
 > It's good to list this command after the table. It allows you to shrink
 > the table by using "...":

OK.

 >
 > Test                                HEAD~   HEAD
 > ---------------------------------------------------------
 > 2000.78: git grep ... (full-v3)     0.11    0.09 (≈)
 > 2000.79: git grep ... (full-v4)     0.08    0.09 (≈)
 > 2000.80: git grep ... (sparse-v3)   0.44    0.04 (-90.9%)
 > 2000.81: git grep ... (sparse-v4)   0.46    0.04 (-91.3%)
 >
 > This saves horizontal space without losing clarity. The test numbers 
help,
 > too.
 >
 >>          strbuf_setlen(&name, name_base_len);
 >>          strbuf_addstr(&name, ce->name);
 >> +        if (S_ISSPARSEDIR(ce->ce_mode)) {
 >> +            enum object_type type;
 >> +            struct tree_desc tree;
 >> +            void *data;
 >> +            unsigned long size;
 >> +            struct strbuf base = STRBUF_INIT;
 >> +
 >> +            strbuf_addstr(&base, ce->name);
 >> +
 >> +            data = read_object_file(&ce->oid, &type, &size);
 >> +            init_tree_desc(&tree, data, size);
 >>
 >> -        if (S_ISREG(ce->ce_mode) &&
 >> +            /*
 >> +             * sneak in the ce_mode using check_attr parameter
 >> +             */
 >> +            hit |= grep_tree(opt, pathspec, &tree, &base,
 >> +                     base.len, ce->ce_mode);
 >> +            strbuf_release(&base);
 >> +            free(data);
 >> +        } else if (S_ISREG(ce->ce_mode) &&
 >
 > I think this is a good setup for transitioning from the index scan
 > to the tree-walking grep_tree() method. Below, I recommend calling
 > the method slightly differently, though.
 >
 >>              match_pathspec(repo->index, pathspec, name.buf, 
name.len, 0, NULL,
 >>                     S_ISDIR(ce->ce_mode) ||
 >>                     S_ISGITLINK(ce->ce_mode))) {
 >> @@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, 
const struct pathspec *pathspec,
 >>          int te_len = tree_entry_len(&entry);
 >>
 >>          if (match != all_entries_interesting) {
 >> -            strbuf_addstr(&name, base->buf + tn_len);
 >> +            if (S_ISSPARSEDIR(check_attr)) {
 >> +                // object is a sparse directory entry
 >> +                strbuf_addbuf(&name, base);
 >> +            } else {
 >> +                // object is a commit or a root tree
 >> +                strbuf_addstr(&name, base->buf + tn_len);
 >> +            }
 >> +
 >
 > I think this is abusing the check_attr too much, since this will also
 > trigger a different if branch further down the method.

Yeah that's why I wrote "sneak in".

 > These lines are the same if tn_len is zero, so will it suffice to pass
 > 0 for that length? You are passing base.len when you call it, so maybe
 > that should be zero?

Agree.

 > When I apply this change, all tests pass, so if there _is_ something
 > different between the two implementations, then it isn't covered by
 > tests:

I think they are no difference between these two implementations,
at least according to my intention.

 > diff --git a/builtin/grep.c b/builtin/grep.c
 > index 8c0edccd8e..fc4adf876a 100644
 > --- a/builtin/grep.c
 > +++ b/builtin/grep.c
 > @@ -549,8 +549,7 @@ static int grep_cache(struct grep_opt *opt,
 >              /*
 >               * sneak in the ce_mode using check_attr parameter
 >               */
 > -            hit |= grep_tree(opt, pathspec, &tree, &base,
 > -                     base.len, ce->ce_mode);
 > +            hit |= grep_tree(opt, pathspec, &tree, &base, 0, 0);
 >              strbuf_release(&base);
 >              free(data);
 >          } else if (S_ISREG(ce->ce_mode) &&
 > @@ -613,13 +612,7 @@ static int grep_tree(struct grep_opt *opt, const 
struct pathspec *pathspec,
 >          int te_len = tree_entry_len(&entry);
 >
 >          if (match != all_entries_interesting) {
 > -            if (S_ISSPARSEDIR(check_attr)) {
 > -                // object is a sparse directory entry
 > -                strbuf_addbuf(&name, base);
 > -            } else {
 > -                // object is a commit or a root tree
 > -                strbuf_addstr(&name, base->buf + tn_len);
 > -            }
 > +            strbuf_addstr(&name, base->buf + tn_len);
 >
 >              match = tree_entry_interesting(repo->index,
 >                                 &entry, &name,
 >
 >> +test_perf_on_all git grep --cached --sparse bogus -- 
"f2/f1/f1/builtin/*"
 >
 > We can't use this path in general, because we don't always run the test
 > using the Git repository as the test repo (see GIT_PERF_[LARGE_]REPO
 > variables in t/perf/README).
 >
 > We _can_ however use the structure that we have implied in our 
construction,
 > which is to use a path that we know exists and is still outside of the
 > sparse-checkout cone. Truncating to "f2/f1/f1/*" is sufficient for this.

OK.

 > Modifying the test and running them on my machine, I get:
 >
 > Test                               HEAD~1            HEAD
 > 
----------------------------------------------------------------------------
 > 2000.78: git grep ... (full-v3)    0.19(0.72+0.18) 0.18(0.84+0.13) -5.3%
 > 2000.79: git grep ... (full-v4)    0.17(0.83+0.16) 0.19(0.84+0.14) 
+11.8%
 > 2000.80: git grep ... (sparse-v3)  0.35(1.02+0.13) 0.15(0.85+0.15) 
-57.1%
 > 2000.81: git grep ... (sparse-v4)  0.37(1.06+0.12) 0.15(0.89+0.15) -59.5%
 >
 > So, it's still expensive to do the blob search over a wider pathspec than
 > the test as you designed it, but this will work for other repo, such 
as the
 > Linux kernel:

Yes, I was trying to use a narrower pathspec to show a difference that
looks better.

 > Test                                HEAD~1             HEAD
 > 
------------------------------------------------------------------------------
 > 2000.78: git grep ... (full-v3)     3.16(19.37+2.55) 2.56(15.24+1.76) 
-19.0%
 > 2000.79: git grep ... (full-v4)     2.97(17.84+2.00) 2.59(15.51+1.89) 
-12.8%
 > 2000.80: git grep ... (sparse-v3)   8.39(24.74+2.34) 2.13(16.03+1.72) 
-74.6%
 > 2000.81: git grep ... (sparse-v4)   8.39(24.73+2.40) 2.16(16.14+1.90) 
-74.3%
 >
 > Thanks,
 > -Stolee

Thanks,
Shaoxuan


