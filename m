From: John Keeping <john@keeping.me.uk>
Subject: Re: ls-files -i & directories
Date: Fri, 31 May 2013 22:20:22 +0100
Message-ID: <20130531212022.GD1072@serenity.lan>
References: <CAO2Twbk5cvEa2uNKMg+n4DFokJ607yRDF0dUeBJkUOAY6BAD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roland Schulz <roland@utk.edu>
X-From: git-owner@vger.kernel.org Fri May 31 23:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiWkX-0000bp-Gy
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 23:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab3EaVUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 17:20:31 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60404 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab3EaVU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 17:20:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A6F6BCDA57E;
	Fri, 31 May 2013 22:20:28 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cijxV+dhfjVN; Fri, 31 May 2013 22:20:27 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D593CCDA59B;
	Fri, 31 May 2013 22:20:24 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAO2Twbk5cvEa2uNKMg+n4DFokJ607yRDF0dUeBJkUOAY6BAD2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226099>

On Fri, May 31, 2013 at 04:22:37PM -0400, Roland Schulz wrote:
> Hi,
> 
> the gitignore rules work so that if a directory is ignored, all files
> in that directory are ignored. While that behavior isn't clearly
> documented in gitignore, this behavior is consistent across all git
> tools (status, ls-files, ...).
> 
> An exception is that listing the ignored files using "ls-files -i"
> doesn't behave the same way.
> 
> example:
> $ mkdir d
> $ touch d/f
> $ echo /d/ > .gitignore
> $ git ls-files -o --exclude-standard
> .gitignore #d/f is correctly not listed
> $ git ls-files -i --exclude-standard
> #no output
> 
> d/f isn't listed even though it is treated as an ignored file by all
> other git tools. That seems inconsistent to me. Is that behavior
> intentionally or is this a bug?

It is listed with "git ls-files -i -o --exclude-standard".  The
documentation says:

   Show only ignored files in the output. When showing files in the
   index, print only those matched by an exclude pattern.  When showing
   "other" files, show only those matched by an exclude pattern.

If you do this then it is shown:

$ git add -f d/f
$ git ls-files -i --exclude-standard
d/f

I think this is working as documented.
