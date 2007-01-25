From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] git-fetch: Only fetch in fetch
Date: Wed, 24 Jan 2007 17:13:02 -0800
Message-ID: <7vhcufc3j5.fsf@assigned-by-dhcp.cox.net>
References: <87veiwszpd.fsf@gmail.com>
	<8aa486160701241652x375f0d0eoba1cdf3d14550034@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 02:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9tAu-0001EQ-SU
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 02:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXAYBNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbXAYBNH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 20:13:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61923 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXAYBNG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 20:13:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125011303.DHGA16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 20:13:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FDDM1W00e1kojtg0000000; Wed, 24 Jan 2007 20:13:21 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37698>

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 1/25/07, Santi B=E9jar <sbejar@gmail.com> wrote:
>>    I've tried to separate the fetch and merge logic. At the same tim=
e it
>>    has removed 40 lines of code to the git-*.sh.
>
> Just some words for the basic idea.
>
> git-fetch: fetches the branches from the remote and save this
> information in .git/FETCH_HEAD. In .git/FETCH_REMOTE it save
> additional information, as the remote nick, the remote url, the
> refspec used and the default remote.
>
> git-pull: uses this information to select the branches to merge and
> save them in .git/FETCH_MERGE.

One thing I suspect is problematic is that this would make
fmt-merge-message much less useful after running git-fetch.  You
have to go all the way to git-pull and replace reading from
=46ETCH_HEAD with reading from FETCH_MERGE (just like you had to
do that in git-pull).  In other words, this may break people's
scripts and workflows.

This is probably a good clean-up at the conceptual level.  If
you had done this before v1.0.0 there would have been no
question about its inclusion.

Please discuss this patch post 1.5.0.
