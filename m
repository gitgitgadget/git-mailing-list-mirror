From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Using local trees and cogito
Date: Thu, 16 Jun 2005 12:39:07 -0400
Message-ID: <20050616163907.GA26037@delft.aura.cs.cmu.edu>
References: <9e473391050615193719d81951@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 16 18:35:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DixK9-0004nh-Bb
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 18:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVFPQjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 12:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFPQjV
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 12:39:21 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:13229 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261750AbVFPQjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2005 12:39:08 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DixOV-0006rm-00
	for <git@vger.kernel.org>; Thu, 16 Jun 2005 12:39:07 -0400
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e473391050615193719d81951@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2005 at 10:37:59PM -0400, Jon Smirl wrote:
> One problem I did notice is that if you add file in a fork and jump to
> a fork without the file, it doesn't get removed. That's not a big
> problem but it can be confusing.

I noticed the same thing and 'solved' it the following way,

After pointing the head at the new branch, instead of using,

    git-read-tree -m HEAD && checkout-cache -q -f -u -a

I use,

    git-diff-cache -R -p HEAD | git-apply --index

This simple reverse applies the differences between the previously
checked out tree and the branch we just switched to. Ofcourse the
cache/index has to be up to date before we switch between branches.

Jan
