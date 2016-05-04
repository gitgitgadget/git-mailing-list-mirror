From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] bisect: rewrite `check_term_format` shell function in C
Date: Wed, 4 May 2016 13:49:39 -0400
Message-ID: <CAPig+cTXj2=iV0RnZU2Lpr3aqoqWOhPKNdpmOjdh+GocNHiP6g@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-3-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cRL7QkQHpSmeKEYECd9JQO8B29OOJoGx2AQORPfmW7QQQ@mail.gmail.com>
	<CAFZEwPNKug1pvGC1fTvZzVPBGKy71fw6S3qcx_fx98nYZasR3w@mail.gmail.com>
	<CAPig+cQn4iRCqquUE-g4879mTS7UJkHr7ANvH9HB2+087qCV7A@mail.gmail.com>
	<CAFZEwPNdmJdt=4Hg7KpfGS51sDeKyAPWgApESf564kt_eaP3Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 19:49:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay0vi-0004Ew-4x
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 19:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbcEDRtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 13:49:41 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34534 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbcEDRtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 13:49:40 -0400
Received: by mail-ig0-f194.google.com with SMTP id kj7so6099678igb.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 10:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=NS5ZU/CpTrQ1RKGUsOamovntuKIgzMnt1X2CVC396Ik=;
        b=ujn3wgna5SFIjku7WOKUAssl4FagktfLYE/k6HQ5cwR8z+Q+iJ5fphYOAx8OdV+O+w
         jnXOSQ9XRbrE3/Li/NZBoibCGqrU1X5TM+3BF8dXuh/EfqUPy3Q5RG4SWD32v2VBxK/N
         C/C3CCfoWdDL77Wl9SC+CgO4QKzXXN4RL7n6+sEM7i88JRjldhduPdh2gOUPct0qGVlP
         xc9FCkQhOUS3cqbpQbOA6Hz72NOUZl/IkzX02ZPo5iYEW8HDvrwEYiE6enanCjubvxYo
         6IMaSQLla44cDNI97U+kGdydMRQHWg34y+DSPw2Eqq5f5xEFL90cEheVQh2dKgqCprSr
         QMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NS5ZU/CpTrQ1RKGUsOamovntuKIgzMnt1X2CVC396Ik=;
        b=bdom1T1qFAHnJUr0aMJwYzZU67QurtwXr8UJjtQr+lyZV7EM4tqqD1ngLRtBos701q
         /onmDFk6bosde6WQbsRcv6c2aDSV8lCt/KQSwYuwPULJf28Tfi/1yctI1OdDTk+QxkQN
         eu/W4KtOV175llIt76jbDDZ633JxSLRKApjRdKu25Tp8rZatOyOZqZ2pm2PDqXfwsQ5U
         cDTzxMVB5iriLLb3JXNb0hozYWk357D5M9gz/01FraCylFfSaQRcTjZSzDgPx/CTn9ht
         KOLf/HlM1J86KGguSooOc6F9zQKa5bT8N6PRn7nsKMl0lJfZ7x/wYv1Af9BKHTWkz6m5
         BgKQ==
X-Gm-Message-State: AOPr4FXVb1attkyQ1XEYlspa1x8EDC8R+ASHK/5SnewAqOzgAqSJjo0mgyCADiXkGF2cWK0tZgioAHRLXkhT2A==
X-Received: by 10.50.205.42 with SMTP id ld10mr35999572igc.17.1462384179135;
 Wed, 04 May 2016 10:49:39 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Wed, 4 May 2016 10:49:39 -0700 (PDT)
In-Reply-To: <CAFZEwPNdmJdt=4Hg7KpfGS51sDeKyAPWgApESf564kt_eaP3Rg@mail.gmail.com>
X-Google-Sender-Auth: SEDe2OZEN73htwXmPayHV1LKGg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293556>

On Wed, May 4, 2016 at 7:58 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Wed, May 4, 2016 at 1:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, May 4, 2016 at 3:36 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> On Wed, May 4, 2016 at 12:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>> +       if (check_refname_format(new_term.buf, flag))
>>>>> +               die(_("'%s' is not a valid term\n"), term);
>>>>
>>>> Why does this die() while the other "invalid" cases merely return
>>>> error()? What makes this special?
>>>
>>> This is because I felt that if check_refname_format() fails then its a
>>> fatal error while in other cases, it is not as fatal.
>>
>> The name of the command is "check-term-format" and that is precisely
>> its purpose so, from the perspective of the caller, *all* problems
>> with the term are fatal. It's black-and-white, there is no grey:
>> either a term is acceptable, or it isn't; that's all the caller wants
>> to know. Consequently, all problems detected by this function should
>> be reported the same way (preferably via 'return error()').
>
> Sure. I will use 'return error()'. Any particular reason why this
> instead of die() ?

This function's specific purpose is *check* some input for validity
and let the caller know the result of that check. The most natural way
to do so is by returning a success/failure value to the caller.

die() is for signalling an exceptional condition which should abort
the program. There is nothing exceptional about a "false" result from
check-term-format, thus die() not an appropriate way to pass the
result to the caller.
