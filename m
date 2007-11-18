From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: preserving mtime
Date: Sun, 18 Nov 2007 22:34:55 +1300
Message-ID: <46a038f90711180134j411bb9c9uf2476f564f9abb6@mail.gmail.com>
References: <473D63F9.4010201@inrim.it> <473D6DC6.8040804@op5.se>
	 <20071117182236.GD23659@blorf.net>
	 <20071118084511.GC16863@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wayne Davison" <wayne@opencoder.net>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgYc-0006jS-Eb
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbXKRJe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbXKRJe6
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:34:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:10320 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbXKRJe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 04:34:57 -0500
Received: by ug-out-1314.google.com with SMTP id z38so826485ugc
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=x667+A4aX+C2hglNj9QH04DE88//9TKfcv5dz/JVT+Y=;
        b=UsCAjD78wY91a4UcgmPJhcm5jYQh7mVprQtgjJFNg4/2aWSF9v1g/l8qtjgkJ6mfdkEgWG/IQtGDDrJ4BzexvAONUJ0Y03SPzHZYNyLCwR3UT8pd5H74iHBcEMcql6K8z36JF+YNvXinoqD9RppFp4zxPjA4zWGOMjek1AsE20g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUjfZIkM6V5nfk//Wn7j2E8ee2TnaK/HUHPdVZTYZovnBJtXPvGry4CPRA35/qkXYA7rsjxgK6CoG09p5EnLFxy5e51FiqEEBksZLKq3XnEGazhu8eMkek0BzQAqczvHxXNGplnhcFL5wsLXKKG3c0nvLFnoPU9nKJ/ppSn+k44=
Received: by 10.66.243.4 with SMTP id q4mr99894ugh.1195378495554;
        Sun, 18 Nov 2007 01:34:55 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 18 Nov 2007 01:34:55 -0800 (PST)
In-Reply-To: <20071118084511.GC16863@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65352>

On Nov 18, 2007 9:45 PM, Mike Hommey <mh@glandium.org> wrote:
> On Sat, Nov 17, 2007 at 10:22:36AM -0800, Wayne Davison wrote:
> > I wish that the initial clone would set the modification time to the
> > commit time.  It would make the intial checkout have a more accurate
> > representation of when a file was last changed instead of all files
...
> For completeness, it would make sense to do so every time you git
> checkout (like, when switching branches).

I do hope anyone doing those things is _very_ aware that the mtime
metadata has a specific meaning -- when did this specific file in this
filesystem last change -- and is used by many tools in that sense. You
are trying to use it for something else. Lots of things will break.

Like incremental backups, for example.

So no no NO. Not recommended. Stuff will break in new and surprising
ways. It'd be trivial to write a quick script that shows the data you
want from git in Perl/Python/etc. But don't use mtime. It's used for
other stuff. Actually used for other stuff. Don't replace that data
with time data you want to see, the actual users of mtime will break.

cheers,


m
