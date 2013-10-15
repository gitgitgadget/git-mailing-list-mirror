From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 12:59:48 -0400
Message-ID: <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
	<20131014205908.GA17089@shrek.podlesie.net>
	<525c63b6711fa_197a905e845b@nysa.notmuch>
	<20131015123505.GA3097@shrek.podlesie.net>
	<525d35e766ad4_55661275e7426@nysa.notmuch>
	<20131015133327.GA22723@shrek.podlesie.net>
	<525d4354a5436_5844e73e843d@nysa.notmuch>
	<20131015145139.GA3977@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 18:59:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW7yM-0003Kf-NW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 18:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028Ab3JOQ7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 12:59:50 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:37881 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228Ab3JOQ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 12:59:50 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so7920360wgh.27
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 09:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Odm8B5RZRrR9GmIDqbm8LA3BAYYzEb66Hgdvn6aI3Xc=;
        b=GuEwePmjFd7Ufik126WhVmBZJo3/TisG1+0CrbxO03G31h6EaluEt58Qh/5GNQ6DNR
         JS4KrqNosKY/+yZb3BkWjF6hXBpliq0Zay/EvENAw+uiQKfg7qIjwSPmgNZ1pQZa1ZkN
         SzEDkPkk+HbJ2CYfBgdW1OiqdqzpHym+ypbbKrhKWpWz5Y6Jqz2sZ3KF6Ak3qwP1fWXi
         +1c5R2XQ2hrEEa4Xnreo3D2KxvN99BYIVk2gAnlZhbbumorvadPenF6tqT8uWXuXowX1
         i0h7oFF9/+eXBIWoYRNlOMcOLaP/+c3sThGy0OhXdT/G7nfAHwPN0dHHM7lCwZjjvTe5
         97HA==
X-Received: by 10.181.12.104 with SMTP id ep8mr20407136wid.54.1381856389017;
 Tue, 15 Oct 2013 09:59:49 -0700 (PDT)
Received: by 10.180.99.169 with HTTP; Tue, 15 Oct 2013 09:59:48 -0700 (PDT)
In-Reply-To: <20131015145139.GA3977@shrek.podlesie.net>
X-Google-Sender-Auth: P61XBI26G4OJrviWITY1rqtOfYc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236188>

On Tue, Oct 15, 2013 at 10:51 AM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
> On Tue, Oct 15, 2013 at 08:29:56AM -0500, Felipe Contreras wrote:
>> Krzysztof Mazur wrote:
>> > On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
>> > > Krzysztof Mazur wrote:
>> > > >
>> > > > But with core.mode = next after upgrade you may experience incompatible
>> > > > change without any warning.
>> > >
>> > > Yes, and that is actually what the user wants. I mean, why would the user set
>> > > core.mode=next, if the user doesn't want to experencie incompatible changes? A
>> > > user that sets this mode is expecting incompatible changes, and will be willing
>> > > to test them, and report back if there's any problem with them.
>> >
>> > With your patch, because it's the only way to have 'git add' v2.0.
>>
>> Yeah, but that's not what I'm suggesting. I suggested to have *both* a
>> fined-tunned way to have this behavior, say core.addremove = true, and a way to
>> enable *all* v2.0 behaviors (core.mode = next).
>
> I'm just not sure if a lot of users would use core.mode=next, because
> of possible different behavior without any warning. Maybe we should also
> add core.mode=next-warn that changes defaults like next but keeps warnings
> enabled until the user accepts that change by setting appropriate
> config option? That's safer than next (at least for interactive use) and
> maybe more users would use that, but I don't think that's worth adding.

I like the idea that we could kick git into a mode that applies the
behaviors we're talking about having in 2.0, but I'm concerned about
one aspect of it.  Not having these behaviors until 2.0 hits means
we're free to renege on our decisions in favor of something better, or
to pull out a bad idea.  But once we insert this knob, I don't know
that we have the same ability.  Once people realize it's there and
start using it, it gets harder to back out.  I guess we could maintain
the stance that "the features are not concrete yet," or something like
that, but I think people would still get upset if something changes
out from under them.

So, at the end of the day, I'm just not sure it's worthwhile to have.

-John
