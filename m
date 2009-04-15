From: E R <pc88mxer@gmail.com>
Subject: integrating make and git
Date: Wed, 15 Apr 2009 10:19:31 -0500
Message-ID: <3a69fa7c0904150819x7598dea5ic43bf0991c35ae45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 17:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu71R-0005v0-GD
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 17:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbZDOPZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbZDOPZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 11:25:58 -0400
Received: from mail-qy0-f107.google.com ([209.85.221.107]:38152 "EHLO
	mail-qy0-f107.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZDOPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 11:25:58 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2009 11:25:57 EDT
Received: by qyk5 with SMTP id 5so839743qyk.33
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=cjxXjaJGStkEV8pWholbospvSj0GIztDtax5BXJLslg=;
        b=sPFZA3bGxHsek1sTphlITRp9uiWw1RAflWblY1ILiquP39+3rsoAjnA08A5aI7mNme
         tQfh1hJaMBR462diVP7lXEkgDqug2adOMcFtabLbfGH2auTvKx8tDpzFrarE3nxGvFwW
         IFn5aoT8+dR7S18uMZdBunIut5DprOT49NQ6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=D9MbU0zfmlXxVvLaJaECyDqKva8CMlt7spq0z+oRivHZnxHontRrqT1sP67rAflfN7
         A1b27FdkucaUF+bxLzuP88vtZ2Jo+yCencIsYoLxwcV35TYS5NUZmM8UMmFENRYmA34x
         kYQnor5stpBeL4/6rTWSveVZgXxC1x/33RybE=
Received: by 10.220.77.1 with SMTP id e1mr69518vck.91.1239808771994; Wed, 15 
	Apr 2009 08:19:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116614>

I have an idea about integrating make with git, and I'm wondering if
it is a reasonable thing to do.

First of all, I am under the impression that git can quickly compute a
hash of a directory and its contents. Is that correct?

If so, suppose you using git to manage revision control of a project
which has some components like 'lib1', 'lib2', etc. Typically you
would perform something like: make clean; make all and 'make all'
would perform 'make lib1' and 'make lib2'. When checking out a
different revision of the project you would have to perform another
'make clean' before 'make all' since you aren't sure of what's changed
and the timestamps of the derived files will be more recent than the
timestamps of the source files.

Now suppose that making 'lib1' only depends on the source code in a
certain directory. The idea is to associate the hash of the source
directory for lib1 with its the derived files. Make can check this to
determine if the component really needs to be rebuilt. Then as you
move around in the repository you can avoid rebuilding components that
haven't changed.

Good, bad, ugly?
