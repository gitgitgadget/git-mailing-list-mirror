From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 11:37:35 +1200
Message-ID: <46a038f90606091637o6a0194d5yb413237253a372fc@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
	 <Pine.LNX.4.64.0606091331170.5498@g5.osdl.org>
	 <9e4733910606091356w391b4fdao23db5b2ce3c3e282@mail.gmail.com>
	 <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 01:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoqXs-00015A-CO
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 01:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWFIXhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWFIXhh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 19:37:37 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:60896 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030370AbWFIXhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 19:37:36 -0400
Received: by wr-out-0506.google.com with SMTP id i20so773029wra
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 16:37:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R93yEsuMJeaHfgZwaqmrdZN7VuJ6lJxSE+xv/7yshvWRz08bNHR/f8/Hl974rBzqxOOZ3YZjrXDK617jeqH6boxtS76cbnfqzAzjsDk0zTK2E+OItYBZaoZBCUMpzmRakPOrLqh21q8EWb8BNRzrjxUWV0NPS30+QTyoAJsWJKo=
Received: by 10.54.77.15 with SMTP id z15mr2115943wra;
        Fri, 09 Jun 2006 16:37:34 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Fri, 9 Jun 2006 16:37:35 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091450180.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21568>

Apologies, I dropped out of the conversation -- Friday night drinks
(NZ timezone) took over ;-)

Now, back on track...

On 6/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
> In the meantime, the fact that git-cvsimport can be done incrementally
> means that once we have the silly pack-file-mapping details worked out, it
> should be perfectly fine to run the 3-day import just once, and then work
> on it incrementally afterwards without any real problems.

Exactly. The dog at this time is cvsps -- I also remember vague
promises from a list regular of publishing a git repo with cvsps2.1 +
some patches from the list.

In any case, and for the record, my cvsps is 2.1 pristine. It handles
the mozilla repo alright, as long as I give it a lot of RAM. I _think_
it slurped 3GB with the mozilla cvs.

I want to review that cvs2svn importer, probably to steal the test
cases and perhaps some logic to revamp/replace cvsps. The thing is --
we can't just drop/replace cvsimport because it does incrementals, so
continuity and consistency are key. All the CVS imports have to take
some hard decisions when the data is bad -- however it is we fudge it,
we kind of want to fudge it consistently ;-)

> So people like you who want to work on it off-line using a distributed
> system _can_ do so, realistically. Maybe not practically _today_

Other than "don't run repack -a", it's feasible. In fact, that's how I
use git 99% of the time -- to do DSCM stuff on projects that are using
CVS, like Moodle.

>   The poor python/perl guys may write things more
>   quickly, but when they hit a language wall, they hit it.

Flamebait anyone? ;-) It is a different kind of fun -- let's say that
on top of knowing the performance tricks (or, to be more hip: "design
patterns") for the hardware and OS, you also end up learning the
performance tricks of the interpreter/vm/whatever.

> > It would be better to rsync Martins copy, he has a lot more bandwidth.

I'm coming down to the office now to pick up my laptop, and I'll rsync
it out to our git machine (also NZ kernel mirror, bandwidth should be
good). That's one of the things I've discovered with these large
trees: for the initial publish action, I just use rsync or scp.
Perhaps I'm doing it wrong, but git-push doesn't optimise the
'initialise repo', and it take ages (and it this case, it'd probably
OOM).

> So it will take me quite some time to download 2GB+, regardless of how fat
> a pipe the other end has ;)

Right-o. Linus, Jon, can you guys then ping me when you have cloned it
safely so I can take it down again?

cheers,


martin
