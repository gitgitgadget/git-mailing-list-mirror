From: Mark Abraham <mark.j.abraham@gmail.com>
Subject: Re: [PATCH] git-add--interactive.perl: Permit word-based diff
Date: Tue, 18 Jun 2013 23:12:59 +0200
Message-ID: <CAMNuMATdbhgydx5R0+OgSECqxs9tYgwqEjMuXq-0LV8fNaRWZw@mail.gmail.com>
References: <CAMNuMARruu+1=kny=g5O1MoxCXuoT3BHdSEEPSqvyn2t2JsAYg@mail.gmail.com>
	<20130618063144.GA6276@sigill.intra.peff.net>
	<87k3lrzxw7.fsf@hexa.v.cablecom.net>
	<20130618172300.GA3557@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 23:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up3D9-0007qy-7M
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 23:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314Ab3FRVNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 17:13:01 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:45553 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab3FRVNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 17:13:00 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so4282560pdi.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QBooRRvRd/sUBofVGF6XCfP8Qc8BRU2tkpgCorNpPcY=;
        b=KKAm6M003Hv5yoP7lWcx9UC3EOJRxhu2AZtODxNW5jYLLwwn/KDHzHkeA+0ALtrQon
         pr4eC3yqdU17Zdd+0gmadlJ0SDJDsxjPxW0Wt97v63A1fk7H21J2rB1oqoSgO0TTXmjT
         sfIlqEVcNZyF14h1x+3q5NZPXYHZncvCgJdCVs+rbWGozztN6JUStoKJvw6VaN52dbjH
         QdD5O3Z6SuoCJ/tN3inIKrdFOaTPqp+XuDvvod9OkVTiA90wcgRaVX6nqnOYesj26n1c
         a69JEDiaw8iV+AhmxZ+rsWrpy8/0otmBhN8WahI2C/j/m2X8GPwg0agc4HqBvgk/eTxt
         DzAw==
X-Received: by 10.66.148.201 with SMTP id tu9mr3670421pab.56.1371589979729;
 Tue, 18 Jun 2013 14:12:59 -0700 (PDT)
Received: by 10.70.26.101 with HTTP; Tue, 18 Jun 2013 14:12:59 -0700 (PDT)
In-Reply-To: <20130618172300.GA3557@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228317>

On Tue, Jun 18, 2013 at 7:23 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 18, 2013 at 09:22:16AM +0200, Thomas Rast wrote:
>
>> [I don't seem to have received a copy of the original mail, so I can
>> only guess...]
>
> Yes, the original doesn't seem to have made it to the list. Sorry, I
> don't have a copy (I am in the habit of deleting direct mails that are
> cc'd to the list, as I keep a separate list archive).
>
> Mark, did you happen to send an HTML mail? The list will silently
> reject such mail.

Yes, that was probably it. I tried to find a gmail configuration, but
I now discover it is done per-email, not globally. Apologies. I have
forwarded the original to Thomas, but based on current feedback, it
seems not worth re-sending the original mail to the list. See below.

>> > Note that the number of lines in your --word-diff=color hunk and the
>> > actual diff will not necessarily be the same.  What happens if I split a
>> > hunk with your patch?
>>
>> If it's actually what you hint at, there's another problem: the word
>> diff might not even have the same number of hunks.  For example, a
>> long-standing bug (or feature, depending on POV) of word-diff is that it
>> does not take opportunities to completely drop hunks that did not make
>> any word-level changes.
>
> Yeah, I didn't even think of that.
>
> In general, I think one can assume 1-to-1 correspondence between whole
> regular diffs and whole word-diffs, but not below that (i.e., neither a
> correspondence between hunks nor between lines).
>
> With something like contrib/diff-highlight, you get some decoration, and
> can assume a 1-to-1 line correspondence.

My choice of "permit" in the description was not best. My
implementation showed a word-based diff, but preserved the existing
mechanism for actually applying the hunk. I understand the way
colorization in git-add--interactive.perl works right now is to
colorize one version to display and use another - I think I preserved
that. I intended to permit the user to choose to show a word-based
diff of a patch during interactive add.

> However, I think that when reviewing text (especially re-wrapped
> paragraphs) that word-diff can be much easier to read, _because_ it
> throws away the line correspondence. To be correct, though, I think we
> would have to simply show the whole word-diff for a file and say "is
> this OK?". Which sort of defeats the purpose of "add -p" as a hunk
> selector (you could just as easily run "git diff --color-words foo" and

Hmm, I will have to re-consider the implications on that kind of
workflow. Thanks!

> "git add foo"). But it does save keystrokes if your workflow is to
> simply "add -p" everything to double-check it before adding.

Yes, that was what I was aiming to make easier.

> So I dunno. I could see myself using it, but I certainly wouldn't want a
> config variable that turns it on all the time (which is what the
> original patch did).

Good point. What I think I really want is "git add
--interactive=color" (with or without --patch) to permit the user to
choose to see the (colorized) word-based diff when they want one. I
now see that the config file approach in my proposed patch doesn't go
close enough to that to be worth considering further.

I think a proper implementation of the above command would have to
* add something to builtin_add_options in builtin/add.c,
* set a new static variable in add.c, and
* extend the calling logic for interactive_add() and/or
run_add_interactive() accordingly,
so that the perl script can get the user's choice on the command line
and not from a config file. And only respond when colorization is
configured.

Does --patch=color, --interactive=color or adding new option
--color-words make more sense?

I'll have a think about that and get back to you guys.

Thanks!

Mark

> -Peff
