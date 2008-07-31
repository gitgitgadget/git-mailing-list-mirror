From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Git vs Monotone
Date: Thu, 31 Jul 2008 20:13:59 +0200
Message-ID: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOcgC-0003fx-A3
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYGaSOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbYGaSOE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:14:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:33267 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbYGaSOC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:14:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so410001ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=PI+w8c72uM4YjnWpJ1nsnfAczjGssEjY0QI2jMpgYQE=;
        b=sP7HEJ4Pl3gW6HtbjLGMj4pyz/+qpS6pyOONlSlz6+4LmRcjhIXM0wVCD0+1TDKb5K
         zivxJunK4EaW0n2hlwBwBnCLg1yExyOD1GGIjoKqKfC3Oc/l5VgePhRdovw5z4pQDeNf
         7vYEQiSvT6Rq/gPqXI43IakD84UcXKr6pAxCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=O5UatKa6tHDfCh8M/AbCeem3aPY+MP81wfbjDOidfYR7AtP8EfmFLH6CO2DygTFo1G
         vL1y0qxJnoXy8Q7D7HdUaCvlTPvkKYRdAjAwK7zkrz30Mfq9mTLCL9tw0rqjC+99RnvL
         6Cf2J28E2+TyMBnKLO+mFDsOv65JmKQ0xcHwg=
Received: by 10.142.239.13 with SMTP id m13mr3369898wfh.298.1217528039819;
        Thu, 31 Jul 2008 11:13:59 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Thu, 31 Jul 2008 11:13:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90955>

Heya,

I just read this blog post [0] in which one of the Pidgin devs sheds
his light on their 'tool choice'. In the post he mentions the
following figures:

"I don't mind the database, myself. I have 11 working copies
(checkouts) from my single pidgin database (8 distinct branches, plus
duplicates of the last three branches I worked on or tested with).
Each clean checkout (that is, a checkout prior to running autogen.sh
and building) is approximately 61 MB. If this were SVN, each working
copy would be approximately 122 MB due to svn keeping a pristine copy
of every file to facilitate 'svn diff' and 'svn revert' without
needing to contact the server the working copy was pulled from. Now,
let's add that up. For SVN, I would have 11 times 122 MB, or 1342 MB,
just in working copies. For monotone, I have 11 times 61 MB for the
working copies (671 MB), plus 229 MB for the database, for a grand
total of 900 MB. For me, this is an excellent bargain, as I save 442
MB of disk space thanks to the monotone model. For another compelling
comparison that's sure to ruffle a few feathers, let's compare to git.
If I clone the git mirror of our monotone repository, I find a
checkout size of 148 MB after git-repack--running git-gc also
increased the size by 2 MB, but I'll stick with the initial checkout
size for fairness. If I multiply this by my 11 checkouts, I will have
1628 MB. This is even more compelling for me, as I now save 728 MB of
disk space with monotone."

I'm in the process of cloning the repo myself, and will check if doing
a more aggressive (high --window and --depth values) repack will get
us below that 148, but I'm thinking it's just that big a repo. Anyway,
it seems git is getting screwed over in this post because he is not
taking advantage of git's object-database-sharing capabilities. Am i
right in thinking that with git-new-workdir we would end up at
61*11+148 = 819MB? (Which would actually put us below monotone by
80MB.) Not that I care much whether monotone or git is smaller in disk
size, I'm just curious if we indeed offer this capability? Perhaps
someone with more knowledge of git-new-workdir could shed a light?

[0] http://theflamingbanker.blogspot.com/2008/07/holy-war-of-tool-choice.html

--
Cheers,

Sverre Rabbelier
