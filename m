X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some advanced index playing
Date: Sun, 03 Dec 2006 19:31:51 +0100
Organization: At home
Message-ID: <ekv56m$vd0$1@sea.gmane.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 18:32:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 64
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33125>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqw8b-0001hL-I8 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758771AbWLCScT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758805AbWLCScT
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:32:19 -0500
Received: from main.gmane.org ([80.91.229.2]:41187 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758771AbWLCScS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:32:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gqw8L-0006Or-54 for git@vger.kernel.org; Sun, 03 Dec 2006 19:32:13 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 19:32:13 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 19:32:13 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> With all the discussion about the index file in the last few days I would have 
> thought that this issue would have come up.  But I don't think it has.
> 
> I have been editing a set of files to make a commit, and after editing each 
> one had done a git update-index.
> 
> At this point I am just about to commit when I realise that one of the files 
> has changes in it that really ought to be a separate commit. 
> 
> So effectively, I want to do one of three things
> 
> a) git-commit <that-file>
> 
> Except I can't because there is a safety valve that prevents this and there is 
> no force option.

I do wonder what this safety valve is for, and why it acts also if
index version is equal to working directory version...

> b) Revert the index entry for that file back to the previous HEAD commit 
> point, whilst leaving the edits in the working tree, so that I can then 
> commit without that one file.
> 
> I can't find a command to do that.  The nearest seems to be 
> git-update-index --remove, but the manual says that it will not do anything 
> if the file still exists.

There is "git update-index --force-remove <that-file>". Currently there
is no "git reset -- <that-file>", but you can revert index entry to the
one in HEAD using
  $ git ls-tree HEAD -- <that-file> | git update-index --index-info

And you can always try "git-rm + git-add".
 
> c) Revert the entire index back to the state it was at the last commit so I 
> can selectively add back in the files that I have editted.
> 
> The command to do that seems to be
> 
> git-read-tree HEAD 

No, the command for that is just "git reset" (which means 
"git reset --mixed HEAD"), and touches HEAD and index but not working
directory


> What happened to the text written here
> 
>   http://marc.theaimsgroup.com/?l=git&m=116406699903565&w=2
    "[DRAFT 2] Branching and merging with git"

> I thought this might be a place to put something like this, but having just 
> updated my version of git from source, it doesn't seem to have been put in to 
> git anywhere yet.

linux@horizon.com, perhaps you should send this text in the form of patch
creating Documentation/tutorial-3.txt file?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

