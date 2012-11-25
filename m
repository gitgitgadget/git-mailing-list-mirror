From: David Lang <david@lang.hm>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 03:51:12 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1211250344360.32333@nftneq.ynat.uz>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com> <50B1F684.5020805@alum.mit.edu> <20121125105707.GA25212@thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 12:52:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcakw-0007JO-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 12:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab2KYLv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 06:51:59 -0500
Received: from mail.lang.hm ([64.81.33.126]:57188 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753117Ab2KYLv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 06:51:58 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id qAPBpoFZ025488;
	Sun, 25 Nov 2012 03:51:50 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20121125105707.GA25212@thyrsus.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210367>

On Sun, 25 Nov 2012, Eric S. Raymond wrote:

> Michael Haggerty <mhagger@alum.mit.edu>:
>> There is, of course, the awkward issue of how/when to transition to
>> Python 3.x, which is *not* backwards compatible with Python 2.x.  I
>> expect that when the time comes there will be volunteers (myself
>> included) willing to help adapt Python scripts to the new version, but
>> the problem shouldn't be minimized.
>
> 2to3 actually does a pretty good job.  It doesn't reduce the
> transition cost to zero, but I find it does reduce that cost to an
> easily manageable level even on quite large codebases.
>
>> It would be insane to rewrite performance-critical C code in any
>> scripting language, but there is a huge penumbra of code that is not
>> performance critical and that mutates rapidly.
>
> Indeed.  In the git architecture there is a pretty clear dividing line -
> to a first approximation, plumbing should remain C but porcelain should
> probably not.  (Not that I am advocating forcing such a move - but it would
> be good to allow it to happen.)
>
> The 80-20 rule (80% of the execution time is spent in 20% of the code)
> helps us here.  The *other* 80% of the code can move to a scripting
> language with no significant performance loss.  To find out what needs
> to stay in C, run a profiler!

Remember that old code is tested code. The mere act of re-writing it from 
scratch is likely to introduce new bugs due to 'simplifications' by the person 
re-writing the code.

If a particular piece of code has a track record of being buggy, this may be 
overwelmed by the fresh start and new attention (plus whatever theoretical 
advantage any particular language provides), but unless it's suspect, re-writing 
it for the sole reason of changing the language is unlikely to be a win.

In addition, a good programmer working in a 'bad' language that they are very 
familiar with is going to write better code than that same programmer would 
write in a 'good' language that they are not familiar with.

I git, the programmers are very familiar with C and Bash, but far less familiar 
with either Perl or Python (although from what I see, far more familiar with 
Perl than Python)

If it's something going into contrib, where the core developers are not needing 
to maintain it, the language it's written in matters far less than if it's 
something that's going to be in the core. If it's in the core, it needs to be in 
a language that the core developers are comforatable with.

You may think that C and Bash are poor choices, but that is what the community 
is familar with.

You are far from the first person to say that git should be re-written (or at 
least large portions of it) in the language-of-the-day, and you won't be the 
last (even, or especially if it does get re-written in Python ;-)

David Lang
