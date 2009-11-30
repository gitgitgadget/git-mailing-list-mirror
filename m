From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git archive without path
Date: Mon, 30 Nov 2009 14:05:02 +0100
Message-ID: <4B13C2FE.3040707@drmicha.warpmail.net>
References: <20091130123203.GA11235@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 14:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF5xO-0002NK-3U
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbZK3NGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZK3NGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:06:09 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:46711 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752305AbZK3NGI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 08:06:08 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BBAEFC57BE;
	Mon, 30 Nov 2009 08:06:14 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 30 Nov 2009 08:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dwO6X22T2GTjLRr+75PiWgCoBmM=; b=EjY+hhGe8B38Tv0byHfn2phchY8B22LmzdvhU3Z6q9Ab7GqYfzhwyFWCUPXWrVGIvDR4632KRgrJWs6HhdL3mJ9RqLvDbTiNTssiEzn172sbWvjrnJ8Hd9Tq3cqI0IyCHi5vnIrZ8PFhA2PDR+10IIJ6vGe8+KsEbdfE5ZjK6b0=
X-Sasl-enc: b221xHVecDsM54Pzg/j08krIFnM+ANHDRUGOUIWVUOb8 1259586374
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B6401C00;
	Mon, 30 Nov 2009 08:06:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <20091130123203.GA11235@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134096>

Dmitry Potapov venit, vidit, dixit 30.11.2009 13:32:
> Hi!
> 
> I have never run "git archive" inside of a subdirectory but somehow I
> have always assumed that it creates an archive containing all files in
> it regardless the current directory. In fact, the git-archive man page
> says so:
> 
> path
>     If one or more paths are specified, include only these in the
>     archive, otherwise include all files and subdirectories.
> 
> 
> But it turned out that "git archive" works as "git archive .", i.e.
> adds files starting with the current directory. Is any rational for
> this behavior? It smells to me like a bug rather than a feature. I
> cannot imagine wanting to create archive containing just part of the
> whole repository just because he happened to be in that directory,
> and documentation clearly says that all files should be added unless
> one or more paths are specified.

Depends on the definition of "all" :)

In fact: Two mighty powers are fighting right now for the primacy in the
Land of the Git, and both carry the name "consistency" on their flags.
One is the "order of the consistency of generations", also named
"backwards compatibility", and one is the "order of the consistency of
commands", also named "user experience".

Many commands have different defaults with respect to how they behave in
a subdirectory (compare status to ls-files, e.g.), and the discussion
about how to best change that are underway, most prominently in the case
of git grep. I expect that we'll have a gradual migration path towards a
"full-tree" default, but that is just my personal interpretation of the
current "battle". In the short term the best that we can hope for is a
consistent, convenient notation which enforcers a specific behaviour,
such as "/" (non-existent) versus "." (existent).

Cheers,
Michael
