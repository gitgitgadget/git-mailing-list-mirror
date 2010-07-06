From: Eric Niebler <eric@boostpro.com>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 20:25:13 -0400
Message-ID: <4C3277E9.3060800@boostpro.com>
References: <4C31E944.30801@boostpro.com> <rmimxu5bh2s.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 02:25:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVvyY-00059K-GH
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 02:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576Ab0GFAZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 20:25:21 -0400
Received: from boostpro.com ([206.217.198.21]:49688 "EHLO boostpro.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753333Ab0GFAZU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 20:25:20 -0400
Received: from [192.168.2.114] (c-76-118-178-34.hsd1.ma.comcast.net [76.118.178.34])
	(Authenticated sender: eric)
	by boostpro.com (Postfix) with ESMTPSA id 937AD14BAAC;
	Tue,  6 Jul 2010 01:25:19 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
In-Reply-To: <rmimxu5bh2s.fsf@fnord.ir.bbn.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150305>

On 7/5/2010 8:16 PM, Greg Troxel wrote:
> 
> You have found the core issue with svn/git: svn allows you to have a
> large repo with everything (and atomic commits across it) and to have
> users check out parts of the repo separately.  git does not, because the
> svn separate checkouts model only works with a remote repository that
> you don't keep a copy of.  With git, cloning the repo gets you the whole
> thing.

Makes sense.

> One thought is that you may want to separate how you organize boost
> sources in git and how you release them.  It's possible to have a single
> git repo for all libraries and have atomic commits but then create
> distfiles for each library separately.
> 
> git becomes a bit slow when ...
<snip>

It can't get any worse than svn. We haven't run into any perf problems
with git yet. That's not our primary concern.

> My advice (which is not really about git) is to figure out whether you
> want:
> 
>   A) a set of interrelated libraries on which you will allow atomic
>   commits that change interfaces/usage in multiple libraries
> 
> or
> 
>   B) a set of independent libaries which have commits to separate
>   libraries, and for which you insist that each library have an API and
>   ABI compatiblity story, so that even when upgraded other libraries can
>   continue to use it.
> 
> 
> For A, you probably want one git repo, much as you have one svn repo
> now.  For B, multiple git repos are the right answer.

I'll take B FTW! :-) The idea is to open up and distribute C++ library
development. Versioned dependency tracking will be handled at a higher
level with per-project metadata and a tool (pip) that resolves
dependencies. API compatibility is handled with peer review and
regression testing. ABI compatibility is not an issue because we're
distributing source code.

-- 
Eric Niebler
BoostPro Computing
http://www.boostpro.com
