From: Dustin Sallings <dustin@spy.net>
Subject: Re: [PATCH] Allow tracking branches to set up rebase by default.
Date: Sat, 10 May 2008 15:36:13 -0700
Message-ID: <1206EB02-2AE6-4A97-AF00-D16B8E686D9B@spy.net>
References: <7vprrycce9.fsf@gitster.siamese.dyndns.org> <1210271287-36719-1-git-send-email-dustin@spy.net> <7vfxsq9f3n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 00:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuxhG-0002nf-EY
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 00:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbYEJWgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 18:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756238AbYEJWgm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 18:36:42 -0400
Received: from basket.west.spy.net ([69.230.8.154]:56868 "EHLO
	mail.west.spy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756184AbYEJWgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 18:36:41 -0400
Received: from dustinmb.west.spy.net (dustinmb.west.spy.net [192.168.1.56])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by mail.west.spy.net (Postfix) with ESMTP id 5C74E34D;
	Sat, 10 May 2008 15:36:14 -0700 (PDT)
In-Reply-To: <7vfxsq9f3n.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81710>


On May 10, 2008, at 11:41, Junio C Hamano wrote:

> - die_bad_config() takes a variable name without surrounding  
> explanatory
>   text.  If you actually tested your patch and looked at the error
>   message, it would have been blatantly obvious and you would have
>   noticed it.  Not a good sign.
>
> - Test not just the success cases but failure cases; test not just
>   explicitly configured cases but also default cases.

	You're right, I didn't test misconfiguration cases.  I've updated the  
patch per your recommendations with a lot more tests and have manually  
tested the error messages to ensure they make sense.

	Does it make sense in the cases where a value is bad to list the  
valid values?  I don't see a precedent (so I don't know what format  
would be most desirable), but it might be friendly.

> Also I suspect that we would want to test cases where
> autosetuprebase is given but autosetupmerge is not.

	This code isn't so much dependent on that variable, but on the  
effects of that variable, which may be overridden by the --track and -- 
no-track parameters.  I think it'd be best to leave the effects of  
that variable in its own tests wrt tracking since this code doesn't  
kick in until after the tracking is set up.

> Another thing we might want to address is to move parsing of branch.*
> configuration variables out of git_default_config().  They are  
> unnecessary
> for majority of commands that do not create new branches.  But that  
> would
> be a separate topic if we were to do so.

	I agree with this.  I tried initially to not have it be part of the  
default config parser, but it seemed a lot more disruptive, so I just  
followed autosetupmerge.

	Thanks for your input again.  New patch to follow.

-- 
Dustin Sallings
