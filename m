Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D28C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbiA0So0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:44:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64243 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiA0SoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:44:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91C75174B3B;
        Thu, 27 Jan 2022 13:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L2KDQ1beiiPh2ogQUfVrqwJ6OdWSF6PExnQjY0
        orzas=; b=li9+CXek+94gtYSFlOBkn48sUqr+uRI4TQtdppH5B+rJ06hLKyiaCT
        D4LKKelMeX0W7QRjseFSsBv3f2w00ZXED6SaIC8KHUlNZqpLe2X3Dq1V9Larq945
        p9g8bkpRvAC4XzZrw+ozaLAc89JDYmXb6Y1CZa0Y8fZKnudeUM148=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81F82174B3A;
        Thu, 27 Jan 2022 13:44:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A79A5174B39;
        Thu, 27 Jan 2022 13:44:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: WARNING: terminal is not fully functional
References: <CAH8yC8kYP2Sth+vUZMzHujKQZC6r1kFf+Lz=6_WRs4GFR65B9g@mail.gmail.com>
        <xmqqr18t4sc0.fsf@gitster.g>
        <CAH8yC8k53a4xcDh34XqoA0VCcxG+Y+mE-rb1MKMd_Z+r-t=_Bw@mail.gmail.com>
Date:   Thu, 27 Jan 2022 10:44:18 -0800
In-Reply-To: <CAH8yC8k53a4xcDh34XqoA0VCcxG+Y+mE-rb1MKMd_Z+r-t=_Bw@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 27 Jan 2022 02:05:18 -0500")
Message-ID: <xmqqczkd2f3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23199BB4-7FA1-11EC-9549-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> On Thu, Jan 27, 2022 at 1:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jeffrey Walton <noloader@gmail.com> writes:
>>
>> > I needed to install Git on Ubuntu 8. Git seems to work Ok for most
>> > task, but this is unusual:
>> >
>> >     $ git diff
>> >     WARNING: terminal is not fully functional
>> >     -  (press RETURN)
>> >
>> > Here's the terminal:
>> >
>> >     $ echo $TERM
>> >     xterm-256color
>> ...
>> Something to try quickly would be:
>>
>> $ export TERM=vt100; less README.md
>>
>> As the termcap/terminfo entry for vt100 is usually more widely
>> available, this may unblock you.
>> 
>> > It seems like loss of colors on an old platform is not that important.
>> > However, the message being printed creates an actionable item that
>> > needs attention. I think no message would be a better option.
>>
>> You would want to redirect it to folks who work on "less" ;-)
>
> Oh, sorry about that.

No need to be sorry for that.

I seem to have these terminfo database entries for terminals whose
name begin with 'x':

    $ /bin/ls /lib/terminfo/x
    xterm
    xterm-256color
    xterm-color
    xterm-debian
    xterm-mono
    xterm-r5
    xterm-r6
    xterm-vt220
    xterm-xfree86

my suspicion is that you are lacking xterm-256color for some reason.
These usually come from ncurses-base package if I am not mistaken.

