From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH] Support \ in non-wildcard .gitignore entries
Date: Tue, 10 Feb 2009 13:58:00 +0100
Message-ID: <20090210125800.GA14800@pvv.org>
References: <20090210121149.GA1226@pvv.org> <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 14:00:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsD7-0002ei-3v
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZBJM6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZBJM6E
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:58:04 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:37323 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZBJM6D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:58:03 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LWsBc-0004H9-B5; Tue, 10 Feb 2009 13:58:00 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109228>

On Tue, Feb 10, 2009 at 01:56:36PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 10 Feb 2009, Finn Arne Gangstad wrote:
> 
> > If you had an exclude-pattern with a backslash in it, e.g. "\#foo",
> > this would not work, since git would do a strcmp of the exclude pattern
> > and the filename. Only wildcard patterns were matched with fnmatch,
> > which does the right thing with backslashes. We now also treat all patterns
> > containing backslashes as wildcards.
> > 
> > De-escaping the pattern while reading the .gitignore file is error prone,
> > since that would break patterns with both backslashes and wildcards.
> > E.g. "\\*.c" would be translated to "\*.c" before fnmatch got it,
> > and would change the meaning of the rule dramatically.
> 
> I am not sure I understand (maybe a test case would help, but that test 
> case would have to be disabled on Windows, I guess):
> 
> You mean that '\#abc' would match '\#abc', but '\#abc*' would not?

Currently, \#abc does not match a file named #abc, but \#abc* does.
With the patch, both will match.

- Finn Arne
