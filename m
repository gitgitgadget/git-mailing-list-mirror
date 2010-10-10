From: Arnout Engelen <arnouten@bzzt.net>
Subject: Re: [PATCH] log which temporary file could not be created
Date: Sun, 10 Oct 2010 12:33:28 +0200
Message-ID: <20101010103327.GO9348@bzzt.net>
References: <20101009201751.GK9348@bzzt.net> <20101010024124.GA20305@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 12:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4tE0-0002VE-JB
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 12:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711Ab0JJKdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 06:33:33 -0400
Received: from smtp-1.concepts.nl ([213.197.30.124]:43022 "EHLO
	smtp-1.concepts.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab0JJKdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 06:33:33 -0400
Received: from 5ee5397b.ftth.concepts.nl
	([94.229.57.123] helo=mail.bzzt.net ident=Debian-exim)
	by smtp-1.concepts.nl with esmtp (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P4tDc-0004dp-4L; Sun, 10 Oct 2010 12:33:28 +0200
Received: from arnouten by localhost with local (Exim 4.69)
	(envelope-from <arnouten@bzzt.net>)
	id 1P4tDc-0004Ii-3O; Sun, 10 Oct 2010 12:33:28 +0200
Content-Disposition: inline
In-Reply-To: <20101010024124.GA20305@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: arnouten@bzzt.net
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-Concepts-MailScanner-Information: Please contact abuse@concepts.nl for more information
X-Concepts-MailScanner-ID: 1P4tDc-0004dp-4L
X-Concepts-MailScanner: Found to be clean
X-Concepts-MailScanner-SpamCheck: 
X-Concepts-MailScanner-From: arnouten@bzzt.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158653>

On Sat, Oct 09, 2010 at 09:41:24PM -0500, Jonathan Nieder wrote:
> Arnout Engelen wrote:
> > When creating a temporary file, log the template.
> 
> Since mkstemp modifies its template, these hopefully would print the
> actual filename on errors.  Examples:
> 
> 	fatal: Unable to create temporary file '.merge_file_Sc7R5c': File exists
> 	fatal: Unable to create temporary file 'newrepo/.git/tOWHcxk': No space left on device

Perhaps we should also log the current working directory when the temporary 
filename is relative?

> Unfortunately some mkstemp()s (such as that used to implement
> git_mkstemp_mode()) clear the template on error, which would result in
> 
> 	fatal: Unable to create temporary file '': Permission denied
> 
> What should git do in this situation?

Perhaps we should strdup() the template before mkstemp(), and log the 
strdup()'ed template when the original has been cleared?


Arnout
