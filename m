From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 17/17] rebase-interactive: introduce interactive
 backend for builtin rebase
Date: Wed, 16 Mar 2016 00:48:27 +0800
Message-ID: <CACRoPnRhhMM0e3S23KVnEANwNRDPq0P3hSqn5Zs1ksZxeaAoiA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-18-git-send-email-pyokagan@gmail.com>
	<alpine.DEB.2.20.1603150800420.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs94-0001Qx-GE
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbcCOQsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:31 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36354 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965214AbcCOQs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:48:29 -0400
Received: by mail-lf0-f48.google.com with SMTP id l83so34340lfd.3
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5fFRYyzlTlMxUO4pwb0gUY7ngSGJK+RNrJECrY1oO24=;
        b=w/3NW0bt5ZY/mSD/JC/cGU1nsrNZ0xXk/Tz3dQQtAvykMgtzAqQDZb1HhfYfH6rNXW
         /mlZU0DftvYxEnd1Q358uO35iwgWxzzFzI4eA1uSy+33lbv8Q9nss/WnVAUtfTqv64sE
         uwrsOSuK4TIcHNcYnQM2wV9uyX78cex82leHZKx69EeWlIeAkcdNB5X5T3+7lMoUzq42
         twCFCoHdVclTvWPNPd20vep979UgTShvNbWNdU9f4vzqlFuL2uln8avXGaOjMVI2Fg83
         r9NJaV1JhySrF1fxUpo6X0xRgobg3Xi1ddCMMKtjm2JAeOQfwJXyYlCwbzR99UyM3j/7
         zpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5fFRYyzlTlMxUO4pwb0gUY7ngSGJK+RNrJECrY1oO24=;
        b=kXzg8go2utZ+Dz60Pcf/v9/LOnzmm2ESdjoNuDHsm2CdjjlLGjCuhIV09cDGlMhgPC
         T2yrl3+ru33Yk4aAsXw/tIjDfxvH5EaZjeOmZTFXaUhgpKmt57Tg/f5G/qxmlsL406b9
         8ZgbY39Zn+ZiSp6umr5GXQZSmxd0NOr8oped3OkTJEebe2X52H0WbAz2BAKaH9lTU+xA
         704m1rh+637YH0KZSRL8h1w3ZLM7S59Sh0SIGNC94efSN3VvVhClsE5R8v2ED81yaJAo
         Y/Bswf3I3B5KLmsqZekV6tXHbMJGMgKAS37Yl3r1n7mMiPNXpmGlBC5esNQQmulcGPY/
         HRIw==
X-Gm-Message-State: AD7BkJJ2kktQm3WjkGoTwcxKI13Hf8kmOGYGRKNlhOG6trFUKyuNiUBWMtAJnDLm3xJG9Go0agVKO65wawc3xw==
X-Received: by 10.25.79.16 with SMTP id d16mr8296107lfb.73.1458060507498; Tue,
 15 Mar 2016 09:48:27 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Tue, 15 Mar 2016 09:48:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603150800420.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288879>

Hi Dscho,

On Tue, Mar 15, 2016 at 3:57 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 12 Mar 2016, Paul Tan wrote:
>
>> Since 1b1dce4 (Teach rebase an interactive mode, 2007-06-25), git-rebase
>> supports an interactive mode when passed the -i switch.
>>
>> In interactive mode, git-rebase allows users to edit the list of patches
>> (using the user's GIT_SEQUENCE_EDITOR), so that the user can reorder,
>> edit and delete patches.
>>
>> Re-implement a skeletal version of the above feature by introducing a
>> rebase-interactive backend for our builtin-rebase. This skeletal
>> implementation is only able to pick and re-order commits.
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>
> It is a pity that both of us worked on overlapping projects in stealth
> mode. Inevitably, some of the work is now wasted :-(

No worries, I did this series for my own interest, especially to get a
gauge of the speedup between rebase in shell and C. GSoC applications
have opened and will close in 10 days time, so I wanted to get some
data before the deadline at least :-).

> Not all is lost, though.
>
> Much of the code can be salvaged, although I really want to reiterate
> that an all-or-nothing conversion of the rebase command is not going to
> fly.

Sure. I admit that I concentrated more on how the "final code" would
look like, and not so much how the rewrite would be built upon in
pieces.

> For several reasons: it would be rather disruptive, huge and hard to
> review. It would not let anybody else work on that huge task. And you're
> prone to fall behind due to Git's source code being in constant flux
> (including the rebase bits).
>
> There is another, really important reason: if you package the conversion
> into small, neat bundles, it is much easier to avoid too narrow a focus
> that would tuck perfectly useful functions away in a location where it
> cannot be reused and where it is likely to be missed by other developers
> who need the same, or similar functionality (point in case:
> has_uncommitted_changes()). And we know that this happened in the past,
> and sometimes resulted in near-duplicated code, hence Karthik's Herculean,
> still ongoing work.
>
> Lastly, I need to point out that the conversion of rebase into a builtin
> is not the end game, it is the game's opening.
>
> [...]
>
> So you see, there was a much larger master plan behind my recommendation
> to go the rebase--helper route.

Ah I see, thanks for publishing your branch and sharing your plans.

Originally I was thinking smaller -- rewrite git-rebase first,
following its shell script closely, and then doing the libification
and optimization after that. However, I see now that you have grander
plans than that :-).

>
> As to my current state: Junio put me into quite a fix (without knowing it)
> by releasing 2.7.3 just after I took off for an extended offline weekend,
> and now I am scrambling because a change in MSYS2's runtime (actually,
> probably more like: an update of the GCC that is used to compile the
> runtime, that now causes a regression) is keeping me away from my work on
> the interactive rebase. Even so, I am pretty far along; There are only
> three major things left to do: 1) fix fixups/squashes with fast-forwarding
> picks, 2) implement 'reword', 3) display the progress.  And of course 4)
> clean up the fallout. ;-)
>
> At this point, I'd rather finish this myself than falling prey to Brooks'
> Law.

Okay, I won't touch interactive rebase then.

> I also have to admit that I would love to give you a project over the
> summer whose logical children are exciting enough to dabble with even
> during the winter. And somehow I do not see that excitement in the boring
> conversion from shell to C (even if its outcome is well-needed).

Well, that is subjective ;-).

Even with interactive rebase out-of-bounds, I don't think it's a dead
end though:

1. git-rebase--am.sh, git-rebase--merge.sh and git-rebase.sh can be
rewritten to C, and call git-rebase--interactive.sh externally, like
what Duy demonstrated in his patch series. The timings show that am
and merge rebase still benefit, and that way we will be closer to a
git-rebase in full C.

2. git-commit can be libified, so that we can access its functionality
directly. (sequencer.c runs it once per commit, rebase-interactive
uses it for squashes etc.)

Or would that be stepping on your toes?

> Ciao,
> Dscho
>
> Footnote *1*:
> https://github.com/git-for-windows/build-extra/blob/master/shears.sh

Regards,
Paul
