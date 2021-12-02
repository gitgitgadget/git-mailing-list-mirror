Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF3DC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 23:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377610AbhLCACM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 19:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbhLCACL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 19:02:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B37C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 15:58:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so4633642edv.1
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMeDiWFoLtkp26ka6aHdFouRKvK6uev3187pcSrg6sE=;
        b=N0XjbRUwkz8bJb91s4BJ9dcLXCNNyegXrj4FACL9fq3HEvpimW+FX6n9TjLMLiMEtm
         hcGkGTpNic3UDeov9tnnbhrGp2d47gnzUyi4ooVnBLqBnuwADQOvcjJjs9ACFNWNDZqQ
         JBTLluptM7DVKd+E2uXrkGzJ75vDlVXj9y8aSHLQ2LvGDiWYPIDyZuoNh4m+S8KZvYxY
         J0Yx7Ad8lOhZyXZWdhVwp3A5qdRZ4Ulym/WoRcC/5EExd1dwW4/lyx5Sx4Z5Pbko1Pc8
         jDpqj0dCI+tEnLeMRON03NtdPHpBl+RbGQpBBqVPbhHRb3j8dEIZCOvdd+Jnl4+pRDqA
         bYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMeDiWFoLtkp26ka6aHdFouRKvK6uev3187pcSrg6sE=;
        b=3uTeJGWW1hO3PeByi0UhpBS/I3prqhkJ4kQbG88HuqZh2tniiA2XQ2FZEa5pZ2HQF0
         7Br+Psq+0Q3xKfd7jVFNoHYA5hpnnVdLXmNSyHfa0anaHYtn24Ly3I7qQ4JV/X5BgMrq
         u0Wx26y5BATfwKPxs+E+Y9a/o1ry25m42dSnFsenDHyq9feHKjOCVTXTbvYtvzqYEP4R
         pwM8aW9Wz7whmVlR87jtt5tP5eyMfKClJsi0/LzGmMIp6v86vkony7uK134Ck91IoFq7
         cpccLypv9dMEmCAG+Xre2XI8ae3EScJeqHHumrQu4++q/ByLNUWKpjaDbCk7pXDZPRT3
         SLiw==
X-Gm-Message-State: AOAM533/ffg5dBBYDdYFZIY7/C6wZAh1f04w1bm27JOra8Kvc2IRLGMk
        lEYH++iQtvG/0pcYrXUBMCgZHBoVeFuxzsI4rhvMfnIEhVs=
X-Google-Smtp-Source: ABdhPJw6sFIHaBbrQ+JUbePgaGJTTWk1vuYiqjo12zM/P1E2HP1XLaSgKwXsKwxrjz+YGdlAt6YR7gM21X3oT32wmYc=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr21607653edb.175.1638489526996;
 Thu, 02 Dec 2021 15:58:46 -0800 (PST)
MIME-Version: 1.0
References: <1638470726.ql5i6zljva.none.ref@localhost> <1638470726.ql5i6zljva.none@localhost>
In-Reply-To: <1638470726.ql5i6zljva.none@localhost>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Dec 2021 15:58:35 -0800
Message-ID: <CABPp-BEyy97x-9od+9E9DxCDHHq-m8hyZJWqxFutkRy3G7Hu9g@mail.gmail.com>
Subject: Re: Confusing (maybe wrong?) conflict output with ort
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Dec 2, 2021 at 11:08 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Hi all,
>
> After upgrading to git 2.34.1, I tried to rebase [0] onto [1], but
> encountered "strange" conflict results.
>
> git rebase -s recursive main produces [[RECURSIVE]]. It is roughly what
> I expected to be output. If I take all the changes from the upper
> section of the conflict, my changes will be effectively undone. If I
> take all the changes from the lower section, then the upstream changes
> will be undone.

In general, this does not work.  The only time it can work is if every
region of the code considered by the three-way content merge ended up
with conflicts.  (If any of those regions had automatically resolvable
changes, then after taking just the upper section(s) or just the lower
section(s) of each conflict would still result in a file that is a
mixture of changes from both sides due to the automatically resolvable
chunks that the merge already handled.)

> On the other hand, running git rebase -s ort main produces [[ORT]]. I am
> unsure if it is wrong, strictly speaking, but it is certainly unexpected
> and difficult for me to resolve. Selecting the upper section of the
> conflict does erase my changes, as before, but selecting the lower
> section results in syntactically incorrect code (foreach is ended by
> endif). The diff3 output makes even less sense to me.

The output from using ort is identical to that obtained by

   git rebase -s recursive -Xdiff-algorithm=histogram ...

on your testcase; i.e. this is due to a difference between the
histogram and myers diff algorithms.
(recursive defaults to using myers diff; ort uses histogram diff.)

