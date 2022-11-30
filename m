Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32782C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiK3JTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK3JTm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 04:19:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D660DC
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:19:40 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so15517530pgc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2wFQq3Etqtf3YDuog42OYdSr6J1MmrH8ENRYT+Eeys=;
        b=WOfa2Qh6VJiFlNfrkUVGTx8GUEs9a5xgFJUeC4rx2T2VQ0P88n8oXLZeWoHp+bpVtd
         0uhq3ZIFqv6B7qV1Nfg0Sqmw9vyAXZ+kuy/+kjTH6evbZRK3vwSMt+8IytctdQGh0DB5
         bGy3KM2oGRKZ25+HCHydK/h/77ECW/oottFQbUOfvjy/9b6GSAEUSNz6jcSuyX3vK+/K
         6TFhIx3Cr738p777Vd8aZ1IZz20IZG2q/iek7buaswfDzBCCgA9Ltl5WjbLUHXowlbkZ
         kuekyDrl7X+RDkOPyO85krmQUuwzFgQZmDQSqFuogq2kuppAA6Um+ls+LTVgEIClrOPA
         w81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u2wFQq3Etqtf3YDuog42OYdSr6J1MmrH8ENRYT+Eeys=;
        b=GqsZUfF+Xzjx/lpYfKE4E/NV6E21nto3lPf3DxEG0yoGUq7Bo8fna5kLnSgu69M2Ln
         PjRIFVCTSP6A8uM3+ybwh5Rb+msAdj4Sdq8fjCW0AfrQk/NAhd1niig/4lAUXntvbJOj
         M3/+bIPItdHlFnMJpl+Tb0w393qaiPHk0CH7Y4/pH1p/xc5+NdOJhU0ueHdvn+XEyzUd
         qXzPjMLSmRJktiQAnBmyXMI9D2LlsEhVqTahl4X4LTTUDIqP+CnrFvJM/1uJ6jYEgk57
         8JRVtKUvkQb9xFF/0gcE55P/QWWpc+Nrj8Wqc7OOddsd74Ijjf36f8Wgur/tNlU0rQO8
         BSaA==
X-Gm-Message-State: ANoB5pkeupsXuSOJ+QhOoKT7YNTBLqxC7a5P+E1aOBMnqFE/S1h09hey
        v0mhBPNrl2gCn5wMYDg1JcU=
X-Google-Smtp-Source: AA0mqf7ukmA+4WaBWCZT/c2+M/PK/E31IofU6iD3woOYPRJz2rFsHrjWqSZuLn1f/xmAe7iTjC6M+w==
X-Received: by 2002:a63:1d62:0:b0:477:d018:ef31 with SMTP id d34-20020a631d62000000b00477d018ef31mr25972834pgm.287.1669799980051;
        Wed, 30 Nov 2022 01:19:40 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k60-20020a17090a14c200b00219220edf0dsm791401pja.48.2022.11.30.01.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:19:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        me@ttaylorr.com
Subject: Re: [PATCH v5 2/2] cat-file: add mailmap support to --batch-check
 option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-3-siddharthasthana31@gmail.com>
        <xmqqbkp0wyd8.fsf@gitster.g>
Date:   Wed, 30 Nov 2022 18:19:39 +0900
In-Reply-To: <xmqqbkp0wyd8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        21 Nov 2022 16:38:43 +0900")
Message-ID: <xmqqa648ztn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Note that some implementations of "wc" pads its output with SP.  The
> implication will be seen in a few paragraphs below.
> ...
> In any case, don't abuse "log" when you mean
>
>     commit_object_name=$(git rev-parse HEAD) &&
>
>> +	echo "$commit_sha commit $commit_size" >expect &&
>
> As $commit_size here may have extra and unwanted SP before it, this
> may break with the implementation of "wc" on certain platforms.  In
> this particular instance, losing quoting, i.e.
>
> 	echo $commit_sha commit $commit_size >expect
>
> may be a good workaround.

And this indeed does break GitHub CI osx jobs ...

  https://github.com/git/git/actions/runs/3581605069/jobs/6024866010#step:4:1860

... in the way exactly I predicted to break in the message I am
responding to.

