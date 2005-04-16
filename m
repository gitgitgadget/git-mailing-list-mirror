From: Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] Get commits from remote repositories by HTTP
Date: Sun, 17 Apr 2005 00:17:45 +0200
Message-ID: <20050416221745.GA10280@ucw.cz>
References: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:14:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvYC-0006KW-Se
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDPWRq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDPWRq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:17:46 -0400
Received: from albireo.ucw.cz ([84.242.65.67]:37509 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261158AbVDPWRo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:17:44 -0400
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id B59F87BD17; Sun, 17 Apr 2005 00:17:45 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504161750020.30848-100000@iabervon.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

> This adds a program to download a commit, the trees, and the blobs in them
> from a remote repository using HTTP. It skips anything you already have.

Is it really necessary to write your own HTTP downloader? If so, is it
necessary to forget basic stuff like the "Host:" header? ;-)

If you feel that it should be optimized for speed, then at least use
persistent connections.

> +	if (memcmp(target, "http://", 7))
> +		return -1;

Can crash if the string is too short.

> +	entry = gethostbyname(name);
> +	memcpy(&sockad.sin_addr.s_addr,
> +	       &((struct in_addr *)entry->h_addr)->s_addr, 4);

Can crash if the host doesn't exist or if you feed it with an URL containing
port number.

> +static int get_connection()

(void)

> +	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);

What if it fails?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A student who changes the course of history is probably taking an exam.
