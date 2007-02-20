From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Mechanical conversion to use prefixcmp()
Date: Tue, 20 Feb 2007 12:53:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201243000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702191839.05784.andyparkins@gmail.com>
 <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net> <200702200942.18654.andyparkins@gmail.com>
 <7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 12:53:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJTYv-00066K-Hx
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 12:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbXBTLxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 06:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbXBTLxe
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 06:53:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:52918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964842AbXBTLxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 06:53:34 -0500
Received: (qmail invoked by alias); 20 Feb 2007 11:53:32 -0000
X-Provags-ID: V01U2FsdGVkX195YqhzS3d5wpS0pQ3auSpx7IZiO/4OIk6K2jsgCi
	3S4g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b51xihy.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40233>

Hi,

On Tue, 20 Feb 2007, Junio C Hamano wrote:

>    #!/usr/bin/perl -i.bak -p
>    if (/strncmp\(([^,]+), "([^\\"]*)", (\d+)\)/ && (length($2) == $3)) {
>            s|strncmp\(([^,]+), "([^\\"]*)", (\d+)\)|prefixcmp($1, "$2")|;
>    }
>    if (/strncmp\("([^\\"]*)", ([^,]+), (\d+)\)/ && (length($1) == $3)) {
>            s|strncmp\("([^\\"]*)", ([^,]+), (\d+)\)|(-prefixcmp($2, "$1"))|;
>    }

Ha, I did it by

$ perl -pi.bup -e \
 's/strncmp\( *("[^"]*"), *([^"]*), *[0-9]* *\)/prefixcmp\($2, $1\)/g' \
 $(git ls-files)

and

$ perl -pi.bup -e \
 's/strncmp\( *([^"]*), *("[^"]*"), *[0-9]* *\)/prefixcmp\($1, $2\)/g' \
 $(git-ls-files)

Of course, I missed the two ,ofs ones, but a git grep -n strncmp brought 
these up.

Ciao,
Dscho
