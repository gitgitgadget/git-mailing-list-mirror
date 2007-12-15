From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Wrong Git rename detection results
Date: Sat, 15 Dec 2007 22:14:25 +0100
Message-ID: <20071215211425.GA12334@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 22:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3eLa-0003VJ-7E
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 22:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbXLOVOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2007 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbXLOVOd
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 16:14:33 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51862 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705AbXLOVOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 16:14:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 4439B7000CE7
	for <git@vger.kernel.org>; Sat, 15 Dec 2007 22:14:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irAsSI80hZVE for <git@vger.kernel.org>;
	Sat, 15 Dec 2007 22:14:25 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2474F680BF7A; Sat, 15 Dec 2007 22:14:25 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68417>

I have reworked parts of my bcusdk repository in a separate branch
(6d102933f620b81b4a2c09046ec529460bd0c90f), which I merged into master
(9068de13cb408babf4206aa5ee55a7f8094f4ff3).

I'm interessed in the resulting differenced of the merge:
http://repo.or.cz/w/bcusdk.git?a=3Dcommitdiff;h=3D9068de13cb408babf4206=
aa5ee55a7f8094f4ff3;hp=3D6d102933f620b81b4a2c09046ec529460bd0c90f

The output of git is totally absurd. It tells me, that I moved a C
file to a java file with about 70% similarity, many other C files
where copied from one C file with 70% to 80% similarity, misses an
move with new lines added (eibd/client/eibclient-int.h =3D>
eibd/client/c/eibclient-int.h) and so on.

Additionally, it states, that files were moved to unrelated files, eg:

  eibd/client/def/mcprogmodeoff.inc [moved from eibd/client/openvbusmon=
itor.c with 60% similarity]

In this case, eibd/client/mcprogmodeoff.def would have been the
correct logical successor.

With git 1.5.4.rc0.1122.g5512, the rename detection yields to slightly =
different
results, which are also not correct.

I guess, that the problem is triggered by the fact all files
are short and share a common (big) license header.

mfg Martin K=F6gler
PS:
I don't doubt, that the results are technical correct (files have the
printed similarity).
