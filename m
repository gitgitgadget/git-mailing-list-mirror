From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 14:10:31 +0200
Message-ID: <4C98A0B7.9050501@drmicha.warpmail.net>
References: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com> <4C987C2E.3060001@drmicha.warpmail.net> <4C98830A.70203@viscovery.net> <4C989BBD.80106@drmicha.warpmail.net> <4C989E6B.1070703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joshua Shrader <jshrader83@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 14:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy1g6-0002KI-I1
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 14:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab0IUMKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 08:10:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58127 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753879Ab0IUMKX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 08:10:23 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7A081557;
	Tue, 21 Sep 2010 08:10:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 21 Sep 2010 08:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LIBK5bm581DxFpvZ/aY04SK4igM=; b=DpL5bKTYaMFqak1d+YE2sfv9K7/Orx8wbhihhVSTUtTASnuc90QzqmPGE+EB+G4B63AgWff8JdhOpMu/0MjTk7kzXyfejQ/tnV3FJ6DPvHvbuLDQ05bxAxrBp8b07VfsyT306muDl9l2v331fp6Mbh0upTBoJLGU3VpzcPUqh7E=
X-Sasl-enc: 9bryK8PYBw+prdwEcL8UsU9xFSxWkgNi7L5S6aNnnKUj 1285071023
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DD3604007F9;
	Tue, 21 Sep 2010 08:10:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <4C989E6B.1070703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156718>

Johannes Sixt venit, vidit, dixit 21.09.2010 14:00:
> Am 9/21/2010 13:49, schrieb Michael J Gruber:
>> Johannes Sixt venit, vidit, dixit 21.09.2010 12:03:
>>> git describe e5498e8a^2 e5498e8a^1~24 e5498e8a
>>> v1.7.0.7
>>> v1.7.1.1
>>> v1.7.1.1-38-ge5498e8
>>>
>>> v1.7.1.1 is 25 commits away, while v1.7.0.7 is a parent (the second).
>>>
>>> AFAICS, git-describe does The Right Thing (--first-parent).
>>
>> I'm not saying it does the wrong thing. I'm saying it does not do
>> --first-parent but depth priority (where depth is a bit complicated),
>> which may or may not be the same as first-parent transversal/priority.
>> You picked one case where they coincide:
>>
>> git describe --debug e5498e8a^2 e5498e8a^2~24 e5498e8a
>> v1.7.0.7
>> v1.7.0.5
> 
> This should be "v1.7.1.1", no?

Well, e5498e8a^2~24 == v1.7.0.5 and e5498e8a^1~24 == v1.7.1.1.
The copy&paste from your e-mail was not exactly helped by Thunderbirds
conversion of ^2, ^1 into exponents... In any case, the numbers below
are what matters:

> 
>> searching to describe e5498e8a
>>  annotated         38 v1.7.1.1
>>  annotated        252 v1.7.1
>>  annotated        268 v1.7.1-rc2
>>  annotated        318 v1.7.1-rc1
>>  annotated        355 v1.7.1-rc0
>>  annotated        478 v1.7.0.7
>>  annotated        492 v1.7.0.6
>>  annotated        512 v1.7.0.5
>>  annotated        539 v1.7.0.4
>>  annotated        564 v1.7.0.3
>> traversed 1267 commits
>> more than 10 tags found; listed 10 most recent
>> gave up search at 97222d9634b5518cd3d328aa86b52746a16334a7
>> v1.7.1.1-38-ge5498e8
>>
>> v1.7.1.1 clearly wins by depth priority.
> 
> If "depth priority" is not the shortest ancestry path (and it obviously is
> not given the numbers above), what is it then, and why does it not work
> with Joshua's example? Wouldn't it be better to make it Just Work instead
> of adding a workaround that has to be enabled manually?

I don't consider the existing behaviour wrong, though it may be a bit
tough to figure out. It may even be that the depth calculation has an
off-by-1 error which leads to this behaviour.

Consequently, I don't consider --first-parent a workaround. Note that
with --first-parent, tags on other branches are not even considered so
that you can be sure to get a first parent tag or none.

Do you really think that changing the algorithm would be accepted? In
any case, at most that would lead to prioritizing first parent tags
unconditionally but still resorting to other tags when there are no
first-parent tags.

Michael
