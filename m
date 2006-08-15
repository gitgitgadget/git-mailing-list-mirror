From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: git-mv is broken in master
Date: Tue, 15 Aug 2006 22:51:50 +0200
Message-ID: <20060815205150.GA467@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Aug 15 22:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD5tE-0006K8-4A
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 22:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWHOUvx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 16:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWHOUvx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 16:51:53 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:46299 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1750700AbWHOUvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 16:51:52 -0400
Received: from c165 ([213.114.27.99] [213.114.27.99])
          by mxfep01.bredband.com with ESMTP
          id <20060815205150.NOUI5813.mxfep01.bredband.com@c165>
          for <git@vger.kernel.org>; Tue, 15 Aug 2006 22:51:50 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1GD5t8-00008a-00
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 22:51:50 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25482>

Hi,

With the current master I get the following:

    $ git-mv README README-renamed
    fatal: can not move directory into itself, source=README, destination=README-renamed

Which is buggy. The culprit seems to be the test

    if (!bad &&
        !strncmp(destination[i], source[i], strlen(source[i])))
            bad = "can not move directory into itself";

at line ~207 in builtin-mv.c.


If the source isn't a prefix of the destination things works as expected,

    $ git mv README renamed-README
    $

- Fredrik
