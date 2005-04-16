From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: space compression (again)
Date: Sat, 16 Apr 2005 11:11:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504161101470.29343@cag.csail.mit.edu>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org>
 <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504151210590.7211@ppc970.osdl.org> <20050416143905.GA10370@macavity>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:07:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMotS-0003do-R4
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbVDPPLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVDPPLO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:11:14 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:40600 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262679AbVDPPLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:11:12 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMowv-0007pf-00; Sat, 16 Apr 2005 11:11:09 -0400
To: Martin Uecker <muecker@gmx.de>
In-Reply-To: <20050416143905.GA10370@macavity>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Martin Uecker wrote:

> The right thing (TM) is to switch from SHA1 of compressed
> content for the complete monolithic file to a merkle hash tree
> of the uncompressed content. This would make the hash
> independent of the actual storage method (chunked or not).

It would certainly be nice to change to a hash of the uncompressed 
content, rather than a hash of the compressed content, but it's not 
strictly necessary, since files are fetched all at once: there's not 'read 
subrange' operation on blobs.

I assume 'merkle hash tree' is talking about:
   http://www.open-content.net/specs/draft-jchapweske-thex-02.html
..which is very interesting, but not quite what I was thinking.
The merkle hash approach seems to require fixed chunk boundaries.
The rsync approach does not use fixed chunk boundaries; this is necessary 
to ensure good storage reuse for the expected case (ie; inserting a single 
line at the start or in the middle of the file, which changes all the 
chunk boundaries).

Further, in the absence of subrange reads on blobs, it's not entirely 
clear what using a merkle hash would buy you.
  --scott

WASHTUB supercomputer security Mk 48 justice ODUNIT radar COBRA JANE 
SSBN 731 BATF KUJUMP SECANT operation class struggle SYNCARP KGB ODACID
                          ( http://cscott.net/ )
