From: David Miller <davem@davemloft.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 13:06:14 -0700 (PDT)
Message-ID: <20070509.130614.15589957.davem@davemloft.net>
References: <20070509.020916.80034730.davem@davemloft.net>
	<7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed May 09 22:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlsQW-0002Im-Ua
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbXEIUGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbXEIUGP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:06:15 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38930
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754323AbXEIUGO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 16:06:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 20AE9290133;
	Wed,  9 May 2007 13:06:15 -0700 (PDT)
In-Reply-To: <7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46775>

From: Junio C Hamano <junkio@cox.net>
Date: Wed, 09 May 2007 08:41:20 -0700

> There is something very wrong.  "-l -s" should never go to the
> "remote: Generating pack..." codepath.  Is that reproducible?

Every single time on master.kernel.org

> Could you try "sh -x git-clone" it?

Sure:

+ unset CDPATH
+ '[' -n '' ']'
+ quiet=
+ local=no
+ use_local=no
+ local_shared=no
+ unset template
+ no_checkout=
+ upload_pack=
+ bare=
+ reference=
+ origin=
+ origin_override=
+ use_separate_remote=t
+ depth=
+ no_progress=
+ test -t 1
+ case "$#,$1" in
+ bare=yes
+ shift
+ case "$#,$1" in
+ no_checkout=yes
+ shift
+ case "$#,$1" in
+ use_local=yes
+ shift
+ case "$#,$1" in
+ local_shared=yes
+ use_local=yes
+ shift
+ case "$#,$1" in
+ break
+ repo=../torvalds/linux-2.6.git
+ test -n ../torvalds/linux-2.6.git
+ test yes = yes
+ test yes = ''
+ no_checkout=yes
+ use_separate_remote=
+ test -z ''
+ origin=origin
++ get_repo_base ../torvalds/linux-2.6.git
+ base=
+ dir=test-2.6.git
+ '[' -z test-2.6.git ']'
+ '[' -e test-2.6.git ']'
+ mkdir -p test-2.6.git
++ cd test-2.6.git
++ pwd
+ D=/home/davem/git/test-2.6.git
+ trap 'err=$?; cd ..; rm -rf "$D"; exit $err' 0
+ case "$bare" in
+ GIT_DIR=/home/davem/git/test-2.6.git
+ export GIT_DIR
+ git-init
Initialized empty Git repository in /home/davem/git/test-2.6.git/
+ test -n ''
+ rm -f /home/davem/git/test-2.6.git/CLONE_HEAD
+ case "$local,$use_local" in
+ case "$repo" in
+ case "$upload_pack" in
+ git-fetch-pack --all -k ../torvalds/linux-2.6.git
remote: Generating pack...

etc.

Oh, /home/davem/git is a soft symlink to
/pub/scm/linux/kernel/git/davem, maybe that is confusing
git to make it think the repo is not local.
