Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3DC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8629F61078
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhKBMXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhKBMXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:23:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613EBC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:20:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b12so28546857wrh.4
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3MAVL0A/vqxyIJoQoO7MaZu3moL/Y4BKhLtuWbWx0pw=;
        b=piI2lnhNyS4LxKkHOORcVJLUTmmQdbJVnq0WK0i1/RFJim39Rm0Zb4+tm5S35p/DDD
         Zz43SP+oStBJnKm/9YhYZG9hQgwO3x9VeM2KiZcJKbbgGm6I+RSoJVzLn9MlxAIoliaI
         Bv/NJNU/ToXl+dFIe4BCMCnPyxINZFmA56XQidP2r4SxDi6rKQED/2lDrPpbdd+NaIFl
         VcUwzWR2XMx1YxbVdqxY/FqZb2YaAcP6ofVF/9451/aHVOhhm/8tdoh5yGbNNU5hrZnU
         jQdG0lX2q/fNuYeDRnfMwORZT45ChazHig/1sWB2fXTm3ur3JVRRfOb01YOQUfnmzCk6
         7afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3MAVL0A/vqxyIJoQoO7MaZu3moL/Y4BKhLtuWbWx0pw=;
        b=xSi0HCZBMBuLdB40Hjyoo0DlHYw8czaok2AneNf05AGqN9Ki/SukXA+U1Qc89H25DW
         Kc3hiq7Dy4T9C8gW7aZLoQ1d/yBUCHC4Yoqnmeb+Ggb1t5YQEjlQ8nD1rnRalfOkuLTC
         n7Wfr+7jR0sXt+FnqL78zb0Vm/Zc70GEJQY6HzUE5OHO3MCbN6qmbyDyKqGlPYuHLsMX
         meslRJjw7nrps8QwV8NwrRXBkv5ueHcC0JBqepeZWHBjz+lDEZL0VLCL8Vpy26rzXGaM
         +3aox5eOWldH+9NOdo4JBcQklQ5K3NNuH6FCENjPg+njSolnLERGaebn5MFognO9r0Va
         STVw==
X-Gm-Message-State: AOAM5321ntiHLLF3n81MZ6YXLb6MW4XC9qqIKvTIeaEzZllDsXYvzTf4
        CFxtTij+dGqodvbzxK/JBjU=
X-Google-Smtp-Source: ABdhPJyTdEAy7daGFuXG3f7JOsmRnEUFG2yFEyS9//xJ+HgvlWc4T8alfsyLSChvtXmruUL2cJ6dKQ==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr35776441wrp.29.1635855636016;
        Tue, 02 Nov 2021 05:20:36 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id v6sm20361245wrx.17.2021.11.02.05.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 05:20:35 -0700 (PDT)
Message-ID: <c510fd61-a079-c8fd-9203-61706f5534ac@gmail.com>
Date:   Tue, 2 Nov 2021 12:20:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author
 script` when trying to reword in interactive rebase
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Jonas Kittner <jonas.kittner@ruhr-uni-bochum.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <000201d7cf76$a4861460$ed923d20$@ruhr-uni-bochum.de>
 <YYCT7tLfphH049h+@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YYCT7tLfphH049h+@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11/2021 01:27, Jeff King wrote:
> On Tue, Nov 02, 2021 at 12:17:29AM +0100, Jonas Kittner wrote:
> 
>> In the interactive prompt I changed `pick` to `reword`, saved and closed the
>> prompt.
>> Commands to repoduce see below
> 
> Thanks for the easy reproduction. Here are commands that slightly
> simplify / automate things, which I used to bisect:
> 
>    rm -rf repo
>    git init repo
>    cd repo
>    git commit --allow-empty -qm base
> 
>    touch file
>    git add .
>    GIT_AUTHOR_DATE='@123456789 +0000' git commit -qm "this message says pick"
> 
>    GIT_EDITOR='sed -i s/pick/reword/' \
>    git.compile rebase -i --committer-date-is-author-date HEAD^
> 
>    # not strictly necessary, but when it works, you can see that the
>    # timestamps correctly match, and that "pick" was changed to "reword"
>    # in the message. Of course when it doesn't work, rebase aborts, so
>    # that's easier to see than looking at the commit. :)
>    git cat-file commit HEAD
> 
>> What happened instead? (Actual behavior)
>> segfault: `BUG: sequencer.c:921: GIT_AUTHOR_DATE missing from author script`
>>
>> [...]
>>
>> https://github.com/git/git/commit/7573cec52c0274ceb166c425be4288f6b3103d6f#d
>> iff-0e574dc9087fc7831bbc1403545a8561f08869576c1ccc4146aa276146ff9777R888-R88
>> 9
>> this seems to be not the case and needs to be handled differently I guess?
> 
> It looks like things did work back in 7573cec52c (rebase -i: support
> --committer-date-is-author-date, 2020-08-17). Bisecting shows that it
> broke in baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when
> fast-forwarding, 2021-08-20). +cc Phillip (who wrote both commits).

Thanks for bisecting, I think I know what the problem is, I'll post a 
fix tomorrow.

Best Wishes

Phillip

