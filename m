From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Trying to use git-filter-branch to compress history by
	removing large, obsolete binary files
Date: Mon, 8 Oct 2007 10:36:50 -0400
Message-ID: <20071008143650.GC2902@fieldses.org>
References: <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <Pine.LNX.4.64.0710080018270.4174@racer.site> <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> <Pine.LNX.4.64.0710080028301.4174@racer.site> <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com> <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org> <Pine.LNX.4.64.0710080204140.4174@racer.site> <4709CCB2.4000202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 08 16:37:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ietjb-0001wx-3f
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 16:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXJHOhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 10:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbXJHOhN
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 10:37:13 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56655 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbXJHOhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 10:37:11 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Ietj0-0001ls-2n; Mon, 08 Oct 2007 10:36:50 -0400
Content-Disposition: inline
In-Reply-To: <4709CCB2.4000202@viscovery.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60325>

On Mon, Oct 08, 2007 at 08:22:42AM +0200, Johannes Sixt wrote:
> Johannes Schindelin schrieb:
>> The rationale was this: filter-branch recently learnt how to rewrite many 
>> branches, and it might be tedious to find out which ones.  But then, there 
>> is git log --no-walk --all, so maybe I really should get rid of 
>> refs/original/*?
>> I'd like to have some comments from the heavier filter-branch users on 
>> that...
>
> IMHO, a backup of the original refs is needed.

And we can't rely instead on reflogs or some other existing mechanism?

> However, it may be wise to store them in the refs/heads namespace so
> that 'git branch -d' can delete them and 'git branch -m' can move them
> back if something went wrong.

If people want backups like this it'd seem easier to turn this on
optionally with commandline switches, like patch's --backup, --prefix,
--suffix options.

Having it by default leave these backups around, even when everything
succeeds, makes for unnecessary cleanup work in the normal case, and is
inconsistent with the behavior of other git commands that destroy or
rewrite history.

--b.
