Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B1B20988
	for <e@80x24.org>; Wed, 19 Oct 2016 00:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936095AbcJSAU4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 20:20:56 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34066 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933277AbcJSAUz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 20:20:55 -0400
Received: by mail-qt0-f173.google.com with SMTP id q7so6466504qtq.1
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yqtiHUIyFMn4vcqyg8X03hjs+mPCVKoooeQVJFsVb0M=;
        b=Q7ZvzOFiEcGlPpzhXDg1Wg8xbOdkkExbGTmjbA1rQ9iBkte3GczKc2Yvg3t+aTu5IZ
         wRYFHOv/eMR334xiu25KNDFw/a+ES0Bi2QtkTX9XqTxBGiuUUZzkDgt/oYqxVAAdZ+lb
         ksLnaHxQ7DzJXf6OQhBnhWsZV+tnqF/Y7+Ey5LRHjcgZQlS8OFKvAA7e4mpus+FCPAJ1
         NxgJJZYVxkOdz1/FNcySzuBhYhgWZc9bXkksVtEs7XmxXebuFikkm+Gw6IJl7AL+cyft
         ZJkTfwAi+E0UM1A1W4/Wb5etKz9d/CaZqKEIEdA0lEV8p8Awnok8kFy7MvL0a6IoOCGg
         k4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yqtiHUIyFMn4vcqyg8X03hjs+mPCVKoooeQVJFsVb0M=;
        b=DOGmrWT1z+LY8e9CoU9mT+LSIBT2bhmy6x08t2nCtFf9+/zIMiJDqLwbyhrPpCeAO7
         w3e+jJv7N9d9FPu2uwdt6SjfkRfKntLaTQHsVg3GThwbjlBqi+9fxKf8rB8ioLz7jsut
         uUtBaCRi4inBuWpeEoxmUYMpt8tPAkT0K9YhVUeQKZKjwvgxgmMr7ODVjRpJZk9iYJ0o
         fNci+pEmRhitl7VHQq2ceWZuK3pROdzX0vEcfzjPYQkcynKr7TSsJrHTFtz+jzPdaoUy
         lQo7oqAV/dbYjG2Gnf6BhVEYi1vkKZKcoYvDngUouVQ9Ag1l5uYynKg7cjBpFH08l68r
         xXLQ==
X-Gm-Message-State: AA6/9RlcXklVufcGNk5gxSsYGuwOj6ZBhSL8OK1UOFg0H5PDQOgy+iX8fxNU04JyStIFaYjutCc56b53Ep0x7F4+
X-Received: by 10.237.56.137 with SMTP id k9mr3565753qte.131.1476836454311;
 Tue, 18 Oct 2016 17:20:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 18 Oct 2016 17:20:53 -0700 (PDT)
In-Reply-To: <CAPc5daVF2HBD2DfP=w2oG-2PMWQ+guXP_onQX+foSgVYH4N1Qg@mail.gmail.com>
References: <20161012224109.23410-1-sbeller@google.com> <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
 <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com> <CAGZ79kbS4mP7sVTCM+QJXTwKsgZ40xvVDng-F3igZnJWLYek0A@mail.gmail.com>
 <CAPc5daVF2HBD2DfP=w2oG-2PMWQ+guXP_onQX+foSgVYH4N1Qg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Oct 2016 17:20:53 -0700
Message-ID: <CAGZ79kbq7m6s5s8OCXFwyonUdiaL3nVNCoGS40xkH2qKCkYzag@mail.gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 5:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Tue, Oct 18, 2016 at 4:52 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> >
>> > By the way, I do see a merit on the "check" side (tl;dr: but I do
>> > not think "result" needs it, hence I do not see the need for the
>> > "ugly" variants).
>>
>> So we'd rather go with const char **result instead of our own new struct there.
>> Ok, got it.
>
> I do not think you got it. I am talking about wrapping struct around
> an array of element,
> not each element in the array. IOW
>
>> > If we were still to do the wrapping for result, I would say that
>> > basing it around the FLEX_ARRAY idiom, i.e.
>> >
>> >>         struct git_attr_result {
>> >>                 int num_slots;
>> >>                 const char *value[FLEX_ARRAY];
>> >>         };
>
> the structure around the array of elements (value) that allows us to have
> something other than value[] in it. That is what I said "I do not see
> the need for".
>
> It is perfectly fine future-proofing to have
>
> struct git_attr_result_value {
>   const char *value;
> };
>
> and have the users of API declare
>
> struct git_attr_result value[5];
>
> or whatever. That way we could fatten the structure later if we wanted
> to without having to update the users of API, and there is no downside.
>
> Having wrapping strut around the array does have a huge downside,
> and that is what I said I see no need for.

I am not sure if I see the upside on wrapping a single value except for
its future proofness, i.e. what if we want to transport information that
is valid for all values, e.g. an error code or that the result check was done
lazily (for non lazy you would need to do X) or ...

IOW I would expect there to be more use cases for information regarding
all the values and not each value enhanced by a thing.

We could just repeat the thing in each of the 5 values in
> struct git_attr_result value[5];
though.

I'll go with that.
