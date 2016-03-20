From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Sun, 20 Mar 2016 14:37:01 +0530
Message-ID: <CAFZEwPM2XZzGuVBRoQt1e8uVvfd3_b9h2-j+vCe3XymW6kjRsg@mail.gmail.com>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
	<20160317015044.GB12830@sigill.intra.peff.net>
	<CAFZEwPOib-3JJQ+ufAbmNf1HYb5003LJw_paF2s9L8OK59N0PQ@mail.gmail.com>
	<20160320041009.GA18312@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:07:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahZKN-0003HN-Un
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 10:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbcCTJHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 05:07:05 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35355 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbcCTJHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 05:07:02 -0400
Received: by mail-yw0-f179.google.com with SMTP id g127so185708703ywf.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FZpGYJLXMrRolOjaF27UF+WG2NwWsoeexSRhWQJFQ/I=;
        b=bEnAlqNDQbfH4bReRZWuSTKFaqu1awRcNONdZGGGmAm+M3eyj2q3uGkcsLBWPZDykT
         SBJ8bjPhHwB7Qk37+mqWZpZZ4NWxZXMk+3ZBnQGp1HsXTyhllkUAv+baRzuCxZe3oxBr
         Bwd0bQEcUAaYrVVIq4GU+SHwy1+HY9nemgGdaFDQOQ8gSb98tjn8/zgp22CIGNfd/2RM
         5f6442ToEd4fjNNOuag5zMm8klNYjtF+SGXhvy9ZuzGPOV78tu6tXyfVSoZNGJYOdLBz
         t4Gp3+gEareGyfNPbwY2eSgrfzJn9pnC4BZ447rqiswYHHPH2jXzp6Nw1YEsxranJT4H
         yzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FZpGYJLXMrRolOjaF27UF+WG2NwWsoeexSRhWQJFQ/I=;
        b=YtCX+tkopwrslXKwaPokqN+N4H81bxCQwKSzrVaycvIy3yky+LOYkbRiK9uQJMAK60
         QU5QO+g8sq4SRe3tLDwC4ayfdq5o7/XXcOuGf782PjPP/qjudm1PZo+NHsb/Zz7Hj03v
         3Bh3gyyS1WiSQHaUkBCxrknsqxyZKx1LEpODi+6+VXasMn4S9nknCh+8HLVE0lH4n2H4
         YaHQP/OdaSLgwcQgXk3QvnJZLaDiSWuAKhLKUxV5reW75KDwcX5bUSRUBJVOQ6tMfuJe
         mPim/LFBhctIXGamsTuvCP3P3e7D3W9ZkWJ2TnT0iUWao/j9P63QECbc8dWmB+gJp9VF
         O7SQ==
X-Gm-Message-State: AD7BkJKThNOAiON+Yx2JVNICTkFRqDe9g0Bww9z80S/UH9kYvpIstNem6yxpENrzGQTpOYFCGZT4uxqbiTPJpA==
X-Received: by 10.129.94.7 with SMTP id s7mr11911593ywb.93.1458464821246; Sun,
 20 Mar 2016 02:07:01 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 02:07:01 -0700 (PDT)
In-Reply-To: <20160320041009.GA18312@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289343>

On Sun, Mar 20, 2016 at 9:40 AM, Jeff King <peff@peff.net> wrote:
>> > We are also changing semantics without changing the interface, which
>> > means any topics in flight (that you _cannot_ review, because you have
>> > not seen them yet) may be subtly broken. To me that is not an absolute
>> > deal-breaker, but something to weigh against the utility of the change.
>>
>> As I am new here, I don't really know how to go about with this. Could
>> you describe in a little detail so that I can work on it?
>
> A more canonical example is changing a function return value. Imagine I
> have a function which returns "1" for success and "0" for error, and I
> want to change it to return "0" for success and "-1" for error. If I do
> so and update each caller, then merging with a branch that has a new
> caller will not result in any conflicts (there is no textual link
> between the callers and the function), but the result will be subtly
> broken (the new caller will get the error-check wrong).
>
> So we generally try to find some way that the compiler will notice the
> breakage. E.g., if the function changes name when the return value
> semantics change, or if it gains a new argument at the same time, then
> the compiler will notice and complain. We still have to fix it up during
> the merge, of course, but it's easy to spot.
>
> Likewise here. If you change the semantics of OPT_COUNTUP(), then any
> branch which introduces a new use of "int foo = -1" and expects the old
> semantics will be subtly broken.
>
> The obvious fix would be to switch the name (to OPT_COUNTUP_DEFAULT() or
> something). But that's a bit painful, as almost nobody uses COUNTUP
> directly, so we'd need OPT__VERBOSE_DEFAULT().

This is quite new to me. It took me some time to digest it.

> Which in the end is the same as ignoring the problem in the first place,
> but there is a big difference between not thinking about the problem,
> and thinking about it and deciding it's not a problem. :)
True That! ;)

Regards,
Pranit Bauva
