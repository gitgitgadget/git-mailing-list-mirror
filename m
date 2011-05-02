From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add default merge options for all branches
Date: Mon, 02 May 2011 11:23:07 -0700
Message-ID: <7vhb9dm06s.fsf@alter.siamese.dyndns.org>
References: <4DBED99E.3050709@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vmiklos@frugalware.org, deskinm@umich.edu,
	gitster@pobox.com
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGxmJ-0001CW-7D
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 20:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882Ab1EBSXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 14:23:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab1EBSXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 14:23:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 261EE5BF5;
	Mon,  2 May 2011 14:25:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AoQ1elGmV+yQSs4zM9qHbQ/MOVc=; b=e29VCi
	qdn4faOPvm6fg/nATl3RXwoh8/hKpGk9jSTViZvfq4D0EHKwBk7tkqYIDBoiDXOa
	1p5DTA4gH1aWQ3H9d3aCy/YvLR8HJyZ3/m0XKhat24K7m3cAKFJqLlrNv6xzmzng
	0TfK3dVEsmALpq65SblYrZj8rBragd3VgZhZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sXlbHDRwcMg0AmIYsqFJrKnKpxtjEAgm
	8KN6i366OlPCoECtGUaCWkWq3Xr+6iLPbPfq3uyEOJSgUrAHmeu4YXUOW9T0LBLJ
	8aJSeqFBcr3gfnyujWq1LaozIrwZMTrcBZfDoYIq0b/7Ed63Sc/J3D95rAhi1A3U
	YoRNrqg5hOU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D994E5BF2;
	Mon,  2 May 2011 14:25:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 262B75BEF; Mon,  2 May 2011
 14:25:12 -0400 (EDT)
In-Reply-To: <4DBED99E.3050709@dailyvoid.com> (Michael Grubb's message of
 "Mon, 02 May 2011 11:19:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8922190A-74E9-11E0-B644-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172613>

Michael Grubb <devel@dailyvoid.com> writes:

> The approach taken is to make note of whether a branch specific
> mergeoptions key has been seen and only apply the global value if it
> hasn't. An alternative method would be to keep the
> branch.<branch>.mergeoptions semantics, but assign a special value for
> <branch> to be the global default.

Both my gut feeling and design taste tell me that "branch.*.mergeoptions"
(using literal '*' for match-all for now) would be a lot more appropriate
here.  We could extend the '*' part later to take globs.

The resulting part of the configuration file would look like this:

	[branch "*"]
        	mergeoptions = ...

and later we would end up supporting other kinds of defaults, like:

	[branch "ko/*"]
        	remote = korg
	[branch "github/*"]
        	remote = github
                mergeoptions = ...

I didn't read the patch carefully but there seems to be many instances of
the same "excess whitespace" pattern you should be able to avoid easily to
match the style by looking at the surrounding code.

Thanks.
