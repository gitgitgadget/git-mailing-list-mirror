Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9032BC4332F
	for <git@archiver.kernel.org>; Sun,  1 Jan 2023 01:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjAABOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 20:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAABOn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 20:14:43 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA765F3
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 17:14:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so36950702lfb.1
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g8D/scrZkpJ62OKrndkLKSd3zTyaKOUAinYEskJ02fE=;
        b=ECe5r2LONqAQxC3YFSwWUxeP74XOOz1TUPGoOrv2TGaNxcfKiugHvqPa6/Le40eoNw
         UPExuI01eqiPHGi/iXxj+pb6sASRvFTp1pFdbGUksAaAWyaTmY20Waon3mPk6FIBedwS
         He02Y/eLFknOhpWnjEwS3Cecym16GWdaTOANSXKhFMDR1ukHjQLJeMLSzNSgeBDMpLZN
         EB8c8CXrp5dBacA7QT7PR3k2rkCStBuuxsqkRSeqv1tV8FPdUu+lCBDZ+7SSCO1i1R8a
         Adv6i06EgqtQlkrfC/u5BV0gJJxN0o5gDMCDJNE8P/xzA857xctOq3OfQHEaLObWW9pN
         mxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8D/scrZkpJ62OKrndkLKSd3zTyaKOUAinYEskJ02fE=;
        b=bL290Xol239Kd6kxcKCn2tFNQlVrHf9H7axut249e6Fp7KiVBKno0Wxn6GQTi1wsr8
         wOld/eGPoOBtQVT3YIEffnQJBbGja9zYTfkt4C+CSlx2ZEj15LzlHuh294a0rS/m4FcW
         wDf9SQ6sYUL/RUneF/rWIsI/2J2gk9JCcxuwHQN2LtGu483zo7uYT7fSsUj9ATyscaEW
         Vd/aQjxfLjd1F531inQuu7iUWL2hqCJOaIe5kbBi3wmoN5Ns/yV5wohuhYhVZ2GHkJ3S
         oftOem7cpOvreOicMVVGzMU419IHasykbLns3RnMW3rZDmvEf/jU6+oH5wVb3LNQF67Z
         tU6g==
X-Gm-Message-State: AFqh2kouuSNLqlyZ3C8afRlW0V+JuHA+WSrHFp47zeS7yas0Vr2KxwZg
        5xm5vluMOj+Pmomk9Vp0yOHVNwWZjGWfgZ380KQ48/5zHfYEJVqF
X-Google-Smtp-Source: AMrXdXul3Uo1SVQHH/hQmefF21hY7Z4E8G844ng0dllE8fYeLv8Ooa571GtyoJ/rEPnnvrtp+meZz18Y7tOofeJ+VLE=
X-Received: by 2002:a05:6512:2a93:b0:4b5:6e66:7bbc with SMTP id
 dt19-20020a0565122a9300b004b56e667bbcmr1720769lfb.487.1672535679801; Sat, 31
 Dec 2022 17:14:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:aa6:c266:0:b0:23b:5e81:46ba with HTTP; Sat, 31 Dec 2022
 17:14:38 -0800 (PST)
In-Reply-To: <000701d91cae$6c8cbbf0$45a633d0$@nexbridge.com>
References: <CAJcAo8tjMLFisK5_13iD_JGo2xVQDJRX3wAC7wRD_V2GKFGevQ@mail.gmail.com>
 <000701d91cae$6c8cbbf0$45a633d0$@nexbridge.com>
From:   Samuel Wales <samologist@gmail.com>
Date:   Sat, 31 Dec 2022 18:14:38 -0700
Message-ID: <CAJcAo8syzh3-R2RQVQJtv+eZiwLjmdKm7+MUYqt1BcX2Jz7XZA@mail.gmail.com>
Subject: Re: is this data corruption?
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

r> Have you done any git add operations?

i presume this is staging.  i do staging in magit all the time.  but
right now the staging area is empty and so is diff --cached.

