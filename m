Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B8C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBZXDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBZXDm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 18:03:42 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0C5EFA5
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:03:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso325669pjb.2
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2iCx8wFR5LvrL6FsPP/rXqOpIC62la7qyz6rCYDjPo=;
        b=FsqOEbzbP3mtGss1ZmCRQUWNk9BZtZi1ZNFl+XfcBCl2I7YADOYsW6d/kFDe1O9m39
         nac9AACpb/9/DMNkNMWEDbTsRbTI8Swr0qdcf4MGo8g5/oAW9hnGLeOZf8Na8FfI+YS5
         85Yr0MzepNuZ/O0Ji+8x3RKeNIzR7J7RehI9IMtuEsuuqCdvQawCsXNl3UVMb3nEfNfL
         +rDwqcHMyTvocKUdy7iC+S1Lhrubz7EfUV5H726oYHt8X+YpwkZ42AyOWANOlZc1hsRD
         KUDYo+vSboR9Trf22C/f2oCA1wcR7AGK4Y5wi5cdEEheUilHC+V4rTGBzVpDQ8Kxs3Jz
         KmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2iCx8wFR5LvrL6FsPP/rXqOpIC62la7qyz6rCYDjPo=;
        b=ehIC8TfNulwkUN92KZWNTuscAnMiuJXTRh9e1N1HMwSHswbmXr1GjmHLtT9PTEpdF4
         QF+3M95YGbi0eV8ZIZTpbnAwdtjnrdp2jDcBDgUanPu8QMW17CrpD1JSZyzvK0fswLYr
         GhUkqv0YL6INvrTRt6Qf+GVLAy8NS+6vH4Aa8mAFJ/EQI+LV7YcM3DloErsQ7VXZyJNL
         uYcqFoSOOVwLQkFQFO4ToYPg60XWE5vSrY8SObQ3cuQgFD6H96mSI2sLS9cGXr6q3Tvh
         b+JtLky4rg3PmyyS031ggid4l2zkcN/zZT0/rLXJGjWPna2mFgqKkDTal4ndNhgSIw8X
         dlEA==
X-Gm-Message-State: AO0yUKWQMJyGe6sf41OHE1ToD91IrtTunFMqQ1i4MrwcsYt33exINoej
        K1WeRipYhUAgRM8rnVLjle7c
X-Google-Smtp-Source: AK7set8EguJyQwppUyJoTfFmAh2OLsMXF+r7Yre4duBZZqb/m0K1VpP3/So2ahmeTwM5uOQC630cVA==
X-Received: by 2002:a17:90b:1b08:b0:237:a50e:1781 with SMTP id nu8-20020a17090b1b0800b00237a50e1781mr8839776pjb.24.1677452582419;
        Sun, 26 Feb 2023 15:03:02 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a318d00b00230c8484fbfsm2952486pjb.55.2023.02.26.15.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 15:03:01 -0800 (PST)
Message-ID: <5575804f-0918-fa7c-7af1-da2f4cf073f7@github.com>
Date:   Sun, 26 Feb 2023 15:03:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [RFC][PATCH] GSoC 2023 proposal: more sparse index integration
Content-Language: en-US
To:     Vivan Garg <gvivan6@gmail.com>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
References: <20230226083347.80519-1-gvivan6@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230226083347.80519-1-gvivan6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vivan Garg wrote:
> ## Synopsis

Please wrap your text to 72 (or up to 80) characters; doing that will make
this much easier for reviewers to format their emails. I've re-wrapped lines
I'm commenting on below.

> Git 2.25.0 introduced a new experimental `git sparse-checkout` command,
> which simplified the existing feature and improved performance for large
> repositories. It allows users to restrict their working directory to only
> the files they care about, allowing them to ensure the developer workflow
> is as fast as possible while maintaining all the benefits of a monorepo. 
> (Bring your monorepo down to size with sparse-checkout, Stolee).

References to other sources (e.g. web links) are usually made with [<N>]
footnotes. In this case, that might look something like:

"
Git 2.25.0 introduced a new experimental `git sparse-checkout` command,
which simplified the existing feature and improved performance for large
repositories. It allows users to restrict their working directory to only
the files they care about, allowing them to ensure the developer workflow is
as fast as possible while maintaining all the benefits of a monorepo. [1]
 
[1]: https://github.blog/2020-01-17-bring-your-monorepo-down-to-size-with-sparse-checkout/
"

Same goes for the other references you've included.
> +## Microproject
> +
> +t4121: modernize test style
> +Status: ready to merge

To expand on the point made by Ashutosh [1], this microproject is not yet
tracked by Junio's "What's cooking" emails (most recent here: [2]), so it is
not "ready to merge." "Under review" would be a more appropriate
description. 

[1] https://lore.kernel.org/git/CACmM78QTptLOvNHs9oE2NNareSNDb+ydGFKr0VHuboCBWSZbSw@mail.gmail.com/
[2] https://lore.kernel.org/git/xmqq1qmeyfps.fsf@gitster.g/

> Integration with “mv”
> Integration with “reset”
> Integration with “sparse-checkout”
> Integration with “clean”
> Integration with “blame”

Please include mailing list archive links to these series.

> During my discussion with Victoria, she informed me that given my
> commitment of 175 hours, it is expected that I will be able to fully
> integrate two commands with sparse index during the GSOC program. My plan
> is to evenly distribute the work for each command over the course of the
> program. I am confident that I can start the project early as I have
> already established communication with my mentors and familiarized myself
> with the related documentation, although my understanding may not be
> comprehensive.

"Two commands per 175 hours" is what I characterized as "rough
expectations," but the actual number of commands integrated for the project
will vary based on the complexity of the commands chosen. In a proposal, I
would expect an applicant present their own, more detailed reasoning around
how long various parts of the project will take, rather than simply quoting
my high-level estimate.

> ## Availability
> 
> I will respond to all communication daily and will be available throughout
> the duration of the program. Although I will be taking some summer courses
> at my university, I will not be enrolled in a typical full course load. As
> part of GSOC, I plan to commit to 175 hours. I have experience managing my
> time effectively while taking courses and working full-time internships in
> the past. My semester ends on August 15th, and I have no commitments for
> the following month, which allows me to continue working beyond the end of
> the semester. With the flexibility to extend the timeline of GSOC, I am
> confident that I will have ample time to complete the project. I have
> already discussed this with Victoria, the mentor for the project, and she
> has agreed to extend the deadline until October 2nd, if necessary. After
> August 15th, I will be able to work at least 8 hours per day, totaling
> ~360 hours of work until the October 2nd deadline. 
I said that "I'd be willing to extend as far as Oct 2 (four weeks) if
needed", but that's a general statement about my own availability and does
not mean that I think such an extension is necessary in this case. The ~360
hours you mention is too large a margin over the 175 hours allocated for the
project to properly understand your planned availability. I would prefer a
more precise breakdown of the time you actually intend to spend on the
project.

> # Some Credits to Myself
> 

[...]

> Victoria mentioned that I was the first person to express interest in the
> project this year, either directly or via the mailing list. 

I want to be extremely clear on this point: while you were the first to
reach out to me, I do not consider that a weighting factor as to who is
ultimately selected for the project. The application deadline is April 4
[3], and I acknowledge that not every potential applicant has the time
available right now to get an early start on preparing their application.
Most importantly, I _absolutely do not_ want your comment to discourage
others from applying.

[3] https://developers.google.com/open-source/gsoc/timeline

