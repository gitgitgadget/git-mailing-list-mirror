From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Narrow clone implementation difficulty estimate
Date: Thu, 14 May 2009 03:39:49 -0700 (PDT)
Message-ID: <m38wl0klxt.fsf@localhost.localdomain>
References: <200905141404.30695.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Asger Ottar Alstrup <asger@ottaralstrup.dk>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 12:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4YM3-0007fU-IY
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 12:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbZENKjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 06:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZENKju
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 06:39:50 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:22620 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZENKjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 06:39:49 -0400
Received: by wa-out-1112.google.com with SMTP id j5so464124wah.21
        for <git@vger.kernel.org>; Thu, 14 May 2009 03:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=oWYLOIK9K5biBY86l6VANpIhHBN2wkYkHmn3+eTWcF4=;
        b=merT4kWOKFsbNXF2TZJjA+vUZi893M6rNnFKLyxrpsow/znrduW9Qdpjsu5pbH4y29
         UcKpLKYbbBj+M3NvmTmCwCJ3KC78Y6cBoI59j3nGL1CSWNKbHx5CvlrmpEt0n0W9QxHM
         djZCtZbhy90GXLJWK/AmK+Xwy13tQCip+xx4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LcVkczFhQ9QBDBnLGXhxvB1+Wh3DH4SBz25Dzw2bzo9DTYvAAb7Y5aE2Ljl0xm32sN
         hiNCzvDf/RiCYn1PWUo7/5q+1CQ7iRmvyF5GDWNQlIXvy+EkDKo6BzJ8MvTZnXHYBqI/
         KfQgON00RIr0XYk5Urx+SSzwwQ41IT3k2Qpns=
Received: by 10.114.192.3 with SMTP id p3mr1884499waf.25.1242297590172;
        Thu, 14 May 2009 03:39:50 -0700 (PDT)
Received: from localhost.localdomain (abvo12.neoplus.adsl.tpnet.pl [83.8.212.12])
        by mx.google.com with ESMTPS id m26sm2678218pof.14.2009.05.14.03.39.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 03:39:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4EAdhOS025328;
	Thu, 14 May 2009 12:39:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4EAdgFm025325;
	Thu, 14 May 2009 12:39:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200905141404.30695.angavrilov@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119180>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> We are considering using Git to manage a large set of mostly binary
> files (large images, pdf files, open-office documents, etc). The
> amount of data is such that it is infeasible to force every user
> to download all of it, so it is necessary to implement a partial
> retrieval scheme.
> 
> In particular, we need to decide whether it is better to invest
> effort into implementing Narrow Clone, or partitioning and
> reorganizing the data set into submodules (the latter may prove
> to be almost impossible for this data set). We will most likely
> develop a new, very simplified GUI for non-technical users,
> so the details of both possible approaches will be hidden
> under the hood.

First, there were quite complete, although as far as I know newer
accepted into git, work on narrow / sparse / subtree / partial
*checkout*.  IIRC the general idea about extening or (ab)using
assume-unchanged mechanism was accepted, but the problem was in the
user interface details (I think that porcelain part was quite well
accepted, except hesitation whether to use/extend existing flag, or
create new for the purpose of narrow checkout).  You can search
archive for that
  http://article.gmane.org/gmane.comp.version-control.git/89900
  http://article.gmane.org/gmane.comp.version-control.git/90016
  http://article.gmane.org/gmane.comp.version-control.git/77046
  http://article.gmane.org/gmane.comp.version-control.git/50256
  ...
should give you some idea what to search for. This is of course
only part of solution.

Second, there was an idea to use new "replace" mechanism for this
(currently in 'pu' only, I think, merged as 'cc/replace' branch).
This mechanism was created for better bisecting with non-bisectable
commits, and is meant to be transferable extension of 'graft'
mechanism. The "replace" mechanism allows to replace also blob objects
(contents of filename), so you can have two repositories: baseline
repository with stub files in place of large binary files, and
extended repository with replacement in and replacement blobs in
object database with 'proper' (and large) contents of those binary
files. But that is just an idea, without implementation.

Third, there was work (a year ago, perhaps?) by Dana How on better
support for large objects. Some of those got accepted, some
dosn't. You can set maximum size of object in pack, IIRC, and you can
use gitattributes to mark (binary) files that are meant to be not
deltaified. If all of your repositories are on networked filesystem,
you can create separate optimized pack containing only those large
binary files, mark it as "kept" (using *.keep file, see documentation)
to avoid repacking those large binary files, and distributed this pack
either using symlink, or using alternates (keeping only one copy of
this pack, and accessing it via networked filesystem when it is
required).

Fourth, a long thime ago there was send a patch supposedly adding
support for 'lazy' clone, where you download blob objects from remote
repository only as required.  But its was send as a single large
patch, fairly intrusive.  I don't think it got good review, nevermind
being accepted into git.


Some further reading:
* "large(25G) repository in git"
  http://article.gmane.org/gmane.comp.version-control.git/114351
* "Re: Appropriateness of git for digital video production versioning"
  http://article.gmane.org/gmane.comp.version-control.git/107696
* http://git.or.cz/gitwiki/GitTogether08 had some presentation
  about media files in git, and some thread on git mailing list about
  that issue was result (which I didn't bookmark).

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
