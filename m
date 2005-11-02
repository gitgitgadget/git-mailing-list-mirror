From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/4] Server-side support for user-relative paths.
Date: Wed, 02 Nov 2005 09:30:12 +0100
Message-ID: <43687914.6080906@op5.se>
References: <20051101225921.3835C5BF73@nox.op5.se> <7vek5z6h3f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:30:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXE0g-0003ed-GX
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVKBIaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVKBIaO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:30:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:3968 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932651AbVKBIaN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:30:13 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 7843B6BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:30:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vek5z6h3f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11009>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>Remove the redundant code from {receive,upload}-pack.c in favour of the
>>library code in path.c (previous patch) with documentation of the changes
>>to the affected programs.
> 
> 
> I like the simplification of these two calling sites, but it
> makes me feel uneasy to see the workhorse named is_git_repo().
> 
> The name implies a check to see if the given path is a git repo
> or not (i.e. side-effect free predicate), while what it actually
> does are three things: (1) resolve and check, (2) chdir to it,
> (3) set up GIT_DIR environment.  Not that I have a better name
> in mind...
> 

I went with this implementation because when I tried to break it up I 
had to add the chdir() and putenv() calls in the three callers. No 
programs in the git-suite tries to resolve the canonical path of a repo 
without subsequently entering it and using it.

Perhaps it should be enter_repo() or some such? Optionally with 
is_git_repo() as a separate function?

> 
>>+	SSH Is the default transport protocol and also supports an
> 
> 
> Just a typo ("Is")?
> 

Yes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
