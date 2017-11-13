Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6E41F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbdKMUFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 15:05:07 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:51409 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbdKMUFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 15:05:06 -0500
Received: by mail-ua0-f175.google.com with SMTP id l25so4030250uag.8
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 12:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KxasBmIO5o/yuZ5D7pF/p4GsTW4YlWuC5N7uFvZp5Rw=;
        b=CJjBu16I30Yb//sTk16CxzamhKZIue7puHVRp3+Y2mlETOJY1CiyuScew26Q+9EAZM
         62u1WsBVH6OwG0SLAGLFUsbKnNpk2Ovr92mNZyEbpLIqVHJUBnmV55y1tMUOXRM6sVaa
         3FrqkKEWzmPQsabxeeNGqqOHoDiwDcuMgmhv5FyoFdPkQ5Bdu5bY+24BYppfeMygXmGg
         5vXB9OizoHd9QyrOEWxdK8+RfaEXRG6iskDVfMYx8lKmVyGYUGw8qVb0bq5/wXl5CStE
         Nhcu+RBN4O1EPlX9nsRUl8ao2rcn9zoU/b0pv9D7Vkmina9Udq3lWdOXqRyhfDJ9ljEb
         euqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KxasBmIO5o/yuZ5D7pF/p4GsTW4YlWuC5N7uFvZp5Rw=;
        b=MHJjN0ht6t6kWifewzQRNMLk9fEPJkwSo7VztOlwqY/cqt0mrZzbk78hkAvLQBLqlA
         GAm8NrHwKnB/2jxn9vh0cWBws6Tq7YxIybsoeDlMLDnPIT965TnD613aKTeLcAfMllU3
         T69zJaLpAvMlqOl5IjGyDo2p7pmpnwmkOZdLZkwVuRjRvDdZ1GlrxLEHmv2f05W8hWhn
         QAKTtJHSYa8NSL3Td0FXZd+vYhxTfd9oN4xGfrJ/BBVn2bpurb3WZ0afJjBeHVbLzbtz
         GsP9q+L5O5M5ngKoqfGx3YL6P7mHTfa1942svWSGpmMIiWZOBa5jj0IqBvZ94Wh2ldfI
         tjGg==
X-Gm-Message-State: AJaThX4q+8lvkG8RoXcj8ZIgM9RCfmbwSRejTL1YylNz/26rnQsx/M4o
        pU40eCt3VdieW4AmOeWaB0RSyioPdfX1NbFK49Y=
X-Google-Smtp-Source: AGs4zMZsEQZtV/h7I3aPwc6vEChFKkWT1MQdS99TsnTDqJEiGJhwtbc4n/cWyS/3pvwwjmnJfCha6WPKxr0Yup4HXac=
X-Received: by 10.176.23.19 with SMTP id j19mr8406619uaf.87.1510603505814;
 Mon, 13 Nov 2017 12:05:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 12:05:05 -0800 (PST)
In-Reply-To: <xmqqtvxy92ey.fsf@gitster.mtv.corp.google.com>
References: <20171110173956.25105-1-newren@gmail.com> <20171110173956.25105-4-newren@gmail.com>
 <xmqqtvxy92ey.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 12:05:05 -0800
Message-ID: <CABPp-BH1Cpc9UfYpmBBAHWSqadg=QuD=28qx1oV29ZdvF4NbJw@mail.gmail.com>
Subject: Re: [PATCH 3/4] progress: Fix progress meters when dealing with lots
 of work
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reviews and suggestions!

On Sun, Nov 12, 2017 at 9:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> Subject: Re: [PATCH 3/4] progress: Fix progress meters when dealing with lots of work
>
> Style: s/Fix/fix/;

I also messed this up in a lot of my patches in my other patch series.
I've fixed them all up, but I'll wait to resubmit those other series
until I get some other reviews.

> The middle part of the log message may waste more mental bandwidth
> of readers than it is worth.  It might have gave you satisfaction to
> be able to vent, but don't (the place to do so is after the three
> dash lines).

Cleaned it up, along with the other commit message you pointed out;
I'll resubmit shortly.

> I am not sure if we want all codepaths to do 64-bit math for
> progress meter, but let's see what others would think.

If others don't want to do 64-bit math for the progress meter, what
would they like to see done instead?  I can see a few options:
  1) Have two separate progress codepaths, one for 32-bith math and
one for 64-bit math.
  2) Instead of counting pairs of source/dest files compared, just
count number of dest paths completed.  (Thus, we wouldn't need a value
big enough to hold rename_dst_nr * rename_src_nr, just big enough to
hold rename_dst_nr).
  3) just let the progress meter overflow and show nonsensical values
  4) don't show the progress meter if overflow would happen
  5) something else I'm not thinking of.

>> -                             fprintf(stderr, "%s: %3u%% (%u/%u)%s%s",
>> +                             fprintf(stderr, "%s: %3u%% (%lu/%lu)%s%s",
>
> Are these (and there are probably other instances in this patch) %lu
> correct?

Oops, no.  I think %llu is right, though looking around the code it
appears folks use PRIuMAX and avoid %llu due to possible issues with
old windows compilers.  Not sure if that's still relevant, but I'll
try to remain consistent with what I see elsewhere and include that
fix in my re-roll.
