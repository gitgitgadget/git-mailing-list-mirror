From: Travis P <git@castle.fastmail.fm>
Subject: How to handle terminal detection in a daemon calling git?
Date: Wed, 30 May 2012 16:16:47 -0500
Message-ID: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 23:16:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZqGC-0002JO-PC
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 23:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2E3VQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 17:16:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35870 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754301Ab2E3VQr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 May 2012 17:16:47 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3DC5F213AE
	for <git@vger.kernel.org>; Wed, 30 May 2012 17:16:47 -0400 (EDT)
Received: from web5.nyi.mail.srv.osa ([10.202.2.215])
  by compute6.internal (MEProxy); Wed, 30 May 2012 17:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:mime-version
	:content-transfer-encoding:content-type:subject:date; s=smtpout;
	 bh=4060kE8HiGrEWcp/HJemTuaeBCQ=; b=d2EJ72MjZ5N4p8VzbFTgwf2GXeAv
	HAZCPOxrQFUqorEqr1Z9fHNtQtzx/REZegWs78CeAth+bxtuDwxwAxXL9qHcv7n2
	BoWLOWyjEK1v/6sA6+U38qNJCBqKxG9MHadIfwbm03NTKI+3oshNj2x3o82W85d9
	8PN21iAnolgQRac=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 1CB374C11A4; Wed, 30 May 2012 17:16:47 -0400 (EDT)
X-Sasl-Enc: IVf0ZPhY02z3EPpq3RYzaEwY2/hyLMrdbwFTGgNkCrUo 1338412607
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198836>


I've got a script that runs in the background without a terminal.
It actually does have STDOUT and STDERR set to a rotating log file.

When it runs:
  /bin/sh -c 'cd /to/my/wc; git pull --ff-only'
the git command fails (rc 32768).

When it runs
 /bin/sh -c 'cd /to/my/wc; git pull --ff-only > /to/a/file 2>&1'

or even
 /bin/sh -c 'cd /to/my/wc; git pull --ff-only | cat'

then all is well.  The command succeeds (rc 0, and I see the expected
results).

Piping through 'cat' is okay, but I'd rather avoid the 'trick'.  Is
there
some way to communicate to git that it should operate just as if output
were redirected?

-Travis
