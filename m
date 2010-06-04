From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Fri, 04 Jun 2010 09:38:29 +0200
Message-ID: <4C08AD75.6040307@drmicha.warpmail.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net> <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net> <7vsk537p8k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 09:39:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKRUn-0001Oz-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 09:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab0FDHjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 03:39:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:36258 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952Ab0FDHjG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 03:39:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 74CD1F8BD1;
	Fri,  4 Jun 2010 03:38:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 04 Jun 2010 03:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=u/n3tHGfbhjNhBwLRjfrpfvotpE=; b=raXFgkscXzLw16ON3SdsKDwn9Dmxk9q0Smn2TcAH1/JVPJAxYK7FTjijdt4aZk/QEMAHMnvj/m3DO9gaKApLMNP2OJs5rrUrNW1pRkjYdg/6H2dlJvzWCY+cAnJpEPJAka50aCQN2noR21jC6r6UAidniJzs9rY8utsdxvPKJlA=
X-Sasl-enc: t6TRj/1Gk405aNeA6obRoHvuIzOvv3Ib6Pq6ZeMF3evM 1275637131
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C61304D8CD2;
	Fri,  4 Jun 2010 03:38:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <7vsk537p8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148381>

Junio C Hamano venit, vidit, dixit 03.06.2010 23:58:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This puts the "No newline at end of file" warning for both code paths
> 
> This is not a warning.
> 
> It is an integral part of the diff output specification that allows patch
> recipients to correctly reproduce incomplete lines.  Removing this from
> the output is simply out of question.
> 

I'm sorry, but that makes 3 out of 3 respondents who didn't seem to read
what I wrote.

This series is about the display of that line for human-consumable
output such as log -p etc.

Patch 1/4 doesn't remove anything. It just makes it simpler to follow
the different diff code paths that we have.

In 3/4, that "No NL at EOF" is suppressed for symlinks *when textconv is
in effect only*, i.e. when we don't (necessarily) produce a diff fit to
be applied anyways.

As Jeff pointed out in his 2nd response, it may make sense to have this
dependent on TERM just like color output is currently (which messes ab
diff|apply also!).

I would even go so far to say that --no-textconv should be the default
for diff,log etc. unless the output goes to the terminal, just like our
color handling.

Michael
