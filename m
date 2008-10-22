From: kenneth johansson <ken@kenjo.org>
Subject: Re: git archive
Date: Wed, 22 Oct 2008 18:45:30 +0000 (UTC)
Message-ID: <gdnsca$92r$2@ger.gmane.org>
References: <gdmp0p$92r$1@ger.gmane.org>
	<20081022130829.GC2015@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 20:47:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksijc-0006Eg-Ob
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 20:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYJVSpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 14:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbYJVSpr
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 14:45:47 -0400
Received: from main.gmane.org ([80.91.229.2]:39810 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364AbYJVSpq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 14:45:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KsiiB-0002IE-Ul
	for git@vger.kernel.org; Wed, 22 Oct 2008 18:45:39 +0000
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 18:45:39 +0000
Received: from ken by 1-1-4-20a.ras.sth.bostream.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 18:45:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1-1-4-20a.ras.sth.bostream.se
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98887>

On Wed, 22 Oct 2008 09:08:29 -0400, Deskin Miller wrote:

> On Wed, Oct 22, 2008 at 08:42:01AM +0000, kenneth johansson wrote:
>> I was going to make a tar of the latest stable linux kernel. Done it
>> before but now I got a strange problem.
>> 
>> >git archive --format=tar v2.6.27.2
>> fatal: Not a valid object name
> 
> I had the same thing happen to me, while trying to make an archive of
> Git. Were you perchance working in a bare repository, as I was?  I spent
> some time looking at it and I think git archive sets up the environment
> in the wrong order, though of course I never finished a patch so I'm
> going from memory:

Yes it was a bare repository.

> 
> After looking at the code again, I think the issue is that git_config is
> called in builtin-archive.c:cmd_archive before setup_git_directory is
> called in archive.c:write_archive.  The former ends up setting GIT_DIR
> to be '.git' even if you're in a bare repository.  My coding skills
> weren't up to fixing it easily; moving setup_git_directory before
> git_config in builtin-archive caused last test of t5000 to fail:
> GIT_DIR=some/nonexistent/path git archive --list should still display
> the archive formats.

if I do
GIT_DIR=. git  archive --format=tar v2.6.27.2

it does work so it looks like you are on the right track.
