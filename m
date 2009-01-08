From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Support ref logs for refs/*
Date: Thu, 08 Jan 2009 18:08:57 +0900
Message-ID: <20090108180857.6117@nanako3.lavabit.com>
References: <20090108082827.GA6177@tesla.theory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Neil Macneale <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:11:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqvJ-00051S-Hv
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZAHJKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZAHJKI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:10:08 -0500
Received: from karen.lavabit.com ([72.249.41.33]:46526 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbZAHJKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:10:06 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 5D290C8433;
	Thu,  8 Jan 2009 03:10:05 -0600 (CST)
Received: from 3884.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 3D17HAO4DPZ8; Thu, 08 Jan 2009 03:10:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=nEGZssPCzdi/ktxoIjXbDJmL1v75i7WTuUpLvmhLmex5u6JVCRg2Xkor96NQs/05uO9Uz9uE6KqD6096Ibrzh2KGuPT3K7zaWqqFYU0whL/XnJvWyq+XCLQ2t4ZCtH8bMb9n7BHK1ZUtkzHQldAWT+EDtI5jPVzzX8VqIdU/dFI=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090108082827.GA6177@tesla.theory.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104904>

Quoting Neil Macneale <mac4-git@theory.org>:

> The documentation for git update-ref seems to imply that logging of ref
> updates should be done for anything in refs/...

The documementation for git-update-ref is part of git, and git does not use anything outside of refs/{heads,tags,remotes}/ for its normal operation. 

I think it is generally assumed that there is nothing of interest outside of these areas that deserves the automated creation of reflogs, and the code you are touching is about that. Once you have reflog for any ref you are interested outside of these areas, your actions will be logged regardless. 

Most notably, refs/stash itself is exempt from this code path and it makes sure that reflog exists without relying on log_all_ref_updates configuration. 

Also the documentation for the configuration variable explicitly says it is about the branch heads.

core.logAllRefUpdates::
	Enable the reflog. Updates to a ref <ref> is logged to the file
	"$GIT_DIR/logs/<ref>", by appending the new and old
	SHA1, the date/time and the reason of the update, but
	only when the file exists.  If this configuration
	variable is set to true, missing "$GIT_DIR/logs/<ref>"
	file is automatically created for branch heads.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
