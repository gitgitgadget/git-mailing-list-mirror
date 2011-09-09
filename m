From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 09 Sep 2011 10:05:48 +0200
Message-ID: <4E69C8DC.7060008@drmicha.warpmail.net>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com> <4E6769E3.4070003@drmicha.warpmail.net> <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com> <4E68C04F.9060804@drmicha.warpmail.net> <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com> <20110908191842.GB16064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Szakmeister <john@szakmeister.net>,
	Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 10:06:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1w6A-0007jF-0c
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758548Ab1IIIF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 04:05:56 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:49491 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758491Ab1IIIFv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 04:05:51 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9E9A32A774;
	Fri,  9 Sep 2011 04:05:50 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 09 Sep 2011 04:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AjIH33D39lZtwkA7EA5Ovd
	rlx/Q=; b=ZCl6s1SxvNaaxTTjFRFXCfAEmowDsNgopeKH1WJdm7x2mS/nlROIeZ
	oM5E9LD7m+zt/bEuoO6zN6YNbH5yJuM6e/A+d5RqX/MNCRC3G04z1Yn7mAfUvl/E
	c3e3qwkC3CJ4PPpkFty2AN2YbprXwrCdIazA0xY9NkBxkmbqQP91c=
X-Sasl-enc: Fnn5xDX9iOdQCw6b7oqLM9EJMBBA7NBhwzOPbEH3ggm/ 1315555550
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D4D317601FC;
	Fri,  9 Sep 2011 04:05:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <20110908191842.GB16064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181030>

Jeff King venit, vidit, dixit 08.09.2011 21:18:
> On Thu, Sep 08, 2011 at 11:02:11AM -0400, John Szakmeister wrote:
> 
>> On Thu, Sep 8, 2011 at 9:17 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>> [snip]
>>> It would be interesting to know what we can rely on in the user group
>>> you're thinking about (which I called ssh-challenged). Setting up ssh
>>> keys is too complicated. Can we require a working gpg setup? They do
>>> want to check sigs, don't they?
>>
>> I don't think you can require a working gpg setup (at least for not
>> addressing the ssh-challenged group).
> 
> Agreed. Anything harder than ssh keys is right out the window, because
> they're always the alternative these people could be using (but can't or
> don't want to).

Sue, the question was: What is easy enough? I hoped that people would be
using gpg to check signed tags, and that there might be a simple,
convenient gnupg installer for Win and Mac which ties into the
respective wallet systems or provides one they use already.

> We could make our own gpg-based password wallet system, but I think it's
> a really bad idea, for two reasons:
> 
>   1. It's reinventing the wheel. Which is bad enough as it is, but is
>      doubly bad with security-related code, because it's very easy to
>      screw something up when you're writing a lot of new code.

So please let's not deploy credential-store...

>   2. It's inconvenient for users. Nobody wants a separate wallet system
>      with its own master password. They want to integrate with the
>      wallet system they're already using. Which is generally going to be
>      way nicer _anyway_, because it's going to be part of the OS and do
>      helpful things like unlock the secret store using their login
>      credentials.

On 1.+2.: The idea/hope was to use an existing wallet system which
people use for gnupg already to store their passphrase. If that is not
used then my suggestion does not help much (the issue of widespread
deployment), though it still is a secure version of credential-store for
those who want a desktop-independent secure credential store.

>>> So: What credential store/password wallet/etc. can we rely on for this
>>> group? Is gpg fair game?
>>
>> I think there probably need to be providers for using Keychain under
>> the Mac, gnome-keyring and kwallet under Linux, and probably something
>> using the wincrypt API under Windows.  I don't think there's a
>> one-store-fits-all solution here, unfortunately. :-(
> 
> Exactly. That's why the helpers communicate via pipes. They don't have
> to be included with core git at all; you should be able to just drop a
> third-party git-credential-foo into your PATH.
> 
>> I'm actually tempted try and work on a couple of those myself.
> 
> Please do! I mentioned a few people working on helpers elsewhere in this
> thread, so you may want to see what they've done and/or coordinate to
> avoid duplicate effort. Let me know if you have trouble finding the
> appropriate threads in the list archive.

It seemed appropriate to leverage GitHub for this:

https://github.com/gitigit/git/wiki/Git-Credentials-Hub

Feel free to add!

Cheers,
Michael
