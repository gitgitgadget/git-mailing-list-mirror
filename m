From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 14:57:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604191453030.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
 <7vpsjecriu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
 <7vd5fecpyd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181836400.3701@g5.osdl.org>
 <7v8xq2ciws.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604182108070.3701@g5.osdl.org>
 <7v3bg96xsv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 23:58:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKgY-00056g-K2
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWDSV6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWDSV6D
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:58:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751264AbWDSV6B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 17:58:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JLvutH011436
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 14:57:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JLvswE004464;
	Wed, 19 Apr 2006 14:57:55 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bg96xsv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18944>



On Wed, 19 Apr 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Tue, 18 Apr 2006, Junio C Hamano wrote:
> >> 
> >> A small fry in the ointment.  What should the parts that are
> >> output with --name-only say for such a diff?
> >
> > I have no idea, I have to say ;)
> 
> Another small one ;-).  Bare blobs do not have modes, so diffcore
> needs to be told "do not bother comparing mode for this pair".

True, but sad.

We clearly _do_ have the mode when we look it up using the tree:name 
shorthand, so it's a bit sad that we drop it on the floor like that.

We could do something like with the "name" part - squirrel the mode away 
for users that could use it, and use the special mode of 0 as "unknown" 
for when somebody really does give a pure SHA1 number (short or full).

But I suspect most people simply don't care, so dropping the mode might 
just be the right thing to do. Especially if we do know that we _could_ 
get the mode if people really really care and complain some day in the 
future..

(The logic being: 640kB really _is_ enough for everybody, if you just know 
that you can extend on it in the future without undue pain when people 
complain)

			Linus
