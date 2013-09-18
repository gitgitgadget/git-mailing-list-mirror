From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Wed, 18 Sep 2013 08:19:08 -0400
Message-ID: <CA+55aFwJQ7yo3N3rdAz2=o9Zxxt4ascF5kzvB6-YHL+HXbz7ug@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
	<20130911214116.GA12235@sigill.intra.peff.net>
	<CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
	<20130912101419.GY2582@serenity.lan>
	<xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
	<20130912182057.GB32069@sigill.intra.peff.net>
	<CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
	<20130912202246.GF32069@sigill.intra.peff.net>
	<xmqqr4ctokat.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOQ-y1beD_X_jiH+FrhPvLOVJqT0J=Wk988Q4NeCs1-9Q@mail.gmail.com>
	<xmqqppsckcsd.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMNDJhAqNfgVRHRE-7R=UZbd+fMExYeKDWWCFjyQJYYTQ@mail.gmail.com>
	<xmqqppscij8a.fsf@gitster.dls.corp.google.com>
	<CAHGBnuM=QqLxPNNZmoL1jG+oAm2y6o=AuBtkH+FRwZ_8ahGC+w@mail.gmail.com>
	<xmqqli30idfx.fsf@gitster.dls.corp.google.com>
	<CAHGBnuOfYoosgWQdfF+L3=YCqO-MYEx-TpNzBAD-Zt0kqeR_Hw@mail.gmail.com>
	<xmqqhadj1kyo.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMgE1zO4=MnJJXcDLJSD2Vsjptk1x2Bc6CpF9GSxmFp8w@mail.gmail.com>
	<xmqqsix3w27t.fsf@gitster.dls.corp.google.com>
	<CAHGBnuMh9wqe6mhLyqbPAGJUEEH7cA2LZPuCQK8VD=NU2ix3Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 14:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMGiz-0003Tw-5t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 14:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab3IRMTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 08:19:12 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:44684 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3IRMTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 08:19:09 -0400
Received: by mail-vc0-f176.google.com with SMTP id lf11so5065883vcb.21
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=co/BhTTLvodpxEJNF+npOdh+ajt2+MnRZaDp6YcNgaU=;
        b=i5y7zt9z69C7MQD8gbV62pobxekcpoYI5hRZBawvZ6YHpTI4JA7YE4i1d86dOxYBRF
         zXGRszK+FQEipyUPzHiQr0T7dZtDfaJSLzT8mub/VOfYhzPPWTou0i00inh6gGl34PIm
         ynN7g2gevkhcL4OVrXTLPMPb0lZZV0rMgPTF5HX6h6XOC8+mRbvCrlkJZMvIKkRxito+
         1YzX+ZbR0locNcTZDRvWF9lvbGVhtNMJI9/jhQhwgKHYCCkUTr93W3GLYMGPTppP7Zm+
         Gi4Ru3jjKUXXiaP1TqPXRxNufP9SUvkX3wA2VTj1Y7AN69x/beKQGhOvqgpCt6LZE+ft
         /oaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=co/BhTTLvodpxEJNF+npOdh+ajt2+MnRZaDp6YcNgaU=;
        b=NMA/lWCYpGYjjPNPZNhIDbJbLZNxNgMn8TDIw02PA5cLbOh9bePHtSslkbC6gjxOkC
         V248e3mIcCljoQO15QAeTxF0XrhO87/SfIhRtgZqGjTDPHcGXjh0nKqA97/OKD9lhe7X
         TZanxiOBf5PolKu5R14v9LvC9D5A2aTAP0dkI=
X-Received: by 10.52.98.66 with SMTP id eg2mr12563964vdb.24.1379506748408;
 Wed, 18 Sep 2013 05:19:08 -0700 (PDT)
Received: by 10.220.3.137 with HTTP; Wed, 18 Sep 2013 05:19:08 -0700 (PDT)
In-Reply-To: <CAHGBnuMh9wqe6mhLyqbPAGJUEEH7cA2LZPuCQK8VD=NU2ix3Pg@mail.gmail.com>
X-Google-Sender-Auth: UqrkRwcKu06J3OSj9v9_Ka_vV38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234962>

On Wed, Sep 18, 2013 at 5:43 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
>
> My feeling is that Linus' reaction was more about that this
> work-around is even necessary (and MinGW is buggy) rather than
> applying it to git-compat-util.h and not elsewhere.

So I think it's an annoying MinGW bug, but the reason I dislike the
"no-inline" approach is two-fold:

 - it's *way* too intimate with the bug.

   When you have a bug like this, the *last* thing you want to do is
to make sweet sweet love to it, and get really involved with it.

   You want to say "Eww, what a nasty little bug, I don't want to have
anything to do with you".

   And quite frankly, delving into the details of exactly *what* MinGW
does wrong, and defining magic __NO_INLINE__ macros, knowing that that
is the particular incantation that hides the MinGW bug, that's being
too intimate. That's simply a level of detail that *nobody* should
ever have to know.

   The other patch (having just a wrapper function) doesn't have those
kinds of intimacy issues. That patch just says "MinGW is buggy and
cannot do this function uninlined, so we wrap it". Notice the lack of
detail, and lack of *interest* in the exact particular pattern of the
bug.

The other reason I'm not a fan of the __NO_INLINE__ approach is even
more straightforward:

 - Why should we disable the inlining of everything in <string.h> (and
possibly elsewhere too - who the hell knows what __NO_INLINE__ will do
to other header files), when in 99% of all the cases we don't care,
and in fact inlining may well be good and the right thing to do.

So the __NO_INLINE__ games seem to be both too big of a hammer, and
too non-specific, and at the same time it gets really intimate with
MinGW in unhealthy ways.

If you know something is diseased, you keep your distance, you don't
try to embrace it.

> I tried to put the __NO_INLINE__ stuff in compat/mingw.h but failed,
> it involved the need to shuffle includes in git-compat-util.h around
> because winsock2.h already seems to include string.h, and I did not
> find a working include order. So I came up with the following, do you
> like that better?

Ugh, so now that patch is fragile, so we have to complicate it even more.

Really, just make a wrapper function. It doesn't even need to be
conditional on MinGW. Just a single one-liner function, with a comment
above it that says "MinGW is broken and doesn't have an out-of-line
copy of strcasecmp(), so we wrap it here".

No unnecessary details about internal workings of a buggy MinGW header
file. No complexity. No subtle issues with include file ordering. Just
a straightforward workaround that is easy to explain.

                        Linus
