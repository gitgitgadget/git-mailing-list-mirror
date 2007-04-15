From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Sun, 15 Apr 2007 20:51:31 +0100
Message-ID: <200704152051.35639.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com> <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdAlW-0001We-A0
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXDOTvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbXDOTvz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:51:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:27384 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbXDOTvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:51:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so949698uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 12:51:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=px82PKqBSO/tr1KG+sf7aLcAt/WKpFcpizBl2jMcC4IaMDwhzwEap8UPeDTy+RdE+kjzf/bEYnw+8dFtTVpqkHvM3rL7lfPF1Q05JIwP3VheSV3AxOUsYe2XnRsCkPDDiyZ/PTxCHFkZKBEaQDkLY8aZa7MsoDFlKRDoPhiCysk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MVRhe2ZrMbXAE4DfZ7SMTP7/Kwi7j5FZFIgvUhcGw1FkgHXgZlr90F+tkBMy44vUg3DgLMIS2thbqwwz0mOBI+hSWQ4pW8/f87TA3v9qLtxDxBXmZ8RlkQnNcS9W45A9ht75SS8g2zSSB6HZCuseEy4PFkuMgjUDQvMY4SFEAfQ=
Received: by 10.82.136.4 with SMTP id j4mr7090428bud.1176666712868;
        Sun, 15 Apr 2007 12:51:52 -0700 (PDT)
Received: from grissom.local ( [82.0.29.64])
        by mx.google.com with ESMTP id c25sm10642886ika.2007.04.15.12.51.47;
        Sun, 15 Apr 2007 12:51:48 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44507>

On Sunday 2007, April 15, Linus Torvalds wrote:

> Keyword substitution is just *stupid*. It's an inexcusable
> braindamage. Don't do it. It leads to all kinds of idiotic problems
> downstream, and it really doesn't help *anything* except for "but I'm
> used to it". There are absolutely no valid uses for it.

You're right that it can cause problems, but it is certainly not the 
case that there are no valid uses for it.  I've mentioned it before but 
I'll say it again, because it is the only feature I miss from 
subversion and I can't see why it is invalid.

I keep diagrams for a project in SVG format in the repository, this 
works very well because SVG is so nicely ASCII.  In the title block of 
the diagram I put "$Id$", then in subversion, after checking in and 
updating it got expanded to

 $Id: diagram.svg 148 2002-07-28 21:30:43Z andyp $

Now, I print out that diagram and pin it to my wall - sometimes copies 
of it are given to others.  I do this on a regular basis.  The diagram 
is big and complicated and all versions of it look very similar.  In 
short it is very convenient to have the version of the file actually 
printed on the piece of paper.  This is a piece of paper remember, 
there is no way to hash the daigram, or even look at the underlying 
source.  When someone comes to me with a random version of the diagram, 
I can use that ID to checkout exactly the revision that that diagram 
refers to.

Please explain to me why that is not a valid use.

> If you want to tag your files somehow, do it in "git archive" when
> exporting it, but not in the working tree. And realize that once you
> export it with the stupid keyword expansion, diffs etc will all be
> corrupted, and will not - AND MUST NOT - apply to the uncorrupted
> working tree.

All of the problems you describe apply equally to CRLF conversion, and 
yet there seems to be no problem with implementing that.  In fact the 
problem there is significantly worse, as it changes every line of the 
file.

Now, solving the keyword problem is not simple, obviously, but it's 
certainly not impossible.  On git-add the expanded tags get unexpanded 
so $Tag: blah blah blah$ becomes $Tag$; on checkout they get expanded. 
Similarly while calculating diffs - the diff engine unexpands as it 
goes so the lines with the keywords in them are not seen as different 
regardless of the expanded part.

Applying diffs from some external source doesn't corrupt anything - 
because the diff engine is, by definition, going to unexpand the 
keywords when it compares.

So, someone sends you a diff that has this:

- /* $Id: diagram.svg 148 2002-07-28 21:30:43Z andyp $ */
+ /* $Id: diagram.svg 149 2002-07-29 20:32:47Z andyp $ */

And you apply it to the working tree - well, that line will be seen as 
this by the diff engine:

- /* $Id$ */
+ /* $Id$ */

No change.  Obviously this is entirely optional and would be activated 
on a per-file basis.  For git it would be even more useful because of 
all the information actually available.  I'd love to have git-keywords 
like these:

 $Commit: 2bfe3cec92be4f5e3bfc0e71ed560df4a726c07b$
 $Object: b1bd9e46c2bd64e00b671ff5ed512d9c12b53309$
 $Describe: v1.5.1.1-83-g2bfe3ce$
 $Id: cache.h v1.5.1.1-83-g2bfe3ce $

Feelings seem very strong about this; I've seen comments again and again 
about how braindamaged it is and I just can't see it - please, help me 
see - what is it that is so utterly broken about it?  I can see that it 
adds a complication to many parts, but I can't see why it is seen as so 
evil.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
