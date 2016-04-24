From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: 0 bot for Git
Date: Sun, 24 Apr 2016 14:19:21 +0200
Message-ID: <1461500361-25913-1-git-send-email-szeder@ira.uka.de>
References: <alpine.DEB.2.20.1604240908200.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 24 14:24:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auJ53-0001JI-UU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 14:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbcDXMTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 08:19:45 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42073 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316AbcDXMTp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 08:19:45 -0400
Received: from x4db27354.dyn.telefonica.de ([77.178.115.84] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1auJ0f-0004nA-QE; Sun, 24 Apr 2016 14:19:35 +0200
X-Mailer: git-send-email 2.8.1.99.g5d5236f
In-Reply-To: <alpine.DEB.2.20.1604240908200.2896@virtualbox>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461500375.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292319>


> > Don't worry; I didn't feel offended.  The Travis stuff running on
> > the branches at http://github.com/git/git would surely catch issues
> > on MacOSX and/or around git-p4 (neither of which I test myself when
> > merging to 'pu') before they hit 'next', and that is already helping
> > us greatly.
> 
> I agree that it helps to catch those Mac and P4 issues early.
> 
> However, it is possible that bogus errors are reported that might not have
> been introduced by the changes of the PR, and I find it relatively hard to
> figure out the specifics. Take for example
> 
> 	https://travis-ci.org/git/git/jobs/124767554
> 
> It appears that t9824 fails with my interactive rebase work on MacOSX,
> both Clang and GCC versions. I currently have no access to a Mac for
> developing (so I am denied my favorite debugging technique: sh t... -i -v
> -x), and I seem to be unable to find any useful log of what went wrong
> *specifically*.
> 
> Any ideas how to find out?

You could patch .travis.yml on top of your changes to run only t9824
(so travis-ci returns feedback faster) and to run it with additional
options '-i -x', push it to github, and await developments.  I'm not
saying it's not cumbersome, because it is, and the p4 cleanup timeout
loop with '-x' is particularly uninteresting...  but it works, though
in this case '-x' doesn't output anything useful.

You could also check how independent branches or even master are
faring, and if they fail at the same tests, like in this case they do,
then it's not your work that causes the breakage.

It seems you experience the same breakage that is explained and fixed
in this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/291917
