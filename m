Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC161F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751096AbeC0Q0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:26:04 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42827 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC0Q0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:26:03 -0400
Received: by mail-oi0-f66.google.com with SMTP id l190-v6so11484529oig.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jeReKb8yGqygvkih8luha9G676mPKbhPRhqOctUEySc=;
        b=HWB/MdPD96Swttd1FiKm6tN80DQ7VU4PCxGoTwy03sgm7z0xIZNIUMzBlAU8SCfEVj
         nOujiePW5j5gzu9JWQw5167JKp8xKe0RVupYpGXMebbYisVZHLtCzVohWnhEXp/xncV+
         UFzwzsCEgh9f9ntG+Dlq+C+A2ilY4lZCK2iI/+xe0WKeoAHZvQJLGyU7JMOAYefik1ZJ
         QYzdqoQB1UthfhW5XvTpgPXa1peIz05GaQZ7xzTKAoX49ellQi6trtYejnqj5bPKk2Li
         mEAgpJmXAhlgHrr/txBRRd3gdCBT5Jux79uHgz6ugfLrW2am1sIc6NdTi20GeePkfwMe
         yCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jeReKb8yGqygvkih8luha9G676mPKbhPRhqOctUEySc=;
        b=i706CwcFIGV1MOSTib8Mn4oaVzlJ9wMYV9znQ3jl6VSLjDRGd1yHpaBkFzSVVERndR
         oLYbIY0PUkOFPRafaMwKs3ggXbHd95i37Gr3AJqk5pzBVdAguRALXofunW2QMbV4QkvP
         jSj3A0GIU9bb/z26HgpYSYncsbo4wKCLmlYZqwg3kZPT51cVgTJbIowA/XSVRj+oSrLp
         h6hWuUZz0imiAI9Kh3iJGkudYslkMwb5vHpd7UTJGHndz+IZ4IU+Gz8uxQHi9xXvpWB5
         qCDhDa09Vrj0W4zINsYgk85wD8xedR9YBiGNp8W/lYa3MpDliWy78Rx9jIfbkQL9nIL3
         o2Uw==
X-Gm-Message-State: ALQs6tALW2/7uAojGLqJpZslPo1bj6/GDVOeU1Y94U1YKUybOg0GkIf4
        AY788yByFC43leSBIbKnVPlkYPUuIqZxfhkPjPE=
X-Google-Smtp-Source: AIpwx4+EJZtQH6HP7mKj15ezaiSHr73zdNdMXbX9Ezz88zjcpE5T051wE2tnRgrXqbAfyLZ/ZX26i87pvCvZLgBujAg=
X-Received: by 10.202.81.200 with SMTP id f191mr31727oib.32.1522167963175;
 Tue, 27 Mar 2018 09:26:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Tue, 27 Mar 2018 09:25:32 -0700 (PDT)
In-Reply-To: <20180327161110.GA24747@sigill.intra.peff.net>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
 <20180315173142.176023-8-bmwill@google.com> <20180327152714.GA27050@duynguyen.home>
 <20180327161110.GA24747@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 27 Mar 2018 18:25:32 +0200
Message-ID: <CACsJy8B7Da7ubTti_NL46uejo_OMgx5pkFvk4My5g7RZDmAK7g@mail.gmail.com>
Subject: Re: [PATCH v6 07/35] connect: convert get_remote_heads to use struct packet_reader
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 6:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 27, 2018 at 05:27:14PM +0200, Duy Nguyen wrote:
>
>> On Thu, Mar 15, 2018 at 10:31:14AM -0700, Brandon Williams wrote:
>> > In order to allow for better control flow when protocol_v2 is introduced
>> > +static enum protocol_version discover_version(struct packet_reader *reader)
>> > +{
>> > +   enum protocol_version version = protocol_unknown_version;
>> > +
>> > +   /*
>> > +    * Peek the first line of the server's response to
>> > +    * determine the protocol version the server is speaking.
>> > +    */
>> > +   switch (packet_reader_peek(reader)) {
>> > +   case PACKET_READ_EOF:
>> > +           die_initial_contact(0);
>> > +   case PACKET_READ_FLUSH:
>>
>> gcc is dumb. When -Werror and -Wimplicit-fallthrough are enabled (on
>> at least gcc 7.x), it fails to realize that this die_initial_contact()
>> will not fall through (even though we do tell it about die() not
>> returning, but I guess that involves more flow analysis to realize
>> die_initial_contact is in the same boat).
>> [...]
>> @@ -124,6 +124,7 @@ enum protocol_version discover_version(struct packet_reader *reader)
>>       switch (packet_reader_peek(reader)) {
>>       case PACKET_READ_EOF:
>>               die_initial_contact(0);
>> +             break;
>
> Would it make sense just to annotate that function to help the flow
> analysis?

Yes that works wonderfully with my gcc-7.3.0

> Like:
>
> diff --git a/connect.c b/connect.c
> index c3a014c5ba..49eca46462 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -46,7 +46,7 @@ int check_ref_type(const struct ref *ref, int flags)
>         return check_ref(ref->name, flags);
>  }
>
> -static void die_initial_contact(int unexpected)
> +static NORETURN void die_initial_contact(int unexpected)
>  {
>         if (unexpected)
>                 die(_("The remote end hung up upon initial contact"));
>
> That should let the callers know what's going on, and inside the
> function itself, the compiler should confirm that all code paths hit
> another NORETURN function.
>
> -Peff



-- 
Duy
