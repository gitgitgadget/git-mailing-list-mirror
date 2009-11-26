From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 13:00:09 +0100
Message-ID: <4B0E6DC9.3070105@drmicha.warpmail.net>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr> <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Nov 26 13:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDd2K-0002hX-4q
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759809AbZKZMBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759802AbZKZMBM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:01:12 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58191 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751749AbZKZMBL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 07:01:11 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 26D25C1A8B;
	Thu, 26 Nov 2009 07:01:17 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Nov 2009 07:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dv8qsDsz2PG2BrFYzTGbqzxlDvA=; b=HYE/kxCdJGfuOQEUmL5bBQvy3/aXI5b//B5ZMeLe76Ka/NBB1L7f+Z5hn1CTJdsewWjN6cInTz82Iq0en7WtPMsjLMwdCkvcuvukii7AJB9PuP/LOOuBe4QgLRQFfyPeQF1xwz+kW9a7PDdzi28j/c0lE5MxNAfFqyt0gCy8dIk=
X-Sasl-enc: taAIc5jlpPg9L3cTYVaKu9h0Lef2/xtgiPfGsYCQ111X 1259236876
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6636C70FB7;
	Thu, 26 Nov 2009 07:01:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133786>

Matthieu Moy venit, vidit, dixit 26.11.2009 11:35:
> Most users will set it to ~/.gitsomething. ~/.gitignore would conflict
> with per-directory ignore file if ~/ is managed by Git, so ~/.gitexcludes
> is a sane default.

I'm sorry to jump in so late, and this may sound like bike-shedding, but
right now we have

.git/info/exclude
.gitignore

and this would add

~/.gitexcludes

That is, three terms, or two, where one comes in two variations
(exclude/exludes). I always wondered why we have two.

The reason for .gitignore is most probably the similarity to
.${othervcs}ignore, and that is a valid reason.

I know we have ~/.gitconfig for the global version of .git/config, and
maybe that was just no good idea either. But I don't even dare
suggesting to rename it ~/.gitglobalconfig.

So, in line at least with our term "global" (per user) config, I would
suggest to use "~/.gitglobalignore" for the global ignore file. Maybe,
eventually, we'll manage to rename .git/info/excludes to .git/info/ignore.

On a somewhat larger scale, a good alternative strategy would be to have
a directory "~/.gitglobal/" in which Git would look for
~/.gitglobal/config and
~/.gitglobal/info/ignore or
~/.gitglobal/ignore

i.e. mirroring the repo structure or at least bundling everything in a
single dir, which would also be a good place for a global svnauthors
file and such, and for other global configuration files we don't think
of right now.

Michael
