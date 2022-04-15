Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14351C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiDOVE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiDOVEM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 17:04:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AFBDEB93
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:01:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m8so10612793ljc.7
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8qcdACtXSn0Dzo0nb6fYXDqNyeZ2rVrnapOMEvPDeM=;
        b=adO9rJNnJ1u+5XCN4jzrLp68qiWPuYn/i/2PSRithrhtrR4KlBwVzFF/YsBEqxSAsS
         QyObNb5tLMxi2uR1SxwKyYAM0i1vuSSE+cKaTBJ7tugIIVwOvy+qU8G6KCeQkK/8KK//
         rPvxOvR832ToGw9jeMwTOMJI6dTEH2qKmYFwn0S0m0lXSun+/oGAFy5DszSe/MFWo32P
         m0WRcfikSHGWiaorVzbVIqDCYyAnAsfMhjX2geZTjZWA2J+VDMQfXUJJjOHy8280xWCW
         npaFC5ySKncgYSRMWAH9J87xO8BMvd12r15ML5/SfsC95Zm+B0KRHIWFEOiJ5+s71fNY
         fEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8qcdACtXSn0Dzo0nb6fYXDqNyeZ2rVrnapOMEvPDeM=;
        b=iEhV7t0MBwy0/Xqew1Vi3yJmRzZ53JsVczH/FAzzYjq1QlMkBQ9Zp6caO7/8153zKe
         Da/KAWOWZh5rh5pZtBZXrvWjdMVOtRLmdSeawGHaO2sLspXnvYCmhQTSRY9oRzJFs43L
         3skGuh0duYF9fbo5Tosw9DrfZqpXJOHDIKsbw5MbfIJ6tDCYn3MPHGJaqh8KPSSXJlHJ
         TkAfMtGK1YFoLt05o7NNmQnVhqJMAdop7pBUGcMrjOY+K9EngKbEK6XI+HdB0KM9NeCU
         1VJHqZLntRX8bNFfycLfLLglwmauapxRepeXTmSVInqodGGXPdHNTMJLZheDRB2R6mIm
         DhMA==
X-Gm-Message-State: AOAM5339qLdxweKM+6VEejuckUiSM+3rouLzsM0ZXnI8k28LeTDCCS47
        tsVn6/y8k9vny6gYAeiF5nWnW7qabXdXDntfEWg=
X-Google-Smtp-Source: ABdhPJxiCtzwGp3xSjwh45ZzqLiWfwCZuZey4fbRa0Ss2u9LiMGeOrN0ULBIMJQ7t0k0svfU7epvalneykdA81XP1gA=
X-Received: by 2002:a2e:5d6:0:b0:24d:a502:240e with SMTP id
 205-20020a2e05d6000000b0024da502240emr480620ljf.22.1650056494003; Fri, 15 Apr
 2022 14:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local> <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <Yk21JvirO6FyQ3Va@nand.local> <e312b18b-f0d6-8980-9cad-74602043a1db@gmail.com>
 <CAP8UFD1x-JEX8MAmpabK4RbKgmVm1VQYNJdX3fP8Op5WMfUgVg@mail.gmail.com>
 <YlCcQw6FuWufLe74@nand.local> <Ylc4rWZf380FlEbj@nand.local>
In-Reply-To: <Ylc4rWZf380FlEbj@nand.local>
From:   Plato Kiorpelidis <kioplato@gmail.com>
Date:   Sat, 16 Apr 2022 00:01:08 +0300
Message-ID: <CAO2gv83WXPmABfVu_YR57rJg8sJ7mv-pUuXDpxYw644gcRCtYw@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        git <git@vger.kernel.org>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 11:55 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Plato,

Hey Taylor,

>
> On Fri, Apr 08, 2022 at 04:34:11PM -0400, Taylor Blau wrote:
> > Instead, let's keep the project as-is, and have the accepted student
> > focus on one of the first two bullet points, taking into account that
> > we'll first want to spend some time thinking about whether or not the
> > current .bitmap format is appropriate given the proposed changes.
>
> If this sounds interesting to you, I would encourage you to submit a
> proposal similar to the ones in

Yes, it does sound interesting to me because it's an experimental
project. I'm working exclusively on my proposal for the past week
reading papers and benchmarks, while writing digests about them
to include in my proposal, in favor of roaring method. As you also
said, having a proposal with references and digests about previous
work, discussions and papers does help regardless of being selected.

Technical question: will roaring bitmaps' random access feature help
with introducing the "table of contents" feature? Or is it bitmap
compression agnostic?

>
>     https://lore.kernel.org/git/20220406200440.27010-1-chakrabortyabhradeep79@gmail.com/
>     https://lore.kernel.org/git/20220409184350.1124-3-shivam828787@gmail.com/

Thanks, I've already read both of them and used them as guideline for
my proposal.

>
> Feel free to take a look at mine and Kaartic's responses to each of
> those, two, since they may influence your planning / which sub-project
> sounds most interesting / etc.

I saw your and Kaartic's reviews and incorporated them into my proposal.

>
> Thanks,
> Taylor

Thanks,
Plato
