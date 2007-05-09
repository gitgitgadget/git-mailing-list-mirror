From: "Dana How" <danahow@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Wed, 9 May 2007 09:33:40 -0700
Message-ID: <56b7f5510705090933t261e414es9e3cc63b28b60546@mail.gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	 <vpqbqgxak1i.fsf@bauges.imag.fr>
	 <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
	 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
	 <20070509134151.GT4489@pasky.or.cz>
	 <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Martin Langhoff" <martin.langhoff@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 09 18:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlp6q-0003JV-PG
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbXEIQdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbXEIQdo
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:33:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:16410 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbXEIQdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:33:43 -0400
Received: by wr-out-0506.google.com with SMTP id 76so282116wra
        for <git@vger.kernel.org>; Wed, 09 May 2007 09:33:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d8qo3d1o7y3CcpNHuKta0iJd3EIsxn09gW5VTG5MaOotRA3JDMUIDHZEyWck2rS7704rGNN7ExA8eXO2VZr80w2A7Ld8wutk0bqgZFtLvvkPPzY2BJczUeJs84niqMQ1A3sI6m+9/UQKCJRQpsoyr+Ol9XgiHILHmqx17dI48sA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JApYXS9sHQeikJHndhaBpwfMFAqObEu2SvpfoegNBzuLpPtQDLjnai28iF+KhNaDn24G1Z7ayDvdROg6DH4NPQ3sCHRu5qy2kx0ZJkSH11uadbruCAAqoOwvqQ2rANXpbTuRbiB+0YMUr73bqYSZtjXFJnaIvJc2mByWbxy+kU4=
Received: by 10.114.108.15 with SMTP id g15mr247294wac.1178728420983;
        Wed, 09 May 2007 09:33:40 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 9 May 2007 09:33:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705090825090.4062@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46746>

On 5/9/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  - I just switch back to my starting point (and now I'm usually on
>    "master"), and do
>
>         git diff -R target > diff
>
>    to create a diff of my current tree (which is initially the starting
>    point) to the good result.
>
>  - I actually edit the "diff" file by hand, and edit it down to the part I
>    actually want to commit as the first in the series. And then I just do
>    a "git-apply diff" to actually apply that part to my working tree.
>
>  - I then edit any missing parts in the actual working tree (for example,
>    if there were mixed hunks that I want to get to in later commits, and I
>    edited out above, or that I need to partially undo), to do any
>    finishing touches.
>
>  - I now have a tree I can compile and test, and has the "first part" of
>    the journey towards the final "target" state. If compiling/testing
>    shows that I missed something, I can still fix things, and/or go back
>    to doing another "git diff -R target" to see if I missed something).
>
>  - I commit that first case, and repeat the sequence from step 2 (and
>    at every step, the "diff" file ends up shrinking and shrinking).

Geez,  this is similar [in nature, not scale] to what I've been doing.
After reading about people "right-clicking on hunks in git-gui",
I was convinced I needed to force myself to do more manipulations
inside git itself.  Hmm...

Maybe, in addition to [or in] the User Manual, git should have some
workflow examples, which have been cribbed from various emails
on this list?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
