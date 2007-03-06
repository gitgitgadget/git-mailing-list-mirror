From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 6 Mar 2007 04:39:17 -0500
Message-ID: <20070306093917.GA1761@coredump.intra.peff.net>
References: <45ECE700.8090205@freescale.com> <7v649euai8.fsf@assigned-by-dhcp.cox.net> <8fe92b430703060134l14fffcc4rbece3c2071c56422@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Li Yang <leoli@freescale.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOW93-0005km-Tp
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 10:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbXCFJjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 04:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbXCFJjW
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 04:39:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2127 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030473AbXCFJjW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 04:39:22 -0500
Received: (qmail 8776 invoked from network); 6 Mar 2007 04:39:37 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 6 Mar 2007 04:39:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2007 04:39:17 -0500
Content-Disposition: inline
In-Reply-To: <8fe92b430703060134l14fffcc4rbece3c2071c56422@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41565>

On Tue, Mar 06, 2007 at 10:34:32AM +0100, Jakub Narebski wrote:

> >Regardless of the recent xhtml+html vs html discussion, I think
> >this is probably a sane change.  Comments?
> Good (although a bit magic) solution. Ack, FWIW.

I think this should do the same, and is perhaps less magic (or maybe
more, depending on your perspective).

-Peff

-- >8 --
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 653ca3c..5d1d8cf 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -17,6 +17,7 @@ use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
+CGI::autoEscape(1);
 
 BEGIN {
        CGI->compile() if $ENV{MOD_PERL};
