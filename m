From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Mon, 16 May 2016 19:07:35 +0200
Message-ID: <CAP8UFD1BD9JtcW_BGZtrS0vdaC7YpvgohpJWC813RX03HfKNUA@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	<xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
	<CAFZEwPPZJqGHsHk0RLzo-pA8rUN0VP9-ricycNOnGbhO=2JZgg@mail.gmail.com>
	<CAPig+cRhfJbbP7FE-XkW4uaMu5Gy+UvBbh-rHOY5NK4_SrwjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:07:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Lza-0003Wv-CK
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbcEPRHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:07:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34092 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbcEPRHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:07:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so19478582wmn.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jkuWTuPrYWRASWPFpb7DPK/vc+s8oj/aDaYc736aKE4=;
        b=GxtT28giAUGYga71dx9u7EvRDFlD43gpHDN/vr1a1tjrkcHC8lrYmofqIGTjSNbeX9
         rz3hrgfMs+W7zxu2wNYBdrbeKqk7p9vqRDfgUk+yLNKCJ/zi6UCEXhwEdS9Xo6yF4raw
         C7QkRXnD8E4O+SubozFq+N1qOJ5zwiLa3+IGdquTUdPkQQ1fBJQPWCqrsf7SIoq/glui
         M8dTynjmKWuFYRS3VGNyDrIpE121ZhC42FsKAtL5vpu9FZtRLP61Lsam4oHAz/WxUSDd
         ZaFaZXNidTHCclSTiUwC2DHm3cJitPRSLhKKQjdJzHmaxsBVDLqTQNrxLRN6fPCiAZe4
         jAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jkuWTuPrYWRASWPFpb7DPK/vc+s8oj/aDaYc736aKE4=;
        b=RTMrYt+33Bh4UIzzFREoC2awTYv+j+I0oB84emrju9pqZA/KuwuDvxQ2TDtX6nVGxa
         My/GWMpsGd3Vc6/MhbkNnBSSQVi0P/zesIa3uaDjZBI66G+RSqmGro2N7r3giXoHQS0r
         /Fa+VGQNKlhJ0Off3rCAQkXccr5EZQK+IAZyZLt9w6CyYmf5Scu17im0n9dZ6zjXeMZi
         1L+b5gi0+w1OM19jdZp/aA5wzfJd4qfsgYYpv++oX2WqxjMZEn1g9Ja3yxnO0wB6uXsb
         l45qYtVdl0nAV76YkFETUbPsTi8+qaQuW5kw1x0Iv5XBtNaJ2reZz4nkSC9JzM7Gozc2
         3KHg==
X-Gm-Message-State: AOPr4FW8hOUGjFtxfbMKkUfI1xZAmpx/pOT8+faN5Vqjr2C8WrRYdvrg6MPOx6S4m4keLVj4EhgwMDeKWSwO4A==
X-Received: by 10.28.129.22 with SMTP id c22mr19802515wmd.89.1463418455513;
 Mon, 16 May 2016 10:07:35 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Mon, 16 May 2016 10:07:35 -0700 (PDT)
In-Reply-To: <CAPig+cRhfJbbP7FE-XkW4uaMu5Gy+UvBbh-rHOY5NK4_SrwjcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294755>

On Mon, May 16, 2016 at 2:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 8, 2016 at 9:34 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, May 8, 2016 at 11:53 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> On Sun, May 8, 2016 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>>> I completely missed your point and you want me to go the Eric Sunshine's way?
>>>>
>>>> I am neutral.
>>>>
>>>> When I read your response to Eric's "top down" suggestion, I didn't
>>>> quite get much more than "I started going this way, and I do not
>>>> want to change to the other direction.", which was what I had the
>>>> most trouble with.  If your justification for the approach to start
>>>> from building a tiny bottom layer that will need to be dismantled
>>>> soon and repeat that (which sounds somewhat wasteful) were more
>>>> convincing, I may have felt differently.
>>>
>>> Sorry if it seemed that "I have done quite some work and I don't want
>>> to scrape it off and redo everything". This isn't a case for me. I
>>> think of this as just a small part in the process of learning and my
>>> efforts would be completely wasted as I can still reuse the methods I
>>
>> efforts would **not** be completely wasted
>>
>>> wrote. This is still open for a "philosophical" discussion. I am
>>> assuming 1e1ea69fa4e is how Eric is suggesting.
>
> Speaking of 1e1ea69 (pull: implement skeletal builtin pull,
> 2015-06-14), one of the (numerous) things Paul Tan did which impressed
> me was to formally measure test suite coverage of the commands he was
> converting to C, and then improve coverage where it was lacking. That
> approach increases confidence in the conversion far more than fallible
> human reviews do.
>
> Setting aside the top-down vs. bottom-up discussion, as a reviewer
> (and user) I'd be far more interested in seeing you spend a good
> initial chunk of your project emulating Paul's approach to measuring
> and improving test coverage (though I don't know how your GSoC mentors
> feel about that).

If we could test each `git bisect-helper` subcommand that has been
converted to C separately, then I think it would be quite easy and a
good idea. And maybe Paul's approach is really great and easy to use,
but I haven't followed his GSoC, so I cannot tell.

As we take the approach of testing the whole thing, which is made of a
number of different source files (shell code in git-bisect.sh, C code
in `git bisect-helper` subcommands and in bisect.{c,h}), I am worried
that Pranit would spend too much time initially not only to measure
test coverage but especially to find ways to improve it.

The good thing with converting code incrementally to C is that one
does not need to understand everything first. While if one wants to
increase test coverage initially, it might be needed to understand
many things.

What I started asking though is to take advantage of bugs that are
found, and were not covered by the test suite, to improve test
coverage.

Also starting to convert functions right away can make the student
feel productive early and in turn make everyone else happy to see some
progress.
