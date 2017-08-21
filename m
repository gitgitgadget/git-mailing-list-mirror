Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92B9E208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbdHURsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:48:12 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35309 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753926AbdHURsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:48:11 -0400
Received: by mail-yw0-f176.google.com with SMTP id s187so10162750ywf.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ph+1qdgOTt+fBEfEMlU2Oet+unwPfc//6i9sKum7+eY=;
        b=QLW9aZTMYHQWOTMqlOIWvN9bi1ZJmGeJXvQJrk89d5tCOtRrn5zwmy01EpOQk0q0Nf
         fLDco7Tbx2OyFuBAK9hsP4qs/AXy046o7rQhZ65hVgML2ho2f096Q4+2jUgeZjJlkh+6
         1WKc5bVS52dGQrcBUDHjEQPQgFUNVOM2sUjXMfzDGsGM50Ekk5HBUtIhi9zd7/HYCghz
         Ok6M1TMmE53g4EE6GHtayaWBIspSStHkbs9JhGBpIIhBfvwqvKT+1aZqULyYxRzvt/y8
         Tm2JU/qG1wjkwEzWeuHjsVVxUbqpaz6pdYmecri48KnZ9ZHMp3jKxS5MZnrM7xSWC0Dw
         H/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ph+1qdgOTt+fBEfEMlU2Oet+unwPfc//6i9sKum7+eY=;
        b=bFUE17Xl6MwukC920YbGQp/65zoulr9/MmcYW75rwAr4MySwEL2E0X2hwIA6+69L3N
         cGMPhIPTp47rvrXu27xMCLUdriFhmvOUwmAJ4yqnOXXI5/QQmtAY1PFS5OAf8KlX7YnX
         BiBv9GiSAeqOVtiadPrN5DMl7sZb0Z7KFDHAhXDY6KM+smrWescWttjFjwtz59iJYTU+
         9WQCegVrRjS5avFN8wSbpPFf1+k5MdlWG19ireqTVLKSrSrb0bbuXry3pgcZFHh+FeaR
         f4mjII2JE4BuqKdKFwnwVTrH8FefIB/Smu7jHu7wc+/KbG2X7u118C9gOw4LN6wbpQ2P
         v/LQ==
X-Gm-Message-State: AHYfb5jIKj4sCqPRjpnlh9230W2r218p3SfrI0oGejufTxHAfZFEb8EV
        hibSeaNTyxUEoCCyBUlmZtLKU0kozFDA
X-Received: by 10.37.123.129 with SMTP id w123mr15739363ybc.305.1503337690840;
 Mon, 21 Aug 2017 10:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 10:48:10 -0700 (PDT)
In-Reply-To: <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com> <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com> <20170821162056.GB1618@book.hvoigt.net>
 <CAGZ79ka1jyxmATQbrjPHAv3227UJNcN0nw9AY-RZXnNahepoGQ@mail.gmail.com> <85ED93BC-1E27-4B8D-856D-090C6860BAB0@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 10:48:10 -0700
Message-ID: <CAGZ79kZMjGNOn0FnJGtO5gRY3rF0Eiow8n0uppTZsCUAHY+m3A@mail.gmail.com>
Subject: Re: [PATCH] pull: respect submodule update configuration
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 10:20 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 21 Aug 2017, at 18:55, Stefan Beller <sbeller@google.com> wrote:
>>
>> On Mon, Aug 21, 2017 at 9:20 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>>
>>>> So I am a bit curious to learn which part of this change you dislike
>>>> and why.
>>>
>>> I am also curious. Isn't this the same strategy we are using in other
>>> places?
>>>
>>
>> I dislike it because the UX feels crude.  When reading the documentation,
>> it seems to me as if submodule.<name> can be one of the following
>>
>>    (none, checkout, rebase, merge, !<custom-command>)
>>
>> This is perfect for "submodule-update", whose primary goal is
>> to update submodules *somehow*. However other commands
>>
>>    git rebase --recurse
>>    git merge --recurse
>>    git checkout --recurse
>>
>> have a different primary mode of operation (note how their name
>> is one of the modes from the set above), so it may get confusing
>> for a user.
>>
>> 'none'  and '!<custom-command>' seem like they would be okay
>> for any of the commands above but then:
>>
>>    git config submodule.<name>.update "!..."
>>    git reset --hard --recurse
>>    git status
>>    # submodule is reported, because "!..." did not 'reset'.
>>
>> Anyway. That dislike is just a minor gut feeling about the UX/UI
>> being horrible. I wrote the patch to keep the conversation going,
>> and if it fixes Lars problem, let's take it for now.
>
> Well, I need just a way to disable certain Submodules completely.
> If you show me how "git config --local submodule.sub.active false"
> works then I don't need this patch.
>
> I tried to make it work here:
> https://public-inbox.org/git/89AB8AA3-8E19-46BA-B169-D1EA4CF4ABE7@gmail.com/

(A) you need to set expect there as well, to have sub{2,4,5} be expected
there as well.

(B) That may hint at another (UX) bug.

The test case there uses "git submodule update --init".
The init flag will set all submodules to active.

Maybe you want

    git config submodule.active ":(exclude)sub0"
    git config --add submodule.active ":(exclude)sub2"
    git config --add submodule.active "."
    # Read: anything except sub0 and sub2 are interesting

    git submodule update
    # no init flag, needed even for new submodules IIUC
