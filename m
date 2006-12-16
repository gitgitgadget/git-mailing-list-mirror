X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 19:31:29 +0100
Organization: At home
Message-ID: <em1e1v$lse$1@sea.gmane.org>
References: <458437E0.1050501@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 16 Dec 2006 18:32:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 42
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34630>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GveKB-0007We-49 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751171AbWLPSbv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 13:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWLPSbv
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:31:51 -0500
Received: from main.gmane.org ([80.91.229.2]:46110 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751171AbWLPSbu
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 13:31:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GveK0-0002Uq-DS for git@vger.kernel.org; Sat, 16 Dec 2006 19:31:44 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 19:31:44 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 16 Dec 2006
 19:31:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Steven Grimm wrote:

> In the course of experimenting with using git for my snapshot backups, I 
> ran into what looks like a bug in git-add: it croaks when it tries to 
> add a file whose type has changed, specifically when a directory gets 
> moved and a symbolic link is put in the old location pointing to the new 
> one. Here's a simple test case:
> 
> $ git init-db
> defaulting to local storage area
> $ mkdir dir
> $ echo foo > dir/file
> $ git add .
> $ git commit -m "initial commit" -a
> Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
>  create mode 100644 dir/file
> $ mv dir dir.real
> $ ln -s dir.real dir
> $ git add .
> fatal: unable to add dir to index

Works if you use "git mv dir dir.real".

$ git init-db
defaulting to local storage area
$ mkdir dir
$ echo foo > dir/file
$ git add .
$ git commit -m "initial commit" -a
Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
$ git mv dir dir.real
$ ln -s dir.real dir
$ git add .
$ git commit -m "second commit" -a
$ git ls-tree HEAD
120000 blob e05f72eddb14362b836c3612c13d441b097a065a    dir
040000 tree 4a1c03029e7407c0afe9fc0320b3258e188b115e    dir.real
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

