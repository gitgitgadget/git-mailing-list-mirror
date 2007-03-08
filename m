From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Git building is borked
Date: Thu, 8 Mar 2007 15:07:57 +0000
Message-ID: <C5E8BD06-1404-403B-88D0-F24F386A14AF@cam.ac.uk>
References: <4BBB354C-B000-4EF7-B3FF-7B2A4D6DE538@cam.ac.uk> <F0177878-0A2B-43B0-9838-E032FB3A0A58@cam.ac.uk> <20070308145532.GA30674@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKEK-0006uQ-F3
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbXCHPI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXCHPI0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:08:26 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42074 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbXCHPIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:08:25 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from pcuxsup2.csi.cam.ac.uk ([131.111.10.66]:49810)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:587)
	with esmtpsa (PLAIN:aia21) (TLSv1:AES128-SHA:128)
	id 1HPKDm-0005I4-UD (Exim 4.63)
	(return-path <aia21@cam.ac.uk>); Thu, 08 Mar 2007 15:07:59 +0000
In-Reply-To: <20070308145532.GA30674@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41747>

On 8 Mar 2007, at 14:55, Shawn O. Pearce wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>> But now I put the git-gui mentions back into the Makefile and tried
>> again it still fails.  Looking at it closer it actually requires me
>> to compile within a checked out git tree, i.e. including the .git
>> directory and all its contents!  That seems even weirder than
>> requiring git to be installed in the first place...
>
> What version of Git specifically are you building with?  How did
> you obtain these source files?

On my old workstation (Linux) which has the git git tree on it I  
tarred up the files in the git directory (not including the .git  
directory), then scp-ed the tar ball to my new workstation (OSX),  
untarred it there and tried to build git to boot strap...

> Release tarballs of Git contain a git-gui/credits file that makes
> CREDITS-GEN avoid invoking the not-yet-existing Git.  Building
> git-gui without this file does require not only a working Git
> installation, but also the git-gui object database.  Both of these
> are readily available on a Git hacker's system, and on any system
> that is attempting to create a release tarball.
>
> There are other files included in the release tarballs (version,
> git-gui/version) that are also required to get a correct build when
> you don't have Git installed, or are missing its object database.
> Having these missing does not stop the build process, but it does
> make the output of `git version` and `git gui version` relatively
> useless.
>
> So you need to be bootstrapping from a released *.tar.{gz,bz2},
> which can be found here:
>
>   http://www.kernel.org/pub/software/scm/git/
>
> Sadly, simply downloading the source files from a random gitweb
> doesn't work anymore.  Yes, I know, my fault.  ;-)

Ah, ok.  I did not realize that released tar balls would be different  
to just tarring up the files...

That is fair enough.  In the end I manage to boot strap myself by  
removing the git-gui stuff out of the main Makefile which allowed me  
to do make and sudo make install.  Then I used the newly installed  
git to do a "git clone" of the git repository on kernel.org, then  
build and installed that which gave me git-gui as well.

I then deleted the old git directory I used for boot strapping.

Thanks for the quick response.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
