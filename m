From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: git annotate runs out of memory
Date: Tue, 11 Dec 2007 12:33:56 -0500
Message-ID: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 18:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J290B-0002J3-PS
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbXLKReF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbXLKReE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:34:04 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:22979 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbXLKReD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:34:03 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1241028nze
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 09:33:57 -0800 (PST)
Received: by 10.143.16.9 with SMTP id t9mr771783wfi.1197394436746;
        Tue, 11 Dec 2007 09:33:56 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 09:33:56 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67890>

On the gcc repository (which is now a 234 meg pack for me), git
annotate ChangeLog takes > 800 meg of memory (I stopped it at about
1.6 gig, since it started swapping my machine).
I assume it will run out of memory.  I stopped it after 2 minutes.

Mercurial, on the same file, takes 50 meg and 30 seconds.


git annotate fold-const.c takes 300 meg of memory and takes > 30 seconds.
Mercurial, on the same file takes 50 meg of memory and 10 seconds.
svn takes 15 seconds and 20 meg of memory.

I have excluded the mmap memory from mmap'ing the pack/file (in
git/mercurial respectively).

Annotate is treasured by gcc developers (this was a key sticking point
in svn conversion).
Having an annotate that is 2x slower and takes 15x memory would not
fly (regardless of how good the results are).

This seems to be a common problem with git. It seems to use a lot of
memory to perform common operations on the gcc repository (even though
it is faster in some cases than hg).

--Dan
