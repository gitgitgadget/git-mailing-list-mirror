From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sun, 01 Nov 2015 19:40:50 +0100
Message-ID: <vpqmvuxzhot.fsf@anie.imag.fr>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
	<vpqbnbfpc6p.fsf@anie.imag.fr> <5635D0B1.9040800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 19:41:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxYo-0006P7-JW
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbbKASky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:40:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37364 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbbKASkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:40:53 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tA1IemsX032720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 1 Nov 2015 19:40:48 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tA1Ieo8q011091;
	Sun, 1 Nov 2015 19:40:50 +0100
In-Reply-To: <5635D0B1.9040800@gmail.com> (Sebastian Schuberth's message of
	"Sun, 1 Nov 2015 09:43:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 01 Nov 2015 19:40:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tA1IemsX032720
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1447008048.56532@ODOfLOQgjwuS+NRsbnIj7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280651>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> However, the commit message says "to check if text files are stored
> normalized in the *repository*", yet the output refers to the index /
> cache. Is there a (potential) difference between line endings in the
> index and repo?

There is when you have staged changes that are not commited yet.

> Any I find it a bit confusing to refer to the index where, as e.g. for
> a freshly cloned repo the index should be empty,

No it is not. The index is a complete snapshot of your working tree.
When you have no uncommited staged changes, the index contains all files
that are in HEAD. Most commands show you _changes_ in the index (wrt
HEAD or wrt the working tree), but the index itself contain all files.

> Long story short, how about consistently talking about line endings in
> the repo, and also using "repo" instead of "ca" here?

I don't think this is a good idea. One typical use-case for the feature
would probably be:

1) wtf, there's something wrong with my line endings, let's fix this.

2) tweak .gitattributes, try to get everything right

3) prepare a commit to apply the new settings to the repository, play
   with "git add", "dos2unix" and friends.

4) check that it's OK

5) "git commit"

At stage 4), you really want to see the content of the index, because
your HEAD is still broken.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
