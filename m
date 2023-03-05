Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26195C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 22:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCEWy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 17:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCEWy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 17:54:26 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE8A903A
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 14:54:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s20so10381389lfb.11
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZUZWJYPpAW7FeR0ab7SnZ4slLu7Mft8PUD2RsdAvzc=;
        b=en1byjBysMcRDAWA+BF0G0HBLRFvX9upGbo5Qbhvzw8ByZjMC80RVRjqLfCd/49n8j
         2j0tZXYx4ZunukYXlaNF0YAu5jI6M71DSpyXfRyXL3YaMfaX/+VsDSFEuSUFfp5Nh04f
         q5PaqvJC34XG5PPPiJqLj5NmOZV2xZj9wDcDXczfsXMBFl5uzw5A8VgcJtzef+dT3yVd
         jpjEhmeZabp/8XAxbLa4T6m5Kdsi99dikMdUpVSemzzz8HmMQA2JmVc44PGH6Yl/A+Ka
         16dLkI94a7wC3+kp+xiI211csO74VdKhdN4AOM/9rgt19xBpHDao/nHcNsqMiot/0CyR
         CP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZUZWJYPpAW7FeR0ab7SnZ4slLu7Mft8PUD2RsdAvzc=;
        b=UduclmdRhfIvrFtz0CZHXZ+aBPlIusM+zPq1pSbrq3GxWjJfgMTs8LtypDErh0bAHn
         j3bk6wX5sZmy5M5qi7Wx7pqxDUSi/BpA5mjXKa3KL3sJIroZnOPwwH2Z9jnU3HT2WGbY
         uxbTnhHqqE7WIf2PQtHyoJZlnNnpryTTOWH8R1zlHl26NaMq3mlFno7dAoDmXbnXbUZb
         8sgNDRdLgBHLHg4GiOyr9ciJpHSdZT61xmbxxdY6K1IJOUtvfgIuSQR3TlBjXOuRN6xs
         Nu3V5xYK5AsfWFv4GArphxcPTFrIiEROSV/f8jkFqhprltL1cYq2FqHa9JOmwvofHHKp
         MDZQ==
X-Gm-Message-State: AO0yUKWd/l9R0NA/8HFC5gIlVtzWI8PF/FlgMFbVEJYv7tz3302M63La
        t4OlsbtVCIsT8y5yi3uT3Is=
X-Google-Smtp-Source: AK7set8obreYezIZV6rwZPUBVjL9VvKebldgXtuU2JRx7gG3inDbFeUWM+4L23HgjHDkYTTxhscy0Q==
X-Received: by 2002:ac2:5457:0:b0:4dd:ce0b:7692 with SMTP id d23-20020ac25457000000b004ddce0b7692mr2409251lfn.46.1678056862758;
        Sun, 05 Mar 2023 14:54:22 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id n28-20020ac2491c000000b004dd0bbc89a1sm1350575lfi.244.2023.03.05.14.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 14:54:22 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, chooglen@google.com,
        calvinwan@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v6 0/3] rebase: document, clean up, and introduce a
 config option for --rebase-merges
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
        <20230305050709.68736-1-alexhenrie24@gmail.com>
        <87ilff2xsl.fsf@osv.gnss.ru>
        <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
Date:   Mon, 06 Mar 2023 01:54:20 +0300
In-Reply-To: <CAMMLpeSowxoJgPOt84Dos8BVKU=y=M+Ph0xaGe6UTxwwE5zsXQ@mail.gmail.com>
        (Alex Henrie's message of "Sun, 5 Mar 2023 14:33:36 -0700")
Message-ID: <87ttyyn71f.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Sun, Mar 5, 2023 at 5:22 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> [...]
>>
>> > - Rephrase the warning about --rebase-merges="" to recommend
>> >   --rebase-merges without an argument instead, and clarify that that
>> >   will do the same thing
>>
>> Not a strong objection to the series as they are, but, provided options
>> with optional arguments are considered to be a bad practice in general
>> (unless something had recently changed), I'd like to vote for adding:
>>
>>   --rebase-merges=on (≡ --reabase-merges="")
>>
>> and for suggesting to use that one instead of --rebase-merges="" rather
>> than naked --rebase-merges.
>>
>> It'd be best to actually fix --rebase-merges to always have an argument,
>> the more so as we have '-r' shortcut, but as this is unlikely to fly due
>> to backward compatibility considerations, this way we would at least
>> avoid promoting bad practices further.
>>
>> If accepted, please consider to introduce
>>
>>   --rebase-merges=off (≡ --no-rebase-merges)
>>
>> as well for completeness.
>>
>> BTW, that's how we settled upon in the implementation of --diff-merges,
>> so these two will then be mutually consistent.
>
> I am curious as to why you say that flags with optional arguments are
> considered bad practice.

As far as I can tell, the core problem with such options is that generic
options parsing code can't tell if in "--option value" "value" is an
argument to "--option", or separate argument, that in turn may lead to
very surprising behaviors and bugs.

I believe it's a common knowledge here. If I'm wrong, then the rest
simply doesn't make sense.

> I don't see an advantage to adding --rebase-merges=on and then telling
> users that they ought to always type the extra three characters, even
> if we were designing the feature from scratch.

The advantage is that we avoid optional arguments. That said, there is
'-r' that is 13 characters shorter than --rebase-merges, so another
option is to advertise that, provided you are still opposed to
"--rebase-merges=on".

> As it is, we're certainly not going to drop support for
> --no-rebase-merges

--no-rebase-merges is fine, as it has no optional arguments

> or --rebase-merges without an argument,

Yep, but that's a pity and the whole point of my comment: if we can't
fix it, at least don't promote it.

> so it seems fine to advertise them to users.

--no-rebase-merges is fine, but then you don't advertise it anyway.

> And if we do want to add support for passing a boolean value as an
> argument to --rebase-merges, that can be done after the
> rebase.rebaseMerges config option is added; it's not a prerequisite.

Yep, that's why I said at the beginning that this is not an objection to
the series as they are, rather a nitpick.

Thanks,
-- Sergey
