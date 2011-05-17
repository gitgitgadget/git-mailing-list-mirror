From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Tue, 17 May 2011 10:03:48 -0700
Message-ID: <7vei3xgsy3.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
 <7vei3zoab9.fsf@alter.siamese.dyndns.org>
 <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
 <20110516070047.GA26270@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:04:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMNhC-0004E6-5c
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab1EQRER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 13:04:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab1EQRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 13:03:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CCC74D65;
	Tue, 17 May 2011 13:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=89ph5odFsOFoQca6FEV9xDnbJoE=; b=uTy08L
	mDvXqHwFv0KG/KxxiUasMbX0J6xxSW5dZIJ0KVOK7yxHO2cYceu48UPn0rltc+2m
	ybGmIIYj56I2oCvoW3UoYwMiPR+DQXw03y3Jsot+I/J1rEyEzetvW6ijVlO0kGbG
	2Qccro51lEuTWaETg83xW8AOa4/hHHtbIhg+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x2mNHriWnxOHjpX2O6401n1D8DgqTlLa
	9qFdBN++YilhULa63Gp+r/Fy+4vpVH0iCvJ2qqXkSX+nV5RY+qB8njK8Bdo2d+gJ
	if/KBY/5lWmZGeEtDuUkjNHPOCTAdBiqQoPOfgIl74RQUfpICQt4/ntfwf2cHp8H
	ZdNUrfP3/Jc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDD684D64;
	Tue, 17 May 2011 13:06:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A85B4D63; Tue, 17 May 2011
 13:05:57 -0400 (EDT)
In-Reply-To: <20110516070047.GA26270@elie> (Jonathan Nieder's message of
 "Mon, 16 May 2011 02:00:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F156C948-80A7-11E0-A07D-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173814>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jay Soffian wrote:
>> On Sun, May 15, 2011 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> I am not entirely happy about this change. The "ditto" refers to an ugly
>>> workaround we had to add with 4f62c2b (log.decorate: only ignore it under
>>> "log --pretty=raw", 2010-04-08) only because it was too late to revert the
>>> change in 72d9b22 (Merge branch 'sd/log-decorate', 2010-05-08) that was
>>> about to become part of 1.7.2-rc0 release. If we knew better, we probably
>>> wouldn't have added the log.decorate variable that requires this hack that
>>> requires us to say that 'log --pretty=raw' is special.
>>>
>>> If we stop before adding a new configuration, we do not have to repeat the
>>> same mistake we made earlier.
>>>
>>> I dunno.
>>
>> I disagree that log.decorate is a mistake and that the workaround is
>> ugly.
>
> I suppose part of what Junio is saying is that by the time the commits
> referenced above were written, git had already broken some scripts
> (including gitk) and those changes were part of a desparate attempt to
> contain the damage.  So they are not a great example to look to for
> the sort of smooth transition it is possible to set up proactively.

Thanks for rephasing.

> One transition plan could look like this:
> ...
> Now, returning to "log --pretty=raw".  Is it plumbing or not?  It
> would be nice to advertise whichever way it is decided (I guess it is
> de facto plumbing) in the "git log" reference documentation and to
> follow that decision in cases like this one.
>
> Thanks for some food for thought.

Although I find the cop-out "if you set this variable, some third-party
tools may break---please do not complain to us, but send bug reports to
these third-party folks" somewhat attractive, I am reluctant to take that
position. I suspect some projects do work that way, and if it works for
them, it may turn out that we wouldn't get much flak doing so ourselves,
but still...

But having slept on this, I would agree that it is a pragmatic solution to
declare "pretty=raw _is_ special" and keep it that way.  Let's queue v3
from Jay and see what happens.

Thanks.
