From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Submodules and GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Tue, 30 Sep 2014 15:25:13 +0200
Message-ID: <878ul19r5y.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vokac Michal <michal.vokac@comap.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 21:51:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ3SK-0003Lh-Ej
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 21:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbaI3TvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 15:51:22 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:53111 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbaI3TvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 15:51:21 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Sep 2014 15:51:21 EDT
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 8B0635CCEFE;
	Tue, 30 Sep 2014 21:42:37 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id IOsSJknLP2LI; Tue, 30 Sep 2014 21:42:33 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id EBE683CFEA1;
	Tue, 30 Sep 2014 21:42:32 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojka@merica.cz>)
	id 1XYxQX-00037s-4x; Tue, 30 Sep 2014 15:25:13 +0200
User-Agent: Notmuch/0.18.1+101~g56b0ff0 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257678>

Hi list,

I'd like to shorten the time needed by our continuous integration (CI)
tool to clone the source repositories. Currently the full clone takes
about 10 minutes (even from local server). Our main repository has
several submodules so the CI tool runs "git submodule update --init". My
idea was to use GIT_ALTERNATE_OBJECT_DIRECTORIES to cache objects from
several submodule repositories locally. However, this does not work
because GIT_ALTERNATE_OBJECT_DIRECTORIES is considered local to the
super-project and is not propagated to the "git clone" for submodules
(git-submodule.sh calls clear_local_git_env).

My question is why is GIT_ALTERNATE_OBJECT_DIRECTORIES considered local
to the repository? If I could modify the command-line I would use the
"git submodule update" with the --reference option, which is propagated
to clones of all submodules. Letting GIT_ALTERNATE_OBJECT_DIRECTORIES
propagate to the submodules should have the same effect as --reference
option. So why it is not propagated?

Thanks,
-Michal
