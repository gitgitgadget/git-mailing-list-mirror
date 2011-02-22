From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 10:38:12 -0800
Message-ID: <7v7hcrewyz.fsf@alter.siamese.dyndns.org>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net>
 <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
 <20110222081458.GA11825@sigill.intra.peff.net>
 <m3wrks756a.fsf@localhost.localdomain>
 <20110222152723.GA23353@sigill.intra.peff.net>
 <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:38:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prx85-0003YT-0p
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab1BVSi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 13:38:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1BVSi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 13:38:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4EB84C78;
	Tue, 22 Feb 2011 13:39:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRoZgcmt5SvXPXpSNGGo23iDgVc=; b=ciaq6D
	nq+Qr+Zs7EGhLAqRAa/n+4ja596BwJjZsJt3NQZ0yELgXl6ueav3BL/Xibxpy8HT
	dE4A3F+aM+MUDMHdWUuYLuXSCrrRO4TbJZLKjj3jcfOluZ3GCXy4MVzo3iNEmlSo
	kvDYsI6/9UPI1OwPRx6XTAEqL90eA3qNFJOvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NUTGO3PxpMUgFAK9CJkv/W0dWn3lV22w
	kgEx98+eQXqCPiYisUYUMFjWp+9yUAyd/A611JhLAv/AVjInV4ybB+lfSvuG70lt
	Xb1xtFojIinzQU41KJLzKyCWUqaFVcHfK9xgnG+Egdv+TTPovBYUvOiDj7nWxIy7
	NPZpVVj8RlA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F5514C76;
	Tue, 22 Feb 2011 13:39:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E34404C71; Tue, 22 Feb 2011
 13:39:25 -0500 (EST)
In-Reply-To: <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com>
 (Christian Halstrick's message of "Tue\, 22 Feb 2011 17\:21\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 164D6EAA-3EB3-11E0-86C4-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167571>

Christian Halstrick <christian.halstrick@gmail.com> writes:

> I am not sure whether what is discussed now is really solving my
> problem best. Maybe I rephrase again the problem I have:
> I just want to make sure that certain commits are not garbage
> collected. And the artefacts I create to ensure that should not
> pollute the namespace of developer-created tags/branches. Is creating
> a tag and then hiding it again really the best solution for that?
>
> Here is some background: there is a tool developed in our company which
> helps teams to release their git-controlled products. The release tool
> gets as input just a commit ID. Whenever the release tool has
> succesfully done his work on a product it wants to make sure the this
> commit will never be garbage collected. Even not if month's later the
> product owner resets all their branches making the released commits
> beeing unreachable. And since some projects may run a lot of attempts
> until they finally released some stuff we don't to have our tags
> namespace to be polluted with too many attempt-to-release tags.

How about taking advantage of the fact that you do not have to treat tag
namespace as a global thing?  For the "release tool" to "get a commit ID"
and do something useful, the "release tool" must be working on a git
repository, and hopefully that repository is something other than the ones
developers directly play with (by checking out random branches in its
working tree and compiling, etc.).

You can run "git tag" in that "release tool" repository, and if you do not
want to show that to others, never let developers fetch tags from there.

I would think that using a private namespace other than tags for your own
use (e.g. "git update-ref refs/anchor/release-20110222 $that_commit") may
be the best option that is easiest to understand, though.
