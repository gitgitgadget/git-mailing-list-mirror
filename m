From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Change to use explicitly function call cgi->escapHTML()
Date: Tue, 06 Mar 2007 01:46:31 -0800
Message-ID: <7vwt1ur9fs.fsf@assigned-by-dhcp.cox.net>
References: <45ECE700.8090205@freescale.com>
	<7v649euai8.fsf@assigned-by-dhcp.cox.net>
	<8fe92b430703060134l14fffcc4rbece3c2071c56422@mail.gmail.com>
	<20070306093917.GA1761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Li Yang <leoli@freescale.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 10:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOWFf-0000Kc-Kp
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 10:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbXCFJqe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 04:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbXCFJqd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 04:46:33 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63097 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030503AbXCFJqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 04:46:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306094632.WZCL1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 04:46:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XMmY1W0021kojtg0000000; Tue, 06 Mar 2007 04:46:32 -0500
In-Reply-To: <20070306093917.GA1761@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 6 Mar 2007 04:39:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41566>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 06, 2007 at 10:34:32AM +0100, Jakub Narebski wrote:
>
>> >Regardless of the recent xhtml+html vs html discussion, I think
>> >this is probably a sane change.  Comments?
>> Good (although a bit magic) solution. Ack, FWIW.
>
> I think this should do the same, and is perhaps less magic (or maybe
> more, depending on your perspective).
>
> -Peff

Thanks.  I tend to agree, as it does not depend on the reader
knowing what magic $cgi default behaviour is by being
expliicit.

>
> -- >8 --
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 653ca3c..5d1d8cf 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -17,6 +17,7 @@ use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
>  binmode STDOUT, ':utf8';
> +CGI::autoEscape(1);
>  
>  BEGIN {
>         CGI->compile() if $ENV{MOD_PERL};
