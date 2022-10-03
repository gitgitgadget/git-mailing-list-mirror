Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877EFC433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 16:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJCQbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJCQbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 12:31:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A369357C8
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 09:31:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso9878449pjm.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpO4n6op3f9fwUnmU2xnaGRMThy61ZphEZUkbwATQ/4=;
        b=MU8uSflFKXGINSqIct4im0UXGIRMj0UVIjBbBkd/3B0QhNokmG0jDpGUFdPU/ykSTF
         MNsDnxAM/rH4gBrQ8Oci5BAts3CCQ9J4MrU/pZDQBB2PXhN0TU2A9diNSdgMhnHsmjD/
         qzDSewaiSmFAKvOem3RaY8LB2I80m6rKeZiNoEHgo5+i5X7R14iARlsNtpDjVdf4bphi
         B82AChSg6LKOzl8hTi6dEn85X9DuJcIvBx3a5zcxBrqH5hsxwiKKN+TvzwZK5aJvxQS6
         CWCAeQFcBzScXyVNl7M5A7yZ0dbeHsaDP/GMaSeEfpB3hMuKdDUVdE2dx5UyejbilFS1
         bSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpO4n6op3f9fwUnmU2xnaGRMThy61ZphEZUkbwATQ/4=;
        b=d6EWkLc5wIad6ZeNB2Tjb/JO2nEegTX9oqxsAniA2VczW6xDa8xiAH8mAXdMfQh/z/
         Us/WOitwWalLaxTEcHN/fsSGEjk5fMA30AyhtAbVux8yYSx72b/h6T2ZlGix3vwsuX3A
         RiNXoSa5TdJ2HlP38o9ITOi10C77wlG+SFsqnOvU5fI/wO0sonr3P2F40+eNdxDq4zsZ
         OZ5gKu48ydwY+byIudbJdw3r0P3Jj2Bz8Nbxt0VAEjo25F/XTAhZD+9Y9dAUs+PrWlmI
         /mjwAL7JHmkoEJQeu/T+5/S1A+pZdc+Qx6mv0ZKlLSGAA32ql/YAkkd2muNiBiAmMryK
         JBqA==
X-Gm-Message-State: ACrzQf0IMv0DvVsmZMB7uvV//PGpTJPIvYD1ossB1/CIWy7MFscnHRDz
        1eE1sd05uXP1CbWQGzBN8i0=
X-Google-Smtp-Source: AMsMyM6AgJIOCoJUwDApkVyBKto4oOrMDPRHFYgkzEwxiiVD3LM5rPovEnE+IGXrWlAOBLLPjIKPOw==
X-Received: by 2002:a17:902:7607:b0:17c:6c3b:20cd with SMTP id k7-20020a170902760700b0017c6c3b20cdmr17071863pll.44.1664814694494;
        Mon, 03 Oct 2022 09:31:34 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z13-20020a63330d000000b00434651f9a96sm6665492pgz.15.2022.10.03.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:31:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
References: <20221003084654.183966-1-gitter.spiros@gmail.com>
        <221003.86o7uttfxg.gmgdl@evledraar.gmail.com>
Date:   Mon, 03 Oct 2022 09:31:33 -0700
In-Reply-To: <221003.86o7uttfxg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 03 Oct 2022 11:20:05 +0200")
Message-ID: <xmqqfsg4x40q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Mon, Oct 03 2022, Elia Pinto wrote:
>
>> This commit adds an "EXAMPLES" section to the git reflog man page.
>> This new section currently provides examples of using git reflog
>> with branches, for which doubts often exist. In this commit we also
>> add a "SEE ALSO" section which refers to further information
>> on git commands or documentation referenced in the git reflog man page.
>
> I think it can be valuable to have an EXAMPLES section, but:
> ...
> Most of this really just seems to be duplicating "SPECIFYING REVISIONS",
> and some of it such as "show with timestamp" is ambiguous/misleading.

It would become immediately clear what these phrases want to say,
when the reader runs "git reflog @{0}" and "git reflog @{now}" while
reading the document.  I am not sure if the description is ambiguous
or misleading to those who haven't seen any reflog output, especially
the timestamped ones.  Perhaps some sample output in the documentation
would help, do you think?

    $ git reflog -2 HEAD@{now}
    ce17cbfa2b HEAD@{Mon Oct 3 09:07:30 2022 -0700}: checkout: moving...
    ce17cbfa2b HEAD@{Mon Oct 3 09:07:14 2022 -0700}: am: ssh signing...
    $ git reflog -2 HEAD@{0}
    ce17cbfa2b HEAD@{0}: checkout: moving...
    ce17cbfa2b HEAD@{1}: am: ssh signing...

I would freely admit that this is one of my least favourite part of
Git UI that allows what comes inside @{} as parameter to "git
reflog" affect both the starting point (e.g. @{2.days} omits the
activities of the past 48 hours) and the format of the output.  The
taste of the design is bad, but it is what we ended up with.

>> +SEE ALSO
>> +--------
>> +linkgit:gitrevisions[7],
>> +linkgit:git-log[1]
>
> Likewise "SEE ALSO" sections can be really valuable, but they're really
> for "now that you've read the above, maybe this is also useful". It's
> not a "SEE STUFF YOU SAW BEFORE" :)
>
> In this case we link to these in the first and third paragraphs of the
> DESCRIPTION section (respectively), since explaining the revision syntax
> etc. is really core to understanding how this command works.

I do not know about that.

Only the part of the revision syntax that refers to the tip of a ref
works as input for "git reflog".  IOW, "git reflog seen^2~4" does
not work.  I do not think the knowledge of revision syntax helps
understanding how to operate the command that much because of the
above.  I agree with you that it is dubious if it is a good idea to
list gitrevisions[7] here, but for an entirely different reason.

On the other hand, git-log[1] might not be a bad thing to refer to,
in order to learn that you can say something like

    git reflog --pretty=short --stat @{now}

Thanks for a review.

