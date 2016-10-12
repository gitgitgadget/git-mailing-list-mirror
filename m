Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0F1C209F6
	for <e@80x24.org>; Wed, 12 Oct 2016 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756023AbcJLUCn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 16:02:43 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34621 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755983AbcJLUCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 16:02:42 -0400
Received: by mail-qt0-f174.google.com with SMTP id q7so26325872qtq.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xn6N6KaYt7f93agzLJNGgNfcJpMpmgeYL6R3RVPonOs=;
        b=MyxOT1N+YlkbOULFluV5P72uFXljzw6bkvXrNTJzUHbSddVl1qAdeNifFwKAswfcuu
         8lo7k0JjSQSpx9NVAadUKOvbrq2dGTEKsiNllR7xT7kb3T/WBeASl6EfvY8WULrAfFDy
         9rEbkCxtqoOcOYwWvI4WtGmW5nAlQwsMvYgvlvlbSV32XB0QTj4wAqPXwYlYT6u6xg4n
         SO9FsnGl8cJCP6YSSYf8E98mHh6dHboNmv6y5am8AuR8wRQyPnHeGiiPwWleyIpYJOWW
         NvZ6v0NH7UZHbLDoW5TZ1huSbOyGvfH+4xbmok8f9S6p/TuaZHlUrW4lrP2e1emwWShK
         OnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xn6N6KaYt7f93agzLJNGgNfcJpMpmgeYL6R3RVPonOs=;
        b=doTnO2NOavf2EKc26wxsLkfhsJ8W0EuhCxuwjAygAuhruYSZSXfY+n83Xk7cuoT4Ws
         im7gD7JrflsThbL3X3PShjFQdtVFWHiFFlivxxqeI2700/9LU3i57pWCoxbD8U8wViA0
         ae7PrxKAyTZBoLPE7ipZt47R4ahbI7sdNMa1rAPPqeRW2qJkCaclqcBU139OhpKPc++3
         2JGeFyQV682/xXqdNW2NNN1ddOls0Ng0lWTQSJZS7oyXlVnOx/O2cnyCoUTQTV6Pj3U6
         Dn6jaXvNcHRgnZYVunHYSP6weCc1E+WLjOLbTHsAg24ZUBomVkhBDBqyXB+9T/nDHKF6
         jrmw==
X-Gm-Message-State: AA6/9RnRyyOMMPHKsthQU36i+q3fjusaH0G5n28IDmH81fbC2dG9IIkQDTLWUFsbqWsVUrN+eQZBQ3LHA7bpcZy1
X-Received: by 10.200.34.145 with SMTP id f17mr3123898qta.149.1476302560877;
 Wed, 12 Oct 2016 13:02:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 13:02:40 -0700 (PDT)
In-Reply-To: <xmqqfuo15yjm.fsf@gitster.mtv.corp.google.com>
References: <20161011235951.8358-1-sbeller@google.com> <xmqqvawy5c4i.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZrNSmPAQ6SmBzFDJtSmdCbqKcgQu4KDLfoYVkSXvo-og@mail.gmail.com> <xmqqfuo15yjm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 13:02:40 -0700
Message-ID: <CAGZ79kaBhXHLDEK0XMLjm3QofmtaGZspA3EEx5x4-qCYY--wZA@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 9:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I am not sure if the updates to the callers fulfill that purpose.
>>> For example, look at this hunk.
>>>
>>>> @@ -111,6 +111,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>>>       struct archiver_args *args = c->args;
>>>>       write_archive_entry_fn_t write_entry = c->write_entry;
>>>>       static struct git_attr_check *check;
>>>> +     static struct git_attr_result result;
>>>
>>> As we discussed, this caller, even when threaded, will always want
>>> to ask for a fixed two attributes, so "check" being static and
>>> shared across threads is perfectly fine.  But we do not want to see
>>> "result" shared, do we?
>>
>> Well all of the hunks in the patch are not threaded, so they
>> don't follow a threading pattern, but the static pattern to not be
>> more expensive than needed.
>
> Is it too invasive a change to make them as if they are thread-ready
> users of API that happen to know their callers are not threading?
> It would be ideal if we can prepare them so that the way they
> interact with the attr subsystem will not have to change after this
> step.

As far as I see the future, we do not need to change those in the future,
unless we add the threading to the current callers, which is usually a very
invasive thing?

>
>>> In other words, ideally, I think this part of the patch should
>>> rather read like this:
>>>
>>>         static struct git_attr_check *check;
>>>         struct git_attr_result result[2];
>>>
>>>         ...
>>>         git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>>>         if (!git_check_attr(path_without_prefix, check, result)) {
>>>                 ... use result[0] and result[1] ...
>>>
>>> For sanity checking, it is OK to add ARRAY_SIZE(result) as the final
>>> and extra parameter to git_check_attr() so that the function can
>>> make sure it matches (or exceeds) check->nr.
>>
>> That seems tempting from a callers perspective; I'll look into that.
>
> For callers that prepare "check" and "result" before asking
> check-attr about the attributes in "check" for many paths, it is OK
> to use your "allocate with attr_result_init()" pattern.  The "result"
> still needs to be made non-static, though.

I do not see why we would want to have a non static result for
non threaded callers.

>
> But many callers do not follow that; rather they do
>
>         loop to iterate over paths {
>                 call a helper func to learn attr X for path
>                 use the value of attr X
>         }
>
> using a callchain that embeds a helper function deep inside, and
> "check" is kept in the helper, check-attr function is called from
> there, and "result" is not passed from the caller to the helper
> (obviously, because it does not exist in the current API).  See the
> callchain that leads down to convert.c::convert_attrs() for a
> typical example.  When converted to the new API, it needs to have a
> new "result" structure every time it is called, and cannot reuse the
> one that was used in its previous call.

Why would that be? i.e. I do not understand the reasoning/motivation
as well as what you propose to change here. Do you think of the result
being held at the top of the call chain (and there it may be just allocated
on the stack) and passed down all the way to convert_attrs, that writes
into that result?

Currently the static result in convert_attrs just works fine (as all tests pass)
and that is not the place where we'd add threading to?

Threading would be added in dir.c, a new place that will use attrs.

Maybe instead of discussing the meaning of this patch further, I should
rebase the "pathspecs can ask for attributes" patches to either experience
the problems myself or at least have a series that has a meaningful endgoal.
I thought this preparatory series may be better than sending an even
larger series.

Thanks,
Stefan
