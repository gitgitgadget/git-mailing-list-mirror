From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 11:50:08 -0800
Message-ID: <7vbqjwo6xb.fsf@assigned-by-dhcp.cox.net>
References: <17875.25882.784307.731860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 20:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHQ99-0004fG-RO
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXBNTuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbXBNTuM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:50:12 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62589 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515AbXBNTuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:50:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214195010.JIVX21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:50:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PXq91W0041kojtg0000000; Wed, 14 Feb 2007 14:50:09 -0500
In-Reply-To: <17875.25882.784307.731860@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 13:38:02 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39735>

Bill Lear <rael@zopyra.com> writes:

> I have not yet figured this one out: I have not tagged anything, but
> know that I checked in something lame sometime between now and two days
> ago.  How do I get my working repo to be that as it was, say, yesterday?
>
> Do I do:
>
> % git log --since="2 days ago"
>
> parse, the output for the commit I want, and then do
>
> % git reset <SHA>
>
> or would I do
>
> % git reset --soft <SHA>
>
> or something else?

Do you mean you have something like this:

 ---o---o---o---o---o---*---o---o HEAD
        ^               ^  
     two days           lame
     ago

and want to revert the lame one, or do you mean


 ---o---o---o---o---o---*---*---* HEAD
        ^               ^   ^   ^
     two days           lame
     ago

all are lame after certain point and want to discard all of
them?

If the latter, probably "reset --hard <first-lame-one>^" (i.e.
the parent of the first lame one) is what you want.

If the former, you may want to "git revert <lame>" or "git
rebase --onto <lame>^ <lame>".
