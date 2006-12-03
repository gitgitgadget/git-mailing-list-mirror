X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Some advanced index playing
Date: Sun, 03 Dec 2006 21:19:16 +0100
Organization: At home
Message-ID: <ekvbg3$jjd$1@sea.gmane.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org> <200612032011.25922.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 3 Dec 2006 20:19:58 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 49
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33137>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqxoZ-0002hD-Gx for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760066AbWLCUTq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760070AbWLCUTq
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:19:46 -0500
Received: from main.gmane.org ([80.91.229.2]:62899 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1760066AbWLCUTp (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 15:19:45 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gqxo8-0001Fs-GM for git@vger.kernel.org; Sun, 03 Dec 2006 21:19:29 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 21:19:28 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 21:19:28 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> On Sunday 03 December 2006 18:24, Linus Torvalds wrote:

> ...
>>
>>      git ls-tree HEAD -- that-file | git update-index --index-info
>>      git commit that-file
> 
> I don't quite understand this - maybe it should be
> 
> git ls-tree HEAD -- that-file | git update-index --index-info
> git commit
> git commit -a
> 
> either I want to ONLY commit that file at the working tree state (and index 
> before these commands), or I want to commit ALL except this file (so I can 
> later come and commit just that file)
> 
> so having reset the index to the state of HEAD for "that-file" then the commit 
> should make a commit with all the other changes in the index (but NOT 
> that-file) and then the git commit -a picks up "that-file"

$ git ls-tree HEAD -- that-file | git update-index --index-info
$ git commit that-file
$ git commit

resets index state of 'that-file' to the HEAD version, so the safety valve
is bypassed and "git commit that-file" commit _working directory_ version
only (because --only is default for "git commit <path>"). Then you commit
the rest of files.


While

$ git ls-tree HEAD -- that-file | git update-index --index-info
$ git commit
$ git commit -a

first commits rest of files, then all files to their working directory
version.

P.S. Could you wrap lines a little earlier (76 columns perhaps)? Thanks
in advance
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

