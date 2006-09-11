From: Junio C Hamano <junkio@cox.net>
Subject: Re: Start handling references internally as a sorted in-memory list
Date: Mon, 11 Sep 2006 16:57:37 -0700
Message-ID: <7vsliyez2m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
	<Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 12 01:57:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMve6-00085o-31
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWIKX4r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWIKX4q
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:56:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32664 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965187AbWIKX4p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 19:56:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911235644.GYHU12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 19:56:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MBwa1V00c1kojtg0000000
	Mon, 11 Sep 2006 19:56:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 11 Sep 2006 16:37:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26870>

Linus Torvalds <torvalds@osdl.org> writes:

> This also adds some very rudimentary support for the notion of packed
> And yeah, I know that the "sorting" code is O(n**2) thanks to doing an 
> insertion sort into a simple linked list. Tough. I didn't care enough to 
> do it well. With "n" usually being a few hundred at most, we really don't 
> care, and if we ever do, we _can_ fix it later on to use a heap or 
> something.

I thought what triggered the restructuring of this part was N
actually being large enough to cause pain to some people, so I
suspect later might need to be reasonably soon ;-).

> +static const char *parse_ref_line(char *line, unsigned char *sha1)
> +{
> +	/*
> +	 * 42: the answer to everything.
> +	 *
> +	 * In this case, it happens to be the answer to
>...

Rof,l.

I've been wondering what happens if you pack "refs/heads/foo",
delete it, and create "refs/heads/foo/bar" with your proposal.
I'll find the answer (which is _not_ "42") in the updated
do_for_each_ref(), I guess.
