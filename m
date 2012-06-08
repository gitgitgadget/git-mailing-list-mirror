From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Fri, 08 Jun 2012 15:22:11 -0700
Message-ID: <7vmx4dbg18.fsf@alter.siamese.dyndns.org>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
 <CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
 <CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
 <7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
 <7v8vfzjbhi.fsf@alter.siamese.dyndns.org>
 <CAH5vBdLGHpFCH3mWgNANTw4frzqSz=AO+kB12DSx55wn1hYJag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cheng renquan <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd7Zm-0005Tp-Gb
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jun 2012 00:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab2FHWWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 18:22:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab2FHWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 18:22:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7A4685BF;
	Fri,  8 Jun 2012 18:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ebJy2BCo+q4vSar1ZCuQI7IdRf8=; b=yb0NOD
	XbQV3tQoS91ZWL3ZcPFIWTyQzMsvfwFR0nYRPcZ46H3zP4vtDelxI8vTMX3yYQKN
	5lLivPnMXOMIMUbTH5nRDwSSGRnPk4xOzOWmHC4ktovJ6A4wwzCyXS5g6zkjvSLS
	7ozAq/aHI6JMeD0RuOcg9HKy5/7w+GePvyAEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZZJcA2BWIxfuKpNSqpyKEJlo7hI7esT
	rfFxJ1BxDdaITWZjOW75huVIt8k4oWZnruMhZUolyzpmQAMiLacfoD8TTCZFORzI
	54RWzhOr9goF+dB/W2k0vBk1Hi9Qi5CoUEMXq3HUmnlZlDWGj9wEbUP5Rk/rPFIU
	0Fc2w0tjtYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EF4085BD;
	Fri,  8 Jun 2012 18:22:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA0285BC; Fri,  8 Jun 2012
 18:22:13 -0400 (EDT)
In-Reply-To: <CAH5vBdLGHpFCH3mWgNANTw4frzqSz=AO+kB12DSx55wn1hYJag@mail.gmail.com> (cheng
 renquan's message of "Fri, 8 Jun 2012 14:46:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 657474FA-B1B8-11E1-B083-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199536>

cheng renquan <crquan@gmail.com> writes:

> On Thu, Jun 7, 2012 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * The auto-follow kicks in whenever you tell "fetch" to update some
>>   refs locally.  Maybe if we tweak the rule and auto-follow kick in
>>   only when you tell "fetch" to update some refs outside refs/tags
>>   locally,
>>
>>        $ git fetch $over_there tag v1.0.0
>>
>>   will fetch and store _only_ the v1.0.0 tag.
>>
>>   Of course, any behaviour change is a regression, and if done
>>   without an escape hatch, such a change robs people one useful
>>   feature: grab tag v1.0.0 and others older than that tag in one
>>   go.
>>
>> I won't be coding any of the above; just thinking aloud.
>
> Here is the code to implement your 2nd approach,

The patch is obviously and trivially correct ;-)

> and I don't think this behaviour change is a regression,
> because if someone is really relying this fetch one tag actually fetch
> all tags feature
> he is relying on a broken feature,

I do not think the old behaviour is broken. "tag v1.0.0" asks for
refs/tags/v1.0.0 at the remote and store it at refs/tags/v1.0.0
locally.  And when you ask "git fetch" to store something in refs/
hierarchy like that, without --no-tags, you are also asking tags on
commits reachable from v1.0.0 (e.g. v0.99, but not v1.1.0).

	Side note: I just double-checked this.

	$ git init junk && cd junk
        $ git fetch ../git.git tag v1.0.0

	Of course, I get v1.0.0, many tags in v0.99 series and
	v1.0rc tags, but nothing newer.

I would grant you that "asking for only tags v1.0.0 and everything
before" is not a very common thing to do, but I do not think it is a
wrong feature in any way.

In any case, when we discuss regression, "I think the old behaviour
is broken" does not matter.  Change in behaviour is change in
behaviour, even if the new one is superiour than the old one (and I
tend to think that if I were doing Git from scratch, I probably
would have coded the auto-follow part to ignore refs/tags hierarchy).

The problem of introducing such a change _today_ is that it robs a
way to ask for tags v1.0.0 and all tags before it, which people can
do with Git without the patch.  A new --auto-follow-tags option that
undoes what the patch does could remedy it, but without such an
escape hatch, the change will be a true regression as it not just
changes behaviour but it loses capability.
