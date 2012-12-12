From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Wed, 12 Dec 2012 15:43:46 +0100
Message-ID: <50C89822.9050900@drmicha.warpmail.net>
References: <7vd2yojbw2.fsf@alter.siamese.dyndns.org> <1622149333.19335600.1354756984435.JavaMail.root@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 15:44:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TinXZ-0000En-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 15:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab2LLOns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 09:43:48 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50822 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753920Ab2LLOnr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 09:43:47 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 082992072A;
	Wed, 12 Dec 2012 09:43:47 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 12 Dec 2012 09:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=NhLQ3XR6/gv+Tmy4GYZHOG
	biZs4=; b=dWspke/UJotpmMdFtVycBWLNHvA4p562P7+4CNiYsnws3iixfOrt84
	pEOPduoBMphHHPcizLWlSutQP3DkYtWqJGPz0zvgow0GJ/59QYlRYQ+qzbR2oreO
	JE6FhrFEPlkVgVyJBBZm8ACKT1zynUqqo3U5qD7QSfUiNXOP9nNpk=
X-Sasl-enc: clw6ZJI7Y/TkK3uKB5fYomJg8YNwWmOWa7XgvH83bkGy 1355323426
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6C4CC4827CB;
	Wed, 12 Dec 2012 09:43:46 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1622149333.19335600.1354756984435.JavaMail.root@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211355>

Robin Rosenberg venit, vidit, dixit 06.12.2012 02:23:
> 
> 
> ----- Ursprungligt meddelande -----
>> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>>
>>> If core.symlinks is set to copy then symbolic links in a git
>>> repository
>>> will be checked out as copies of the file it points to.
>>
>> That all sounds nice on surface when the primary thing you care
>> about is to fetch and check out other people's code and extract it
>> to the working tree, but how well would that work on the checkin
>> side?  What happens if I check out a symlink that points at a file
>> (either in-tree or out-of-tree), make some changes that do not
>> involve the symlink, and before I make the commit, an unrelated
>> change is made to the file the symlink is pointing at?
>>
>>> - git status - when do we report a diff.
>>> 	- After checkout we should probably not
>>> 	- if the "linked" files change?
>>
>> Yeah, exactly.
>>
>>> 	- if a change in the copied directory chsnges
>>
>> That, too.
>>
>>> 	- if a file in the copied diretory is added/removed
>>> 	- update, should we update the copied structure automatically
>>> 	  when the link target changes
> 
> Some of the questions have proposals in the includes test script. A 
> little more dangerous than having real symlinks ofcourse, but regardless
> of what one does with or without copied symlinks one can make mistakes
> and I feel letting Git do the copying is way better than having real
> copies in the git repository. Another crappy scm which the users are
> converting from does this and it works. A difference to git is that
> it (ok clearcase) makes all files read-only so there are fewer mays
> of making mistakes with the copies.
> 
>> I personally do not think this is worth it.  It would be very useful
>> on the export/checkout side, so it may make sense to add it to "git
>> archive", though.
> 
> It makes sense, but it does not solve the problem at hand.
> 
> -- robin
> 

Well, what is the problem at hand?

Your commit message begins in present tense as if it described the
current state of git, when in fact it describes what the patch is about
to achieve. This is confusing enough already,

I don't see any mention of the purpose, other than "content may be
used", which would be served perfectly by a copy-on-link feature on the
export side, as mentioned by Junio. Is git-archive|tar an option?

Michael
