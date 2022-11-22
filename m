Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6957FC43217
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiKVW46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKVW45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:56:57 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409C115
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:56:55 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q13so2347613ild.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjHVb/46+T49x36k+VNAfu5Ygp99Jdc4Iqr+J2Frksw=;
        b=Hdoht+5CZXx0pe6U0ZUBQ+sCJJtq6gd+kLUg/DRRsxh0fRdNl3+G9oZ9u8Jk6GlZof
         nQccvyNFRLSXVwXfpEKFyaSXB91CjhWqVlexMEqGPQLOCSzLJ4QrpEWyHn3QlZi0K2I4
         oMhHrAXnJhab2rDTMHz4SXaCfyWaRJ0AV6HQq9lWjAIiOMXBMWLTHxJKkmae4kehtyIy
         feoQkuoxMPMqjDH1VYJ8uVDi6kfk67cHcHrwxayb9g9RW9RMjWC6Dfx92C+vZ/CNiTSZ
         nSZkqN4nUxyyMbrU6XZzFIYhwZ6M9P32yvuhME9SU85PHz/5+X5y8ChtC/OJKyRcHU3Z
         Ybqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjHVb/46+T49x36k+VNAfu5Ygp99Jdc4Iqr+J2Frksw=;
        b=2I62EfRu1ppBxH7Yk13LxuqniKZsiWrZyBkmZfMw0Xce4CLXJPumakknYZOw+oz+uP
         ZTXr27gpYzQyXksRqRPYQulrJit5xSqRh1k/YzpVQsVJHsEDrbt5d6TNrvwGSZbsrOrf
         YaUgt3VQ1Ia6uW8LK/UHVfLlLrTN0ZhSjnuhPh6XnMiB1TE85IgcRh682A1NHXvgV0YV
         xBtYWBSqxUnlN0zJ6J7F7FcVdpKRCCpRPap42BdJEslBvSruvttAuBlElCL8zeT94xOA
         8BHMgHMFLsbdXQwPHTQh9NsyHmSafGVURSRp822QmUuYEY/ZURpTxhM2TRJ74dgCuX2U
         I+aA==
X-Gm-Message-State: ANoB5pne2atBg9aLBodMlxk32nwJTmqQiox/agdEI1LbrrCCChX1R2Uo
        HVccgOe6eI03f9en18WAnhKCj2MYiPv1OQ==
X-Google-Smtp-Source: AA0mqf5li2iR8nztIfdKZJhwOHVMQ4qU9U9OVPGU2/Ry3m8GBjTYo+9fSgq04OVzDZvOK3rJx83usQ==
X-Received: by 2002:a92:ddc4:0:b0:2ff:daa8:dbbe with SMTP id d4-20020a92ddc4000000b002ffdaa8dbbemr6158388ilr.14.1669157815022;
        Tue, 22 Nov 2022 14:56:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b2-20020a92ce02000000b00302aa2a202dsm4588111ilo.64.2022.11.22.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:56:54 -0800 (PST)
Date:   Tue, 22 Nov 2022 17:56:52 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <Y31TtIatznxRuHln@nand.local>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <xmqq7czp1a6y.fsf@gitster.g>
 <Y3q9xrq5u9YSuVQC@nand.local>
 <xmqqpmdhx9kr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmdhx9kr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 12:36:36PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Nov 21, 2022 at 08:24:21AM +0900, Junio C Hamano wrote:
> >> Taylor Blau <me@ttaylorr.com> writes:
> >>
> >> > * ab/various-leak-fixes (2022-11-08) 18 commits
> >> >   (merged to 'next' on 2022-11-18 at 8828bb7161)
> >> >  ...
> >> >  (this branch is used by ab/merge-index-prep.)
> >>
> >> > * pw/rebase-no-reflog-action (2022-11-09) 2 commits
> >> >   (merged to 'next' on 2022-11-14 at 790dadc8d3)
> >> >  ...
> >> >  (this branch is used by ab/merge-index-prep.)
> >>
> >> The other topic referred to is not described anywhere, and not part
> >> of 'seen'.  Intended?
> >
> > It was merged intentionally via 790dadc8d3 (Merge branch
> > 'pw/rebase-no-reflog-action' into next, 2022-11-14) as you note, though
> > I'm not sure why the description from 790dadc8d3 didn't make it into the
> > WC report.
> >
> > In any case, the description I went with is:
> >
> >     Avoid setting GIT_REFLOG_ACTION to improve readability of the
> >     sequencer internals.
>
> Sorry, but the question was about ab/merge-index-prep that does not
> exist in the report and not in 'seen'.
>
> For now, I'll ignore that phantom user of these two topics.  It can
> come back when dust settles ;-).

Ah, yes, I remember this topic. It's from [1], and it does indeed use
ab/various-leak-fixes and pw/rebase-no-reflog-action (cf. [2]), which
apparently isn't quite sufficient (cf. [3]).

If I recall correctly, it had some conflicts when queuing, so I punted
on it (because at the time when [2] was written the correct base(s) were
not known).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com/
[2]: https://lore.kernel.org/git/Y3gVekgT7jLibjWo@nand.local/
[3]: https://lore.kernel.org/git/221119.86o7t3ds49.gmgdl@evledraar.gmail.com/
