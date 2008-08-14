From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 14:26:54 -0700
Message-ID: <20080814212654.GS3782@spearce.org>
References: <977100.98240.qm@web27803.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkMQ-00011c-2u
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbYHNV0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYHNV0z
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:26:55 -0400
Received: from george.spearce.org ([209.20.77.23]:46293 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYHNV0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:26:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1B4FC38375; Thu, 14 Aug 2008 21:26:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <977100.98240.qm@web27803.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92404>

Mark Struberg <struberg@yahoo.de> wrote:
> I'm the initial author of the Apache maven-scm-providers-git and
> I need to update our SCM-Matrix.
> 
> This is just for making sure I did not oversee anything.
> 
> I didn't came across anything like 'cvs export' and I do not
> think git really needs this, since it doesn't pollute the working
> directories with lots of waste like CVS and SVN does.
> 
> But I just want to make sure to not build workarounds in our
> scm-provider (checkout + afterwards blasting the GIT_DIR) for things
> that do exist natively in git.

You can use:

  git archive --tar HEAD | (mkdir ../dest;cd ../dest;tar xf -)

Or you can do something even more bizzare like:

  export GIT_INDEX_FILE=/tmp/$$.index;
  export GIT_WORK_TREE=../dest;
  export GIT_DIR=.git;
  git read-tree HEAD &&
  git checkout-index --force --all &&
  rm $GIT_INDEX_FILE

-- 
Shawn.
