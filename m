From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Fri, 2 Mar 2007 10:05:12 +0000
Message-ID: <200703021005.13620.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <200703011931.32170.andyparkins@gmail.com> <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Junio C Hamano <junkio@cox.net>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6Rs-0007oI-Cp
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423047AbXCBMBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423048AbXCBMBS
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:01:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:53007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423047AbXCBMBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:01:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1257595nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 04:01:05 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FCn+IwAnRgVvZY5j/5sds4ZMnWqc7WkAnS1PAHKwifBq34oOT3zxlY9x7LpYlkDurbXM/Epkb60zpvl5etwOoi4+HRv6M0jbjy0Mn1tGQWAH1GWozqCvYWMTqMVrShsAh46ZhJRsjda0zx+nFIqOQMfbT7oNNkber0+09/ikCTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=be6BU2BD+a+a5qFBHzlbjGzAS8zQTJ5DSF/xvjjMx4EipM3eZCmrhBmcnGa2HWGEvKbZxN8VmKnF+UBwHMXYKgi5teEVlUNwkFkjObm8BAJRfZm+3G9IGmVK0eVK8wF27ZQvr5HO1bY6B/ecsd3T9D8LStBA9c9zjPumBhisjz0=
Received: by 10.49.19.18 with SMTP id w18mr7611721nfi.1172836865049;
        Fri, 02 Mar 2007 04:01:05 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id c24sm6241526ika.2007.03.02.04.01.02;
        Fri, 02 Mar 2007 04:01:03 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0703012140370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41198>

On Thursday 2007 March 01 20:43, Johannes Schindelin wrote:

> > Putting $Id$ $Rev$ in a git managed file would have far more meaning
> > that it does in a CVS managed file.
>
> No. My point was that you do not even have to have an id. The hash of the
> object is the id.

I think you're thinking of these tags in too strict terms.  You're right they 
aren't /needed/ you can query the version control system for the information.  
However, if you sent them out in a tarball to someone who didn't have or want 
to have your version control system, then it is much easier for them to be 
able to tell you the $Id$ field from the file itself than to generate the 
hash or send you a copy of the file.

They're purely for information.  As I've mentioned before, personally the only 
place I use them is in inkscape SVG files (thank the lord SVG's are ASCII), 
where I add a text field that appears on the diagram itself and I write $Id$ 
as the text.  Then whenever I print that diagram out (which makes it much 
harder to hash), I will know which version of the file I'm looking at.  This 
is the /only/ thing I miss from subversion.

> This is obviously much better than the mess of CVS/SVN's file ids. There
> is an option, even, to switch off key expansion, so you can have erroneous
> ids. That just cannot happen with hashes.

As I said, I don't think anyone ever imagines that these Id fields are 
absolute guarantees of correctness - nor does any version control 
system /ever/ read them and use them.  They are there only as a convenience 
for the user.  Obviously, I could just edit the $Id$ anyway if I wanted, so 
it obviously isn't absolute.

> Of course, it does not give you any hint about when this file was current.
> But there is no way to tell in distributed development _anyway_. You have
> to look it up, when, and who, changed the file to the current state.

What about this though:
 * Tag a release
 * Export the working tree into a fresh directory
 * Edit each source file to put the hash of the tagged revision into
   every file.
 * Edit the makefile to include the tag hash in the released version
 * tar it up
 * Release
It's such a mundane, useless waste of time to edit the hash in by hand - why 
can't the version control system do it?

It's already nearly there in the form of git-describe.  It's only purpose is 
to supply strings that describe the current revision.  Well, so would $Id$, 
but for files instead.

I don't see that keywords are the evil they're made out to be; they're for 
convenience, not for absolute truth.  When some random printout of the source 
turns up, at least the $Id$ might give you a clue as to which version it is.  
If it doesn't, well you're no worse off.

Here's another similar idea: generating copyright lines.  Let's say we want to 
copyright every source file - that means writing "(C) Junio, (C) Johannes, 
etc" at the top of every file.  Wouldn't it be nicer if we could put 
$Copyright$ in the file, then have some git-blame-like machinery fill in the 
copyrights automatically based on who's made contributions?

e.g.

 git-blame refs.c | sort -f 2 | uniq -c -s 10 -w 10 | sort -nr



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
