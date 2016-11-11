Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC5C2021E
	for <e@80x24.org>; Fri, 11 Nov 2016 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965982AbcKKJKp (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 04:10:45 -0500
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35515 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965818AbcKKJKl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 04:10:41 -0500
Received: by mail-yb0-f170.google.com with SMTP id d128so3286779ybh.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 01:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVqw9kLABOxlAFckQpTkxC31qX+vfF1IR/DXKUPgmdw=;
        b=FBaOaMM+UEiqJdHbq7sMe7/vKoXfJQfK4nGcIEqYPqLnYAUjRCJ2zcvNCwGmVwEEHU
         jNgCLDQJ8MOy3s4yDAHlPrzDcbLqvZ2/yf6JMZrQdFqKW9VPSY7AGtcnzz6F4o3MXZDm
         2BEUJg/TSb3J1yN89j6T0JlFN9F0qRWWs/Ppf9cOz+BPTR7tb6Xa65og0mfY13eEVZiE
         gG96Nzxjfl9q7n+Kubzaq7JEzWgmF+BTXpZ9KgvKxjeOCfj2Ld8xDiZtblsFBvt5CyHk
         x45lRpOrvPwRI8/SY8paiUvlo04wAUGEAjO9hdb6EFn1PuuVG0DcqWnlVQy0VIlORjIo
         oLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVqw9kLABOxlAFckQpTkxC31qX+vfF1IR/DXKUPgmdw=;
        b=SS3iNdSf6AC9cJnt5peohwHsdsNWia6bBRFvM/kt8CgxUdtWJw03kkwhY1/AiHG9pp
         HxuXNZ+w+AT262h2hdhhwkToLYftk9zA3w30/uc8J+z1SPItbNOKCLVwXi79BGEmQWJo
         HkOXbKAHMP7iBsrteCuj6h56uK+kbaYIdz9EptrrPpaQCbySxsEUc2ImB8hQn3zMD+Xl
         /sLOUIfDCtNfEzJwBl5MA7wc0eTJB5QGs8aTFfZPoW32zOkzLaRjSFMOWN4ve5UnSEhX
         mTIKu5voWxlMg+b41zQ4MtjYfo/nRbG3JmvRoU1mnA2Y5gpJj9vCIr2CWaxT3d0Y3+/I
         +mjw==
X-Gm-Message-State: ABUngvcCZ3b6q7hdTsEVg3GX9WfHb8GwugcigtwJnvtkF4P5mA99tMM6NC08Pn0vOoqxaMcnpO3CXv4wQ1B8Xg==
X-Received: by 10.37.172.65 with SMTP id r1mr1257079ybd.132.1478855440592;
 Fri, 11 Nov 2016 01:10:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Fri, 11 Nov 2016 01:10:10 -0800 (PST)
In-Reply-To: <xmqqwpgb3p3g.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-2-Karthik.188@gmail.com>
 <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com> <xmqqwpgb3p3g.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 11 Nov 2016 14:40:10 +0530
Message-ID: <CAOLa=ZSrhN0DAKN2aex5EThPQJ4C8GULLvckhct3n6NgXJge9w@mail.gmail.com>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and
 %(else) atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 4:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Ok, so I have only one minor nit, but otherwise this looks quite good
>> to me. A few comments explaining my understanding, but only one
>> suggested
>> change which is really a minor nit and not worth re-rolling just for it.
>
> As you didn't snip parts you didn't comment, I'll use this to add my
> own for convenience ;-)
>
>>> +if::
>>> +       Used as %(if)...%(then)...(%end) or
>>> +       %(if)...%(then)...%(else)...%(end).  If there is an atom with
>>> +       value or string literal after the %(if) then everything after
>>> +       the %(then) is printed, else if the %(else) atom is used, then
>>> +       everything after %(else) is printed. We ignore space when
>>> +       evaluating the string before %(then), this is useful when we
>>> +       use the %(HEAD) atom which prints either "*" or " " and we
>>> +       want to apply the 'if' condition only on the 'HEAD' ref.
>>> +
>>>  In addition to the above, for commit and tag objects, the header
>>>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>>>  be used to specify the value in the header field.
>
> I see a few instances of (%end) that were meant to be %(end).
>

Will change that.

> Aren't the following two paragraphs ...
>
>>> +When a scripting language specific quoting is in effect (i.e. one of
>>> +`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
>>> +atoms, replacement from every %(atom) is quoted when and only when it
>>> +appears at the top-level (that is, when it appears outside
>>> +%($open)...%(end)).
>
>>> +When a scripting language specific quoting is in effect, everything
>>> +between a top-level opening atom and its matching %(end) is evaluated
>>> +according to the semantics of the opening atom and its result is
>>> +quoted.
>
> ... saying the same thing?
>

Yes. I'm not sure of what the context even was, but I shall remove the
first paragraph,
the second one seems to notify the same thing in simpler terms.

>
>>> +               }
>>> +       } else if (!if_then_else->condition_satisfied)
>>
>> Minor nit. I'm not sure what standard we use here at Git, but
>> traditionally, I prefer to see { } blocks on all sections even if only
>> one of them needs it. (That is, only drop the braces when every
>> section is one line.) It also looks weird with a comment since it
>> appears as multiple lines to the reader. I think the braces improve
>> readability.
>>
>> I don't know whether that's Git's code base standard or not, however.
>> It's not really worth a re-roll unless something else would need to
>> change.
>>
>
> In principle, we mimick the kernel style of using {} block even on a
> single-liner body in if/else if/else cascade when any one of them is
> not a single-liner and requires {}.  But we often ignore that when a
> truly trivial single liner follows if() even if its else clause is a
> big block, e.g.
>
>         if (cond)
>                 single;
>         else {
>                 big;
>                 block;
>         }
>
> I agree with you that this case should just use {} for the following
> paragraph, because it is technically a single-liner, but comes with
> a big comment block and is very much easier to read with {} around
> it.
>

Ah! I see, sure I'll change it :)

-- 
Regards,
Karthik Nayak
