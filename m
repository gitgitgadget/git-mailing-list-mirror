From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Tue, 06 Sep 2011 09:51:56 +0200
Message-ID: <4E65D11C.3050105@drmicha.warpmail.net>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net> <4E6088F9.5070102@drmicha.warpmail.net> <20110902152947.GB19213@sigill.intra.peff.net> <7v4o0uncq0.fsf@alter.siamese.dyndns.org> <20110902162524.GC19690@sigill.intra.peff.net> <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com> <vpqvct69l2e.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:52:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qRv-00024X-Rz
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1IFHv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:51:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38118 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258Ab1IFHv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 03:51:58 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 29EC424D84;
	Tue,  6 Sep 2011 03:51:58 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 06 Sep 2011 03:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=J9MkyOBuyqGqo8/E32t3Cz
	NZktI=; b=OBhk70nPdT2vvEWXyfMZwWf9gpTarWnBoWmDoCvfXCH/Btdfvry9SH
	+R7idY7r7qDvWc+5nUFTElg543ilPJCmE8VEm7uK0Ij51RseJfe11IU4Et8xBuvF
	FoPFrss8U+VBComSZUW9FVnX2KN3y27GPTwnFDehHkoDjt6ecEMpQ=
X-Sasl-enc: IGxSnaGXrge2nu7VOYCC5QrUzrdBwRltDlQFMIwP8ZJb 1315295517
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 43B13780025;
	Tue,  6 Sep 2011 03:51:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <vpqvct69l2e.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180779>

Matthieu Moy venit, vidit, dixit 06.09.2011 09:39:
> Shawn Pearce <spearce@spearce.org> writes:
> 
>> Again, the repository owner would notice on their next push, and
>> notify people the repository is not to be trusted.
> 
> For simple attack, yes. But if the server is compromised, you can't
> trust it anymore to error out on non-fast-forward. I don't think it
> would be very complex to write a modified Git server that would come
> back to the official history before a push, and re-introduce faulty
> commits right after. pushers wouldn't notice, and fetchers would get
> compromised history.

Exactly. Even on fetch, it could serve different histories depending on
the ip so that the pusher does not notice when fetching from the same ip.

> OTOH, non-fast-forward fetches can be reliably detected client-side, and
> I like being able to think "whatever the server does, I don't care
> because I'm using Git".

reflog based warnings should provide a sane default. We could amend the
update hook for those who want to allow/deny specific branches to
rewind, or make receiveDeny... branch.-specific, if the multiple
refspecs approach is too complicated.

Michael
