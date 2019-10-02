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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3081A1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfJBShJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:37:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44309 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBShJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:37:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so131680wrl.11
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wC4PLSB/Vmw6ooY/6N3NGYiM2tXLEx7wGEbRkZQzy5I=;
        b=Zzx8C7twwttfyZEg03lhkfzi5nXzYj+CUPJLI4n2Ai/bx1WNvv8woKb1ap6hCBJ1op
         NzyE4yVBbVrtUCj+JFrJfJ8cSDdldoPwqkP5WstdIWNXbw6iKWyodmvme/cyoS1WnxfH
         jSKkN9Tz6hHdvmxaqKAH3kW+dCym49sgtIcKA6vSkW8Zu7mDT4XJMZzKWSbc3f2Axim/
         Wqc9WZoIvkXkgfStb0MNyaLGbBVlNcfD7sm1MtIZ0Wv8x4Pw6JmkOi3QikV4FiRSb+Gi
         8Kqw3FQNLoKeHAQ1BLkkJ4HCBbSLfGHMza+6yal/qLw5yhip3a1buR3v6U4qtjq826kG
         sKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wC4PLSB/Vmw6ooY/6N3NGYiM2tXLEx7wGEbRkZQzy5I=;
        b=p5b5ubb3qyCcLE3lIBXY7AVpuQMlQ6jMRnCb2fO5U6q+EDcSOL0Uv9hhvtFXdz8C8E
         +be27zbFLtq9GOvwHlQ3Z1IzZYH788CEPddWccOSEWVLiaSjSG74aKLkQwqf/WJPbDcW
         sOcB7Xvq4cOUCELheiWKCy+4o+TPjFc4A/MnHJNiHMYhR7nZ+B3rfOw/jjGoiA1CqfM8
         trT8bw9geXixbnLt91TsUpAE3qx3lkFos33WumN+GN6YCnal1M4FKsMnN52E/grRZ0Ba
         q76pjByRgaUp7DHQSg/PwyV/pS/iNovNL9kqwynZi6vuu8LgX42oKQNnLUPP4W0r3Zzv
         3ZGQ==
X-Gm-Message-State: APjAAAXLZjcnSMQJ5nYvdYj9d8x2F7hhc/vz41rzUkAwiAYdEk4zVzmf
        N6ChHizfKrj79FBN5sM8XUo=
X-Google-Smtp-Source: APXvYqyLZiyQBdMOPEWDMSeGCbvWBTKY5dKmTM2AbUxchawfH4i9GbNN25l0KRLkX+9ReGv2e3KLiw==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr3772228wrn.200.1570041426115;
        Wed, 02 Oct 2019 11:37:06 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-236-54.w90-38.abo.wanadoo.fr. [90.38.111.54])
        by smtp.gmail.com with ESMTPSA id f18sm341965wrv.38.2019.10.02.11.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:37:05 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-6-alban.gruin@gmail.com>
 <xmqq5zl7hnwe.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c276de00-fffb-c483-e1b9-526052544fe8@gmail.com>
Date:   Wed, 2 Oct 2019 20:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zl7hnwe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 02/10/2019 à 04:38, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> Currently, complete_action() calls sequencer_continue() to do the
>> rebase.  Even though the former already has the todo list, the latter
>> loads it from the disk and parses it.  Calling directly pick_commits()
>> from complete_action() avoids this unnecessary round trip.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>  sequencer.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> All the earlier steps in this series are necessary because the
> inconsistencies caused by not doing things the code updated by the
> earlier steps do (e.g. leaving number of commits recorded in
> total_nr and done_nr stale) were masked by re-reading the info from
> the on-disk file.  And this step exposes these inconsistencies
> because the extra reading from the file no longer happens.
> 
> That is my reading of the series---did I get it right?
> 

Yes.

> I wonder if that can be stated clearly in the log message of the
> earlier steps.
> 
> For example, by reading 1/5 or 2/5 alone, it would be natural for
> readers to wonder why the original code that did not update done_nr
> correctly terminated after going through the todo list (you would
> expect that when done reaches total you are finished, so if one of
> these variables are not maintained correctly, your termination
> condition may be borked), and then by knowing that the current code
> more-or-less works correctly by not terminating too early or barfing
> to say it ran out of things to do prematurely, the next thing
> readers would wonder is if these patches introduce new bugs by
> incrementing these variables twice (iow, "does the author of the
> patch missed other places where these variables are correctly
> updated?")
> 
> 1/5 for example talks about the variable mostly being used by
> prompts, which may be useful to reduce worries by readers about
> correctness (iow, "well, if it is only showing wrong number in the
> prompts and does not affect correctness otherwise, perhaps that was
> why the current code that is buggy did not behave incorrectly").
> But I suspect that it is not why these changes in the earlier steps
> are acceptable or are right things to do.

Interestingly, it is the only reason for these two patches.  If you skip
them both, t34??-*.sh will not fail, only t9903-bash-prompt.sh will.
This is because `total_nr' does not reflect the real number of items in
a todo list, but the number of steps, done *and* remaining.  When a
rebase is resumed, some commands may already have been run, and are no
longer part of the todo list.  So, it’s not used to determine whether or
not the rebase is done.  `nr' is used for this purpose.  `done_nr' and
`total_nr' are just used for user interaction.

>  So, perhaps replace the
> "these are used only in prompts and the numbers being wrong does not
> affect correctness" comments from them with:
> 
>     By forgetting to update the variable, the original code made it
>     not reflect the reality, but this flaw was masked by the code
>     calling (sometimes unnecessarily) read_todo_list() again to
>     update the variable to its correct value before the next action
>     happens.  At the end of this series, the unnecessary call will
>     be removed and the inconsistency addressed by this patch would
>     start to matter.
> 
> or something like that (assuming that the answer to the first
> question I asked in this message is "yes", that is), or a more
> concise version of it?
> 

I will do so.

Cheers,
Alban



> Thanks.
> 

