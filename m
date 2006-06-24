From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [Patch] trap: exit: invalid signal specification
Date: Sat, 24 Jun 2006 18:57:41 +0200
Message-ID: <E1FuBS1-0006RF-O8@moooo.ath.cx>
References: <200606240410.18334.caglar@pardus.org.tr> <7vejxf5ktc.fsf@assigned-by-dhcp.cox.net> <200606241555.03147.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 18:58:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuBS8-00059c-GF
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 18:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWFXQ5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 12:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWFXQ5p
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 12:57:45 -0400
Received: from moooo.ath.cx ([85.116.203.178]:56967 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750894AbWFXQ5p (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 12:57:45 -0400
To: =?iso-8859-1?B?Uy7HYT8/bGFy?= Onur <caglar@pardus.org.tr>
Mail-Followup-To: =?iso-8859-1?B?Uy7HYT8/bGFy?= Onur <caglar@pardus.org.tr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200606241555.03147.caglar@pardus.org.tr>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22523>

> As an example bash (v. 3.1.17) permits lowercase signal names but it converts 
> this lowercase signal names into uppercase ones while interpreting the 
> script. But for our "Turkish has 4 letter "I"s" problem this convert to 
> uppercase one process fails but for bash invalid signal names not be 
> considered a syntax error and do not cause the shell to abort. 

It is ``trap <action> <signal>'' so for the signal part this may be
right that this is made uppercase. But action is not modified I guess.
So it should be exit because there is no built-in named EXIT in
bash:

$ type exit
exit is a shell builtin
$ type EXIT
bash: type: EXIT: not found

So for me it does not seem to work:

$ trap 'err=$?; echo trap; EXIT $?' 0
$ exit 5
exit
trap
bash: EXIT: command not found
[1]    12906 exit 5     bash
