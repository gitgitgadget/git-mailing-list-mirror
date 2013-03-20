From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge <tag> behavior
Date: Wed, 20 Mar 2013 11:46:16 -0700
Message-ID: <7vwqt1ewp3.fsf@alter.siamese.dyndns.org>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802682.6289.46.camel@test.quest-ce.net>
 <1363803172.6289.49.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIO2C-0004tv-70
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab3CTSqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:46:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63157 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932773Ab3CTSqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:46:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5625A1E7;
	Wed, 20 Mar 2013 14:46:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wOAfArxaHer4rpMS2rztMhO8kVs=; b=EyUlRG
	k06XfCgr6Y7cegVW6onRc6jdqSLE+fsccwnqcXefR4MnuUi9BxepGHKPXRAbrRXU
	y/dxeMvvEzJMTeiJ9LPgBjiMXXGpKU+CkjGjUslF+W2q3H3oP7TYu5JnS5u/FQX2
	f8asnBRCKeqFLHty9NTovnu5A4qodPoqGuOpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSGMlX3E8V2bZRbKlp4SDl7Zu72kRQWZ
	R4ILJSM9+M9fOQ0ebztcwVP1BkM5TCujbpA5rubobL10YNr4vxqGCMHSrRYLONgi
	m3frp2BOMG60cVC5Mhbrty+jjf4wQ/kgLNVzqnUB1TUAkaqnsiyjouDIKqAW1jlN
	HAyJSx2jhrk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A92A8A1E6;
	Wed, 20 Mar 2013 14:46:18 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29C8DA1E4; Wed, 20 Mar 2013
 14:46:18 -0400 (EDT)
In-Reply-To: <1363803172.6289.49.camel@test.quest-ce.net> (Yann Droneaud's
 message of "Wed, 20 Mar 2013 19:12:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73630D04-918E-11E2-9939-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218650>

Yann Droneaud <yann@droneaud.fr> writes:

> But but do not take those remarks as a feature request.
> I was just asking for clarification/comment on the behavior difference
> between merging tag/tag object-id.

If you are asking why things are as they are, the answer is simply
because "git merge $(git rev-parse v1.2.3)" was not even considered
while adding the support to pull signed tags.

We did find the use case for "git merge v1.2.3" interesting and
important enough to give it a proper support with defined semantics.
"git merge $(git rev-parse v1.2.3)" may behave differently but it
was not because we found the use case for it important and designed
a behaviour that is different from merging the tag by name that
suits that use case.

It is just we didn't even think giving the bare object name to name
an annotated or signed tag on the command line is interesting, and
the command does whatever the implementation happens to do to such
an input.

I think I sent out a "how about this" patch.  Have you tried it?
