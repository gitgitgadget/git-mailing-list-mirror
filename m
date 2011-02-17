From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 09:23:29 +0100
Message-ID: <4D5CDB01.9070502@drmicha.warpmail.net>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com> <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com> <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com> <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Feb 17 09:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpzCE-0002kU-I9
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 09:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab1BQI0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 03:26:37 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42962 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751254Ab1BQI0g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 03:26:36 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 217DF2023C;
	Thu, 17 Feb 2011 03:26:36 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 17 Feb 2011 03:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nLqdrQQ4v5/zhaQSCzPBTEzPHZ8=; b=N8xNuwoJPje6EC8mtiywlgp9Sz22T/1na5GIIficDgganXz9UWvYtLOhYt+WxAAjGYHFYI8YhpPcvP3sLaBTpZXMIINo9YK09IbpIYUiRdpC4DxKIGbn6n0tTzk0ckX+PG+sLbuteTNOl/0Lkw0DMVDpRjjp5RvaVZhUsQQlWG0=
X-Sasl-enc: Us+Qy+UNnnxteeZHPKrlDqxzNbgFDTIBoz3k9QwjsWOK 1297931195
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E76D407945;
	Thu, 17 Feb 2011 03:26:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim6HDCaeTDuEtK+3niKKoz6A3KA=m=UCr4DaY-V@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167054>

Miles Bader venit, vidit, dixit 17.02.2011 08:24:
> Hmm, on a related note, is there an obvious way to _show_ the current
> branch's upstream...?
> 
> [I mean, which just prints out "origin/master" or whatever...]
> 
> Thanks,
> 
> -miles
> 

git for-each-ref --format="%(upstream)" $(git symbolic-ref HEAD)

I can't come up with a better way of expanding @{u} without resolving
the resulting refname to a SHA1. You could do

git name-rev @{u}

or similar with "describe", but that's really backwards - it first
expands @{u} to a refname, then to a SHA1, and then tries to describe
that SHA1 by a refname...

BTW: Please don't change "--set-upstream" light-heartedly and isolated
from other stuff. We need more consistency wrt. subcommands vs. options
vs. options taking parameters. So an incompatible change should be part
of a bigger picture. This requires some research about our current
usage, pitfalls, and the best way forward (breaking as little as
possible and achieving as much as possible).

Michael
