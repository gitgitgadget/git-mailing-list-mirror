From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Wed, 22 May 2013 11:07:07 -0700
Message-ID: <7v4ndukhx0.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 22 20:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfDRV-00022L-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 20:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab3EVSHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 14:07:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab3EVSHK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 14:07:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C43502046E;
	Wed, 22 May 2013 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Db67j2vs+Mgwx7oLvCQ6fW7KzNI=; b=YgUJVA
	lnoAFpMAPXQjL4hQYGYvRJHd4rAPEvc1CjDC+M2j8jKbnFfeDA7SYM0/XTyMHpXe
	tCksKrLvym+FP9UDOAVr7G+mYPuSSyAlV5LaYOjO0FBdGSz0Ys9BQYdmDEhrTy/u
	YP6brhgZSXiAR8JxbcEuekEa0m7PlWm2imwlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoKB4jqLBwOYleTimBD1+bPZwK2RrZj2
	Tvv7myqLhnGBpyQCX9rOTcMt6vPKwLfMcLpwuDl3pN2325E/TXP1VnIGo4fChA3R
	2NgLyRnWx8XHoTWDDmHMCrXz4bNDl8jXJN83oICdqjymb2wwvQ45l+tTO8HKyy+p
	g5eNIPdgM7E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7FAA2046D;
	Wed, 22 May 2013 18:07:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FA982046C;
	Wed, 22 May 2013 18:07:09 +0000 (UTC)
In-Reply-To: <20130522115042.GA20649@inner.h.apk.li> (Andreas Krey's message
	of "Wed, 22 May 2013 13:50:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B503378-C30A-11E2-93AB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225182>

Andreas Krey <a.krey@gmx.de> writes:

> A short trial showed that representing first parent chains as
> straight lines in the graph does actually improve understandability,
> as feature branches clearly stand out as separate lines even when
> they no longer carry a branch name.

If you have a four-commit segment in your commit ancestry graph
(time flows from left to right; turn your head 90-degrees to the
right if you want a gitk representation):

    ---A--X
        \/
        /\
    ---B--Y

where X and Y are both merges between A and B, having A as their
first parent, how would you express such a graph with first-parent
chain going a straight line?

> Also, there is an implication with 'git pull': You'd expect the
> master branch to be a first parent line, but when I do a small
> thing directly on master and need to pull before pushing back,
> then origin/master is merged into my branch, and thus my side
> branch becomes the first parent line.

Don't do that, then.
