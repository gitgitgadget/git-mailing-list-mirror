From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv12 0/7] Expose submodule parallelism to the user
Date: Thu, 18 Feb 2016 15:27:13 -0800
Message-ID: <CAGZ79kY7aYmDcz+JYwpzizfzRV3bUeN8TU-4jRjKqToJJTBHoA@mail.gmail.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
	<xmqqr3g9eii9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZZRENjVhfrhSfPmSNNQ_qrwpzWk=pocQ4GY6kBos1r6Q@mail.gmail.com>
	<CAGZ79kZwgBJQ2bkvKSuT+ULiSPL9x5WTcwVJG0FATNv-D_-AhQ@mail.gmail.com>
	<xmqqio1lehbp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:27:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXyj-000729-LM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992470AbcBRX1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:27:15 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33943 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946330AbcBRX1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:27:13 -0500
Received: by mail-ig0-f177.google.com with SMTP id g6so26207991igt.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oFpzm1tr5J+6uS5aOSWYoCxQDDVo22FEUYlGRQZ6o88=;
        b=QYqDeY+5YeDCSDN3acCR2zUWODQYftiekDcTe8xxUFqab32qN84Q/jbBGMx7gPmcLV
         L1SFzf4UdPhZUbTw5xm7yFw5LOs7lJSyDRQbmE/LuQITSTFaEXNClAN++goqKZj00AhV
         x18VaLY8iExa1eZsqUOrjuNvTpQp05jYdhGQjPMF8py83AmipuvjYH/kJaOzrApe0yhH
         aHF+I8zsQbPkUD5JGBo7BqNZfwvEEbdEoIBoGWKM5M2fpJYTRXwz/nq9NsbY/w8bMMG2
         d8CM/BFOsdFLu99tFZhDFg/6nBGehxU0J6i53UU51C3JGUT3GxZoOluOgLtrTksiHasB
         7/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oFpzm1tr5J+6uS5aOSWYoCxQDDVo22FEUYlGRQZ6o88=;
        b=U0bM5LNI02kssifipuskuLcRMxpRYBby1iPaSkCvNHxVBaRx215ksCbsOIHy5T/Tmw
         amriYIJbSmH7tpwZSqUkshclVYIdjre4L4+smpUMiWtWmHu7YeSfUuRqZ+ENuwfU1m6e
         3T1PakwtuteM3JrONoR3Kex8h7EwBqQmvrvti468IjKp3e0LDpXhc+nfym0HrJgh9m9C
         z2eRnF4PzExDVrq6+mhurXtTls5OgO4Hhk52uCs8I8TqIlWxqyy40EJQDLw2QgPrOi0L
         DgTJik5/HR35hG6ej9OqkO4lZrkuP4ZxTzOy0x99F2iB+YTPsb4IiuPqE2Hqt+CDYO5P
         oe4A==
X-Gm-Message-State: AG10YORuUXOvXLIZLYBJcGuxAV5mC373AsApLJAqFRkPJ1r0T5+TNS8SykwMmC0m4frQ39hjvt8bnZiX1Iaikc+c
X-Received: by 10.50.138.76 with SMTP id qo12mr6123158igb.85.1455838033155;
 Thu, 18 Feb 2016 15:27:13 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Thu, 18 Feb 2016 15:27:13 -0800 (PST)
In-Reply-To: <xmqqio1lehbp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286642>

On Thu, Feb 18, 2016 at 3:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Feb 18, 2016 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> Unless you count "I want to write differently from what was
>>>> suggested" is a desirable thing to do, I do not see a point in
>>>> favouring the above that uses an extra variable and skip_prefix()
>>>> over what I gave you as "how about" patch.  But whatever.
>>>
>>> The skip_prefix was there before, so it stuck there.
>
> Sorry, but I thought this "parsing update strategy" was all new
> code.

I meant previous patches or in my mind. That's why I was hesitant to
throw out the skip_prefix.

>
>>> Also it seems a bit more high level to me hence easier to read,
>>> (though I am biased). I'll use your suggestion.
>>
>> and it doesn't crash when passing in value == NULL.
>> (We don't do that currently, just a side observation)
>
> Hmph.  If you pass str==NULL with prefix="!" to what we have below,
> I would think the first iteration would try to read from *str and do
> a bizarre thing.
>
> static inline int skip_prefix(const char *str, const char *prefix,
>                               const char **out)
> {
>         do {
>                 if (!*prefix) {
>                         *out = str;
>                         return 1;
>                 }
>         } while (*str++ == *prefix++);
>         return 0;
> }
>
> Puzzled.

And there I was asserting properties about methods
without looking them up.

ok.
