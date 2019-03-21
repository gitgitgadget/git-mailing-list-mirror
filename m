Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC6F202BB
	for <e@80x24.org>; Thu, 21 Mar 2019 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfCUOfQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 10:35:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35430 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfCUOfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 10:35:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so2992041wmd.0
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=upNQvsF9e0M1+vtEXkaSe16d0u+ElbCFNoYN9Ee3H1k=;
        b=sGkR5yPnwhRbPbl/bUif6GQHoymcpV0qklCKKYwMwZW4x1puC3/rezFYcBMHjoR0XN
         DzpZtpO21QdtOWXFlnRwtnNxOigqVgQd4EkQWIAxBkgUDwiM+mBuZaJMSXCWfOACMMe6
         a8MeOQQpukDPYMU69Vpe6Ex2/cHLWrDC8ahzOzNkjHJbjvw8zTUvVkCPhEsb976IG0rZ
         UYs/DNa2UfCOkvf4psd9ka54e7M3N0MuhxIVzkrF6qZDwiRDDQYAS0tGPVq3v06U7Qp2
         XCJgIyuAIJ4vBd/grvSZSNCsL2CHZs+6MHvK3NrE1Qvc+YQ1JubvtdUuARLjri9p9W3B
         aFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=upNQvsF9e0M1+vtEXkaSe16d0u+ElbCFNoYN9Ee3H1k=;
        b=ubWZ5FkxJ40aXKs8wGSWqpEZ5sQG8648vj/OMztiJ+A6m9YGssQFokwQmjvpAWTTJK
         t/cQE7xFeqVI+C6zWoIHk82wQyI3/KPWNHrJJ/6BxvIsVgtsUjAAo3XT0WYyHv94mmzm
         wfPl+pZir4M3oXCzdp4MnhuOI4giNn2qPXCAqLNwUr2HHb1mdw5Lz2JlhqPjpshISjbj
         XOS0008U8Q44WGW0Lrwev9mcFSvXDOXbVxjhj5Oe7VUnKoCwF7Z7Lrm5Dm1L00Usnsoi
         qhl7HHlLMvTgEy41tuLXuQB86zGw/VJoqb3dlKcvTktHfT7laigEsx8xiGxSqdHftgBO
         m32g==
X-Gm-Message-State: APjAAAUTTG/d31aoi45kvUuRemTF3bRZ8rgkByv658pT6AKibRS5NTjj
        aSNLqxAm7Cg4yfD0SIHhVMo=
X-Google-Smtp-Source: APXvYqwP2HnmEZNhxw6BoU73D7jKs4mPc/tjFtAxjO2clP9mAYjGRl9hi+FK4ffPH7ujy5rDGtrgRw==
X-Received: by 2002:a1c:3543:: with SMTP id c64mr2873120wma.75.1553178914245;
        Thu, 21 Mar 2019 07:35:14 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id a204sm6819479wmf.12.2019.03.21.07.35.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:35:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 01/11] sequencer: always discard index after checkout
To:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190319190317.6632-2-phillip.wood123@gmail.com>
 <CACsJy8CRN1NUD1DdKXkOoaYqCU_RJU56ph=eBAGSS-EXMAcmww@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8c663552-b792-b885-ea59-abe3137efe26@gmail.com>
Date:   Thu, 21 Mar 2019 14:35:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CACsJy8CRN1NUD1DdKXkOoaYqCU_RJU56ph=eBAGSS-EXMAcmww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/03/2019 01:50, Duy Nguyen wrote:
> On Wed, Mar 20, 2019 at 2:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>      It would perhaps be better to pass around the_index rather than
>>      the_repository
> 
> Not by a large margin. For sequencer.c most operations require more
> than just the index and passing 'struct repository *' around has been
> the norm. And as soon as you need to load the index back (not sure if
> you should do it here btw, after discard_index, since we have the
> index loaded before) you need 'struct repository' not 'struct
> index_state'.

Thanks, I think I'll leave it as it is then. After we checkout the new 
base we reload the index in the loop that picks the commits. For 'rebase 
<upstream> <branch>' after we checkout <branch> we create the todo-list 
which involves a revision walk and then checkout the new base. I'm not 
entirely sure if it needs reloading before we create the todo list but I 
think it probably not as I don't think rebase--interactive.c loads the 
index (which would explain why this only becomes an issue when we stop 
forking rebase--interactive from rebase because then rebase.c has loaded 
the index to check there are no uncommitted changes)

Best Wishes

Phillip



> 
>>   builtin/rebase--interactive.c |  2 +-
>>   sequencer.c                   | 27 +++++++++++++++++----------
>>   sequencer.h                   |  3 ++-
>>   3 files changed, 20 insertions(+), 12 deletions(-)
