From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: GIT pull
Date: Thu, 12 Apr 2012 18:58:50 +0200
Message-ID: <4F8709CA.6080102@kdbg.org>
References: <1334242077960-7459655.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: cvalusek <clintv2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 18:58:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SINMJ-0001Y7-6r
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 18:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab2DLQ6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 12:58:54 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:8186 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371Ab2DLQ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 12:58:54 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2B22B10017;
	Thu, 12 Apr 2012 18:55:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 76A2519F458;
	Thu, 12 Apr 2012 18:58:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <1334242077960-7459655.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195346>

Am 12.04.2012 16:47, schrieb cvalusek:
> My team has had a lot of trouble with GIT lately because of aborted pull
> commands.
> 
> If a user has local modifications not on the index and does a pull, I have
> seen git attempt to start applying the merge to master and abort. The whole
> checkout is then left in a terrible state that is nearly unrecoverable. In
> the past, I thought GIT would run some sort of check to identify these
> problems before it attempts the merge.
> 
> Even with a clean state (nothing to commit), I have seen the same thing
> randomly happen at least once.

As others pointed out, this should not happen. That leaves one
possibility: You are on Windows, and you very likely have one or more of

- a virus scanner
- an IDE

running. It can happen that one of these programs happen to look at a
file at the same moment when git is trying to remove or rename the file.
This fails because on Windows a file that is open cannot be removed or
renamed. In this situation, the merge/checkout is aborted in the middle
and leaves a mess behind.

There's not a lot that can be done about it. I thought we have some
counter measures in our compatibility layer (e.g., retry the removal if
the first attempt fails due to permissions), but I have seen this happen
nevertheless. I haven't tried tracking it down because it happens so
rarely for me, and it didn't hurt *too* much so far.

-- Hannes
