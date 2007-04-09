From: Junio C Hamano <junkio@cox.net>
Subject: Re: incorporating the past
Date: Mon, 09 Apr 2007 12:59:10 -0700
Message-ID: <7vejmtz5dd.fsf@assigned-by-dhcp.cox.net>
References: <87d52d1kli.fsf@mid.thomas-huehn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas =?utf-8?Q?H=C3=BChn?= <newsgroups@thomas-huehn.de>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb01c-0002oY-4U
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbXDIT7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbXDIT7O
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:59:14 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52703 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965109AbXDIT7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 15:59:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409195910.UPCV373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 15:59:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l7zA1W00s1kojtg0000000; Mon, 09 Apr 2007 15:59:11 -0400
In-Reply-To: <87d52d1kli.fsf@mid.thomas-huehn.de> (Thomas =?utf-8?Q?H?=
 =?utf-8?Q?=C3=BChn's?= message of
	"Mon, 09 Apr 2007 20:14:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44081>

Thomas H=C3=BChn <newsgroups@thomas-huehn.de> writes:

> Can I just do another git init for 0.1, commit the changes up to 1.0 =
and
> merge those two histories? Don't I need a common ancestor for both or
> something like that?
>
> Or can I do the same, only up to 0.9 instead of 1.0, and then "sew
> together" those histories?

Yes. you can "graft" two distinct histories together.

You already have v1.0..v1.6 history.  You create v0.1..v0.9
history the same way, perhaps in a separate repository.

Then, you tell git to pretend that the v1.0, which in reality
does not have any parent (i.e. "git cat-file commit v1.0" does
not have any "parent" line), has one parent that is v0.9, by
creating a file .git/info/grafts.  The file should list two
commit object names (v1.0 first and then v0.9) separated with a
single SP and then terminated with a single LF.  Each line of
this file says "this commit (the first one on the line) has the
following parents (the rest)".
