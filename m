From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Mon, 18 Feb 2008 18:50:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181849410.30505@racer.site>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802181627340.30505@racer.site> <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRB59-0000tw-3Y
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbYBRSuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 13:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbYBRSuj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:50:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:50806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751688AbYBRSui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 13:50:38 -0500
Received: (qmail invoked by alias); 18 Feb 2008 18:50:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 18 Feb 2008 19:50:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/nN0DQHu/mNqGs4jJ/jDco4OHmLN+lvuHcggSdT
	XbiK2MAwNRfC9e
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74329>

Hi,

On Mon, 18 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The script uses File::Basename upfront so perhaps just simply...
> >
> > I tried that.  But as the file need not exist, "basename" went on 
> > strike.
> >
> > So I'll keep the (ugly) version.
> 
> The reason why "basename" is not being used needs documented in the code 
> then.  The next person will likely to make the same mistake as I did.

Right.  Could you be so good and squash this in, then, please?

Thanks,
Dscho

-- snipsnap --
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index c00368b..6eff42c 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -208,6 +208,7 @@ if (@canstatusfiles) {
       my %fullname = ();
       foreach my $name (keys %todo) {
 	my $basename = $name;
+	# cannot use basename(), since $name need not exist in the CVS tree
 	$basename =~ s/.*\///;
 	$basename = "no file " . $basename if (exists($added{$basename}));
 	chomp($basename);
