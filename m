From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Git-new-workdir
Date: Wed, 21 May 2008 14:25:37 -0500
Message-ID: <MnNeABMJjOQ8gdG6gY5zubSC3c5X2sDYBwcI1MotmXFvW3kUNXzB5A@cipher.nrlssc.navy.mil>
References: <63BEA5E623E09F4D92233FB12A9F794301FC8B1D@emailmn.mqsoftware.com> <20080521184446.GA23924@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Craig L. Ching" <cching@mqsoftware.com>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Wed May 21 21:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JytxR-0001as-5n
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbYEUTZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYEUTZu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:25:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54496 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbYEUTZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:25:49 -0400
Received: by mail.nrlssc.navy.mil id m4LJPbuD011861; Wed, 21 May 2008 14:25:37 -0500
In-Reply-To: <20080521184446.GA23924@bit.office.eurotux.com>
X-OriginalArrivalTime: 21 May 2008 19:25:37.0539 (UTC) FILETIME=[72BB0D30:01C8BB78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82568>

Luciano Rocha wrote:

> git clone server:/rep ~/master
> git clone -s ~/master build/abc
> git clone -s ~/master build/foo
> ...

Don't do that without first doing

    git config gc.pruneExpire never

to disable pruning loose objects if there is any chance that any will
be created. Better to be safe, and prune manually using the example
in the prune documentation.

> The -s option should reduce disk-usage considerably.

It won't be any less than what git-new-workdir would produce. Actually,
git-new-workdir could provide more space savings since there is only a
single repository so new objects created by development in any of the
new work directories would be available to all others. This is getting
a little nit-picky, basically space usage for the two options is nil.

My take on it...

If you want to have _multiple_different_ branches checked out from the
_same_ repository, and do development in all of them, then git-new-workdir
is the right choice.

If you want to have the _same_branch_ checked out in multiple work
directories, then cloning with -s is what you want. In this case
I assume development will be performed in the original repo, and
the clones will do a pull to update.

Personally, I have found the git-new-workdir script to satisfy any
need which caused me to even think about cloning with -s. I am
hoping the functionality of git-new-workdir will be folded into
git porcelain at some point (ahem J Schindelin).

-brandon
