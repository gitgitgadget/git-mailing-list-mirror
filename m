From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Feature Request: Passing a number as an option to git tags for
 displaying latest tags
Date: Thu, 23 Jul 2015 11:39:51 +0200
Message-ID: <55B0B667.6000103@drmicha.warpmail.net>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
 <xmqqbnf4rohs.fsf@gitster.dls.corp.google.com>
 <xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?SGFsaWwgw5Z6dMO8cms=?= <halilozturk55@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 11:40:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZICyx-0004iy-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 11:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbbGWJkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 05:40:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33514 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752668AbbGWJjz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2015 05:39:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 8A8C120BEF
	for <git@vger.kernel.org>; Thu, 23 Jul 2015 05:39:53 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 23 Jul 2015 05:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=z3DkRAD4udPns3DPx+JTVSAwaRg=; b=AsytO2
	WIy8g6KoulqUQTjQ78Q+R66/UrjQxCJflddq+oVpcfI06uziaoFUxU1P+DA1WGKE
	MGruH87OJlgsNkt9Assx0HC0EBw0tBjq65LIrSxmiyj6oVd9kucRRN7XlFyNgiTV
	NQ57Hmjr+IPvKlEGjESM6YkoNvDcXo/ddj41M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=z3DkRAD4udPns3D
	Px+JTVSAwaRg=; b=i2NozJztUVfpcyqmJc4Cndu1O6QhM6c2e9YH095qFW8xxJV
	ChT/CyVrMtywq4KllcsxoARb+DMNtRCy4ita8lTC55CYfD3QQqSDxceJuan7fjbc
	qvFAvO1TS+Qgj9j33ui65w7wQgDCeNlLseQMne12G5e1/reIg4Lf3RDSK9nY=
X-Sasl-enc: X2+WOTG4NShHxiQ4Sgvu/yUJTAsBWSAJ7rLkgXCaIMpy 1437644393
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AF6606801AC;
	Thu, 23 Jul 2015 05:39:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274490>

Junio C Hamano venit, vidit, dixit 22.07.2015 21:20:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The former, sort by "time", is interesting, but you need to define
>> what to do with various corner cases.  For example, some people may
>> have one or more of the following desires:
>>
>>  * My project did not use tags for a long time, and started using it
>>    recently starting from v1.1.0.  The first release only said
>>    "Frotz version 1.0.0" in its commit log message.  I retroactively
>>    did "git tag -s -m 'Frotz 1.1.0' v1.1.0" on that commit.
> 
> Obviously, I meant "git tag -s -m 'Frotz 1.0.0' v1.0.0" here.
> 
>>    In such a case, it is likely that I would want the sorting done
>>    based on the committer date on the underlying commit, not the
>>    tag's tagger date.
>>
>>  * When a bug is found, it is customary in my project to add a
>>    "break-<something>" tag to the commit that introduces the bug
>>    (and "fix-<something>" tag to the commit that fixes it).
>>
>>    When I want to find recently discovered breakages, I want the
>>    tags whose names match "break-*" sorted by tagger dates, not the
>>    underlying commit's committer dates.
> 
> Another use case may be one in which older tags are interesting.  In
> other words, you need to be able to sort in reverse, too.
> 
>> The necessary ordering machinery to do the above already exists in
>> "for-each-ref".  There is a GSoC project that works to unify various
>> features spread across "for-each-ref", "branch -l" and "tag -l" and
>> make them available to all of the three.
> 
> And the above is still true even with reverse-order use case.
> 

While not quite being intended for that purpose,

git log --oneline --decorate --simplify-by-decoration [-n] --tags

(or with a custom format instead of "--oneline --decorate") may come
close to what you want.[*]

Michael

[*] As Linus once described it (iirc): oooh, evil. I like it.
