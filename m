From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Wed, 09 Aug 2006 12:26:50 +0200
Organization: At home
Message-ID: <ebcd8r$bi7$1@sea.gmane.org>
References: <200608071626.52655.jnareb@gmail.com> <7v3bc82v7l.fsf@assigned-by-dhcp.cox.net> <eb8cdh$s6n$1@sea.gmane.org> <7v4pwo1a0r.fsf@assigned-by-dhcp.cox.net> <eb8e12$2aa$1@sea.gmane.org> <7vejvsyum8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Aug 09 12:26:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAlH0-0008Rr-0s
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 12:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWHIK0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 06:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbWHIK0q
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 06:26:46 -0400
Received: from main.gmane.org ([80.91.229.2]:24515 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030645AbWHIK0p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Aug 2006 06:26:45 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAlGq-0008QA-3r
	for git@vger.kernel.org; Wed, 09 Aug 2006 12:26:40 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 12:26:40 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 Aug 2006 12:26:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25108>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Matthias Lederhofer has noticed that parsing all the tags in "summary" and
>> "tags" views, while we use only epoch/timestamp information to sort them
>> and discard most of parsed input, is bottleneck due to the fact that
>> usually number of tags is linear with history (version tags) and the fact
>> that for each tag is one invocation of git (one fork, two execs).
> 
> Maybe we would want to expose for_each_ref somehow to the
> command level then.  Looking at how "git branch" without any
> argument lists the branches, and how "git tag -l" lists the
> tags, it appears that we could benefit from such a command [*1*].

> -- >8 -- [*1*] -- >8 --
> [PATCH] git-show-refs
> 
> Implementation is left as an exercise ;-)
[...]
> +SYNOPSIS
> +--------
> +'git-show-refs' [--count=<max>] [--sort=<sortkeys>] [--format=<format>] [<pattern>]

It would be useful for application in gitweb to have [-l|--count-lines]
option which would print number of lines (excluding the one with number
of lines) before any output. It could be used to know before reading all
the output how many lines would be, and if there is something more than
(for --count=<max>) <max> lines. 

It is needed in gitweb to create pagination/paging navigation bar. 
Currently it is done by reading all the output into array, and 
checking length of this array.

While at it, --skip=<count> would also be nice, although not that
necessary.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
