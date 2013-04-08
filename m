From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 16:36:09 +0530
Message-ID: <CALkWK0mLG78anjbcVRF7Zpj-hMmts1pshF=XhLh--MCYV66Gng@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
 <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEvX-0003oz-WA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935118Ab3DHLGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 07:06:51 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34506 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934765Ab3DHLGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 07:06:49 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so6773311ieb.15
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JlI4M+E+3GI5Zz2LkILoi9PoCRMyxJI736R9rZWEGpE=;
        b=S8T/AiLPGbwoxFtpUiOXJY8l988/Jy+akgUOjq6Swx0U3PGHKHKV9Wk6f/Ke8s4cA6
         +y5qwV56WbXa515km2lyXL/eX8mG23I7mUmI9A/05sESLiKbEJzFBbF1dJZcA9/1t98j
         jN+R+pLAKetGCqGVbDO/srOxe8UUZXieC71JXxLyToGUmS4NIiLPpiEPbKykmipCZyGT
         /HysQZmYlyHsk83PxAefBFicuYyYRMYwdqPHXdhG3pIXuNGWxitj7dViQ/SeAsReKgpv
         gdQGSebVH/H6mini4nIy4GGbnchBTrvx28l2qBmat7MW8HPClMORB9Y+cFp4AOGAQXCl
         oqgg==
X-Received: by 10.42.204.79 with SMTP id fl15mr11482338icb.57.1365419209177;
 Mon, 08 Apr 2013 04:06:49 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 8 Apr 2013 04:06:09 -0700 (PDT)
In-Reply-To: <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220420>

Duy Nguyen wrote:
> Probably off-topic, but I'm starting to find ".gitignore can be found
> in every directory" a burden to day-to-day git operations. So imo it's
> not done right entirely ;-)

Why is it a burden?  I would argue that the tooling support is not yet
there, but git check-ignore is a step in the right direction.  What
alternate design would you propose, just out of curiosity?

> Index operations sometimes read these .git{ignore,attributes}. I
> believe git-archive reads worktree's .gitattributes, so it's not
> really just about worktree.

I should've said "largely, only affects the current worktree".

> I don't follow this thread closely, but I think there's a common
> ground where improvements can benefit both approaches. There are a lot
> of problems for deep integration and erasing submodule's boundaries
> from UI perspective. I think maybe you can work on that first, gain
> experience along the way, and maintain the link-object changes
> separately. Maybe someday you will manage to switch .gitmodules with
> it. Or maybe I'm wrong (partly because I did not read the whole
> thread)

Yes, there is some common ground.  But:

1. The inspiration for fixing fundamental design problems comes from
my redesign.  For instance, I would've never discovered the git add
bug if I'd not attempted to git add (as opposed to the unnatural
abstraction that git submodule add presents).

2. I think it is absolutely imperative that we do the redesign now,
before we've descended too far into the madness that the current
design is.  I think I'm capable of doing the redesign now, with some
help and support from the list.  My attitude doesn't align with the
"I'm feeling lazy; why don't we postpone it?" argument.  Let's finish
what I started now: I'm more than willing to dedicate the next few
months full-time towards finishing this and getting it merged.
