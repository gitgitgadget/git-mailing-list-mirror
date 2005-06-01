From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Using cvs2git to track an external CVS project
Date: Wed, 01 Jun 2005 14:07:46 +0100
Organization: Computing Service, University of Cambridge, UK
Message-ID: <1117631266.26067.40.camel@imp.csi.cam.ac.uk>
References: <46a038f905060105358e24723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdSy8-0005xq-4D
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 15:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFANLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFANJY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 09:09:24 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:60325 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261278AbVFANIC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 09:08:02 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from imp.csi.cam.ac.uk ([131.111.10.57]:37698)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:465)
	with esmtpsa (LOGIN:aia21) (SSLv3:RC4-MD5:128)
	id 1DdSwk-0005VV-1x (Exim 4.51)
	(return-path <aia21@cam.ac.uk>); Wed, 01 Jun 2005 14:07:46 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905060105358e24723@mail.gmail.com>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-06-02 at 00:35 +1200, Martin Langhoff wrote:
> Following the cvs2git threads, I'm left with a few doubts.
> 
> Linus has stated that it can be used incrementally to track a project
> that uses CVS -- in which case I assume I would be maintaining two git
> repos, one strictly tracking "upstream", pulling changes from CVS on a
> crontab, and the 2nd one with my local changes. Or is it meant to work
> on the "local" repo as a pull/merge/update?
> 
> What'd be the strategy in that case if I am working on patches that I
> intend to feed upstream? To what degree will git try and remerge
> against the local repo where the patch originates from? This kind of
> smarts are nice when they work -- but I am interested in exploring
> more git-style approaches, if git supports this at all.
> 
> In the scenario above, if I push _some_ patches upstream, does git
> help me at all in sorting out what is upstream and what is not?
> 
> I suspect all this patch-based horsetrading amounts to cherry-picking,
> and is therefore not supported. What strategy would work with git to
> run local branches with a mix of patches that go upstream and others
> that don't (or just may take longer to get there).

Disregarding anything about cvs2git there is one point you may not be
thinking about but you may want to care about:  when you send something
upstream to the cvs repository and then get it back via cvs2git you will
get a completely different commit to the one your local git repository
has.  So while the file changes inside those two commits are the same
the actual commits are not and you will end up with all those commits in
duplicate because of it as well as an automatic merge commit to merge
the two commits.  If you don't want that to happen you would need to do
your local changes in throw-away git trees which you rm -rf after the
patch gets applied and you use cvs2git to get your changes.  You could
of course do your local things in git branches and then throw-away the
branch that got applied to cvs and only keep the main trunk in sync but
I personally prefer separate trees to branches.

> Right now we are using arch where a long-lived branch tracks
> theexternal cvs repo, and we open short-lived branches where we do a
> mix of development -- most of which is merged upstream in several
> stages.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

