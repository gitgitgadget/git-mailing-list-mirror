Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A391F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfA2SC0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:02:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36321 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfA2SC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:02:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so18779840wmc.1
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 10:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oSOAkxkCKswVLF7OmccStogUGBewUV0dcqo0pD8dMjA=;
        b=DTKWvX6Qyp2gYH+G2ZObGKVo1ZVApPrb6tyuDYWUIM6K5H1FZOOFxKQlwLC59lMO9b
         B0J6NM45QMMxjVa/IAcckylHqTbB0BEv7DqXtiso/VFmKODxvHcyQMlkSWRODmOKLXXN
         R6qTQeQohPaXgGbceat7J4mObLPrQZRAUjt2Wd75Hys89GrPCRojCVYgQzCH/wcTQyGL
         lX8E4MEFn5MqJFNwjwV9moG2HsR8sd4wDfoyVPx2Y1UH/VEm00HODTZx0gF7X2EHY4ov
         k2ibsEO26FWYUJx8xXfcY2WwgtjDMvoRaNhpOKQIzb15T8EgweWJns08HwJ1iFFntmyi
         y5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oSOAkxkCKswVLF7OmccStogUGBewUV0dcqo0pD8dMjA=;
        b=fy3xOgIUQ7CdQ0uMjD3+E+CpDcv4f/RFIenn2w5lWRoKeHUKYSqCevrSLFcsj5aYdy
         aQteK1Zall3U36EOzPuL5y/G2TmXYvdgEu5HZlavOEUQdAVvMIgZCwopWuk05FGqiWMP
         Ow+U2BLFS23RIFtr5SVu1rrUWht1BS+t4l24S0CeO0peWAsudRqljb0eDUicxxQoRr3y
         j8DPWGuvAhYO2kfi+PWe/VEIycZ1dU2XTpzLKd26kWZlVzp+UW5NhBdnoeW3alm8rwgJ
         Zl+ALPLUe7+rvTOl3eigXQTAqF8L/39lkcdHWMVn1dhqq5br1m2U+gq9HwBr+VKRRbgn
         /PWA==
X-Gm-Message-State: AJcUukdtkNgA9AqjLIF5+6LDzfU38NZQwB1hRGdxP7vZ8NGqmjjchMUq
        X41DSE2/7UXS463RioY+1Y0=
X-Google-Smtp-Source: ALg8bN4CTKTdzXJUkAqnNwUyOYlN5mCRvPkZAdsHAtCcXjMCH2ugxIbQxW7rlXeOr2ZY/LWZRNBOdQ==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr21949354wma.24.1548784944030;
        Tue, 29 Jan 2019 10:02:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c65sm4209269wma.24.2019.01.29.10.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 10:02:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] evolve: Add the change-table structure
References: <20190127194415.171035-1-sxenos@google.com>
        <20190127194415.171035-5-sxenos@google.com>
        <nycvar.QRO.7.76.6.1901280858060.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1901290005390.41@tvgsbejvaqbjf.bet>
        <CAPL8ZiuKnvQd1tpbsT+xn2Dt0rMs_ggQKOSz_vMda3i1V1YfHQ@mail.gmail.com>
Date:   Tue, 29 Jan 2019 10:02:22 -0800
In-Reply-To: <CAPL8ZiuKnvQd1tpbsT+xn2Dt0rMs_ggQKOSz_vMda3i1V1YfHQ@mail.gmail.com>
        (Stefan Xenos's message of "Mon, 28 Jan 2019 15:24:45 -0800")
Message-ID: <xmqqef8v8hqp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

> Sorry, folks. I normally can't do any open source work on weekdays.
> That also includes writing responses on the mailing list, so there
> will normally be a week or two lag for me to iterate on this sort of
> thing.
>
> Feel free to either include this fix or revert my patch if there's a
> problem with it - just let me know what you selected. I'll roll with
> it and either resubmit with the requested changes or submit the
> requested changes as follow-ups.

I think double casting Dscho did was not his ideal "fix" but he did
it as a mere workaround to force the 'pu' branch to compile.  And I
also agree with him that the double casting workaround is too ugly
to live, compared to a union he suggests.  So I'd rather kick the
branch out of 'pu' for now.

Thanks, both.

>
>   - Stefan
>
> On Mon, Jan 28, 2019 at 3:08 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> Hi Junio,
>>
>> On Mon, 28 Jan 2019, Johannes Schindelin wrote:
>>
>> > On Sun, 27 Jan 2019, sxenos@google.com wrote:
>> >
>> > > +   new_item->util = (void*)index;
>> >
>> > This is not good. You are using a `long` here. The 80s called and want
>> > their now-obsolete data types back.
>> >
>> > If you want a data type that can take an integer but also a pointer, use
>> > `intptr_t` instead.
>> >
>> > But even that is not good practice. What you really want here is to use a
>> > union of the data types that you want to store in that `util` field.
>> >
>> > This is not merely academic, your code causes compile errors on Windows:
>> >
>> > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=400&view=logs&jobId=fd490c07-0b22-5182-fac9-6d67fe1e939b&taskId=ce91d5d6-0c55-50f5-8ab9-6695c03ab102&lineStart=430&lineEnd=440&colStart=1&colEnd=1
>>
>> Since Stefan did not grace us with an answer, Junio, could I ask you to
>> squash this in (which is by no means a satisfactory fix, but it is a
>> stopgap to get `pu` building again)?
>>
>> -- snipsnap --
>> diff --git a/change-table.c b/change-table.c
>> index 2e0d935de846..197ce2783532 100644
>> --- a/change-table.c
>> +++ b/change-table.c
>> @@ -103,7 +103,7 @@ void change_table_add(struct change_table *to_modify, const char *refname,
>>         new_head->hidden = starts_with(refname, "refs/hiddenmetas/");
>>
>>         new_item = string_list_insert(&to_modify->refname_to_change_head, refname);
>> -       new_item->util = (void*)index;
>> +       new_item->util = (void *)(intptr_t)index;
>>         // Use pointers to the copy of the string we're retaining locally
>>         refname = new_item->string;
>>
>> @@ -201,6 +201,6 @@ struct change_head* get_change_head(struct change_table *heads,
>>                 return NULL;
>>         }
>>
>> -       index = (long)item->util;
>> +       index = (long)(intptr_t)item->util;
>>         return &(heads->heads.array[index]);
>>  }
>>
