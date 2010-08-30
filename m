From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP
 files.
Date: Mon, 30 Aug 2010 21:10:04 +0200
Message-ID: <4C7C020C.6090907@drmicha.warpmail.net>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>	<4C7B8E1E.6050708@drmicha.warpmail.net>	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>	<20100830141602.GF2315@burratino>	<AANLkTim+S87KjFBstBineR02hQHzG=X2VDqgiGNbPQGS@mail.gmail.com>	<20100830163302.GA13336@burratino> <AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 21:10:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq9kD-0002PI-B8
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab0H3TKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 15:10:04 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37855 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab0H3TKD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 15:10:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 15F8C1BA;
	Mon, 30 Aug 2010 15:10:03 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 30 Aug 2010 15:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=TM+DHyEUfXovga3KbJWZ7HCp/q4=; b=I44DoewIILOvOPKDOga1Ue7erkOiEsxdnf2wNv6LDaESrFHKUlvjVN65Myg2b/bOLifWCxVhonevgtkBYRnOii8RzONcAXiIuBwphP7Q7K+wF1rxhRiBGosWq1T2hHOAGvil+9wipdli1kuFpzfLo7GE34ZMCfj2lfpNw5ZkCVM=
X-Sasl-enc: EsPwQmdNBgvh/CcJB4FA2aHqjvUjNEkaefA8vkW6bn/H 1283195402
Received: from localhost.localdomain (p54859465.dip0.t-ipconnect.de [84.133.148.101])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2DB3840B585;
	Mon, 30 Aug 2010 15:10:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTi=VPf9CWNJcce6d20HQChi0mHgTG1F=jakzNT-O@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154840>

Chris Patti venit, vidit, dixit 30.08.2010 19:37:
> On Mon, Aug 30, 2010 at 12:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Chris Patti wrote:
>>
>>> What if this is the
>>> first time a new ref is being pushed?  Then, old-ref is 000000 and git
>>> diff --raw throws up a hairball :)
>>
>> Can't you check for 0{40} and use $(git hash-object -t tree </dev/null)
>> in its place?
>>
>> In general, the "LOW-LEVEL COMMANDS (PLUMBING)" listed on the git man
>> page are meant to be useful for scripts.  They have simple input and
>> output formats, they don't try to introduce weird exceptions for user
>> convenience, the git developers are more conservative about changing
>> them, and so on.
>>

git diff-tree --root $newrev

will take care of this.

> 
> Maybe I'm not understanding your intent here, but, this is a
> pre-receive hook, where you get handed two refs, the old (pre-push)
> ref, and the new (after push) ref.
> 
> git hash-object computes a hash from the file's contents.  That's my
> whole point, I don't *have* the file to compute! All I have is those
> two refs.

You do have the files, otherwise you couldn't check them. They're in
your git file system ;)

Michael
