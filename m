Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCF81F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 18:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfDWSNK (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 14:13:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41707 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDWSNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 14:13:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9so1989027pls.8
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aUc9A3bwK6CHwZZqCSZoqIiVXNd8h5e7NTcNCmehQRg=;
        b=oTCrKe+MFTf1er/fqwv7ZeqW6uC2XlJmSw0dZWnzFv7FOz82bUpdPQKeX5XdmZCibP
         9EX8qeRvSsY1pNKBFjxhImXR7XuzQft/3KXugomqynSEEoPqcx9JaqKjIbvmyU8zNCqo
         5t05eKwhpXiYdPmtnL4EEf6PsecaXtfLm3BekvBzGu8BrgKEqb1kd2sR2sQdkmIihF5k
         SMJ0gZzTQp3KRxx/57ouMchMZ1x6cMK+jP6E4zLAkZ+Vyt8yrEswTul5q3rbZC5K7AdL
         C+OUrvOdFpqoogkazy4aYw8SmBX/UbzDdyb8jjR+0GWYY7b5meWkJQiUK1hJ2r5m5Orq
         Q9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUc9A3bwK6CHwZZqCSZoqIiVXNd8h5e7NTcNCmehQRg=;
        b=Rg81jvmq5SQOaBEYko5ctSTdDubUt8BpQKuN4PbO2/qmoyh8YQ6IKdJKHAazFMIOwq
         smML+ppWXSNm3qm2kbrgWM6cfmqvy1tRnfQlONZc2NZjZ3ZWFZaO8pppsF+SNfwqHOn9
         vK6Y20F4JEM80yhsbRb8oZu7FeLORw0BAm0SIcfJxYDGpMP6+Cq0k81jhE5p1+5ESbFX
         a+CkGnkgkMarVCmTPDzHwDprbRSMXAOHbYBNCsMWCJqrLqS+Vix4PDlycYT5fu1xCNZW
         BADe94GhBf/WBnP0jsT6Rarl9rWzRwW8k5ZyVDYY3PSFyN6JjiRkbyp4/lTbvcc09lv4
         ggkQ==
X-Gm-Message-State: APjAAAUqoBPJyZX0yFay1dJMOl4+/uwhginrFbVCE9cv6qzxddEBiLGS
        Mjjoum4rQVh391k2wWFFUZ+1TA==
X-Google-Smtp-Source: APXvYqyFf7ilIo+T6M7s4jkZ5AAZeNPSUAk4ePTLI26QGW0OfJi1tzzcNiPC2ZUFRgy6qt9rGZnx2g==
X-Received: by 2002:a17:902:86:: with SMTP id a6mr27259000pla.277.1556043188959;
        Tue, 23 Apr 2019 11:13:08 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id h8sm22778466pfo.149.2019.04.23.11.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:13:07 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
 <20190422222647.48628-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <533f7721-2af6-1137-17c1-065837e1321d@google.com>
Date:   Tue, 23 Apr 2019 14:13:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190422222647.48628-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael -

On 4/22/19 6:26 PM, michael@platin.gs wrote:
> +	int *matching_lines = fuzzy_find_matching_lines(parent->file.ptr,
> +							target->file.ptr,
> +							parent->line_starts,
> +							target->line_starts,
> +							e->s_lno + offset,
> +							e->s_lno,
> +							parent_len,
> +							e->num_lines);

Here was the issue I ran into, and it's due to translations between 
e->s_lno and the parent's "address space".

The short version is that "e->s_lno + offset" is not always the 
parent_slno, and parent_len is based off of parent_slno.

guess_line_blames() gives you parent_slno and parent_len, as well as 
offset.  'offset' is how you convert from the target's space to the 
parent's.  parent_slno and parent_len describe the whole chunk given to 
us from the diff engine.  However, there may be multiple blame_entries 
covering that chunk.

So e->s_lno is in the target, but it's not necessarily the beginning of 
the entire diff chunk.  This is related to that page fault you found a 
while back.

Passing e->s_lno + offset for where fuzzy() starts looking in the parent 
is fine, but then the length in the parent needs to be adjusted.  For 
instance, I have this at the top of my modified 
fuzzy_find_matching_lines() (changed to take the origins and variables 
from guess_line_blames()):

         // XXX conversions to michael's variable names
	int start_a = e->s_lno + offset;
         //int length_a = parent_len;    // XXX this fails the test
         int length_a = (parent_slno + parent_len) - (e->s_lno + offset);

	int start_b = e->s_lno;
         int length_b = e->num_lines;

Plus we need a check for length_a <= 0.  I had to work to make it be 
negative, but it's possible.  parent_slno = tlno + offset, so we're 
looking at:

	length_a = tlno + parent_len - e->s_lno;

That just requires a blame entry split such that e->s_lno > tlno, and a 
parent chunk that had 0 lines.  I found a case that did that.  Basically 
in one commit you add a bunch of lines.  In another, you change one line 
in the middle of that bunch.  That causes a split of the diff chunk into 
more than one, such that e->s_lno > tlno.  That original commit only 
added lines, so parent_len == 0.

The intuition for the "negative length_a" isn't that the parent_len is 
negative, it's that the e->s_lno chunk (when offset) is outside the 
window of the parent's change.  I have a simple test for this.

Oh, and we have to length_a == 0, due to this:

	max_search_distance = length_a - 1;

Anyway, I'll take what I've got and apply your latest and see what I 
come up with.  =)  Plus, I have fixes for all of the other stuff brought 
up in the v6 discussion.

Barret

