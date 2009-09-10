From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Thu, 10 Sep 2009 16:09:33 +0200
Message-ID: <4AA9089D.3000507@drmicha.warpmail.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <8445CEA3-AC5D-4A38-9C73-B4E14BD4864C@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:09:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlkLS-0003ZU-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbZIJOJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbZIJOJq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:09:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57507 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbZIJOJp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Sep 2009 10:09:45 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 34B3C69B54;
	Thu, 10 Sep 2009 10:09:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 10 Sep 2009 10:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=k9j9Dm69rXiNsgKNASKbXVbx2l8=; b=XV1NWw6b89dynlnZaW3AdJwxTWlPXRAoolciQYIDqcBKJUMlTN1WLt/IJJ+vsEdUm9OfrHSjk3WTP7kXn3i2U96eP3CPfziJ+LGYRYJKING8+lG4EN8RJxJsoQdmJZ3+ZivGHSD9aFNRDFOnbBZfMe0ySvouRlndsZH5AtS7dhA=
X-Sasl-enc: SslxA8/w68FwvPGkB6Oxo17R6g3TYc9amiaxtl/lcg1W 1252591785
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C6D78E222;
	Thu, 10 Sep 2009 10:09:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <8445CEA3-AC5D-4A38-9C73-B4E14BD4864C@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128112>

Geert Bosch venit, vidit, dixit 10.09.2009 16:00:
> On Sep 7, 2009, at 22:26, Johan Herland wrote:
...
> 
> Hi Johan,
> 
> I've been following this series with some interest, and am curious
> why notes need to be stored in a separate data structure from regular
> objects. Note that I'm not questioning the design (and certainly would

It's not separate, that's the point. They're stored as objects in trees,
just like anything else. The discussion about the structure is about how
to organize the tree structure, not actual subdirectories under .git/.

> not want to, this late in the process), rather I'd like to learn
> about the reasons.
> 
> I've wondered about this as well in the context of refs, reflog and
> git config. In a completely unified model, every change to the
> repository (except  for the index, pack indices and working directory)
> would be a  commit of the .git/ directory (again excluding indices).
> One of the advantages (besides allowing configuration management
> of the repository itself in addition to its contents) would be that
> no locking is ever required.

...and one of the disadvantages that you're not in control of your
config any more, if you pull from upstream. config and reflog are
something inherently private and local. The reflog does not even make
sense other than in a local (per repo) context.

For the config, one may think up a solution where parts of config are
shared (by storing them as objects and referencing them) and git asks
you before changing anything on pull/fetch. In a sense git submodule
does that already.

Cheers,
Michael
