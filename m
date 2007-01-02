From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] fail pull/merge early in the middle of conflicted merge
Date: Tue, 02 Jan 2007 11:35:36 -0800
Message-ID: <7vmz51usqf.fsf@assigned-by-dhcp.cox.net>
References: <7vwt478b5d.fsf@assigned-by-dhcp.cox.net>
	<20070101204354.GA26687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 20:36:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pQW-0002N0-9m
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbXABTfn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbXABTfn
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:35:43 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36144 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964964AbXABTfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:35:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102193537.GMZV29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jan 2007 14:35:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6Kap1W00t1kojtg0000000; Tue, 02 Jan 2007 14:34:50 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35807>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> After a pull that results in a conflicted merge, a new user
>> often tries another "git pull" in desperation.  When the index
>> is unmerged, merge backends correctly bail out without touching
>> either index nor the working tree, so this does not make the
>> wound any worse.
>
> I've seen this many times too.  I don't understand why users cannot
> read output messages and realize the current command failed, but
> they don't.  *sigh*

That is not user's fault.  Tools should not make things worse
when run more than once after they failed, and we do not either,
so it is not a stupid behaviour on the user's part to do that.

We just need to make sure that it is more clear to the user that
pull after a conflicted pull is futile, which is what this patch
does.
