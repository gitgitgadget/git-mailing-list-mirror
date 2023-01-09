Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39CAC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 13:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjAIN5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 08:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjAIN5D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 08:57:03 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC85FFE
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 05:57:01 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id g7so7896064qts.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 05:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVYR1GyHHnsyMHtvAP4DJm4QWdp74aNXp9+rQmqoTFo=;
        b=EPnLtLzqva5+l0XUPGiG0oIZIfQwT10yN4MbvhUu3bJjQMWX4AEhQm5n1UvjKP2o/u
         QZUWFZjyCilFFcC+1vdU+BOv+p1VHnbLMGrjtPZRZsly4oPK/ympUaWb9dwNPf9uJIDk
         x8RMG3uhzeZtYBZtCzQXtMfRH/5+lo5WdlzbmFM6qPYsx51KC3wyqBHJZ6H2lNyLVNbT
         YeOfogXs1M6w9xZnM/yc1g6AvJFDUlnExGcN55mgnKGQAbk9phz4GFICFEmahpwaKaV1
         2/cFplYBHSzczIh0r1LecmsVxSr55uLv6g+eqYsMz8dewPoPRhjLQ4B8CwoA6vZydBGO
         WtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVYR1GyHHnsyMHtvAP4DJm4QWdp74aNXp9+rQmqoTFo=;
        b=Ja0uIaIkpcBTQ9TOEgTia+/7NC7JW8dufD+wQZ5PqZjgoskj9a+s45a/eZJHMBngPt
         M39S4U5nyTvRSNwLSqifV5lQR+dEUw2qObujKkuz3mXH3pck5W2zbHPDV80noZEs769G
         EN5cw8Y6yh6lsnT9gE/NLQs5PUErMlT4ms0kDGGpaLasItqqdLtqYZZ46yJziyhF9/0T
         Flf3XXKbZ9r96iA4Pnhss8gqj0gJLL8fy8fyS9hDhLZuLZyONjm3foQ8HMNpkzJxpZ61
         gP8lBMilFwJPH1pO2aKHULH0WHZQm7QEuecitN5qVKQrKDqhhivo7B9ijv9MYuritlg8
         kJMQ==
X-Gm-Message-State: AFqh2kpgKjB2bSAuI5TOodi1KSOfWlBfT1I6rmf6rIcZtUwCNWDEkV/9
        jTuT286AYNwU12CWiZwDbys=
X-Google-Smtp-Source: AMrXdXvqUPgLHLBwrk1Q2pYkl3w9HN8pHNQmHfGdbcZP7KVS0X/WX8zH0r8KFnw/HIa30TidDaP0ww==
X-Received: by 2002:a05:622a:1884:b0:3ab:ec48:d54f with SMTP id v4-20020a05622a188400b003abec48d54fmr13583311qtc.25.1673272620318;
        Mon, 09 Jan 2023 05:57:00 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bv15-20020a05622a0a0f00b003a7e8ab2972sm4586222qtb.23.2023.01.09.05.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 05:56:59 -0800 (PST)
Subject: Re: [PATCH 1/5] git-cherry-pick.txt: do not use 'ORIG_HEAD' in
 example
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
 <74b2d5a9144e4893311d9acfb0b5e8268da6f0f0.1673120359.git.gitgitgadget@gmail.com>
 <xmqqh6x1232e.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <4525699c-eed5-4da6-b469-b73b87525b23@gmail.com>
Date:   Mon, 9 Jan 2023 08:56:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqh6x1232e.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Junio,

Le 2023-01-07 à 21:05, Junio C Hamano a écrit :
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The command used in the example to abort the cherry-pick is 'git reset
>> --merge ORIG_HEAD', but cherry-pick does not write 'ORIG_HEAD' before
>> starting its operation.
> 
> Sorry, but I am confused.  Doesn't <1> update ORIG_HEAD used by <3>?
> 
>>  $ git cherry-pick topic^             <1>
>>  $ git diff                           <2>
>> -$ git reset --merge ORIG_HEAD        <3>
>> +$ git cherry-pick --abort            <3>
>>  $ git cherry-pick -Xpatience topic^  <4>
>>  ------------
>>  <1> apply the change that would be shown by `git show topic^`.
> 

No, as far as I was able to test and from my reading of the code,
cherry-pick does not write ORIG_HEAD.

Here is a little script that demonstrates this:

```
#!/bin/sh

rm -rf test
git -c init.defaultBranch=master init test
(

cd test
echo hello>file
git add file
git commit -m initial
git branch other
echo two>>file
git commit -am two
git checkout other
echo three >>file
git commit -am three
git checkout master
# This writes ORIG_HEAD as 'two'
git reset HEAD^
git commit -a -m two-redone
# This does not
git cherry-pick other
# This shows ORIG_HEAD written by reset:
echo ORIG_HEAD is:
git log --oneline -1 ORIG_HEAD
# Whereas HEAD is 'two-redone':
echo HEAD is:
git log --oneline -1 HEAD
)
```

Looking at the code, 'git grep -p ORIG_HEAD \*.c'
reveals the only builtin that write ORIG_HEAD are 
am, merge, rebase and reset, and the only library code
that involves ORIG_HEAD is reset.c::reset_head.

Moreover, 'git grep -p [^a-z_]reset_head \*.c'
reveals that the only non-builtin user of reset.c::reset_head
is sequencer.c::create_autostash, in which the RESET_ORIG_HEAD 
flag of 'struct reset_head_opts ropts' is not set.

That is what convinced me that cherry-pick does not write ORIG_HEAD.

Thanks,

Philippe.
