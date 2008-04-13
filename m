From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: Test suite failures due to Error.pm issues.
Date: Sat, 12 Apr 2008 20:04:57 -0700
Message-ID: <20080413030457.GA12747@net-ronin.org>
References: <20080408221853.GA3819@net-ronin.org> <b77c1dce0804090134j514811d7mbffdc73dee5a90b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 05:06:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JksXo-0002RQ-KP
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 05:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYDMDFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 23:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYDMDFN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 23:05:13 -0400
Received: from brak.cowlabs.com ([208.96.51.45]:48023 "EHLO brak.cowlabs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356AbYDMDFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 23:05:12 -0400
Received: from prophet.net-ronin.org (S0106000ea6c7835e.no.shawcable.net [70.67.106.241])
	by brak.cowlabs.com (8.14.1/8.14.1) with ESMTP id m3D34xU1488657
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 13 Apr 2008 03:05:00 GMT
Received: from ramune by prophet.net-ronin.org with local (Exim 4.63)
	(envelope-from <ramune@net-ronin.org>)
	id 1JksWX-0003MF-Uf; Sat, 12 Apr 2008 20:04:57 -0700
Content-Disposition: inline
In-Reply-To: <b77c1dce0804090134j514811d7mbffdc73dee5a90b7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79387>

(Was on the road for work, so couldn't reply till now)

> The private Error file is not installed if perl/Makefile.PL detects
> than an Error.pm recent enough on your system. Do you actually have
> perl/blib/lib/Error.pm ? Try to run (cd perl; make clean; cd ..; make)
> and try the tests again.

ramune/lycaeum:git: locate Error.pm
/usr/local/stow/git-1.5.4.5/share/perl/5.8.8/Error.pm
/usr/share/perl5/Debconf/Element/Dialog/Error.pm
/usr/share/perl5/Debconf/Element/Editor/Error.pm
/usr/share/perl5/Debconf/Element/Gnome/Error.pm
/usr/share/perl5/Debconf/Element/Kde/Error.pm
/usr/share/perl5/Debconf/Element/Noninteractive/Error.pm
/usr/share/perl5/Debconf/Element/Teletype/Error.pm
/usr/share/perl5/Debconf/Element/Web/Error.pm
ramune/lycaeum:git: 

So... there's Error.pm files around, but I remember now having to copy it
over for previous versions of git.  Reporting it slipped my mind until now
(sorry).

After the:
 cd perl
 make clean
 cd ..
 make -j4
 make test

when git 1.5.4.5 is still in /usr/local/stow/git-1.5.4.5 and stow'd to
/usr/local, it passes.  So it looks like it was picking up the previous
Error.pm installed in the git directory from the previous installation.

So when it was stow -D'd, and the new git installed and stow'd, the Error.pm
went away (also, when the old git was stow -D'd before running the test).

Not sure what the right way to handle this is.  I may just make a note to
always copy over Error.pm, if it won't change in the git source.

-- DN
Daniel
