Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3931D1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeFRREb (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:04:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39851 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932762AbeFRREa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:04:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so17609494wrn.6
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E5pmPeSeTpASFJKnmN61nB4VCS4PCqRCyAamvIBl+WM=;
        b=EgymLc16TU0RDhD0f1vsjMmTzBzq8S03yikWk3Qk0GqXB+C5lWEmjCDLUScLOIFQxp
         aZH003AKZg4Gv7/fuxL9AlSQy4swlBsj69caIRP3HUfmj45Q13vN2rFIw5IPks32GLEg
         8LbwxDp4TQp+HwR3pgfburQ0J2Z41vTAGi2fBFenEyTNZryBZCumFmBV9qZZO74YhOTi
         Kz/1GyuBuLGkcxVVszcgJ+t9zP5gUj0UvHZ2uN8PA/MP6g2Zcfi5Ao1djo6Hbi1IpTJJ
         MSygBchyzA20OfawqFLz7OfZUitSBZ9sxaJDJKsnxPgPS2+8GWsecVToPpKi5NgPv3ge
         x0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E5pmPeSeTpASFJKnmN61nB4VCS4PCqRCyAamvIBl+WM=;
        b=PIvGd4cS6oZZcc6q3hCv/iAB5UOTSH25QajYKtwbOEODfGemqvTJ+Dm/zI6BnGmKse
         avy5Ugqmc/QLP4MLbCJB8/4AEoryrciN9kBXxp+vOEblAwHR/GGFr80/IxhlEyKq2Gk1
         N4XWGGleyVwPt7/8+LwwUlcGwoC5mSjt1e1mfuDMIytHeCZhKWXAYOx7iZCxvEs7Yx0B
         hoavmdwE0avu9z2JtAz8IuCT9Ukx0J7SocdLi1/1riA8l2cUALGakBbXt+Y8O1gkdFbC
         gJTS0oGw0sKbNev59PKOeQ3nyxei2rndS9ttuw/4bHBiNTQM2AjSpXNMbDUkRo8rQta5
         +yzQ==
X-Gm-Message-State: APt69E0uqaQ/jzu3Z3q6vAbthcIPXAtZNHm+yfSySv9nQWUOUvE05naM
        9vw+6B/pmvCjWR+lDt1l2BvtcDAJ
X-Google-Smtp-Source: ADUXVKJqBSUas35lEhnR0RlQH9l82QeBFNCLgu0/H/9H5rOE+4LT6KGv34NHFrwM3FRKrq2OH90Img==
X-Received: by 2002:adf:be81:: with SMTP id i1-v6mr10931875wrh.86.1529341469217;
        Mon, 18 Jun 2018 10:04:29 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id b186-v6sm9306119wmh.4.2018.06.18.10.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:04:27 -0700 (PDT)
Subject: Re: [GSoC][PATCH 2/3] rebase -i: rewrite setup_reflog_action() in C
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-3-alban.gruin@gmail.com>
 <6583e68e-3aeb-3afa-8e13-9391b77e4fe7@talktalk.net>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <f7320b16-a543-11c1-d511-fd95ec7a7f8d@gmail.com>
Date:   Mon, 18 Jun 2018 19:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6583e68e-3aeb-3afa-8e13-9391b77e4fe7@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Le 18/06/2018 à 17:34, Phillip Wood a écrit :
> On 18/06/18 14:18, Alban Gruin wrote:
>> This rewrites setup_reflog_action() from shell to C.
>>
>> A new command is added to rebase--helper.c, “setup-reflog”, as such as a
>> new flag, “verbose”, to silence the output of the checkout operation
>> called by setup_reflog_action().
> 
> I'm having difficulty understanding what that means, surely the verbose
> flag is to stop the output from being silenced.
> 

I reversed the meaning of the flag, I will correct it in a reroll.

> I'm not that keen on the naming in this patch, if it's only a staging
> post and will be removed it probably doesn't matter too much. I can see
> why you've based the function and flag names on the shell version, but
> the C version is not setting up the reflog it is checking out the branch
> we're rebasing. --checkout-base or something like that would be clearer.
> 
> Also the name of the function that does the checkout is tied to checking
> out the base revision, but then reused in the next patch to checkout the
> 'onto' commit. As such I think it would be clearer if it was called
> run_git_checkout() or something like that.
> 

Right.

> One further thought - how easy would it be to refactor the code in
> do_reset() to handle the checkouts in this patch series, rather than
> having to fork 'git checkout'
> 

Good remark, I did not notice do_reset().  I intend to refactor and
optimize after I have done (most of) the conversion, so this goes into
my todo-list, but it does not really seem difficult at first sight.

Cheers,
Alban

