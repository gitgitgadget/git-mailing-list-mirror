Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5B251F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbcIAWq2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:46:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33285 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbcIAWq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:46:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id w207so535617wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 15:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lj2KpvGxx12q3uYh+3QCrPASr9QhlOGSvIfw7m3NMSY=;
        b=z+rYbF+vgNGVLeJihqiexpBdYTmJ0LcIkpRPYzETqm39DVcRig9z8620EOb2iHzo78
         rP68jDtBFYJpWhpfswNQMdwXN1ym/1JwlroPguUMFYAGq/zeENWDChVgfT3jMjshmjPv
         bJ2QCL/gvb5EHJNj1MlFrXOKalCnB2+O7Xw2UR943EGwi0MynTfmtWD/sT2aW+KSuVmy
         A2rC1PHmVVHQqsKABqvCs/R9Hcyxi+tf9F+PIY7m+QBidCgar4CRc89WcVOVWvAO8FbT
         pudz3IbxbGDvwddO5c4KTV0KHWI10bbDd1kghMvVHJOnPIkJL4ik9HSwygcdEQMI9TN7
         u7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lj2KpvGxx12q3uYh+3QCrPASr9QhlOGSvIfw7m3NMSY=;
        b=aCPOsGUoFLMqUtoO10sbg2wScPdVkicHfaveUNZ39X/fO2b1XpCVzSQUrM2b7ca7gn
         eJuV0E+opBNn655Dpf5LBHDAmFIdMjAX6Gamw75WbrRk+LiSXkwI2uvl1Iow0lVns2xP
         bjUGRDHyvSAC7lJVQdA8IwuSVIMFoHv3LXoni/24ZnRrUI0LzAhRTSn0bnAglGb4KOKv
         2Biwo+k7awijkK+kBLdDLokDbzJkiNV2v1u3KEdzhQzc7pqrhhazb+fssHJHVUr8xkYM
         RDeep7Okb1kUVmrWgggKvqUYDqbaPTzuPn+OI7ATc+TRhYTg16f8VeRaXMTuW6br8crU
         2dcQ==
X-Gm-Message-State: AE9vXwOX7JOfqgZG4pHyw9L8rwzOi/MPyY2h/9VkEcNx9F2KqEQ/AAc5txRSXv4nyk8dJQ==
X-Received: by 10.28.20.77 with SMTP id 74mr77879wmu.1.1472769986063;
        Thu, 01 Sep 2016 15:46:26 -0700 (PDT)
Received: from [192.168.1.26] (abrf30.neoplus.adsl.tpnet.pl. [83.8.99.30])
        by smtp.googlemail.com with ESMTPSA id c8sm7407481wjm.19.2016.09.01.15.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 15:46:25 -0700 (PDT)
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
 <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
 <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1609011052260.129229@virtualbox>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <63004be3-04de-00c5-a94d-1b600201bc6f@gmail.com>
Date:   Fri, 2 Sep 2016 00:46:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609011052260.129229@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 01.09.2016 o 11:37, Johannes Schindelin pisze:
> On Wed, 31 Aug 2016, Junio C Hamano wrote:
>> Jakub Narębski <jnareb@gmail.com> writes:
>>
>>>> diff --git a/sequencer.c b/sequencer.c
>>>> index 06759d4..3398774 100644
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>>>>  struct todo_item {
>>>>  	enum todo_command command;
>>>>  	struct commit *commit;
>>>> +	const char *arg;
>>>> +	int arg_len;
>>>
>>> Why 'arg', and not 'oneline', or 'subject'?
>>> I'm not saying it is bad name.
>>
>> I am not sure what the "commit" field of type "struct commit *" is
>> for.  It is not needed until it is the commit's turn to be picked or
>> reverted; if we end up stopping in the middle, parsing the commit
>> object for later steps will end up being wasted effort.
> 
> No, it won't be wasted effort, as we *validate* the todo script this way.
> And since we may very well need the info later (most rebases do not fail
> in the middle), we store it, too.

The question was (I think) whether we should do eager parsing of
commits, or whether we can do lazy parsing by postponing full parsing
"until it is the commit's turn to be picked or reverted", and possibly
when saving todo file.

I wonder how probable is situation where we save instruction sheet
for interactive rebase, with shortened SHA-1, and during rebase
shortened SHA-1 stops being unambiguous...

>                                [...] after parsing the todo_list, we will
> have to act on the information contained therein. For example we will have
> to cherry-pick some of the indicated commits (requiring a struct commit *
> for use in do_pick_commit()). Another example: we may need to determine
> the oneline for use in fixup!/squash! reordering.
> 
> So: keeping *that* aspect of the previous todo_list parsing, i.e. store a
> pointer to the already-parsed commit, is the right thing to do.

The above probably means that eager eval is better

Best,
-- 
Jakub Narębski

