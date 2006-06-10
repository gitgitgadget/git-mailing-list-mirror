From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Fri, 9 Jun 2006 21:08:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092103170.5498@g5.osdl.org>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
 <7virnam435.fsf@assigned-by-dhcp.cox.net> <7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606091743410.5498@g5.osdl.org> <7v8xo5lleo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 06:08:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoumC-00026W-6k
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 06:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWFJEIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 00:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWFJEIf
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 00:08:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932362AbWFJEIf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jun 2006 00:08:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A48Vgt018243
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 21:08:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A48UkW009087;
	Fri, 9 Jun 2006 21:08:31 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xo5lleo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21594>



On Fri, 9 Jun 2006, Junio C Hamano wrote:
> 
> Having said that, I do not think the distinction is that
> important; I would rather make the core.sharedrepository = true
> to mean an equivalent of "chmod go+rX" (it does "chmod g+rX"
> currently).

How about making it be

	[core]
		sharedrepository = {umask | user | group | everybody}

and allow the old boolean expression syntax to mean "0/false means umask, 
1/true means group".

So you'd have:

 - umask/0/false means "use 0777 permissions with default umask"
 - user means "use 0500 permissions"
 - group means "use 0550 permissions"
 - everybody means "use 0555 permissions"

(where "5" is r-x, and only for directories, and obviously degenerates to 
just "4" aka r-- for regular files).

That sounds really pretty self-explanatory and obvious, wouldn't you say?

			Linus
