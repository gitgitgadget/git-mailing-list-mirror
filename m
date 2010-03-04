From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/3] Revert "git-svn: always initialize with
	core.autocrlf=false"
Date: Thu, 4 Mar 2010 01:53:50 -0800
Message-ID: <20100304095350.GB12885@dcvr.yhbt.net>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com> <1267647023-2604-3-git-send-email-kusmabite@gmail.com> <40aa078e1003031216l5d164654ta8ff7ea6c8cf2162@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dpotapov@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 04 10:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn7kj-00033M-1J
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 10:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636Ab0CDJxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 04:53:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35873 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab0CDJxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 04:53:50 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D901F4F1;
	Thu,  4 Mar 2010 09:53:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <40aa078e1003031216l5d164654ta8ff7ea6c8cf2162@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141519>

Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Wed, Mar 3, 2010 at 9:10 PM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> > git-svn dcommit uses diff-tree (which does not apply CRLF conversion) to
> > generate SVN commits, so there never were any CRLF conversion issues when
> > commiting in the first place.
> 
> Uhm, this comment is slightly wrong. diff-tree is used to find out if
> there's a change in a file at all. cat_blob(), which in turn uses "git
> cat-file", is used to get the file contents.
> 
> Sorry for the noise.

Hi Erik,

Yes, diff-tree is only used to find changed paths, not the actual
content changes.  git svn always uses entire blobs from cat-file.

So cat-file won't do CRLF conversions at all, meaning this change is
safe for previously created repos, correct?  If so, consider patches
2/3 and 3/3 acked by me.

1/3 looks alright, too, but I'll wait for Dmitry as I've never hacked
on (builtin-)hash-object.c

-- 
Eric Wong
