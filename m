From: John Keeping <john@keeping.me.uk>
Subject: Re: Using clean/smudge filters with difftool
Date: Thu, 18 Jun 2015 15:28:52 +0100
Message-ID: <20150618142852.GL18226@serenity.lan>
References: <CAGA3++LiX9NyK94RPiuiG83X8FSRN4EkaxMchir51hGSQY90Tw@mail.gmail.com>
 <5582BA1F.1030409@drmicha.warpmail.net>
 <CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>
 <20150618132622.GJ18226@serenity.lan>
 <CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>
 <20150618141116.GK18226@serenity.lan>
 <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Florian Aspart <florian.aspart@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:39:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ayJ-0004Fr-TE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 16:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943AbbFROjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 10:39:06 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:50902 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbbFROjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 10:39:04 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2015 10:39:04 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 34F1D2A4B5;
	Thu, 18 Jun 2015 15:29:04 +0100 (BST)
X-Quarantine-ID: <SJf5XfnASHYj>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.499
X-Spam-Level: 
X-Spam-Status: No, score=-1.499 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SJf5XfnASHYj; Thu, 18 Jun 2015 15:29:02 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 25BE32DFDB;
	Thu, 18 Jun 2015 15:28:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272011>

On Thu, Jun 18, 2015 at 04:17:52PM +0200, Florian Aspart wrote:
> 2015-06-18 16:11 GMT+02:00 John Keeping <john@keeping.me.uk>:
> > On Thu, Jun 18, 2015 at 03:51:25PM +0200, Florian Aspart wrote:
> >> 2015-06-18 15:26 GMT+02:00 John Keeping <john@keeping.me.uk>:
> >> > [Please don't top-post on this list.]
> >> >
> >> > On Thu, Jun 18, 2015 at 03:15:38PM +0200, Florian Aspart wrote:
> >> >> 2015-06-18 14:31 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
> >> >> > Florian Aspart venit, vidit, dixit 16.06.2015 16:11:
> >> >> >> I created a clean filter to apply on some files before commiting them.
> >> >> >> The filter works correctly when I commit the file and is also applied
> >> >> >> when I usethe iff command line tool.
> >> >> >> However, when using difftool with meld, the filter is not applied and
> >> >> >> the different versions of the files are compared without any
> >> >> >> filtering.
> >> >> >>
> >> >> >> Is there a way to apply the clean/smudge filters when comparing the
> >> >> >> working copy of a file to the HEAD version in a gui diff tool?
> >> >> >>
> >> >> >> I'm using git version 2.4.3 under Ubuntu.
> > 
> > I also realised that the code for file diff is very different from
> > directory diff do you see any difference between git-difftool acting on
> > files and with the `--dir-diff` option?
> 
> No, even with the --dir-diff option, the filter is still not applied.

I have tried to reproduce this and it works as expected for me (i.e. the
filter is applied) both for file diff and directory diff mode:

$ git config filter.quote.clean "sed -e 's/^> //'"
$ git config filter.quote.smudge "sed -e '/^> /n; s/^/> /'"
$ git config filter.quote.required true

$ echo '*.quote filter=quote' >>.gitattributes
$ cat >1.quote <<EOF
one
two
three
EOF
$ git add .gitattributes 1.quote
$ git commit -m 'Initial commit'
$ echo four >>1.quote

Now `git-difftool` shows the differences with the filter applied.  This can be
seen running with GIT_TRACE:

$ GIT_TRACE=2 git difftool
15:26:59.211541 git.c:557               trace: exec: 'git-difftool'
15:26:59.211674 run-command.c:347       trace: run_command: 'git-difftool'
15:26:59.338617 git.c:348               trace: built-in: git 'config' '--bool' '--get' 'difftool.trustExitCode'
15:26:59.342664 git.c:348               trace: built-in: git 'diff'
15:26:59.344857 run-command.c:347       trace: run_command: 'sed -e '\''s/^> //'\'''
15:26:59.345383 run-command.c:195       trace: exec: '/bin/sh' '-c' 'sed -e '\''s/^> //'\''' 'sed -e '\''s/^> //'\'''
15:26:59.351077 run-command.c:347       trace: run_command: 'sed -e '\''/^> /n; s/^/> /'\'''
15:26:59.351605 run-command.c:195       trace: exec: '/bin/sh' '-c' 'sed -e '\''/^> /n; s/^/> /'\''' 'sed -e '\''/^> /n; s/^/> /'\'''
15:26:59.355716 run-command.c:347       trace: run_command: 'git-difftool--helper' '1.quote' '/tmp/SUEySx_1.quote' '4cb29ea38f70d7c61b2a3a25b02e3bdf44905402' '100644' '1.quote' '0000000000000000000000000000000000000000' '100644'
15:26:59.356191 run-command.c:195       trace: exec: 'git-difftool--helper' '1.quote' '/tmp/SUEySx_1.quote' '4cb29ea38f70d7c61b2a3a25b02e3bdf44905402' '100644' '1.quote' '0000000000000000000000000000000000000000' '100644'
15:26:59.370468 git.c:348               trace: built-in: git 'config' 'diff.tool'
15:26:59.373485 git.c:348               trace: built-in: git 'config' 'merge.tool'
15:26:59.378402 git.c:348               trace: built-in: git 'config' 'difftool.vimdiff.cmd'
15:26:59.381424 git.c:348               trace: built-in: git 'config' 'mergetool.vimdiff.cmd'
15:26:59.386623 git.c:348               trace: built-in: git 'config' '--bool' 'mergetool.prompt'
15:26:59.390198 git.c:348               trace: built-in: git 'config' '--bool' 'difftool.prompt'

I think the first run_command of `sed` is cleaning the working tree file
to figure out *if* it differs, then the second `sed` is smudging the
version in the index so that difftool can use it.
