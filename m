Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6730F1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 08:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFZI6D (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 04:58:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40024 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZI6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 04:58:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so1209741wmj.5
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6nCyKz39fHZbTXco7MYV4LlVNwGyqw8nuv6lt+2bAd4=;
        b=jpZ2qJiv4zeEHV4OVi0fE4YPukU+zTfqZxUU2CqmPgekDfTGbUBW92MjkJVdqztN8h
         nMMRDamWOEnNXc59/TkW8T7MUkVDE3GfW7LU8SYCWAzR1FAQx7AtPJx8U7OiGvaDtAFQ
         BmQllb/W/iK5RNoTlbFUEu1YeXROtZAI35nNowHpnsZ7v1MQ8qq3olZYd/nXeG77SUj8
         PTUefjgzhjjpgu26qY50ud2zEZaCFq7JMhArnX8ZsNE4+4X7cUN3k3KLecQZ36Ox5llQ
         g8KuDL1IQbiRBH+d+8MYQThDevAAJ3Tqtly5LKHmeF9hD6bDFZYUARottOHdlRiMtgnO
         Ya0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6nCyKz39fHZbTXco7MYV4LlVNwGyqw8nuv6lt+2bAd4=;
        b=PzeP1+m/SqhlM6S6ZiATEWdycVDMBZ5WrSa9NobxEK0LSz3aG7SAUwbkxzrcx9fYs1
         ZSHtKLnlqZeI+J05UeE9Z5YiyJQRmjtPQmMQW3MB/CvL2bT8pubO5GOoPdPi/3dLOVeS
         CMp0jXDIsmHb3nibT3QLlLZh5vvMhCygdAGIZudd+L32Z2x+jJnrgqcPDMFthbmftNic
         dzOGEL8mighDTQ3BAaZUhuqt1Xklh4SEiH6JUMN9/PqNeL7SuCVxMGIWsuW7gGYHy+uv
         WjXtjQo40f8aXloEcNAT0IsIkaX+61yDkOX6ZL9zcYsYiHVZmoxXpsbUKl031fnr/cYn
         Ntjw==
X-Gm-Message-State: APjAAAV3LaBnsR7RFWl5T4WOS+8Yw6l4Oz03UxzosonuoBCVPL24jpjf
        nTiSQClY9Rg0GBSyLMjfDMQVF9L2fPg=
X-Google-Smtp-Source: APXvYqxY71BlxJ0MvZ4LMqzpvpUm2fkKVRlxLcc5dmMXlwP0vjCChHKIU6gXRD6da7yGnmv/WMmr6Q==
X-Received: by 2002:a1c:740f:: with SMTP id p15mr1899470wmc.103.1561539480058;
        Wed, 26 Jun 2019 01:58:00 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id j189sm1660211wmb.48.2019.06.26.01.57.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 01:57:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] status: do not report errors in sequencer/todo
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.275.git.gitgitgadget@gmail.com>
 <af4b823caac84899b5ac71da61af5ec00f88bb2f.1561457483.git.gitgitgadget@gmail.com>
 <xmqqo92le6ns.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <51d31257-7093-a0fa-9681-929b9fea059c@gmail.com>
Date:   Wed, 26 Jun 2019 09:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqo92le6ns.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Thanks for the comments

On 25/06/2019 21:44, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> commit 4a72486de9 ("fix cherry-pick/revert status after commit",
>> 2019-04-16) used parse_insn_line() to parse the first line of the todo
>> list to check if it was a pick or revert. However if the todo list is
>> left over from an old cherry-pick or revert and references a commit that
>> no longer exists then parse_insn_line() prints an error message which is
>> confusing for users [1]. Instead parse just the command name so that the
>> user is alerted to the presence of stale sequencer state by status
>> reporting that a cherry-pick or revert is in progress.
> 
> I have to wonder what would happen when "git cherry-pick --continue"
> is given from such a stale state.  It would have to fail as it would
> not know the shape of the change to be replayed, no?

Yes it would fail with
   error: invalid line <line-no>: <line>
   error: unusable instruction sheet: '.git/sequencer/todo'
   fatal: cherry-pick failed

> Is it easy to detect and say "there is an abandoned state file from
> stale cherry-pick" and optionally offer to remove it (as we have no
> chance of continuing anyway)?

I guess we could have a specific error return if get_oid() failed and 
suggest that then

> Or is it likely that such an effort would end up being wasted, as...
> 
>> Note that we should not be leaving stale sequencer state lying around
>> (or at least not as often) after commit b07d9bfd17 ("commit/reset: try
>> to clean up sequencer state", 2019-04-16).
> 
> ...this already happened?

Probably. It is still possible for the user to run checkout in the 
middle of a cherry-pick and forget to finish it but if they're using a 
prompt with git support it should tell them that a cherry-pick is in 
progress as `git status` detects that it is.

>> Also avoid printing an error message if for some reason the user has a
>> file called `sequencer` in $GIT_DIR.
> 
> I agree that it is not a good place for giving diagnostics, but
> getting ENOTDIR would be an indication that next time when the user
> wants to do a rebase, range pick or range revert, it would not work
> unless somebody removes that `sequencer` file, right?  Are our users
> sufficiently covered on that front (e.g. giving "we cannot do this
> operation as $GIT_DIR/sequencer is in the way. please remove that
> file" would be OK, but silently removing and possibly losing info we
> didn't even look at may be bad)?

mkdir() will fail with ENOTDIR which should be reported with 
error_errno() I think.

Best Wishes

Phillip

> In any case, the "unable to open 'sequencer/todo'" you are removing
> with this patch was *not* about helping the issue above which is an
> unrelated tangent, so let me not be distracted by that ;-)
> 
>> +test_expect_success 'status shows cherry-pick with invalid oid' '
>> +	mkdir .git/sequencer &&
>> +	test_write_lines "pick invalid-oid" >.git/sequencer/todo &&
>> +	git status --untracked-files=no >actual 2>err &&
>> +	git cherry-pick --quit &&
>> +	test_must_be_empty err &&
>> +	test_i18ncmp expected actual
>> +'
>> +
>> +test_expect_success 'status does not show error if .git/sequencer is a file' '
>> +	test_when_finished "rm .git/sequencer" &&
> 
> In short, I was wondering what happens if we lose this line, and
> then we later had a command that needs to use .git/sequencer/todo or
> something.
> 
>> +	test_write_lines hello >.git/sequencer &&
>> +	git status --untracked-files=no 2>err &&
>> +	test_must_be_empty err
>> +'
>> +
>>   test_expect_success 'status showing detached at and from a tag' '
>>   	test_commit atag tagging &&
>>   	git checkout atag &&
