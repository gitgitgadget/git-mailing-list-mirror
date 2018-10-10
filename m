Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B2F1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeJKHRm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 03:17:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33912 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 03:17:42 -0400
Received: by mail-yw1-f66.google.com with SMTP id m129-v6so2904286ywc.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14aZqGqQWUmmpeW625MkgH/bjw2toK1gNtWjUPEvvG4=;
        b=BqKh4q4zh6bcKrghq3ikPlXQK3OhHfzvxJaR2UIQieOd2bUMPM1MCbB8RxJ52ZUDbC
         3fbN8OYYPvvTXkJs8YAY7pCwO1TpB0M5k62gM0ln6f83hDekejDr1PxD9WgKni8qb2t7
         DzFFiGD1+VXn+IZlPpBRWqrp+yXAa1ywI37BvbJbM2qcvnkUJU3vJcZv3liffsgylmeT
         9PjtRAuLCJFKs015N3IBW+orTXmnCeAzQRZOJi8zbqiR1fbDGR/J/kR6aBP8eNgRWcd6
         EOcHNunEQqjImUaYG/tTAJ2ugJH0mIRE++ThK5CVZHT6trkjBgKvbya5cmf/a42939Hh
         L6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14aZqGqQWUmmpeW625MkgH/bjw2toK1gNtWjUPEvvG4=;
        b=LUR2Nmw5NC0ShdzSR7bbLlYzTw7enrMSrpidqNmPZ+dSL8O95I0S6BFcSoy/kDRnMq
         r6YXK1Fb4eNlEnKLCiJ4LeIf02yXdObJgTJOCOBjGugtdCotUq8nYTcHBdY26qxvU5gs
         ZKRlaofLkHcD9Xg4alcApFP9TUNtrY6tM7c79sPkZK4sFZ12KcvzZB5FCkr6G2Gt7GQh
         SR6LbzKic7iLvzXi2xqmSfzYkmHVN38Zo6SXWy1hTIRpnmp5PbzuQG5AN9F/GS1FSCER
         sakhOseAbpAgr5bdjlNfPQDXufTSmJnMWLiC7KIYlFUdhiyP3gw1K/Rgx/SEe7+8SK7m
         molw==
X-Gm-Message-State: ABuFfogJSLTMSY18IH0i0CKypfU4W3AW/yOohV2uCvioOIVNTzZ/lLyy
        YpW+foaj8Cvcg23QlE5heP3ow3jEQ+coTyx0kN8=
X-Google-Smtp-Source: ACcGV602S/fPY+iuS2hKQSkfw2U3sma2uG572plXWlMMaXspIATZYYVIeZ7d0icE7hU8GsZhmbnyznFyeFNOLq4SM1U=
X-Received: by 2002:a0d:d4c9:: with SMTP id w192-v6mr19343864ywd.211.1539215592280;
 Wed, 10 Oct 2018 16:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181010193235.17359-1-avarab@gmail.com> <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com>
 <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 10 Oct 2018 16:53:00 -0700
Message-ID: <CA+sFfMcrCZCJwzVDdyDFg8tb1g1N+2p8i556C-AhGSuHMJqLmw@mail.gmail.com>
Subject: Re: [PATCH] gc: remove redundant check for gc_auto_threshold
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 4:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Brandon Casey <drafnel@gmail.com> writes:
>
> > ...  Again, I don't feel strongly about it, but I'm not
> > sure this change actually improves the code.
>
> Yeah, in the context of the current caller, this is a safe change
> that does not break anybody and reduces the number of instructions
> executed in this codepath.  A mistaken caller may be added in the
> future that fails to check auto-threashold beforehand, but that
> won't lead to anything bad like looping for a large number of times,
> so as long as the API contract into this helper function is clear
> that callers are responsible to check beforehand, it is still not
> too bad.
>
> So, I'd throw this into "Meh - I won't regret applying it, but it is
> not the end of the world if I forget to apply it, either" pile.
>
> I _think_ a change that actually improves the code would be to
> restructure so that there is a helper that is responsible for
> guestimating the number of loose objects, and another that uses the
> helper to see if there are too many loose objects.  The latter is
> the only one tha needs to know about auto-threashold.  But we are
> not in immdiate need for such a clean-up, I guess, unless somebody
> is actively looking into revamping how auto-gc works and doing a
> preparatory clean-up.

Agreed on all points, and as usual, said better than I could :-)

-Brandon
