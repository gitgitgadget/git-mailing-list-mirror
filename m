From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add --track option to git clone
Date: Mon, 30 Nov 2009 14:36:40 +0100
Message-ID: <4B13CA68.70708@drmicha.warpmail.net>
References: <1259587004-14633-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 14:38:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF6S0-00064w-ES
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 14:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbZK3Nhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 08:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZK3Nhr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 08:37:47 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54669 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752340AbZK3Nhq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 08:37:46 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 34504C4A01;
	Mon, 30 Nov 2009 08:37:53 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 30 Nov 2009 08:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RQ88yROQSBfXmHAVns6u3L0ylbw=; b=cw0qWMcHNtO3jkU6nJ31vwuOy+FYcHcbUbzSw0CP0m6RyD968Fj90q4eOtb+fScvqcy+1yJfLU+e6pkOM2ZFQNacO9OK22Bf9clxA9BfW7SKfm4J+QYpJtA6oSJo+nYiQ0ErwN8iMmzMjFU5dBDLM5y6gPDkqyvi+NZewy2gYWk=
X-Sasl-enc: qZJ0nWrlZBXNTccBMBnw68blTJwFyClPs8U8s5G9QJnb 1259588272
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 81E5349CC23;
	Mon, 30 Nov 2009 08:37:52 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <1259587004-14633-1-git-send-email-sn_@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134102>

David Soria Parra venit, vidit, dixit 30.11.2009 14:16:
> The following series adds a --track option to git clone. If the --track option
> is specified only the given remote branch will be received and checked out.
> 
> It tries to make the following usecase possible:
> Imagine you are working on a project that has 1.x and a 2.x branch. The project
> itself requires a complex setup (webserver, configuration files, etc). Setting up
> 1.x and 2.x branch requires a lot of work, but a developer needs to maintain both.
> He'll use the --track option to clone the 2.x branch into a directory and does the same
> with the 1.x branch, where he setup the project. He can use locally separate repositories
> while still being able to push to just one remote repository.

While I think the feature itself is useful, I don't think it's that
useful for the case you mention. If you clone all branches anyways
you're much better of using alternates or --reference, or the workdir
script in contrib/

> I'm aware that it's not possible to give more than one --track option. Implementing
> the possibility to specify multiple --track option would certainly a good improvment
> later, but would also require a lot more work as far as I understand the clone code.
> 
> Being able to specify just one --track option is a compromise of doing a small change
> and implementing this feature.

That restriction makes a lot of sense. Two suggestions:

- How does one turn such a "partial" clone into a full one? That should
be documented somewhere (git config remote.origin.fetch
'+refs/heads/*:refs/remotes/origin/*').

- A test would be nice, which makes sure you clone what you think you clone.

Cheers,
Michael
