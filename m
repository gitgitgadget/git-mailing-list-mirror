Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7AAA208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbdHOTGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:06:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34395 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdHOTGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:06:14 -0400
Received: by mail-pg0-f66.google.com with SMTP id y192so2749149pgd.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=revFXtdzAy/RIukkzPjLQahiU3txPf6E8WTvmEi4fdc=;
        b=AnBhYMviSvFWp3usLuPZc1bXe7Bxj7V87mQ2TF/NJAVdmBmpePpMFmBSem890uVTwU
         QC7Gqec/K2qTW5fpZKG3uC4JP7L/MfTzAgznC3oGkuuhH5eGTGD/mWFBtR9xXnTCK98z
         yzrCkfSCNxYclAB6gPlRCAvxHowKUoKjU4CZLCPkfGG+q6RA80gVaC6akpdq1dvQIU9n
         DQNjpwtP1GbwL4dyO8NCaa4IhIZxJFSZbkufq2l7356xb2IxwoqgjuSCn6dR5wWqQuDc
         VIzDWU7WGbiPGVRMvc+47paLn3wobr/i0Fk4F28upI09HtpPQr7xoBYpTJXCgDvQsa1M
         G36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=revFXtdzAy/RIukkzPjLQahiU3txPf6E8WTvmEi4fdc=;
        b=VBD9ezOJdVtgbkScfbwzn2CF1Qd/EW/zjFMClcdACvaye8fV7oeiBuHfwWOqJgMyQH
         S7UscZ82KUjgWUOzo1s3U+06BbKjTUszmJlQbM5CS0fd7cE1NEU0dcJZ+Xut5HJOb2jz
         j9dAtkCkMxFPehxIC7NwqgxrufYQic2YP4st0jEsS5aQxMGu2tY22e/wRbA76SeQxw0w
         VdoU4XIjs4AMqDXxfgjnbT4mvzmBaJz6Z3Uh8oSCwpBojf2BMcxdI5wfWGijc9EMJZRM
         P4scSMmOWdhwUc9Q00gV+rB1/b9mZz6xOleRwpjjOC+cWknZloQ9ak/cbY5chrWqdYNk
         eanA==
X-Gm-Message-State: AHYfb5iZtRh7foG1OHNoEZ2dLska7Wia0DMVpz+qAqbMlxt5jHVp55xk
        /mkLv0FwjNL2T4QDdxI2libdmB93Yw==
X-Received: by 10.99.112.16 with SMTP id l16mr28090801pgc.143.1502823973582;
 Tue, 15 Aug 2017 12:06:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 12:06:13 -0700 (PDT)
In-Reply-To: <xmqqk224r7rv.fsf@gitster.mtv.corp.google.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <931ffb00319f40e3c9e099f17eeae6a0c1de41ea.1502780344.git.martin.agren@gmail.com>
 <xmqqk224r7rv.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 21:06:13 +0200
Message-ID: <CAN0heSqwBNqrQPxOFZPCdFDA58P0JsKUqrw-KhVCcE1WKFTKbA@mail.gmail.com>
Subject: Re: [PATCH 4/5] strbuf_reset: don't write to slopbuf with ThreadSanitizer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 20:43, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> If two threads have one freshly initialized string buffer each and call
>> strbuf_reset on them at roughly the same time, both threads will be
>> writing a '\0' to strbuf_slopbuf. That is not a problem in practice
>> since it doesn't matter in which order the writes happen. But
>> ThreadSanitizer will consider this a race.
>>
>> When compiling with GIT_THREAD_SANITIZER, avoid writing to
>> strbuf_slopbuf. Let's instead assert on the first byte of strbuf_slopbuf
>> being '\0', since it ensures the promised invariant of "buf[len] =3D=3D
>> '\0'". (Writing to strbuf_slopbuf is normally bad, but could become even
>> more bad if we stop covering it up in strbuf_reset.)
>>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>>  strbuf.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/strbuf.h b/strbuf.h
>> index e705b94db..295654d39 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -153,7 +153,19 @@ static inline void strbuf_setlen(struct strbuf *sb,=
 size_t len)
>>  /**
>>   * Empty the buffer by setting the size of it to zero.
>>   */
>> +#ifdef GIT_THREAD_SANITIZER
>> +#define strbuf_reset(sb)                                             \
>> +     do {                                                            \
>> +             struct strbuf *_sb =3D sb;                                =
\
>> +             _sb->len =3D 0;                                           =
\
>> +             if (_sb->buf =3D=3D strbuf_slopbuf)                       =
  \
>> +                     assert(!strbuf_slopbuf[0]);                     \
>> +             else                                                    \
>> +                     _sb->buf[0] =3D '\0';                             =
\
>> +     } while (0)
>> +#else
>>  #define strbuf_reset(sb)  strbuf_setlen(sb, 0)
>> +#endif
>>
>>
>>  /**
>
> The strbuf_slopbuf[] is a shared resource that is expected by
> everybody to stay a holder of a NUL.  Even though it is defined as
> "char [1]", it in spirit ought to be considered const.  And from
> that point of view, your new definition that is conditionally used
> only when sanitizer is in use _is_ the more correct one than the
> current "we do not care if it is slopbuf, we are writing \0 so it
> will be no-op anyway" code.
>
> I wonder if we excessively call strbuf_reset() in the real code to
> make your version unacceptably expensive?  If not, I somehow feel
> that using this version unconditionally may be a better approach.
>
> What happens when a caller calls "strbuf_setlen(&sb, 0)" on a strbuf
> that happens to have nothing and whose buffer still points at the
> slopbuf (instead of calling _reset())?  Shouldn't your patch fix
> that function instead, i.e. something like the following without the
> above?  Is that make things noticeably and measurably too expensive?

Good thinking. There are about 300 users of strbuf_reset and 10 users of
strbuf_setlen(., 0) with a literal zero. Obviously, there might be more
users which end up setting the length to 0 for some reason or other. So
your idea seems the better one. I would assume that whoever resets a
buffer is about to add something to it, which should be more expensive,
but that's obviously just hand-waving. I'll see if I can find some
interesting caller and/or performance numbers.

>  strbuf.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/strbuf.h b/strbuf.h
> index 2075384e0b..1a77fe146a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -147,7 +147,10 @@ static inline void strbuf_setlen(struct strbuf *sb, =
size_t len)
>         if (len > (sb->alloc ? sb->alloc - 1 : 0))
>                 die("BUG: strbuf_setlen() beyond buffer");
>         sb->len =3D len;
> -       sb->buf[len] =3D '\0';
> +       if (sb->buf !=3D strbuf_slopbuf)
> +               sb->buf[len] =3D '\0';
> +       else
> +               assert(!strbuf_slopbuf[0]);
>  }
>
>  /**

When writing my patch, I used assert() and figured that with tsan, we're
in some sort of "debug"-mode anyway. If we decide to always do the
check, would it make sense to do "else if (strbuf_slopbuf[0]) BUG(..);"
instead of the assert? Or, if we do prefer the assert, would the
performance-worry be moot?

Thanks for the feedback.
