From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 20:29:25 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802182025340.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802181627340.30505@racer.site> <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org> <47B9D484.1020304@catalyst.net.nz>
 <alpine.LSU.1.00.0802181942230.30505@racer.site> <47B9E561.8040605@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:30:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCcx-0002Cw-BL
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYBRU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYBRU3j
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:29:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:45675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751319AbYBRU3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:29:38 -0500
Received: (qmail invoked by alias); 18 Feb 2008 20:29:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 18 Feb 2008 21:29:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/AraY8T1bAfT+T85em5C1/SDeKZcOZVv/yAKL4ml
	Mr4zb0RKBuXliS
X-X-Sender: gene099@racer.site
In-Reply-To: <47B9E561.8040605@catalyst.net.nz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74340>

Hi,

On Tue, 19 Feb 2008, Martin Langhoff wrote:

> Johannes Schindelin wrote:
>
> > Well, please try for yourself.  If it works for you, then I probably 
> > had another error in my patch.
> 
> $ perl -MFile::Basename -e 'print basename("/foo/bar/baz");'
> baz
> 
> Johannes, what are you smoking? No PUI here! ;-)

Unfortunately, I am not smoking, because my throat is inflamed...

Checked again, and sure enough, it works.  So, this is a replacement patch 
to be squashed in... So: I'm sorry...

Ciao,
Dscho

-- snipsnap --
 git-cvsexportcommit.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index c00368b..b8114f7 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -207,8 +207,7 @@ if (@canstatusfiles) {
       my @canstatusfiles2 = ();
       my %fullname = ();
       foreach my $name (keys %todo) {
-	my $basename = $name;
-	$basename =~ s/.*\///;
+	my $basename = basename($name);
 	$basename = "no file " . $basename if (exists($added{$basename}));
 	chomp($basename);
 
