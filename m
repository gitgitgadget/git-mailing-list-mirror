Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25E21F404
	for <e@80x24.org>; Wed,  5 Sep 2018 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIFCSw (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 22:18:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40745 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeIFCSv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 22:18:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 207-v6so9124440wme.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c2t1RIQkwSM9wkl/CvDmU9//L6jQkPxeoPVOVWUD1A4=;
        b=ZQ5EaJhwJzgA/XSwg6pbOj7R0kOrswBLp7WIj1ciz6XLznxcE0xkeEG2YMeDRTvLio
         3LLtN5dVsS+Gfvj1SKzhDD/hqsSFAY/eYULNAVd0QWJSz1q+nM3KOqS7/7m71xD8epDc
         UOwmANFlT+p5BN2miP1pSvRKIyLF4rb0z6vDXDidTgogDoM+33B/xyjzAO4aIp4UKuO+
         33emJXqOcBEYB+4TD/jNJ08miOFn8wQmZYROXOSAAKTYbpySQ92RjVS/JtmTKIhHBOkB
         75FsVBKmAxBrxGWuc8ovldKdzniTX3k11xv3U+qDrmeoCRrtzZ/QESx9Vf/t1EGWc0du
         TixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c2t1RIQkwSM9wkl/CvDmU9//L6jQkPxeoPVOVWUD1A4=;
        b=XneTMRVJukkjXLDr+BHUztjz/+2FAupsw17WZA8qk76Dqz5P0j38zKHnLoYg71uVpL
         NPeqO1lAIPMDFWteuVtVlcFkiQpJxWctF+WKj0FpBZ6LOLSxV3dmeavpLk/hP7rAjAIl
         48iZMSDCo1Cge5SjtZPzxXXGQ/r4a/OVnNCDRLjXjIkiZv25W8hY011KWaoHlCxXVU+j
         l5LnyOzLRVIG+jcg9xvtNk5oHxdxiyvMQCGe46XrqOBYDoI5dITrntHCPjzCdTpcK7jP
         hsKFreUj7ELmpQC6u6Q6jRD/ea8OhK+IE4osnVBh24NadlHOxOU2TChAJwl6CF+sEqA5
         FIeA==
X-Gm-Message-State: APzg51AO/2GY9oKri51kxTwKvp5nhKbefpDJMeCyHhJl0qoBjwDF4G7E
        tgl24cDRTxn8VLOHz8plxeR9CLwO6+M=
X-Google-Smtp-Source: ANB0VdZ3/YmN5pIaHKtifrY6lIhOvt3UsazhUqQcvITlDtFATRpccJjBGK0/5D6MzrcSrzWGR5kSPw==
X-Received: by 2002:a1c:838a:: with SMTP id f132-v6mr179315wmd.127.1536184004213;
        Wed, 05 Sep 2018 14:46:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 60-v6sm3822558wre.82.2018.09.05.14.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:46:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com>
        <20180904202729.13900-2-avarab@gmail.com>
        <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com>
        <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com>
Date:   Wed, 05 Sep 2018 14:46:42 -0700
In-Reply-To: <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com> (Derrick
        Stolee's message of "Wed, 5 Sep 2018 07:58:12 -0400")
Message-ID: <xmqqtvn339dp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>>   	for (i = 0; i < commits->nr; i++) {
>>> +		display_progress(progress, i);
>>>   		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>>>   		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>>   			continue;
>> I am wondering if the progress call should be moved after this
>> conditional continue; would we want to count the entry whose
>> generation is already known here?  Of course, as we give commits->nr
>> as the 100% ceiling, we cannot avoid doing so, but it somehow smells
>> wrong.
>
> If we wanted to be completely right, we would count the commits in the
> list that do not have a generation number and report that as the 100%
> ceiling.

Yeah, but I realize that the definition of "right" really depends on
what we consider a task being accomplished is in this loop.  If we
define the task to "we have some number of commits that lack
generation numbers and our task is to assign numbers to them.", then
yes counting the ones without generation number and culling the ones
that already have generation number is outside the work and we need
another loop to count them.  But the position the posted patch takes
is also a valid one: we have some commits and we are making sure
each and every one of them has assigned a generation number.

So I do not think it is necessary to introduce another loop just for
counting.

Thanks.



