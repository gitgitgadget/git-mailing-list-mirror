From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: how to reorder commits
Date: Mon, 20 Jul 2009 17:27:25 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907201717570.2147@iabervon.org>
References: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 23:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MT0OX-0006iW-Dv
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 23:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbZGTV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 17:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752537AbZGTV12
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 17:27:28 -0400
Received: from iabervon.org ([66.92.72.58]:53843 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbZGTV11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 17:27:27 -0400
Received: (qmail 26519 invoked by uid 1000); 20 Jul 2009 21:27:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jul 2009 21:27:25 -0000
In-Reply-To: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123636>

On Mon, 20 Jul 2009, Rustom Mody wrote:

> I have a sequence of commits. I tried to reorder the top two in this way.
> $ git rebase -i HEAD^^
> 
> flip the two pick lines and exit vi
> 
> I find my file full of conflict markers.
> So what is the way of doing:
> HEAD becomes current HEAD^
> HEAD^ becomes current HEAD
> without having to handle conflicts ??

Note that what you're asking for here would add both changes in HEAD^ and 
*remove* some changes in HEAD (to get to the state where only the change 
that was made first has been made).

What you tried with rebase is correct, but if your changes in those 
commits intersect, impossible to do automatically:

Original:

 This is an example.

Change 1:

-This is an example.
+This is a better example.

Change 2:

-This is a better example.
+This is a better sentence.

Now, make change 2 without change 1. Even if you can split the changes as
(1) "an"->"a better"; (2) "example"->"sentence", you get:

 This is an sentence.

When the correct version would be:

 This is a sentence.

But there's no automated way to know this, so you get conflict markers.

	-Daniel
*This .sig left intentionally blank*
