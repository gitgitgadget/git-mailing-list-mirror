From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Wed, 27 Sep 2006 12:08:25 -0700
Message-ID: <7vr6xxb00m.fsf@assigned-by-dhcp.cox.net>
References: <451A30E4.50801@freedesktop.org>
	<7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
	<451A6788.5030808@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 21:08:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSeli-0007F2-8i
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 21:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbWI0TI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 15:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030649AbWI0TI1
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 15:08:27 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52401 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030648AbWI0TI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 15:08:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927190826.LWAD22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 15:08:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TX8U1V00P1kojtg0000000
	Wed, 27 Sep 2006 15:08:28 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <451A6788.5030808@shadowen.org> (Andy Whitcroft's message of
	"Wed, 27 Sep 2006 12:59:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27921>

Andy Whitcroft <apw@shadowen.org> writes:

>> You are handling grafts by hand because --pretty=raw is special
>> in that it displays the real parents (although traversal does
>> use grafts).  Maybe it would have helped if we had a --pretty
>> format that is similar to raw but rewrites the parents?
>
> I have wondered recently why grafts are hidden in this way.  I feel they
> are something I want to know is occuring in my history as this history
> is being manipulated.

Just to make sure we are on the same page, only "raw" format
output is special and it is special only on output.  Ancestry
traversal always honors what you have in grafts.

However, you can do:

$ git rev-list --parents --pretty=raw

which would give you "commit $this_commit $its $parents" lines
and "parent $true_parent" lines at the same time.

And they will be inconsistent when you have grafts or path
limiter.  The former honor grafts and path limiter, and the
latter show the true set of parents.
