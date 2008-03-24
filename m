From: Logan Kennelly <logank+git@sent.com>
Subject: Effects of alias not changing the directory
Date: Sun, 23 Mar 2008 22:27:44 -0700
Message-ID: <64DCCD62-D432-4076-9CD6-337EEB82FCCE@sent.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 06:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdfEQ-0000pO-00
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 06:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYCXF1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 01:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbYCXF1p
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 01:27:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45005 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbYCXF1o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 01:27:44 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 110D5E0EF1
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 01:27:44 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 24 Mar 2008 01:27:44 -0400
X-Sasl-enc: 4iNnBnr6C0K5tOKGU3H2CwZdXr0xzAubsgfES7Crykfr 1206336463
Received: from [192.168.0.104] (ip68-106-246-146.ph.ph.cox.net [68.106.246.146])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A52561EA27
	for <git@vger.kernel.org>; Mon, 24 Mar 2008 01:27:43 -0400 (EDT)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78004>

At the request of some of my coworkers, I created a wrapper script that
allows them to use a graphical diff tool when they wish. I  
effectively add a
new command through the use of an alias:

  [alias]
   exdiff = "!GIT_EXTERNAL_DIFF=git_exdiff.sh GIT_PAGER=cat git diff"

This command works extremely well when run by itself (`git exdiff`) but
fails when run from a subdirectory and given a relative path because the
alias machinery changes the current directory as demonstrated here:

  [alias]
   echopath = "!echo $PWD"

   $ cd /path/git_tracked/a/b
   $ git echopath
   /path/git_tracked

Is there a reason for this behavior? I'd like to submit a patch, but I'm
concerned that I'm missing something. If it helps, I believe it is the
setup_git_directory_gently logic (called from handle_alias) that  
results in
the chdir.

Thank you.
