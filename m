Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD42203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbcKOBgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:36:22 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34554 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcKOBgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:36:21 -0500
Received: by mail-yw0-f179.google.com with SMTP id t125so82602152ywc.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 17:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lFEa8nuNe5aayMBGUeqjwUfUTl6Xkc2rGlFMN/8yLn0=;
        b=a9sz8LXlRKGr68UEelKBPVNzp9sKf7knjnAMOEYxBQZGD+eOmuzX/NkkEfNv3lHcZq
         5jo6U68VXmrRNuhdmpNVRbnV7B+C0vcdeNzNdb0C6+yTIgtE248cmumUdnPKCVXNlB3Q
         98/+laL6TIQPIQOSxiK4dcOgI5f4aIbhoFzq0y19hwavXSGnqTGaSMQU4toLLWTsMTSG
         xdPhgPcrNxVNVDJ6u5AxV1w8aQ0Dxv9NeLV9W5E/0btIXfn7rtLQtfMEx9zeqrdpGSbv
         6RSunuIUZDkph2K0Hsrek48GTyMYHdFioYLgCqIJjnrv3Y+Y8pjypLlV/JYlvb6TS5fo
         956A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lFEa8nuNe5aayMBGUeqjwUfUTl6Xkc2rGlFMN/8yLn0=;
        b=Dm3dRcYcECPw2bYRI4gh9HmMrnIAPhGXHpDDJ6JZuy9UTxSocoWErWzTRAqc6Zn3pC
         Co49gRpNB5zMGZ2/c6yboO1J/7SY4hM/dXf/mo0bAS3Yo9BiEVgI1+qaUpSxzFTsSOfK
         yOiSNgfpS+ZA3uzaZPVZGPW1lbQkqSHAGobqz6hRbnuVOZMrkKipo6IclTfZk/cb1jjZ
         9mRPMD1A7DdAhSFdKtoezlbRON/mjSQwhSOcY3cQV4u2F27GGrNpMRtCDUirTgDudUAW
         OUl+ubPCoaaVoyzjB7UTMNbThC4NfIgPo2RiGGnk2Rrg65j2uDDZgAQ/IgvRag++1Y8x
         jZrg==
X-Gm-Message-State: ABUngvdyykSnsYwto5n4+NvhY9vFgERIZFpgfeCWGLYLRUbfXmQRR17w2nnehEFpI91JR1nSXIMHXfL44kq1Ug==
X-Received: by 10.129.130.193 with SMTP id s184mr16781302ywf.276.1479173780741;
 Mon, 14 Nov 2016 17:36:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Mon, 14 Nov 2016 17:36:00 -0800 (PST)
In-Reply-To: <CAOLa=ZQSQe=jfTpdyscZCZgi5p6cVLN23oi2eE-hqFTXgt2LEQ@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-17-Karthik.188@gmail.com>
 <CA+P7+xr20UyKMKUZBpP-SjtEhbow2df+iT6nF67mOAZ8BAaxEg@mail.gmail.com> <CAOLa=ZQSQe=jfTpdyscZCZgi5p6cVLN23oi2eE-hqFTXgt2LEQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 14 Nov 2016 17:36:00 -0800
Message-ID: <CA+P7+xpWTwA2S+nHDsX4pemCsw=XWToYOMkevPMdLZy3ywagWQ@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 11:23 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Hello
>
> On Wed, Nov 9, 2016 at 5:44 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> Port branch.c to use ref-filter APIs for printing. This clears out
>>> most of the code used in branch.c for printing and replaces them with
>>> calls made to the ref-filter library.
>>
>> Nice. This looks correct based on checking against the current
>> branch.c implementation by hand. There was one minor change I
>> suggested but I'm not really sure it buys is that much.
>>
>
> Thanks for this review. More down.
>
>>> +               if (filter->verbose > 1)
>>> +                       strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>>> +                                   "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
>>> +                                   branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
>>
>> When we have extra verbose, we check whether we have an upstream, and
>> if so, we print the short name of that upstream inside brackets. If we
>> have tracking information, we print that without brackets, and then we
>> end this section. Finally we print the subject.
>>
>> We could almost re-use the code for the subject bits, but I'm not sure
>> it's worth it. Maybe drop the %contents:subject part and add it
>> afterwards since we always want it? It would remove some duplication
>> but overall not sure it's actually worth it.
>>
>
> If you see that's the last part we add to the 'local' strbuf in the
> verbose case.
> If we want to remove the duplication we'll end up adding one more
> strbuf_addf(...).
> So I guess its better this way.
>

Agreed, I think that it makes more sense to keep this as is. It is
relatively complicated and the strings do have some duplicate code,
but I think it's still ok.

Thanks,
Jake

> --
> Regards,
> Karthik Nayak
