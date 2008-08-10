From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Sun, 10 Aug 2008 01:09:56 -0700
Message-ID: <20080810080956.GB21575@untitled>
References: <1218235313-19480-1-git-send-email-marcus@griep.us> <20080809062521.GA10480@untitled> <489DBB8A.2060207@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS611-00032u-UT
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbYHJIJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYHJIJ5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:09:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59155 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbYHJIJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:09:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 41C682DC01B;
	Sun, 10 Aug 2008 01:09:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <489DBB8A.2060207@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91810>

Marcus Griep <marcus@griep.us> wrote:
> Also, I came up with one more optimization inside 'sub close_file',

Would that be truncating the file immediately after we're done using it?

Previously IO->new_tmpfile would unlink the file immediately after it
got created; so closing the file descriptor immediately after use would
allow the OS it to bypass the actual writeout to disk on an asynchronous
filesystem.

-- 
Eric Wong
