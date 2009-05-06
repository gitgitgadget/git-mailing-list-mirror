From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Fix sloppy Getopt::Long.
Date: Wed, 6 May 2009 09:13:09 -0700
Message-ID: <20090506161309.GC10702@curie-int>
References: <1241547374-6737-1-git-send-email-robbat2@gentoo.org> <7vljpazuyg.fsf@alter.siamese.dyndns.org> <20090506064949.GB29479@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 06 18:13:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1jkl-0001O6-0N
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 18:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759893AbZEFQNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 12:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759759AbZEFQNS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 12:13:18 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:57211 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755442AbZEFQNR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 12:13:17 -0400
Received: (qmail 23461 invoked from network); 6 May 2009 16:13:12 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 06 May 2009 16:13:12 +0000
Received: (qmail 5342 invoked by uid 10000); 6 May 2009 09:13:09 -0700
Content-Disposition: inline
In-Reply-To: <20090506064949.GB29479@dcvr.yhbt.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118352>

On Tue, May 05, 2009 at 11:49:49PM -0700, Eric Wong wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > "Robin H. Johnson" <robbat2@gentoo.org> writes:
> > 
> > > Getopt-Long v2.38 is much stricter about sloppy getopt usage. The
> > > trailing pipe causes git-svn testcases to fail for all of the --stdin
> > > argument calls.
> > >
> > > Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
> > 
> > Eric, I'll take this directly to my tree.  Ok?
> 
> The empty "" after the "|" was intended for the set-tree command to take
> a lone "-" as a parameter to also mean "--stdin".
> 
> The following should work, too, but I don't have time to test right now:
> 
> +			{ '' => \$_stdin, 'stdin' => \$_stdin,
> +			  %cmt_opts, %fc_opts, } ],
I confirm that it does correctly set the $_stdin variable (tested
briefly).

Testcase:
=====
use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
my $_stdin;
my $rc = GetOptions( 'stdin' => \$_stdin, '' => \$_stdin);
printf "rc:%s s:%s\n",$rc,$_stdin;
=====

-- 
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
