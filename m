From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Thu, 19 Feb 2015 10:52:39 +0100
Message-ID: <54E5B267.9090604@drmicha.warpmail.net>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>	<CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>	<54E46635.4060009@drmicha.warpmail.net>	<xmqq8ufv408l.fsf@gitster.dls.corp.google.com>	<54E4EBC4.6000802@drmicha.warpmail.net> <xmqq8ufv2e62.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Julien Cretel <j.cretel@umail.ucc.ie>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 10:52:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YONmu-0000Vk-7e
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 10:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbbBSJwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 04:52:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38147 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752075AbbBSJwm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 04:52:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 5E01A207F6
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 04:52:41 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 19 Feb 2015 04:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3B1hRVMw1PxMbjaRzZVeN9
	NFigc=; b=AV39Lj9+UXEFJcc7ODnELpbqXXoKEWmRl6wrAltm3cYB8mrpM8GRAz
	uAk5xzjx0YwLoSNGSQ9ZZG0/XXuOfoivxk1a5/TapfEfBdz/z+qfAcf4449CikMI
	GImd+2LyIw/ouLN3JU/dsrsjTXxBJIUJbVp7iR4hZq78jaMgLjYAs=
X-Sasl-enc: wbmVl2XWWqYmIuH43NwThXR9m8Uc6tJesIHzdJIxu+WO 1424339561
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BEABEC002A2;
	Thu, 19 Feb 2015 04:52:40 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqq8ufv2e62.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264086>

Junio C Hamano venit, vidit, dixit 18.02.2015 20:49:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Yep, it very well is. Also, that approach would tell you which branch is
>> checked out, though I don't consider that git log's business.
>>
>> OTOH, it's "backwards" in the sense that it marks the "ordinary" case
>> (HEAD is symref, branch is checked out) specially compared to the
>> "exceptional/dangerous" case (HEAD is ref, detached).
> 
> Both are ordinary and there is nothing exceptional or dangerous
> about your HEAD temporarily being detached during a "rebase -i"
> session, for example.

Sure, that's why I put it in quotes. That's only how it is perceived by
some users, and I suppose it's that kind of users that we are trying to
help here.

>> And status, branch
>> will point out that latter case more verbously, too.
> 
> Yeah, but as you said, that is not "log"'s business.

I still think decorations "detached HEAD" resp. "HEAD" for the two cases
are more natural, if we want to include any additional information at
all. Just think of:

deadbeef (HEAD=master, topicbranch, tag: v1)

log/rev-list is about commit objects. All the refs above resolve to the
same commit, so why are only two of them equal?

In fact, they are very unequal, since HEAD would be "ref:
refs/heads/master" whereas master would "deadbeef". They are equal in
the other (detached) case! I'm not telling you any news here, I just
want to point out how badly misleading that notation is.

So, I would suggest to "decorate the decorations", by saying something
like "detached HEAD", and maybe some version of "HEAD at master" (I'd
prefer just "HEAD") and possibly more info on the tags ("s-tag" or
"signed tag" etc).

Michael
