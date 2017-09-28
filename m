Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92CF920A2A
	for <e@80x24.org>; Thu, 28 Sep 2017 20:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750943AbdI1Uas (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 16:30:48 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35938 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdI1Uar (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 16:30:47 -0400
Received: by mail-vk0-f67.google.com with SMTP id w23so704357vkw.3
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 13:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kTaGVwIlHVu1lkZHEII31Rw0OdWLntbh7A6OZguBk8I=;
        b=aK5AsGp1WBe/gzwsINc3j0aWjnVf3NNho+36TW2aqoWnLc6bwYCXr+1NHmFuacg+Eu
         WSvX1m7Hgem77MvUhCHzPuoyhNPgjmGfx7AztFohHR1s/OOHNhRyfDjLqOX7xlmZ9Wng
         9KFBbm0MhUIy+idYLkW137FslgkhJYLW4kwac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kTaGVwIlHVu1lkZHEII31Rw0OdWLntbh7A6OZguBk8I=;
        b=fE4yc3GX42sD9CpfqbIAk+QwkxJ8gSXb77soyxyFbIsrP6praSrt/qPkJyaIw8xYkD
         oOnKchZpx0bx1Ek2q4+5Wbl/AjOAnLylIzwriFjDdThJO2184bp9NHsy4EG1KFcqDdty
         +OKkZ6QPKXnOZzWPSlCKILG3FxzVRgTCmRMU4JmVPEp5ntCXs0adMpU3t+lS8eYctbSP
         l8EQr5oydm/ub2YQBFSeRiR4IbT82iDq/fuXW/HMTuGhuf9h8yUcOAPii8B7bA8tPz4R
         w8QmPvrBQaW4gtqpKYimsR21W7+biMiXKeJuzvaTU12Lf0OlvZngleASZbflcBEKBhN/
         aQEA==
X-Gm-Message-State: AHPjjUgsSTvd6liN2XW0rIzjr6aUxIM5fVP+CfNbreb6B4Z51WqEcUNd
        tIzgQcN04yyLUftK/NI/75XQiTdy5f3dbwcYQD5ztg==
X-Google-Smtp-Source: AOwi7QAfqNQfZl6DkNlmT/j3zSTm/pU18WW5koD6qPAONuTkYMy5ICyZaadDklXQumDgJUXa52q5AdHPOmrR+k/4nGw=
X-Received: by 10.31.197.196 with SMTP id v187mr3169145vkf.2.1506630646397;
 Thu, 28 Sep 2017 13:30:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.146.1 with HTTP; Thu, 28 Sep 2017 13:30:25 -0700 (PDT)
In-Reply-To: <xmqqo9pv156t.fsf@gitster.mtv.corp.google.com>
References: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
 <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com> <xmqqo9pv156t.fsf@gitster.mtv.corp.google.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Thu, 28 Sep 2017 13:30:25 -0700
Message-ID: <CAH_=xoY_WihdNEeZTcUyYR8jFu17L0gnS8umLToOR6ER0A=RSQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks
 even if object_count==0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Rannaud" <e@nanocritical.com> writes:
>
>> +# The commands in input_file should not produce any output on the file
>> +# descriptor set with --cat-blob-fd (or stdout if unspecified).
>
> Thanks for documenting this.  Swapping the order of starting
> fast-import and feeding its input (which is one change in this
> version relative to the previous one) alone would not help, because
> in the updated order in this patch, nobody is reading from
> fast-import until the parent process finishes feeding it.

Darn. That's correct, on a platform with blocking pipes it would not
work. I will start the input cat in the background (so it may block
while writing), before reading from the output of fast-import.
