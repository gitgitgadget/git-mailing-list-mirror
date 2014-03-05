From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New directory lost by git am
Date: Wed, 05 Mar 2014 11:10:46 -0800
Message-ID: <xmqqtxbch361.fsf@gitster.dls.corp.google.com>
References: <531690A3.3040509@ubuntu.com> <53169549.10309@gmail.com>
	<53169868.3010401@ubuntu.com> <5316DBEC.3020208@gmail.com>
	<53173423.6050708@ubuntu.com>
	<20140305163415.GA28908@sigill.intra.peff.net>
	<53175510.7020000@ubuntu.com>
	<20140305171334.GA31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phillip Susi <psusi@ubuntu.com>,
	Chris Packham <judge.packham@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHDw-0002o2-BX
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbaCETKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:10:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbaCETKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:10:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 490C07022D;
	Wed,  5 Mar 2014 14:10:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z2Fya5eEUBUOx89crgi5sVplnow=; b=s2Crut
	LdgzI6b4lMDhEgO71WQoyn7BiNmoYbsbx/5DSVtvgxbFY1BFG+06XE6/mk4rgf6U
	Enn/jYM4S+nz4ZGYLz0D4hS/q6B7A6HCXnf52c7n55s8qdcJ6I3jlVYgJSUBjCWB
	v9na/zxhUSrQc7AJkJEvHZQQdEtDxuS/ZZg1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sieUuf2D7RkHo4xiYGl8jE9wX00Nmm7y
	MLKK/dNQZjRu/AWHU520UwzLNijYrJq282X70go6V5jMFnOT3mqrLW26OqWP6xb9
	2PNqAQ5GL7dv1MXF4oM56TThMDe954oUqjmni3sPN1X+aT/HckqP8p6aN5VavbSe
	bUkK3oxDuZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3662470229;
	Wed,  5 Mar 2014 14:10:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E3FF70225;
	Wed,  5 Mar 2014 14:10:49 -0500 (EST)
In-Reply-To: <20140305171334.GA31252@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Mar 2014 12:13:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DCEB3CD2-A499-11E3-8652-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243467>

Jeff King <peff@peff.net> writes:

> But I have not thought hard about it, so maybe there is a good reason
> not to (it is a little weird just because the resulting index is a
> partial application of the patch).

Originally ".rej" was a deliberate attempt to be "not very Git but
more like 'patch'", so I wouldn't be surprised if the combination
between "--reject" and "--index" did not work, in the sense that we
did not add such a partial change to the index.

I do not offhand think of a reason to forbid the combination,
though, as long as we make sure that "git apply --index --reject"
still exits with failure to prevent a partial application to be
auto-committed.
