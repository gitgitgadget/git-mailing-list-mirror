From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Mon, 08 Dec 2008 14:10:26 +0100
Message-ID: <493D1CC2.8050407@drmicha.warpmail.net>
References: <493A6CEC.4060601@tuffmail.com>	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>	 <493C1F36.7050504@tuffmail.com> <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com> <493C47FD.4080302@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:12:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9ftu-0000Nd-3w
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 14:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYLHNKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 08:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYLHNKd
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 08:10:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46185 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886AbYLHNKc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 08:10:32 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9EEDA1E3E21;
	Mon,  8 Dec 2008 08:10:29 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 08 Dec 2008 08:10:29 -0500
X-Sasl-enc: Ac0F82z0ZTeZ2RSR2tv3ZkDZzDhGT6stO8xCwqqLIcG9 1228741829
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CD6F81F069;
	Mon,  8 Dec 2008 08:10:28 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <493C47FD.4080302@tuffmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102540>

Grzegorz Kossakowski venit, vidit, dixit 07.12.2008 23:02:
> Peter Harris pisze:
>> After the git clone, I do the following:
>> git svn init -s svn://repo/sitory
>> git svn rebase
>>
>> No data is transferred[1], although 'git svn rebase' does spend a
>> minute or so reading the commit messages to rebuild its index.
> 
> I've tried this method with Cocoon repository
> (http://jukka.zitting.name/git/?p=cocoon.git;a=summary) and got this error:
> 
> git clone git://jukka.zitting.name/cocoon.git
> git svn init -s https://svn.eu.apache.org/repos/asf/cocoon/
> git svn rebase
> Unable to determine upstream SVN information from working tree history
> 
> git --version
> git version 1.6.0.2

Could it be as simple as a missing "cd cocoon" between git clone and git
svn rebase? No, you probably did that.

But note that you did not follow Peter's instructions. The point is that
your clone creates "remotes/origin/trunk" whereas Peter's instructions
mirror the source, creating "remotes/trunk", which is what git svn needs
(unless you say "git svn init -s --prefix=origin/" or "git config
svn-remote.svn.fetch trunk:refs/trunk" etc.). The prefix solution should
be the best.

Michael

P.S.: Peter starts off a different layout (standard svn remotes, which
need special instructions to be cloned). Ordinary clone + git svn init
--prefix=origin/ should work fine for the cocoon layout.

P.P.S.: We can't test cocoon unless we have an account on the apache
server...
