From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: filenames with " b" in them create confusing git diff-tree
 output
Date: Wed, 20 Jun 2007 13:23:12 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706201315310.3593@woody.linux-foundation.org>
References: <18041.3163.329391.298926@cargo.ozlabs.ibm.com>
 <7v4pl2v1lf.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I16iM-0004o7-Sy
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbXFTUXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXFTUXk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:23:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52038 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796AbXFTUXk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 16:23:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5KKNIdU032704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2007 13:23:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5KKNCtq013726;
	Wed, 20 Jun 2007 13:23:12 -0700
In-Reply-To: <7v4pl2v1lf.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, hits=-2.52 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50568>



On Wed, 20 Jun 2007, Junio C Hamano wrote:
> 
> Your example, "a/test b/foo" vs "b/test b/foo", can be and IS
> parsed unambiguously by git-apply (you can try "git apply
> --stat" your example).  IOW, the code to correctly handle it
> already exists ;-)

Well, in all fairness, I *did* hate having to write the code to handle all 
the name handling in git-apply.

Escaping whitespace (or at least giving the _option_ to do so) might well 
be a good way to not have to be as smart as git-apply is.

git-apply didn't have that option, since git-apply has as one primary 
motivation the need to be able to handle patches that come from non-git 
sources, so git-apply goes to quite some extreme lengths to try to make 
sense of an inherently rather ambiguous format (that the git diffs then 
*made* unambiguous, but using pretty subtle rules in order to stay 
compatible).

Some maybe we should have some generic method of asking for any filename 
to be quoted in particular ways?

		Linus
