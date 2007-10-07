From: "Gerald (Jerry) Carter" <jerry@samba.org>
Subject: Missing tags from git-clone, but not git-clone -l ?
Date: Sun, 07 Oct 2007 13:23:43 -0500
Message-ID: <4709242F.7070004@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 20:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IebJA-0004O4-5O
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 20:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbXJGS4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 14:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbXJGS4n
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 14:56:43 -0400
Received: from mail.samba.org ([66.70.73.150]:54494 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbXJGS4m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 14:56:42 -0400
X-Greylist: delayed 1974 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Oct 2007 14:56:42 EDT
Received: from kayak.plainjoe.org (68-184-60-223.dhcp.mtgm.al.charter.com [68.184.60.223])
	by lists.samba.org (Postfix) with ESMTP id 1A937162C44
	for <git@vger.kernel.org>; Sun,  7 Oct 2007 18:23:46 +0000 (GMT)
Received: from silk.local (phzzbt.plainjoe.org [192.168.1.1])
	by kayak.plainjoe.org (Postfix) with ESMTP id D6E3E1170BF
	for <git@vger.kernel.org>; Sun,  7 Oct 2007 13:23:45 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60209>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm really a but stumped on this one.  I've got a set of tags
(created by git-svnimport):

  $ git tag -l release-4*
  release-4-0-0tp1
  release-4-0-0tp2
  release-4-0-0tp3
  release-4-0-0tp4

but when I "git-clone samba-svnimport tags-test"", one tag
is missing.

  $ git tag -l release-4*
  release-4-0-0tp2
  release-4-0-0tp3
  release-4-0-0tp4

Running git-clone -l works as expected (i.e. the tp1 tag appears
in the clone).

Here's some more info about the tag in the original svnimport
repo:

$ ls -l .git/refs/tags/
total 0

$ grep release-4 .git/packed-refs
2fbd67786af06b8f5184048d997b660cbd80cbc4 refs/tags/release-4-0-0tp1
a786f423d6dee793418e8c6591f9b962c0fa96bc refs/tags/release-4-0-0tp2
1fea21bffc836a28e3e86e930d3d9fca85590ae6 refs/tags/release-4-0-0tp3
c58417a9934d3c1f04becb542a9fb6334a07f19d refs/tags/release-4-0-0tp4

$ for h in `grep release-4 .git/packed-refs | awk '{print $1}'`; \
  do git-cat-file -t $h; done
tag
tag
tag
tag

Any suggestions on how to debug this?   Am I just misunderstanding
something about tags?




cheers, jerry
=====================================================================
Samba                                    ------- http://www.samba.org
Centeris                         -----------  http://www.centeris.com
"What man is a man who does not make the world better?"      --Balian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHCSQvIR7qMdg1EfYRAhOIAKDpefcPqyVhPfxTazJhtd/QrmzM8QCgyyQc
e0Br/1PngGmQlGNkME+tY7c=
=+PIn
-----END PGP SIGNATURE-----
