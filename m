From: John Keeping <john@keeping.me.uk>
Subject: Re: how do I ignore a directory for diff
Date: Sun, 5 Apr 2015 13:17:05 +0100
Message-ID: <20150405121705.GE21452@serenity.lan>
References: <BLU168-W455AD13F694F68E77DFD0EB4FF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "LongChair ." <longchair@hotmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 14:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yeja3-0004vK-Cl
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 14:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbbDEMXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 08:23:06 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:34628 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbDEMXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 08:23:04 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2015 08:23:04 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 0B45D1FD39;
	Sun,  5 Apr 2015 13:17:12 +0100 (BST)
X-Quarantine-ID: <bhv2H10pficx>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bhv2H10pficx; Sun,  5 Apr 2015 13:17:11 +0100 (BST)
Received: from serenity.lan (griffin.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 63E5B20181;
	Sun,  5 Apr 2015 13:17:07 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <BLU168-W455AD13F694F68E77DFD0EB4FF0@phx.gbl>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266803>

On Sun, Apr 05, 2015 at 11:31:54AM +0000, LongChair . wrote:
> I have been looking into ignoring a subdirectory of my tree for
> diffing with upstream.  I'll explain the situation below :
> 
> My tree is a fork of an upstream repo.  There is a specific directory
> in my tree lets call it foo/bar that i would like to ignore for diff.
> This directory includes only files that i added to my repo and is
> therefore irrelevant for diffing (i know all files in there have been
> added and are not in upstream). Having there in the diff is just
> making a lot of files to appear and that is confusing to see what is
> changed from upstream.
> 
> I have read the docs and found a way mentioning that i should add a
> line to .gitattributes with : foo/bar/* -diff
> 
> But this still lists the files in there when i'm diffing.
> 
> Is there any way to achieve this ? i cant find any clear explanation
> in the docs.

Since git-diff takes a pathspec you can use the exclude magic to exclude
certain directories like this:

	git diff upstream -- ':(top)' ':(exclude)foo/bar'

or equivalently:

	git diff upstream -- :/ ':!foo/bar'

The documentation for the pathspec syntax is in git-glossary(7).
