From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git-cvsimport: $cvs->file() fails silently
Date: Thu, 27 Oct 2005 17:23:19 +1300
Message-ID: <46a038f90510262123y4f56cf7v5494b391394ac648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Oct 27 06:24:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUzIo-0004n0-Bg
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 06:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVJ0EXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 00:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVJ0EXV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 00:23:21 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:42044 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964964AbVJ0EXU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 00:23:20 -0400
Received: by xproxy.gmail.com with SMTP id i30so585665wxd
        for <git@vger.kernel.org>; Wed, 26 Oct 2005 21:23:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IPGveEpm7Zd/pzzckTkBOJa1Hpw1NeL4/BCltAehbyC0/jZYqwS/4zgvqFeelMytz9drdopXN0SedYQ8ew2Pqgoo2dwVU0+02bOTGm5ziW0o3sXSp+l1fLoX1g6igdOC7O5qSLAzl7EvZrEXBI4wMNyaEjwHmkhJythFWDG4qVw=
Received: by 10.65.61.17 with SMTP id o17mr1330190qbk;
        Wed, 26 Oct 2005 21:23:19 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 26 Oct 2005 21:23:19 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>,
	Sven Verdoolaege <skimo@kotnet.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10697>

We have seen a few instances of files extracted from a remote CVS repo
by $cvs->file() being empty, and still git-cvsimport did not die or
complain. If I rewind the affected head and re-run git-cvsimport, the
file is imported correctly, which makes me suspect that the server
went away or there was some other networking glitch, and that the
file() and _file() methods didn't handle it gracefully.

I've been through the file(), _file() and _line() methods, and they
seem pretty conservative -- they die or return undef in all the right
places. There _must_ be one place that we're missing but I just can't
see it.

Any ideas?



martin
