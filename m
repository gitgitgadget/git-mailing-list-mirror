From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Bug in git stash
Date: Mon, 14 Jan 2013 12:45:39 +0100
Message-ID: <50F3EFE3.9020100@viscovery.net>
References: <CAOJsraHfKRoK1G8tA2ROUH6qt-q0kG6WesZr5enOeeqFF_AC=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nikolay Frantsev <nikolay@frantsev.ru>
X-From: git-owner@vger.kernel.org Mon Jan 14 12:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuiUP-0003lT-4j
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 12:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896Ab3ANLpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 06:45:46 -0500
Received: from so.liwest.at ([212.33.55.24]:41622 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756412Ab3ANLpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 06:45:45 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TuiU0-00071D-B8; Mon, 14 Jan 2013 12:45:40 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id EDE9E1660F;
	Mon, 14 Jan 2013 12:45:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CAOJsraHfKRoK1G8tA2ROUH6qt-q0kG6WesZr5enOeeqFF_AC=w@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213481>

Am 1/14/2013 10:18, schrieb Nikolay Frantsev:
> nikolay@localhost:~/Desktop/git-stash_bug/bug$ git status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   3
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	modified:   1
> #	modified:   2
> #
> nikolay@localhost:~/Desktop/git-stash_bug/bug$ git stash save --keep-index one
> Saved working directory and index state On master: one
> HEAD is now at 7e495f9 files added
...
> nikolay@localhost:~/Desktop/git-stash_bug/bug$ git stash pop stash@{1}
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   3
> #
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	modified:   1
> #	modified:   2
> #
> Dropped stash@{1} (7926ab7285753c179a368a3a7e8ebfb0f39d0437)
> 
> Why there a new empty file named 3?

It is by design. --keep-index only achieves that your staged changes are
not reverted, but nevertheless all changes are stashed away. Therefore,
when you later apply the stash, you also get back the modified index.

-- Hannes
