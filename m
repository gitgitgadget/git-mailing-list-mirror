Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2C3C4167B
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 04:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAAEqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 23:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAAEqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 23:46:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A472E78
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:46:32 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s25so26137418lji.2
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 20:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCJZXtbOXCi+wu5lbR4V6irvG85c1LaEhqixpX14Uv8=;
        b=hnRJDL/Jd0YeYQJt2HNhCf0H2jIvU8WV1lpvvBMS7df59z0FZ7JGCWZB5Fe8ahPZjM
         trOjA6VT8zMu/N/xzzO7v9lQJpha6aFLoXHjLrmpWpLjuuPNPQ0QUA2Wnya7IW0vBPx3
         oUJzBGNUrnKQTuvg/kDGipGzQbC65qrGUe/MolVMof9FxD4VBnUd3Al4ePdxzTgfcMLz
         +P1Z+WNguxZwwVZti9jTiSs9dICo0gS9HnaV8l1U35Vg92CwhaAEesKfoPOUGe+1/qEi
         EcAzyc/VcY03MjbW0fRh9Q3tDFdiInbtQ7a9i1Pf3LpYmmnoyGGg/LDGUn8bJDKnvKfn
         zt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCJZXtbOXCi+wu5lbR4V6irvG85c1LaEhqixpX14Uv8=;
        b=wCkIvfweniDKSZkyCn+w93tOaQPwEK0G7LArSc1mB4LElMr4rZXLJVklYUUBzwi5fO
         PPS0hNAlG1J4vSQjbQb2mSYlxVRSIHrENFZPGitCVKGR927z9z5CyWgn7zYw6N3DU2bQ
         fRBkpFdyWb06ttnWn8dQyOcvT2VdiBPuIdKnKxZ4gNt1NZo8NMpcgTCH2skQBOEBCypw
         FdL5CPH8dkk5evW2a//rD8BJjwKqo+NMN3PKfpeEQ4agg0BFawRAJlLWCMx/IDwokZO1
         AsT7qWZZzKKAV1mAKK34wMZKI6aZ12UrHJTLQdz4bysF/EYRkGTiFMDp1DlfqC/2JmF4
         mExA==
X-Gm-Message-State: AFqh2koAorgWKxvxB+hq7rqofhmHzEmLFVBSWiWH6as5zK42S4Z/g4yu
        AZU3X/uwLiK2AwjI7GcvgGpx0qHpcgsumYhEUqGj34LkPDzO551C
X-Google-Smtp-Source: AMrXdXuGC6YK22FL1f2KQVcRdarKz7qrtn95kKvXzl5eCcgxP3CfRRLc/Xbcf5eLswtJYNVON7edWiTA44Ct8jy6/ds=
X-Received: by 2002:a2e:9e82:0:b0:27f:d61b:4e54 with SMTP id
 f2-20020a2e9e82000000b0027fd61b4e54mr903141ljk.75.1672548390390; Sat, 31 Dec
 2022 20:46:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Sat, 31 Dec 2022
 20:46:29 -0800 (PST)
In-Reply-To: <xmqqlemmhp97.fsf@gitster.g>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
 <xmqqlemmhp97.fsf@gitster.g>
From:   Samuel Wales <samologist@gmail.com>
Date:   Sat, 31 Dec 2022 21:46:29 -0700
Message-ID: <CAJcAo8sJo8mE5V8_3eGj3miirNOJfQGsDH+=7HmSrwvLC=Ch3w@mail.gmail.com>
Subject: Re: is this data corruption?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hi,

thanks for reading/thinking.

> Sorry, but I do not see any "-" versions in the above.  Simple and
minimum reproduction recipe would be useful for the list to help.

the - versions are identical.  as i wrote, there are 2 - versions in
addition.  i didn't want to make a pointlessly long email.

it would be great if i could provide a reproduction recipe.  i don't
know how i couold do that in this case.  for example, when i try to
pare down the repo and make private things obscured, i run into the
proble that when i do staging, things change around, thus erasing that
particular bug.  and other stuff like my limited knowledge of git.

i'm afraid i am stuck with hoping for other types of solutions like
"i've seen this before" or "that's not possuble unless..."or something
a priori like that.  but if you have an idea of how to create a
minimal repro in less than a week, let me know.


On 12/31/22, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Wales <samologist@gmail.com> writes:
>
>> the problem that seems like data corruption is that a few lines appear
>> twice as - and once as +.  but in the current version of the files,
>> those lines exist only once.  here are the lines.  there are 2 -
>> versions and one + version:
>>
>> +***************** REF bigpart is a partition
>> +biglike and homelike are distracting nonsense i think except
>> +to describe inferior filesets.  anomalous subset of home
>> +might be called homelike or so.
>
> Sorry, but I do not see any "-" versions in the above.  Simple and
> minimum reproduction recipe would be useful for the list to help.
>
> https://www.chiark.greenend.org.uk/~sgtatham/bugs.html
>
> Thanks.
>


-- 
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
