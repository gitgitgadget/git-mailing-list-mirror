From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2013, #04; Wed, 15)
Date: Tue, 21 May 2013 08:27:43 -0700
Message-ID: <7vy5b8qro0.fsf@alter.siamese.dyndns.org>
References: <7vmwrvajye.fsf@alter.siamese.dyndns.org>
	<CACsJy8Cr7AKxo9sUjMCVQ0=O91L8CRoxD3qrvZczCrBUq4TDzA@mail.gmail.com>
	<7vk3mtwrq9.fsf@alter.siamese.dyndns.org>
	<87a9nobyae.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 21 17:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeoTf-0004mK-4m
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 17:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab3EUP1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 11:27:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab3EUP1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 11:27:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5754B20213;
	Tue, 21 May 2013 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zzrQXyK0uFg1QDurXFn8mZ0BVlk=; b=Im2TMy
	EiPUS9X0NAzq7NvB0osWptmWDgEugqprbhzZxqBz5cXlYaHo1WGBEYn7UvbuCaz1
	Qz8QE8Qb2IsjKt2STWvjfPtRqvDmlHZYK6dZysnQlSenbe/qVXk7NAJITAl92ce4
	Ke0bwMu91d1OfoKBlqmd3UPMvSxM/ROXQovjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fw1kIK1nzlLhRgJWF8OhIqbIJtU9B5kL
	GXcEj71Vf4HQVevHlym/KDcY8OQ+I7C7VF3hYFijqC+Iu3mVaoVOhUteO4FLw+Ho
	HTCqpKejRhb7UQd153l4DZ36UtJ88ehcRzQPxXdFHLaiYIWg87NWQSmtna5JXCQ3
	CCj+519XlpQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A8C820212;
	Tue, 21 May 2013 15:27:45 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC97A20211;
	Tue, 21 May 2013 15:27:44 +0000 (UTC)
In-Reply-To: <87a9nobyae.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 21 May 2013 09:13:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC0F9740-C22A-11E2-A3D9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225032>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> In addition to your topic, it may be a good idea to notice this at
>> the Porcelain level (e.g. "checkout -b" and "branch", but not at the
>> "update-ref" level) and warn or even die if a Porcelain tries to
>> create a branch with such a name.
>
> But if we're going there and deprecating some ways of naming refs,

This is not about deprecating but is discouraging a confusing use at
the Porcelain level (i.e. enforcing one policy decision that may not
apply to those who wrote their own workflow using plumbing commands,
knowing and following the "full 40-hex is taken as an object name,
not a dwimmed ref" rule---to them there is no ambiguities).

I think I see where you are going and I do not necessarily disagree
with that, but it is a separate topic.

> please also disallow some other funny things in the same go.  Michael
> suggested this earlier in some thread: the fewer ways we have of legally
> spelling refnames, the more syntax is available for revision syntax.
