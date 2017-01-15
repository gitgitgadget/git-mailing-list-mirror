Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC63F20A17
	for <e@80x24.org>; Sun, 15 Jan 2017 05:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbdAOFvl (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 00:51:41 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35577 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750840AbdAOFvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 00:51:40 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so9408677lfa.2
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 21:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ksb4wFsvcJHfRxsz6X/z7BClncgQz/QydKkoox4FHLc=;
        b=AVh420chEBjIbnx+fKWu2gva4FmiJapXrJCn+0ItrOqokajMsm/bagrq+EaLY2kBnC
         4JgS6/MzYGJbQw2FVVBxENqOu9ghQf1s2BZFgKZhsXzv2CmL/IIot+6PxCDc05Skdop2
         PKafJUAuRfofuGNUt2lSc+AwdDA2wkVf57ZDuY1a9FVg6fyyq0P9EcFbSWrHkpy94kEK
         +gTEgmIs5UT36Yt8vnM3Hwmq6HEdp/OvBUSWMoY5XSzmi+H1D80GrYP3jRskkakKAfrS
         6G3kq0HtqGRyy+n3ScS3p2gN077wNuu6tKCdWcULDGIpDmRsO8cDtISCQo05oC1wKnxX
         kYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ksb4wFsvcJHfRxsz6X/z7BClncgQz/QydKkoox4FHLc=;
        b=kqqZcSoMRMvOOJ3Eefjs93nKV0weCuhsIYHPT+iUbQj2ARHhwziu/GUIU08sY5U4pR
         +RBnYWzjztiu/I3nIcq8dHrqGA/lYM94Okeiebz1Zao7Jip4Tpf5FWiMg/eVNgp1KQi5
         2UL6RvpSsBvVElRhFJTvCn+eZNLtA7OkgCDGk97/Z5qnjrUkNabgB2gF/1muon2S1CJn
         qDO5siuWsuVFspKmSNO0QVtWvrHQg3r1g527U9LfMFVKhaKGZLi5k4J7cRA8tte3ecVj
         k7O56wEXvViXMGLtz5AU2WfNC96lGwx8HMiYCi1bZmQGnw7R98r4Cy5SX5tBt6MNUH4G
         s4xQ==
X-Gm-Message-State: AIkVDXJSpo+QT7UrxsVZiaYmZ+bW4PCgAlCnjp170sRicf7WETC/kzREu5cCJAPrsSV0plX3ja1PIXVI7DMj/w==
X-Received: by 10.25.141.147 with SMTP id p141mr10430495lfd.147.1484459498916;
 Sat, 14 Jan 2017 21:51:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sat, 14 Jan 2017 21:51:18 -0800 (PST)
In-Reply-To: <CAOLa=ZQR9ksPtRw_9FneN26Mjq1TVYx7o=YOM4cDNgrDbuQtXg@mail.gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com> <20170110084953.15890-20-Karthik.188@gmail.com>
 <CA+P7+xqV+CJwP-0_27V26UZbkDzBqbdstGw_Rq=8c3SkjAq2bA@mail.gmail.com> <CAOLa=ZQR9ksPtRw_9FneN26Mjq1TVYx7o=YOM4cDNgrDbuQtXg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 14 Jan 2017 21:51:18 -0800
Message-ID: <CA+P7+xoN12HqaVnYfESrf3-1ZSWkxAz9K+7rRi2gPpGPNSYmHQ@mail.gmail.com>
Subject: Re: [PATCH v10 19/20] branch: use ref-filter printing APIs
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2017 at 2:01 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Hello,
>
> On Thu, Jan 12, 2017 at 5:17 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Jan 10, 2017 at 12:49 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> diff --git a/builtin/branch.c b/builtin/branch.c
>>> index 34cd61cd9..f293ee5b0 100644
>>> --- a/builtin/branch.c
>>> +++ b/builtin/branch.c
>>> @@ -37,11 +37,11 @@ static unsigned char head_sha1[20];
>>>  static int branch_use_color = -1;
>>>  static char branch_colors[][COLOR_MAXLEN] = {
>>>         GIT_COLOR_RESET,
>>> -       GIT_COLOR_NORMAL,       /* PLAIN */
>>> -       GIT_COLOR_RED,          /* REMOTE */
>>> -       GIT_COLOR_NORMAL,       /* LOCAL */
>>> -       GIT_COLOR_GREEN,        /* CURRENT */
>>> -       GIT_COLOR_BLUE,         /* UPSTREAM */
>>> +       GIT_COLOR_NORMAL,       /* PLAIN */
>>> +       GIT_COLOR_RED,          /* REMOTE */
>>> +       GIT_COLOR_NORMAL,       /* LOCAL */
>>> +       GIT_COLOR_GREEN,        /* CURRENT */
>>> +       GIT_COLOR_BLUE,         /* UPSTREAM */
>>>  };
>>
>>
>> What's... actually changing here? It looks like just white space? Is
>> there a strong reason for why this is changing?
>>
>> Thanks,
>> Jake
>
> None, I'm not sure how this ended up being added too.
>
> --
> Regards,
> Karthik Nayak

It looks like it might just be reformatting of some spaces or stray
end-spaces or something. Hard to see in an email.

Thanks,
Jake
