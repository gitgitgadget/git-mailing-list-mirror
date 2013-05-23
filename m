From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 17:46:19 -0500
Message-ID: <CAMP44s3-3gpAAyp-WfDjHxJiotO68GUbb5tHw9Qo35yCTGFNqA@mail.gmail.com>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 00:46:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfeHD-0008A7-6L
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 00:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847Ab3EWWqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 18:46:23 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:57230 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759824Ab3EWWqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 18:46:22 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so4036477lbd.1
        for <git@vger.kernel.org>; Thu, 23 May 2013 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sl2qGfaBEYzzeAFjnSdmV/5NraFKfEJpINz9l/D9jP0=;
        b=khJuzEYP40N9Vcn5WFpLDfnFbHF89TUfPp2xZoxqNDZEqihPeuAwcYa3YdmCl/+go1
         nt0RxIYIYILe7wRQdtOKTOWyHB7xsB9qBeZwyzHfZcryhIHAB8drMBJxozyjUPsvm+N6
         wK0zn1Ed6p0c5jbTnQxG68/z6FVPN0lQYIjEWg/ujgvE6C+43YS8MVHoyZ8msOLSCo7i
         KKFfcrnp8ZMWhLWY1H1QoLYktyR6ZSJmBrr6dr4jmcYbBISe8qiYJmFTw1X2sNE/SAx5
         mpY8Yn2MHd6hekFE0WilTrK2dPW7hYjj21hBqsA1iZuv1ze0RDEA2M5RR9rUR5JxHbpt
         IMtA==
X-Received: by 10.152.2.233 with SMTP id 9mr7559491lax.34.1369349179943; Thu,
 23 May 2013 15:46:19 -0700 (PDT)
Received: by 10.114.174.170 with HTTP; Thu, 23 May 2013 15:46:19 -0700 (PDT)
In-Reply-To: <7vli75cpom.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225311>

On Thu, May 23, 2013 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> This isn't about "swap parents", it's about helping people realise that
>> just "git pull" isn't necessarily the best thing for them to do, and
>> that they may want --rebase.
>>
>> So I was asking if it would be sensible (possibly in Git 2.0) to make
>> git-pull pass --ff-only to git-merge by default.
>
> Unless your primary user base is those who use Git as a deployment
> tool to always follow along the tip of some external repository
> without doing anything on your own on the branch you run your "git
> pull" on, defaulting it to --ff-only does not make much sense to me.

A lot of people do stuff, but the rebase it.

> If the proposal were to make pull.rebase the default at a major
> version bump and force all integrators and other people who are
> happy with how "pull = fetch + merge" (not "fetch + rebase") works
> to say "pull.rebase = false" in their configuration, I think I can
> see why some people may think it makes sense, though.

That makes perfect sense, because the people that are not familiar
with Git more often than not end up making merges by mistake, and the
ones that are familiar with it can easily configure it to do what they
want, or just 'git pull --merge', or 'git fetch'+'git merge' (we
should make merge.defaulttoupstream=true as well).

> But neither is an easy sell, I would imagine.  It is not about
> passing me, but about not hurting users like kernel folks we
> accumulated over 7-8 years.

I've worked in the Linux kernel, and in my experience the vast vast
majority of kernel developers don't do merges; they send patches. It's
only the lieutenants that might do that, and although there are a lot,
they don't surpass the 200, and they most definitely know how to
configure Git to do what they need. And even then, most of them don't
do merges, but create a linear history for Linus to merge.

So the only one who does really rely on merges is Linus, I think he
would have no problems configuring Git.

It is also my experience that most people don't do 'git pull', because
it rarely does what one wants; 'upstream' is still too cumbersome for
most people.

> Also "rebase" of the branch you attempted to push out is sometimes a
> good solution (fixing "just a small change on 'master'" that was
> beaten by somebody else pushing first), but is a bad workaround (you
> had many changes on that branch, which would have been better if
> they were done on a topic branch, but you do not want to merge with
> the upstream because you worked on 'master') some other times, so I
> have this suspicion that 'pull.rebase' is not necessarily a good
> thing to encourage in the first place.

Too bad, that's what most people recommend; 'git fetch'+'git rebase'.
That's the only way newcomers can avoid the ugliness of 'upstream',
and avoid making atrocious merges.

It's silly that the people familiar with Git has to explain this to
each and every newcomer.

-- 
Felipe Contreras
