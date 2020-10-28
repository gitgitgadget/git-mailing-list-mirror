Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29CDC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B9820728
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlkxth5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbgJ1Wf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732560AbgJ1Wfz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:35:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16767C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:35:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b1so804152lfp.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rcsmKoPHEAtPv0JUsZmg0N+Q5wsIffQ67RgWTuxm6I0=;
        b=Dlkxth5h2fR5OhUAkTlKge4vBBLtiQaihmhyyh/fwWBqa6Y2rHzEBbo6Via9Xv//8B
         4ZogEYk69en9uuenWqx91vQnTSc/OgzyNOOVQN5gaEeNfgR1C6jpT/h3GraEt/VXtOF2
         CRcc8yqfGqJRQtN8251LrIK+64+9Al9TQO/lnz5hztQIHW7bjqyRZ2WGfg8H+/E4RHCr
         Uct9TO2B4q5yFpLPNXj+t3bWn7clhC4nczSHNSDqn+gKDXFtXVX9HlfL19eYFebruTsA
         ZmA3jg7wERd5hGJYN+Jz7k2i2LrJJpi2+ETL6gFbmw0oER1CenZ8ypx+Eh+XLk8laz9v
         uRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rcsmKoPHEAtPv0JUsZmg0N+Q5wsIffQ67RgWTuxm6I0=;
        b=o3CKPzrakcXS+FMZazsDTMBDMMFqb60X1WTwgFDsO+G1iYajoKQroOKn95D1jreUlz
         PvOcdV71eQylGiTPeBvgiNomOhvrioxcEjf/ZUjswJXBtpvSHs0vRJQH5la+q308nTd+
         fO7vK1Ep+GFCnWnobVtYTHyiC4YAbEKyk7aV1L3w9ZtTWjXivScRDwomis2z1s/a04J9
         +tgAKDXQifu9vrTQhcdg/+5J+CMr+92AuUVgmKaNOZJClCI5paO6qBdQfdOb9gxswgp0
         PEaEG3+UFHM6sKdPmI2+tR6B1+6DuxXKNs6jP7O6HOaeCKib+QAUiFlARR/uNK+jGPFB
         aBSw==
X-Gm-Message-State: AOAM533zyzX6gvrToF1gVrqXWandwvMC8R7xZpt/axHyhOW0X74Kbypq
        8VJ+Axh+aqXioH8+z+M1N16NQGJli/0=
X-Google-Smtp-Source: ABdhPJyxRHs9ymwJiTlM5FaP2XhauKHQbgnPtzQDKGpQDTVW9bcQjmUiuyiY8f9PK5hvN3XmncGpTw==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr9276731wrt.323.1603899976331;
        Wed, 28 Oct 2020 08:46:16 -0700 (PDT)
Received: from [192.168.1.240] (189.55.7.51.dyn.plus.net. [51.7.55.189])
        by smtp.gmail.com with ESMTPSA id u15sm7746098wrm.77.2020.10.28.08.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 08:46:15 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy]: Help for Outreachy Application
To:     Charvi Mendiratta <charvi077@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
References: <CAPSFM5e9tXx_LuwNK+e1wOjaHb6kiTCEt3WeL851KAbTPNsEow@mail.gmail.com>
 <6a2005e7-6b8b-2bf4-91fa-55feadd65897@gmail.com>
 <CAPSFM5fbZN0uv9SgB-d4SR53ZFw8cOkgFmUK-Gns+c=yAmcP1w@mail.gmail.com>
 <966470c3-8883-faf1-629f-89fc8d18b339@gmail.com>
 <CAPSFM5evXnsOT3Oj=PXzeDYUR8esCd1rEZXpihSdbT7NPuYm1w@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <29fc2f59-1cca-a3db-5586-bbd7b2e4806d@gmail.com>
Date:   Wed, 28 Oct 2020 15:46:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5evXnsOT3Oj=PXzeDYUR8esCd1rEZXpihSdbT7NPuYm1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 28/10/2020 13:14, Charvi Mendiratta wrote:
> On Tue, 27 Oct 2020 at 23:18, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 27/10/2020 14:24, Charvi Mendiratta wrote:
>>> On Mon, 26 Oct 2020 at 16:06, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> On 25/10/2020 07:43, Charvi Mendiratta wrote:
 > [...]
>>>> We will also need to decide on the best UI for the --reword idea. My
>>>> patches were developed a couple of years ago before I was aware of
>>>> dscho's idea and so implement a slightly different UI to the one
>>>> outlined in the github issue (they call 'reword!' 'amend!' instead). I'm
>>>> not that keen on adding another option to `git commit` to create yet
>>>> another flavor of fixup commit, we'll need to agree a way forward on that[1]
>>>>
>>>
>>> I agree that we need to look into options for creating reword! commit
>>> and drop! commit and its integration with interactive rebase .
>>>
>>> Also, considering this I think there can be two possibilities :
>>>
>>> As mentioned by Junio [1] that we can extend the existing '--fixed <commit>'/
>>> '--squash <commit>', to implement reword! commit as mentioned in the issue[2]
>>> by Dscho .
>>
>> My concern with the idea of using `--fixup=<commit> --edit` to create a
>> reword! commit is that it is changing existing behavior. I (very)
>> occasionally add some temporary notes to a fixup commit if I know I'm
>> not going to be rebasing for a while, that would still be possible under
>> the new scheme but would require manually editing the subject line.
>>
> 
> I am still unable to get the case as you mentioned.

