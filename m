From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 11:07:51 -0700
Message-ID: <CAPc5daWXdt5TMCxj_zSY6uwz5ndjism6HGbzQ8UxstO79z94OA@mail.gmail.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com> <20140516084126.GB21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 16 20:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMYL-0001p8-V2
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbaEPSIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:08:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60726 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757536AbaEPSIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:08:13 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so2199052lbi.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rm/ZIusYkDIHfkGc1c0yD0bVuBlhJ4+wrT9dq/hdrus=;
        b=yCPjjwiX4QIr1aclpkyzgnOGiTRZ4YFvA/FVBv3bRzFwVIvjNqbr3Nh6gJ9PfZaDKy
         tn8IkfH7ZvB7UY5lpcamH1VkKGsf+OkmVGKH7ASrR6SEW9w0gS5x9Zu4kt9UtG3aYYUA
         M83plBSzWr7dQApWfKnsA56T/jMUZeohTRyGp4RSnuRYyqhP9vJZ3L7lOzdSXkRvFWok
         vfkQabPT6o3hTeEhOmlvcJcCXXgTzMKNsQ1a7qrf3qsZDGSd4k9jG2os9QfsXB2cdvSN
         OTy0o2ZrdcPVG2EjmGhj/eZz9pBcgHnczwg84NCympYCPizXwq63WgXAjTUK4YGfEWNK
         Qf5g==
X-Received: by 10.112.35.202 with SMTP id k10mr12456499lbj.14.1400263691710;
 Fri, 16 May 2014 11:08:11 -0700 (PDT)
Received: by 10.112.17.98 with HTTP; Fri, 16 May 2014 11:07:51 -0700 (PDT)
In-Reply-To: <20140516084126.GB21468@sigill.intra.peff.net>
X-Google-Sender-Auth: iwrNU5szZy2YiPyfQXJFxKR05VU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249401>

(Sorry if you receive a dup; pobox.com seems to be constipated right now).

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2014 at 03:56:29PM -0700, Junio C Hamano wrote:
>
>> Two announcements for their version 0.2 on the list archive are not
>> quite enough to advertise them to their users.
>
> I do not think this README nor a mention in the release notes will get
> their attention either, and many people (and packagers) will continue to
> use the stale versions forever until those versions go away.
>
> I would much rather _replace_ them with a README in the long run, and
> people will notice that they are gone, and then use the README to update
> their install procedure.
>
> For 2.0, I am hesitant to do that, though I do not have a problem with a
> README like this as a heads-up to prepare packagers for the future. I
> say hesitant because people may have been test-packaging 2.0.0-rc3 in
> preparation for release, and it will be annoying to them to suddenly
> switch.

I share the latter two of the above three.  I was giving distro
packagers a bit more credit for their diligence in knowing what they
are packaging than you seem to be in your first point, but I admit
that it is a blind faith.

> But that being said, this is Felipe's code. While we have a legal right
> to distribute it in v2.0, if he would really prefer it out for v2.0, I
> would respect that.

I am fine with that.

> I would prefer to instrument the code with warnings, as that is the sort
> of thing a packager moving from -rc3 to -final might not notice, and
> shipping the warnings to end users who did not package the software in
> the first place will not help them. It is the attention of the packagers
> (and source-builders) you want to get.

I do agree that a new warning every time it is run will be a more
likely to grab users' attention.  The conclusion I draw from that
shared observation is that the user will be annoyed all the time,
without having a power to do anything about the annoyance, until the
report s/he (or other users) Throw at the packager, even when the
version that was packaged hasn't diverged that much yet, which does
not help end users.

I guess the ideal we want is to make sure their build break.  What
if we do the README in addition to rename contrib/remote-helpers to
contrib/obsolete-remote-helpers (or s/obsolete/graduated/)?  It will
give the packagers three choices and I think it hurts people much
less.

 * The packagers that dump the entirety of contrib/ to somewhere
   without doing anything to expose the scripts to user's PATH do
   not have to do anything.  The users who chose to pick them up
   from there notice the missing contrib/remote-helpers, notice
   "obsolete" (or "graduated"), and read README.

 * The packagers that pick up from contrib/remote-helpers and
   arrange the scripts to be on user's PATH will find their build
   broken, because they are no longer where they expect them to be.
   They will notice "obsolete"(or "graduated"), and read README.

   - They can choose to pick them up from "obsolete", perhaps for
     expediency, perhaps for their change aversion, but that will
     not last once we grabbed their attention, and they will switch
     their upstream in some later release once such a choice makes
     them feel dirty enough.

   - They can choose to switch their upstream right now in response
     to the breakage.

I would say that the options I see are these three, and I would rank
the "warn every time" as less helpful to end-users:

 - rename contrib/remote-helpers to contrib/obsolete-remote-helpers
   and add README to point at the upstream.

 - remove contrib/remote-helpers scripts and add README.

 - warn every time the user runs the scripts.

Or am I reacting to a typo and you meant to say "I would prefer not
to instrument"?  Your "shipping the warnings to end users who did
not package the software will not help" was unclear if you meant the
README that has warning or warning message they have to see every
time from the instrumented code.
