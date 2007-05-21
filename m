From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/3] t9400: Add test cases for config file handling
Date: Mon, 21 May 2007 18:31:45 +0200
Message-ID: <20070521163145.GM4085@planck.djpig.de>
References: <11797003182642-git-send-email-frank@lichtenheld.de> <7vlkfjhu2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 18:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqAnf-00043L-OX
	for gcvg-git@gmane.org; Mon, 21 May 2007 18:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbXEUQbw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 12:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755747AbXEUQbw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 12:31:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:4641 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbXEUQbv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 12:31:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 8F95888060;
	Mon, 21 May 2007 18:31:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rL5ise73GTsz; Mon, 21 May 2007 18:31:45 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 7658F88105; Mon, 21 May 2007 18:31:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vlkfjhu2w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48025>

On Sun, May 20, 2007 at 05:57:27PM -0700, Junio C Hamano wrote:
> This part seems to fail for me and gets an "unexpected cvs success".

Note the note in the patch ;)

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index fcfb99d..1de5177 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -192,11 +192,9 @@ sub req_Root
>          }
>      }
>  
> -    unless ( ($cfg->{gitcvs}{$state->{method}}{enabled}
> -	      and $cfg->{gitcvs}{$state->{method}}{enabled} =~ /^\s*(1|true|yes)\s*$/i)
> -	     or ($cfg->{gitcvs}{enabled}
> -	      and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i) )
> -    {
> +    my $enabled = ($cfg->{gitcvs}{$state->{method}}{enabled}
> +		   || $cfg->{gitcvs}{enabled});
> +    unless ($enabled && $enabled =~ /^\s*(1|true|yes)\s*$/i) {
>          print "E GITCVS emulation needs to be enabled on this repo\n";
>          print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
>          print "E \n";


Yeah, should probably have fixed that myself before sending, but the
other patches were already prepared ;)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
