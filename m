X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Drake <ddrake@brontes3d.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Mon, 11 Dec 2006 09:27:10 -0500
Message-ID: <1165847230.13854.2.camel@systems03.lan.brontes3d.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
	 <20061208203230.GA9193@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 14:27:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061208203230.GA9193@sashak.voltaire.com>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: OK
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34007>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtm7f-0002b7-Vq for gcvg-git@gmane.org; Mon, 11 Dec
 2006 15:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935057AbWLKO1N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 09:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935217AbWLKO1N
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 09:27:13 -0500
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:42730 "EHLO
 smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S935057AbWLKO1M (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 09:27:12 -0500
Received: from [10.20.253.243] (host34.155.212.242.conversent.net
 [155.212.242.34]) (Authenticated sender: ddrake@brontes3d.com) by
 relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 723C9646FD3; Mon,
 11 Dec 2006 09:27:10 -0500 (EST)
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

On Fri, 2006-12-08 at 22:32 +0200, Sasha Khapyorsky wrote:
> > # git-svnimport -v -i -C repo -r https://server repo
> 
> Is this 'server' public? Can I rerun this git-svnimport?

Sorry, it is not.

> @@ -906,7 +912,7 @@ sub commit_all {
>  	my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
>  	my %p;
>  	while(my($path,$action) = each %$changed_paths) {
> -		$p{$path} = [ $action->action,$action->copyfrom_path, $action->copyfrom_rev, $path ];
> +		$p{$path} = [ $action->action,$svn_dir$action->copyfrom_path, $action->copyfrom_rev, $svn_dir$path ];

This is not valid perl - I think you wanted $svn_dir . $path

After making that modification it's not fixed though:

Fetching from 1 to 10742 ...
Tree ID 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Committed change 1:/ 2004-12-22 22:53:27)
Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
Commit ID 2614c05ac4c5f24eb89cea056a7d46c909084d8c
Writing to refs/heads/origin
DONE: 1 origin 2614c05ac4c5f24eb89cea056a7d46c909084d8c
perl: subversion/libsvn_subr/path.c:377: svn_path_basename: Assertion
`is_canonical (path, len)' failed.
Aborted

-- 
Daniel Drake
Brontes Technologies, A 3M Company
