From: mmogilvi_git@miniinfo.net
Subject: Re: [PATCH] cvsserver: make the output of 'update' more compatible with cvs.
Date: Sat, 5 Dec 2009 16:48:31 -0700
Message-ID: <20091205234831.GA925@comcast.net>
References: <87zl5z4y0w.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 00:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH4Mq-0000UG-RK
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 00:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbZLEXs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbZLEXs2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 18:48:28 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:53855 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932322AbZLEXs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 18:48:27 -0500
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id DbYW1d0020QkzPwA2bobvX; Sat, 05 Dec 2009 23:48:35 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA02.emeryville.ca.mail.comcast.net with comcast
	id Dboa1d0015FCJCg8NboacM; Sat, 05 Dec 2009 23:48:35 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 1F0B789115; Sat,  5 Dec 2009 16:48:32 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <87zl5z4y0w.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134637>

On Thu, Dec 03, 2009 at 11:12:47PM +0300, Sergei Organov wrote:
>  
> +    my $last_dirname = "///";
> +    
>      # foreach file specified on the command line ...
>      foreach my $filename ( @{$state->{args}} )
>      {
>          $filename = filecleanup($filename);
> +        my $cur_dirname = dirname($filename);
> +        if ( $cur_dirname ne $last_dirname )
> +        {
> +            $last_dirname = $cur_dirname;
> +            if ( $cur_dirname eq "" )
> +            {
> +                $cur_dirname = ".";
> +            }
> +            print "E cvs update: Updating $cur_dirname\n";
> +        }
>  
>          $log->debug("Processing file $filename");

This should probably be conditional on the absense of the
global "cvs -q update" and "cvs -Q update" options, in case
other CVS clients depend on quiet operation when they specify
those options.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
