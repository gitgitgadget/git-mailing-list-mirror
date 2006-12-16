X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 17 Dec 2006 00:29:25 +0100
Organization: At home
Message-ID: <em1vgj$bc3$1@sea.gmane.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 16 Dec 2006 23:29:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 57
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34657>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GviyU-0001eW-31 for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:29:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422809AbWLPX3k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422811AbWLPX3k
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:29:40 -0500
Received: from main.gmane.org ([80.91.229.2]:48020 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1422809AbWLPX3k
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 18:29:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gviy9-0004gj-UK for git@vger.kernel.org; Sun, 17 Dec 2006 00:29:29 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 00:29:29 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 17 Dec 2006
 00:29:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Things that I feel should be done need to be done to complete
> v1.5.0 are:
[...]
>  - now reflog is enabled by default for user repositories, I
>    have two worries about its effect, fortunately can be killed
>    with a single stone.
> 
>    * the reflog grows unbounded;
> 
>    * revisions recorded in the reflog can be pruned out,
>      rendering some entries in reflog useless.
> 
>    I am thinking about teaching fsck-objects and prune to keep
>    revisions recorded in the reflog; we would need an end-user
>    way to prune older reflog entries and I would appreciate
>    somebody codes it up, but even without it, people can always
>    use "vi" or "ed" on reflog files ;-).

I'd rather not have prune keep revisions recorded in reflog. Reflog
keeps also amended commits, and blobs from incrementally staged
commits. Or perhaps make it an configuration option, default to
true for new users (or have an option to git-prune to ignore reflog).

As of "reflog grows unbounded"... perhaps we should encourage to use
logrotate for that (well, perhaps git-prune and porcelains which deal
with reflog should be able to uncompress reflog if needed).

>  - 'git-svn' users should speak out about two issues:
> 
>    * use of svn command line client as the backend is being
>      removed;
> 
>    * 'git-svn commit' command is being renamed to avoid
>      confusion, and potentially 'dcommit' will be renamed to 
>      'commit'.
> 
>    Please discuss these with Eric.

What about remote.<repo>.url = svn://ser.ver/repo/ idea?
 
> ** jc/reflog (Thu Dec 14 15:58:56 2006 -0800) 1 commit
>  - Teach show-branch how to show ref-log data.
> 
> A strawman to make reflog data a bit more browsable; it would be
> useful while recovering from a mistake you made recently.  Not
> essential and can wait or be dropped if people do not find it
> useful.

Looks useful.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

