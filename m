From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Fri, 24 Jun 2005 10:05:55 +0100
Message-ID: <tnxd5qc6s5o.fsf@arm.com>
References: <tnxy899zzu7.fsf@arm.com> <20050623175848.1cf41a52.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 11:01:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlk3W-0004ii-09
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 11:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVFXJHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 05:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbVFXJHF
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 05:07:05 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:32683 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262975AbVFXJGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 05:06:31 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5O9606i013094;
	Fri, 24 Jun 2005 10:06:00 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA16233;
	Fri, 24 Jun 2005 10:06:27 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 24 Jun 2005 10:06:10 +0100
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050623175848.1cf41a52.pj@sgi.com> (Paul Jackson's message of
 "Thu, 23 Jun 2005 17:58:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 24 Jun 2005 09:06:10.0355 (UTC) FILETIME=[F6AA5830:01C5789B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Paul,

Thanks for trying it. As a note, for the moment you should try the
latest daily snapshot since it contains less bugs than the main
(alpha) releases.

Paul Jackson <pj@sgi.com> wrote:
>  1) "Unknown" is misspelled as "Unkown" in a couple places.

Thanks.

>     Before invoking an editor, it would be a good idea to tell the
>     user you are doing so.  If someone is on a telnet session to
>     a system with their $DISPLAY set wrong, they might not even
>     get the terse "16" clue that I got, that they are editing
>     something.

Done.

>     I'd recommend ignoring the exit status of externally invoked
>     editors.

OK, fixed.

>  4) I tried rerunning that "stg init" without further ado, and it
>     failed again (due to the incomplete init above, no doubt), with:
>
[...]
> 	AttributeError: 'NoneType' object has no attribute
> 	'startswith'

The problem here is that the .git/HEAD link is not valid if init
failed. I will fix it for the tonight's snapshot.

>  5) I tried again, doing:
>
> 	rm -fr .git
> 	stg init
> 	# on the commit message edit - just quit 'q', to avoid any error exit
>
>     This failed again, leaving my new git tree in god only knows what bogus state.
>     It failed with:
>
> 	stg init: Commit message not modified

I can remove this condition for init only. The problem is that if it
no longer exists on an non-zero editor exit status, it should at least
check whether the commit message was modified.

>     Try generating fewer fatal errors, and try giving a tiny clue
>     what state (ok or not or how bad) one is left in after an
>     apparently fatal error, and for extra credit, a clue what to do
>     next.

I will try to add as much as information as possible. I initially
wanted to get something working and be able to push/pop patches. I
haven't tried the init command with different editors etc.

>  6) Ok - got through the init that time.

Good.

> Since I am fond of both quilt and Python, and since I need to be
> using git and/or cogito,
> I will poke around some more with this - it's promising.

Great. Pushing/popping works fine at the moment with my kernel tree
(but with less than 10 patches on the stack). It even detected when
the patches I submitted were merged upstream.

The next thing on my plan a log command. I would like to be able to
preserve the history of a patch but this probably won't be available
in an upstream tree pulling from yours.

> I see something about a patch emailer on the todo list -- you're
> welcome to make use of my patch emailer (I use with quilt, though
> it's not tightly bound to quilt) at:
>
>   http://www.speakeasy.org/~pj99/sgi/sendpatchset

Thanks. I will try to include this in a future version.

-- 
Catalin

