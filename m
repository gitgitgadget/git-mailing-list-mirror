From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH/RFC 0/3] Teach mv to move submodules
Date: Wed, 03 Apr 2013 21:54:38 +0200
Message-ID: <515C88FE.9020203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 21:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNTmi-0001hR-RJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 21:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab3DCTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 15:55:24 -0400
Received: from mout.web.de ([212.227.17.12]:64324 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932245Ab3DCTzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 15:55:23 -0400
Received: from [192.168.178.41] ([79.193.80.178]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MZlNu-1U3CIN0F0I-00LA0S; Wed, 03 Apr 2013 21:54:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:CD31ygPC8uzf9NTLJgRhpkuoTDTWYNI5u8W0Oim4v6w
 +9Kr+pd9DX9qnqrVz7mmvQfaunhMLP1bxiwdxwAEypY5Teq2BC
 yRr08g9EmpYFxjZekfQ6pbQkjx03Wi7sN2XMdP8UJnKcon9WCj
 zq7dg94IUTrU7TrB2uQWgrDrcIlUXsmn2L2QRxW1MV1o/kR1Mz
 Lpcv1KfgBs17KmMylbK8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219963>

This is the last topic I intend to finish before preparing the recursive
submodule update. The other prerequisites for that next step are Heiko's
"allow more sources for config values" and "fetch moved submodules
on-demand" topics, which are necessary to populate submodules that were
not present in the currently checked out commit and to have all commits
of moved or currently not present submodules fetched for later checkout
respectively. But these are other threads ...

Let's enable users to move submodules (just as easy as they can already
remove them with current Git with "git rm") by using a plain "git mv".
While using "git submodule update" on a moved submodule cloned by a
coworker will still leave the submodule's work tree lying around at the
old path, that will be fixed by the recursive submodule update (and is
not different from what Git currently does with removed submodules).
Replacing a directory containing files tracked by Git or vice versa is
still not possible, another issue to be fixed by the recursive submodule
update. I tried to CC all parties which showed interest in this topic,
hopefully I didn't forget anyone.

Jens Lehmann (3):
  Teach mv to move submodules together with their work trees
  Teach mv to move submodules using a gitfile
  Teach mv to update the path entry in .gitmodules for moved submodules

 builtin/mv.c  | 126 ++++++++++++++++++++++++++++++++++------------------------
 submodule.c   | 126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h   |   3 ++
 t/t7001-mv.sh |  94 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 297 insertions(+), 52 deletions(-)

-- 
1.8.2.377.g1bdb7d0
