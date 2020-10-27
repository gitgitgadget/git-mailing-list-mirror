Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B73AC55178
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE8B2242E
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaobZx1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822300AbgJ0RtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:49:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54472 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822226AbgJ0RsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 13:48:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id w23so2194741wmi.4
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxZIbZDhBnDwZ5b71xrw9t0jGXBptDaOOxYuWQpldH8=;
        b=kaobZx1heZ63rU8HPunrKU9knhbBN+Eo4I1CyGQheMaVck5YEnPl2gjqxiLXBsJA3G
         cBX9rfTdnc3/g1hs4X8WtaeUbr8EuBnRI2+r/rxTBzCEXKpRv+0GPyoiQiB5XgOjbF88
         ZHYhKGoIwfNoNf2OZAwgoivQF/FdJ0rLlcvcy58f1eiA09+VxKRGYcrT5mG/7KHcASTY
         Y6AccGOGx1b5eZGrJza+ZVKRfCK8cQMHix3cCo48oTLoQ0gib6JtiwLftbFu5KZL0rkU
         BDeywoE2P7sZVjCq3P22b4eyK48lIO3Fcsw++DH0Fmhfoab8LCvFFc42tFkSNhIJrfxy
         gq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sxZIbZDhBnDwZ5b71xrw9t0jGXBptDaOOxYuWQpldH8=;
        b=qCcf5wnasrboAdtc5Do5RXcACse7fuCTjLTAekDOz+UUOoYAZeuwryvDdhpaYgtSZW
         HUR/sH5uCs9riXkLr0CYLKQVjqFgMsFa0R6gqVrZmWyPBQbYFK9UnFk44W98Q3PduvCW
         iqHTw1jA00/JNQ4TwxrkKumlyA9/Hvr1KnFBPV5n9yk1bDE4r84yZe8i2pbYC2ECixbC
         XBmUE4X6p2tQvoOfD8kfaYfc3Nb8LObFS57wMvmjaz9+3nH27f1Ybb7Nv25K2AvW9Di9
         LvpipKI7PWK8rMR72MDqxc5mnsy6fUMXG9JiY9yVTdCJ4ZGy87g7bJW0MKzJjTUXBoak
         XlHQ==
X-Gm-Message-State: AOAM532rST+6By5p0j9sO+ppZV6NY/fDY0rhVC7oMQ8nDLY2Lu2+dNmR
        TZ7vEjwb4NSnCE83VMZONbUY95pR37g=
X-Google-Smtp-Source: ABdhPJwhXWBJYsVvWecW+B0uUfWk/9Xo5Xtgytt0911C6cFthYI+PKvuwQlz9RVAbkbKaACm24ABUg==
X-Received: by 2002:a1c:bc55:: with SMTP id m82mr3797684wmf.159.1603820890873;
        Tue, 27 Oct 2020 10:48:10 -0700 (PDT)
Received: from [192.168.1.240] (189.55.7.51.dyn.plus.net. [51.7.55.189])
        by smtp.gmail.com with ESMTPSA id g8sm3048382wma.36.2020.10.27.10.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 10:48:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy]: Help for Outreachy Application
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
 <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com>
 <CAPSFM5fbZN0uv9SgB-d4SR53ZFw8cOkgFmUK-Gns+c=yAmcP1w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <966470c3-8883-faf1-629f-89fc8d18b339@gmail.com>
Date:   Tue, 27 Oct 2020 17:48:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5fbZN0uv9SgB-d4SR53ZFw8cOkgFmUK-Gns+c=yAmcP1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 27/10/2020 14:24, Charvi Mendiratta wrote:
> On Mon, 26 Oct 2020 at 16:06, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 25/10/2020 07:43, Charvi Mendiratta wrote:
>>> I have read the Outreachy projects and am interested in the project
>>> "Improve droping and rewording commits in Git interactive rebase". I
>>> spent some time understanding the project and have gone through its
>>> detailed explanation in the issue[2].
>>
>> Thanks for your interest in the project
>>
> I apologize for late replies, as I thought to spend some more time in
> understanding the project.

