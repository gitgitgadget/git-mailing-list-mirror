From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH 0/3] fixup remaining cvsimport tests
Date: Sun, 20 Jan 2013 14:17:02 -0600
Message-ID: <CAEUsAPaw8EUcZFbODDj9Z-=3Ppd1CC=jvYDvuyntFkX_3V0ynQ@mail.gmail.com>
References: <1357878439-27500-1-git-send-email-chris@rorvick.com>
	<20130120125838.GK31172@serenity.lan>
	<CAEUsAPZKd+mw2iK7nd6rTtB8N+B99ud19FkuSx0HVitNxrxxZA@mail.gmail.com>
	<20130120152857.GM31172@serenity.lan>
	<7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:17:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1Kh-00084Z-J4
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab3ATURF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:17:05 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61402 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3ATURE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 15:17:04 -0500
Received: by mail-lb0-f177.google.com with SMTP id gm6so1755085lbb.22
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/TvL+xMzcnCbUNNjR2X/OCnmEhk6ueSgc30bu5pP40Y=;
        b=E/S6CD/NmaSUP9pJHAsPpy7gL/iDL9+NY/xecVJCGVIrxn4oBJ2L8qdw2bvS9syXgy
         LgS6W9xV8oULp9rm9SEVJ85Vp+5KSrYJiKLv4rV5twL2URKhECzPgxSDKBFzJ+ddy2W+
         zgG8kSn51pNVFSoXEPTrg18s5JRcGk2xPflNea8yc4ewnEczcenZkUzrT5zozXXjYq9s
         KBO5ulkyBVWrQBX/AYSgmvYhjz6I0Jwsx/OfpC002dWYy35bs3CbYU5FSDGcsStb5DBe
         O7EWj01/XxjI+3YRlbL3Yj3wpvebsmXf0EMbr4zloyjT2KTeWL+6PjtG24yRldyZ8/tq
         AekA==
X-Received: by 10.152.108.172 with SMTP id hl12mr15124074lab.32.1358713022474;
 Sun, 20 Jan 2013 12:17:02 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Sun, 20 Jan 2013 12:17:02 -0800 (PST)
In-Reply-To: <7vsj5vlm1d.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: GPx0MDujoSAV_ejdxI3CPLY82MM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214044>

On Sun, Jan 20, 2013 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> On Sun, Jan 20, 2013 at 09:22:03AM -0600, Chris Rorvick wrote:
>>> On Sun, Jan 20, 2013 at 6:58 AM, John Keeping <john@keeping.me.uk> wrote:
>>>> On Thu, Jan 10, 2013 at 10:27:16PM -0600, Chris Rorvick wrote:
>>>>> These patchs apply on top of of Eric Raymond's cvsimport patch.  7 of 15
>>>>> tests in t9600 fail, one of which is fixed w/ a cvsps patch I've sent
>>>>> to Eric (fixes revision map.)
>>>>
>>>> Did you post the fix for the revision map publicly anywhere?
>>>
>>> It's in Eric's repo and included in version 3.8:
>>>
>>> https://gitorious.org/cvsps/cvsps/commit/abe81e1775a8959291f629029513d1b7160bbde6
>>
>> Thanks.  For some reason I thought the fix would be to
>> git-cvsimport-3.py.  Obviously I should have read more carefully.
>>
>> Sorry for the noise.
>
> This is not a noise, though.
>
> Chris, how would we want to proceed?  I'd prefer at some point to
> see cvsimport-3 to be in sync when the one patched and tested in
> Eric's repository is proven enough.  Will Eric be the gatekeeper, or
> will you be sending patches this way as well?

I probably won't be sending any more patches on this.  My hope was to
get cvsimport-3 (w/ cvsps as the engine) in a state such that one
could transition from the previous version seamlessly.  But the break
in t9605 has convinced me this is not worth the effort--even in this
trivial case cvsps is broken.  The fuzzing logic aggregates commits
into patch sets that have timestamps within a specified window and
otherwise matching attributes.  This aggregation causes file-level
commit timestamps to be lost and we are left with a single timestamp
for the patch set: the minimum for all contained CVS commits.  When
all commits have been processed, the patch sets are ordered
chronologically and printed.

The problem is that is that a CVS commit is rolled into a patch set
regardless of whether the patch set's timestamp falls within the
adjacent CVS file-level commits.  Even worse, since the patch set
timestamp changes as subsequent commits are added (i.e., it's always
picking the earliest) it is potentially indeterminate at the time a
commit is added.  The result is that file revisions can be reordered
in resulting Git import (see t9605.)  I spent some time last week
trying to solve this but I coudln't think of anything that wasn't a
substantial re-work of the code.

I have never used cvs2git, but I suspect Eric's efforts in making it a
potential backend for cvsimport are a better use of time.

Chris
