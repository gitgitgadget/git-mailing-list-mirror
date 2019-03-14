Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF87B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 11:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCNLCx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:02:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39198 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfCNLCx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:02:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id p8so5347990wrq.6
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGWoioMquqnDXJ+cUmFQObUozD2gNPzZhUDqOR5hWh4=;
        b=U5oiIT/lkh+Eg7Q3WUUuchz4Jo1jjRhJbsARDK5f/DwHoHjqUYLMbGBPaxoAyvsQt5
         YgjgW4JMUkAC0qQZ0R1l420ovyEmaI/igxYlmK9/w51wWosWuWk2U4yO+pflPyK4HdGu
         km5gZ2Fy/MvoVQFcLzGoa2lotJ/pjSHa9fWOq1Z7ymZgxtidQ7SzpUJWu6dJZ3vyTkn/
         u+MAWiLX6w/cVcdcx0BYd+d83PsNCWp70lRYVzQKwHzPLv5FAhwoNeU5tEc3374TSuae
         5V9SUAuifPktjz+Z/6Oppeg5X4DHPWpNC7cN+UUbm1r5qVvy31rh/SgUoqUoae40tWJL
         Y+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGWoioMquqnDXJ+cUmFQObUozD2gNPzZhUDqOR5hWh4=;
        b=f2ohlGkv0K6DbDc7bGEQdi/TFv6Pash31HD38KE/VkAsqRNNzqcU/LxLbCXzJ+YoCV
         YFOlfahDotSYc3wZUcMfpZAUtbO+3I7XDhpoj2k5GTyFP2JLepABFtOl/U7xsAi+EWjc
         lPtvdKGcBOqe+Ensund/KNB87t4Mbp2iITn+Y4xcDrpVCxqfKTZvhxRzr1QMppuMbAi7
         7dqpR1yqdOUrHy/Zp6woP22YUtYaRKZn4YkS6sfCdP/P6XqKASSkHouUhEmssXs1D7S6
         3YNzFJaggKcfaHw4UWS6bpKJJTmQQ8AXHQ4tygDB5iIxsyMdxr0uBwZO2LFdQ/ZWXwov
         Ny6w==
X-Gm-Message-State: APjAAAVN+E2lVhMK12TXL0uTUr10WmolCAtrBjXwcBqJg/XcjMtnBAqL
        FtXlOlBIEq+Bs15La8jz6YbtLzJdhdLWIQ==
X-Google-Smtp-Source: APXvYqzVPvU8CtAQJ32Pj4J4Cpk1bDlFQ1PUhVAC/KQRwUBi26k6Gf3T4fYi0PCd6HHzpLuScmVdBw==
X-Received: by 2002:adf:9dc7:: with SMTP id q7mr2214833wre.316.1552561371038;
        Thu, 14 Mar 2019 04:02:51 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.googlemail.com with ESMTPSA id y8sm11496744wrm.8.2019.03.14.04.02.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:02:50 -0700 (PDT)
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
To:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
 <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
 <20190314091753.GA9852@ash>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5cd15ff0-8913-9b92-6ddb-94eff6f22077@gmail.com>
Date:   Thu, 14 Mar 2019 11:02:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314091753.GA9852@ash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2019 09:17, Duy Nguyen wrote:
> On Tue, Mar 12, 2019 at 01:28:35PM -0400, Eric Sunshine wrote:
>>>> Again, not much of a datapoint, but I do use --orphan periodically.
>>>> The idea of "fixing" the behavior so that --orphan starts with a clean
>>>> slate is certainly appealing (since it matches how I've used orphan
>>>> branches in each case).
>>>
>>> The only three people who have commented on --orphan in this thread
>>> all apparently feel the same way: the current behavior is wrong.
>>> Maybe we can switch it to start with an empty index after all?
>>
>> Starting empty may match intuition better. (More importantly, perhaps,
>> it's harder to come up with a use-case for --orphan which doesn't
>> involve starting with a clean slate.)
> 
> OK so the new --orphan description would be like this, right?
> 
> --8<--
> --orphan <new-branch>::
> 	Create a new 'orphan' branch, named `<new-branch>`. If
> 	`<start-point>` is specified, the working tree is adjusted to
> 	match it. The index remains empty (i.e. no file is tracked).
> -->8--

What happens if no <start-point> is given? Do you end up with an empty
working tree or the current one? I'd lean towards an empty working tree
(with a check that there are no uncommitted changes, users can use
`restore` if they want some of the files back) but that is inconsistent
with the implicit <start-point> of -c.

Best Wishes

Phillip

> I was wondering if instead of the empty index, we mark on files from
> <start-point> as intent-to-add. That way "git commit -a" achieves the
> same as before, but you could still carefully craft the new index and
> "git commit". Dunno. Not going to implement it unless somebody says
> something, since I rarely (if ever?) use --orphan.
> 
> I may need someone to come up with a convincing commit message
> too. All I've got is "I've been told this is a good thing to do" :)
> --
> Duy
> 

