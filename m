From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [HALF A PATCH] Teach the '--exclude' option to 'diff --no-index'
Date: Fri, 20 Feb 2009 10:34:30 -0800 (PST)
Message-ID: <m3skm9rm6h.fsf@localhost.localdomain>
References: <499E92FD.8000900@alum.mit.edu>
	<cf17659db8a4f7fe9d878984effcdd8d6417c862.1235138849u.git.johannes.schindelin@gmx.de>
	<20090220145331.GA3515@coredump.intra.peff.net>
	<alpine.DEB.1.00.0902201555490.6302@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 19:36:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaaEK-00076O-1T
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 19:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZBTSej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 13:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbZBTSei
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 13:34:38 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:5125 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbZBTSeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 13:34:37 -0500
Received: by ti-out-0910.google.com with SMTP id d10so735608tib.23
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 10:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qn/rbfueyRT79r407fAYf6AEvSPkV2l6CwxGrfPx+8k=;
        b=DwyPnZQaDrOVfgXE1ij7YPjB73rSnOljCiuoy6xgAMPlKjJ+8juQA/tcjTsWCMnMpI
         KXT8moeNtCm46gA/CNhF0XjlmRY3C7uSiR3u9VFi7M0UTy4rDJqOZKPTK14/1W8XeK53
         efcc88+nOSV7bcJzzAjDs0KqnZ3W7Aw0xcgus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=du53f/fBmzrSqn/RpCFRiahQuaM7XhWir8Z0dYu8zVRNb2fzrlFPcDj+m9VtTazFm4
         fqrdpLxlNaN94u9ulvNr7wHn1wS+8tKq3EkfHFHXVCg/zPIATVPucjrnl4+oaZASf7MV
         +tFVi3iSXK/R5q1rr5KIS0bo7TcslQUaOp+ig=
Received: by 10.110.41.20 with SMTP id o20mr1399578tio.53.1235154872599;
        Fri, 20 Feb 2009 10:34:32 -0800 (PST)
Received: from localhost.localdomain (abvl165.neoplus.adsl.tpnet.pl [83.8.209.165])
        by mx.google.com with ESMTPS id a4sm1104537tib.11.2009.02.20.10.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 10:34:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1KIZgWM012825;
	Fri, 20 Feb 2009 19:35:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1KIZYVA012821;
	Fri, 20 Feb 2009 19:35:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0902201555490.6302@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110877>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Fri, 20 Feb 2009, Jeff King wrote:
> 
> > But more seriously, how would a user expect this to interact with 
> > .gitignore? I know gitignore is about ignoring untracked files, but I 
> > can't help but feel the two have something in common. But maybe not. I'm 
> > sick today and my brain is not working very well.
> 
> I think that the -x option with regular (not --no-index) diff would be 
> a little different.  .gitignore is for "git add" time, while "git diff" 
> happily ignores .gitignore.
> 
> Besides, the -x option only works on the basenames (as I implemented it; 
> no idea if GNU diff works the same way, but from Michael's patch it looks 
> like it does).

Info: (diff.info.gz)diff Options

`-x PATTERN'
`--exclude=PATTERN'
     When comparing directories, ignore files and subdirectories whose
     basenames match PATTERN.  *Note Comparing Directories::.

`-X FILE'
`--exclude-from=FILE'
     When comparing directories, ignore files and subdirectories whose
     basenames match any pattern contained in FILE.  *Note Comparing
     Directories::.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
