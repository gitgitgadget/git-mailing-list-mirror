Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B95203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 05:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbcKOFQt (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 00:16:49 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:38177 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936544AbcKOFQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 00:16:48 -0500
Received: by mail-it0-f51.google.com with SMTP id q124so169939305itd.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 21:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kl5oMHAVNBmFqS8pS47mnYoSdR6TFuhd8vtOwsc4aas=;
        b=wHEr1O871281Id64IC2uOLwUkndxDe82tP9O8G92YS7Y2PM4CJW67xqAt/6gfZWBbL
         I0q92upFSVCJkU15d+gfXIdMLAxiMsRUC6rnP/jisiq1y3BovsW8iw2Fpetjza2lgyhA
         mxyGNRAZrMGgJ5W1lS+AcTIFoKplODRoJd6es4SdIwo/ZPow6WQIcIOBNhC1xprSFRSj
         t/vS/sMRA3cMGBj0mJHGQlxuDgEbs6AUX+sQMMrAZipx9w4yKXZIRsto9EGWowVaOqvW
         nduwvRooydUP29Ula/80Qma+Axmkm3aL4sIS+r1mFHyIaeOAjKv42ucnd6FYtioJLUuR
         riCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kl5oMHAVNBmFqS8pS47mnYoSdR6TFuhd8vtOwsc4aas=;
        b=Av/Mhw9z1TmQIneoRMlpYoXCowQWFNrMERhhG+zFZHlD7lRhva588p7pAPaynapaLO
         B0cgd5TeqfYa5TN7t+QbWCFrFN6FmitXElp/WBtE4VG1fRClfYtx1fkpcRrQjUWK1gos
         Y1PzlSaq2HJEyO0JK9Rjk5Phqe5MMO+dw8+882SejpeD8RiKjNSpZQy+pBy4KszV8H0t
         fkAj9JAENkmsERtHNW9psQINh+FHjsUzacBh8SolWX/qtsKG7gLp+/pYQ0FGg0BAjhRL
         Km+daaeHWjE++Hucvo5mzObWPToQ7xBrLfd4ZQoJsz/0e7ncEQsUOZ79h6NKrASNKtNr
         zcOg==
X-Gm-Message-State: ABUngvdeSUzLS1BpW7thbyluZXMNYdnMTYcLyfE73xFemiM59/lF8sBlkvkgF6JChq/OJJTTRd7yzUPApHYLNg==
X-Received: by 10.36.83.213 with SMTP id n204mr1544824itb.100.1479187007822;
 Mon, 14 Nov 2016 21:16:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.27.209 with HTTP; Mon, 14 Nov 2016 21:16:47 -0800 (PST)
In-Reply-To: <61aacd44-cb6a-2bbb-7fb4-933e2505040d@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1a74-ad2bcaff-0c92-4af4-9aa0-72d98f4945fc-000000@eu-west-1.amazonses.com>
 <61aacd44-cb6a-2bbb-7fb4-933e2505040d@gmx.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Tue, 15 Nov 2016 10:46:47 +0530
Message-ID: <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
Subject: Re: [PATCH v15 02/27] bisect: rewrite `check_term_format` shell
 function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Tue, Nov 15, 2016 at 3:50 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi,
>
> I saw in the recent "What's cooking" mail that this is still waiting
> for review, so I thought I could interfere and help reviewing it from a
> non-git-developer point of view.
> But only two commits for today. The first one seems fine. The second
> one makes me write this mail ;-)

Thanks a lot!

> On 10/14/2016 04:14 PM, Pranit Bauva wrote:
>> +static int check_term_format(const char *term, const char *orig_term)
>> +{
> [...]
>> +     if (one_of(term, "help", "start", "skip", "next", "reset",
>> +                     "visualize", "replay", "log", "run", NULL))
> [... vs ...]
>> -check_term_format () {
>> -     term=$1
>> -     git check-ref-format refs/bisect/"$term" ||
>> -     die "$(eval_gettext "'\$term' is not a valid term")"
>> -     case "$term" in
>> -     help|start|terms|skip|next|reset|visualize|replay|log|run)
>
> Is there a reasons why "terms" has been dropped from the list?

It is a mistake. I will rectify.. Thanks!

Regards,
Pranit Bauva
