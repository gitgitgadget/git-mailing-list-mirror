From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 11:51:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605151149460.3866@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
  <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>  <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
  <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org> 
 <e5bfff550605151022m7b9ddcd9y53cd745e16ff6b22@mail.gmail.com> 
 <Pine.LNX.4.64.0605151055080.3866@g5.osdl.org>
 <e5bfff550605151132s4605a241sd3132aaeb2de6a39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 20:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfiAr-0004QZ-8o
	for gcvg-git@gmane.org; Mon, 15 May 2006 20:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWEOSwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 14:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWEOSwF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 14:52:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbWEOSwD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 14:52:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4FIpstH020904
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 11:51:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4FIprrP012999;
	Mon, 15 May 2006 11:51:53 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605151132s4605a241sd3132aaeb2de6a39@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20077>



On Mon, 15 May 2006, Marco Costalba wrote:
> 
> $ git-rev-list --topo-order --after="Apr 10" --before="Apr 11" HEAD |wc
>     14      14     574
> $ git-rev-list --topo-order --boundary --after="Apr 10" --before="Apr
> 11" HEAD |wc
>     18      18     742
> 
> Boundary revisions in this case are _not_ passed through search
> filtering. Using --boundary option we get revisions ouside given
> filter range.

Right. And the commit counting is a special filter, and "boundary" is 
special in that it doesn't normally honor some other filters (it _does_ 
honor path-based ones, though, I think).

So you really should see "--boundary" as a heuristic, and as a hack to 
help you close the loop on uninteresting commits _faster_. But if 
something else has closed it for other reasons, you shouldn't depend on 
it.

		Linus
