From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 07:32:39 -0500
Message-ID: <525d35e766ad4_55661275e7426@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 14:52:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW47N-0006aG-7e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 14:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758955Ab3JOMwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 08:52:53 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:53402 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990Ab3JOMww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 08:52:52 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so2506181oah.36
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Khf9fWlYOcYOwgRROrMjPTcZyjWno/2zEYIm5edchR4=;
        b=qv7gbFH1qYlL6WQb9qnPJ4qWYI2YbFF7boNRtpG71NtWtU3OZQ9w/XMKs8x020erhf
         WKd/Ke1mtonGR/1WR84i/bnU7dgOxbkdDOde+1JomnVZAHL9JupwrSiGweX76uJrTan5
         E5UV/Ytp28lBz+uFW3JKQa7XVncwTez6TbtOgRDm5Hs941fbEf2A+DCcWuGzTBbPon2y
         pzkAzC1jlLNa5bAw3QAFTqmQh7iz3ugnt74kq/L7RIdUfDxmt7q0HVzw5j+a68fmVA+i
         dWfOhsqHXcLXoHtq50CEclUspm2bVhccf1nsjtn9cj/OZMIsYGwcjqGI8QcoiwusUciW
         y/7Q==
X-Received: by 10.182.98.162 with SMTP id ej2mr1823108obb.61.1381841572067;
        Tue, 15 Oct 2013 05:52:52 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id m7sm10707407obo.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 05:52:51 -0700 (PDT)
In-Reply-To: <20131015123505.GA3097@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236181>

Krzysztof Mazur wrote:
> On Mon, Oct 14, 2013 at 04:35:50PM -0500, Felipe Contreras wrote:
> > Krzysztof Mazur wrote:
> > > On Sat, Oct 12, 2013 at 02:04:45AM -0500, Felipe Contreras wrote:
> > > > So that we can specify general modes of operation, specifically, add the
> > > > 'next' mode, which makes Git pre v2.0 behave as Git v2.0.
> > > > 
> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > ---
> > > 
> > > I don't think that single option it's a good idea. From the user's
> > > point of view I think that the way push.default was introduced and
> > > will be changed is much better. So maybe it's better to just add
> > > "core.addremove" option instead?
> > 
> > Maybe, but what happens when we start doing changes for v3.0? As a user, I
> > don't and to figure out which are the new configurations that will turn v3.0
> > behavior on, I just want to be testing that mode, even if I'm not following Git
> > development closely. If I find something annoying with core.mode = next, I
> > report the problem to the mailing list, which is good, we want to know problems
> > with the backward-incompatible changes that will be introduced before it's too
> > late, don't we?
> 
> But with core.mode = next after upgrade you may experience incompatible
> change without any warning.

Yes, and that is actually what the user wants. I mean, why would the user set
core.mode=next, if the user doesn't want to experencie incompatible changes? A
user that sets this mode is expecting incompatible changes, and will be willing
to test them, and report back if there's any problem with them.

> I think it's better to keep the old behavior by default and warn the user if
> with new behavior the result might be different. So the user:
> 
> 	a) knows about the change
> 
> 	b) may set appropriate option to enable the new default or keep
> 	   the old behavior and disable the warning
> 
> 	c) may report that he does not like that change

But that's what we are doing already. Look at the test I wrote, it's testing
the warnings for the current version of Git.

> > I'd be fine with having *both* a fine-tuned option to trigger each specific
> > behavior, and another one that turns all those fine-tuned options on that are
> > meant for v2.0.
> > 
> > Unfortunately, I don't see much interest from Git developers in either.
> 
> I think that most users have already set the push.default, so "git add"
> is the only problem. If Junio really wants to change "git add" he should
> be interested in allowing user to use it now.

I agree, but he really wants the change, and proof of that is that the warning
is already there, and every Git release since then has an annoying message
about that at the top.

> I don't see the change in "git add" as an improvement, because
> removing files with "git add" IMHO is more confusing than ignoring
> such files. Maybe introducing new command - "git update" for instance -
> which is equivalent to new "git add" and teaching new users to use it
> instead of "git add" is better.

I agree. At first I simply ignored the changes because I didn't have the
patience to figure out what exactly did they mean. Now I was forced to
understand them to write this patch, and I'm also forcing myself to use this
behavior.

'git add' removing files is counter-intutive, 'git stage' (currently an alias
to 'git add') might make more sense.

But even better would be to use my proposed changes to 'git stage', which add
subcommands, for example:

 * git stage all (git add --all)
 * git stage update (git add --update)

But it doesn't seem that patch is going to be applied by Junio, so most likely
we would have to deal with yet anotyer counter-intuitive behavior in Git.

-- 
Felipe Contreras
