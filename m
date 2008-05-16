From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 10:44:46 -0400
Message-ID: <32541b130805160744u6afb2018y931993ea342cade6@mail.gmail.com>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
	 <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
	 <alpine.DEB.1.00.0805161457250.30431@racer>
	 <32541b130805160712m24f24c6aw59b54a0f0ace6269@mail.gmail.com>
	 <alpine.DEB.1.00.0805161521510.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "skillzero@gmail.com" <skillzero@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 16:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx1Df-0004nF-V6
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758789AbYEPOpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758732AbYEPOpB
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:45:01 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:37596 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058AbYEPOot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:44:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so733004fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fvijuxpNss8g2O1P81YCXm9UovaZIkwuJlFMEiil58U=;
        b=l6uIf/8rJsWY5Im19cEOnAYhJJRoxqAoaiM5tsUMaprXNG7ElKZOM1036/80Y7H0GEM5S7NHOC9JEzgtAvyRe3GmtIjHxn5VMu+YOm1mW1Em4TMGGEgKwGXU4n8HgugRc17gegYgyw+R7p004P9v/ThyuUKlFNEgEpC0VFP0nEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=auz8lOUCyBYVB4MZhSDEWWH28PS269/9LbsFCngxALTKt0CEHK0tpZ/3uJUca4nsAW6PMDKhsJDF9a/QrGa+qFhUlDiPZb4ChWAvgJ82UyFIS1U2cA5avrTp6akKxVl6XrBm2Lj898S8kiJBwSkMyqiYBXwL3Ze1DVDjeTQ7lKw=
Received: by 10.82.112.3 with SMTP id k3mr516677buc.56.1210949086646;
        Fri, 16 May 2008 07:44:46 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 16 May 2008 07:44:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161521510.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82299>

On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Fri, 16 May 2008, Avery Pennarun wrote:
>  > But with submodules, that common case looks more
>  > like this:
>  >    cd sub
>  >    git checkout -b manual_branchname_because_there_was_no_default
>  >    git commit -a
>  >    git push etc.
>  >    cd ..
>  >    git commit -a
>  >    git push etc.
>
> Funny, for me it looks completely different:
>
>  $ cd sub
>  # work, work, work
>  # from time to time commit
>  # from time to time rebase -i to clean up some things
>  # test, test, test
>  # sometimes push
>
>  And then, every once in a while, it is
>
>  $ cd ..
>  $ git add submodule
>  $ git commit -s submodule
>  $ git push

Indeed.  I think you and I use submodules for very different purposes.
 The important case for me is that I often add a function to a library
(submodule), then *immediately* move on to use that function in an
application (supermodule).  When I commit the new submodule gitlink,
there are almost always other source code changes in the supermodule
at the same time.  And then I want to share the new application with
my co-workers shortly thereafter, often several times per day.

It looks like your own work on submodules tends to be quite isolated
from the supermodule, which would make sense if you use submodules for
(say) bundling a bunch of separate applications together.

>  > That's *really* tedious, and the number of commands multiplies when you
>  > have more than one submodule going at once.
>
> But hey, if you find that tedious, why did I not see a patch from you yet,
>  implementing "git submodule commit-n-push"?

Well, I think someone already submitted some "git submodule recursive" stuff.

I don't mean to complain.  I think the existing git-submodule code
gives all the raw materials necessary to solve all my
submodule-related problems, whatever those problems may be.  I'd much
rather have tedious-but-flexible instead of quick-but-inflexible.
However, having such powerful tools means it takes longer to figure
out how to use them most effectively.

Don't worry, I'll be the first to submit an all-singing all-dancing
shell script as soon as I figure out what that looks like.  Err,
unless someone else submits it first.  I guess that should cover all
my bases :)

(And now... I'm going to disappear for at least a week for vacation.  Bye!)

Have fun,

Avery
