From: Jared Hance <jaredhance@gmail.com>
Subject: Re: Can I checkout a single file without altering index?
Date: Wed, 13 Oct 2010 17:09:07 +0000 (UTC)
Message-ID: <loom.20101013T190544-893@post.gmane.org>
References: <loom.20101012T114900-532@post.gmane.org> <4CB44318.7000305@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 13 19:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P64pv-0007Kn-C7
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 19:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab0JMRJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 13:09:25 -0400
Received: from lo.gmane.org ([80.91.229.12]:47567 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab0JMRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 13:09:24 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P64pO-00078c-HN
	for git@vger.kernel.org; Wed, 13 Oct 2010 19:09:23 +0200
Received: from rrcs-24-123-205-34.central.biz.rr.com ([24.123.205.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 19:09:22 +0200
Received: from jaredhance by rrcs-24-123-205-34.central.biz.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 19:09:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.123.205.34 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; GTB0.0; InfoPath.2; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; OfficeLiveConnector.1.4; OfficeLivePatch.1.3))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158944>

Stefan Naewe <stefan.naewe <at> atlas-elektronik.com> writes:

> 
> On 10/12/2010 12:03 PM, Christian Halstrick wrote:
> > Can I checkout a certain file to a specific revision without also adding 
this 
> > content to the index? I only want to alter the working-tree - no 
modification of 
> > index or HEAD needed.
> > 
> > Here is why I need that: I see a bug in git controlled sources. I fix one 
source
> > file and also add one unit test in a separate file. I checked that the test
> > succeeds with my fix. The index now contains what I want to commit.
> > Now I want to see whether my test fails without my fix. I want to checkout 
HEAD
> > for the source file without destroying my index. In the end, after I saw 
that my
> > test fails without my fix, I just want to say "git commit" without having 
to.
> 
> commit the unit test first, and the fix as a second commit ?
> 
> Regards,
>   Stefan

Just to add to this, since you might not want the test and the fix in separate 
commmits: (as is implied in the message)
  1. commit unit test.
  2. commit fix.
  3. go to detchatched head at HEAD^
  4. run unit test to insure that it fails.
  5. checkout the branch again to where you have the fix.
  6. run unit test to insure that it doesn't fail.
  7. run `git rebase HEAD^` and merge squash the two commits. (optional)

Alternatively, as others have pointed out, the stash should work as well.
