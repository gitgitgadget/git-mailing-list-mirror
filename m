From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-checkout changes the index but not the checked out files?
Date: Tue, 24 Apr 2007 08:16:11 +1200
Message-ID: <46a038f90704231316r3a94c46cl8e1dd2a9dbccbea@mail.gmail.com>
References: <46a038f90704221625k216864cdwb2b35bc035fac7e9@mail.gmail.com>
	 <7virbokmx1.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90704221717i8e5c1bkff066dcbdb0a0523@mail.gmail.com>
	 <7vabx0kk4z.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90704221745h1bf2955cyfb40f6e8c08a336d@mail.gmail.com>
	 <alpine.LFD.0.98.0704230747110.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4xM-0007us-54
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 22:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXDWUQN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 16:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXDWUQN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 16:16:13 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:2875 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbXDWUQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 16:16:12 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1688180wra
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 13:16:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EFff2ZAz+HTSo738xhVHBh0hvql0ek2NmaJvzxdWvxa2B5T9BFMOsCWwuUQPoFeOC064czy3Z7o5Wtjxv501fZR9VOOcJjo7lWwbFgZy5+8/GvKlCbfz4fKebeOaUBsMjc/622Q+Cyx7Qs9YdQgFhxPvFOtGmFzfXG2UxW/GuMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5iXMTersd1Sxpatixz3Z6KDiagqEY7B3i7vL5W6sAkCqXAU7CBD6LTPIXLpcnCbGu2TdLkuppiVKJQbM7kJVzNdEYcX2HoGHZaCCJqjr4qIVzlbWspKG8io271xxYTb/g3m+RdE2D5ulcXESSMYmsE/qbTQJcyCed36XmKnWHY=
Received: by 10.90.66.9 with SMTP id o9mr5377752aga.1177359371243;
        Mon, 23 Apr 2007 13:16:11 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Mon, 23 Apr 2007 13:16:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704230747110.9964@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45359>

On 4/24/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 23 Apr 2007, Martin Langhoff wrote:
> > The _really_ strange bit is that it was attempting to merge 2 heads of
> > the same name. It'd probably be something to block...
>
> No, "git-read-tree -m A B" is not a "merge" in the sense you're thinking,
> it's a "fast-forward merge", ie just a "move from A to B"
...
> So when we move from one head to another, we do that two-way thing. And if
> A and B are the same, doesn't really do anything, but there's also no
> point to try to avoid doing it.

Yup - except that the logic in git-commit wasn't expecting this at
all, so it never said "fast-forwarding" and most importantly, it
changed the index, and the checked out files, but didn't update the
head it was aiming for.

There is definitely a bug when heads are ambiguous. Will try and find
some time to fix it up in the coming days but I'm quite cornered with
work here so if anyone wants to have a look at it...

cheers,


martin
