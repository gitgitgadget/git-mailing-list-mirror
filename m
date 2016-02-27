From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 02/16] bisect: add test for the bisect algorithm
Date: Sat, 27 Feb 2016 12:40:50 +0100
Message-ID: <CAP8UFD27f3zmrLrvyCuMfs6ijt7MtLB8rX0Ykvfar3kidpm6LQ@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-3-git-send-email-s-beyer@gmx.net>
	<CAP8UFD2szf46skWmgZi3kSkh3D0aeMPw4TagUQa7KZ-z6pHdAA@mail.gmail.com>
	<56D0C5E0.2020703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 12:40:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZdF3-0003Ir-FP
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 12:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbcB0Lkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 06:40:53 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35864 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178AbcB0Lkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 06:40:52 -0500
Received: by mail-lb0-f177.google.com with SMTP id x1so58834995lbj.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 03:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=CtKXcf9LOVgAhStuxlqFN519/5eNNBLRd83M+GBs2ok=;
        b=g/HyGWzM+mlDfTm0orOzUF3/lGJCbji+5korfFSuTiXV2WxDi3AzyQX6sxILXmZKNK
         f7vwSo3/vKzFtd5967xQ/cAjex1rEKR265Jl4TU9miQgAfwtmgEb9OOCYcCD+qwLfUtt
         NSWwRnKi03CnDCDg+Jx7zPCjyLmISBIVateZrOUaua0qXKdJuETG//G1Lwh3tCq3M15V
         iMrmQ7bndr+n1ivGujMFtv60eiMYr/pKcXag04A4RVf4sLKLDYELkWyH4BUgj3trRTDe
         wCx7PWz4yEi14btWBYpfA0PS1irXXfgaL5ijrdKdcAzilbVrAdfcYPDjDfAvaSKJM/Tm
         oNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CtKXcf9LOVgAhStuxlqFN519/5eNNBLRd83M+GBs2ok=;
        b=TdWmLbkTrbqFoYixcz30Yf09NQp0fc9mMOP4ulHDR4ZFfkSmR+4U30w2LTl7pl7Y+L
         WYwSNYuS0jEbfHxivEbB7aYkLf04xQa7iKTa9rABImUygiYlL9Y7OEgMmXLi3hWpl0IA
         eTQzroEvzeUgU9Oe/EIwTNZK3t/UFt3Dzb1BKeE5s/TZ2aLTLRk8D2e1XETWnE92QlaS
         v39ArVbOFkBn95HilURzZZaV4wTBWBZYaWSIZC65GPgY9LFRkYGYAgVhZAIiwVF/ChcT
         dHVgTHJAY8Jho3DTB7Vi7ox4zaaBBkPbcgS9lqefbvyuAgobYyz2UJYBH7uLj34e1hzS
         ZR4A==
X-Gm-Message-State: AD7BkJLH1JwaiU5zjJ88nvi4Qced7uE0zEs0boObkQ1S5bzUNbQxvNUKTwfFOF1GN0+jisAD0OK+WVVlyW1FSw==
X-Received: by 10.112.64.5 with SMTP id k5mr2231241lbs.133.1456573250966; Sat,
 27 Feb 2016 03:40:50 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Sat, 27 Feb 2016 03:40:50 -0800 (PST)
In-Reply-To: <56D0C5E0.2020703@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287693>

Hi Stephan,

On Fri, Feb 26, 2016 at 10:38 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Christian,
>
> On 02/26/2016 07:53 AM, Christian Couder wrote:
>>> +test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
>>> +       git bisect start A7 &&
>>> +       git bisect next &&
>>> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
>>> +         -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
>>
>> I thought that we should not use "-o" and "-a" but instead "|| test"
>> and "&& test".
>
> Why is this?

I think it is because it might not be very portable, but I am not sure
I remember well the previous discussions about this.

> I understand the && instead of -a thing (test atomicity),
> however, for || this results in an ugly
>
> +       git bisect next &&
> +       ( test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" ||
> +         test "$(git rev-parse HEAD)" = "$(git rev-parse A4)" )
>
> Right? (Otherwise a failure of e.g. "git bisect start A7" would run
> the command after || (which may still be fine in some cases but is wrong
> in most of the other cases).

Yeah.

By the way maybe t6030-bisect-porcelain.sh is paranoid, but it does
some of those checks like:

    HASH4=$(git rev-parse --verify HEAD)

and later:

    rev_hash4=$(git rev-parse --verify HEAD) &&
    test "$rev_hash4" = "$HASH4" &&

So it uses "--verify" and also often puts the "git rev-parse" on a
separate line...

> However, what do you think about this?
>
> diff --git a/t/t8010-bisect-algorithm.sh b/t/t8010-bisect-algorithm.sh
> index bda59da..ae50e7c 100755
> --- a/t/t8010-bisect-algorithm.sh
> +++ b/t/t8010-bisect-algorithm.sh
> @@ -8,6 +8,16 @@ exec </dev/null
>
>  . ./test-lib.sh
>
> +test_compare_rev () {
> +       arg="$(git rev-parse "$1")"

...hence I would suggest:

    arg="$(git rev-parse --verify "$1")" || return

> +       shift
> +       for rev
> +       do
> +               test "$arg" = "$(git rev-parse "$rev")" && return 0

...and:

        hash="$(git rev-parse --verify "$rev")" || return
        test "$arg" = "$hash" && return 0

> +       done
> +       return 1
> +}

Otherwise I like test_compare_rev().

Thanks,
Christian.
