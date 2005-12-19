From: Paul Serice <paul@serice.net>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 11:29:42 -0600
Message-ID: <43A6EE06.8040108@serice.net>
References: <43A628F6.1060807@serice.net> <Pine.LNX.4.64.0512190130450.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 18:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoOpR-0006pA-Qv
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 18:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVLSR3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 12:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVLSR3i
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 12:29:38 -0500
Received: from serice.org ([206.123.107.184]:18693 "EHLO serice.org")
	by vger.kernel.org with ESMTP id S932231AbVLSR3i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 12:29:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by serice.org (Postfix) with ESMTP id 9F280584F9;
	Mon, 19 Dec 2005 11:29:37 -0600 (CST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512190130450.25300@iabervon.org>
X-Enigmail-Version: 0.92.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13828>

> If, for some reason, a hook looked at stdin, it could get surprising
> results.

In the first patch, the hook would hang waiting for input.  That was a
bug.  In the second patch, the hook's standard input has been closed
by git-send-pack (which is the standard thing for the parent to do in
a pipeline), thus if a hook looks at stdin it will get EOF (the same
as if connected to /dev/null).


Paul
