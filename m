From: Yuri D'Elia <wavexx@thregr.org>
Subject: Thinning a repository
Date: Sun, 30 Nov 2014 13:18:34 +0100
Message-ID: <m5f1uq$na7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 13:21:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv3Ur-0003Zq-R9
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 13:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbaK3MUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 07:20:45 -0500
Received: from plane.gmane.org ([80.91.229.3]:42358 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbaK3MUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 07:20:04 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Xv3Tu-00034w-NS
	for git@vger.kernel.org; Sun, 30 Nov 2014 13:20:02 +0100
Received: from adsl-ull-182-73.49-151.net24.it ([151.49.73.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 13:20:02 +0100
Received: from wavexx by adsl-ull-182-73.49-151.net24.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 13:20:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-182-73.49-151.net24.it
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260448>

Hi everyone,

Is there a quick way to reproduce the effect of a shallow clone on a
local repository that doesn't involve filter-branch and/or re-clone?

My motivation is to reduce the local size of repositories I'm only
following, by trimming the history without prejudice to a [N] set of
last commits. It feels stupid that the quickest way I'm aware of right
now to achieve this is to "git clone --depth N ..." again. filter-branch
is ridiculously slow, as it iterates through history.

I've tried using graft points, but the combination of:

echo [sha] > .git/info/grafts
git reflog expire --expire=0 --all
git repack -Ad

doesn't really save any space and/or reduce the object count as I would
expect. It means there's probably still reachable?

I'd really love to have a 'git thin [depth]' subcommand to perform the
above however. I don't really want to have to iterate through refs just
to check if they are still reachable within [n] commits just to delete them.

Thanks for any pointer.
