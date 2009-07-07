From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: =?ISO-8859-1?Q?Schr=F6dinger=27s_diff?=
Date: Tue, 07 Jul 2009 09:28:13 +0200
Message-ID: <4A52F90D.7080305@viscovery.net>
References: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 09:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO56K-0006oc-MO
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 09:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbZGGH2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 03:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbZGGH2Q
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 03:28:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33919 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZGGH2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 03:28:15 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MO565-00021C-AD; Tue, 07 Jul 2009 09:28:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E390155DD; Tue,  7 Jul 2009 09:28:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <279b37b20907062353k34bca06erf035458e80933c8d@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122826>

Eric Raible schrieb:
> Sometimes it does, and sometimes it doesn't (seems to be about
> 50/50).  But either way in any given repo rerunning the git-diff will
> always give the same result.
> 
> Doing an "git ls-tree HEAD" gives an identical tree in both cases.
> 
> Can anyone explain why the output to this is not deterministic?
> I'm at a complete loss.
> 
> 	# Clean up from last run and start over
> 	rm -rf .git has-crlf
> 	git init
> 	git config core.autocrlf false
> 
> 	# Add a "bad" file
> 	perl -e 'printf( "12%c%c", 0xd, 0xa )' > has-crlf
> 	git add has-crlf
> 	git commit -m"add crlf"
> 
> 	# I realize that switching is ill-advised, but I'm
> 	# trying to track down a possibly related problem...
> 	git config core.autocrlf true
> 
> 	# This sometimes produces output and sometimes it doesn't.
> 	# Either way rerunning just git-diff always gives the same result
> 	# as the first run in this repo.
> 	git diff

If I put this in a script, I get a diff in 9 out of 10 runs. If I insert
'sleep 1' right before the 'git add', I never get a diff.

I'm handing this off to people who care about core.autocrlf and who know
how racily-clean index entries (not) work ;)

-- Hannes
