X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 10:22:31 +0100
Organization: At home
Message-ID: <ek6dhj$n1l$1@sea.gmane.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz> <7vejrtiwqd.fsf@assigned-by-dhcp.cox.net> <20061123234203.GN7201@pasky.or.cz> <7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 09:21:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 58
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32203>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnXFE-0005bU-Ba for gcvg-git@gmane.org; Fri, 24 Nov
 2006 10:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757508AbWKXJVM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 04:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbWKXJVM
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 04:21:12 -0500
Received: from main.gmane.org ([80.91.229.2]:9952 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757508AbWKXJVL (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 04:21:11 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnXF0-0005Yz-Sl for git@vger.kernel.org; Fri, 24 Nov 2006 10:21:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 10:21:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 10:21:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>>> Even though I fully agree that use-separate-remotes should be
>>> the default, to the point that I think we do not even
>>> need a backward compatibility option.  People who want to use
>>> traditional layout for simple one-remote-branch-only project
>>> would not suffer anyway because 'origin' still means origin in
>>> the new layout (refs/remotes/origin/HEAD).
>>
>> I don't know, we still at least need to keep the functionality for
>> --bare.

By the way, I think the backward compatibility option should be
simply named --dont-use-separate-remote, or --without-separate-remote,
or --no-separate-remote (the last is probably the best choice).

> I agree --bare should continue to be a "snapshot mirror"; I am
> not advocating for the removal of the internal implementation
> detail such as $use_separate_remote variable.
> 
> However, I think having one sane behaviour is the right thing to
> do for a clone that prepares a repository with a working tree
> (including the one made with -n option, which only means "do not
> do the check-out immediately after cloning" for such a
> repository).
> 
> The traditional layout is slightly simpler for a project with
> the simplest needs (that is, a single upstream repository that
> has a single 'master' branch), but I do think even that is not
> an advantage anymore.
> 
> With the separate-remote layout, git-fetch would still fetch and
> update the "origin" (although that is now remotes/origin/master
> which is pointed at by remotes/origin/HEAD) and the user can
> still refer to it with "origin".  Commands "git-pull origin",
> "git-pull . origin", and "git-merge origin" all will continue to
> work the same way as before for such a project as in the
> traditional layout, and that is why I think we do not need
> backward compatibility flag in this case.
 
The exception being that with --use-separate-remote you cannot checkout
tracking branches to see what it is there (at least for now, but IIRC we
want to relax this constraint; i.e. to forbid commiting to non-heads,
instead of forbidding checking out), you cannot use it as alternate
source (as alternate repo to check from) while still allowing to work
on it, and that gitweb doesn't show anything except heads and tags;
it doesn't show remotes.

By the way, does new "git peek-remote -a ." show anything except
refs/heads/, refs/tags/ and refs/remotes (e.g. StGit refs/bases/
and refs/patches/)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

