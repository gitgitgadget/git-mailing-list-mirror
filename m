From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 11:03:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605151055080.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
  <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>  <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
  <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
 <e5bfff550605151022m7b9ddcd9y53cd745e16ff6b22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 20:04:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhQJ-00048c-Qw
	for gcvg-git@gmane.org; Mon, 15 May 2006 20:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWEOSEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWEOSEA
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 14:04:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965027AbWEOSD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 14:03:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FI3qtH018190
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 11:03:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FI3pi7011524;
	Mon, 15 May 2006 11:03:52 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605151022m7b9ddcd9y53cd745e16ff6b22@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20074>



On Mon, 15 May 2006, Marco Costalba wrote:
> 
> Well, it works but the nice boundary circles are not shown, and qgit
> always adds  --boundary to command line args to feed git-rev-list, but
> in this case it seems the --boundary option didn't do his job.

Well, it did do it's job, but you expected different counting priorities 
than git-rev-list actually gives you.

For the "limit by number" case, the commit counting counts _both_ 
"primary" commits and "boundary" commits, and will limit the total output 
to the number specified.

qgit would seem to prefer to have the commit counting only affect the 
"primary" commits, and not the "boundary" ones at all. Which might be 
sensible, but it's not the semantics it has now.

gitk doesn't care, because it uses the boundary commits just as hints.

I _think_ gitk is correct here, and qgit is being too strict in its 
semantic understanding of what the boundary commits mean. But I think so 
mostly because it would actually be pretty hard to do otherwise (ie the 
git-rev-list commit counting is largely defined by it's _implementation_, 
not necessarily by what you want it to do ;)

		Linus
