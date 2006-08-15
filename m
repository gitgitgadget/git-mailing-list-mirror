From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 8/9] gitweb: True fix: Support for the standard mime.types map in gitweb
Date: Mon, 14 Aug 2006 17:33:14 -0700
Message-ID: <7vlkpqbzxx.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com>
	<200608140216.34150.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 02:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCmrw-0002mv-5v
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 02:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWHOAdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 20:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWHOAdQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 20:33:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:2236 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932757AbWHOAdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 20:33:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815003315.KVLX14543.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 20:33:15 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608140216.34150.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 14 Aug 2006 02:16:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25429>

Jakub Narebski <jnareb@gmail.com> writes:

> True fix for error in mimetype_guess, error introduced in original commit
> 2d00737489b8c61ed616b261c7c9bd314e2b0b41 and later fixed temporarily
> by commenting out the line that caused error in commit
> 57bd4d3523efecf60197040cad34154aff4ddf80.
>
> Gitweb now supports mime.types map $mimetypes_file relative to project.

Care to explain what that commenting out was about?

>  	if ($mimetypes_file) {
>  		my $file = $mimetypes_file;
> -		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
> +		if ($file !~ m!^/!) { # if it is relative path
> +			# it is relative to project
> +			$file = "$projectroot/$project/$file";
> +		}
>  		$mime = mimetype_guess_file($filename, $file);

Are $project and $file always defined when we take this new
codepath?
