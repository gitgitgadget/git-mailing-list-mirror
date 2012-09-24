From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 09:19:27 +0200
Message-ID: <5060097F.9050203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:19:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG2xC-00016w-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 09:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2IXHT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 03:19:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55044 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab2IXHT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 03:19:29 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 97B4D2081A
	for <git@vger.kernel.org>; Mon, 24 Sep 2012 03:19:28 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 24 Sep 2012 03:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:content-type:content-transfer-encoding; s=smtpout; bh=D
	8AOfwaOxKEy2Nv2R6nyTBQjpi8=; b=Iyl6Dm80F3UYBlgcqhy4MHoOYd8QF0a+3
	udn95NqAltsrKL3czD49bfL4ovCnKQPCf8mM0gBkFsZRCqVBqikgZRLD6p5q+SQ2
	Rlq3PBeCBDKYLzyvW9X+hHHt9ghFBrhS5q+LD8oEAweuQMKK37iDaq9OyW6UdBNv
	8vOdqAY1Sw=
X-Sasl-enc: H3g5akU68s+/MvhC59g8jLciaVKN1PJaB5UIi+TcqLeC 1348471168
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 351424827AB
	for <git@vger.kernel.org>; Mon, 24 Sep 2012 03:19:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206255>

[mjg@localhost ~]$ GIT_DIR=~/.githome git rev-parse --show-toplevel
/home/mjg

[mjg@localhost ~]$ git --git-dir=~/.githome rev-parse --show-toplevel
fatal: Not a git repository: '~/.githome'

Huh? Ok, so most users probably would not try further and blame git, but:

[mjg@localhost ~]$ git --git-dir=/home/mjg/.githome rev-parse
--show-toplevel
/home/mjg

(All this is with core.worktree set to /home/mjg.)

So, while I do understand that we don't expand '~' in any of these cases
and it's only a matter of bash tilde expansion kicking in or not, we
might want to do something about it. (--git-dir=$HOME/.githome gets
expanded, as well, and --git-dir=.githome works from the appropriate cwd
only).

Michael
