From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Tue, 23 Apr 2013 10:58:38 +0200
Message-ID: <51764D3E.9020403@drmicha.warpmail.net>
References: <1547528401.1826118.1366645060312.JavaMail.root@openwide.fr> <vpqfvyi7e86.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeremy Rosen <jeremy.rosen@openwide.fr>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 23 10:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUZ3c-0004p3-SS
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 10:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716Ab3DWI6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 04:58:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55116 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755584Ab3DWI6b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 04:58:31 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 142A520446;
	Tue, 23 Apr 2013 04:58:31 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 23 Apr 2013 04:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=UhoG+qaGJHAHszrsH+MuQQ
	Y65Co=; b=Z2i8x3WOLSGvKBIDCVRiJ/2Qt+BEsvg+ejlPDaGdG7ROMq4gYZaIUy
	0fxaPH1McVivx9OYkSxy5B8ylAPJ94lX8IEUfqez84pPXOgEb0wTXYyuoWJ9A22K
	4bL6g/uhytcGWdgtg0Gu5JQjuEbp9aTahiE7w994HyNELQfjn6PIY=
X-Sasl-enc: dS7KjEdkwbaS55c6F3DkbIvTDucJDi36M1ymXpqX3XLa 1366707510
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 056D7C80005;
	Tue, 23 Apr 2013 04:58:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <vpqfvyi7e86.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222138>

Matthieu Moy venit, vidit, dixit 22.04.2013 17:54:
> Jeremy Rosen <jeremy.rosen@openwide.fr> writes:
> 
>> some features detect if they are piping to a terminal... couldn't we do
>> something like that ?
> 
> That's OK for convenience features like colors or so, but that would be
> really, really unexpected to have
> 
> $ git show HEAD:file
> foo
> $ git show HEAD:file > tmp
> $ cat tmp
> bar
> 
> IMHO.

Yes, I'd either do it by default in general (my preference) or on
request, but not based on tty.

Another point of input: You can do

git show commit <blob> <commit> <blob>

and also with other object types, of course. On the other hand, there is
a single rev.diffopt. Besides the nuisance of having to track whether
textconv has been specified explicitely and flipping the bit in
rev.diffopt per argument (or adding a parameter), which is an
implementation detail, it would mean that the default for different
arguments in the argument list is different, depending on type. And that
is a usablility issue, I would argue:

Is textconv on by default for git show? Yes and no, for some arguments
yes, for others no.

That's what I want to cure ;)

Michael
