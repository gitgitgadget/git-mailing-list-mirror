X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 09:20:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611210913000.3338@woody.osdl.org>
References: <200611211341.48862.andyparkins@gmail.com>
 <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
 <slrnem694k.4lm.Peter.B.Baumann@xp.machine.xx> <Pine.LNX.4.64.0611210820100.3338@woody.osdl.org>
 <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 17:23:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <slrnem6cpn.6vh.Peter.B.Baumann@xp.machine.xx>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32008>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmZLA-00025M-HN for gcvg-git@gmane.org; Tue, 21 Nov
 2006 18:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966964AbWKURXU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 12:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966966AbWKURXU
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 12:23:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43486 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S966964AbWKURXT (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 12:23:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kALHK7ix015634
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 21
 Nov 2006 09:20:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kALHK6Jc032197; Tue, 21 Nov
 2006 09:20:07 -0800
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org



On Tue, 21 Nov 2006, Peter Baumann wrote:
> 
> And I think handling this behaviour as a config option is the right thing,
> because most of the time if someone imports a project into git he
> will import the whole history, especially if he is using one of the
> cvs/svn importers. A "halfway import" as seen in the kernel repo is a
> special case and it is unlikely seen again.

Actually, I see "halfway imports" all the time.

I've found that some of the git things like "git grep" etc are _so_ 
convenient, that whenever I get a source tar-ball for _anything_, I tend 
to do

	zcat < xyz-123.tar.gz | tar xvf -
	cd xyz-123
	git init-db
	git add
	git commit -m "Import xyz-123"

the first thing I do. Even if I never end up changing anything in that 
archive, it's just that convenient (and fast - sure, doing the hashing and 
compression means that the "git add" might not be truly instantaneous, but 
it's definitely fast enough that for almost all projects, doing this is so 
cheap that you don't need to care).

And _especially_ for things like this, being able to do "git log -p" to 
check the small trivial one-liners that I might do is nice (it happens - 
my pine4.64 import these days has three small commits to add buildnotes 
and handle UTF-8 input etc).

And again, that's when you do _not_ want to see "--root". Because it's 
never what you actually care about.

So I think imports are important. They may be throw-away trees like mine, 
but they're still useful. 

