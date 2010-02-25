From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] Different views on a repository
Date: Thu, 25 Feb 2010 13:30:24 +0100
Message-ID: <4B866D60.6040306@drmicha.warpmail.net>
References: <cover.1267029680.git.agruen@suse.de> <92fea2335b73265b04d64fcc217055e1170f5e16.1267029680.git.agruen@suse.de> <4B863C77.8040304@drmicha.warpmail.net> <201002251025.22881.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 13:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkctg-0003Su-D0
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 13:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343Ab0BYMcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 07:32:47 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39338 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932338Ab0BYMcq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 07:32:46 -0500
Received: from compute2.internal (compute2 [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9A671DECD9;
	Thu, 25 Feb 2010 07:32:45 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 25 Feb 2010 07:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8S3mLEen2vjnQVZBa0IXAJFugGk=; b=DWI6UItgmf8ZrtZRjbWD7tVMiS+BsPkJlZz47aKqiiYcwqa3DMP1NWZlrE42MD1KNeL4/KcxttRfiMoz3lpebesR6zj9WkZCMrlJAHisGGx0BpbF0JJ4ffZcUL1qysZRhibvuNFM27JEyW9eQiigf+6clGmmqOfWpdSwYN6Be5k=
X-Sasl-enc: iEMsyolO7V/pfCJK/Yr1keTYFZ1FHFhBSUF5CS3un7kX 1267101165
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0C5AC3AAFB2;
	Thu, 25 Feb 2010 07:32:44 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100222 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <201002251025.22881.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141047>

Andreas Gruenbacher venit, vidit, dixit 25.02.2010 10:25:
> On Thursday 25 February 2010 10:01:43 Michael J Gruber wrote:
>> Andreas Gruenbacher venit, vidit, dixit 24.02.2010 16:57:
>>> Add --view options in upload-pack and receive-pack so that a repository
>>> on the server side can be made to look like several independent
>>> repositories on the client side.
>>>
>>> This is implemented by transforming ref names: for example, with
>>> --view=one/, refs/heads/one/master on the server will look like
>>> refs/heads/master to the client, refs/tags/one/v1 will look like
>>> refs/tags/v1, etc.
>>>
>>> This allows to transparently share repositories on the server which
>>> have a lot of objects in common without complicating things for the
>>> client, and without breaking garbage collection.
>>
>> Just from this description, I can't see why the same can't be done with
>> appropriate refspecs. (A helper for doing that would be more welcome, of
>> course.)
> 
> You mean on the client side? The problem then is that a simple "git clone" 
> would not do the right thing anymore; you would still expose server-side 
> implementation details to clients. Clients shouldn't have to bother with this 
> added complexity. (They might not even have access to some of the views.) When 
> you do the mapping server-side, you can split or merge repositories as needed 
> without the clients even noticing.

But the client has to request a specific view, doesn't it? You have to
tell all clients "don't just clone, use...", where the "..." don't seem
to be part of the series yet. [I could see 0/3 on gmane only now, by the
way.]

I just can't help the impression that this is a use case which does not
need a new feature, at least not upload/receive-pack wise. It's more a
matter of ensuring that all clients use a specific configuration (which
you would have to with your patch as well, AFAICT), and this more
general issue is creeping up again and again, with no agreeable solution
so far.

Cheers,
Michael
