From: Andreas Ericsson <ae@op5.se>
Subject: Re: The git protocol and DoS
Date: Thu, 20 Oct 2005 10:16:45 +0200
Message-ID: <4357526D.2000807@op5.se>
References: <4356A5C5.5080905@zytor.com> <20051019222044.GP30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Oct 20 10:17:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESVbd-0008AN-A8
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 10:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbVJTIQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 04:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbVJTIQr
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 04:16:47 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:36536 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751707AbVJTIQq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 04:16:46 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id AE0516BCFE
	for <git@vger.kernel.org>; Thu, 20 Oct 2005 10:16:45 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20051019222044.GP30889@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10353>

Petr Baudis wrote:
> Dear diary, on Wed, Oct 19, 2005 at 10:00:05PM CEST, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> told me that...
> 
>>One way to do this would be to start the transaction by having the 
>>server transmit a cookie to the client, and to require the client to 
>>send a SHA1 of the (cookie + request) together with the request.  This 
>>would be done with a fairly short timeout.
> 
> 
>   If (well, it sounds like a good idea, so rather "when") you do this,
> it would be a good idea to do in a way that makes it easy to later add
> support for some kind of authentication (really, not everyone wants to
> give away ssh accounts). Let's say it works like:
> 
> [client]	git-upload-pack <path>
> [server]	challenge somethingnonsensical
> [client]	challenge-response <username>:sha1(somethingnonsensical<password>)
> [server]	All right, the pack goes like this...
> 
>   Suddenly you have support for hopefully secure authentication, and at
> the same time you have the cookie implemented in backwards-compatible
> fashion (in the sense that new client will be able to talk to old
> server) - just assume the username and password empty. This might be
> even hardcoded for now, just leave a room for its addition (in an
> elegant and compatible way) in the protocol, please.
> 

I think git-daemon would be better off without this, since
* A project rarely grants write access to the central repo (or whatever 
git has, I'm still fairly new to it) without being willing to give out 
ssh access, often limited by the ssh command whitelist.
* It's hard to do right.
* Passwords are never as secure or as convenient as public key 
authentication and there's no point in spending a lot of time 
re-inventing ssh.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
