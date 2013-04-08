From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 20:29:06 +1000
Message-ID: <CACsJy8CAW1h4rAOK_2+EAFEL28CKeqf4vqROsLByjZaMU3D-ow@mail.gmail.com>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin> <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de> <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408081959.GD20159@elie.Belkin> <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEuU-0003oz-N0
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935362Ab3DHK3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 06:29:38 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45298 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934944Ab3DHK3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 06:29:37 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so5902292oag.6
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4/Nn0LG0yF2NsaFHh178JQ+3TebWjVx0u3WBF6ajekU=;
        b=d5+5bCLIRSkAsjD4mNjwk9FN7mjrucywvLXHfZisrKe96iuW7uV2WdNYKZHuhQY62V
         ht54SkAd8xrNXkP2EEWtMIhgNTaGz/rp1SCFDxXalkyBIX1TFj7ovvhIWfZsUeC1B6a1
         8q74RpZ9GqX7jRCu8vDSKQi7mRLErxycJyEqnwhRaO2BZm0rHwxMeE3eDH5n9ymbU6GT
         qQfkBavwMaxG8da4juvUiODCHB+Z8pE1ahslNS3l6nwt8y6nMiLxKMYUxhhXyaa5IHL7
         TnTP5W5RLQSJqd7vwPm4hvnnrXP1asXM/wHELuC0Gbkh+ANzJr891YIqSbxj7QG2PU2z
         Avzg==
X-Received: by 10.60.34.98 with SMTP id y2mr10021724oei.74.1365416977102; Mon,
 08 Apr 2013 03:29:37 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Mon, 8 Apr 2013 03:29:06 -0700 (PDT)
In-Reply-To: <CALkWK0nz878Xh9BFSCrtBGT=g3fys3uBy7QQs9cdWaFtoS8Rsg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220416>

On Mon, Apr 8, 2013 at 7:08 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jonathan Nieder wrote:
>> What do you think of .gitignore and .gitattributes?  Should they be
>> somewhere other than the filesystem as well?
>
> I would argue that .gitignore and .gitattributes are done right.  They
> are integrated into a very mature part of git-core very well, and
> their nature is fundamentally different from that of .gitmodules.

Probably off-topic, but I'm starting to find ".gitignore can be found
in every directory" a burden to day-to-day git operations. So imo it's
not done right entirely ;-)

> .gitignore and .gitattributes specify extended globs (see: wildmatch)
> rules to apply on the worktree, and can be in multiple places in the
> worktree.  They apply strictly on the current worktree; they have
> nothing to do with the index, and have no interaction with other
> objects in the repository.

Index operations sometimes read these .git{ignore,attributes}. I
believe git-archive reads worktree's .gitattributes, so it's not
really just about worktree.

>> I don't think Jens had any obligation to work on submodules and
>> nothing else for the last five years. ;-)
>
> I know.  What I'm saying is that his current approach is just filled
> with tons of unnecessary complexity, inelegance, and pain.  This is
> evidenced by the fact that the current submodule system is pathetic
> after five years of work (and I don't think the developers working on
> it were particularly incompetent or lazy).

I don't follow this thread closely, but I think there's a common
ground where improvements can benefit both approaches. There are a lot
of problems for deep integration and erasing submodule's boundaries
from UI perspective. I think maybe you can work on that first, gain
experience along the way, and maintain the link-object changes
separately. Maybe someday you will manage to switch .gitmodules with
it. Or maybe I'm wrong (partly because I did not read the whole
thread)
-- 
Duy
