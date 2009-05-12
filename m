From: Alexander Gladysh <agladysh@gmail.com>
Subject: Git-SVN memory error
Date: Tue, 12 May 2009 21:04:56 +0400
Message-ID: <c6c947f60905121004v257e6f72m2a24de12c98dd1ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:05:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vPf-00049x-Ff
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbZELRE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZELRE5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 13:04:57 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:4426 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZELRE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 13:04:56 -0400
Received: by ey-out-2122.google.com with SMTP id 9so47845eyd.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=o1sxJDmXW3cgyJ+qQyZNkatHpe0Xy58wNOcOxA4a9eo=;
        b=fH8Z17ZjDeD9Cb9oTGnU244vzi5337w0dUJXPpb+FBmCw4z/FZ/HNplLcCj8P+H4cE
         0ohW+6/OKuze6fFyUnK+FllRF8/iixTEHMlhIoNEqzQMHXMl6LMWe0YVSN1KfM+X3E30
         1OGCgo7KKlLtWdZ+e/Iy6o1vynr285dA/Ue10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=LJ9OIjLY6l0vaFbT94NiR2PtCc8JPteNZ9ov86FTYPMs6Tp7XKbInLn+kG1Rd3BcFJ
         sJ0FxIlgKegRPnfBN89qwhSXnedYVymewPi3Y8LVRPjJfa7YKZvjCj05xL4+cdPkSWXG
         nVIVBiCBAHTRQPk46Tx/3b8Gyn4zov0hw0wv8=
Received: by 10.216.15.85 with SMTP id e63mr4067321wee.199.1242147896381; Tue, 
	12 May 2009 10:04:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118930>

Hi, list!

I'm importing a rather large SVN repository into Git. I'm doing it on
a Synology DS508 NAS PPC box (don't ask me why :-) ). I'm getting an
out of memory error when trying to import one of commits. Please help
me to debug/workaround it.

Relevant system information below.

Alexander.

DiskStation> uname -a
Linux DiskStation 2.6.24 #839 Wed Mar 25 18:30:32 CST 2009 ppc GNU/Linux

DiskStation> git --version
git version 1.6.3

DiskStation> sudo ipkg info git
Package: git
Version: 1.6.3-1
Depends: zlib, openssl, libcurl, diffutils, rcs, expat
Suggests: git-manpages
Status: install user installed
Section: net
Architecture: powerpc
maintainer: NSLU2 Linux <nslu2-linux@yahoogroups.com>
MD5Sum: b92688e018f23fa7a82a504d073fe813
Size: 5872996
Filename: git_1.6.3-1_powerpc.ipk
Source: http://www.kernel.org/pub/software/scm/git/git-1.6.3.tar.gz
Description: GIT is a directory tree content manager that can be used
for distributed revision control.

DiskStation> free # That is actually AFTER git svn died.
              total         used         free       shared      buffers
Mem:       516172       501828        14344            0        62656
Swap:      2586456        29508      2556948
Total:      3102628       531336      2571292

DiskStation> git svn fetch # This is the second run. First one failed
with the same message.
Index mismatch: ba0c6593571c2f4b6b6ceff1b1326b30d0cd9495 !=
c633473cfe3dd92e536450e48cd1d9cb2da1cdd2
rereading fe4935bc22756ffdb430f94cd7ce4af898750edb

	A	File1.rar
        ...
	A	FileN.rar
fatal: Out of memory, malloc failed
hash-object -w --stdin-paths: command returned error: 128

error closing pipe: Bad file descriptor at /opt/libexec/git-core/git-svn line 0
error closing pipe: Bad file descriptor at /opt/libexec/git-core/git-svn line 0