> A script is attached to assist in reproducing my results. Running it
> initializes the repository to the desired state. Then, run "git rebase
> -s strategy master" to produce the conflict.

Thanks.  I'll note for others that there's a missing 'git add
meson.build' (without which the script errors out), and folks should
probably run this from an empty directory that they can nuke later.


Let's use a simpler example for demonstration purposes with some made
up pseudocode.  I'll label each line so I can refer to it ('B' for
base, plus a line number), but the lines are everything after the
label:

B01 if condition1:
B02   if condition2:
B03     do_stuff2()
B04   endif
B05   for var in range:
B06     if condition3:
B07       do_stuff3()
B08     endif
B09   endfor
B10 endif

And let's say that locally, you modified line 7 to do something more
complex, so that the local version looks like this: (prefixing the
line numbers with 'L' for local)

L01 if condition1:
L02   if condition2:
L03     do_stuff2()
L04   endif
L05   for var in range:
L06     if condition3:
L07       more_detailed_stuff3()
L08     endif
L09   endfor
L10 endif

Further, let's say that upstream either determined that condition1 was
always true, or just that they wanted to run all the code
unconditionally so they removed the outer if and un-indented
everything.  So they have (prefixing the line numbers with 'U' for
upstream):

U01 if condition2:
U02   do_stuff2()
U03 endif
U04 for var in range:
U05   if condition3:
U06     do_stuff3()
U07   endif
U08 endfor


There's multiple equally valid ways to attempt to merge this.  One
could be just considering the entire region to conflict, so you'd end
up with a conflict region that looks like this:

    <<<<<<
L01 if condition1:
L02   if condition2:
L03     do_stuff2()
L04   endif
L05   for var in range:
L06     if condition 3:
L07       do_stuff3()
L08     endif
L09   endfor
L10 endif
    ||||||
B01 if condition1:
B02   if condition2:
B03     do_stuff2()
B04   endif
B05   for var in range:
B06     if condition3:
B07       do_stuff3()
B08     endif
B09   endfor
B10 endif
    ======
U01 if condition2:
U02   do_stuff2()
U03 endif
U04 for var in range:
U05   if condition3:
U06     do_stuff3()
U07   endif
U08 endfor
    >>>>>>

Of course, you can leave out the middle region if not doing diff3.

Alternatively, if you look closely, there is exactly one line that
matches in all three versions of the code: B04 == L04 == U07 (if you
think there are other lines that match, you're not paying enough
attention to leading whitespace).  That one matching line could be
used to break us into two conflict regions, which we'll take as a
first step towards simplifying this:

    <<<<<<
L01 if condition1:
L02   if condition2:
L03     do_stuff2()
    ||||||
B01 if condition1:
B02   if condition2:
B03     do_stuff2()
    ======
U01 if condition2:
U02   do_stuff2()
U03 endif
U04 for var in range:
U05   if condition3:
U06     do_stuff3()
    >>>>>>
B04   endif
    <<<<<<
L05   for var in range:
L06     if condition 3:
L07       more_detailed_stuff3()
L08     endif
L09   endfor
L10 endif
    ||||||
B05   for var in range:
B06     if condition3:
B07       do_stuff3()
B08     endif
B09   endfor
B10 endif
    ======
U08 endfor
    >>>>>>

Now, if you look at the first conflict region, the local side matches
the base side exactly, so it can be trivially merged -- we should just
take the upstream side.  Doing that gives us the following:

U01 if condition2:
U02   do_stuff2()
U03 endif
U04 for var in range:
U05   if condition3:
U06     do_stuff3()
B04   endif
    <<<<<<
L05   for var in range:
L06     if condition 3:
L07       more_detailed_stuff3()
L08     endif
L09   endfor
L10 endif
    ||||||
B05   for var in range:
B06     if condition3:
B07       do_stuff3()
B08     endif
B09   endfor
B10 endif
    ======
U08 endfor
    >>>>>>

Or, if you don't use the diff3 format, then we can leave out the
middle section of the remaining conflict and get just:

U01 if condition2:
U02   do_stuff2()
U03 endif
U04 for var in range:
U05   if condition3:
U06     do_stuff3()
B04   endif
    <<<<<<
L05   for var in range:
L06     if condition 3:
L07       more_detailed_stuff3()
L08     endif
L09   endfor
L10 endif
    ======
U08 endfor
    >>>>>>

Now, if you try to use just the "left" side of the remaining conflict,
you get code that doesn't even compile because it's mixing upstream
and local code (and in particular ends U04's "for" with L10's "endif",
similar to the example you gave).  The lines U04-B04 roughly
correspond to L05-L08 (though U06 needs updating based on L07), and
your confusion is probably that both are included in the result.  But
the above is why.

Does that help explain things?
