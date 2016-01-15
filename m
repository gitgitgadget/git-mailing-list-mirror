From: Daniel Egger <daniel@eggers-club.de>
Subject: git worktree bug: paths are being reset to the main repository directory
Date: Fri, 15 Jan 2016 14:23:55 -0600
Message-ID: <FACC48AE-B1A9-4A13-9CC8-889996F3113D@eggers-club.de>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 21:33:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKB40-0002K6-8s
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbcAOUdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:33:36 -0500
Received: from mx2.eggers-club.de ([78.47.14.144]:53503 "EHLO
	mx2.eggers-club.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbcAOUdg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2016 15:33:36 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2016 15:33:35 EST
Received: from mail.eggers-club.de (ipbcc2d6d4.dynamic.kabel-deutschland.de [188.194.214.212])
	by mx2.eggers-club.de (Postfix) with ESMTPA id 49AE53983B9A
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 21:24:10 +0100 (CET)
Received: from [10.77.216.78] (unknown [192.76.80.96])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.eggers-club.de (Postfix) with ESMTPSA id 9A62E501C2
	for <git@vger.kernel.org>; Fri, 15 Jan 2016 21:24:09 +0100 (CET)
X-Mailer: Apple Mail (2.3112)
X-eggers-club-de-MailScanner-ID: 9A62E501C2.A48D2
X-eggers-club-de-MailScanner: Found to be clean
X-eggers-club-de-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-eggers-club-de-MailScanner-From: daniel@eggers-club.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284213>

Hi guys,

doing a git reset --hard in one of the worktrees will reset the path in $GIT_DIR/worktrees/worktree_name/gitdir to .git, so after that point all thusly modified worktrees will look as if they live in current woorktree root.

State before:

# cd /Users/user/Desktop/Source/Product && git worktree list
/Users/user/Desktop/Source/Product          2991e32 [master]
/Users/user/Desktop/Source/Product-2.1      3fc1082 [releases/master-2.1]
/Users/user/Desktop/Source/Product-2.2      3ccc3fe [releases/master-2.2]
/Users/user/Desktop/Source/Product-2.3      4044881 [releases/master-2.3]
/Users/user/Desktop/Source/Product-2.3-S11  4a67d36 [customer/S11]
/Users/user/Desktop/Source/Product-2.2-S22  2d2503a [customer/S22]

# pushd /Users/user/Desktop/Source/Product-2.2; git reset --hard; popd

# git worktree list
/Users/user/Desktop/Source/Product          2991e32 [master]
/Users/user/Desktop/Source/Product-2.1      3fc1082 [releases/master-2.1]
/Users/user/Desktop/Source/Product          3ccc3fe [releases/master-2.2]
/Users/user/Desktop/Source/Product-2.3      4044881 [releases/master-2.3]
/Users/user/Desktop/Source/Product-2.3-S11  4a67d36 [customer/S11]
/Users/user/Desktop/Source/Product-2.3-S33  174575e [customer/S33]
/Users/user/Desktop/Source/Product-2.2-S22  2d2503a [customer/S22]

3ccc3fe is now (incorrectly) claimed to be represented in <pwd>.

Servus,
      Daniel
