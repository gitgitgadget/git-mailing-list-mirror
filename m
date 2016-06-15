From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 15:00:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051457020.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
 <Pine.LNX.4.64.0701051439060.3661@woody.osdl.org> <7vac0xdr97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 06 00:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2y3a-0000OG-W0
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXAEXA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXAEXA7
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:00:59 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39909 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbXAEXA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 18:00:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l05N0rWi012545
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 15:00:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l05N0qJp006276;
	Fri, 5 Jan 2007 15:00:53 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac0xdr97.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.671 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36038>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
> 
> I do not think we have too many branch refs (builtin-branch and
> builtin-show-branch) for this patch to make any practical
> difference

Yeah, it's mainly a "safety thing" - have the default be the "don't waste 
memory".

> but I wonder why this is needed...
> 
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index bac16f5..b98ed1a 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -1286,6 +1286,7 @@ int main(int argc, char *argv[])
> >  	const char *branch1, *branch2;
> >  	struct commit *result, *h1, *h2;
> >  
> > +	save_commit_buffer = 1;
> >  	git_config(git_default_config); /* core.filemode */
> >  	original_index_file = getenv(INDEX_ENVIRONMENT);
> 
> Ah, there are those annoying "using this as the merge base whose
> commit log is..." business.  I wonder if anybody is actually
> reading them (I once considered squelching that output).

"output_commit_title()" used it. Not just for the merge base, but for the 
regular "merging X and Y" messages, I think.

		Linus
