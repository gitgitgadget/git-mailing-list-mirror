From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 48/49] builtin/apply: move 'lock_file' global into
 'struct apply_state'
Date: Fri, 3 Jun 2016 11:42:13 +0200
Message-ID: <CAP8UFD37RJ_O-5Ob7KhF_d288=Ab0o4hVJDrtBoNPJ1VPmLosg@mail.gmail.com>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
 <20160524081126.16973-49-chriscool@tuxfamily.org> <xmqq8tyozuul.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:42:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8lcS-0003Wk-87
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbcFCJmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:42:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36080 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcFCJmP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 05:42:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id n184so117301253wmn.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gm7Tul4Lkyl7iVJrGjXF2YvLBfYC30LT/Gp0bygdDzI=;
        b=SNfmd8hRcb/VT4JSfqLEQsESeTqsRE4gO3zALI44e7xYd/OZuBmomMIEhZz68ckdXU
         rTT6liqksaHzH3179LtOE4igcCRx9WfOqJPcwFaXR0FDKerlu9ImQFkCwHiMhRDuuyG8
         7YjrsgEZFQ6v8LrglNFYuO6dL1wZECsIRHlos8s1Rv0tfFbTdNi3ujipn2VBlYrLCepP
         ITalYK2c7JdBQVE818Zw7gwkHrt3TxMl5AcgZj0qIYHhKfPExaR8E8eZZ+FAlD3XroiQ
         VQ6MW24LGGugn3+9TVOAfWM1x22Apl1CL5sLv9sTlcA1nB+QkscWBwHPoXT+t644TO+5
         C0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gm7Tul4Lkyl7iVJrGjXF2YvLBfYC30LT/Gp0bygdDzI=;
        b=eezqVhg/P3gMEGfjDsUciqmdmt5tPPhaQYUIr9YtLtuP15/hZZXdMQFndRm7de/PIk
         CsNyATOBFeBNg5KaUqJzMa8INgZIqBPCPSMX7kONuCXDKP5JPc0l2pyr5JEbT1EZ7PnR
         E+4yGmBpl+GxwDE0rt2KZE2mNMKq3NbzAGbr6GWe7chFmYn2JNQBObpUji4mmLSP1EKT
         ctkTTowSNfS7mJja4JM3N0DZ4czPaLXQukw0qeufHRCrJ21FVGfG2jtp3cqrIB4BE/q6
         BghyZVXkexcjMdZPeMbIktVik95vXBzsG8bMBMrPesXD9Mr0MWhektDNCjt6ZpoC1svO
         Z4ZA==
X-Gm-Message-State: ALyK8tLdtuQ3VjRzC+p79bsXClFbf/Klz3YNdM1HI8qnFXmiZxLHbAC1LfmN5RVb9814/oYbVYNS5oIm8URhgg==
X-Received: by 10.28.98.215 with SMTP id w206mr29251689wmb.79.1464946933809;
 Fri, 03 Jun 2016 02:42:13 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Fri, 3 Jun 2016 02:42:13 -0700 (PDT)
In-Reply-To: <xmqq8tyozuul.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296294>

On Wed, Jun 1, 2016 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> We cannot have a 'struct lock_file' allocated on the stack, as lockfile.c
>> keeps a linked list of all created lock_file structures. So let's make the
>> 'lock_file' variable a pointer to a 'struct lock_file'
>
> Good.
>
>> As the same instance of this struct can be reused, let's add an argument
>> to init_apply_state(), so that the caller can supply the same instance to
>> different calls.
>
> Good.
>
>> And let's alloc an instance in init_apply_state(), if the
>> caller doesn't want to supply one.
>
> This is questionable.
>
>> -static struct lock_file lock_file;
>
> I'd rather leave this as-is, and pass the pointer to it to
> init_apply_state().  For the purpose of "cmd_apply()" which is the
> first user of the "(semi-)libified apply API", that reads a single
> patch and applies it before exiting, that is sufficient.

Ok, I will leave this as-is.

> As to the "if the caller does not want to supply one, we will
> allocate one that will definitely be leaked", I am mildly opposed.
>
> By making it the responsibility of the caller, whenever a new caller
> of the libified apply API is written, those who write it is _forced_
> to think about not leaking the lockfile structure, which is a good
> thing.

Ok, I will remove the allocation in case the caller pass NULL.

> Other than that, all 49 patches look sensible to me.

Ok, I think I will resend only this patch (48/49) with the changes you
suggest, and maybe the next one 49/49 to avoid spamming the list.

> Thanks for working on this.

Thanks,
Christian.
