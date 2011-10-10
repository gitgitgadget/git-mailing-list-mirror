From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Mon, 10 Oct 2011 08:33:03 +0200
Message-ID: <4E92919F.2030007@drmicha.warpmail.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org> <4E91FD57.7050808@drmicha.warpmail.net> <7v4nzhrebp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 08:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD9Qd-0001pw-2F
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 08:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533Ab1JJGdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 02:33:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60425 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256Ab1JJGdF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 02:33:05 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 461C120A76;
	Mon, 10 Oct 2011 02:33:05 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 10 Oct 2011 02:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=uqpl+8pVhBFE7cO7jH9vOD
	mRvj0=; b=sMAJs+QoVeUym6iT9/8vCg/gB1nXLrsity40GvfeRSpfrTC3eNuHjt
	Od0mJdR9ojeVyLaYECcoFkK0HyxMdAAQetDZTA7YtwCrjwfd13ZnakFLYbndOYFd
	9fhGw2wcZtR6A0G3XKL1qdkEkX2eJ4MZ3u5pow4/B+p85AtZOyAHM=
X-Sasl-enc: 2IxzcF0w0ESg+MnoGCt4VRjqeRAn7n9N6hE8tsfeaxLN 1318228385
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C2A4AD0037B;
	Mon, 10 Oct 2011 02:33:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <7v4nzhrebp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183227>

Junio C Hamano venit, vidit, dixit 10.10.2011 00:27:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> BTW: commit --amend --gpg-sign strips an existing signature rather than
>> adding one. We might want the user to have a say here.
> 
> I think it deserves a separate command (commit --add-gpg-sign) that is
> used _only_ to add an additional signature by another person without
> affecting anything else in the commit (i.e. the tree, the parents and the
> author and committership information) from the viewpoint of the workflow,

Agreed, as I asked "the user to have a say".

> Obviously that "add-signature" mode needs to be aware of the existing
> signature. It is a deliberate design decision to strip existing signature
> when anything in the commit changes, which is the norm for --amend.

What norm? --amend keeps some header fields and discards others. In
fact, signing a commit "without changing it" (i.e. keeping tree, parents
etc., alias "--amend -C HEAD") should be the normal use case for signing
the tip of an existing branch. I mean, I have no problems adding to this:

git help fixup
`git fixup' is aliased to `commit --amend -C HEAD'

But what is the best default for the workflows that we encourage (commit
early, ...)? You answer a pull-request which happens to be a
fast-forward, sign the tip and suddenly you've taken over ownership (and
changed dates)??? Signing a commit should not do this.

Michael
