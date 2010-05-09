From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Sun, 9 May 2010 20:47:24 +0400
Organization: '
Message-ID: <20100509164723.GA4638@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005090041.11864.jnareb@gmail.com> <20100509093100.GA7641@dcvr.yhbt.net> <201005091439.26310.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 18:47:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB9fY-0001xV-6v
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 18:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab0EIQru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 12:47:50 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:53869 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753727Ab0EIQrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 12:47:49 -0400
Received: from localhost (unknown [222.107.34.53])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 267555A81;
	Sun,  9 May 2010 20:36:09 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005091439.26310.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146727>

I'm face to face with Jakub who sold the world?
2010/05/09 14:39:23 +0200 Jakub Narebski <jnareb@gmail.com> => To Eric Wong :

JN> Yes, it can.  CGI::Compile is used for example by CGI::Emulate::PSGI,
JN> and you can run PSGI app on standalone Perl web server (pure Perl
JN> HTTP::Server::PSGI, or HTTP::Server::Simple::PSGI which in turn uses
JN> HTTP::Server::Simple, or Starman, or Twiggy, or Perlbal).  CGI::Compile
JN> just compiles given CGI script into a subroutine, which can be called
JN> many times in a persistent web environment like FastCGI.

Thanks a lot about that!
I took a quick look at the patches and see this:
- FastCGI people are not always happy with CGI.pm anmd thus with CGI::Fast that
  derives from it. They prefer CGI::Simple, e. g. for the Catalyst on fastcgi
and other CGI.pm replacements. Despite the CGI::Fast is somehow the part of the
perl core distribution the FCGI.pm and CGI.pm which are the required
dependencies are not. Needless to say that the CGI.pm is not at all ( because
it tries too much to be ) a 'killer app'. I myself is about to stop using
CGI::Fast in FCGI::Spawn in favor of regular FCGI.pm and the CGI.pm variant
chosen by the user. Needless to say that this can make the CGI.pm patching for
FCGI::Spawn unecessary.
- FCGI::ProcManager is a piece of cake in any way, but there are 'more than one
  way to do it' (c) and it should be mentioned on a docs as a dependency since
there are modules on CPAN too for the same purpose but promiseful of features
like OO/etc.

The special thank for getting rid of exit()!

I'd like to propose the Git to have the Perl interface for common functions
that can make it easy to create trhe bunch of tools like those made with
(likely XS'ed) SVN:* namespace, e. g. git-svn. It makes me wonder why gitweb is
packaged with Git but no Perl API seen: looks like its storage is simple enough
to realize all of that in PP. Don't just disappoint me saying that git is used
to be exec()'uted on some of the gitweb calls. ;)

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
