From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Mon, 6 Jan 2014 19:42:45 -0500
Message-ID: <CAEBDL5W+3zRb1c51N2JfTR2acwvrUi8TpOw-DkjUn_r114mhAA@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CAEBDL5UaS2Hd-Yb417W+Fw_7j1+5sRAgszko-PbU7z901_X+cw@mail.gmail.com>
	<20140106204203.GI3881@google.com>
	<CAEBDL5VD9C8DXFUS9VawxZhAC0AnR=abV-FEVTdi25NVBPvDVg@mail.gmail.com>
	<CALkWK0mQJcFw45uWz08h+gzn6rTdVOdHkUtU3oRTyQ00LbtcbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 01:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Kkt-0000g0-ME
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 01:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055AbaAGAmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 19:42:47 -0500
Received: from mail-we0-f171.google.com ([74.125.82.171]:39231 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620AbaAGAmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 19:42:46 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so16231585wes.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 16:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9vFnKSr3lFV11WiwLLUCROYvQTN+39eJOyCwVmiBs3E=;
        b=aRnaPHSAGg8NXUIJ5VmwGR6z4RTbKcsaU/TLGTs//ZS9/N3OqHIkwSRWoct3VtFI7K
         2crbymIMEyi6Jhw4FzQscMS7udQo4zHgyW8tK+JbDVRj49cBCuNtLMVLP86jUXACgiU/
         95ZrJ6PUQ0x9co7wI/aSxUGyaF+Tscz6DwdtRwV2/S1bHLRF32up5fdltz8VSX2e18su
         zX4uM0LkPXSDMCy+5xEuriaDpQDEdQjWwA1zaeZTAp0b+MT8atYRAkb0uLW74wFcZzf6
         fTYyeZDhBtAfS8Clo0imME9l9NjGG1QJlZK0feTUQzxdAF9lFQRd5HIJmnBJustNbffy
         mBOQ==
X-Received: by 10.180.21.166 with SMTP id w6mr4261431wie.31.1389055365417;
 Mon, 06 Jan 2014 16:42:45 -0800 (PST)
Received: by 10.180.74.232 with HTTP; Mon, 6 Jan 2014 16:42:45 -0800 (PST)
In-Reply-To: <CALkWK0mQJcFw45uWz08h+gzn6rTdVOdHkUtU3oRTyQ00LbtcbA@mail.gmail.com>
X-Google-Sender-Auth: lDHDMFdbtmgdOEeRs040yadtnRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240090>

On Mon, Jan 6, 2014 at 5:54 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> John Szakmeister wrote:
>> Then where does it get pushed?  Do you always specify where to save your work?
>>
>> FWIW, I think the idea of treating @{u} as the eventual recipient of
>> your changes is good, but then it seems like Git is lacking the
>> "publish my changes to this other branch" concept.
>>
>> Am I missing something?  If there is something other than @{u} to
>> represent this latter concept, I think `git push` should default to
>> that instead.  But, at least with my current knowledge, that doesn't
>> exist--without explicitly saying so--or treating @{u} as that branch.
>> If there's a better way to do this, I'd love to hear it!
>
> That's why we invented remote.pushdefault and branch.*.pushremote. When you say
>
>   $ git push
>
> it automatically goes to the right remote instead of going to the
> place you fetched from. You can read up on how push.default interacts
> with this setting too, although I always recommend push.default =
> current.

This was the piece that I was missing.  I remember when
remote.pushdefault was added, but questioned its usefulness because it
just changes the remote that a branch is pushed to, not necessarily
the name.  I somehow missed the 'current' option for 'push.default'...
which is surprising since I seem to spend an incredible amount of time
looking at the git-config man page.  I guess it's not a good idea to
set 'push.default' to 'upstream' in this triangle workflow then,
otherwise the branch name being pushed to will be 'branch.*.merge'.
Is that correct?  I just want to make sure I understand what's
happening here.

Given this new found knowledge, I'm not sure it makes sense for `git
status` to show me the status against the upstream vs. the publish
location.  The latter makes a little more sense to me, though I see
the usefulness of either one.

Thanks for taking the time to explain this.  I'm going to have to
spend some more time with this configuration and see what the sticking
points are.

-John
