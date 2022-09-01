Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227EECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 22:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiIAWgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiIAWgY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 18:36:24 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5EE2C108
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 15:36:23 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11eb8b133fbso913121fac.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1Bku6RFz/CvCbqZWzNjBzV40eU89p7s/KCTWx+y7JGQ=;
        b=aJwhCEwJzeWQUJo2osWLJ9uKHjnvizr2iWilCoNNQSG+C8CN4c/VOqwyDOvnlYWDy+
         srByOxPEJf0SEpnpERvyFSZSMvTASQvvX3WRafyTx87Lj+3h2uyo/0QtG5n7Jg3sH+MZ
         xQY2S1ALiTT5WsVR0VfO6GPR0zz3v0pImp0Fvg9bNj6Xa53uk7E0uVM+LW4jabOPSR9P
         MZw6G/2KOQKb1ZwRX2QjxZu/E2EDVQbxHWRdytBEtYc/H3Hlszo1sIKjZO3PEEoXM0to
         w2tN6IGTMW2kHWhe/fm50E8AQX9S/Sf2+UdSqVIcQrWJQRrFuoza6h86bCMbGKv2AIz7
         seRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1Bku6RFz/CvCbqZWzNjBzV40eU89p7s/KCTWx+y7JGQ=;
        b=B+xMzesun27Yc1DhgZgI4Jz2SYwxA6sivysH//ZANJAIsKyjPTOj40eaCgtg3W6Uvk
         rIkp1qzCbD5nT28LcJJQMP6tzh2jJFiRIg1w5KPuNOcJ25ePnZ1l2KUZqunw1ekrn/tk
         dugdV14t0JQS2pf1dYZEymcg2Y9ULXe/v2gu/AVqLVNYPBHNqMXsHe3W5Age7gsL7/5m
         Fvg8GS1jf8wO6Iy/k4f12+IBpNpT/kS1Vs6+NDzBwNb/z/zULH8dp7L4BvZ1dodB1tLq
         ymzMQthwX6Kq2G5qsInI4e5SJuXEdfoj9TT8XVTuQxuYZtmtSi23ZP/KQYIdWISPLHIs
         MtHg==
X-Gm-Message-State: ACgBeo1UssTa+tdtW0oeNF1I/PCmZi1ckUaM4JCWC/3H0wjnpaU278h4
        2pKJDmXvICmbsJE0a63K7d/XFteoFws=
X-Google-Smtp-Source: AA6agR6KiidqiVYW9PwC3F/PsrF+liD61/qitdGPAarmM8wsTjKro3aFnzrrfu1wcE4QOGZjdNokwQ==
X-Received: by 2002:a05:6870:830c:b0:122:339c:9bcb with SMTP id p12-20020a056870830c00b00122339c9bcbmr747389oae.224.1662071782455;
        Thu, 01 Sep 2022 15:36:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:19b:a8b4:73c:2e5? ([2600:1700:5a60:7720:19b:a8b4:73c:2e5])
        by smtp.gmail.com with ESMTPSA id m15-20020a9d73cf000000b006393aa233d5sm246573otk.27.2022.09.01.15.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 15:36:22 -0700 (PDT)
Message-ID: <cd11cc71-397a-e186-7d53-4a122f830903@gmail.com>
Date:   Thu, 1 Sep 2022 15:36:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-1-shaoxuan.yuan02@gmail.com>
 <20220901045736.523371-4-shaoxuan.yuan02@gmail.com>
 <xmqqpmgf9fpr.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqpmgf9fpr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 10:17 AM, Junio C Hamano wrote:
 > Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
 >
 >> Before this patch, whenever --sparse is used, `git-grep` utilizes the
 >> ensure_full_index() method to expand the index and search all the
 >> entries. Because this method requires walking all the trees and
 >> constructing the index, it is the slow part within the whole command.
 >>
 >> To achieve better performance, this patch uses grep_tree() to search the
 >> sparse directory entries and get rid of the ensure_full_index() method.
 >
 > When you encounter a "sparsedir" (i.e. a tree recorded in index),
 > you should know the path leading to that directory. Even though I no
 > longer remember the details of the implementations of grep_$where()
 > which I did long time ago, I think grep_tree() should know how to
 > pass the leading path down, as that is the most natural way to
 > implement the recursive behaviour.  This patch should be able to
 > piggyback on that.

Yes, though this commit [1] from 6 years ago started to assume that
grep_tree() only accepts root tree or commit, so the function fails
to process a tree like "sparsedir". It's the pathspec matching base that
was messed up. The support for a tree that is not at root-level was
added in this series.

[1] 74ed43711fd1cd7ce155d338f87ebe52cb74d9e2

 >> @@ -537,8 +534,26 @@ static int grep_cache(struct grep_opt *opt,
 >>
 >>          strbuf_setlen(&name, name_base_len);
 >>          strbuf_addstr(&name, ce->name);
 >> +        if (S_ISSPARSEDIR(ce->ce_mode)) {
 >> +            enum object_type type;
 >> +            struct tree_desc tree;
 >> +            void *data;
 >> +            unsigned long size;
 >> +            struct strbuf base = STRBUF_INIT;
 >> +
 >> +            strbuf_addstr(&base, ce->name);
 >> +
 >> +            data = read_object_file(&ce->oid, &type, &size);
 >> +            init_tree_desc(&tree, data, size);
 >>
 >> +            /*
 >> +             * sneak in the ce_mode using check_attr parameter
 >> +             */
 >> +            hit |= grep_tree(opt, pathspec, &tree, &base,
 >> +                     base.len, ce->ce_mode);
 >
 > OK.  Instead of inventing a new "base" strbuf, we could reuse
 > existing name while running the grep_tree() and restore it after it
 > returns, and I suspect that the end result would be more in line
 > with how grep_cache() uses that "name" buffer for all the cache
 > entries.  But that is not a correctness issue (it is move about
 > preventing from making the code worse).

Oh right, thanks for the suggestion!

 >> @@ -598,7 +613,14 @@ static int grep_tree(struct grep_opt *opt, 
const struct pathspec *pathspec,
 >>          int te_len = tree_entry_len(&entry);
 >>
 >>          if (match != all_entries_interesting) {
 >> -            strbuf_addstr(&name, base->buf + tn_len);
 >> +            if (S_ISSPARSEDIR(check_attr)) {
 >> +                // object is a sparse directory entry
 >
 > No // comments, please.

OK.

Thanks,
Shaoxuan



