From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v7 02/40] builtin/apply: make apply_patch() return -1
 instead of die()ing
Date: Tue, 14 Jun 2016 13:06:09 +0200
Message-ID: <CAP8UFD1zPUZQTY_rdMwK8vQBd7M5d8gPdTaEmfrg_Q74Y5B2Ew@mail.gmail.com>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
 <20160613160942.1806-3-chriscool@tuxfamily.org> <xmqq37ogbswg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmAi-00029T-9T
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbcFNLGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:06:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35878 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbcFNLGL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 07:06:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id m124so21454070wme.3
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BKgh+rXETRJJoSR1Bayb3wir/wR7OI7np0tJe/yoFWg=;
        b=G+amxFDVpfC1PORKWqLs/fKr2HFOHr1ZA1hTo8/CqL03R/DCrnzF8t1jojC2lAaYS2
         8ZNzXmuQ9y9TnqTt1fl7mnkYKgJAd0MOpM0KQAdXk3y3cldjrgh21rJ4VvqRkZn87kh6
         Fxrnc0zRCgVl7iWuj79mkBdLNs/NR79+195qh2F+x2mOYOjujrACccX/wnk2tqxp9e9a
         Encp2SAHscnyujk2BGoxe9jD3f0z/skZxqySaPC/AxDThzOd3gBZ0jXnOw989AdSY3w0
         SInCPBi1mllZifH+RgPI7YCTyci2unnek/8ZYmPJDUECEVEmsYmtM6J/Tt9Zg9LcrlK4
         MUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BKgh+rXETRJJoSR1Bayb3wir/wR7OI7np0tJe/yoFWg=;
        b=GPGmsGKyDgLC+Cu8SLRzDiNtkgv+WLtWgDHHHmBLL+EWICOmJ57JP7EB8KP7R+Cu1H
         FNxkk1Ksx2N4aFwWN8ICCd2kmhNLX6d9eMDhupfcb5ArAtPzHm07AoocZ4vt81BBjCZe
         xl9MnqP/XZIFcit76F2mjRYzKGiXM8hvCVpuBx8TBHGz+sA0xHlEXB8T7PAIpF4tAbJt
         OWxZxWielc4hYTdJWGVSDhdqGF9UTyuBjpu2ePgdy/g1srbp9jmIYCkwhpMAGn+I7BWW
         akiyjDBqNx2JV0d3T8vyDOt4o2KTigHdiOWKYdUMLvv2sErNa+1iJelqn8lDT0wEtYcS
         hwKg==
X-Gm-Message-State: ALyK8tKcec5/JBi2IicLgmNhAFFQ2wMAYUB2zTXv6CkprA2YmoUhr8p6XKto423ThmpnGzfLJAEBv3QqrTztwQ==
X-Received: by 10.194.239.163 with SMTP id vt3mr5554210wjc.78.1465902369939;
 Tue, 14 Jun 2016 04:06:09 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Tue, 14 Jun 2016 04:06:09 -0700 (PDT)
In-Reply-To: <xmqq37ogbswg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297284>

On Tue, Jun 14, 2016 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +/*
>> + * Try to apply a patch.
>> + *
>> + * Returns:
>> + *  -1 if an error happened
>> + *   0 if the patch applied
>> + *   1 if the patch did not apply
>> + */
>>  static int apply_patch(struct apply_state *state,
>>                      int fd,
>>                      const char *filename,
>> @@ -4413,6 +4421,7 @@ static int apply_patch(struct apply_state *state,
>>       struct strbuf buf = STRBUF_INIT; /* owns the patch text */
>>       struct patch *list = NULL, **listp = &list;
>>       int skipped_patch = 0;
>> +     int res = 0;
>>
>>       state->patch_input_file = filename;
>>       read_patch_file(&buf, fd);
>> @@ -4445,8 +4454,10 @@ static int apply_patch(struct apply_state *state,
>>               offset += nr;
>>       }
>>
>> -     if (!list && !skipped_patch)
>> -             die(_("unrecognized input"));
>> +     if (!list && !skipped_patch) {
>> +             res = error(_("unrecognized input"));
>> +             goto end;
>> +     }
>
> Before this patch, the program said "fatal: $message" and exited
> with status = 128.  All these changes in this step modifies the
> external behaviour and make it say "error: $message" and exit with
> status = 1 (at least the caller in apply_all_patches() does so).
>
> Will that be an issue for the calling scripts?

Hopefully the scripts don't check the specific error code and message.

I will add something about this in the commit message.

Do you think something else that should be done about this?
