From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Wed, 18 Feb 2015 20:45:08 +0100
Message-ID: <54E4EBC4.6000802@drmicha.warpmail.net>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>	<CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>	<54E46635.4060009@drmicha.warpmail.net> <xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Julien Cretel <j.cretel@umail.ucc.ie>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAYh-0006qU-FB
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674AbbBRTpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:45:12 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50158 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753767AbbBRTpL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 14:45:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id D4F8022905
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 14:45:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Wed, 18 Feb 2015 14:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=mtAjB7tdeezeVjjZa9TbQ6
	LWxEk=; b=AgkaLVKePFZMdlDzth9B0nLNDHpXM/g33Noc3Qyrhy0/1QGF0x1N65
	O1LR3ZQBuDq6/fEHLlhRpoKZuw9ijzm9zAHl7uCHRG9DWNnlqRyFA3K4dqrTsAxR
	79q3clOdZlW1rD2qa+CrW1ODiFRnxiA0o8vbxG6UXy4PMPTeW/Cd0=
X-Sasl-enc: G4IMWi8KNwXQwWXk93AXzZOkQvXUL5CrgeaUFXZQdPG/ 1424288710
Received: from localhost.localdomain (unknown [88.70.121.210])
	by mail.messagingengine.com (Postfix) with ESMTPA id C6A01C00295;
	Wed, 18 Feb 2015 14:45:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264058>

Junio C Hamano venit, vidit, dixit 18.02.2015 18:07:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "git branch" will tell you your branches and which one is checked out
>> (or HEAD); "git status" will tell you the latter.
>>
>> "git log" is about the DAG which has absolutely nothing to do with what
>> you have currently checked out.
> 
> Yeah, that summarizes my reaction, too.  More importantly, "log" is
> about showing commits and "--decorate" is a way to enrich the
> presentation of commits---it talks about commits in terms of refs;
> the command and the option is not about describing refs and their
> relationships.
> 
> I do not terribly mind showing the fact that HEAD points at a branch
> when --decorate talks about HEAD, partly because we will be showing
> both HEAD and the branch name _anyway_ in the output.  But I am not
> sure if the extra bit of information is more helpful to the readers
> or being distracting.
> 
> Julien's "HEAD=master, other" vs "HEAD, master, other" may be
> subdued enough to be undistracting, I would guess.  I do not think
> the distinction between "HEAD = master" and "HEAD -> master" would
> be useful, on the other hand.  We already know that the names listed
> all refer to the same commit, which means that we do not have to say
> "HEAD is detached" explicitly as long as we have a way to say "HEAD
> points at this branch".  If HEAD is listed and is not marked to
> point at another branch that is shown, by definition it is detached,
> no?
> 

Yep, it very well is. Also, that approach would tell you which branch is
checked out, though I don't consider that git log's business.

OTOH, it's "backwards" in the sense that it marks the "ordinary" case
(HEAD is symref, branch is checked out) specially compared to the
"exceptional/dangerous" case (HEAD is ref, detached). And status, branch
will point out that latter case more verbously, too.

Michael
