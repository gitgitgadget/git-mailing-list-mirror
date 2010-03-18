From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Not possible to see combined diff before committing a merge?
Date: Thu, 18 Mar 2010 10:55:12 +0100
Message-ID: <4BA1F880.2090100@drmicha.warpmail.net>
References: <76718491003172321j2a184643o47ec3a712a3b0c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 10:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsCUK-0004R1-W6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 10:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0CRJ54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 05:57:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44208 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0CRJ5z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 05:57:55 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B1329E593A;
	Thu, 18 Mar 2010 05:57:54 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 18 Mar 2010 05:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=M5e73IDd3/nnkUHYHs4JfjufiCg=; b=ajSMDyV0BHCADADmCknU9kyxRjP1Rfgj5eeH93e0MBJmkLimKVkWJPGWD9ctNU8KOH44ft1pXA9KZZjSE6EXDCucIr1lYNZ6HOJFXgFSsgmkf+1ZGDFK0V1Rl5NuogOuuAV7ppQzqENH9pqyY9H/yIzf9q1LoFJ2CQl4M4PSHrU=
X-Sasl-enc: aqz2JwHgPFaS/ZtZTOATTDtBIMIKmghs+wBdn5q/1LW2 1268906274
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 21447EDD8;
	Thu, 18 Mar 2010 05:57:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100316 Lightning/1.0b2pre Shredder/3.0.4pre
In-Reply-To: <76718491003172321j2a184643o47ec3a712a3b0c12@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142454>

Jay Soffian venit, vidit, dixit 18.03.2010 07:21:
> Am I missing something, or is there no way to see combined diff output
> after completing merge resolution on a conflicted merge but before
> committing the merge?
> 
> $ git diff --cc [-- path]
> 
> works fine _until_ you've added the file to the index, at which point
> you're hosed.
> 
> I think I want the combined diff between:
> 
> - What's in the index
> - The first parent (ORIG_HEAD)
> - The second parent (MERGE_HEAD)
> 
> And I don't think that's possible, sadly.

The obvious attempt "git diff --cc --cached" does not work,
unfortunately, because the add cleared out the other stages from the index.

The funny thing is that after committing, git show will give you the
combined diff (again).

I guess that proves, again, that there can't be a symbolic ref like
INDEX because it just doesn't behave like one.

If there are no conflicted files left you could do a throw-away commit
with a temp index, but that looks ugly. Do we have a way of specifying a
3-way diff for some git diff --cc incarnation, i.e. pretending two
commits to be the parents and a third (or index) to be the merge result?

Junio would probably say that by adding the merge resolution you declare
that you're not interested in that part of the merge any more ;)

Michael
