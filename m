From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Sample pre-push hook can crash
Date: Fri, 11 Mar 2016 15:35:27 -0500
Message-ID: <CAH8BJxGeSL24v=RxBG4oBXQcavrpuawm1_N0kR7QBYOkYjpXaQ@mail.gmail.com>
References: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
	<xmqq37rydn6b.fsf@gitster.mtv.corp.google.com>
	<CAH8BJxFtHD6zq=EKb0XUsMu8uMDB6=J-F+TURha+XiWcq=V06A@mail.gmail.com>
	<xmqqmvq4aihh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 21:35:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeTmW-0005IP-PK
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 21:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbcCKUf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 15:35:29 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35110 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcCKUf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 15:35:28 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so33937137wml.0
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hmht3WDtbByF7CR/XLW3jQmmim0X16Ytbmy4Zw5L1s0=;
        b=JUTkk4H9aIYT8lKZo4Eayb6zFc7pr1m0352NLn0DAGQ03m5CCLVg4Pwe+T1StZ/4pv
         beDxsK6waBE7tX3zli2CUzCgUTy344UVzMX5Hw5q4U6Vb6YvcmMKykVxzCCF/jxiBjMZ
         raP40IKp0vq2SMUMHo86KVw40UHnnTVfyBkG7u45kBu/n98w9i3LIbL61DLfnRgcvE8D
         r4xHj8KreK3kKqo933Pl/rV0i7iTzJVg+tiLrTz/bBXbqQYF7p5aWg9oR0Or8IGvHstx
         vKkuLVRKTkQNUOjOmiS4WOwOBURpvkXPMBhEdPS+Lzdsr1pNCkIHHauHcOqypWHSFP57
         OAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hmht3WDtbByF7CR/XLW3jQmmim0X16Ytbmy4Zw5L1s0=;
        b=fpiG4+E7k8e0HWGiFMkpYwaG+PsRQK/ihSnHr5KEKddTyEmsnfOc1q1djX+gylypCL
         HFi3WEoFzYzJbkU5F3/nMp16Q+r3j3SlmjMHyU8J6aVDA/MsOkAdo732PS8HsxLVdHnW
         NadXWl8rmT+3oofMA5LAJZwW6ZzHbQDrtsBj01+U5kdRBTs3ap0ujdBWXAzlZmOS0TKC
         ahZ/16qP0cWWWrAAWcJU9mSLG7IUNxO4yUMnmhgKcU1bl61rLPbPvgsNW3ZRkEp1lX3Z
         9ulk3TKL9ohsv4a8zeaegURaqcKvMjfF4VLcuXqktbsRiIJilG4d52x4nYhgvUL/3Bik
         S1pQ==
X-Gm-Message-State: AD7BkJJAOwC6BaopTTdTZ+1+b2q0IZqxoSahSANOMB6SMtt8KeCUoaTNxSli10wHtVrUF8tzMMM8zkwaNzjuvA==
X-Received: by 10.28.52.197 with SMTP id b188mr5132759wma.77.1457728527277;
 Fri, 11 Mar 2016 12:35:27 -0800 (PST)
Received: by 10.194.63.82 with HTTP; Fri, 11 Mar 2016 12:35:27 -0800 (PST)
In-Reply-To: <xmqqmvq4aihh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288704>

Thanks for the information Junio. It is just interesting that although
the pre-push hook receives the remote_sha value from the server, it
does not get 'git merge-base $remote_sha $local_sha' which is what a
check that iterated over all outgoing commits would really need. (I'm
sure this is a simple-minded assessment. I don't pretend to have spent
even an order of magnitude less time working on git than you have. I'm
not trying to be foolishly arrogant.)

I do think it would be worth replacing the existing example with yours
because the existing example will crash anytime somebody's workspace
is up to date.

Stephen



On Fri, Mar 11, 2016 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen Morton <stephen.c.morton@gmail.com> writes:
>
>> That is interesting, so in the case of a non-ff push, there is no way
>> for a pre-push hook to know what is being pushed in order to run?
>
> If you were up-to-date from the other side once:
>
>     ---A---B---C
>
> and built one new commit on top:
>
>     ---A---B---C---D
>
> when you attempt to push it out, there are various possibilities.
>
> An ff situation is simple.  They didn't do anything, so the hook
> gets "we'd be updating their ref from C to D", and "rev-list C..D"
> would tell you that you would need to make sure D is sane.
>
> If your push does not fast-forward, that would mean something has
> happened on the other side while you were working on D.  Perhaps
> they accepted another commit that you haven't seen:
>
>     ---A---B---C---E
>
> and because you haven't fetched from them, even though the hook may
> say "we'd be updating their ref from E to D", you haven't heard of
> E, you do not know where it would be relative to the history you
> have:
>
>                   E???
>
>     ---A---B---C---D
>
> Or perhaps they themselves rewound their history and they now have
> this E at the tip:
>
>     ---A---B---C
>             \
>              E
>
> But again, because you do not yet know where E is relative to your
> history, you cannot say C is where you can stop checking your side
> of the history.
>
> Or perhaps they somehow obtained your D without you pushing into
> them (e.g. you pushed to the "next" tree and they fixed your commit
> and the result was merged there) and have something like this:
>
>     ---A---B---C---D---E
>
> In this case, D is not even a new commit from their point of view,
> and updating their tip E with your old D would lose the fixup E they
> made for D, but again, you do not know what E is yet, you cannot say
> "they have this already, so there is no check I need to do".
>
> In summary, you cannot even say which ones you have need to be
> checked.
>
> If you _are_ using @{u} tracking, then you would know at least they
> used to have up to C in their repository to limit your check, but
> you cannot unconditionally say ref@{u}.. without making sure ref@{u}
> makes sense in the first place.
>
> An obvious alternative for the sample script would be to instead let
> the non-ff push pass the pre-push check (as you may have other
> arrangements to forbid non-ff pushes) without actually checking
> anything.  As this sample script is to serve as a sample, I think
> such an advanced consideration of loosening checks depending on the
> situation should be left to the end users.
>
