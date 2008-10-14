From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [BUG?] git remote rm repo nukes local refs for mirror repo
Date: Tue, 14 Oct 2008 11:05:31 +0200
Message-ID: <48F460DB.9030209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 11:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpfro-0002MR-RM
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 11:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbYJNJFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 05:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbYJNJFo
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 05:05:44 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40703 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754446AbYJNJFn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2008 05:05:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B84EE17A8BD
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 05:05:42 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 14 Oct 2008 05:05:42 -0400
X-Sasl-enc: BUVBSc86ALL5ChKZId3o+vK04adye3HTakoWj9V/9IAT 1223975142
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4DA762A0B3
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 05:05:42 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98175>

I just noticed the hard way that "git remote rm repo" nukes all local
(mirrored) refs if repo had been setup with "git remote add --mirror
repo url".
Some may argue that this behaviour fits the description "deletes all
remote tracking branches" but I would claim it does not: mirrored
branches are not remote tracking branches in the proper sense.

So:
- Is this behaviour intended?
- If yes, how else would I remove a remote mirror configuration without
destroying a local repo? git config, I know, but that can't be the way.

Michael

Technical:
remote_find_tracking() in remote.c returns "branch" as the remote
tracking branch of "branch" (itself) in a mirror setup. Is this the
right thing to do?
