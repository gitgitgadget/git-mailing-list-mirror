From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/3] builtin/apply: make gitdiff_verify_name() return void
Date: Tue, 22 Mar 2016 23:10:45 +0100
Message-ID: <CAP8UFD13ueLG1xdV7QYpiZLx9DZHgdrPcpi9zLc7NAh2BLd08w@mail.gmail.com>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
	<1458680322-17681-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq37rigq7o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:10:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUVn-00043Z-8z
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbcCVWKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:10:48 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37445 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcCVWKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:10:47 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so586951wmp.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=vgWoO7v8R8ddJ/o6pEJtpiadUIydPO7/tSmuvcyDGps=;
        b=LZz3+/86UyrP+DazEX1NaGcvseNF4oReJCq/WoewB4pA9miWOYx9MasozKLHAKH/nK
         s+om03w2QGnfKPP6oYC/Z4qQMbZw7ooRyGuF0VaMia22GIrjeh5G0J3bKs3+3En/yDnC
         9dyGwP1h3C419Q325pgZYCk3jXc8VJpQvwvWhnBFvmVsrfLCEtKOYWZMsEVRu3xJraQR
         OuNLQlYx4kFbpqE0zwGYYHdXZEiLaHYlcsR7eWRET7evXOY1qQawwPcfRjKJgj3e8qQp
         Fy3J+vKv7O7ytYxnAUBXfr6PmRvc9d5JcZQZq8U7mCTFY1XJFobaUj28KfQQZGpPLAoP
         KTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=vgWoO7v8R8ddJ/o6pEJtpiadUIydPO7/tSmuvcyDGps=;
        b=j7Q8pEL1bRI0yh4kQaCNep/QLtXkLfhE5hh9GitSsIp9RgCEGnp3qP+xyJG5PMCvba
         j7I2MzagwW4rhLKS3CCvKvy9xuoVtsu2pc3/g/5oLlGLzJ2Mqswx9KBErX/ylgCLlSZp
         KlqvXSbUR5TQc/sUUa5owOQmYw6TOHKKrEgD58MNN9yRf/iRljGt65zDfVL+CGCElEcc
         sGo/EH7yPARoYyqvZ7vYI2Ff6ayLN3r5hwppEUXtTQwwsy9JhOL1O+nPIwXlq03xoZQV
         6XTHUN/thiEuIBMLhXN0qRMA6X8WhIc/d8faL4DB93Uc2d6dckRCsAisDz7Y9RWNQ7Je
         AtZw==
X-Gm-Message-State: AD7BkJKkfZRtemFR7C4eMiO3KRVUEZ4zwWNoCqi3DaEQKTUPyvHqMtYQ/SW5+533fYf8EJXUpsa4fLUEvAmPMA==
X-Received: by 10.28.180.9 with SMTP id d9mr68059wmf.62.1458684645794; Tue, 22
 Mar 2016 15:10:45 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Tue, 22 Mar 2016 15:10:45 -0700 (PDT)
In-Reply-To: <xmqq37rigq7o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289576>

On Tue, Mar 22, 2016 at 10:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> As the value returned by gitdiff_verify_name() is put into the
>> same variable that is passed as a parameter to this function,
>> it is simpler to pass the address of the variable and have
>> gitdiff_verify_name() change the variable itself.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
>
> This change makes the function less useful by restricting the
> callers--only the ones that wants in-place update can call it after
> this change, while the old function signature allowed a caller to
> pass one variable as orig, receive the result in another variable
> (and probably compare them).
>
> It does not matter very much for this file scope static helper
> either way, and I would probably say the same thing if the patch
> were in reverse (i.e. if the patch were loosening the restriction),
> but I cannot offhand see why this is an improvement.  Puzzled...

In my opinion it is an improvement because:

- the feature of allowing a caller to pass one variable as orig and
receive the result in another is useless here and just makes it more
difficult to understand what the code is doing because you first have
to realize that in both calls the argument that is passed is also
assigned to, and

- using up the return value to return a result prevents from using it
to signal an error instead of die()ing, so it makes libifying the
function more difficult.

But if you prefer I can just resend a series with only patchs 1/3 and
3/3. And we can discuss later in the context of libifying "git apply"
if this patch makes sense.
