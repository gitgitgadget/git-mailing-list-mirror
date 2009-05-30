From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 16:08:32 -0700
Message-ID: <7v63fiyyrz.fsf@alter.siamese.dyndns.org>
References: <20090530140349.GA25265@unpythonic.net>
	<200905301826.11924.markus.heidelberg@web.de>
	<20090530165306.GA1142@unpythonic.net>
	<780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Epler <jepler@unpythonic.net>, git@vger.kernel.org,
	markus.heidelberg@web.de
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 01:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAXfO-0007Zr-Mb
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 01:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZE3XIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbZE3XIc
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 19:08:32 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59952 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbZE3XIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 19:08:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090530230833.YONO17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 May 2009 19:08:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id xz8Y1b0074aMwMQ03z8Ynk; Sat, 30 May 2009 19:08:32 -0400
X-Authority-Analysis: v=1.0 c=1 a=YxzLv42keDoA:10 a=J_Enn-26-KwA:10
 a=pGLkceISAAAA:8 a=G8IQAnVBEAjxqhdiSnMA:9 a=FvpOlEOPV0V8ABoHPxLez2X2_NsA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <780e0a6b0905301413o2686fe34qaa076209c26c0b55@mail.gmail.com> (Stephen Boyd's message of "Sat\, 30 May 2009 14\:13\:51 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120368>

Stephen Boyd <bebarino@gmail.com> writes:

> You might want to look at using the parse options API. It has options
> for verbose and abbrev builtin, so you don't have to do any extra
> work....

Why do people even think a change like this to a _plumbing_ command is
desirable?

Admittedly, there already is "verbose" option that adds redundant
information to the output of this particular plumbing, which might
arguably be equally wrong as what this patch does, but I think it is
excusable.  At least it lets the Porcelain script that uses the command
avoid calling 'git cat-file commit' to find out the title of the commit.

But --abbrev does not even add any information.  If implemented correctly
(which earlier iteration did not even do), it may not lose information by
choping the output too short to make it ambiguous, but as others pointed
out about using grep in the calling Porcelain to filter (or more likely,
sift the lines into "+" and "-" bins) to shoot down -d/-D options, I do
not see the point of adding --abbrev to this plumbing command very much.
