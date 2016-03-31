From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v11 2/4] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Fri, 1 Apr 2016 02:11:16 +0530
Message-ID: <CAFZEwPN_=mLXf+8JfMhwf_5fviG-rjHp07b+41HXs2NLO6BnxA@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153cd2341e2-2616ba0b-9271-4a97-87d1-b6dedbf31828-000000@eu-west-1.amazonses.com>
	<xmqq60w2o5g9.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPO4CJ-Q=52Es14CdD0mjG-qgy4=X2kU71npi=8x7FsSQw@mail.gmail.com>
	<xmqqegaqmmyr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 22:41:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aljPD-0005G3-Px
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 22:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbcCaUlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 16:41:22 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35081 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932877AbcCaUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 16:41:18 -0400
Received: by mail-yw0-f195.google.com with SMTP id u8so13499171ywa.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=fQZNb3B9goAs+nfftHgUF9LciZcVn6aPXEfsW9KglYg=;
        b=pwdNHN4QNHX8lKveW/RqE0fpOVdY74CY2aKDKo/JrNKTt+2Blz77q6wvIjGEGcD7ka
         Ju8Ecw7DI/MAzz3e1VmIVZCvshGS2dy89vgvbxBCbF3i2RdKsjKx6MbGpLbx2hRG6Qfy
         DEjaig1wKSpV22xSgQYvDDtZ2xuRfg2OWoq3PSHf65UgmyHwo9YLtcB+bmDqyt1zOIO+
         430dmI1WDyJdRLR1g+Bd+0Cbxn3z6q3siwAO0ZN3hAPpFYiRGisZN7yeytiJTTmBV1jj
         oLaoGPUgcbqJgGHcYQ6ACMgkEkpsejaJq4iBfkaKJhklKAad9kAQYyuEwJuVII5sTgKl
         X42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fQZNb3B9goAs+nfftHgUF9LciZcVn6aPXEfsW9KglYg=;
        b=fCT5HK2T6fgtGdVdJdOPFB4vEMUxmukMwwkD4PY4hDxahshqNCM2InAtIooHpKZE/6
         aTfFICPZh7z+V1q4BLx69SjVGsoN+82B0AtnsW/zcEaswpPfe4XEXVN2RxTzzCq2zOnZ
         Uri7Jdee8z5VvrRk95V8j43cVuuRQC1Ub6K6hyzJ8CkCGkacwp/mUIFuzFFg49deMEPM
         uFGRVuA8wkS5QsQ00pKWnbqPU8DxITWEP4eACyiJcleIki+lQntME2dlE0NbZ9dsgZH3
         QS+vlxlVJ7zv+W3++EsEMYLw/DP907lzrFcqPe/fQoWshUZ9czkX6AQcFWwb0Cs7zVaA
         g3FQ==
X-Gm-Message-State: AD7BkJLfZwLfvFmF4+FkCgyLJ4nmmV1ceX8DRbOuNQ7y4LtD8J0U40qzZ+9hH67mBFKggvVHf7Jjq4m1tgHRQg==
X-Received: by 10.13.252.67 with SMTP id m64mr9678180ywf.67.1459456876987;
 Thu, 31 Mar 2016 13:41:16 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 31 Mar 2016 13:41:16 -0700 (PDT)
In-Reply-To: <xmqqegaqmmyr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290464>

On Fri, Apr 1, 2016 at 1:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> On Fri, Apr 1, 2016 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>         case OPTION_COUNTUP:
>>> +               if (*(int *)opt->value < 0)
>>> +                       *(int *)opt->value = 0;
>>>                 *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>>>
>>> That is, upon hitting this case arm, we know that an explicit option
>>> was given from the command line, so the "unspecified" initial value,
>>> if it is still there, gets reset to 0, and after doing that, we just
>>> do the usual thing.
>>
>> This does look cleaner. Nice thinking that there is no need to
>> actually specify when it gets 0. It gets 0 no matter what as long as
>> OPTION_COUNTUP is speficied in any format (with or without --no) and
>> variable is "unspecified".
>
> I do not think there is any planned users of such an enhancement,
> but the above points us into a future possibility to be able to do
> this:
>
>         case OPTION_COUNTUP:
> +               if (*(int *)opt->value < 0)
> +                       *(int *)opt->value = -*(int *)opt->value - 1;
>                 *(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
>
> That is, by using "-2" as the "unspecified" value, you can start
> counting up from 2 (i.e. the presence of the option resets the
> variable to 1 and then the option being not "unset" increments it)
> if your application wants to.

I am not very familiar with Git community but I think including a new
feature to use our existing library (who's functionality isn't
required as for now) can trigger some creative thoughts in minds of
other developers which will make them think "How could this be used?".
This could lead to some exciting ideas on improving the UI of git.
Having something actually in hand gives you a confidence, rather than
knowing that you could grab it whenever it is needed.

Also, when such an idea for new feature comes up, it is better to
implement it because let's say some developer is stuck in future and
this new feature could help him but he doesn't have a clue that such a
discussion happened some time ago. Thus saving him time and further
effort.

Anyways, How is the convention in git for these type of futuristic ideas?