On 12/30/22, rsbecker@nexbridge.com <rsbecker@nexbridge.com> wrote:
> On December 30, 2022 7:18 PM, Samuel Wales wrote:
>>i am not subscribed, but am of the impression that's ok.  please copy me
>> directly.
>>
>>
>>tldr: git diff is showing differences that do not exist in the files
>> themselves.
>>
>>i have nothing staged, nothing fancy like stashing, etc.  this is a repo of
>> mostly
>>emacs org mode files.  mostly ascii text.
>>
>>git status and these commands show nothing unusual:
>>
>>    git fsck --strict --no-dangling
>>    git gc --prune="0 days"
>>
>>
>>the problem that seems like data corruption is that a few lines appear
>> twice as -
>>and once as +.  but in the current version of the files, those lines exist
>> only once.
>>here are the lines.  there are 2 - versions and one + version:
>>
>>+***************** REF bigpart is a partition biglike and homelike are
>>+distracting nonsense i think except to describe inferior filesets.
>>+anomalous subset of home might be called homelike or so.
>>
>>
>>emacs magit shows the same problem.  however, it shows a slightly different
>> diff.
>>i did a meta-diff on git diff vs. magit, and there are about 800 +
>> real-content lines
>>that magit shows but git diff does not.  i do not know what this means.  wc
>> -l is like
>>
>>  62540 aaa.diff
>>  62965 bbb--magit.txt
>>
>>idk why a diff would be different with only + lines being different?
>>
>>
>>in summary, what is wrong with my repo, if anything, and what can i do
>> about it?
>>nothing on the web for git corruption seems to say much, other than pull
>> from
>>github or whatever.  this is my own repo, the original repo, so i cannot do
>> that.  org
>>annex has an uncorrupt tool of some kind, but it did not seem relevant.  i
>> do have
>>rsnapshot [basically rsync] backups of the repo and the most significant
>> files and
>>dirs, but i do not know what one does to use that to repair any issues.  i
>> won't get
>>into why, but changes were made over months.
>>
>>is there a protocol for this?
>>
>>would git fsck have balked?
>>
>>thank you!
>>
>>
>>p.s.
>>
>>i have no reason to believe this is related, but git diff has intermingled
>> emacs org
>>mode entries.  but i don't have to talk about it in org terms; in generic
>> text terms, it
>>has intermingled parts of different paragraphs.  as a user, i'd prefer
>> that
>>completely unrelated paragraphs not be mingled, regardless of minimality.
>> if
>>possible.
>>
>>with respect to the intermingling only, unless this is related to the
>> possible
>>corruption, i will presume the diff is correct, in that a patch from it
>> would produce
>>the same result as a patch that does not intermingle.  i believe this
>> intermingling is
>>because diff does not understand org, or paragraphs for that matter.  in
>> org, an
>>entry starts with "^[*]+ " and ends at the beginning of another entry or at
>> eof.
>>they consist in my case mostly of ascii text paragraphs.  just as with
>> paragraphs, if
>>you move an entry, you don't expect it to be mingled with a different one
>> in the
>>diff.
>>
>>i have been told that this cannot be fixed by merely telling a slightly
>> improved
>>differ that stuff between stars is worth preserving, but that a parser, not
>> merely a
>>couple of regexps, is needed to reduce this intermingling.  i have also
>> been told
>>that difftastic uses tree-sitter, which might get such a syntax for emacs
>> org mode.
>>and so maybe at some point git diff can use that.  idk.
>>
>>idk if any of this is related but i include it for completeness.
>>
>>also, please don't laugh, but i am using git version 2.11.0.  i will
>> upgrade pending
>>various library and os stuff but my main concern is not for git, but for
>> possible
>>corruption in the repo and what is possible to do, at least given
>> rsnapshot, to fix it.
>
> I cannot account for your emacs issues, but have a question. Have you done
> any git add operations? Git diff is subject to what specifically is staged.
> So you might be comparing your file with partially staged content that could
> account for partial diffs. See if diff --cached makes a difference. Also try
> different algorithms, like --patience or --diff-algorithm=histogram.
>
> --Randall
>
>


-- 
The Kafka Pandemic

A blog about science, health, human rights, and misopathy:
https://thekafkapandemic.blogspot.com
