From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Use Merged response instead of Update-existing for merged files
Date: Fri, 09 Mar 2007 17:37:14 -0800
Message-ID: <7v4pot281h.fsf@assigned-by-dhcp.cox.net>
References: <11731741443228-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqWR-000127-Ow
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767706AbXCJBhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767712AbXCJBhR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:37:17 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64663 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767706AbXCJBhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:37:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310013715.ILDL3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 20:37:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YpdE1W00J1kojtg0000000; Fri, 09 Mar 2007 20:37:15 -0500
In-Reply-To: <11731741443228-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Tue, 6 Mar 2007 10:42:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41833>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> Using Update-existing leads to the client forgetting about the "locally
> modified" status of the file which can lead to loss of local changes on
> later updates.

To me, both of these hunks look correct (the first one is clean
merge, the second one is merge with conflicts).  Ack?

> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> ---
>  git-cvsserver.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 1bf892e..65fcc84 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -957,12 +957,12 @@ sub req_update
>              {
>                  $log->info("Merged successfully");
>                  print "M M $filename\n";
> -                $log->debug("Update-existing $dirpart");
> +                $log->debug("Merged $dirpart");
>  
>                  # Don't want to actually _DO_ the update if -n specified
>                  unless ( $state->{globaloptions}{-n} )
>                  {
> -                    print "Update-existing $dirpart\n";
> +                    print "Merged $dirpart\n";
>                      $log->debug($state->{CVSROOT} . "/$state->{module}/$filename");
>                      print $state->{CVSROOT} . "/$state->{module}/$filename\n";
>                      my $kopts = kopts_from_path($filepart);
> @@ -978,7 +978,7 @@ sub req_update
>                  # Don't want to actually _DO_ the update if -n specified
>                  unless ( $state->{globaloptions}{-n} )
>                  {
> -                    print "Update-existing $dirpart\n";
> +                    print "Merged $dirpart\n";
>                      print $state->{CVSROOT} . "/$state->{module}/$filename\n";
>                      my $kopts = kopts_from_path($filepart);
>                      print "/$filepart/1.$meta->{revision}/+/$kopts/\n";
> -- 
> 1.5.0.2
