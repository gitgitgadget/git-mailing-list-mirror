From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 21:29:46 +1000
Message-ID: <CACsJy8D-M3xMkO7CPmOzeMxRV0Bv6MtCjH5eCr_vguxPF2N0vg@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com> <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEvy-0003oz-PF
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934974Ab3DHLaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 07:30:17 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56017 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934906Ab3DHLaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 07:30:16 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so3466840obc.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=f2i9iZ28/cO5ORzMKs0B453DvVjvHLNAmbbI1Gwb42s=;
        b=qwuR4VwB2Y7lWzT0N0jlWXIYKPxa2IhFR1SusFxcfrDuPhZRMVai3BFCuah8A0b5IQ
         DSN3Ul5RljzQ8lZ0ZAQWp2Tws0YHIC0/6exQmxwczYutWs0nYHuUGdmz9VAKAzsarr49
         hLJjBbKdnIojQPPkjYB4qw85f5/2m3+tbAnviL336tONnc3HqokSF3row4ZybYsOxi2T
         o3zQTnjRlmD4wSFDQoOtHHlwWjiPASYB5/tVPl1lDoC/9IeH6TYa9ktJZfNVy+vSrn/b
         PuqBKkKRp2DVUrju0tBQ/kIKf7GcosaT1wX8vP9AnjvhXOldh11dwebAaW0J9kbGuj6/
         Af+Q==
X-Received: by 10.182.204.5 with SMTP id ku5mr14993316obc.22.1365420616177;
 Mon, 08 Apr 2013 04:30:16 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 8 Apr 2013 04:29:46 -0700 (PDT)
In-Reply-To: <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220421>

On Mon, Apr 8, 2013 at 9:06 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> Probably off-topic, but I'm starting to find ".gitignore can be found
>> in every directory" a burden to day-to-day git operations. So imo it's
>> not done right entirely ;-)
>
> Why is it a burden?  I would argue that the tooling support is not yet
> there, but git check-ignore is a step in the right direction.  What
> alternate design would you propose, just out of curiosity?

You don't know if .gitignore is there, so you need to check for it in
every directory. If we fixed its location (e.g. worktree's top) we
would not have to look in every directory. Then again it may be a bit
inconvenient that way. If you remove a directory, you also remove
.gitignore rules inside when you distribute .gitignore files.
Otherwise you need to clean up top .gitignore once in a while.

> 1. The inspiration for fixing fundamental design problems comes from
> my redesign.  For instance, I would've never discovered the git add
> bug if I'd not attempted to git add (as opposed to the unnatural
> abstraction that git submodule add presents).

I actually spotted a similar use of git-add in the test suite [1]. You
see, it's a bug that should be fixed but in that particular case, it's
valid to add something "inside a submodule". I wanted to fix that with
my read_directory rewrite (part of the pathspec stuff) but never got
around to finish it and eventually gave up, which leads to your next
point..

> 2. I think it is absolutely imperative that we do the redesign now,
> before we've descended too far into the madness that the current
> design is.  I think I'm capable of doing the redesign now, with some
> help and support from the list.  My attitude doesn't align with the
> "I'm feeling lazy; why don't we postpone it?" argument.  Let's finish
> what I started now: I'm more than willing to dedicate the next few
> months full-time towards finishing this and getting it merged.

Good luck. Bug such a big work usually requires more than one
volunteer. If you haven't convinced (*) the community it's right,
maybe you should take a few days thinking about it again before
implementing.

[1] http://thread.gmane.org/gmane.comp.version-control.git/177454
(*) just a feeling after a quick glance, I may be terribly wrong again
--
Duy
