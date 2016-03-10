From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: git smudge filter fails
Date: Thu, 10 Mar 2016 09:45:19 -0500
Message-ID: <CAH8BJxFmAQtoF+1Q7Ub5qWnz5UewrPS4e8JQWms254hO_E05Hw@mail.gmail.com>
References: <CAH8BJxHwxp2BtzGBqi6J24Kh0TTGEdCx=-Scu+bx5N-ZVpBZNQ@mail.gmail.com>
	<20160310015939.GA12709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 15:45:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae1qA-0000uh-T0
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 15:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbcCJOpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 09:45:24 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36899 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbcCJOpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 09:45:22 -0500
Received: by mail-wm0-f52.google.com with SMTP id p65so31769250wmp.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 06:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8WjDPdxCFFjQqkmZlyr6nz8EeE0so7LgWD+CphDCBKE=;
        b=FtvpeXwfNAPn5wTLYK+WHBH+e66W1jYDipB7iZtSpt7a3/gmsszRdBr/Jvhx/vqStC
         P+DPb5RjJqcR0HtDyPLRzYzbUFpjhtFOBYkfGQ1LlV9prFoEakauTbwV7IBKgp75+nqS
         SJyqnX6w0Rxq42kwIX6zUFZvV2ErGojRCQQY0uLFQl5QSv7MWsDUhS/DSnAVI/iHk4Kx
         W37g1e3VkZ73NIKf5EIN+Q2+JXZSqW44AtoCGzQdV8RblIkvDQPBGlrWdPyksBLad277
         p3rTM39NmA5Qfkr68lNCDJ7xfb/gYFAV0J/ehTGacn4rKbtLbnGShC9wtgOx27IIHyzR
         +GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8WjDPdxCFFjQqkmZlyr6nz8EeE0so7LgWD+CphDCBKE=;
        b=Ls7SlgZh61qT1ibyEG2lDox4oRzbX1k2hAhZJOmHdrO+ahubWYUUAVPKFrXFTDuCv0
         eojkuIh6ae4FmDaI27nM1q+Ah6vpEKLQFXOXcfXo6J/2X0F34W8LygPe80J4wK6bBJLA
         dw9tsBMrbCzStEPjqckefRVxqEluA1SCfkSVm0eK5NMekUGmnRw8Ff34OL1+e3qyZddB
         oZgtCHlpHQEhPboOJCvJUHqHSHUjj5dtFVbEVPmfOBbKwvMfdb1q0SUJTbGDGIE26idC
         xkaAvY4N71ynV/4eXn4cGgGBs+9jGG0hnX0opVcNJhk41KeFD9Ebl5yl34/z86Mie/U8
         g/hQ==
X-Gm-Message-State: AD7BkJKJqxZcDCbt4RqD0MZ0moAExxLnE750NR0brFiC/JjWujQGFX+YQ0mOjBt6x7ba9YoSf8piqZdUnevdIg==
X-Received: by 10.194.83.42 with SMTP id n10mr4401600wjy.20.1457621119792;
 Thu, 10 Mar 2016 06:45:19 -0800 (PST)
Received: by 10.194.63.82 with HTTP; Thu, 10 Mar 2016 06:45:19 -0800 (PST)
In-Reply-To: <20160310015939.GA12709@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288625>

I am a bit confused because this is basically the example used in
ProGit [1] and it is fundamentally broken. In fact, if I understand
correctly, this means that smudge filters cannot be relied upon to
provide any 'keyword expansion' type tasks because they will all by
nature have to query the file with 'git log'.


(Note that although in my example I used 'git checkout', with an only
slightly more complicated example I can make it fail on 'git pull'
which is perhaps a much more realistic use case. That was probably
implied in your answer, I just wanted to mention it.)

Steve

[1] https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes



On Wed, Mar 9, 2016 at 8:59 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 09, 2016 at 01:29:31PM -0500, Stephen Morton wrote:
>
>> git config --local filter.dater.smudge 'myDate=`git log
>> --pretty=format:"%cd" --date=iso -1 -- %f`; sed -e
>> "s/\(\\$\)Date[^\\$]*\\$/\1Date: $myDate \\$/g"'
>
> Your filter is running "git log" without a revision parameter, which
> means it is looking at HEAD.
>
> And here....
>
>> git checkout no_foo
>> git checkout master
>> cat foo.c
>> #observe keyword expansion lost
>
> You are expecting this second one to do:
>
>   1. Switch HEAD to "master".
>
>   2. Checkout files which need updating. Looking at HEAD in your filter
>      then examines "master", and you see the commit timestamp of the
>      destination.
>
> But that isn't how it is implemented. Checkout will handle the file
> checkout _first_, as that is the part that is likely to run into
> problems (e.g., rejecting a switch because it would lose changes in the
> working tree). Only at the very end, after the change to the working
> tree has succeeded, do we update HEAD.
>
> I think the order you are expecting is conceptually cleaner, but I don't
> think we would want to switch it around (for reasons of efficiency and
> robustness). And I don't think we would want to make a promise about the
> ordering to callers either way, as it binds our implementation.
>
> So is there a way to reliably know the destination of a checkout? My
> first thought was that we could add a placeholder similar to "%f" that
> your filter could use. I'm not sure how we would handle the corner cases
> there, though (e.g., do we always have a "destination" to report? If
> not, what do we give the script?).
>
> I suspect you could also hack something together with a post-checkout
> script, though it would probably be a lot less efficient (and might also
> have some weird corner cases).
>
> -Peff
