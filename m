From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 12:19:10 -0700
Message-ID: <CAGZ79kb=dR3omuf1ji8AK9Dh0VCW8pWJ-twWkXXHdDV96RA2QA@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
	<20150916094814.GB13966@sigill.intra.peff.net>
	<xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
	<20150916185256.GA2654@sigill.intra.peff.net>
	<xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcIEe-0005kb-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbbIPTTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:19:12 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34508 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbIPTTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:19:11 -0400
Received: by ykdg206 with SMTP id g206so229256088ykd.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xoxvM0bbJ2RNcWbDiS3d2v5QaSYSelpSooJpQGZeMJ0=;
        b=X7SlLgP0EIX4HQ1iL6fOs5QURcY7dgvyY9VkhEmPLDBNzEI5//uI28sa27dQbq20hh
         nU7zKU3IoBIVXVTecQ/nGgZtC73Py8opuUye2GazN6EIaJpWwtWp0VB4cZk/HCrsT6DG
         XEf9VrodwVK3IP1abJq7ny2IUrte/qE8rOjSKb/k0XBFdr6q5HYyXtJORpNpI2O8XlPA
         ByvaeTxdXbVYVl07GXcNytgnkhg8PqMOLA2ZB21H9NvEeuu8uZGIfQrmALWD+R1kZnpf
         fyfgrcR9UVK3T34eU841AlmfTrPDcn1O3UzZLMtU61HZqaZkx56UASNg35ZtsZwuMN7/
         Zqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xoxvM0bbJ2RNcWbDiS3d2v5QaSYSelpSooJpQGZeMJ0=;
        b=As4GEZSYWBH+HdwsK4j9ekRwvCoDioceaQK7rLYrueYYNUIIYxRAD3pL8deOpPIn27
         jDpBtWmJc2Vwc3xSg9eHcEtNnbyQCmV84Am5C5E1zAc2N/yaG4RMT2i+GvgdjdeImzIa
         WduR7FpJKX6fVe9sdDyMkWuVqniWPMSaE8UXbprzyFyDNSE1Mp3jtvhykCUW+nEkcn/n
         6DIB5f6SjryHLdgNLIrJA9BqL4NSvo+EsxETIzqb6M43Uc4HmvLqGutEX2ZzaVcXCurH
         lZeyybwhLNNZC3/M74EWcWkPp1rovdF7nizkgb3kxfzEbWBEgTqeMbM48a8P3SSPNhGb
         U7LQ==
X-Gm-Message-State: ALoCoQmAKZfwtEjlBGYyOSxr13O7/2MpbX5e5iKnzm6uuzAjQS3JiFZOsuz4mfEZkM+hEGWmuTGN
X-Received: by 10.170.190.133 with SMTP id h127mr30189446yke.115.1442431150534;
 Wed, 16 Sep 2015 12:19:10 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 16 Sep 2015 12:19:10 -0700 (PDT)
In-Reply-To: <xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278052>

On Wed, Sep 16, 2015 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Sep 16, 2015 at 11:24:27AM -0700, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>> > On Tue, Sep 15, 2015 at 11:19:21PM -0400, Eric Sunshine wrote:
>>> >
>>> >> >                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
>>> >> > -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
>>> >> > +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
>>> >>
>>> >> Interesting. I wonder if there are any (old/broken) compilers which
>>> >> would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?
>>> >
>>> > Good point. I've changed it to sizeof(ownbuf[0]).
>>>
>>> Panda brain is lost here.  What's the difference, other than that we
>>> will now appear to be measuring the size of the thing at index 0
>>> while using that size to stuff data into a different location?  All
>>> elements of the array are of the same size so there wouldn't be any
>>> difference either way, no?
>>
>> Correct. The original is sane and gcc does the right thing. The question
>> is whether some compiler would complain that "stage" is not a constant
>> in the sizeof() expression. I don't know if any compiler would do so,
>> but it is easy enough to be conservative.
>
> Wouldn't such a compiler also complain if you did this, though?
>
>         int *pointer_to_int;
>         size_t sz = sizeof(*pointer_to_int);
>
> You (as a complier) do not know exactly where ownbuf[stage] is,
> because "stage" is unknown to you.  In the same way, you do not know
> exactly where *pointer_to_int is.  But of course, what the sizeof()
> operator is being asked is the size of the thing, which does not
> depend on where the thing is.  If you (as a compiler) does not know
> that and complain to ownbuf[stage], wouldn't you complain to the
> pointer dereference, too?
>
> A more important reason I am reluctant to see this:
>
>         xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);
>
> is that it looks strange in the same way as this
>
>         memcpy(ownbuf[stage], src, sizeof(ownbuf[0]));
>
> looks strange.  "We use the size of one thing to stuff into another".
>
> That will make future readers wonder "Is this a typo, and if it is,
> which index is a mistake I can fix?" and may lead to an unnecessary
> confusion.  I do not want to see a correctly written
>
>         xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);
>
> turned into
>
>         xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", ...);
>
> out of such a confusion.

So we could just not use the bracket notation, but the pointer then?

    xsnprintf(ownbuf[stage], sizeof(*ownbuf), "%o", ...);

IMHO that would reasonably well tell you that we just care about the
size of one element there.

A funny thought:

     xsnprintf(ownbuf[stage], sizeof(ownbuf[-1]), "%o", ...);

should work as well as any reader would question the sanity
of a negative index.
