From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 11:31:25 -0700
Message-ID: <CAGZ79kZDq10nDZAgqtYN2J7=LvAdRoWN3rpCEnco97W3637sNw@mail.gmail.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
	<xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
	<xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
	<20150424181236.GK5467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 20:31:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YliNw-0007g7-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 20:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965744AbbDXSb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 14:31:27 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35616 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbbDXSb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 14:31:26 -0400
Received: by igbyr2 with SMTP id yr2so22033974igb.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Iskcy5YXL2w+FvHmtMZXMXJ7OVuUTxBvpqUP17g2+bs=;
        b=gj4hX12ABh5nwYkC9AoUTpaK+QJM9GwXs78YJHoozhAXPM+EFsONZl4nLo+p+7zUHh
         U0QpGcXpNCqM0qI5/5GrbfWTRzG0y5czdwh3mKkjA7Tkois7h7Yz2MuzYx5qxuWelfK/
         90h0CcdM062x1VcB3jEXmGdIcYHwx7RpS9ndqbshdJNiabfsy++cmFHO8b1RlFxA8QEm
         VRrJy5acCcbjYz+di8ZZb7qWGjiaLR2Jo8ueKHxs4CchY5jmaE/DPtdQbJOkGijOWE3o
         i3AVClKkP6IF3dS5LskaPalBA8YZVP0Sg1a8VlEXf/ddBONtzg8PDKlzlwpVFF+fw3FL
         zwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Iskcy5YXL2w+FvHmtMZXMXJ7OVuUTxBvpqUP17g2+bs=;
        b=eJ6ldISR5K4soLvr5DAHeUpCdhyw+H4vdm953XoL97SNCEf5g99LH1gTcVSA6INsy0
         Qu0SLZbybAlYsboyx0SdrZsIKhYxxrV1gMYsfOVYoh0JkGWrDDMDp5Hbg/s2McJMyVOl
         U6Av0hy18jmznbSn3or5IRR28NkEqdLs5gcr3WOCPEeL4SPIw/NRdFLb63R8Kd4+tkcB
         6k06GOS2HPD8DEDjtjEnxNV1+evjqCaZUs1iH87G+xl3r4l/25dMUXbUNZqCpmnW6HgU
         7T1TsxasTakKKDvSY1ci1nXpZymeMKpJkQScTh/kNtjOk28m+huf1+apALr1+KsndzjP
         z1NA==
X-Gm-Message-State: ALoCoQky52N5b7GbLH94Vnzy614V4jExGF1kEVgpmNkJjqXwA1BHkkNRCfYTY6GZWe90aUjumzxl
X-Received: by 10.42.30.141 with SMTP id v13mr379584icc.76.1429900286094; Fri,
 24 Apr 2015 11:31:26 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 24 Apr 2015 11:31:25 -0700 (PDT)
In-Reply-To: <20150424181236.GK5467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267748>

On Fri, Apr 24, 2015 at 11:12 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> I understood that you were talking about Could being capitalized.
>> Though it's distributed 30/70 which hints to me we do not care in
>> enough to explain the capitalized letters as slip-throughs on review
>> or such, but it looks like the authors choice to me.
>
> Lowercase, brief, with no period at the end is the convention.  This
> is user-facing UI, so consistency matters.  It's not author's choice.
>
> Existing examples of capitalized messages fall into a few categories:
>
>  - shell scripts used to tend to use the capitalized form, and when
>    they got rewritten as builtins the messages weren't cleaned up at
>    the same time
>
>  - some patch authors have different habits and it wasn't worth going
>    back and forth to fix it (but the convention still stands, and the
>    result of a program that can't decide how to talk to the user is
>    still harmful)
>
>  - once there are a few examples, they get copy/pasted and imitated
>
>> I think it's a mistake to s/Could/could/g for all errors in the code base
>> as it reduces the information provided in the error messages.
>
> This seems like an after-the-fact justification for a mistake.
>
> Often there is a choice about whether the caller or the callee to a
> function prints an error.  If the caller does, it can say more about
> the context.  If the callee does, the message is in one place and can
> be tweaked more easily to be more useful.
>
> To get the benefits of both, we could print a backtrace with every
> error.  That way, the callee can describe the error in one place but
> the context is all there.  But I'm really glad we don't do that!
>
> The main purpose of most error messages is instructional: they give
> information to the user in a way that is abstracted from the
> implementation (the user doesn't care what function it happened in!)
> that tells them what happened and what they can do next.
> Gratuitous inconsistency in formatting doesn't help with that.

I agree we should fix the formatting, but I was pointing out the side effects
and how to avoid the side effects. So what I am proposing is a cleanup of
the warning messages as well as a GIT_TRACE_ERRORS variable as
Jeff proposed, because then we have all the benefits.

If we were to just cleanup the error messages we improve on certain aspects
(UI), while making others worse.


>
> Actually, I wouldn't mind an environment variable that tells error()
> to include a backtrace if someone wants it.  (See backtrace(3)
> for implementation hints if interested in doing that.)

CONFORMING TO
       These functions are GNU extensions.

I guess I can live with backtrace, but the Git for Windows people may
hate me for it.


>
>> Just 3 days ago ("Regular Rebase Failure"). I used different
>> capitalization to get a better understanding where the error may be.
>
> Wouldn't it be better if there weren't so many similar messages
> produced in different contexts in the first place?  (I.e., this
> suggests to me that we should move more in the direction of
> callee-produces-error.)
>
> Sorry, that was a long way to say very little.  I just wanted to
> emphasize that when a UI inconsistency has a useful side effect, while
> that can be useful to understand and learn from, we should not be
> afraid to fix it.  And to clear up any ambiguity about git's error
> message convention. :)
>
> Thanks and hope that helps,

I really appreciate the background information provided!

Thanks,
Stefan

> Jonathan
