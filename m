From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn bug with blank commits and author file
Date: Tue, 22 Apr 2008 16:23:39 -0700
Message-ID: <20080422232339.GB3532@hand.yhbt.net>
References: <480DB8F3.5080000@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Wed Apr 23 01:24:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoRqc-0002uZ-Gz
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 01:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbYDVXXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 19:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYDVXXk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 19:23:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59807 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbYDVXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 19:23:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 731172DC08C;
	Tue, 22 Apr 2008 16:23:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <480DB8F3.5080000@aei.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80173>

Thomas Guyot-Sionnest <dermoth@aei.ca> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> * Sorry for resending; added a patch tag and corrected typo in subject *
> 
> When trying to import from svn using an author file, git-svn bails out
> if it encounters a blank author. The attached patch changes this
> behavior and allow using the author file with blanks authors.
> 
> I came across this bug while importing from a cvs2svn repo where the
> initial revision (1) has a blank author. This doesn't break the behavior
> of bailing out when an unknown author is encountered.
> 
> The patch was made against Git's HEAD.
> 
> If you reply please make sure to cc me as I'm not subscribed to the list.

Thank you Thomas,

Sorry for the latency, I've been overloaded

Acked-by: Eric Wong <normalperson@yhbt.net>

> - --
> Thomas Guyot
> dermoth@aei.ca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQFIDbjz6dZ+Kt5BchYRAjdFAJ0WA9TiIJ6tefjaPkd40Y2Tjv6NPACbBwmB
> a6eFU84MpJ9MW1nErxDiqHY=
> =k3jA
> -----END PGP SIGNATURE-----

> --- git-svn.perl.orig	2008-04-19 05:58:10.000000000 -0400
> +++ git-svn.perl	2008-04-19 19:50:40.000000000 -0400
> @@ -2375,8 +2375,7 @@
>  	my ($author) = @_;
>  	if (!defined $author || length $author == 0) {
>  		$author = '(no author)';
> -	}
> -	if (defined $::_authors && ! defined $::users{$author}) {
> +	} elsif (defined $::_authors && ! defined $::users{$author}) {
>  		die "Author: $author not defined in $::_authors file\n";
>  	}
>  	$author;
> 
