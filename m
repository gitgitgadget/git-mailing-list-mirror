Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DBF51F404
	for <e@80x24.org>; Thu, 12 Apr 2018 01:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDLBho (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 21:37:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50734 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeDLBhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 21:37:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id t67so8014703wmt.0
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZvcLA6kacsyZ1vQY/ztNLX51os3F+FgSnlDEXVERk2o=;
        b=BiTyp+frOca6w/s+hmotBN17hJR15hGc9YaQulESev55oyO2LtixJmNoRkkQgFQjlQ
         fBi2lgPziW7+v7Dg7zPewDlP8xzmj21peMrpIqDp3UOYODBZVW7Gv9kzGC5Sru7sPExw
         9jxCy7fuilmL9WJoh5z64Z6ayspjd13p47xSHi7yjAIf7uJsiA66CaQXoa8aJ5emJOBK
         /NM1EvD+t7wenri5DOPRXsf+56JHSpT9N23UU6ZUUIVksZqdxl7Gxx7/mwd2wHT4H7yw
         n1xurADsjol7LrJ08qdQmS9ulFPDO4IIzaAMzQPfSMJsihrVessSPRzFpMUeEp91q6Za
         Cb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZvcLA6kacsyZ1vQY/ztNLX51os3F+FgSnlDEXVERk2o=;
        b=tkRNNtEBwMKpwTlpkNhtiiIT3GWbKvPF+BCDmXL1qnqd+ttwgfzahEQcG842u4M2/e
         88JQjL0fpwVF+Tl2TCaND6gfVOkT77o7P6L+cHMCxemAcQosCYNZBMBdmT4AlgIXyIKo
         Go7sBQUnsosFT/9TOo6KL/5acUha3fNQiZ4reLjCWrsz1eUUgfPpUWigQ6cjri6EqtVd
         In6oUNUo8eoUwMhjJbBuRgqDbZVALNa9vuPltM3v+M0zVIvFdZFAldbDP0vF7Ejys4up
         6JmYunQdpye0KpekpB3G9NDU8+dCAuUEu0bSnpCLgTLE0HU7j0+ZUdaxdaXeMajY6Xyd
         bFfA==
X-Gm-Message-State: ALQs6tBy4k7Irr6OAqgZb/aDTiyNpS5ERimWfEE97npgeP8SySpWcB7i
        5lbs7RRV4rsygIxUMoO4jjjU5V5v
X-Google-Smtp-Source: AIpwx49+xuhcyBoTlN+tiTqnMnVoXoETD1Ffb9k0ByO46JW2TqlYJw7UhUhoGjcapksYq6eg9vYJLw==
X-Received: by 10.28.197.205 with SMTP id v196mr4272677wmf.39.1523497061911;
        Wed, 11 Apr 2018 18:37:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l73sm5801444wma.10.2018.04.11.18.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 18:37:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [Git] recursive merge on 'master' severely broken?
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHL4P0RxQ6OAuDSev9BXVM0uKTYD3M4JGTQvSwcBv4K0Q@mail.gmail.com>
Date:   Thu, 12 Apr 2018 10:37:39 +0900
In-Reply-To: <CABPp-BHL4P0RxQ6OAuDSev9BXVM0uKTYD3M4JGTQvSwcBv4K0Q@mail.gmail.com>
        (Elijah Newren's message of "Wed, 11 Apr 2018 08:51:48 -0700")
Message-ID: <xmqqo9ip2oik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Apr 11, 2018 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> It appears that a topic recently graduated to 'master' introduces a
>> severe regression to "git merge" when it merges a side branch that
>> renames paths while the trunk has further updates.
>>
>> The symptom can easily be seen by trying to recreate the merge I
>> made at the tip of 'pu' 29dea678 ("Merge branch
>> 'sb/filenames-with-dashes' into pu", 2018-04-11) that I'll be.
>> pushing out shortly.  The side branch renames a file exec_cmd.h to
>> exec-cmd.h (an underscore changed to a dash) without changing any
>> contents, while the branch being merged to has made some changes to
>> the contents while keeping the original pathname.
> ...
> I agree, that is _really_ bad.  My sincerest apologies.  I'll dig into it.

Thanks.  It is not unusual for a moderately large set of changes to
have glitches that need time to be discovered.  I was hoping that
placing it in 'next' and keeping it there for several weeks would
have been sufficient for people who do use stuff from there in real
life but apparently that wasn't the case.

