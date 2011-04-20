From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] git add: notice removal of tracked paths by default
Date: Wed, 20 Apr 2011 10:18:15 +0200
Message-ID: <4DAE96C7.9070904@drmicha.warpmail.net>
References: <7v1v0y59tv.fsf@alter.siamese.dyndns.org> <20110420055758.GC28597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 10:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCScE-0002AR-D4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 10:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab1DTISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 04:18:20 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48891 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808Ab1DTISS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2011 04:18:18 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8949E206C2;
	Wed, 20 Apr 2011 04:18:17 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 20 Apr 2011 04:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aqm5EmnsH5rGuJ/oWY+VasNw8qc=; b=pVTUNLm36VCHRlvelgejxSTohhqBaRFFmPWAGnOqnz3qaZjBtmweQ/YgZ4wjHLU23J6DdVaaeJ3b7Na60MhK54b9ZOqpsWtEbe/eSeKTnaUMvLZIZX6qm4eVyYu4q+wyWlWdmAwcTd9Fdxsi7It3dNp3R9UQmtxDH9FeBfz+v8E=
X-Sasl-enc: p3wxUMMMoCdQXga6AJBZRR4JxwbOw0DCYJGEqer+uUMK 1303287497
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E8CE9402558;
	Wed, 20 Apr 2011 04:18:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110420055758.GC28597@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171852>

Jeff King venit, vidit, dixit 20.04.2011 07:57:
> On Tue, Apr 19, 2011 at 12:18:20PM -0700, Junio C Hamano wrote:
> 
>> Make "git add" to pretend as if "-A" is given when there is a pathspec on
>> the command line.  "git add" without any argument continues to be a no-op.
> 
> I like your proposed semantics much better. I remember many times early
> on with git cursing the current behavior, until I finally trained myself
> to do "git add -A".
> 
>>  This might not be such a good idea, and I do not have a strong opinion
>>  for this change, but merely a weatherbaloon.
>>
>>  Having "git add ." notice removals might lead to mistakes ("oh, I only
>>  meant to record additions, and didn't want to record the removals"), but
>>  at the same time, leaving it not notice removals would lead to mistakes
>>  by the other people ("I added, removed and edited different paths, but
>>  why only removals are ignored?").
> 
> I suspect most people will want the new semantics, because no matter
> what your overall workflow, it is generally going to be some variant of:
> 
>   1. hack hack hack
>   2. tell git about changes
> 
> And you don't really care about deletions versus modifications, you just
> want them all added. But you probably _do_ care about additions versus
> modififications, since step 1 often involves creating cruft that should
> remain untracked (whereas it very rarely involves _deleting_ precious
> files). And that's why we have "add -u", which should not go away.
> 
> My biggest worry would be people saying "eh? Add removes my files? That
> makes no sense!" But we more or less already have that with "add -u",
> and I think people have learned to accept that it is about "add the
> current state to the index" and not "add files to git".
> 
> -Peff

Yes, that behaviour makes much more sense.

That means that "git add -A" is "git add ." and "-A" is not needed
otherwise any more, right? makes sense, too, and we could probably
deprecate (i.e. stop advertising) it.

Michael
