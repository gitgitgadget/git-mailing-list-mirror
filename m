Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BC931F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 21:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbeGKVaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 17:30:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44018 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbeGKVaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 17:30:14 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so10920337ioa.10
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKwr2CawaMvZxmN5DlHSJ498LdBsVrfPzPd/qP4tfy0=;
        b=aUgkC3Dkf/jLTW34JINLFWhQb2/1fiFatENIg7V0CfYr/qwkjoagLv5X7BENpHh9t3
         JtyT3TrkwUfS7eVS+ecv418gflbw3WU4mp9biQU3YmOJlNC/0L4+WSrVn2CANWo2Eu/5
         lYZK3ewLrtZpFAIO9FfVVLyabffJoDNYUapS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKwr2CawaMvZxmN5DlHSJ498LdBsVrfPzPd/qP4tfy0=;
        b=fFcQFPtnFU48LD1YUxBtJYUAgLVgiWroZPiXNsDkXvYAWf7ysmaAhxb/ggq2lIJg+R
         SkMtu5KoBQgt1YWS+tNvIKuCfHw+vbea+rznmGtrSF7EJG9HJrXZ2oR75QnFoPl5xwxe
         r4QrbwcoE0UF6usqNgj0eM8Pn2UvBtZKZ83e0H0Kco5hKhFD5XWlVFh5EVpGelsFrO2r
         GhogVBF5suUPAwqyoWFOE0ElgOvLpF7ddP+zDYAaZgKiIH9c4f9pn/vkFNizsBVoWdo7
         03KB8V7nUH5V0cMqZmZRhfrtmbwwFulRpQRdcURnX6psyam3+ZFTgYD6bwljn29DyE4n
         IGrw==
X-Gm-Message-State: AOUpUlHVxgEVfPg0/p5ttXrCsPe0gaM56DARMYLQtVaXDCd356NmnVy8
        293iSPDe2sbSCRTbCXy94qVmTm2ubkMe39fmXDo=
X-Google-Smtp-Source: AAOMgpc2rOokESfq+CO/KlV+GShMqAXi1za31qQztuZVcoEOfNvtlpYRtt4ClVqi9mCMxX+Qh8ZflmNHr0cii/oZZZI=
X-Received: by 2002:a6b:19c7:: with SMTP id 190-v6mr646066ioz.670.1531344238827;
 Wed, 11 Jul 2018 14:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
 <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
 <CA+55aFym5aSudSHiVA=VmvoY=WFytUqficLQCE4Sd_urjwKqPw@mail.gmail.com>
In-Reply-To: <CA+55aFym5aSudSHiVA=VmvoY=WFytUqficLQCE4Sd_urjwKqPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jul 2018 14:23:47 -0700
Message-ID: <CA+55aFx8-hni4WoDpc6jkNo03GJr1jVbRr5-Pz35X=yaq+hEqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     rybak.a.v@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Trying to come up with crazy special cases ]

On Wed, Jul 11, 2018 at 1:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But it could be anything else invalid, of course. It could be MAX_INT
> or something like that.

That might be better. A timezone of -1 isn't actually a valid
timezone, but I guess you could create a commit by hand that had
"-0001" as the timezone.

You can't do that with something like MAX_INT, without fsck
complaining - since it has to be exactly four digits.

> The clearing of "human_tm" is done for a similar reason: the code does
>
>         hide.year = tm->tm_year == human_tm->tm_year;
>
> (and then later just checks "if (human_tm->tm_year)") knowing that a
> non-zero tm_year will only ever happen for human_tz (and that 1900 is
> not a valid git date, even though I guess in theory you could do it).

Actually, the 1900 should be safe, because 'timestamp_t' is unsigned.
So a valid timestamp really can't be before 1970.

Of course, you can probably try to mess with it by giving values that
don't actually fit, because sometimes we do convert mindlessly from
'timestamp_t' to 'time_t'. In particular, if you use the
"default-local" time, it will use that

  static struct tm *time_to_tm_local(timestamp_t time)
  {
        time_t t = time;
        return localtime(&t);
  }

and not check the range of the timestamp.

But other proper time stamp functions will actually do range checking
with "date_overflow()", so in general that whole assumption of "a real
git date cannot be in the year 1900" is valid.

              Linus
