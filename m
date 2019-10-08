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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D32A1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHQSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:18:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHQSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:18:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so3765920wmc.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yomP66hov144GjjUti3pEyHt9f7Lg/87NM1W1heZU/0=;
        b=r0t7QrpuoFbAVnu2echfRJswYjqwUCFWwym7WOllKYU9IzWTNppSe6/OSuyTMwhoCf
         0qFJGxuzb1VUjmPjbsfIxUW7E4VaT1vtY6/iL1gSS2ppKsKsapVBazFiHCxrnVrZgaNP
         HPpwMSX+eVEvu91LYjlnV1aB5xr4E1CXCrTxvyyUF3Bo3NuuWLcZhScj58ja3swSw7DO
         uPQg63BGVG5FETJcIL74PZLGzCa08f+YwbQEuYOz6PPaSlf1+4eW95KjukEfxKK19xej
         7xfNMYn/phE7UeG+n5bhNphcI+pIZF17lTLW/4C68HlDlM+b4w9RSA16WpsIh5l8ekdS
         XyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yomP66hov144GjjUti3pEyHt9f7Lg/87NM1W1heZU/0=;
        b=dS+kIcaLZFYkrgo6tgFACLE9DLMiR3ObZ3UvPj3YURzmPBUb50PnO9S53LS+lBoqDS
         zekdenAMW4dCaoGKm792Z6PkZqvcjUob5IUsPSQlRBzbSHpsKlw9WLvwMU/1sOeaujWB
         tg73Ec5Yiteo2Rf3yZHd19Ya40V6yvhVSMXhwfu+tsRVUBWsOegPeh6JzzPElCp6Kdjs
         oAW7+nnw0FERGupuPquu+8RxIb+j/8PxMr1/7KrFKjy6BOOUjdoC2OqKixQ8Hshe8y/X
         m51PHB0mjjL8GSgpXRBb+vPl8XslQ9kGB9FdBhhANI/5XbsZ6Y8WYfBr20hCra3HoBzt
         z+Zg==
X-Gm-Message-State: APjAAAUuSnenpL/qYhr+rT6HMl00qtH5og73PfQ8/FALegXU2SEzN6gd
        gqjj40WnGwQiLgr5Zv/N45o=
X-Google-Smtp-Source: APXvYqxbv/49BSZum000ZRs9h2rdmlQhgW4gWQVeExlirHPy4usBBfjBp+qzy8yPWsiRGrRaYU8Qdw==
X-Received: by 2002:a1c:7e44:: with SMTP id z65mr4405669wmc.21.1570551516735;
        Tue, 08 Oct 2019 09:18:36 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.gmail.com with ESMTPSA id a3sm6040099wmc.3.2019.10.08.09.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:18:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Use complete_action's todo list to do the rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20191007092641.12661-1-alban.gruin@gmail.com>
 <xmqqmuecnefe.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <49b2fa05-5954-fa17-3f5a-5c4e11e11192@gmail.com>
Date:   Tue, 8 Oct 2019 18:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqmuecnefe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 08/10/2019 à 04:45, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> This can be seen as a continuation of ag/reduce-rewriting-todo.
>>
>> Currently, complete_action() releases its todo list before calling
>> sequencer_continue(), which reloads the todo list from the disk.  This
>> series removes this useless round trip.
>>
>> Patches 1, 2, and 3 originally come from a series meaning to improve
>> rebase.missingCommitsCheck[0].  In the original series, I wanted to
>> check for missing commits in read_populate_todo(), so a warning could be
>> issued after a `rebase --continue' or an `exec' commands.  But, in the
>> case of the initial edit, it is already checked in complete_action(),
>> and would be checked a second time in sequencer_continue() (a caller of
>> read_populate_todo()).  So I hacked up sequencer_continue() to accept a
>> pointer to a todo list, and if not null, would skip the call to
>> read_populate_todo().  (This was really ugly, to be honest.)  Some
>> issues arose with git-prompt.sh[1], hence 1, 2 and 3.
>>
>> Patch 5 is a new approach to what I did first.  Instead of bolting a new
>> parameter to sequencer_continue(), this makes complete_action() calling
>> directly pick_commits().
>>
>> This is based on 4c86140027 ("Third batch").
>>
>> Changes since v1:
>>
>>  - Rewording of patches 1, 2, 4 and 5 according to comments made by
>>    Phillip Wood, Junio C Hamano and Johannes Schindelin.
>>
>> The tip of this series is tagged as "reduce-todo-list-cont-v2" at
>> https://github.com/agrn/git.
>>
>> [0] http://public-inbox.org/git/20190717143918.7406-1-alban.gruin@gmail.com/
>> [1] http://public-inbox.org/git/1732521.CJWHkCQAay@andromeda/
>>
>> Alban Gruin (5):
>>   sequencer: update `total_nr' when adding an item to a todo list
>>   sequencer: update `done_nr' when skipping commands in a todo list
>>   sequencer: move the code writing total_nr on the disk to a new
>>     function
>>   rebase: fill `squash_onto' in get_replay_opts()
>>   sequencer: directly call pick_commits() from complete_action()
>>
>>  builtin/rebase.c |  5 +++++
>>  sequencer.c      | 26 ++++++++++++++++++--------
>>  2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> Diff-intervalle contre v1 :
>> 1:  d177b0de1a ! 1:  9215b191c7 sequencer: update `total_nr' when adding an item to a todo list
>>     @@ Metadata
>>       ## Commit message ##
>>          sequencer: update `total_nr' when adding an item to a todo list
>>      
>>     -    `total_nr' is the total amount of items, done and toto, that are in a
>>     -    todo list.  But unlike `nr', it was not updated when an item was
>>     -    appended to the list.
>>     +    `total_nr' is the total number of items, counting both done and todo,
> 
> The same s/amount/number/ needs to be done to the log message of
> patches 2/5 and 3/5.  Other than that, updated log messages looked
> much more understandable.  Thanks.
> 

Ouch, sorry about that.  Thank you for fixing them.

Cheers,
Alban

