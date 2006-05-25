From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 10:28:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
 <7vejyjpz9a.fsf@assigned-by-dhcp.cox.net> <m13beysnb2.fsf@ebiederm.dsl.xmission.com>
 <7vwtcay5k8.fsf@assigned-by-dhcp.cox.net> <m1lksqdook.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 19:29:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjJdn-0003Vf-Jl
	for gcvg-git@gmane.org; Thu, 25 May 2006 19:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWEYR2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWEYR2w
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 13:28:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030292AbWEYR2w (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 13:28:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4PHSm2g027415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 May 2006 10:28:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4PHSlQn000352;
	Thu, 25 May 2006 10:28:47 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1lksqdook.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20750>



On Thu, 25 May 2006, Eric W. Biederman wrote:
> 
> My basic argument is that starting a pull with a commit that is not a
> reference is no worse than staring a pull from a broken repository.  The
> same checks that protects us should work in either case.

I think Junio reacted to the subject line, which was somewhat badly 
phrased. You're not looking to transfer random objects, you're looking to 
_start_ a branch at any arbitrary known point.

However, Junio's point is probably that the "any valid SHA1" might 
actually point to a broken tree, even if it exists on the server.

Of course, in that case hopefully git-rev-list exits with an error, and 
the server doesn't generate any pack at all rather than generating a 
broken one.

However, there's a (questionable) security issue: what if the server 
doesn't _want_ to expose certain branches? Arguably, if you know the top 
SHA1, you likely know all that it contains, but it may be a valid argument 
to say that if the SHA1 isn't an exported branch, you shouldn't 
necessarily be able to follow it.

		Linus
