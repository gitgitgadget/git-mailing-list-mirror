From: =?ISO-8859-1?Q?Stefan_V=F6lkel?= <bd@bc-bd.org>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Thu, 17 Dec 2009 15:20:47 +0100
Message-ID: <4B2A3E3F.1@bc-bd.org>
References: <20091216101647.GB27373@bc-bd.org> <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com> <20091216232641.GK25474@genesis.frugalware.org> <51419b2c0912161559x4de94464pe06df2845dbe3b78@mail.gmail.com> <20091217002024.GM25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 15:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLHE4-0007Sl-Ul
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 15:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764783AbZLQOUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 09:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764780AbZLQOUq
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 09:20:46 -0500
Received: from mail.bc-bd.org ([88.217.195.190]:58588 "EHLO bc-bd.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764779AbZLQOUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 09:20:45 -0500
Received: from localhost ([127.0.0.1] helo=[10.0.0.240])
	by bc-bd.org with esmtpa (Exim 4.69)
	(envelope-from <bd@bc-bd.org>)
	id 1NLHFc-0000qW-Kl; Thu, 17 Dec 2009 14:22:44 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <20091217002024.GM25474@genesis.frugalware.org>
X-Enigmail-Version: 1.0
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bd@bc-bd.org
X-SA-Exim-Scanned: No (on bc-bd.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135372>

Hi,

> git log $(git reflog show new|sed -n 's/ .*//;$ p')..new

I had trouble getting the above to work as a git alias (someething wrt
escaping I guess), however this:

        gl = log --graph --pretty=oneline --abbrev-commit
	bl = !sh -c 'git gl $0 --not $(git for-each-ref --format=%\\(refname\\)
refs/heads/* | grep -v refs/heads/$0)'

does exactly what I want:

	# git reflog show new
	76cacd3 new@{0}: commit: B
	9638379 new@{1}: commit: A
	7944f55 new@{2}: branch: Created from HEAD

	# git gl
	* 76cacd3 B
	* 9638379 A
	* 7944f55 Y
	* b8e4a96 X

	# git bl new
	* 76cacd3 B
	* 9638379 A

Thanks for the help,

	Stefan
