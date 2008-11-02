From: "Tomi Pakarinen" <tomi.pakarinen@gmail.com>
Subject: Re: git-cvsimport BUG: some commits are completely out of phase (but cvsps sees them all right)
Date: Mon, 3 Nov 2008 00:21:44 +0200
Message-ID: <f299b4f30811021421w2ef43792l7514ab3a0506077a@mail.gmail.com>
References: <200811022203.41092.fg@one2team.net>
Reply-To: tomi.pakarinen@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Francis Galiegue" <fg@one2team.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 23:23:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwlLX-0001Xm-9q
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 23:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYKBWVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 17:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYKBWVq
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 17:21:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:52157 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbYKBWVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 17:21:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1251962wah.21
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 14:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=67uPWl/cX9kaS70c6723WK5YEOCFwkcEKOFsBR6y77I=;
        b=l+K3yT1DUTZlJ7upBdP0GZYkMCenTWlCJA1HoMX2BlknAa5aYYzzyk650WKXsWxl4O
         V/2Y1fjXyoKBwElqm5Uf0Mrst6aW5QeCfChDSNJBEXcTNWGHcv1HTdZUagUy1RHYTpHy
         iuBESuChuPjuYdj/LF6K/fsdVD1qP3CIQQrH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eb4rChdwtt3THvG4c1YznxwOj93jpafN8cLc17PmkM8kQOjmhRBrrdmScrT2uuL+FC
         m8IbJJOPurMO8Jn7B6LbtYZ45eh00oBxTvmMmWIwjRXJVLqjh1HBnALVAGI/15xYAyWG
         wnj61GzCoNFm+j296VgN2+eUJsAYg9CrqGhHM=
Received: by 10.114.73.1 with SMTP id v1mr12217334waa.110.1225664504346;
        Sun, 02 Nov 2008 14:21:44 -0800 (PST)
Received: by 10.115.91.4 with HTTP; Sun, 2 Nov 2008 14:21:44 -0800 (PST)
In-Reply-To: <200811022203.41092.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99881>

CVS's branch does not appear on cvsps's output, until you do a commit
to it. git-cvsimport
relies on cvsps and can not do much about this...

Last problem may arise, if you try to do incremental imports from cvs to git.
For incremental imports you must start import from same location in
cvs each time.
If you have made first import from beginning of history, sequent
imports must start
from there too. Otherwise cvsps will renumber patch sets.

  Tomi.



On Sun, Nov 2, 2008 at 11:03 PM, Francis Galiegue <fg@one2team.net> wrote:
> Maybe it's due to the other bug that I reported with git-cvsimport a few days
> ago: namely, it does NOT see branches created by CVS with no commits in them
> (ie, create the branch and that's it, don't touch anything).
>
> The problem is very serious, since it seems to trigger another bug which
> prevents git-cvsimport from working at all. cvsps DOES see the commit
> correctly (branc exists for this file at 1.47.6):
>
> ---
> Members:
>
> src/java/com/one2team/database/bean/impl/relation/reporting/Register.java:1.47->1.47.6.1
> ---
>
> But on the imported git repository, the diff is rather 1.60 -> 1.47.6.1! As a
> result, the repository is plain unusable.
>
> As to the first problem, git finds 6 branches, cvs log finds 8 for the same
> module. git finds 22 tags, cvs log finds 29!
>
> --
> fge
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
