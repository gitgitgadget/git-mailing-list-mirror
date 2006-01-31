From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make apply accept the -pNUM option like patch does.
Date: Tue, 31 Jan 2006 09:01:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601310856381.7301@g5.osdl.org>
References: <43DE1DB7.20909@f2s.com> <Pine.LNX.4.64.0601310015460.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ian Molton <spyro@f2s.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 18:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3ysj-0006H2-C5
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWAaRB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWAaRB0
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:01:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750777AbWAaRBZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 12:01:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VH1KDZ024659
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 09:01:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VH1IPN019034;
	Tue, 31 Jan 2006 09:01:19 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601310015460.25300@iabervon.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15323>



On Tue, 31 Jan 2006, Daniel Barkalow wrote:
>
> This only applies to traditional diffs, not to git diffs.

Also, be careful: the default for git-apply is very different from the 
default for a regular "patch".

"patch" without any "-p" at all will try to automagically figure out the 
right file, which has burnt me more than once when you have the same name 
(usually "Makefile") in multiple sub-directories and "patch" makes the 
wrong automagic guess.

git-apply with this patch will continue to use -p1. No guessing, no gray 
areas. 

I do believe that the right thing to do is to just make SVN output "-p1" 
patches (I cannot imagine that you can't do so, since -p1 is a much saner 
format than -p0), but I guess teaching git-apply to take -pN for 
traditional patches is fine.

But if somebody suggests we do the automatic thing that "patch" does, I'll 
scream. Too many times have I been burnt by patch being "helpful" (in 
general, patch by default will try very hard to apply a patch, whether it 
makes sense or not).

		Linus
