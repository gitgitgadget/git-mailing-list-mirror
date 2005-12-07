From: Paul Serice <paul@serice.net>
Subject: Re: [RFC] Run hooks with a cleaner environment
Date: Tue, 06 Dec 2005 18:19:58 -0600
Message-ID: <43962AAE.4040704@serice.net>
References: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 01:20:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejn2N-0002JW-MJ
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 01:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbVLGAT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 19:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932673AbVLGAT4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 19:19:56 -0500
Received: from serice.org ([206.123.107.184]:53256 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S932672AbVLGATz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 19:19:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id 10070584EB;
	Tue,  6 Dec 2005 18:19:55 -0600 (CST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512061716030.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13309>

> Currently, hooks/post-update is run in the environment that
> receive-pack is run. This means that there are a number of things
> that are unpredictable. I'd like to make it set things up in a more
> predictable and useful way.

I'd like to second this.  I've been bitten by two of the three issues
you've raised.


> stdout and stdin are connected to send-pack, either by broken pipes
> (for local pushes) or an ignored socket (via ssh). stdin should
> probably be /dev/null, and stdout should be either a log file or
> /dev/null. stderr is still the push's stderr, which may or may not
> be desired.

If there is a controlling terminal and nothing else git-related is
reading from it, I'd like for stdout and stderr to be reconnected.


Paul Serice
