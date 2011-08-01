From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Sun, 31 Jul 2011 18:16:52 -0700
Message-ID: <7vpqkqj5h7.fsf@alter.siamese.dyndns.org>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com>
 <1311790250-32454-4-git-send-email-iveqy@iveqy.com>
 <7vy5zikw6e.fsf@alter.siamese.dyndns.org> <4E3315E6.8060501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Aug 01 03:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnh7t-000404-Ez
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 03:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab1HABQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 21:16:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab1HABQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 21:16:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DDF495B;
	Sun, 31 Jul 2011 21:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZtSgh64jaVqiebaV0GHnZYEYeo=; b=oGxMnn
	kW3Rszjonw9BtFKG7WvvM6y0CKUs5CpNMYbALCjdKgLj5nP9x5Px2FVI8C2ZIAQw
	FDSUmGz8yXIeobWeMegZIZYQqP8QF5U0YvH1TqqetIjQBbQapcqUZQIvu4KQ6CP+
	Hjj5b4pZCz8Nd/rT/V4BPaSuKJYHh8ijZ7Uho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yt9OQo0YXpIaaBuwoORI4386e3iTFwlE
	9ZO26+QyQOASK6Xi/iIS+RHQBtcurPliQqtfDnociVzHQpkTnJ1TttNGJHbfL/sh
	jQCbA2X53QU8CCHdV4C3i1cKxIhqlt8PSM6r7/BAFkNsWtzqQvozSkC8AExxitVV
	x9XotEarM8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC75495A;
	Sun, 31 Jul 2011 21:16:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44F094959; Sun, 31 Jul 2011
 21:16:54 -0400 (EDT)
In-Reply-To: <4E3315E6.8060501@web.de> (Jens Lehmann's message of "Fri, 29
 Jul 2011 22:19:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F15FCB50-BBDB-11E0-A01D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178292>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> We will skip the check for submodules without remotes, does that lessen
> your annoyance? We still think it is a good idea to have that test enabled
> by default, but it might be a good idea to wait with that until we provide
> a central config option to enable users to turn that off with a simple
> "git config push.recurseSubmodules off". What do you think?

I would rather see a questionable (in the sense that it can trigger false
positive and annoy users of workflows you didn't anticipate) new feature
turned off by default, so that interested people who _do_ want to can use
it knowing what they are getting into, to find out as much unexpected
fallout as possible. So if we want to give this topic early graduation, I
would suggest making it a command line option that defaults to off first,
then in a later commit add a configuration option to enable people to turn
it on (and allow those who do not see the point of the new feature to keep
it turned off permanently). Enabling the feature by default can be done
in a later version after the feature proves to be truly useful for people
who opted into the experiment.
