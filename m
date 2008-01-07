From: Jan Hudec <bulb@ucw.cz>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 21:07:56 +0100
Message-ID: <20080107200756.GA20892@efreet.light.src>
References: <20080107102327.GA12427@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JByGy-0005fH-5J
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 21:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYAGUIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 15:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbYAGUII
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 15:08:08 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:60208 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYAGUIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 15:08:07 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id F40ED57245;
	Mon,  7 Jan 2008 21:08:04 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Vyo+9qN6teBT; Mon,  7 Jan 2008 21:08:02 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8C2FA57354;
	Mon,  7 Jan 2008 21:08:00 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JByGK-0005de-EF; Mon, 07 Jan 2008 21:07:56 +0100
Content-Disposition: inline
In-Reply-To: <20080107102327.GA12427@pvv.org>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69802>

On Mon, Jan 07, 2008 at 11:23:27 +0100, Finn Arne Gangstad wrote:
> 3. each time you push a submodule, do a merge ours to a
>    "internal-submodule-tracking" branch, and push to that. Something
>    like this in other words:
> 
>      git fetch origin internal-submodule-tracking
>      git merge -s ours origin/internal-submodule-tracking
>      git push origin internal-submodule-tracking
>      git reset --hard HEAD^1
> 
>    Issue: feels wrong somehow?

Only one thing feels wrong here -- the merge -s ours. For one thing, the
commit is probably descendant of what was in the internal-submodule-tracking
branch (the branch name should actually have product2 in it's name).
If it is not, you should not artificially make it so, but rewind the branch.

But as Junio already told you, you should really manage the subproject like
a project (because it is a project), so the change should get to a topic
branch where the other superprojects can look at the change and decide
whether they want it or not.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
