From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Wed, 07 Aug 2013 23:39:54 -0700
Message-ID: <7vli4cbs91.fsf@alter.siamese.dyndns.org>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
	<7vsizkpv21.fsf@alter.siamese.dyndns.org>
	<20130712071157.GL10217@login.drsnuggles.stderr.nl>
	<20130807102716.GA10217@login.drsnuggles.stderr.nl>
	<7v61vhc7wn.fsf@alter.siamese.dyndns.org>
	<CACsJy8AUrrMuW9TgT=gCfFVNq8H0zNjCsZwBY_0Ty-tdEgUYyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 08:40:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7JtF-0007RY-34
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 08:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272Ab3HHGj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 02:39:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948Ab3HHGj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 02:39:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7D623277B;
	Thu,  8 Aug 2013 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QDH0G5BTwrP3IIi4iuvHVJtcoq8=; b=Li5FQp
	tJzFBZFXRukVabYDF3QJZiim0Ahg1z8+YeXg06ph/UAEaRbpQvfYl6rwyCFhBh1r
	m9YkpQA4ZghpNkBQyrYp9LaAJG0nEdLuPFpBr53spMP+qetFbdlgCA/03yUJrO5l
	nR5pa/id643kk5/l6sjOeSK5Z1wk7GggFPIc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GjXZRzCd3iPvII4+xIyV+gSuzRy1MBuz
	CQqMNmCGFEpJ89pXks6BxhuWJVljJIIDLZVi6FZK0HXSeJ7PQl+ETsX8b/wDqxbW
	ChQEKJELQhss+XJvx78tUCiFHlgaPyRZ3GMt/yg7ZOsWoxQscS3ZdFW7znOOj0GH
	xqlu8jsUu9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBA7A3277A;
	Thu,  8 Aug 2013 06:39:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC2BD32776;
	Thu,  8 Aug 2013 06:39:55 +0000 (UTC)
In-Reply-To: <CACsJy8AUrrMuW9TgT=gCfFVNq8H0zNjCsZwBY_0Ty-tdEgUYyQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 8 Aug 2013 08:09:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 568996AA-FFF5-11E2-A4D8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231864>

Duy Nguyen <pclouds@gmail.com> writes:

> Haven't found time to read the rest yet, but this I can answer.
> .git/shallow records graft points. If a commit is in .git/shallow and
> it exists in the repository, the commit is considered to have no
> parents regardless of what's recorded in repository. So .git/shallow
> refers to the new roots, not the missing bits.

Thanks.
