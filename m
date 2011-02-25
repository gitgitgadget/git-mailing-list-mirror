From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 09:51:37 +0100
Message-ID: <4D676D99.2010600@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph> <4D6672F7.4020101@drmicha.warpmail.net> <20110224154908.GA29309@sigill.intra.peff.net> <4D667F1A.5060408@drmicha.warpmail.net> <20110224160027.GA30275@sigill.intra.peff.net> <4D6680F3.1000205@drmicha.warpmail.net> <20110224160932.GC30275@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 09:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PstS2-0000Zp-Vu
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 09:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294Ab1BYIy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 03:54:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54797 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754271Ab1BYIy5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 03:54:57 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A46E420B58;
	Fri, 25 Feb 2011 03:54:56 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 25 Feb 2011 03:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5zXavVa6r3/bu93Zd3QUQ0wQ5m8=; b=XsAcS3f/SQINJx1cDpXmNuRwwfXEGPBF0KXkiI7Q+qqcKVk61g1ablNAW3ucD82xw/F14vfhBg1GNC5DbJbbfgNdbBHaEg0hbZF7uC9d21e6yhV+GyFGCJhZAUWtHjKhwUT28XZsAbXl3dMr46XcWUaYu4SU24DE02T/DXYk46E=
X-Sasl-enc: PF/wY8Cv9bdRuo/+BbSP1UUvnElRnPT4SsvfWkx3SqhD 1298624096
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 14D7344098E;
	Fri, 25 Feb 2011 03:54:55 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224160932.GC30275@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167885>

Jeff King venit, vidit, dixit 24.02.2011 17:09:
> On Thu, Feb 24, 2011 at 05:01:55PM +0100, Michael J Gruber wrote:
> 
>>>> - hom. interface: allow "-a pathspec" for commit
>>>
>>> What would it do? It would just behave like "git commit -i
>>> pathspec"?
>>
>> It should do what "-u pathspec" does for add: limit "all tracked" to the
>> pathspec. I know it's the same as without "-a", but why bail out on it?
> 
> Without "-a", we do "git commit -o", which is slightly different with
> respect to stuff in the index.  In the case of:
> 
>   git add -u <path> && git commit
> 
> we will add new changes from <path>, and then commit them along with
> whatever was already in the index.
> 
> With:
> 
>   git commit <path>
> 
> We will commit _just_ the changes in <path>, regardless of what is in
> the index.
> 
> I assumed that:
> 
>  git commit -a <path>
> 
> would behave more like the "git add -u <path>" case; add new stuff to
> the index from <path>, and then commit those changes plus whatever was
> already in the index.

Yes, you're right. I haven't wrapped my brain completely around those
mixed cases yet (changes in index + pathspec argument). My aim is that

"git commit <addoptions> <commitoptions> [<pathspec>]"

would be equivalent to (the atomic version of)

"git add <addoptions> [<pathspec>] && git commit <commitoptions>"

and that is difficult because currently, pathspecs are "limiting" for
commit and "additive" for add without -u. I mean, I don't want to break
anything, at least not before 1.8.0..

>> I've done all the careful planning already, laid out in nice steps. Now
>> it's your time ;)
> 
> Heh. Transitioning to management, I see.

Still in negotiations ;)

> -Peff

Michael
