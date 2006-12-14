X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Ignoring local changes
Date: Thu, 14 Dec 2006 17:44:58 +0100
Message-ID: <45817F8A.3050701@op5.se>
References: <loom.20061214T171948-279@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:45:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <loom.20061214T171948-279@post.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34370>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guthf-0001UU-V9 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751870AbWLNQpB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWLNQpB
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:45:01 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36689 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751767AbWLNQpA (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 11:45:00 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 30ED86BCC4; Thu, 14 Dec 2006 17:44:59 +0100 (CET)
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu wrote:
> Is there any way to make git completely ignore changes to certain local files? I
> know about .gitignore, but that doesn't work when the files I want to ignore
> were already added to the repository.
> 

Yes it does. Just add the file to .gitignore and it won't be noticed
anymore.

Correction: I just tested this, and while git-add won't touch the file, 
git-update-index will, and git-status still shows it as modified.

This feels like a bug to me.

> A little more context should help you understand my need. I'm currently tracking
> a big subversion repository using git-svn; I do all my develop on local git
> branches, and later use git-svn dcommit to push these changes to the svn
> repository. 
> 
> There are some files in the svn repository (and by extension, on my local
> mirrored repository) that are almost always locally modified (eclipse/IDEA
> project files or generated artifacts that someone else added to svn), but I
> almost never want to commit then. This is a hassle in several situations:
> 
> 1) git-status always show these files as modified, polluting the output and
> making it harder for me to pinpoint the "real" changes.
> 2) git-rebase refuses to run, since the working copy will always be dirty*
> 3) since git-svn dcommit uses git-rebase, sometimes it fails for the same reason.
> 
> So, is there any way to make git look the other way regarding these files?
> 

man git-ls-files, search for .git/info/exclude and see if that works for 
you.

On a side-note, it would be neat if it was possible to set 
--exclude-per-directory as a config option. It would save an awful lot 
of hassle for imported repositories. Even more so if 
git-{cvs,svn,p4}import and the lot set it up automagically.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
