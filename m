From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: [BUG] filter-branch --parent-filter in bare repository
Date: Fri, 17 Aug 2012 18:27:21 +0200
Message-ID: <2079016.4kHNMXxD8A@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 18:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2POY-0004Ei-Hc
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 18:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758425Ab2HQQ13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 12:27:29 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:34817 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395Ab2HQQ11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 12:27:27 -0400
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTovb1Kn/J/Q==
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E0C65.dip0.t-ipconnect.de [91.62.12.101])
	by smtp.strato.de (joses mo55) (RZmta 30.9 DYNA|AUTH)
	with ESMTPA id y022c2o7HBipZd for <git@vger.kernel.org>;
	Fri, 17 Aug 2012 18:27:24 +0200 (CEST)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id DA3545E0123
	for <git@vger.kernel.org>; Fri, 17 Aug 2012 18:27:21 +0200 (CEST)
User-Agent: KMail/4.9 (Linux/3.2.0-29-generic; KDE/4.9.0; x86_64; ; )
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=unavailable version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203619>

Using git version 1.7.12.rc2.18.g61b472e
(1.7.9 has the same problem)

If I run (directly in the bare repository)

git filter-branch -d ../localrewrite --parent-filter cat

I get this error message on the last line, nothing unusual before:
error: Untracked working tree file 'AUTHORS' would be overwritten by merge.

but if I run (directly in the bare repository)

git filter-branch -d .localrewrite --parent-filter cat

everything works fine. Depending on the path of the temporary directory,
the error may also point to some other file. AUTHORS is in the root directory,
but it is never untracked.

If I do a clone and run the same command in the clone, it also works with any
temp directory.

And this only happens with one specific repository - a KDE game, converted with
svn2git. No other game has this problem. git fsck only finds dangling tags.

The resulting repositories are identical, so I can ignore the error message for now.
But still - why can't I run this in the bare repository? git help filter-branch does not
mention something like that.

You can get the repository here:
http://www.rohdewald.de/oss/tst.tbz



Maybe related:

I run this directly in the bare repository. If the command succeeds, I find
a checkout directly there (everything was clean before), so I have all this
intermixed - IMHO a bug.

branches  description  HEAD  hooks  info  objects  refs
PLUS all directories and files right in there:
AUTHORS                  History.h                ksokobanui.rc        MapDelta.h        PathFinder.cpp
Bookmark.cpp             hooks                    LevelCollection.cpp  Map.h             PathFinder.h
Bookmark.h               HtmlPrinter.cpp          LevelCollection.h    Messages.sh       PlayField.cpp
branches                 HtmlPrinter.h            LevelMap.cpp         ModalLabel.cpp    PlayField.h
CMakeLists.txt           ImageData.cpp            LevelMap.h           ModalLabel.h      Queue.h
config-ksokoban.h.cmake  ImageData.h              levels               Move.cpp          README
data                     images                   main.cpp             Move.h            refs
description              index                    MainWindow.cpp       MoveSequence.cpp  StaticImage.cpp
doc                      info                     MainWindow.h         MoveSequence.h    StaticImage.h
HEAD                     InternalCollections.cpp  Map.cpp              NEWS              TODO
History.cpp              InternalCollections.h    MapDelta.cpp         objects



-- 
Wolfgang
