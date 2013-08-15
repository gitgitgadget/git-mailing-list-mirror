From: John Keeping <john@keeping.me.uk>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Thu, 15 Aug 2013 12:35:42 +0100
Message-ID: <20130815113542.GN2337@serenity.lan>
References: <20130814124933.77b51a04@bigbox.christie.dr>
 <20130814182657.3c03c5df@bigbox.christie.dr>
 <20130815080058.GM2337@serenity.lan>
 <20130815061229.24dfe891@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 13:36:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9vqV-00075O-TU
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 13:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167Ab3HOLfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 07:35:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:41934 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733Ab3HOLfv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 07:35:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2C51ECDA5B2;
	Thu, 15 Aug 2013 12:35:51 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mRiD-U1p2Xst; Thu, 15 Aug 2013 12:35:50 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 3F7AECDA57E;
	Thu, 15 Aug 2013 12:35:50 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 26538161E4B0;
	Thu, 15 Aug 2013 12:35:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBGO4WFAs0Dz; Thu, 15 Aug 2013 12:35:47 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 95923161E0A4;
	Thu, 15 Aug 2013 12:35:44 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130815061229.24dfe891@bigbox.christie.dr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232342>

On Thu, Aug 15, 2013 at 06:12:29AM -0500, Tim Chase wrote:
> On 2013-08-15 09:00, John Keeping wrote:
> > On Wed, Aug 14, 2013 at 06:26:57PM -0500, Tim Chase wrote:
> > > On 2013-08-14 12:49, Tim Chase wrote:
> > > > If it makes any difference, this is within a cmd.exe shell (with
> > > > $PATH set appropriately so git is being found).
> > > 
> > > Just a follow-up, I tried it within the "bash"ish shell included
> > > in the git install and got the same error regarding
> > > "/tmp/report.tmp".
> > 
> > It seems that report.tmp is something that SVN creates and for some
> > reason the svn on your system is trying to create it in a Unix style
> > temporary directory.
> > 
> > What happens if you export TMPDIR=C:/Windows/Temp before running
> > git-svn?
> 
> Still getting the same results.  I tried:
> 
> 1) cmd.exe with my local temp dir:
>  c:\temp> TEMPDIR=%TEMP%

This should be TMPDIR - note the missing 'E'!

You may also need to "export TMPDIR" but I don't know how cmd.exe
decides what environment variables to export to subprocesses.

>  c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"
> 
> 2) cmd.exe with the windows temp dir as you specify:
>  c:\temp> TEMPDIR=c:\windows\temp
>  c:\temp> git svn clone "file:///x:/path/to/repo/trunk/utils/project1"
> 
> 3) git's bash.exe with inline variable definition:
>  $ TEMPDIR=c:/Windows/Temp git svn clone "file:///x:/path/to/repo/trunk/utils/project1"
> 
> 4) git's bash.exe with exported variable:
>  $ export TEMPDIR=c:/Windows/Temp
>  $ git svn clone "file:///x:/path/to/repo/trunk/utils/project1"
> 
> All of them died with the complaint about "/tmp/report.tmp"
> 
> Thanks for the suggestion though.  At least we've determined one
> thing that *isn't* the issue ;-)