At the moment `--fixup=<commit> --edit` opens an editor with a commit 
message that has a single line "fixup! ..." and the user is free to add 
any notes which will be discarded when they rebase. If we use that 
combination of options to create a reword! commit then the message will 
be pre-populated with the old message and that message will be used when 
the user rebases.

> Otherwise, I thought
> earlier about this idea as that for creating reword! commit if we want to
> change both the content and message then `--fixup=<commit> --edit` can
> be used and will be presented same as `git commit --amend` . Secondly, if
> we want to change only message then `--fixup=<commit> --edit --allow-empty`

You need to add `--only` as well to ensure that any staged changes are 
not added to the commit which makes a lot of typing (though users could 
set up an alias).

> can be used and will present same as `git commit --amend --only` for the
> mentioned commit . Please correct me if I am wrong or missing something .

It may be that using the combination of `--fixup=<commit> --edit` is the 
least worst option and the change in behavior does not impact existing 
users, but we should consider the other options to be sure.

>>> or as you have mentioned to change the semantics of
>>> 'git commit --fixup/squash".
>>
>> I think that would require a config variable to opt in which is not ideal.
>>
>> Since that discussion I've wondered if changing commit to allow
>> `--fixup=reword:<commit>` to create an empty reword! commit that changes
>> the message of <commit> when it is rebased and `--fixup=amend:<commit>`
>> to create a reword! commit that changes the content and message of
>> <commit> when it is rebased. The advantage is that they are backwards
>> compatible and mirror --amend and --reword as suggested in the other
>> thread. We could allow `reword/amend:<commit>` to be abbreviated as
>> `r/a:<commit>`
>>
> 
> Okay, I note this as one of the possibility and I agree completely with this.
> 
>> We also need to decide how to apply a reword! commit when rebasing. My
>> patch series adds a new command 'amend' but I wonder if we should think
>> about using `fixup -C` to reuse the message without editing and `fixup
>> -c` to reuse the message and have the user edit it as we do for `merge`
> 
> Yes I also think, like we are not using extra commit command, then we
> can also avoid to use new command in rebase also and can go with `fixup -C`.
> But, I am still doubtful that how it will work upon rebase
> --autosquash . 

At the moment if `--autosquash` sees a commit with a message that starts 
"fixup! <subject of commit to fixup>" then it moves that fixup commit in 
the todo list to follow the commit it is fixing up and changes the 
command from `pick` to `fixup`. We want it do do the same with commits 
that have a message "reword! ..." but changing the command to `fixup -C` 
instead. If you look at my patch "rebase -i: update --autosquash to work 
with amend!" that might help make it clearer.

> I am still
> looking for some pointers for how merge command works(its use) in rebase -i.

There's a section "Rebasing Merges" in the man page which might help, 
I'm not sure you need to know much about rebasing merges for this project.


Best Wishes

Phillip

>> One other point - as the reword! mechanism changes the contents and
>> message of the commit I wonder if we could improve the name - maybe
>> amend! or revise! I'm not sure.
>>
> 
> As I understood, that reword! mechanism includes two cases, first if we want
> to change the content and commit message both and second if only need to
> change the commit message (as mentioned in issue to --allow-empty). As the
> word "reword" implies the second case only . So, considering this I also agree
> to improve its name to the one as you suggested or may be other.
> 
>>> And, if we consider the above then for drop! commit, I wonder if we
>>> can implement
>>> it in the same way as mentioned in issue [2] by adding the --drop
>>> option to 'git revert'.
>>>
>>> Secondly, as you have mentioned here [3], there could be a `rewrite` command
>>> as a wrap of `rebase -i` . But regarding this, I want to once confirm
>>> if this can be a
>>> solution of this project or is it need to be done later on.
>>
>> The 'rewrite' idea is definitely not part of this project, it's an idea
>> for better history editing in the future.
>>
> 
> Okay,Thanks for confirming this  .
> 
> Thanks and Regards,
> Charvi
> 
>> Best Wishes
>>
>> Phillip
>>
>>> Please correct me if I am wrong.
>>>
>>> Thanks and Regards,
>>> Charvi
>>>
>>> [1] https://lore.kernel.org/git/xmqqft77glhn.fsf@gitster.c.googlers.com/
>>> [2] https://github.com/gitgitgadget/git/issues/259
>>> [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
>>>
>>>> Best Wishes
>>>>
>>>> Phillip
>>>>
>>>> [1]
>>>> https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com
>>>>
>>>>>
>>>>> Thanks and Regards,
>>>>> Charvi
>>>>>
>>>>> [1] https://public-inbox.org/git/20201021124823.2217-1-charvi077@gmail.com/
>>>>> [2] https://github.com/gitgitgadget/git/issues/259
>>>>> [3]
>>>>> https://public-inbox.org/git/pull.736.git.1600695050.gitgitgadget@gmail.com/
>>>>> [4] https://github.com/phillipwood/git/commits/wip/rebase-amend
>>>>>
>>>>