That's fine, no need to apologize - taking time to understand the 
project is good

 >[...]
>>> I also looked into archives of the mailing list and found the
>>> patches[3] submitted by Philip for --reword option in git commit and
>>> need some more pointers about its status and how to start with its
>>> code ?
>>> Also, in the issue[2] as commented by Phillip regarding the patches[4]
>>> that implements reword. I would like to know if I can start with that
>>> mentioned work, if available.
>>
>> Whoever takes on this project is very welcome to use my patches as a
>> starting point. The code in the patches is sound as far as I know and
>> the I believe the test coverage is reasonable (though that would need to
>> be checked). They are lacking any documentation and there has been a
>> change to the way empty commits are handled by rebase since they were
>> written so "rebase -i: always keep empty amend! commits" will need
>> looking at and could probably be dropped.
> 
> Okay, I will note these points .
> 
>> We will also need to decide on the best UI for the --reword idea. My
>> patches were developed a couple of years ago before I was aware of
>> dscho's idea and so implement a slightly different UI to the one
>> outlined in the github issue (they call 'reword!' 'amend!' instead). I'm
>> not that keen on adding another option to `git commit` to create yet
>> another flavor of fixup commit, we'll need to agree a way forward on that[1]
>>
> 
> I agree that we need to look into options for creating reword! commit
> and drop! commit and its integration with interactive rebase .
> 
> Also, considering this I think there can be two possibilities :
> 
> As mentioned by Junio [1] that we can extend the existing '--fixed <commit>'/
> '--squash <commit>', to implement reword! commit as mentioned in the issue[2]
> by Dscho .

My concern with the idea of using `--fixup=<commit> --edit` to create a 
reword! commit is that it is changing existing behavior. I (very) 
occasionally add some temporary notes to a fixup commit if I know I'm 
not going to be rebasing for a while, that would still be possible under 
the new scheme but would require manually editing the subject line.

> or as you have mentioned to change the semantics of
> 'git commit --fixup/squash".

I think that would require a config variable to opt in which is not ideal.

Since that discussion I've wondered if changing commit to allow 
`--fixup=reword:<commit>` to create an empty reword! commit that changes 
the message of <commit> when it is rebased and `--fixup=amend:<commit>` 
to create a reword! commit that changes the content and message of 
<commit> when it is rebased. The advantage is that they are backwards 
compatible and mirror --amend and --reword as suggested in the other 
thread. We could allow `reword/amend:<commit>` to be abbreviated as 
`r/a:<commit>`

We also need to decide how to apply a reword! commit when rebasing. My 
patch series adds a new command 'amend' but I wonder if we should think 
about using `fixup -C` to reuse the message without editing and `fixup 
-c` to reuse the message and have the user edit it as we do for `merge`

One other point - as the reword! mechanism changes the contents and 
message of the commit I wonder if we could improve the name - maybe 
amend! or revise! I'm not sure.

> And, if we consider the above then for drop! commit, I wonder if we
> can implement
> it in the same way as mentioned in issue [2] by adding the --drop
> option to 'git revert'.
> 
> Secondly, as you have mentioned here [3], there could be a `rewrite` command
> as a wrap of `rebase -i` . But regarding this, I want to once confirm
> if this can be a
> solution of this project or is it need to be done later on.

The 'rewrite' idea is definitely not part of this project, it's an idea 
for better history editing in the future.

Best Wishes

Phillip

> Please correct me if I am wrong.
> 
> Thanks and Regards,
> Charvi
> 
> [1] https://lore.kernel.org/git/xmqqft77glhn.fsf@gitster.c.googlers.com/
> [2] https://github.com/gitgitgadget/git/issues/259
> [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
> 
>> Best Wishes
>>
>> Phillip
>>
>> [1]
>> https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com
>>
>>>
>>> Thanks and Regards,
>>> Charvi
>>>
>>> [1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
>>> [2] https://github.com/gitgitgadget/git/issues/259
>>> [3]
>>> https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
>>> [4] https://github.com/phillipwood/git/commits/wip/rebase-amend
>>>
>>
